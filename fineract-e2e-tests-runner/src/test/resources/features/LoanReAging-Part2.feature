@LoanReAgingFeature
Feature: LoanReAging - Part2

  @TestRailId:C4079 @AdvancedPaymentAllocation
  Scenario: Verify Loan re-aging transaction at 1st installment - before maturity date and removes additional installments - UC12
    When Admin sets the business date to "20250101"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                        | submitted on date | with Principal | ANNUAL interest rate % | interest type | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_DOWNPAYMENT_ADV_PMT_ALLOC_PROGRESSIVE_LOAN_SCHEDULE_HORIZONTAL | 20250101   | 1000           | 0                      | FLAT          | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 6                 | MONTHS                | 1              | MONTHS                 | 6                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20250101" with "1000" amount and expected disbursement date on "20250101"
    When Admin successfully disburse the loan on "20250101" with "1000" EUR transaction amount
    Then Loan Repayment schedule has 7 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20250101  |           | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 0    | 20250101  |           | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0  | 0.0        | 0.0  | 250.0       |
      | 2  | 31   | 20250201 |           | 625.0           | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 0.0  | 0.0        | 0.0  | 125.0       |
      | 3  | 28   | 20250301    |           | 500.0           | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 0.0  | 0.0        | 0.0  | 125.0       |
      | 4  | 31   | 20250401    |           | 375.0           | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 0.0  | 0.0        | 0.0  | 125.0       |
      | 5  | 30   | 20250501      |           | 250.0           | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 0.0  | 0.0        | 0.0  | 125.0       |
      | 6  | 31   | 20250601     |           | 125.0           | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 0.0  | 0.0        | 0.0  | 125.0       |
      | 7  | 30   | 20250701     |           | 0.0             | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 0.0  | 0.0        | 0.0  | 125.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 1000.0        | 0.0      | 0.0  | 0.0       | 1000.0 | 0.0   | 0.0        | 0.0  | 1000.0      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type  | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20250101  | Disbursement      | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       | false    |
# --- re-age loan on 1st installment ---#
    When Admin sets the business date to "20250102"
    When Admin creates a Loan re-aging transaction by Loan external ID with the following data:
      | frequencyNumber | frequencyType | startDate        | numberOfInstallments |
      | 1               | MONTHS        | 20250102  | 3                    |
    Then Loan Repayment schedule has 5 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      |    |      | 20250101   |                 | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      | 1  |  0   | 20250101   | 20250102 | 1000.0          |   0.0         | 0.0      | 0.0  | 0.0       | 0.0    | 0.0  | 0.0        | 0.0  |   0.0       |
      | 2  |  1   | 20250102   | 20250102 | 1000.0          |   0.0         | 0.0      | 0.0  | 0.0       | 0.0    | 0.0  | 0.0        | 0.0  |   0.0       |
      | 3  |  0   | 20250102   |                 | 666.67          | 333.33        | 0.0      | 0.0  | 0.0       | 333.33 | 0.0  | 0.0        | 0.0  | 333.33      |
      | 4  | 31   | 20250202  |                 | 333.34          | 333.33        | 0.0      | 0.0  | 0.0       | 333.33 | 0.0  | 0.0        | 0.0  | 333.33      |
      | 5  | 28   | 20250302     |                 |   0.0           | 333.34        | 0.0      | 0.0  | 0.0       | 333.34 | 0.0  | 0.0        | 0.0  | 333.34      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late  | Outstanding |
      | 1000.0        | 0.0      | 0.0  | 0.0       | 1000.0 |  0.0  | 0.0        | 0.0   | 1000.0      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type  | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20250101  | Disbursement      | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       | false    |
      | 20250102  | Re-age            | 1000.0 | 1000.0    | 0.0      | 0.0  | 0.0       | 0.0          | false    |

    When Loan Pay-off is made on "20250102"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C4080 @AdvancedPaymentAllocation
  Scenario: Verify Loan re-aging transaction at 1st installment with charge - before maturity date and removes additional normal installments and not modifies n+1 - UC13
    When Admin sets the business date to "20250101"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                      | submitted on date | with Principal | ANNUAL interest rate % | interest type | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_DOWNPAYMENT_AUTO_ADVANCED_PAYMENT_ALLOCATION | 20250101   | 1000           | 0                      | FLAT          | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 6                 | MONTHS                | 1              | MONTHS                 | 6                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20250101" with "1000" amount and expected disbursement date on "20250101"
    When Admin successfully disburse the loan on "20250101" with "1000" EUR transaction amount
    When Admin adds "LOAN_NSF_FEE" due date charge with "20250101" due date and 20 EUR transaction amount
    Then Loan Repayment schedule has 7 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20250101  |                 | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 0    | 20250101  | 20250101 | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0| 0.0        | 0.0  |   0.0       |
      | 2  | 31   | 20250201 |                 | 625.0           | 125.0         | 0.0      | 0.0  | 20.0      | 145.0 | 0.0  | 0.0        | 0.0  | 145.0       |
      | 3  | 28   | 20250301    |                 | 500.0           | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 0.0  | 0.0        | 0.0  | 125.0       |
      | 4  | 31   | 20250401    |                 | 375.0           | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 0.0  | 0.0        | 0.0  | 125.0       |
      | 5  | 30   | 20250501      |                 | 250.0           | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 0.0  | 0.0        | 0.0  | 125.0       |
      | 6  | 31   | 20250601     |                 | 125.0           | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 0.0  | 0.0        | 0.0  | 125.0       |
      | 7  | 30   | 20250701     |                 | 0.0             | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 0.0  | 0.0        | 0.0  | 125.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 1000.0        | 0.0      | 0.0  | 20.0      | 1020.0 | 250.0 | 0.0        | 0.0  | 770.0       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type  | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20250101  | Disbursement      | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       | false    |
      | 20250101  | Down Payment      |  250.0 | 250.0     | 0.0      | 0.0  | 0.0       |  750.0       | false    |
    Then Loan Charges tab has the following data:
      | Name    | isPenalty | Payment due at       | Due as of       | Calculation type | Due  | Paid | Waived | Outstanding |
      | NSF fee | true      | Specified due date   | 20250101 | Flat             | 20.0 | 0.0  | 0.0    | 20.0        |
# --- re-age loan on 1st installment ---#
    When Admin sets the business date to "20250110"
    When Admin creates a Loan re-aging transaction by Loan external ID with the following data:
      | frequencyNumber | frequencyType | startDate        | numberOfInstallments |
      | 1               | MONTHS        | 20250111  | 2                    |
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20250101  |                 | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 0    | 20250101  | 20250101 | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0  | 0.0         |
      | 2  | 9    | 20250110  |                 | 750.0           | 0.0           | 0.0      | 0.0  | 20.0      | 20.0  | 0.0   | 0.0        | 0.0  | 20.0        |
      | 3  | 1    | 20250111  |                 | 375.0           | 375.0         | 0.0      | 0.0  | 0.0       | 375.0 | 0.0   | 0.0        | 0.0  | 375.0       |
      | 4  | 31   | 20250211 |                 | 0.0             | 375.0         | 0.0      | 0.0  | 0.0       | 375.0 | 0.0   | 0.0        | 0.0  | 375.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 1000.0        | 0.0      | 0.0  | 20.0      | 1020.0 | 250.0 | 0.0        | 0.0  | 770.0       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type  | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20250101  | Disbursement      | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       | false    |
      | 20250101  | Down Payment      |  250.0 | 250.0     | 0.0      | 0.0  | 0.0       |  750.0       | false    |
      | 20250110  | Re-age            |  750.0 | 750.0     | 0.0      | 0.0  | 0.0       | 0.0          | false    |
    When Loan Pay-off is made on "20250110"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C4081 @AdvancedPaymentAllocation
  Scenario: Verify that Loan re-aging transaction - can be performed before maturity date and removes n+1 - UC14
    When Admin sets the business date to "20240101"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                        | submitted on date | with Principal | ANNUAL interest rate % | interest type | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_DOWNPAYMENT_ADV_PMT_ALLOC_PROGRESSIVE_LOAN_SCHEDULE_HORIZONTAL | 20240101   | 1000           | 0                      | FLAT          | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 6                 | MONTHS                  | 1             | MONTHS                   | 6                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240101" with "1000" amount and expected disbursement date on "20240101"
    When Admin successfully disburse the loan on "20240101" with "1000" EUR transaction amount
    When Admin adds "LOAN_NSF_FEE" due date charge with "20241001" due date and 20 EUR transaction amount
    Then Loan Repayment schedule has 8 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20240101  |           | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 0    | 20240101  |           | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0  | 0.0        | 0.0  | 250.0       |
      | 2  | 31   | 20240201 |           | 625.0           | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 0.0  | 0.0        | 0.0  | 125.0       |
      | 3  | 29   | 20240301    |           | 500.0           | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 0.0  | 0.0        | 0.0  | 125.0       |
      | 4  | 31   | 20240401    |           | 375.0           | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 0.0  | 0.0        | 0.0  | 125.0       |
      | 5  | 30   | 20240501      |           | 250.0           | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 0.0  | 0.0        | 0.0  | 125.0       |
      | 6  | 31   | 20240601     |           | 125.0           | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 0.0  | 0.0        | 0.0  | 125.0       |
      | 7  | 30   | 20240701     |           | 0.0             | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 0.0  | 0.0        | 0.0  | 125.0       |
      | 8  | 92   | 20241001  |           | 0.0             |   0.0         | 0.0      | 0.0  | 20.0      | 20.0  | 0.0  | 0.0        | 0.0  | 20.0        |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 1000.0        | 0.0      | 0.0  | 20.0      | 1020.0 | 0.0   | 0.0        | 0.0  | 1020.0      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type  | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20240101  | Disbursement      | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       | false    |
    Then Loan Charges tab has the following data:
      | Name    | isPenalty | Payment due at       | Due as of       | Calculation type | Due  | Paid | Waived | Outstanding |
      | NSF fee | true      | Specified due date   | 20241001 | Flat             | 20.0 | 0.0  | 0.0    | 20.0        |
    When Admin sets the business date to "20240309"
    When Admin creates a Loan re-aging preview by Loan external ID with the following data:
      | frequencyNumber | frequencyType | startDate     | numberOfInstallments |
      | 1               | MONTHS        | 20240315 | 10                   |
    Then Loan Re-Aged Repayment schedule preview has 14 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date     | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      |    |      | 20240101  |               | 1000.0          | 0.0           | 0.0      | 0.0  | 0.0       | 0.0    | 0.0  |            |      |             |
      | 1  | 0    | 20240101  | 20240309 | 1000.0          |   0.0         | 0.0      | 0.0  | 0.0       | 0.0    | 0.0  | 0.0        | 0.0  | 0.0         |
      | 2  | 31   | 20240201 | 20240309 | 1000.0          |   0.0         | 0.0      | 0.0  | 0.0       | 0.0    | 0.0  | 0.0        | 0.0  | 0.0         |
      | 3  | 29   | 20240301    | 20240309 | 1000.0          |   0.0         | 0.0      | 0.0  | 0.0       | 0.0    | 0.0  | 0.0        | 0.0  | 0.0         |
      | 4  | 8    | 20240309    | 20240309 | 1000.0          | 0.0           | 0.0      | 0.0  | 0.0       | 0.0   | 0.0   | 0.0        | 0.0  | 0.0         |
      | 5  | 6    | 20240315    |               |  900.0          | 100.0         | 0.0      | 0.0  | 0.0       | 100.0  | 0.0  | 0.0        | 0.0  | 100.0       |
      | 6  | 31   | 20240415    |               |  800.0          | 100.0         | 0.0      | 0.0  | 0.0       | 100.0  | 0.0  | 0.0        | 0.0  | 100.0       |
      | 7  | 30   | 20240515      |               |  700.0          | 100.0         | 0.0      | 0.0  | 0.0       | 100.0  | 0.0  | 0.0        | 0.0  | 100.0       |
      | 8  | 31   | 20240615     |               |  600.0          | 100.0         | 0.0      | 0.0  | 0.0       | 100.0  | 0.0  | 0.0        | 0.0  | 100.0       |
      | 9  | 30   | 20240715     |               |  500.0          | 100.0         | 0.0      | 0.0  | 0.0       | 100.0  | 0.0  | 0.0        | 0.0  | 100.0       |
      | 10 | 31   | 20240815   |               |  400.0          | 100.0         | 0.0      | 0.0  | 0.0       | 100.0  | 0.0  | 0.0        | 0.0  | 100.0       |
      | 11 | 31   | 20240915|               |  300.0          | 100.0         | 0.0      | 0.0  | 0.0       | 100.0  | 0.0  | 0.0        | 0.0  | 100.0       |
      | 12 | 30   | 20241015  |               |  200.0          | 100.0         | 0.0      | 0.0  | 20.0      | 120.0  | 0.0  | 0.0        | 0.0  | 120.0       |
      | 13 | 31   | 20241115 |               |  100.0          | 100.0         | 0.0      | 0.0  | 0.0       | 100.0  | 0.0  | 0.0        | 0.0  | 100.0       |
      | 14 | 30   | 20241215 |               |    0.0          | 100.0         | 0.0      | 0.0  | 0.0       | 100.0  | 0.0  | 0.0        | 0.0  | 100.0       |
    Then Loan Re-Aged Repayment schedule preview has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 1000.0        | 0.0      | 0.0  | 20.0      | 1020.0 | 0.0   | 0.0        | 0.0  | 1020.0      |
    When Admin creates a Loan re-aging transaction by Loan external ID with the following data:
      | frequencyNumber | frequencyType | startDate     | numberOfInstallments |
      | 1               | MONTHS        | 20240315 | 10                   |
    Then Loan Repayment schedule has 14 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date     | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      |    |      | 20240101  |               | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      | 1  | 0    | 20240101  | 20240309 | 1000.0          |   0.0         | 0.0      | 0.0  | 0.0       | 0.0    | 0.0  | 0.0        | 0.0  | 0.0         |
      | 2  | 31   | 20240201 | 20240309 | 1000.0          |   0.0         | 0.0      | 0.0  | 0.0       | 0.0    | 0.0  | 0.0        | 0.0  | 0.0         |
      | 3  | 29   | 20240301    | 20240309 | 1000.0          |   0.0         | 0.0      | 0.0  | 0.0       | 0.0    | 0.0  | 0.0        | 0.0  | 0.0         |
      | 4  | 8    | 20240309    | 20240309 | 1000.0          | 0.0           | 0.0      | 0.0  | 0.0       | 0.0   | 0.0   | 0.0        | 0.0  | 0.0         |
      | 5  | 6    | 20240315    |               |  900.0          | 100.0         | 0.0      | 0.0  | 0.0       | 100.0  | 0.0  | 0.0        | 0.0  | 100.0       |
      | 6  | 31   | 20240415    |               |  800.0          | 100.0         | 0.0      | 0.0  | 0.0       | 100.0  | 0.0  | 0.0        | 0.0  | 100.0       |
      | 7  | 30   | 20240515      |               |  700.0          | 100.0         | 0.0      | 0.0  | 0.0       | 100.0  | 0.0  | 0.0        | 0.0  | 100.0       |
      | 8  | 31   | 20240615     |               |  600.0          | 100.0         | 0.0      | 0.0  | 0.0       | 100.0  | 0.0  | 0.0        | 0.0  | 100.0       |
      | 9  | 30   | 20240715     |               |  500.0          | 100.0         | 0.0      | 0.0  | 0.0       | 100.0  | 0.0  | 0.0        | 0.0  | 100.0       |
      | 10 | 31   | 20240815   |               |  400.0          | 100.0         | 0.0      | 0.0  | 0.0       | 100.0  | 0.0  | 0.0        | 0.0  | 100.0       |
      | 11 | 31   | 20240915|               |  300.0          | 100.0         | 0.0      | 0.0  | 0.0       | 100.0  | 0.0  | 0.0        | 0.0  | 100.0       |
      | 12 | 30   | 20241015  |               |  200.0          | 100.0         | 0.0      | 0.0  | 20.0      | 120.0  | 0.0  | 0.0        | 0.0  | 120.0       |
      | 13 | 31   | 20241115 |               |  100.0          | 100.0         | 0.0      | 0.0  | 0.0       | 100.0  | 0.0  | 0.0        | 0.0  | 100.0       |
      | 14 | 30   | 20241215 |               |    0.0          | 100.0         | 0.0      | 0.0  | 0.0       | 100.0  | 0.0  | 0.0        | 0.0  | 100.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 1000.0        | 0.0      | 0.0  | 20.0      | 1020.0 | 0.0   | 0.0        | 0.0  | 1020.0      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type  | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20240101  | Disbursement      | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       | false    |
      | 20240309    | Re-age            | 1000.0 | 1000.0    | 0.0      | 0.0  | 0.0       | 0.0          | false    |
    Then Loan Charges tab has the following data:
      | Name    | isPenalty | Payment due at       | Due as of       | Calculation type | Due  | Paid | Waived | Outstanding |
      | NSF fee | true      | Specified due date   | 20241001 | Flat             | 20.0 | 0.0  | 0.0    | 20.0        |
    When Loan Pay-off is made on "20240309"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C4082 @AdvancedPaymentAllocation
  Scenario: Verify that Loan re-aging transaction - before maturity date and removes additional normal installments and not modifies n+1 - UC15
    When Admin sets the business date to "20240101"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                        | submitted on date | with Principal | ANNUAL interest rate % | interest type | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_DOWNPAYMENT_ADV_PMT_ALLOC_PROGRESSIVE_LOAN_SCHEDULE_HORIZONTAL | 20240101   | 1000           | 0                      | FLAT          | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 6                 | MONTHS                  | 1             | MONTHS                   | 6                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240101" with "1000" amount and expected disbursement date on "20240101"
    When Admin successfully disburse the loan on "20240101" with "1000" EUR transaction amount
    When Admin adds "LOAN_NSF_FEE" due date charge with "20241001" due date and 20 EUR transaction amount
    When Admin adds "LOAN_NSF_FEE" due date charge with "20241101" due date and 30 EUR transaction amount
    Then Loan Repayment schedule has 8 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20240101  |           | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 0    | 20240101  |           | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0  | 0.0        | 0.0  | 250.0       |
      | 2  | 31   | 20240201 |           | 625.0           | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 0.0  | 0.0        | 0.0  | 125.0       |
      | 3  | 29   | 20240301    |           | 500.0           | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 0.0  | 0.0        | 0.0  | 125.0       |
      | 4  | 31   | 20240401    |           | 375.0           | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 0.0  | 0.0        | 0.0  | 125.0       |
      | 5  | 30   | 20240501      |           | 250.0           | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 0.0  | 0.0        | 0.0  | 125.0       |
      | 6  | 31   | 20240601     |           | 125.0           | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 0.0  | 0.0        | 0.0  | 125.0       |
      | 7  | 30   | 20240701     |           | 0.0             | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 0.0  | 0.0        | 0.0  | 125.0       |
      | 8  | 123  | 20241101 |           | 0.0             |   0.0         | 0.0      | 0.0  | 50.0      | 50.0  | 0.0  | 0.0        | 0.0  | 50.0        |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 1000.0        | 0.0      | 0.0  | 50.0      | 1050.0 | 0.0   | 0.0        | 0.0  | 1050.0      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type  | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20240101  | Disbursement      | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       | false    |
    Then Loan Charges tab has the following data:
      | Name    | isPenalty | Payment due at       | Due as of       | Calculation type | Due  | Paid | Waived | Outstanding |
      | NSF fee | true      | Specified due date   | 20241001 | Flat             | 20.0 | 0.0  | 0.0    | 20.0        |
      | NSF fee | true      | Specified due date   | 20241101| Flat             | 30.0 | 0.0  | 0.0    | 30.0        |
# --- add re-age transaction --- #
    When Admin sets the business date to "20240309"
    When Admin creates a Loan re-aging preview by Loan external ID with the following data:
      | frequencyNumber | frequencyType | startDate     | numberOfInstallments |
      | 1               | MONTHS        | 20240315 | 2                    |
    Then Loan Re-Aged Repayment schedule preview has 7 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date     | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      |    |      | 20240101  |               | 1000.0          | 0.0           | 0.0      | 0.0  | 0.0       | 0.0    | 0.0  |            |      |             |
      | 1  | 0    | 20240101  | 20240309 | 1000.0          |   0.0         | 0.0      | 0.0  | 0.0       | 0.0    | 0.0  | 0.0        | 0.0  | 0.0         |
      | 2  | 31   | 20240201 | 20240309 | 1000.0          |   0.0         | 0.0      | 0.0  | 0.0       | 0.0    | 0.0  | 0.0        | 0.0  | 0.0         |
      | 3  | 29   | 20240301    | 20240309 | 1000.0          |   0.0         | 0.0      | 0.0  | 0.0       | 0.0    | 0.0  | 0.0        | 0.0  | 0.0         |
      | 4  | 8    | 20240309    | 20240309 | 1000.0          | 0.0           | 0.0      | 0.0  | 0.0       | 0.0   | 0.0   | 0.0        | 0.0  | 0.0         |
      | 5  | 6    | 20240315    |               |  500.0          | 500.0         | 0.0      | 0.0  | 0.0       | 500.0  | 0.0  | 0.0        | 0.0  | 500.0       |
      | 6  | 31   | 20240415    |               |    0.0          | 500.0         | 0.0      | 0.0  | 0.0       | 500.0  | 0.0  | 0.0        | 0.0  | 500.0       |
      | 7  | 200  | 20241101 |               |    0.0          |   0.0         | 0.0      | 0.0  | 50.0      |  50.0  | 0.0  | 0.0        | 0.0  |  50.0       |
    Then Loan Re-Aged Repayment schedule preview has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 1000.0        | 0.0      | 0.0  | 50.0      | 1050.0 | 0.0   | 0.0        | 0.0  | 1050.0      |
# -- add re-age transaction --- #
    When Admin creates a Loan re-aging transaction by Loan external ID with the following data:
      | frequencyNumber | frequencyType | startDate     | numberOfInstallments |
      | 1               | MONTHS        | 20240315 | 2                    |
    Then Loan Repayment schedule has 7 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date     | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      |    |      | 20240101  |               | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      | 1  | 0    | 20240101  | 20240309 | 1000.0          |   0.0         | 0.0      | 0.0  | 0.0       | 0.0    | 0.0  | 0.0        | 0.0  | 0.0         |
      | 2  | 31   | 20240201 | 20240309 | 1000.0          |   0.0         | 0.0      | 0.0  | 0.0       | 0.0    | 0.0  | 0.0        | 0.0  | 0.0         |
      | 3  | 29   | 20240301    | 20240309 | 1000.0          |   0.0         | 0.0      | 0.0  | 0.0       | 0.0    | 0.0  | 0.0        | 0.0  | 0.0         |
      | 4  | 8    | 20240309    | 20240309 | 1000.0          | 0.0           | 0.0      | 0.0  | 0.0       | 0.0   | 0.0   | 0.0        | 0.0  | 0.0         |
      | 5  | 6    | 20240315    |               |  500.0          | 500.0         | 0.0      | 0.0  | 0.0       | 500.0  | 0.0  | 0.0        | 0.0  | 500.0       |
      | 6  | 31   | 20240415    |               |    0.0          | 500.0         | 0.0      | 0.0  | 0.0       | 500.0  | 0.0  | 0.0        | 0.0  | 500.0       |
      | 7  | 200  | 20241101 |               |    0.0          |   0.0         | 0.0      | 0.0  | 50.0      |  50.0  | 0.0  | 0.0        | 0.0  |  50.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 1000.0        | 0.0      | 0.0  | 50.0      | 1050.0 | 0.0   | 0.0        | 0.0  | 1050.0      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type  | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20240101  | Disbursement      | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       | false    |
      | 20240309    | Re-age            | 1000.0 | 1000.0    | 0.0      | 0.0  | 0.0       | 0.0          | false    |
    Then Loan Charges tab has the following data:
      | Name    | isPenalty | Payment due at       | Due as of        | Calculation type | Due  | Paid | Waived | Outstanding |
      | NSF fee | true      | Specified due date   | 20241001  | Flat             | 20.0 | 0.0  | 0.0    | 20.0        |
      | NSF fee | true      | Specified due date   | 20241101 | Flat             | 30.0 | 0.0  | 0.0    | 30.0        |
    Then LoanReAgeTransactionBusinessEvent has changedTerms "true"
    When Loan Pay-off is made on "20240309"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C4136 @AdvancedPaymentAllocation
  Scenario: Verify that Loan re-aging with zero outstanding balance is rejected in real-time - UC1
    When Admin sets the business date to "20240101"
    When Admin creates a client with random data
    When Admin set "LP2_DOWNPAYMENT_AUTO_ADVANCED_PAYMENT_ALLOCATION" loan product "DEFAULT" transaction type to "NEXT_INSTALLMENT" future installment allocation rule
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                      | submitted on date | with Principal | ANNUAL interest rate % | interest type | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_DOWNPAYMENT_AUTO_ADVANCED_PAYMENT_ALLOCATION | 20240101   | 1000           | 0                      | FLAT          | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 45                | DAYS                  | 15             | DAYS                   | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240101" with "1000" amount and expected disbursement date on "20240101"
    When Admin successfully disburse the loan on "20240101" with "1000" EUR transaction amount
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101  |                 | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 0    | 20240101  | 20240101 | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0  | 0.0         |
      | 2  | 15   | 20240116  |                 | 500.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0   | 0.0        | 0.0  | 250.0       |
      | 3  | 15   | 20240131  |                 | 250.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0   | 0.0        | 0.0  | 250.0       |
      | 4  | 15   | 20240215 |                 | 0.0             | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0   | 0.0        | 0.0  | 250.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 1000.0        | 0.0      | 0.0  | 0.0       | 1000.0 | 250.0 | 0.0        | 0.0  | 750.0       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20240101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       | false    |
      | 20240101  | Down Payment     | 250.0  | 250.0     | 0.0      | 0.0  | 0.0       | 750.0        | false    |
    When Admin sets the business date to "20240220"
    And Customer makes "AUTOPAY" repayment on "20240220" with 750 EUR transaction amount
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late  | Outstanding |
      |    |      | 20240101  |                  | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |       |             |
      | 1  | 0    | 20240101  | 20240101  | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0   | 0.0         |
      | 2  | 15   | 20240116  | 20240220 | 500.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 250.0 | 0.0         |
      | 3  | 15   | 20240131  | 20240220 | 250.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 250.0 | 0.0         |
      | 4  | 15   | 20240215 | 20240220 | 0.0             | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 250.0 | 0.0         |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late  | Outstanding |
      | 1000.0        | 0.0      | 0.0  | 0.0       | 1000.0 | 1000.0 | 0.0        | 750.0 | 0.0         |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20240101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       | false    |
      | 20240101  | Down Payment     | 250.0  | 250.0     | 0.0      | 0.0  | 0.0       | 750.0        | false    |
      | 20240220 | Repayment        | 750.0  | 750.0     | 0.0      | 0.0  | 0.0       | 0.0          | false    |
    And Admin adds "LOAN_NSF_FEE" due date charge with "20240301" due date and 10 EUR transaction amount
    Then Loan Repayment schedule has 5 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late  | Outstanding |
      |    |      | 20240101  |                  | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |       |             |
      | 1  | 0    | 20240101  | 20240101  | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0   | 0.0         |
      | 2  | 15   | 20240116  | 20240220 | 500.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 250.0 | 0.0         |
      | 3  | 15   | 20240131  | 20240220 | 250.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 250.0 | 0.0         |
      | 4  | 15   | 20240215 | 20240220 | 0.0             | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 250.0 | 0.0         |
      | 5  | 15   | 20240301    |                  | 0.0             | 0.0           | 0.0      | 0.0  | 10.0      | 10.0  | 0.0   | 0.0        | 0.0   | 10.0        |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late  | Outstanding |
      | 1000.0        | 0.0      | 0.0  | 10.0      | 1010.0 | 1000.0 | 0.0        | 750.0 | 10.0        |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20240101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       | false    |
      | 20240101  | Down Payment     | 250.0  | 250.0     | 0.0      | 0.0  | 0.0       | 750.0        | false    |
      | 20240220 | Repayment        | 750.0  | 750.0     | 0.0      | 0.0  | 0.0       | 0.0          | false    |
    When Admin fails to create a Loan re-aging transaction with status code 403 error "error.msg.loan.reage.no.outstanding.balance.to.reage" and with the following data:
      | frequencyNumber | frequencyType | startDate     | numberOfInstallments |
      | 1               | MONTHS        | 20240301 | 3                    |
    Then Loan Repayment schedule has 5 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late  | Outstanding |
      |    |      | 20240101  |                  | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |       |             |
      | 1  | 0    | 20240101  | 20240101  | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0   | 0.0         |
      | 2  | 15   | 20240116  | 20240220 | 500.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 250.0 | 0.0         |
      | 3  | 15   | 20240131  | 20240220 | 250.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 250.0 | 0.0         |
      | 4  | 15   | 20240215 | 20240220 | 0.0             | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 250.0 | 0.0         |
      | 5  | 15   | 20240301    |                  | 0.0             | 0.0           | 0.0      | 0.0  | 10.0      | 10.0  | 0.0   | 0.0        | 0.0   | 10.0        |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late  | Outstanding |
      | 1000.0        | 0.0      | 0.0  | 10.0      | 1010.0 | 1000.0 | 0.0        | 750.0 | 10.0        |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20240101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       | false    |
      | 20240101  | Down Payment     | 250.0  | 250.0     | 0.0      | 0.0  | 0.0       | 750.0        | false    |
      | 20240220 | Repayment        | 750.0  | 750.0     | 0.0      | 0.0  | 0.0       | 0.0          | false    |
    Then Loan Charges tab has the following data:
      | Name    | isPenalty | Payment due at     | Due as of     | Calculation type | Due  | Paid | Waived | Outstanding |
      | NSF fee | true      | Specified due date | 20240301 | Flat             | 10.0 | 0.0  | 0.0    | 10.0        |

    When Loan Pay-off is made on "20240220"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C4137 @AdvancedPaymentAllocation
  Scenario: Verify that zero amount reage transaction is reverted during reverse-replay with backdated repayment that fully paid loan - UC2
    When Admin sets the business date to "20240101"
    When Admin creates a client with random data
    When Admin set "LP2_DOWNPAYMENT_AUTO_ADVANCED_PAYMENT_ALLOCATION" loan product "DEFAULT" transaction type to "NEXT_INSTALLMENT" future installment allocation rule
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                      | submitted on date | with Principal | ANNUAL interest rate % | interest type | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_DOWNPAYMENT_AUTO_ADVANCED_PAYMENT_ALLOCATION | 20240101   | 1000           | 0                      | FLAT          | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 45                | DAYS                  | 15             | DAYS                   | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240101" with "1000" amount and expected disbursement date on "20240101"
    When Admin successfully disburse the loan on "20240101" with "1000" EUR transaction amount
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101  |                 | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 0    | 20240101  | 20240101 | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0  | 0.0         |
      | 2  | 15   | 20240116  |                 | 500.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0   | 0.0        | 0.0  | 250.0       |
      | 3  | 15   | 20240131  |                 | 250.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0   | 0.0        | 0.0  | 250.0       |
      | 4  | 15   | 20240215 |                 | 0.0             | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0   | 0.0        | 0.0  | 250.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 1000.0        | 0.0      | 0.0  | 0.0       | 1000.0 | 250.0 | 0.0        | 0.0  | 750.0       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20240101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       | false    |
      | 20240101  | Down Payment     | 250.0  | 250.0     | 0.0      | 0.0  | 0.0       | 750.0        | false    |
    When Admin sets the business date to "20240220"
    When Admin creates a Loan re-aging transaction with the following data:
      | frequencyNumber | frequencyType | startDate     | numberOfInstallments |
      | 1               | MONTHS        | 20240301 | 3                    |
    Then Loan Repayment schedule has 7 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101  |                  | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 0    | 20240101  | 20240101  | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0  | 0.0         |
      | 2  | 15   | 20240116  | 20240220 | 750.0           | 0.0           | 0.0      | 0.0  | 0.0       | 0.0   | 0.0   | 0.0        | 0.0  | 0.0         |
      | 3  | 15   | 20240131  | 20240220 | 750.0           | 0.0           | 0.0      | 0.0  | 0.0       | 0.0   | 0.0   | 0.0        | 0.0  | 0.0         |
      | 4  | 15   | 20240215 | 20240220 | 750.0           | 0.0           | 0.0      | 0.0  | 0.0       | 0.0   | 0.0   | 0.0        | 0.0  | 0.0         |
      | 5  | 15   | 20240301    |                  | 500.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0   | 0.0        | 0.0  | 250.0       |
      | 6  | 31   | 20240401    |                  | 250.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0   | 0.0        | 0.0  | 250.0       |
      | 7  | 30   | 20240501      |                  | 0.0             | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0   | 0.0        | 0.0  | 250.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 1000.0        | 0.0      | 0.0  | 0.0       | 1000.0 | 250.0 | 0.0        | 0.0  | 750.0       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20240101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       | false    |
      | 20240101  | Down Payment     | 250.0  | 250.0     | 0.0      | 0.0  | 0.0       | 750.0        | false    |
      | 20240220 | Re-age           | 750.0  | 750.0     | 0.0      | 0.0  | 0.0       | 0.0          | false    |
    When Admin sets the business date to "20240221"
    And Customer makes "AUTOPAY" repayment on "20240219" with 750 EUR transaction amount
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late  | Outstanding |
      |    |      | 20240101  |                  | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |       |             |
      | 1  | 0    | 20240101  | 20240101  | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0   | 0.0         |
      | 2  | 15   | 20240116  | 20240219 | 500.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 250.0 | 0.0         |
      | 3  | 15   | 20240131  | 20240219 | 250.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 250.0 | 0.0         |
      | 4  | 15   | 20240215 | 20240219 | 0.0             | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 250.0 | 0.0         |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late  | Outstanding |
      | 1000.0        | 0.0      | 0.0  | 0.0       | 1000.0 | 1000.0 | 0.0        | 750.0 | 0.0         |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20240101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       | false    |
      | 20240101  | Down Payment     | 250.0  | 250.0     | 0.0      | 0.0  | 0.0       | 750.0        | false    |
      | 20240219 | Repayment        | 750.0  | 750.0     | 0.0      | 0.0  | 0.0       | 0.0          | false    |

  @TestRailId:C4138 @AdvancedPaymentAllocation
  Scenario: Verify that zero amount reage transaction is reverted during reverse-replay with backdated MAR trn that fully paid loan - UC3
    When Admin sets the business date to "20240101"
    When Admin creates a client with random data
    When Admin set "LP2_DOWNPAYMENT_AUTO_ADVANCED_PAYMENT_ALLOCATION" loan product "DEFAULT" transaction type to "NEXT_INSTALLMENT" future installment allocation rule
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                      | submitted on date | with Principal | ANNUAL interest rate % | interest type | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_DOWNPAYMENT_AUTO_ADVANCED_PAYMENT_ALLOCATION | 20240101   | 1000           | 0                      | FLAT          | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 45                | DAYS                  | 15             | DAYS                   | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240101" with "1000" amount and expected disbursement date on "20240101"
    When Admin successfully disburse the loan on "20240101" with "1000" EUR transaction amount
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101  |                 | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 0    | 20240101  | 20240101 | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0  | 0.0         |
      | 2  | 15   | 20240116  |                 | 500.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0   | 0.0        | 0.0  | 250.0       |
      | 3  | 15   | 20240131  |                 | 250.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0   | 0.0        | 0.0  | 250.0       |
      | 4  | 15   | 20240215 |                 | 0.0             | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0   | 0.0        | 0.0  | 250.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 1000.0        | 0.0      | 0.0  | 0.0       | 1000.0 | 250.0 | 0.0        | 0.0  | 750.0       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20240101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       | false    |
      | 20240101  | Down Payment     | 250.0  | 250.0     | 0.0      | 0.0  | 0.0       | 750.0        | false    |
    When Admin sets the business date to "20240220"
    When Admin creates a Loan re-aging transaction with the following data:
      | frequencyNumber | frequencyType | startDate     | numberOfInstallments |
      | 1               | MONTHS        | 20240301 | 3                    |
    Then Loan Repayment schedule has 7 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101  |                  | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 0    | 20240101  | 20240101  | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0  | 0.0         |
      | 2  | 15   | 20240116  | 20240220 | 750.0           | 0.0           | 0.0      | 0.0  | 0.0       | 0.0   | 0.0   | 0.0        | 0.0  | 0.0         |
      | 3  | 15   | 20240131  | 20240220 | 750.0           | 0.0           | 0.0      | 0.0  | 0.0       | 0.0   | 0.0   | 0.0        | 0.0  | 0.0         |
      | 4  | 15   | 20240215 | 20240220 | 750.0           | 0.0           | 0.0      | 0.0  | 0.0       | 0.0   | 0.0   | 0.0        | 0.0  | 0.0         |
      | 5  | 15   | 20240301    |                  | 500.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0   | 0.0        | 0.0  | 250.0       |
      | 6  | 31   | 20240401    |                  | 250.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0   | 0.0        | 0.0  | 250.0       |
      | 7  | 30   | 20240501      |                  | 0.0             | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0   | 0.0        | 0.0  | 250.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 1000.0        | 0.0      | 0.0  | 0.0       | 1000.0 | 250.0 | 0.0        | 0.0  | 750.0       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20240101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       | false    |
      | 20240101  | Down Payment     | 250.0  | 250.0     | 0.0      | 0.0  | 0.0       | 750.0        | false    |
      | 20240220 | Re-age           | 750.0  | 750.0     | 0.0      | 0.0  | 0.0       | 0.0          | false    |
    When Admin sets the business date to "20240221"
    And Customer makes "MERCHANT_ISSUED_REFUND" transaction with "AUTOPAY" payment type on "20240219" with 750 EUR transaction amount and system-generated Idempotency key
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late  | Outstanding |
      |    |      | 20240101  |                  | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |       |             |
      | 1  | 0    | 20240101  | 20240101  | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0   | 0.0         |
      | 2  | 15   | 20240116  | 20240219 | 500.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 250.0 | 0.0         |
      | 3  | 15   | 20240131  | 20240219 | 250.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 250.0 | 0.0         |
      | 4  | 15   | 20240215 | 20240219 | 0.0             | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 250.0 | 0.0         |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late  | Outstanding |
      | 1000.0        | 0.0      | 0.0  | 0.0       | 1000.0 | 1000.0 | 0.0        | 750.0 | 0.0         |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type       | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20240101  | Disbursement           | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       | false    |
      | 20240101  | Down Payment           | 250.0  | 250.0     | 0.0      | 0.0  | 0.0       | 750.0        | false    |
      | 20240219 | Merchant Issued Refund | 750.0  | 750.0     | 0.0      | 0.0  | 0.0       | 0.0          | false    |

  @TestRailId:C4139 @AdvancedPaymentAllocation
  Scenario: Verify that zero amount reage transaction is reverted during reverse-replay with backdated repayment that overpaid loan - UC4
    When Admin sets the business date to "20240101"
    When Admin creates a client with random data
    When Admin set "LP2_DOWNPAYMENT_AUTO_ADVANCED_PAYMENT_ALLOCATION" loan product "DEFAULT" transaction type to "NEXT_INSTALLMENT" future installment allocation rule
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                      | submitted on date | with Principal | ANNUAL interest rate % | interest type | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_DOWNPAYMENT_AUTO_ADVANCED_PAYMENT_ALLOCATION | 20240101   | 1000           | 0                      | FLAT          | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 45                | DAYS                  | 15             | DAYS                   | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240101" with "1000" amount and expected disbursement date on "20240101"
    When Admin successfully disburse the loan on "20240101" with "1000" EUR transaction amount
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101  |                 | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 0    | 20240101  | 20240101 | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0  | 0.0         |
      | 2  | 15   | 20240116  |                 | 500.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0   | 0.0        | 0.0  | 250.0       |
      | 3  | 15   | 20240131  |                 | 250.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0   | 0.0        | 0.0  | 250.0       |
      | 4  | 15   | 20240215 |                 | 0.0             | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0   | 0.0        | 0.0  | 250.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 1000.0        | 0.0      | 0.0  | 0.0       | 1000.0 | 250.0 | 0.0        | 0.0  | 750.0       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20240101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       | false    |
      | 20240101  | Down Payment     | 250.0  | 250.0     | 0.0      | 0.0  | 0.0       | 750.0        | false    |
    When Admin sets the business date to "20240220"
    When Admin creates a Loan re-aging transaction with the following data:
      | frequencyNumber | frequencyType | startDate     | numberOfInstallments |
      | 1               | MONTHS        | 20240301 | 3                    |
    Then Loan Repayment schedule has 7 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101  |                  | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 0    | 20240101  | 20240101  | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0  | 0.0         |
      | 2  | 15   | 20240116  | 20240220 | 750.0           | 0.0           | 0.0      | 0.0  | 0.0       | 0.0   | 0.0   | 0.0        | 0.0  | 0.0         |
      | 3  | 15   | 20240131  | 20240220 | 750.0           | 0.0           | 0.0      | 0.0  | 0.0       | 0.0   | 0.0   | 0.0        | 0.0  | 0.0         |
      | 4  | 15   | 20240215 | 20240220 | 750.0           | 0.0           | 0.0      | 0.0  | 0.0       | 0.0   | 0.0   | 0.0        | 0.0  | 0.0         |
      | 5  | 15   | 20240301    |                  | 500.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0   | 0.0        | 0.0  | 250.0       |
      | 6  | 31   | 20240401    |                  | 250.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0   | 0.0        | 0.0  | 250.0       |
      | 7  | 30   | 20240501      |                  | 0.0             | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0   | 0.0        | 0.0  | 250.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 1000.0        | 0.0      | 0.0  | 0.0       | 1000.0 | 250.0 | 0.0        | 0.0  | 750.0       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20240101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       | false    |
      | 20240101  | Down Payment     | 250.0  | 250.0     | 0.0      | 0.0  | 0.0       | 750.0        | false    |
      | 20240220 | Re-age           | 750.0  | 750.0     | 0.0      | 0.0  | 0.0       | 0.0          | false    |
    When Admin sets the business date to "20240221"
    And Customer makes "AUTOPAY" repayment on "20240219" with 800 EUR transaction amount
    Then Loan status will be "OVERPAID"
    And Loan has 50 overpaid amount
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late  | Outstanding |
      |    |      | 20240101  |                  | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |       |             |
      | 1  | 0    | 20240101  | 20240101  | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0   | 0.0         |
      | 2  | 15   | 20240116  | 20240219 | 500.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 250.0 | 0.0         |
      | 3  | 15   | 20240131  | 20240219 | 250.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 250.0 | 0.0         |
      | 4  | 15   | 20240215 | 20240219 | 0.0             | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 250.0 | 0.0         |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late  | Outstanding |
      | 1000.0        | 0.0      | 0.0  | 0.0       | 1000.0 | 1000.0 | 0.0        | 750.0 | 0.0         |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20240101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       | false    |
      | 20240101  | Down Payment     | 250.0  | 250.0     | 0.0      | 0.0  | 0.0       | 750.0        | false    |
      | 20240219 | Repayment        | 800.0  | 750.0     | 0.0      | 0.0  | 0.0       | 0.0          | false    |

    When Admin makes Credit Balance Refund transaction on "20240221" with 50 EUR transaction amount
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C4075 @AdvancedPaymentAllocation
  Scenario: Verify allowing Re-aging on interest bearing loan - Interest calculation: Default Behavior - Interest Split scenario - UC1
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
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240201 | Repayment        | 17.01  | 16.43     | 0.58     | 0.0  | 0.0       | 83.57        | false    | false    |
      | 20240315    | Re-age           | 84.28  | 83.57     | 0.71     | 0.0  | 0.0       | 0.0          | false    | false    |

    When Loan Pay-off is made on "20240315"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C4076 @AdvancedPaymentAllocation
  Scenario: Verify allowing Re-aging on interest bearing loan - Interest calculation: Default Behavior - Fees and Interest Split before re-aging - UC2
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
    And Loan Charges tab has the following data:
      | Name       | isPenalty | Payment due at     | Due as of        | Calculation type | Due  | Paid | Waived | Outstanding |
      | Snooze fee | false     | Specified due date | 20240215 | Flat             | 10.0 | 0.0  | 0.0    | 10.0        |
    When Admin sets the business date to "20240315"
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
      | 20240315    | Re-age           | 84.28  | 83.57     | 0.71     | 0.0  | 0.0       | 0.0          | false    | false    |
    And Loan Charges tab has the following data:
      | Name       | isPenalty | Payment due at     | Due as of        | Calculation type | Due  | Paid | Waived | Outstanding |
      | Snooze fee | false     | Specified due date | 20240215 | Flat             | 10.0 | 0.0  | 0.0    | 10.0        |

    When Admin sets the business date to "20240401"
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
      | 20240315    | Re-age           | 84.28  | 83.57     | 0.71     | 0.0  | 0.0       | 0.0          | true     | false    |
    And Loan Charges tab has the following data:
      | Name       | isPenalty | Payment due at     | Due as of        | Calculation type | Due  | Paid | Waived | Outstanding |
      | Snooze fee | false     | Specified due date | 20240215 | Flat             | 10.0 | 0.0  | 0.0    | 10.0        |

    When Loan Pay-off is made on "20240401"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C4125 @AdvancedPaymentAllocation
  Scenario: Verify allowing Re-aging on interest bearing loan - Interest calculation: Default Behavior - Fees and Interest Split before re-aging - fees paid - UC2.1
    When Admin sets the business date to "20240101"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                 | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_EMI_360_30_INTEREST_RECALC_DAILY_MULTIDISBURSE | 20240101   | 100            | 7                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 6                 | MONTHS                | 1              | MONTHS                 | 6                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
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
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    |
      | 20240201 | Repayment        | 17.01  | 16.43     | 0.58     | 0.0  | 0.0       | 83.57        | false    |
    And Loan Charges tab has the following data:
      | Name       | isPenalty | Payment due at     | Due as of        | Calculation type | Due  | Paid | Waived | Outstanding |
      | Snooze fee | false     | Specified due date | 20240215 | Flat             | 10.0 | 0.0  | 0.0    | 10.0        |
    When Admin sets the business date to "20240216"
    And Customer makes "AUTOPAY" repayment on "20240216" with 10.0 EUR transaction amount
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101  |                  | 100.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 31   | 20240201 | 20240201 | 83.57           | 16.43         | 0.58     | 0.0  | 0.0       | 17.01 | 17.01 | 0.0        | 0.0  | 0.0         |
      | 2  | 29   | 20240301    |                  | 67.05           | 16.52         | 0.49     | 10.0 | 0.0       | 27.01 | 10.0  | 10.0       | 0.0  | 17.01       |
      | 3  | 31   | 20240401    |                  | 50.43           | 16.62         | 0.39     | 0.0  | 0.0       | 17.01 | 0.0   | 0.0        | 0.0  | 17.01       |
      | 4  | 30   | 20240501      |                  | 33.71           | 16.72         | 0.29     | 0.0  | 0.0       | 17.01 | 0.0   | 0.0        | 0.0  | 17.01       |
      | 5  | 31   | 20240601     |                  | 16.9            | 16.81         | 0.2      | 0.0  | 0.0       | 17.01 | 0.0   | 0.0        | 0.0  | 17.01       |
      | 6  | 30   | 20240701     |                  | 0.0             | 16.9          | 0.1      | 0.0  | 0.0       | 17.0  | 0.0   | 0.0        | 0.0  | 17.0        |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 100.0         | 2.05     | 10.0 | 0.0       | 112.05 | 27.01 | 10.0       | 0.0  | 85.04       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240201 | Repayment        | 17.01  | 16.43     | 0.58     | 0.0  | 0.0       | 83.57        | false    | false    |
      | 20240216 | Repayment        | 10.0   | 0.0       | 0.0      | 10.0 | 0.0       | 83.57        | false    | false    |
    And Loan Charges tab has the following data:
      | Name       | isPenalty | Payment due at     | Due as of        | Calculation type | Due  | Paid | Waived | Outstanding |
      | Snooze fee | false     | Specified due date | 20240215 | Flat             | 10.0 | 10.0 | 0.0    | 0.0         |
    When Admin sets the business date to "20240315"
    When Admin creates a Loan re-aging transaction with the following data:
      | frequencyNumber | frequencyType | startDate    | numberOfInstallments |
      | 1               | MONTHS        | 20240401| 6                    |
    Then Loan Repayment schedule has 9 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101  |                  | 100.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 31   | 20240201 | 20240201 | 83.57           | 16.43         | 0.58     | 0.0  | 0.0       | 17.01 | 17.01 | 0.0        | 0.0  | 0.0         |
      | 2  | 29   | 20240301    | 20240315    | 83.57           | 0.0           | 0.0      | 10.0 | 0.0       | 10.0  | 10.0  | 10.0       | 0.0  | 0.0         |
      | 3  | 14   | 20240315    | 20240315    | 83.57           | 0.0           | 0.0      | 0.0  | 0.0       | 0.0   | 0.0   | 0.0        | 0.0  | 0.0         |
      | 4  | 17   | 20240401    |                  | 70.25           | 13.32         | 0.98     | 0.0  | 0.0       | 14.3  | 0.0   | 0.0        | 0.0  | 14.3        |
      | 5  | 30   | 20240501      |                  | 56.36           | 13.89         | 0.41     | 0.0  | 0.0       | 14.3  | 0.0   | 0.0        | 0.0  | 14.3        |
      | 6  | 31   | 20240601     |                  | 42.39           | 13.97         | 0.33     | 0.0  | 0.0       | 14.3  | 0.0   | 0.0        | 0.0  | 14.3        |
      | 7  | 30   | 20240701     |                  | 28.34           | 14.05         | 0.25     | 0.0  | 0.0       | 14.3  | 0.0   | 0.0        | 0.0  | 14.3        |
      | 8  | 31   | 20240801   |                  | 14.21           | 14.13         | 0.17     | 0.0  | 0.0       | 14.3  | 0.0   | 0.0        | 0.0  | 14.3        |
      | 9  | 31   | 20240901|                  | 0.0             | 14.21         | 0.08     | 0.0  | 0.0       | 14.29 | 0.0   | 0.0        | 0.0  | 14.29       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      | 100.0         | 2.8      | 10.0 | 0.0       | 112.8 | 27.01 | 10.0       | 0.0  | 85.79       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240201 | Repayment        | 17.01  | 16.43     | 0.58     | 0.0  | 0.0       | 83.57        | false    | false    |
      | 20240216 | Repayment        | 10.0   | 0.0       | 0.0      | 10.0 | 0.0       | 83.57        | false    | false    |
      | 20240315    | Re-age           | 84.28  | 83.57     | 0.71     | 0.0  | 0.0       | 0.0          | false    | false    |
    And Loan Charges tab has the following data:
      | Name       | isPenalty | Payment due at     | Due as of        | Calculation type | Due  | Paid | Waived | Outstanding |
      | Snooze fee | false     | Specified due date | 20240215 | Flat             | 10.0 | 10.0 | 0.0    | 0.0         |

    When Loan Pay-off is made on "20240315"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C4077 @AdvancedPaymentAllocation
  Scenario: Verify allowing Re-aging on interest bearing loan - Interest calculation: Default Behavior - Charge-back before re-aging - UC3
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
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    |
      | 20240201 | Repayment        | 17.01  | 16.43     | 0.58     | 0.0  | 0.0       | 83.57        | false    |
      | 20240201 | Chargeback       | 17.01  | 16.43     | 0.58     | 0.0  | 0.0       | 100.0        | false    |
    When Admin sets the business date to "20240315"
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
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240201 | Repayment        | 17.01  | 16.43     | 0.58     | 0.0  | 0.0       | 83.57        | false    | false    |
      | 20240201 | Chargeback       | 17.01  | 16.43     | 0.58     | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240315    | Re-age           | 101.42 | 100.0     | 1.42     | 0.0  | 0.0       | 0.0          | false    | false    |
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
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240201 | Repayment        | 17.01  | 16.43     | 0.58     | 0.0  | 0.0       | 83.57        | false    | false    |
      | 20240201 | Chargeback       | 17.01  | 16.43     | 0.58     | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240315    | Re-age           | 101.42 | 100.0     | 1.42     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240315    | Repayment        | 101.42 | 100.0     | 1.42     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240315    | Accrual          | 2.0    | 0.0       | 2.0      | 0.0  | 0.0       | 0.0          | false    | false    |

  @TestRailId:C4135 @AdvancedPaymentAllocation
  Scenario: Verify allowing Re-aging on interest bearing loan - Interest calculation: Default Behavior - Charge-back before re-aging and installment is partially paid - UC3.1
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
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    |
      | 20240201 | Repayment        | 17.01  | 16.43     | 0.58     | 0.0  | 0.0       | 83.57        | false    |
      | 20240201 | Chargeback       | 17.01  | 16.43     | 0.58     | 0.0  | 0.0       | 100.0        | false    |
    When Admin sets the business date to "20240301"
    And Customer makes "AUTOPAY" repayment on "20240301" with 10.0 EUR transaction amount
    When Admin sets the business date to "20240315"
    When Admin creates a Loan re-aging transaction with the following data:
      | frequencyNumber | frequencyType | startDate    | numberOfInstallments |
      | 1               | MONTHS        | 20240401| 6                    |
    Then Loan Repayment schedule has 9 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101  |                  | 100.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 31   | 20240201 | 20240201 | 83.57           | 16.43         | 0.58     | 0.0  | 0.0       | 17.01 | 17.01 | 0.0        | 0.0  | 0.0         |
      | 2  | 29   | 20240301    | 20240315    | 90.0            | 10.0          | 0.0      | 0.0  | 0.0       | 10.0  | 10.0  | 0.0        | 0.0  | 0.0         |
      | 3  | 14   | 20240315    | 20240315    | 90.0            | 0.0           | 0.0      | 0.0  | 0.0       | 0.0   | 0.0   | 0.0        | 0.0  | 0.0         |
      | 4  | 17   | 20240401    |                  | 76.18           | 13.82         | 1.69     | 0.0  | 0.0       | 15.51 | 0.0   | 0.0        | 0.0  | 15.51       |
      | 5  | 30   | 20240501      |                  | 61.11           | 15.07         | 0.44     | 0.0  | 0.0       | 15.51 | 0.0   | 0.0        | 0.0  | 15.51       |
      | 6  | 31   | 20240601     |                  | 45.96           | 15.15         | 0.36     | 0.0  | 0.0       | 15.51 | 0.0   | 0.0        | 0.0  | 15.51       |
      | 7  | 30   | 20240701     |                  | 30.72           | 15.24         | 0.27     | 0.0  | 0.0       | 15.51 | 0.0   | 0.0        | 0.0  | 15.51       |
      | 8  | 31   | 20240801   |                  | 15.39           | 15.33         | 0.18     | 0.0  | 0.0       | 15.51 | 0.0   | 0.0        | 0.0  | 15.51       |
      | 9  | 31   | 20240901|                  | 0.0             | 15.39         | 0.09     | 0.0  | 0.0       | 15.48 | 0.0   | 0.0        | 0.0  | 15.48       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 116.43        | 3.61     | 0.0  | 0.0       | 120.04 | 27.01 | 0.0        | 0.0  | 93.03       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240201 | Repayment        | 17.01  | 16.43     | 0.58     | 0.0  | 0.0       | 83.57        | false    | false    |
      | 20240201 | Chargeback       | 17.01  | 16.43     | 0.58     | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240301    | Repayment        | 10.0   | 10.0      | 0.0      | 0.0  | 0.0       | 90.0         | false    | false    |
      | 20240315    | Re-age           | 91.4   | 90.0      | 1.4      | 0.0  | 0.0       | 0.0          | false    | false    |
    When Loan Pay-off is made on "20240315"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met
    Then Loan Repayment schedule has 9 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101  |                  | 100.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 31   | 20240201 | 20240201 | 83.57           | 16.43         | 0.58     | 0.0  | 0.0       | 17.01 | 17.01 | 0.0        | 0.0  | 0.0         |
      | 2  | 29   | 20240301    | 20240315    | 90.0            | 10.0          | 0.0      | 0.0  | 0.0       | 10.0  | 10.0  | 0.0        | 0.0  | 0.0         |
      | 3  | 14   | 20240315    | 20240315    | 90.0            | 0.0           | 0.0      | 0.0  | 0.0       | 0.0   | 0.0   | 0.0        | 0.0  | 0.0         |
      | 4  | 17   | 20240401    | 20240315    | 75.89           | 14.11         | 1.4      | 0.0  | 0.0       | 15.51 | 15.51 | 15.51      | 0.0  | 0.0         |
      | 5  | 30   | 20240501      | 20240315    | 60.38           | 15.51         | 0.0      | 0.0  | 0.0       | 15.51 | 15.51 | 15.51      | 0.0  | 0.0         |
      | 6  | 31   | 20240601     | 20240315    | 44.87           | 15.51         | 0.0      | 0.0  | 0.0       | 15.51 | 15.51 | 15.51      | 0.0  | 0.0         |
      | 7  | 30   | 20240701     | 20240315    | 29.36           | 15.51         | 0.0      | 0.0  | 0.0       | 15.51 | 15.51 | 15.51      | 0.0  | 0.0         |
      | 8  | 31   | 20240801   | 20240315    | 13.85           | 15.51         | 0.0      | 0.0  | 0.0       | 15.51 | 15.51 | 15.51      | 0.0  | 0.0         |
      | 9  | 31   | 20240901| 20240315    | 0.0             | 13.85         | 0.0      | 0.0  | 0.0       | 13.85 | 13.85 | 13.85      | 0.0  | 0.0         |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late | Outstanding |
      | 116.43        | 1.98     | 0.0  | 0.0       | 118.41 | 118.41 | 91.4       | 0.0  | 0.0         |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240201 | Repayment        | 17.01  | 16.43     | 0.58     | 0.0  | 0.0       | 83.57        | false    | false    |
      | 20240201 | Chargeback       | 17.01  | 16.43     | 0.58     | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240301    | Repayment        | 10.0   | 10.0      | 0.0      | 0.0  | 0.0       | 90.0         | false    | false    |
      | 20240315    | Re-age           | 91.4   | 90.0      | 1.4      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240315    | Repayment        | 91.4   | 90.0      | 1.4      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240315    | Accrual          | 1.98   | 0.0       | 1.98     | 0.0  | 0.0       | 0.0          | false    | false    |

  @TestRailId:C4356 @AdvancedPaymentAllocation
  Scenario: Verify Re-aging on interest bearing loan - Interest calculation: Default Behavior - with NEXT_INSTALLMENT allocation rule, backdated re-aging on 1st installment after repay and chargeback on 1st due - UC3.2
    When Admin sets the business date to "20240101"
    When Admin creates a client with random data
    When Admin set "LP2_ADV_CUSTOM_PMT_ALLOC_PROGRESSIVE_LOAN_SCHEDULE_HORIZONTAL" loan product "DEFAULT" transaction type to "NEXT_INSTALLMENT" future installment allocation rule
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
    When Admin makes "REPAYMENT_ADJUSTMENT_CHARGEBACK" chargeback with 17.01 EUR transaction amount
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101  |                  | 100.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 31   | 20240201 | 20240201 | 83.57           | 16.43         | 0.58     | 0.0  | 0.0       | 17.01 | 17.01 | 0.0        | 0.0  | 0.0         |
      | 2  | 29   | 20240301    |                  | 67.15           | 33.43         | 0.59     | 0.0  | 0.0       | 34.02 | 0.0   | 0.0        | 0.0  | 34.02       |
      | 3  | 31   | 20240401    |                  | 50.53           | 16.62         | 0.39     | 0.0  | 0.0       | 17.01 | 0.0   | 0.0        | 0.0  | 17.01       |
      | 4  | 30   | 20240501      |                  | 33.81           | 16.72         | 0.29     | 0.0  | 0.0       | 17.01 | 0.0   | 0.0        | 0.0  | 17.01       |
      | 5  | 31   | 20240601     |                  | 17.0            | 16.81         | 0.2      | 0.0  | 0.0       | 17.01 | 0.0   | 0.0        | 0.0  | 17.01       |
      | 6  | 30   | 20240701     |                  | 0.0             | 17.0          | 0.1      | 0.0  | 0.0       | 17.1  | 0.0   | 0.0        | 0.0  | 17.1        |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 117.01        | 2.15     | 0.0  | 0.0       | 119.16 | 17.01 | 0.0        | 0.0  | 102.15      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240201 | Repayment        | 17.01  | 16.43     | 0.58     | 0.0  | 0.0       | 83.57        | false    | false    |
      | 20240201 | Chargeback       | 17.01  | 17.01     | 0.0      | 0.0  | 0.0       | 100.58       | false    | false    |
    When Admin sets the business date to "20240501"
    When Admin creates a Loan re-aging transaction with the following data:
      | frequencyNumber | frequencyType | startDate        | numberOfInstallments |
      | 1               | MONTHS        | 20240201 | 6                    |
    Then Loan Repayment schedule has 7 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101  |                  | 100.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 31   | 20240201 | 20240201 | 100.58          | 16.43         | 0.58     | 0.0  | 0.0       | 17.01 | 17.01 | 0.0        | 0.0  | 0.0         |
      | 2  | 0    | 20240201 |                  | 83.58           | 17.0          | 0.0      | 0.0  | 0.0       | 17.0  | 0.0   | 0.0        | 0.0  | 17.0        |
      | 3  | 29   | 20240301    |                  | 67.16           | 16.42         | 0.58     | 0.0  | 0.0       | 17.0  | 0.0   | 0.0        | 0.0  | 17.0        |
      | 4  | 31   | 20240401    |                  | 50.74           | 16.42         | 0.58     | 0.0  | 0.0       | 17.0  | 0.0   | 0.0        | 0.0  | 17.0        |
      | 5  | 30   | 20240501      |                  | 34.32           | 16.42         | 0.58     | 0.0  | 0.0       | 17.0  | 0.0   | 0.0        | 0.0  | 17.0        |
      | 6  | 31   | 20240601     |                  | 17.52           | 16.8          | 0.2      | 0.0  | 0.0       | 17.0  | 0.0   | 0.0        | 0.0  | 17.0        |
      | 7  | 30   | 20240701     |                  | 0.0             | 17.52         | 0.1      | 0.0  | 0.0       | 17.62 | 0.0   | 0.0        | 0.0  | 17.62       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 117.01        | 2.62     | 0.0  | 0.0       | 119.63 | 17.01 | 0.0        | 0.0  | 102.62      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240201 | Repayment        | 17.01  | 16.43     | 0.58     | 0.0  | 0.0       | 83.57        | false    | false    |
      | 20240201 | Chargeback       | 17.01  | 17.01     | 0.0      | 0.0  | 0.0       | 100.58       | false    | false    |
      | 20240201 | Re-age           | 100.58 | 100.58    | 0.0      | 0.0  | 0.0       | 0.0          | false    | false    |
    When Loan Pay-off is made on "20240501"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C4083 @AdvancedPaymentAllocation
  Scenario: Verify allowing Re-aging on interest bearing loan - Interest calculation: Default Behavior - N+1 Scenario - UC4
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
    When Admin sets the business date to "20240715"
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
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    |
      | 20240201 | Repayment        | 17.01  | 16.43     | 0.58     | 0.0  | 0.0       | 83.57        | false    |
    When Admin sets the business date to "20240315"
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
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240201 | Repayment        | 17.01  | 16.43     | 0.58     | 0.0  | 0.0       | 83.57        | false    | false    |
      | 20240315    | Re-age           | 84.28  | 83.57     | 0.71     | 0.0  | 0.0       | 0.0          | false    | false    |

    When Admin sets the business date to "20240401"
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
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240201 | Repayment        | 17.01  | 16.43     | 0.58     | 0.0  | 0.0       | 83.57        | false    | false    |
      | 20240315    | Re-age           | 84.28  | 83.57     | 0.71     | 0.0  | 0.0       | 0.0          | true     | false    |

    When Loan Pay-off is made on "20240401"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C4084 @AdvancedPaymentAllocation
  Scenario: Verify allowing Re-aging on interest bearing loan - Interest calculation: Default Behavior - Partially paid installment - UC5
    When Admin sets the business date to "20240101"
    When Admin creates a client with random data
    When Admin set "LP2_ADV_CUSTOM_PMT_ALLOC_PROGRESSIVE_LOAN_SCHEDULE_HORIZONTAL" loan product "DEFAULT" transaction type to "NEXT_INSTALLMENT" future installment allocation rule
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
    And Customer makes "AUTOPAY" repayment on "20240201" with 25.0 EUR transaction amount
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101  |                  | 100.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 31   | 20240201 | 20240201 | 83.57           | 16.43         | 0.58     | 0.0  | 0.0       | 17.01 | 17.01 | 0.0        | 0.0  | 0.0         |
      | 2  | 29   | 20240301    |                  | 67.0            | 16.57         | 0.44     | 0.0  | 0.0       | 17.01 | 7.99  | 7.99       | 0.0  | 9.02        |
      | 3  | 31   | 20240401    |                  | 50.38           | 16.62         | 0.39     | 0.0  | 0.0       | 17.01 | 0.0   | 0.0        | 0.0  | 17.01       |
      | 4  | 30   | 20240501      |                  | 33.66           | 16.72         | 0.29     | 0.0  | 0.0       | 17.01 | 0.0   | 0.0        | 0.0  | 17.01       |
      | 5  | 31   | 20240601     |                  | 16.85           | 16.81         | 0.2      | 0.0  | 0.0       | 17.01 | 0.0   | 0.0        | 0.0  | 17.01       |
      | 6  | 30   | 20240701     |                  | 0.0             | 16.85         | 0.1      | 0.0  | 0.0       | 16.95 | 0.0   | 0.0        | 0.0  | 16.95       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      | 100.0         | 2.0      | 0.0  | 0.0       | 102.0 | 25.0 | 7.99       | 0.0  | 77.0        |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    |
      | 20240201 | Repayment        | 25.0   | 24.42     | 0.58     | 0.0  | 0.0       | 75.58        | false    |
    When Admin sets the business date to "20240315"
    When Admin creates a Loan re-aging transaction with the following data:
      | frequencyNumber | frequencyType | startDate    | numberOfInstallments |
      | 1               | MONTHS        | 20240401| 6                    |
    Then Loan Repayment schedule has 9 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101  |                  | 100.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 31   | 20240201 | 20240201 | 83.57           | 16.43         | 0.58     | 0.0  | 0.0       | 17.01 | 17.01 | 0.0        | 0.0  | 0.0         |
      | 2  | 29   | 20240301    | 20240315    | 75.58           | 7.99          | 0.0      | 0.0  | 0.0       | 7.99  | 7.99  | 7.99       | 0.0  | 0.0         |
      | 3  | 14   | 20240315    | 20240315    | 75.58           | 0.0           | 0.0      | 0.0  | 0.0       | 0.0   | 0.0   | 0.0        | 0.0  | 0.0         |
      | 4  | 17   | 20240401    |                  | 63.53           | 12.05         | 0.88     | 0.0  | 0.0       | 12.93 | 0.0   | 0.0        | 0.0  | 12.93       |
      | 5  | 30   | 20240501      |                  | 50.97           | 12.56         | 0.37     | 0.0  | 0.0       | 12.93 | 0.0   | 0.0        | 0.0  | 12.93       |
      | 6  | 31   | 20240601     |                  | 38.34           | 12.63         | 0.3      | 0.0  | 0.0       | 12.93 | 0.0   | 0.0        | 0.0  | 12.93       |
      | 7  | 30   | 20240701     |                  | 25.63           | 12.71         | 0.22     | 0.0  | 0.0       | 12.93 | 0.0   | 0.0        | 0.0  | 12.93       |
      | 8  | 31   | 20240801   |                  | 12.85           | 12.78         | 0.15     | 0.0  | 0.0       | 12.93 | 0.0   | 0.0        | 0.0  | 12.93       |
      | 9  | 31   | 20240901|                  | 0.0             | 12.85         | 0.07     | 0.0  | 0.0       | 12.92 | 0.0   | 0.0        | 0.0  | 12.92       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 100.0         | 2.57     | 0.0  | 0.0       | 102.57 | 25.0 | 7.99       | 0.0  | 77.57       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240201 | Repayment        | 25.0   | 24.42     | 0.58     | 0.0  | 0.0       | 75.58        | false    | false    |
      | 20240315    | Re-age           | 76.22  | 75.58     | 0.64     | 0.0  | 0.0       | 0.0          | false    | false    |

    When Loan Pay-off is made on "20240315"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C4229 @AdvancedPaymentAllocation
  Scenario: Verify allowing Re-aging on interest bearing loan - Interest calculation: Default Behavior - with LAST_INSTALLMENT allocation rule and partial repayment - UC5.1
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
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    |
    When Admin sets the business date to "20240201"
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
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    |
      | 20240201 | Repayment        | 25.0   | 24.42     | 0.58     | 0.0  | 0.0       | 75.58        | false    |
    When Admin sets the business date to "20240315"
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
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240201 | Repayment        | 25.0   | 24.42     | 0.58     | 0.0  | 0.0       | 75.58        | false    | false    |
      | 20240315    | Re-age           | 76.22  | 75.58     | 0.64     | 0.0  | 0.0       | 0.0          | false    | false    |
    When Loan Pay-off is made on "20240315"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met
    Then Loan Repayment schedule has 9 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101  |                  | 100.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 31   | 20240201 | 20240201 | 83.57           | 16.43         | 0.58     | 0.0  | 0.0       | 17.01 | 17.01 | 0.0        | 0.0  | 0.0         |
      | 2  | 29   | 20240301    | 20240315    | 83.57           | 0.0           | 0.0      | 0.0  | 0.0       | 0.0   | 0.0   | 0.0        | 0.0  | 0.0         |
      | 3  | 14   | 20240315    | 20240315    | 75.58           | 7.99          | 0.0      | 0.0  | 0.0       | 7.99  | 7.99  | 7.99       | 0.0  | 0.0         |
      | 4  | 17   | 20240401    | 20240315    | 64.64           | 10.94         | 0.64     | 0.0  | 0.0       | 11.58 | 11.58 | 11.58      | 0.0  | 0.0         |
      | 5  | 30   | 20240501      | 20240315    | 51.71           | 12.93         | 0.0      | 0.0  | 0.0       | 12.93 | 12.93 | 12.93      | 0.0  | 0.0         |
      | 6  | 31   | 20240601     | 20240315    | 38.78           | 12.93         | 0.0      | 0.0  | 0.0       | 12.93 | 12.93 | 12.93      | 0.0  | 0.0         |
      | 7  | 30   | 20240701     | 20240315    | 25.85           | 12.93         | 0.0      | 0.0  | 0.0       | 12.93 | 12.93 | 12.93      | 0.0  | 0.0         |
      | 8  | 31   | 20240801   | 20240315    | 12.92           | 12.93         | 0.0      | 0.0  | 0.0       | 12.93 | 12.93 | 12.93      | 0.0  | 0.0         |
      | 9  | 31   | 20240901| 20240315    | 0.0             | 12.92         | 0.0      | 0.0  | 0.0       | 12.92 | 12.92 | 12.92      | 0.0  | 0.0         |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late | Outstanding |
      | 100.0         | 1.22     | 0.0  | 0.0       | 101.22 | 101.22 | 84.21      | 0.0  | 0.0         |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240201 | Repayment        | 25.0   | 24.42     | 0.58     | 0.0  | 0.0       | 75.58        | false    | false    |
      | 20240201 | Accrual Activity | 0.58   | 0.0       | 0.58     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240315    | Re-age           | 76.22  | 75.58     | 0.64     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240315    | Repayment        | 76.22  | 75.58     | 0.64     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240315    | Accrual          | 1.22   | 0.0       | 1.22     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240315    | Accrual Activity | 0.64   | 0.0       | 0.64     | 0.0  | 0.0       | 0.0          | false    | false    |
    When Admin set "LP2_ADV_CUSTOM_PMT_ALLOC_PROGRESSIVE_LOAN_SCHEDULE_HORIZONTAL" loan product "DEFAULT" transaction type to "NEXT_INSTALLMENT" future installment allocation rule

  @TestRailId:C4230 @AdvancedPaymentAllocation
  Scenario: Verify allowing Re-aging on interest bearing loan - Interest calculation: Default Behavior - with LAST_INSTALLMENT allocation rule and partial repayment - continue with regular payments
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
    When Admin sets the business date to "20240315"
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
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240201 | Repayment        | 25.0   | 24.42     | 0.58     | 0.0  | 0.0       | 75.58        | false    | false    |
      | 20240315    | Re-age           | 76.22  | 75.58     | 0.64     | 0.0  | 0.0       | 0.0          | false    | false    |
#   Make regular payment on first re-aged installment due date instead of immediate payoff
    When Admin sets the business date to "20240401"
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
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240201 | Repayment        | 25.0   | 24.42     | 0.58     | 0.0  | 0.0       | 75.58        | false    | false    |
      | 20240315    | Re-age           | 76.22  | 75.58     | 0.64     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240401    | Repayment        | 12.93  | 12.05     | 0.88     | 0.0  | 0.0       | 63.53        | false    | false    |
#   Continue with second regular payment
    When Admin sets the business date to "20240501"
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
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240201 | Repayment        | 25.0   | 24.42     | 0.58     | 0.0  | 0.0       | 75.58        | false    | false    |
      | 20240315    | Re-age           | 76.22  | 75.58     | 0.64     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240401    | Repayment        | 12.93  | 12.05     | 0.88     | 0.0  | 0.0       | 63.53        | false    | false    |
      | 20240501      | Repayment        | 12.93  | 12.56     | 0.37     | 0.0  | 0.0       | 50.97        | false    | false    |
    When Admin set "LP2_ADV_CUSTOM_PMT_ALLOC_PROGRESSIVE_LOAN_SCHEDULE_HORIZONTAL" loan product "DEFAULT" transaction type to "NEXT_INSTALLMENT" future installment allocation rule

  @TestRailId:C4231 @AdvancedPaymentAllocation
  Scenario: Verify allowing Re-aging on interest bearing loan - Interest calculation: Default Behavior - with LAST_INSTALLMENT allocation rule and multiple partial repayments
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
#   First overpayment - goes to last installment
    When Admin sets the business date to "20240201"
    And Customer makes "AUTOPAY" repayment on "20240201" with 20.0 EUR transaction amount
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101  |                  | 100.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 31   | 20240201 | 20240201 | 83.57           | 16.43         | 0.58     | 0.0  | 0.0       | 17.01 | 17.01 | 0.0        | 0.0  | 0.0         |
      | 2  | 29   | 20240301    |                  | 67.03           | 16.54         | 0.47     | 0.0  | 0.0       | 17.01 | 0.0   | 0.0        | 0.0  | 17.01       |
      | 3  | 31   | 20240401    |                  | 50.39           | 16.64         | 0.37     | 0.0  | 0.0       | 17.01 | 0.0   | 0.0        | 0.0  | 17.01       |
      | 4  | 30   | 20240501      |                  | 33.66           | 16.73         | 0.28     | 0.0  | 0.0       | 17.01 | 0.0   | 0.0        | 0.0  | 17.01       |
      | 5  | 31   | 20240601     |                  | 16.83           | 16.83         | 0.18     | 0.0  | 0.0       | 17.01 | 0.0   | 0.0        | 0.0  | 17.01       |
      | 6  | 30   | 20240701     |                  | 0.0             | 16.83         | 0.08     | 0.0  | 0.0       | 16.91 | 2.99  | 2.99      | 0.0  | 13.92       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 100.0         | 1.96     | 0.0  | 0.0       | 101.96 | 20.0 | 2.99       | 0.0  | 81.96       |
#   Second overpayment - also goes to last installment
    When Admin sets the business date to "20240301"
    And Customer makes "AUTOPAY" repayment on "20240301" with 22.0 EUR transaction amount
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101  |                  | 100.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 31   | 20240201 | 20240201 | 83.57           | 16.43         | 0.58     | 0.0  | 0.0       | 17.01 | 17.01 | 0.0        | 0.0  | 0.0         |
      | 2  | 29   | 20240301    | 20240301    | 67.03           | 16.54         | 0.47     | 0.0  | 0.0       | 17.01 | 17.01 | 0.0        | 0.0  | 0.0         |
      | 3  | 31   | 20240401    |                  | 50.36           | 16.67         | 0.34     | 0.0  | 0.0       | 17.01 | 0.0   | 0.0        | 0.0  | 17.01       |
      | 4  | 30   | 20240501      |                  | 33.6            | 16.76         | 0.25     | 0.0  | 0.0       | 17.01 | 0.0   | 0.0        | 0.0  | 17.01       |
      | 5  | 31   | 20240601     |                  | 16.74           | 16.86         | 0.15     | 0.0  | 0.0       | 17.01 | 0.0   | 0.0        | 0.0  | 17.01       |
      | 6  | 30   | 20240701     |                  | 0.0             | 16.74         | 0.05     | 0.0  | 0.0       | 16.79 | 7.98  | 7.98       | 0.0  | 8.81        |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 100.0         | 1.84     | 0.0  | 0.0       | 101.84 | 42.0 | 7.98       | 0.0  | 59.84       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    |
      | 20240201 | Repayment        | 20.0   | 19.42     | 0.58     | 0.0  | 0.0       | 80.58        | false    |
      | 20240301    | Repayment        | 22.0   | 21.53     | 0.47     | 0.0  | 0.0       | 59.05        | false    |
#   Re-aging with multiple paid amounts to consolidate
    When Admin sets the business date to "20240315"
    When Admin creates a Loan re-aging transaction with the following data:
      | frequencyNumber | frequencyType | startDate    | numberOfInstallments |
      | 1               | MONTHS        | 20240401| 6                    |
    Then Loan Repayment schedule has 9 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101  |                  | 100.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 31   | 20240201 | 20240201 | 83.57           | 16.43         | 0.58     | 0.0  | 0.0       | 17.01 | 17.01 | 0.0        | 0.0  | 0.0         |
      | 2  | 29   | 20240301    | 20240301    | 67.03           | 16.54         | 0.47     | 0.0  | 0.0       | 17.01 | 17.01 | 0.0        | 0.0  | 0.0         |
      | 3  | 14   | 20240315    | 20240315    | 59.05           | 7.98          | 0.0      | 0.0  | 0.0       | 7.98  | 7.98  | 7.98       | 0.0  | 0.0         |
      | 4  | 17   | 20240401    |                  | 49.36           | 9.69          | 0.35     | 0.0  | 0.0       | 10.04 | 0.0   | 0.0        | 0.0  | 10.04       |
      | 5  | 30   | 20240501      |                  | 39.61           | 9.75          | 0.29     | 0.0  | 0.0       | 10.04 | 0.0   | 0.0        | 0.0  | 10.04       |
      | 6  | 31   | 20240601     |                  | 29.8            | 9.81          | 0.23     | 0.0  | 0.0       | 10.04 | 0.0   | 0.0        | 0.0  | 10.04       |
      | 7  | 30   | 20240701     |                  | 19.93           | 9.87          | 0.17     | 0.0  | 0.0       | 10.04 | 0.0   | 0.0        | 0.0  | 10.04       |
      | 8  | 31   | 20240801   |                  | 10.01           | 9.92          | 0.12     | 0.0  | 0.0       | 10.04 | 0.0   | 0.0        | 0.0  | 10.04       |
      | 9  | 31   | 20240901|                  | 0.0             | 10.01         | 0.06     | 0.0  | 0.0       | 10.07 | 0.0   | 0.0        | 0.0  | 10.07       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 100.0         | 2.27     | 0.0  | 0.0       | 102.27 | 42.0 | 7.98       | 0.0  | 60.27       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240201 | Repayment        | 20.0   | 19.42     | 0.58     | 0.0  | 0.0       | 80.58        | false    | false    |
      | 20240301    | Repayment        | 22.0   | 21.53     | 0.47     | 0.0  | 0.0       | 59.05        | false    | false    |
      | 20240315    | Re-age           | 59.21  | 59.05     | 0.16     | 0.0  | 0.0       | 0.0          | false    | false    |
    When Loan Pay-off is made on "20240315"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met
    Then Loan Repayment schedule has 9 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101  |                  | 100.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 31   | 20240201 | 20240201 | 83.57           | 16.43         | 0.58     | 0.0  | 0.0       | 17.01 | 17.01 | 0.0        | 0.0  | 0.0         |
      | 2  | 29   | 20240301    | 20240301    | 67.03           | 16.54         | 0.47     | 0.0  | 0.0       | 17.01 | 17.01 | 0.0        | 0.0  | 0.0         |
      | 3  | 14   | 20240315    | 20240315    | 59.05           | 7.98          | 0.0      | 0.0  | 0.0       | 7.98  | 7.98  | 7.98       | 0.0  | 0.0         |
      | 4  | 17   | 20240401    | 20240315    | 50.22           | 8.83          | 0.16     | 0.0  | 0.0       | 8.99  | 8.99  | 8.99       | 0.0  | 0.0         |
      | 5  | 30   | 20240501      | 20240315    | 40.18           | 10.04         | 0.0      | 0.0  | 0.0       | 10.04 | 10.04 | 10.04      | 0.0  | 0.0         |
      | 6  | 31   | 20240601     | 20240315    | 30.14           | 10.04         | 0.0      | 0.0  | 0.0       | 10.04 | 10.04 | 10.04      | 0.0  | 0.0         |
      | 7  | 30   | 20240701     | 20240315    | 20.1            | 10.04         | 0.0      | 0.0  | 0.0       | 10.04 | 10.04 | 10.04      | 0.0  | 0.0         |
      | 8  | 31   | 20240801   | 20240315    | 10.06           | 10.04         | 0.0      | 0.0  | 0.0       | 10.04 | 10.04 | 10.04      | 0.0  | 0.0         |
      | 9  | 31   | 20240901| 20240315    | 0.0             | 10.06         | 0.0      | 0.0  | 0.0       | 10.06 | 10.06 | 10.06      | 0.0  | 0.0         |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late | Outstanding |
      | 100.0         | 1.21     | 0.0  | 0.0       | 101.21 | 101.21 | 67.19      | 0.0  | 0.0         |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240201 | Repayment        | 20.0   | 19.42     | 0.58     | 0.0  | 0.0       | 80.58        | false    | false    |
      | 20240201 | Accrual Activity | 0.58   | 0.0       | 0.58     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240301    | Repayment        | 22.0   | 21.53     | 0.47     | 0.0  | 0.0       | 59.05        | false    | false    |
      | 20240301    | Accrual Activity | 0.47   | 0.0       | 0.47     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240315    | Re-age           | 59.21  | 59.05     | 0.16     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240315    | Repayment        | 59.21  | 59.05     | 0.16     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240315    | Accrual          | 1.21   | 0.0       | 1.21     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240315    | Accrual Activity | 0.16   | 0.0       | 0.16     | 0.0  | 0.0       | 0.0          | false    | false    |
    When Admin set "LP2_ADV_CUSTOM_PMT_ALLOC_PROGRESSIVE_LOAN_SCHEDULE_HORIZONTAL" loan product "DEFAULT" transaction type to "NEXT_INSTALLMENT" future installment allocation rule

  @TestRailId:C4232
  Scenario: Verify allowing Re-aging on interest bearing loan - Interest calculation: Default Behavior - re-aging on paid installment date - UC5.2
    When Admin sets the business date to "20240101"
    When Admin creates a client with random data
    When Admin set "LP2_ADV_CUSTOM_PMT_ALLOC_PROGRESSIVE_LOAN_SCHEDULE_HORIZONTAL" loan product "DEFAULT" transaction type to "NEXT_INSTALLMENT" future installment allocation rule
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
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240201 | Repayment        | 17.01  | 16.43     | 0.58     | 0.0  | 0.0       | 83.57        | false    | false    |
      | 20240301    | Repayment        | 17.01  | 16.52     | 0.49     | 0.0  | 0.0       | 67.05        | false    | false    |
    When Admin sets the business date to "20240501"
    When Admin creates a Loan re-aging transaction with the following data:
      | frequencyNumber | frequencyType | startDate     | numberOfInstallments |
      | 1               | MONTHS        | 20240301 | 6                    |
    Then Loan Repayment schedule has 8 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101  |                  | 100.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 31   | 20240201 | 20240201 | 83.57           | 16.43         | 0.58     | 0.0  | 0.0       | 17.01 | 17.01 | 0.0        | 0.0  | 0.0         |
      | 2  | 29   | 20240301    | 20240301    | 67.05           | 16.52         | 0.49     | 0.0  | 0.0       | 17.01 | 17.01 | 0.0        | 0.0  | 0.0         |
      | 3  | 0    | 20240301    |                  | 55.71           | 11.34         | 0.0      | 0.0  | 0.0       | 11.34 | 0.0   | 0.0        | 0.0  | 11.34       |
      | 4  | 31   | 20240401    |                  | 44.76           | 10.95         | 0.39     | 0.0  | 0.0       | 11.34 | 0.0   | 0.0        | 0.0  | 11.34       |
      | 5  | 30   | 20240501      |                  | 33.81           | 10.95         | 0.39     | 0.0  | 0.0       | 11.34 | 0.0   | 0.0        | 0.0  | 11.34       |
      | 6  | 31   | 20240601     |                  | 22.67           | 11.14         | 0.2      | 0.0  | 0.0       | 11.34 | 0.0   | 0.0        | 0.0  | 11.34       |
      | 7  | 30   | 20240701     |                  | 11.46           | 11.21         | 0.13     | 0.0  | 0.0       | 11.34 | 0.0   | 0.0        | 0.0  | 11.34       |
      | 8  | 31   | 20240801   |                  | 0.0             | 11.46         | 0.07     | 0.0  | 0.0       | 11.53 | 0.0   | 0.0        | 0.0  | 11.53       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 100.0         | 2.25     | 0.0  | 0.0       | 102.25 | 34.02 | 0.0        | 0.0  | 68.23       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240201 | Repayment        | 17.01  | 16.43     | 0.58     | 0.0  | 0.0       | 83.57        | false    | false    |
      | 20240301    | Repayment        | 17.01  | 16.52     | 0.49     | 0.0  | 0.0       | 67.05        | false    | false    |
      | 20240301    | Re-age           | 67.05  | 67.05     | 0.0      | 0.0  | 0.0       | 0.0          | false    | false    |
    When Loan Pay-off is made on "20240501"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met
    Then Loan Repayment schedule has 8 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late  | Outstanding |
      |    |      | 20240101  |                  | 100.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |       |             |
      | 1  | 31   | 20240201 | 20240201 | 83.57           | 16.43         | 0.58     | 0.0  | 0.0       | 17.01 | 17.01 | 0.0        | 0.0   | 0.0         |
      | 2  | 29   | 20240301    | 20240301    | 67.05           | 16.52         | 0.49     | 0.0  | 0.0       | 17.01 | 17.01 | 0.0        | 0.0   | 0.0         |
      | 3  | 0    | 20240301    | 20240501      | 55.71           | 11.34         | 0.0      | 0.0  | 0.0       | 11.34 | 11.34 | 0.0        | 11.34 | 0.0         |
      | 4  | 31   | 20240401    | 20240501      | 44.76           | 10.95         | 0.39     | 0.0  | 0.0       | 11.34 | 11.34 | 0.0        | 11.34 | 0.0         |
      | 5  | 30   | 20240501      | 20240501      | 33.81           | 10.95         | 0.39     | 0.0  | 0.0       | 11.34 | 11.34 | 0.0        | 0.0   | 0.0         |
      | 6  | 31   | 20240601     | 20240501      | 22.47           | 11.34         | 0.0      | 0.0  | 0.0       | 11.34 | 11.34 | 11.34      | 0.0   | 0.0         |
      | 7  | 30   | 20240701     | 20240501      | 11.13           | 11.34         | 0.0      | 0.0  | 0.0       | 11.34 | 11.34 | 11.34      | 0.0   | 0.0         |
      | 8  | 31   | 20240801   | 20240501      | 0.0             | 11.13         | 0.0      | 0.0  | 0.0       | 11.13 | 11.13 | 11.13      | 0.0   | 0.0         |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late  | Outstanding |
      | 100.0         | 1.85     | 0.0  | 0.0       | 101.85 | 101.85 | 33.81      | 22.68 | 0.0         |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240201 | Repayment        | 17.01  | 16.43     | 0.58     | 0.0  | 0.0       | 83.57        | false    | false    |
      | 20240201 | Accrual Activity | 0.58   | 0.0       | 0.58     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240301    | Repayment        | 17.01  | 16.52     | 0.49     | 0.0  | 0.0       | 67.05        | false    | false    |
      | 20240301    | Re-age           | 67.05  | 67.05     | 0.0      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240301    | Accrual Activity | 0.49   | 0.0       | 0.49     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240401    | Accrual Activity | 0.39   | 0.0       | 0.39     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240501      | Repayment        | 67.83  | 67.05     | 0.78     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240501      | Accrual          | 1.85   | 0.0       | 1.85     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240501      | Accrual Activity | 0.39   | 0.0       | 0.39     | 0.0  | 0.0       | 0.0          | false    | false    |

  @TestRailId:C4233
  Scenario: Verify allowing Re-aging on interest bearing loan - Interest calculation: Default Behavior - with NEXT_INSTALLMENT allocation rule and partial repayment - UC5.3
    When Admin sets the business date to "20240101"
    When Admin creates a client with random data
    When Admin set "LP2_ADV_CUSTOM_PMT_ALLOC_PROGRESSIVE_LOAN_SCHEDULE_HORIZONTAL" loan product "DEFAULT" transaction type to "NEXT_INSTALLMENT" future installment allocation rule
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
    And Customer makes "AUTOPAY" repayment on "20240201" with 25.0 EUR transaction amount
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101  |                  | 100.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 31   | 20240201 | 20240201 | 83.57           | 16.43         | 0.58     | 0.0  | 0.0       | 17.01 | 17.01 | 0.0        | 0.0  | 0.0         |
      | 2  | 29   | 20240301    |                  | 67.0            | 16.57         | 0.44     | 0.0  | 0.0       | 17.01 | 7.99  | 7.99       | 0.0  | 9.02        |
      | 3  | 31   | 20240401    |                  | 50.38           | 16.62         | 0.39     | 0.0  | 0.0       | 17.01 | 0.0   | 0.0        | 0.0  | 17.01       |
      | 4  | 30   | 20240501      |                  | 33.66           | 16.72         | 0.29     | 0.0  | 0.0       | 17.01 | 0.0   | 0.0        | 0.0  | 17.01       |
      | 5  | 31   | 20240601     |                  | 16.85           | 16.81         | 0.2      | 0.0  | 0.0       | 17.01 | 0.0   | 0.0        | 0.0  | 17.01       |
      | 6  | 30   | 20240701     |                  | 0.0             | 16.85         | 0.1      | 0.0  | 0.0       | 16.95 | 0.0   | 0.0        | 0.0  | 16.95       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      | 100.0         | 2.0      | 0.0  | 0.0       | 102.0 | 25.0 | 7.99       | 0.0  | 77.0        |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    |
      | 20240201 | Repayment        | 25.0   | 24.42     | 0.58     | 0.0  | 0.0       | 75.58        | false    |
    When Admin sets the business date to "20240315"
    When Admin creates a Loan re-aging transaction with the following data:
      | frequencyNumber | frequencyType | startDate     | numberOfInstallments |
      | 1               | MONTHS        | 20240301 | 6                    |
    Then Loan Repayment schedule has 8 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101  |                  | 100.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 31   | 20240201 | 20240201 | 83.57           | 16.43         | 0.58     | 0.0  | 0.0       | 17.01 | 17.01 | 0.0        | 0.0  | 0.0         |
      | 2  | 29   | 20240301    | 20240301    | 75.58           | 7.99          | 0.0      | 0.0  | 0.0       | 7.99  | 7.99  | 7.99       | 0.0  | 0.0         |
      | 3  | 0    | 20240301    |                  | 63.16           | 12.42         | 0.44     | 0.0  | 0.0       | 12.86 | 0.0   | 0.0        | 0.0  | 12.86       |
      | 4  | 31   | 20240401    |                  | 50.7            | 12.46         | 0.4      | 0.0  | 0.0       | 12.86 | 0.0   | 0.0        | 0.0  | 12.86       |
      | 5  | 30   | 20240501      |                  | 38.14           | 12.56         | 0.3      | 0.0  | 0.0       | 12.86 | 0.0   | 0.0        | 0.0  | 12.86       |
      | 6  | 31   | 20240601     |                  | 25.5            | 12.64         | 0.22     | 0.0  | 0.0       | 12.86 | 0.0   | 0.0        | 0.0  | 12.86       |
      | 7  | 30   | 20240701     |                  | 12.79           | 12.71         | 0.15     | 0.0  | 0.0       | 12.86 | 0.0   | 0.0        | 0.0  | 12.86       |
      | 8  | 31   | 20240801   |                  | 0.0             | 12.79         | 0.07     | 0.0  | 0.0       | 12.86 | 0.0   | 0.0        | 0.0  | 12.86       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 100.0         | 2.16     | 0.0  | 0.0       | 102.16 | 25.0 | 7.99       | 0.0  | 77.16       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240201 | Repayment        | 25.0   | 24.42     | 0.58     | 0.0  | 0.0       | 75.58        | false    | false    |
      | 20240301    | Re-age           | 76.02  | 75.58     | 0.44     | 0.0  | 0.0       | 0.0          | false    | false    |
    When Loan Pay-off is made on "20240315"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met
    Then Loan Repayment schedule has 8 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late  | Outstanding |
      |    |      | 20240101  |                  | 100.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |       |             |
      | 1  | 31   | 20240201 | 20240201 | 83.57           | 16.43         | 0.58     | 0.0  | 0.0       | 17.01 | 17.01 | 0.0        | 0.0   | 0.0         |
      | 2  | 29   | 20240301    | 20240301    | 75.58           | 7.99          | 0.0      | 0.0  | 0.0       | 7.99  | 7.99  | 7.99       | 0.0   | 0.0         |
      | 3  | 0    | 20240301    | 20240315    | 63.16           | 12.42         | 0.44     | 0.0  | 0.0       | 12.86 | 12.86 | 0.0        | 12.86 | 0.0         |
      | 4  | 31   | 20240401    | 20240315    | 50.5            | 12.66         | 0.2      | 0.0  | 0.0       | 12.86 | 12.86 | 12.86      | 0.0   | 0.0         |
      | 5  | 30   | 20240501      | 20240315    | 37.64           | 12.86         | 0.0      | 0.0  | 0.0       | 12.86 | 12.86 | 12.86      | 0.0   | 0.0         |
      | 6  | 31   | 20240601     | 20240315    | 24.78           | 12.86         | 0.0      | 0.0  | 0.0       | 12.86 | 12.86 | 12.86      | 0.0   | 0.0         |
      | 7  | 30   | 20240701     | 20240315    | 11.92           | 12.86         | 0.0      | 0.0  | 0.0       | 12.86 | 12.86 | 12.86      | 0.0   | 0.0         |
      | 8  | 31   | 20240801   | 20240315    | 0.0             | 11.92         | 0.0      | 0.0  | 0.0       | 11.92 | 11.92 | 11.92      | 0.0   | 0.0         |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late  | Outstanding |
      | 100.0         | 1.22     | 0.0  | 0.0       | 101.22 | 101.22 | 71.35      | 12.86 | 0.0         |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240201 | Repayment        | 25.0   | 24.42     | 0.58     | 0.0  | 0.0       | 75.58        | false    | false    |
      | 20240201 | Accrual Activity | 0.58   | 0.0       | 0.58     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240301    | Re-age           | 76.02  | 75.58     | 0.44     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240301    | Accrual Activity | 0.44   | 0.0       | 0.44     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240315    | Repayment        | 76.22  | 75.58     | 0.64     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240315    | Accrual          | 1.22   | 0.0       | 1.22     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240315    | Accrual Activity | 0.2    | 0.0       | 0.2      | 0.0  | 0.0       | 0.0          | false    | false    |

  @TestRailId:C4085 @AdvancedPaymentAllocation
  Scenario: Verify allowing Re-aging on interest bearing loan - Interest calculation: Default Behavior - Chargeback after re-aging - UC6
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
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240201 | Repayment        | 17.01  | 16.43     | 0.58     | 0.0  | 0.0       | 83.57        | false    | false    |
      | 20240315    | Re-age           | 84.28  | 83.57     | 0.71     | 0.0  | 0.0       | 0.0          | false    | false    |
    When Admin sets the business date to "20240401"
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
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240201 | Repayment        | 17.01  | 16.43     | 0.58     | 0.0  | 0.0       | 83.57        | false    | false    |
      | 20240315    | Re-age           | 84.28  | 83.57     | 0.71     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240401    | Chargeback       | 17.01  | 16.43     | 0.58     | 0.0  | 0.0       | 100.0        | false    | false    |

    When Loan Pay-off is made on "20240401"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C4086 @AdvancedPaymentAllocation
  Scenario: Verify allowing Re-aging on interest bearing loan - Interest calculation: Default Behavior - DownPayment Scenarios - UC7
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
      | 20240201 | Repayment        | 12.76  | 12.32     | 0.44     | 0.0  | 0.0       | 62.68        | false    | false    |
    When Admin sets the business date to "20240315"
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
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240101  | Down Payment     | 25.0   | 25.0      | 0.0      | 0.0  | 0.0       | 75.0         | false    | false    |
      | 20240201 | Repayment        | 12.76  | 12.32     | 0.44     | 0.0  | 0.0       | 62.68        | false    | false    |
      | 20240315    | Re-age           | 63.22  | 62.68     | 0.54     | 0.0  | 0.0       | 0.0          | false    | false    |
    When Loan Pay-off is made on "20240315"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C4087 @AdvancedPaymentAllocation
  Scenario: Verify allowing Re-aging on interest bearing loan - Interest calculation: Default Behavior - reverse-repay, backdated repayment - UC8
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
      | 20240315    | Re-age           | 84.28  | 83.57     | 0.71     | 0.0  | 0.0       | 0.0          | false    | false    |
    When Admin sets the business date to "20240401"
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
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240201 | Repayment        | 17.01  | 16.43     | 0.58     | 0.0  | 0.0       | 83.57        | false    | false    |
      | 20240301    | Repayment        | 17.01  | 16.52     | 0.49     | 0.0  | 0.0       | 67.05        | false    | false    |
      | 20240315    | Re-age           | 67.23  | 67.05     | 0.18     | 0.0  | 0.0       | 0.0          | false    | true     |

    When Loan Pay-off is made on "20240401"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C4218 @AdvancedPaymentAllocation
  Scenario: Verify allowing Re-aging on interest bearing loan - Interest calculation: Default Behavior - reverse-repay, reversal of backdated repayment - UC8.1
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
      | 20240315    | Re-age           | 84.28  | 83.57     | 0.71     | 0.0  | 0.0       | 0.0          | false    | false    |
    When Admin sets the business date to "20240401"
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
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240201 | Repayment        | 17.01  | 16.43     | 0.58     | 0.0  | 0.0       | 83.57        | false    | false    |
      | 20240301    | Repayment        | 17.01  | 16.52     | 0.49     | 0.0  | 0.0       | 67.05        | false    | false    |
      | 20240315    | Re-age           | 67.23  | 67.05     | 0.18     | 0.0  | 0.0       | 0.0          | false    | true     |
    When Customer undo "1"th transaction made on "20240301"
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
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240201 | Repayment        | 17.01  | 16.43     | 0.58     | 0.0  | 0.0       | 83.57        | false    | false    |
      | 20240301    | Repayment        | 17.01  | 16.52     | 0.49     | 0.0  | 0.0       | 67.05        | true     | false    |
      | 20240315    | Re-age           | 84.28  | 83.57     | 0.71     | 0.0  | 0.0       | 0.0          | false    | true     |

    When Loan Pay-off is made on "20240401"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C4088 @AdvancedPaymentAllocation
  Scenario: Verify allowing Re-aging on interest bearing loan - Interest calculation: Default Behavior - reversal of Re-aging - UC9
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
      | 20240315    | Re-age           | 84.28  | 83.57     | 0.71     | 0.0  | 0.0       | 0.0          | false    | false    |
    When Admin sets the business date to "20240401"
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
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240201 | Repayment        | 17.01  | 16.43     | 0.58     | 0.0  | 0.0       | 83.57        | false    | false    |
      | 20240315    | Re-age           | 84.28  | 83.57     | 0.71     | 0.0  | 0.0       | 0.0          | true     | false    |

    When Loan Pay-off is made on "20240401"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C4089 @AdvancedPaymentAllocation
  Scenario: Verify that Re-aging is forbidden on charged-off loan, interest bearing loan, Interest calculation: Default Behavior, Charge-off scenario (zero interest) - UC10
    When Admin sets the business date to "20240101"
    When Admin creates a client with random data
    When Admin set "LP2_ADV_CUSTOM_PMT_ALLOC_PROGRESSIVE_LOAN_SCHEDULE_HORIZONTAL" loan product "DEFAULT" transaction type to "NEXT_INSTALLMENT" future installment allocation rule
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                  | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_INTEREST_RECALCULATION_ZERO_INTEREST_CHARGE_OFF | 20240101   | 100            | 7                       | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 6                 | MONTHS                | 1              | MONTHS                 | 6                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
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
    When Admin sets the business date to "20240301"
    And Admin does charge-off the loan on "20240301"
    Then LoanBalanceChangedBusinessEvent is created on "20240301"
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date            | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101 |                  | 100.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 31   | 20240201| 20240201 | 83.57           | 16.43         | 0.58     | 0.0  | 0.0       | 17.01 | 17.01 | 0.0        | 0.0  | 0.0         |
      | 2  | 29   | 20240301   |                  | 67.05           | 16.52         | 0.49     | 0.0  | 0.0       | 17.01 | 0.0   | 0.0        | 0.0  | 17.01       |
      | 3  | 31   | 20240401   |                  | 50.04           | 17.01         | 0.0      | 0.0  | 0.0       | 17.01 | 0.0   | 0.0        | 0.0  | 17.01       |
      | 4  | 30   | 20240501     |                  | 33.03           | 17.01         | 0.0      | 0.0  | 0.0       | 17.01 | 0.0   | 0.0        | 0.0  | 17.01       |
      | 5  | 31   | 20240601    |                  | 16.02           | 17.01         | 0.0      | 0.0  | 0.0       | 17.01 | 0.0   | 0.0        | 0.0  | 17.01       |
      | 6  | 30   | 20240701    |                  | 0.0             | 16.02         | 0.0      | 0.0  | 0.0       | 16.02 | 0.0   | 0.0        | 0.0  | 16.02       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 100.0         | 1.07     | 0.0  | 0.0       | 101.07 | 17.01 | 0.0        | 0.0  | 84.06       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240201 | Repayment        | 17.01  | 16.43     | 0.58     | 0.0  | 0.0       | 83.57        | false    | false    |
      | 20240301    | Accrual          | 1.07   | 0.0       | 1.07     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240301    | Charge-off       | 84.06  | 83.57     | 0.49     | 0.0  | 0.0       | 0.0          | false    | false    |
    When Admin sets the business date to "20240315"
    Then Admin fails to create a Loan re-aging transaction with the following data because loan was charged-off:
      | frequencyNumber | frequencyType | startDate     | numberOfInstallments |
      | 1               | MONTHS        | 20240401 | 6                    |

    When Loan Pay-off is made on "20240315"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C4131 @AdvancedPaymentAllocation
  Scenario: Verify that Re-aging is forbidden on charged-off loan, interest bearing loan, Interest calculation: Default Behavior, Charge-off scenario (regular) - UC10.1
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
    When Admin sets the business date to "20240301"
    And Admin does charge-off the loan on "20240301"
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
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240201 | Repayment        | 17.01  | 16.43     | 0.58     | 0.0  | 0.0       | 83.57        | false    | false    |
      | 20240301    | Accrual          | 1.07   | 0.0       | 1.07     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240301    | Charge-off       | 85.04  | 83.57     | 1.47     | 0.0  | 0.0       | 0.0          | false    | false    |
    When Admin sets the business date to "20240315"
    Then Admin fails to create a Loan re-aging transaction with the following data because loan was charged-off:
      | frequencyNumber | frequencyType | startDate     | numberOfInstallments |
      | 1               | MONTHS        | 20240401 | 6                    |

    When Loan Pay-off is made on "20240315"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C4132 @AdvancedPaymentAllocation
  Scenario: Verify that Re-aging is forbidden on contract terminated loan, interest bearing loan, Interest calculation: Default Behavior - UC10.2
    When Admin sets the business date to "20240101"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                              | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_INTEREST_RECALCULATION_CONTRACT_TERMINATION | 20240101   | 100            | 7                       | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 6                 | MONTHS                | 1              | MONTHS                 | 6                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
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

    When Admin sets the business date to "20240301"
    And Admin successfully terminates loan contract
    Then Loan Repayment schedule has 2 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101  |                  | 100.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 31   | 20240201 | 20240201 | 83.57           | 16.43         | 0.58     | 0.0  | 0.0       | 17.01 | 17.01 | 0.0        | 0.0  | 0.0         |
      | 2  | 29   | 20240301    |                  | 0.0             | 83.57         | 0.49     | 0.0  | 0.0       | 84.06 | 0.0   | 0.0        | 0.0  | 84.06       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 100.0         | 1.07     | 0.0  | 0.0       | 101.07 | 17.01 | 0.0        | 0.0  | 84.06       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type     | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement         | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240201 | Repayment            | 17.01  | 16.43     | 0.58     | 0.0  | 0.0       | 83.57        | false    | false    |
      | 20240301    | Accrual              | 1.07   | 0.0       | 1.07     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240301    | Contract Termination | 84.06  | 83.57     | 0.49     | 0.0  | 0.0       | 0.0          | false    | false    |

    When Admin sets the business date to "20240415"
    Then Admin fails to create a Loan re-aging transaction with the following data because loan was contract terminated:
      | frequencyNumber | frequencyType | startDate   | numberOfInstallments |
      | 1               | MONTHS        | 20240501 | 6                    |

    When Loan Pay-off is made on "20240415"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C4090 @AdvancedPaymentAllocation
  Scenario: Verify that Re-aging is forbidden on charged-off loan, interest bearing loan, Interest calculation: Default Behavior, Charge-off scenario (accelerate maturity) - UC11
    When Admin sets the business date to "20240101"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                                  | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_INTEREST_RECALCULATION_ACCELERATE_MATURITY_CHARGE_OFF_BEHAVIOUR | 20240101   | 100            | 7                       | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 6                 | MONTHS                | 1              | MONTHS                 | 6                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
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
    When Admin sets the business date to "20240301"
    And Admin does charge-off the loan on "20240301"
    Then LoanBalanceChangedBusinessEvent is created on "20240301"
    Then Loan Repayment schedule has 2 periods, with the following data for periods:
      | Nr | Days | Date            | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101 |                  | 100.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 31   | 20240201| 20240201 | 83.57           | 16.43         | 0.58     | 0.0  | 0.0       | 17.01 | 17.01 | 0.0        | 0.0  | 0.0         |
      | 2  | 29   | 20240301   |                  | 0.0             | 83.57         | 0.49     | 0.0  | 0.0       | 84.06 | 0.0   | 0.0        | 0.0  | 84.06       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 100.0         | 1.07     | 0.0  | 0.0       | 101.07 | 17.01 | 0.0        | 0.0  | 84.06       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240201 | Repayment        | 17.01  | 16.43     | 0.58     | 0.0  | 0.0       | 83.57        | false    | false    |
      | 20240301    | Accrual          | 1.07   | 0.0       | 1.07     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240301    | Charge-off       | 84.06  | 83.57     | 0.49     | 0.0  | 0.0       | 0.0          | false    | false    |
    When Admin sets the business date to "20240315"
    Then Admin fails to create a Loan re-aging transaction with the following data because loan was charged-off:
      | frequencyNumber | frequencyType | startDate     | numberOfInstallments |
      | 1               | MONTHS        | 20240401 | 6                    |

    When Loan Pay-off is made on "20240315"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C4091 @AdvancedPaymentAllocation
  Scenario: Verify allowing Re-aging on interest bearing loan - Interest calculation: Default Behavior - Fees and Interest Split after re-aging - UC12
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
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
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
    When Admin sets the business date to "20240215"
    When Admin adds "LOAN_SNOOZE_FEE" due date charge with "20240515" due date and 10 EUR transaction amount
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date            | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101 |                  | 100.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 31   | 20240201| 20240201 | 83.57           | 16.43         | 0.58     | 0.0  | 0.0       | 17.01 | 17.01 | 0.0        | 0.0  | 0.0         |
      | 2  | 29   | 20240301   |                  | 67.05           | 16.52         | 0.49     | 0.0  | 0.0       | 17.01 | 0.0   | 0.0        | 0.0  | 17.01       |
      | 3  | 31   | 20240401   |                  | 50.43           | 16.62         | 0.39     | 0.0  | 0.0       | 17.01 | 0.0   | 0.0        | 0.0  | 17.01       |
      | 4  | 30   | 20240501     |                  | 33.71           | 16.72         | 0.29     | 0.0  | 0.0       | 17.01 | 0.0   | 0.0        | 0.0  | 17.01       |
      | 5  | 31   | 20240601    |                  | 16.9            | 16.81         | 0.2      | 10.0 | 0.0       | 27.01 | 0.0   | 0.0        | 0.0  | 27.01       |
      | 6  | 30   | 20240701    |                  | 0.0             | 16.9          | 0.1      | 0.0  | 0.0       | 17.0  | 0.0   | 0.0        | 0.0  | 17.0        |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 100.0         | 2.05     | 10.0 | 0.0       | 112.05 | 17.01 | 0.0        | 0.0  | 95.04       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    |
      | 20240201 | Repayment        | 17.01  | 16.43     | 0.58     | 0.0  | 0.0       | 83.57        | false    |
    Then Loan Charges tab has the following data:
      | Name       | isPenalty | Payment due at       | Due as of   | Calculation type | Due  | Paid | Waived | Outstanding |
      | Snooze fee | false     | Specified due date   | 20240515 | Flat             | 10.0 | 0.0  | 0.0    | 10.0        |
    When Admin sets the business date to "20240315"
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
      | 6  | 31   | 20240601     |                  | 42.39           | 13.97         | 0.33     | 10.0 | 0.0       | 24.3  | 0.0   | 0.0        | 0.0  | 24.3        |
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
      | 20240315    | Re-age           | 84.28  | 83.57     | 0.71     | 0.0  | 0.0       | 0.0          | false    | false    |
    Then Loan Charges tab has the following data:
      | Name       | isPenalty | Payment due at       | Due as of   | Calculation type | Due  | Paid | Waived | Outstanding |
      | Snooze fee | false     | Specified due date   | 20240515 | Flat             | 10.0 | 0.0  | 0.0    | 10.0        |

    When Admin sets the business date to "20240401"
    When Admin successfully undo Loan re-aging transaction
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date            | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101 |                  | 100.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 31   | 20240201| 20240201 | 83.57           | 16.43         | 0.58     | 0.0  | 0.0       | 17.01 | 17.01 | 0.0        | 0.0  | 0.0         |
      | 2  | 29   | 20240301   |                  | 67.05           | 16.52         | 0.49     | 0.0  | 0.0       | 17.01 | 0.0   | 0.0        | 0.0  | 17.01       |
      | 3  | 31   | 20240401   |                  | 50.53           | 16.52         | 0.49     | 0.0  | 0.0       | 17.01 | 0.0   | 0.0        | 0.0  | 17.01       |
      | 4  | 30   | 20240501     |                  | 33.81           | 16.72         | 0.29     | 0.0  | 0.0       | 17.01 | 0.0   | 0.0        | 0.0  | 17.01       |
      | 5  | 31   | 20240601    |                  | 17.0            | 16.81         | 0.2      | 10.0 | 0.0       | 27.01 | 0.0   | 0.0        | 0.0  | 27.01       |
      | 6  | 30   | 20240701    |                  | 0.0             | 17.0          | 0.1      | 0.0  | 0.0       | 17.1  | 0.0   | 0.0        | 0.0  | 17.1        |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 100.0         | 2.15     | 10.0 | 0.0       | 112.15 | 17.01 | 0.0        | 0.0  | 95.14       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240201 | Repayment        | 17.01  | 16.43     | 0.58     | 0.0  | 0.0       | 83.57        | false    | false    |
      | 20240315    | Re-age           | 84.28  | 83.57     | 0.71     | 0.0  | 0.0       | 0.0          | true     | false    |
    Then Loan Charges tab has the following data:
      | Name       | isPenalty | Payment due at       | Due as of   | Calculation type | Due  | Paid | Waived | Outstanding |
      | Snooze fee | false     | Specified due date   | 20240515 | Flat             | 10.0 | 0.0  | 0.0    | 10.0        |

    When Loan Pay-off is made on "20240401"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C4196 @AdvancedPaymentAllocation
  Scenario: Verify Re-aging reversal on interest bearing loan - UC1: Interest handling: DEFAULT
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
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    |
      | 20240201 | Repayment        | 17.01  | 16.43     | 0.58     | 0.0  | 0.0       | 83.57        | false    |
      | 20240315    | Re-age           | 84.28  | 83.57     | 0.71     | 0.0  | 0.0       | 0.0          | false    |
#   --- Reversal of re-age transaction ---
    When Admin sets the business date to "20240401"
    And Admin successfully undo Loan re-aging transaction
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101  |                  | 100.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 31   | 20240201 | 20240201 | 83.57           | 16.43         | 0.58     | 0.0  | 0.0       | 17.01 | 17.01 | 0.0        | 0.0  | 0.0         |
      | 2  | 29   | 20240301    |                  | 67.05           | 16.52         | 0.49     | 0.0  | 0.0       | 17.01 | 0.0   | 0.0        | 0.0  | 17.01       |
      | 3  | 31   | 20240401    |                  | 50.53           | 16.52         | 0.49     | 0.0  | 0.0       | 17.01 | 0.0   | 0.0        | 0.0  | 17.01       |
      | 4  | 30   | 20240501      |                  | 33.81           | 16.72         | 0.29     | 0.0  | 0.0       | 17.01 | 0.0   | 0.0        | 0.0  | 17.01       |
      | 5  | 31   | 20240601     |                  | 17.0            | 16.81         | 0.2      | 0.0  | 0.0       | 17.01 | 0.0   | 0.0        | 0.0  | 17.01       |
      | 6  | 30   | 20240701     |                  | 0.0             | 17.0          | 0.1      | 0.0  | 0.0       | 17.1  | 0.0   | 0.0        | 0.0  | 17.1        |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 100.0         | 2.15     | 0.0  | 0.0       | 102.15 | 17.01 | 0.0        | 0.0  | 85.14       |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    |
      | 20240201 | Repayment        | 17.01  | 16.43     | 0.58     | 0.0  | 0.0       | 83.57        | false    |
      | 20240315    | Re-age           | 84.28  | 83.57     | 0.71     | 0.0  | 0.0       | 0.0          | true     |

    When Loan Pay-off is made on "20240401"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @Skip @TestRailId:C4197 @AdvancedPaymentAllocation
  Scenario: Verify Re-aging reversal on interest bearing loan - UC2: Interest handling: WAIVE_INTEREST
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
#    TODO investigate numbers  20240315
    When Admin sets the business date to "20240315"
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
#   --- Re-age transaction ---
    When Admin creates a Loan re-aging transaction with the following data:
      | frequencyNumber | frequencyType | startDate     | numberOfInstallments | reAgeInterestHandling |
      | 1               | MONTHS        | 20240401 | 6                    | WAIVE_INTEREST        |
    Then Loan Repayment schedule has 8 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101   |                  | 100.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 31   | 20240201  | 20240201 | 83.57           | 16.43         | 0.58     | 0.0  | 0.0       | 17.01 | 17.01 | 0.0        | 0.0  | 0.0         |
      | 2  | 29   | 20240301     | 20240315    | 83.57           | 0.0           | 0.0      | 0.0  | 0.0       | 0.0   | 0.0   | 0.0        | 0.0  | 0.0         |
      | 3  | 31   | 20240401     |                  | 69.66           | 13.91         | 0.27     | 0.0  | 0.0       | 14.18 | 0.0   | 0.0        | 0.0  | 14.18       |
      | 4  | 30   | 20240501       |                  | 55.89           | 13.77         | 0.41     | 0.0  | 0.0       | 14.18 | 0.0   | 0.0        | 0.0  | 14.18       |
      | 5  | 31   | 20240601      |                  | 42.04           | 13.85         | 0.33     | 0.0  | 0.0       | 14.18 | 0.0   | 0.0        | 0.0  | 14.18       |
      | 6  | 30   | 20240701      |                  | 28.11           | 13.93         | 0.25     | 0.0  | 0.0       | 14.18 | 0.0   | 0.0        | 0.0  | 14.18       |
      | 7  | 31   | 20240801    |                  | 14.09           | 14.02         | 0.16     | 0.0  | 0.0       | 14.18 | 0.0   | 0.0        | 0.0  | 14.18       |
      | 8  | 31   | 20240901 |                  | 0.0             | 14.09         | 0.08     | 0.0  | 0.0       | 14.17 | 0.0   | 0.0        | 0.0  | 14.17       |
#    TODO fix numbers
#    And Loan Repayment schedule has the following data in Total row:
#      | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
#      | 100.0         | 2.8      | 0.0  | 0.0       | 102.8 | 17.01 | 0.0        | 0.0  | 85.79       |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    |
      | 20240201 | Repayment        | 17.01  | 16.43     | 0.58     | 0.0  | 0.0       | 83.57        | false    |
      | 20240315    | Re-age           | 84.28  | 83.57     | 0.71     | 0.0  | 0.0       | 0.0          | false    |
      | 20240315    | Interest waive   | 0.71   | 0.0       | 0.71     | 0.0  | 0.0       | 0.0          | false    |
#   --- Reversal of re-age transaction ---
    When Admin sets the business date to "20240401"
    And Admin successfully undo Loan re-aging transaction
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101  |                  | 100.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 31   | 20240201 | 20240201 | 83.57           | 16.43         | 0.58     | 0.0  | 0.0       | 17.01 | 17.01 | 0.0        | 0.0  | 0.0         |
      | 2  | 29   | 20240301    |                  | 67.05           | 16.52         | 0.49     | 0.0  | 0.0       | 17.01 | 0.0   | 0.0        | 0.0  | 17.01       |
      | 3  | 31   | 20240401    |                  | 50.53           | 16.52         | 0.49     | 0.0  | 0.0       | 17.01 | 0.0   | 0.0        | 0.0  | 17.01       |
      | 4  | 30   | 20240501      |                  | 33.81           | 16.72         | 0.29     | 0.0  | 0.0       | 17.01 | 0.0   | 0.0        | 0.0  | 17.01       |
      | 5  | 31   | 20240601     |                  | 17.0            | 16.81         | 0.2      | 0.0  | 0.0       | 17.01 | 0.0   | 0.0        | 0.0  | 17.01       |
      | 6  | 30   | 20240701     |                  | 0.0             | 17.0          | 0.1      | 0.0  | 0.0       | 17.1  | 0.0   | 0.0        | 0.0  | 17.1        |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 100.0         | 2.15     | 0.0  | 0.0       | 102.15 | 17.01 | 0.0        | 0.0  | 85.14       |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    |
      | 20240201 | Repayment        | 17.01  | 16.43     | 0.58     | 0.0  | 0.0       | 83.57        | false    |
      | 20240315    | Re-age           | 84.28  | 83.57     | 0.71     | 0.0  | 0.0       | 0.0          | true     |
      | 20240315    | Interest waive   | 0.71   | 0.0       | 0.71     | 0.0  | 0.0       | 0.0          | true     |
    When Loan Pay-off is made on "20240401"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C4202 @AdvancedPaymentAllocation
  Scenario: Verify Re-aging reversal on interest bearing loan - UC5: Interest handling: DEFAULT, re-aging is NOT the latest transaction on loan
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
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    |
      | 20240201 | Repayment        | 17.01  | 16.43     | 0.58     | 0.0  | 0.0       | 83.57        | false    |
      | 20240315    | Re-age           | 84.28  | 83.57     | 0.71     | 0.0  | 0.0       | 0.0          | false    |
#    --- Transaction after re-aging ---
    When Admin sets the business date to "20240316"
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
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240201 | Repayment        | 17.01  | 16.43     | 0.58     | 0.0  | 0.0       | 83.57        | false    | false    |
      | 20240315    | Re-age           | 84.28  | 83.57     | 0.71     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240316    | Repayment        | 14.3   | 13.57     | 0.73     | 0.0  | 0.0       | 70.0         | false    | false    |
#   --- Reversal of re-age transaction ---
    When Admin sets the business date to "20240401"
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
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240201 | Repayment        | 17.01  | 16.43     | 0.58     | 0.0  | 0.0       | 83.57        | false    | false    |
      | 20240315    | Re-age           | 84.28  | 83.57     | 0.71     | 0.0  | 0.0       | 0.0          | true     | false    |
      | 20240316    | Repayment        | 14.3   | 13.81     | 0.49     | 0.0  | 0.0       | 69.76        | false    | true     |
    When Loan Pay-off is made on "20240401"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C4110 @AdvancedPaymentAllocation
  Scenario: Verify allowing Re-aging on interest bearing loan - Interest calculation: Default Behavior - backdated re-aging transaction - UC16
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
      | 20240301    | Repayment        | 17.01  | 16.52     | 0.49     | 0.0  | 0.0       | 67.05        | false    | false    |
      | 20240401    | Re-age           | 67.44  | 67.05     | 0.39     | 0.0  | 0.0       | 0.0          | false    | false    |

  @TestRailId:C4154 @AdvancedPaymentAllocation
  Scenario: Verify allowing Re-aging on interest bearing loan - Interest calculation: Default Behavior - re-aging on same day as disbursement - UC16.1
    When Admin sets the business date to "20240101"
    When Admin creates a client with random data
    When Admin set "LP2_ADV_CUSTOM_PMT_ALLOC_PROGRESSIVE_LOAN_SCHEDULE_HORIZONTAL" loan product "DEFAULT" transaction type to "NEXT_INSTALLMENT" future installment allocation rule
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
    When Admin creates a Loan re-aging transaction with the following data:
      | frequencyNumber | frequencyType | startDate       | numberOfInstallments |
      | 1               | MONTHS        | 20240101 | 6                    |
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
      | 20240101  | Re-age           | 100.0  | 100.0     | 0.0      | 0.0  | 0.0       | 0.0          | false    |

  @TestRailId:C4155 @AdvancedPaymentAllocation
  Scenario: Verify allowing Re-aging on interest bearing loan - Interest calculation: Default Behavior - validation that reAgeStartDate must be after disbursement date - UC16.2
    When Admin sets the business date to "20240101"
    When Admin creates a client with random data
    When Admin set "LP2_ADV_CUSTOM_PMT_ALLOC_PROGRESSIVE_LOAN_SCHEDULE_HORIZONTAL" loan product "DEFAULT" transaction type to "NEXT_INSTALLMENT" future installment allocation rule
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
    When Admin sets the business date to "20240215"
    When Admin fails to create a Loan re-aging transaction with status code 400 error "validation.msg.validation.errors.exist" and with the following data:
      | frequencyNumber | frequencyType | startDate          | numberOfInstallments |
      | 1               | MONTHS        | 20231231   | 6                    |

  @TestRailId:C4156 @AdvancedPaymentAllocation
  Scenario: Verify allowing Re-aging on interest bearing loan - Interest calculation: Default Behavior - Verify backdated re-aging on the day of repayment with interest recalculation enabled - UC16.3
    When Admin sets the business date to "20240101"
    When Admin creates a client with random data
    When Admin set "LP2_ADV_PYMNT_INTEREST_DAILY_INTEREST_RECALCULATION_ZERO_INTEREST_CHARGE_OFF" loan product "DEFAULT" transaction type to "NEXT_INSTALLMENT" future installment allocation rule
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                  | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_INTEREST_RECALCULATION_ZERO_INTEREST_CHARGE_OFF | 20240101   | 100            | 7                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 6                 | MONTHS                | 1              | MONTHS                 | 6                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
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
    When Admin creates a Loan re-aging transaction with the following data:
      | frequencyNumber | frequencyType | startDate        | numberOfInstallments |
      | 1               | MONTHS        | 20240201 | 6                    |
    Then Loan Repayment schedule has 7 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late  | Outstanding |
      |    |      | 20240101  |                  | 100.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |       |             |
      | 1  | 31   | 20240201 | 20240201 | 83.57           | 16.43         | 0.58     | 0.0  | 0.0       | 17.01 | 17.01 | 0.0        | 0.0   | 0.0         |
      | 2  | 0    | 20240201 | 20240301    | 69.44           | 14.13         | 0.0      | 0.0  | 0.0       | 14.13 | 14.13 | 0.0        | 14.13 | 0.0         |
      | 3  | 29   | 20240301    |                  | 55.8            | 13.64         | 0.49     | 0.0  | 0.0       | 14.13 | 2.88  | 0.0        | 0.0   | 11.25       |
      | 4  | 31   | 20240401    |                  | 42.06           | 13.74         | 0.39     | 0.0  | 0.0       | 14.13 | 0.0   | 0.0        | 0.0   | 14.13       |
      | 5  | 30   | 20240501      |                  | 28.32           | 13.74         | 0.39     | 0.0  | 0.0       | 14.13 | 0.0   | 0.0        | 0.0   | 14.13       |
      | 6  | 31   | 20240601     |                  | 14.58           | 13.74         | 0.39     | 0.0  | 0.0       | 14.13 | 0.0   | 0.0        | 0.0   | 14.13       |
      | 7  | 30   | 20240701     |                  | 0.0             | 14.58         | 0.09     | 0.0  | 0.0       | 14.67 | 0.0   | 0.0        | 0.0   | 14.67       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late  | Outstanding |
      | 100.0         | 2.33     | 0.0  | 0.0       | 102.33 | 34.02 | 0.0        | 14.13 | 68.31       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240201 | Repayment        | 17.01  | 16.43     | 0.58     | 0.0  | 0.0       | 83.57        | false    | false    |
      | 20240201 | Re-age           | 83.57  | 83.57     | 0.0      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240301    | Repayment        | 17.01  | 17.01     | 0.0      | 0.0  | 0.0       | 66.56        | false    | true     |
    When Loan Pay-off is made on "20240601"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met
    Then Loan Repayment schedule has 7 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late  | Outstanding |
      |    |      | 20240101  |                  | 100.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |       |             |
      | 1  | 31   | 20240201 | 20240201 | 83.57           | 16.43         | 0.58     | 0.0  | 0.0       | 17.01 | 17.01 | 0.0        | 0.0   | 0.0         |
      | 2  | 0    | 20240201 | 20240301    | 69.44           | 14.13         | 0.0      | 0.0  | 0.0       | 14.13 | 14.13 | 0.0        | 14.13 | 0.0         |
      | 3  | 29   | 20240301    | 20240601     | 55.8            | 13.64         | 0.49     | 0.0  | 0.0       | 14.13 | 14.13 | 0.0        | 11.25 | 0.0         |
      | 4  | 31   | 20240401    | 20240601     | 42.06           | 13.74         | 0.39     | 0.0  | 0.0       | 14.13 | 14.13 | 0.0        | 14.13 | 0.0         |
      | 5  | 30   | 20240501      | 20240601     | 28.32           | 13.74         | 0.39     | 0.0  | 0.0       | 14.13 | 14.13 | 0.0        | 14.13 | 0.0         |
      | 6  | 31   | 20240601     | 20240601     | 14.58           | 13.74         | 0.39     | 0.0  | 0.0       | 14.13 | 14.13 | 0.0        | 0.0   | 0.0         |
      | 7  | 30   | 20240701     | 20240601     | 0.0             | 14.58         | 0.0      | 0.0  | 0.0       | 14.58 | 14.58 | 14.58      | 0.0   | 0.0         |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late  | Outstanding |
      | 100.0         | 2.24     | 0.0  | 0.0       | 102.24 | 102.24 | 14.58      | 53.64 | 0.0         |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240201 | Repayment        | 17.01  | 16.43     | 0.58     | 0.0  | 0.0       | 83.57        | false    | false    |
      | 20240201 | Re-age           | 83.57  | 83.57     | 0.0      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240301    | Repayment        | 17.01  | 17.01     | 0.0      | 0.0  | 0.0       | 66.56        | false    | true     |
      | 20240601     | Repayment        | 68.22  | 66.56     | 1.66     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240601     | Accrual          | 2.24   | 0.0       | 2.24     | 0.0  | 0.0       | 0.0          | false    | false    |

  @TestRailId:С4268 @AdvancedPaymentAllocation
  Scenario: Verify allowing Re-aging on interest bearing loan - Interest calculation: Default Behavior - with LAST_INSTALLMENT allocation rule and partial repayment, due date and frequency changed - UC5.1
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
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    |
    When Admin sets the business date to "20240201"
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
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    |
      | 20240201 | Repayment        | 25.0   | 24.42     | 0.58     | 0.0  | 0.0       | 75.58        | false    |
    When Admin sets the business date to "20240315"
    When Admin creates a Loan re-aging transaction with the following data:
      | frequencyNumber | frequencyType | startDate     | numberOfInstallments |
      | 2               | WEEKS         | 20240415 | 6                    |
    Then Loan Repayment schedule has 9 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101  |                  | 100.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 31   | 20240201 | 20240201 | 83.57           | 16.43         | 0.58     | 0.0  | 0.0       | 17.01 | 17.01 | 0.0        | 0.0  | 0.0         |
      | 2  | 29   | 20240301    | 20240315    | 83.57           | 0.0           | 0.0      | 0.0  | 0.0       | 0.0   | 0.0   | 0.0        | 0.0  | 0.0         |
      | 3  | 14   | 20240315    | 20240315    | 75.58           | 7.99          | 0.0      | 0.0  | 0.0       | 7.99  | 7.99  | 7.99       | 0.0  | 0.0         |
      | 4  | 31   | 20240415    |                  | 63.8            | 11.78         | 1.08     | 0.0  | 0.0       | 12.86 | 0.0   | 0.0        | 0.0  | 12.86       |
      | 5  | 14   | 20240429    |                  | 51.11           | 12.69         | 0.17     | 0.0  | 0.0       | 12.86 | 0.0   | 0.0        | 0.0  | 12.86       |
      | 6  | 14   | 20240513      |                  | 38.39           | 12.72         | 0.14     | 0.0  | 0.0       | 12.86 | 0.0   | 0.0        | 0.0  | 12.86       |
      | 7  | 14   | 20240527      |                  | 25.63           | 12.76         | 0.1      | 0.0  | 0.0       | 12.86 | 0.0   | 0.0        | 0.0  | 12.86       |
      | 8  | 14   | 20240610     |                  | 12.84           | 12.79         | 0.07     | 0.0  | 0.0       | 12.86 | 0.0   | 0.0        | 0.0  | 12.86       |
      | 9  | 14   | 20240624     |                  | 0.0             | 12.84         | 0.03     | 0.0  | 0.0       | 12.87 | 0.0   | 0.0        | 0.0  | 12.87       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 100.0         | 2.17     | 0.0  | 0.0       | 102.17 | 25.0 | 7.99       | 0.0  | 77.17       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240201 | Repayment        | 25.0   | 24.42     | 0.58     | 0.0  | 0.0       | 75.58        | false    | false    |
      | 20240315    | Re-age           | 76.22  | 75.58     | 0.64     | 0.0  | 0.0       | 0.0          | false    | false    |
    When Loan Pay-off is made on "20240315"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met
    Then Loan Repayment schedule has 9 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101  |                  | 100.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 31   | 20240201 | 20240201 | 83.57           | 16.43         | 0.58     | 0.0  | 0.0       | 17.01 | 17.01 | 0.0        | 0.0  | 0.0         |
      | 2  | 29   | 20240301    | 20240315    | 83.57           | 0.0           | 0.0      | 0.0  | 0.0       | 0.0   | 0.0   | 0.0        | 0.0  | 0.0         |
      | 3  | 14   | 20240315    | 20240315    | 75.58           | 7.99          | 0.0      | 0.0  | 0.0       | 7.99  | 7.99  | 7.99       | 0.0  | 0.0         |
      | 4  | 31   | 20240415    | 20240315    | 64.31           | 11.27         | 0.64     | 0.0  | 0.0       | 11.91 | 11.91 | 11.91      | 0.0  | 0.0         |
      | 5  | 14   | 20240429    | 20240315    | 51.45           | 12.86         | 0.0      | 0.0  | 0.0       | 12.86 | 12.86 | 12.86      | 0.0  | 0.0         |
      | 6  | 14   | 20240513      | 20240315    | 38.59           | 12.86         | 0.0      | 0.0  | 0.0       | 12.86 | 12.86 | 12.86      | 0.0  | 0.0         |
      | 7  | 14   | 20240527      | 20240315    | 25.73           | 12.86         | 0.0      | 0.0  | 0.0       | 12.86 | 12.86 | 12.86      | 0.0  | 0.0         |
      | 8  | 14   | 20240610     | 20240315    | 12.87           | 12.86         | 0.0      | 0.0  | 0.0       | 12.86 | 12.86 | 12.86      | 0.0  | 0.0         |
      | 9  | 14   | 20240624     | 20240315    | 0.0             | 12.87         | 0.0      | 0.0  | 0.0       | 12.87 | 12.87 | 12.87      | 0.0  | 0.0         |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late | Outstanding |
      | 100.0         | 1.22     | 0.0  | 0.0       | 101.22 | 101.22 | 84.21      | 0.0  | 0.0         |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240201 | Repayment        | 25.0   | 24.42     | 0.58     | 0.0  | 0.0       | 75.58        | false    | false    |
      | 20240201 | Accrual Activity | 0.58   | 0.0       | 0.58     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240315    | Re-age           | 76.22  | 75.58     | 0.64     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240315    | Repayment        | 76.22  | 75.58     | 0.64     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240315    | Accrual          | 1.22   | 0.0       | 1.22     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240315    | Accrual Activity | 0.64   | 0.0       | 0.64     | 0.0  | 0.0       | 0.0          | false    | false    |
    When Admin set "LP2_ADV_CUSTOM_PMT_ALLOC_PROGRESSIVE_LOAN_SCHEDULE_HORIZONTAL" loan product "DEFAULT" transaction type to "NEXT_INSTALLMENT" future installment allocation rule

  @TestRailId:С4269 @AdvancedPaymentAllocation
  Scenario: Verify allowing Re-aging on interest bearing loan - Interest calculation: Default Behavior - re-aging on paid installment date, due date and frequency changed - UC5.2
    When Admin sets the business date to "20240101"
    When Admin creates a client with random data
    When Admin set "LP2_ADV_CUSTOM_PMT_ALLOC_PROGRESSIVE_LOAN_SCHEDULE_HORIZONTAL" loan product "DEFAULT" transaction type to "NEXT_INSTALLMENT" future installment allocation rule
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
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240201 | Repayment        | 17.01  | 16.43     | 0.58     | 0.0  | 0.0       | 83.57        | false    | false    |
      | 20240301    | Repayment        | 17.01  | 16.52     | 0.49     | 0.0  | 0.0       | 67.05        | false    | false    |
    When Admin sets the business date to "20240501"
    When Admin creates a Loan re-aging transaction with the following data:
      | frequencyNumber | frequencyType | startDate     | numberOfInstallments |
      | 2               | WEEKS         | 20240302 | 6                    |
    Then Loan Repayment schedule has 9 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101  |                  | 100.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 31   | 20240201 | 20240201 | 83.57           | 16.43         | 0.58     | 0.0  | 0.0       | 17.01 | 17.01 | 0.0        | 0.0  | 0.0         |
      | 2  | 29   | 20240301    | 20240301    | 67.05           | 16.52         | 0.49     | 0.0  | 0.0       | 17.01 | 17.01 | 0.0        | 0.0  | 0.0         |
      | 3  | 1    | 20240302    | 20240302    | 67.05           | 0.0           | 0.0      | 0.0  | 0.0       | 0.0   | 0.0   | 0.0        | 0.0  | 0.0         |
      | 4  | 0    | 20240302    |                  | 55.81           | 11.24         | 0.01     | 0.0  | 0.0       | 11.25 | 0.0   | 0.0        | 0.0  | 11.25       |
      | 5  | 14   | 20240316    |                  | 44.74           | 11.07         | 0.18     | 0.0  | 0.0       | 11.25 | 0.0   | 0.0        | 0.0  | 11.25       |
      | 6  | 14   | 20240330    |                  | 33.67           | 11.07         | 0.18     | 0.0  | 0.0       | 11.25 | 0.0   | 0.0        | 0.0  | 11.25       |
      | 7  | 14   | 20240413    |                  | 22.6            | 11.07         | 0.18     | 0.0  | 0.0       | 11.25 | 0.0   | 0.0        | 0.0  | 11.25       |
      | 8  | 14   | 20240427    |                  | 11.53           | 11.07         | 0.18     | 0.0  | 0.0       | 11.25 | 0.0   | 0.0        | 0.0  | 11.25       |
      | 9  | 14   | 20240511      |                  | 0.0             | 11.53         | 0.07     | 0.0  | 0.0       | 11.6  | 0.0   | 0.0        | 0.0  | 11.6        |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 100.0         | 1.87     | 0.0  | 0.0       | 101.87 | 34.02 | 0.0        | 0.0  | 67.85       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240201 | Repayment        | 17.01  | 16.43     | 0.58     | 0.0  | 0.0       | 83.57        | false    | false    |
      | 20240301    | Repayment        | 17.01  | 16.52     | 0.49     | 0.0  | 0.0       | 67.05        | false    | false    |
      | 20240302    | Re-age           | 67.06  | 67.05     | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
    When Loan Pay-off is made on "20240501"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met
    Then Loan Repayment schedule has 9 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late  | Outstanding |
      |    |      | 20240101  |                  | 100.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |       |             |
      | 1  | 31   | 20240201 | 20240201 | 83.57           | 16.43         | 0.58     | 0.0  | 0.0       | 17.01 | 17.01 | 0.0        | 0.0   | 0.0         |
      | 2  | 29   | 20240301    | 20240301    | 67.05           | 16.52         | 0.49     | 0.0  | 0.0       | 17.01 | 17.01 | 0.0        | 0.0   | 0.0         |
      | 3  | 1    | 20240302    | 20240302    | 67.05           | 0.0           | 0.0      | 0.0  | 0.0       | 0.0   | 0.0   | 0.0        | 0.0   | 0.0         |
      | 4  | 0    | 20240302    | 20240501      | 55.81           | 11.24         | 0.01     | 0.0  | 0.0       | 11.25 | 11.25 | 0.0        | 11.25 | 0.0         |
      | 5  | 14   | 20240316    | 20240501      | 44.74           | 11.07         | 0.18     | 0.0  | 0.0       | 11.25 | 11.25 | 0.0        | 11.25 | 0.0         |
      | 6  | 14   | 20240330    | 20240501      | 33.67           | 11.07         | 0.18     | 0.0  | 0.0       | 11.25 | 11.25 | 0.0        | 11.25 | 0.0         |
      | 7  | 14   | 20240413    | 20240501      | 22.6            | 11.07         | 0.18     | 0.0  | 0.0       | 11.25 | 11.25 | 0.0        | 11.25 | 0.0         |
      | 8  | 14   | 20240427    | 20240501      | 11.53           | 11.07         | 0.18     | 0.0  | 0.0       | 11.25 | 11.25 | 0.0        | 11.25 | 0.0         |
      | 9  | 14   | 20240511      | 20240501      | 0.0             | 11.53         | 0.05     | 0.0  | 0.0       | 11.58 | 11.58 | 11.58      | 0.0   | 0.0         |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late  | Outstanding |
      | 100.0         | 1.85     | 0.0  | 0.0       | 101.85 | 101.85 | 11.58      | 56.25 | 0.0         |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240201 | Repayment        | 17.01  | 16.43     | 0.58     | 0.0  | 0.0       | 83.57        | false    | false    |
      | 20240201 | Accrual Activity | 0.58   | 0.0       | 0.58     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240301    | Repayment        | 17.01  | 16.52     | 0.49     | 0.0  | 0.0       | 67.05        | false    | false    |
      | 20240301    | Accrual Activity | 0.49   | 0.0       | 0.49     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240302    | Re-age           | 67.06  | 67.05     | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240302    | Accrual Activity | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240316    | Accrual Activity | 0.18   | 0.0       | 0.18     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240330    | Accrual Activity | 0.18   | 0.0       | 0.18     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240413    | Accrual Activity | 0.18   | 0.0       | 0.18     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240427    | Accrual Activity | 0.18   | 0.0       | 0.18     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240501      | Repayment        | 67.83  | 67.05     | 0.78     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240501      | Accrual          | 1.85   | 0.0       | 1.85     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240501      | Accrual Activity | 0.05   | 0.0       | 0.05     | 0.0  | 0.0       | 0.0          | false    | false    |

  @TestRailId:С4270 @AdvancedPaymentAllocation
  Scenario: Verify allowing Re-aging on interest bearing loan - Interest calculation: Default Behavior - with NEXT_INSTALLMENT allocation rule and partial repayment, due date and frequency changed - UC5.3
    When Admin sets the business date to "20240101"
    When Admin creates a client with random data
    When Admin set "LP2_ADV_CUSTOM_PMT_ALLOC_PROGRESSIVE_LOAN_SCHEDULE_HORIZONTAL" loan product "DEFAULT" transaction type to "NEXT_INSTALLMENT" future installment allocation rule
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
    And Customer makes "AUTOPAY" repayment on "20240201" with 25.0 EUR transaction amount
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101  |                  | 100.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 31   | 20240201 | 20240201 | 83.57           | 16.43         | 0.58     | 0.0  | 0.0       | 17.01 | 17.01 | 0.0        | 0.0  | 0.0         |
      | 2  | 29   | 20240301    |                  | 67.0            | 16.57         | 0.44     | 0.0  | 0.0       | 17.01 | 7.99  | 7.99       | 0.0  | 9.02        |
      | 3  | 31   | 20240401    |                  | 50.38           | 16.62         | 0.39     | 0.0  | 0.0       | 17.01 | 0.0   | 0.0        | 0.0  | 17.01       |
      | 4  | 30   | 20240501      |                  | 33.66           | 16.72         | 0.29     | 0.0  | 0.0       | 17.01 | 0.0   | 0.0        | 0.0  | 17.01       |
      | 5  | 31   | 20240601     |                  | 16.85           | 16.81         | 0.2      | 0.0  | 0.0       | 17.01 | 0.0   | 0.0        | 0.0  | 17.01       |
      | 6  | 30   | 20240701     |                  | 0.0             | 16.85         | 0.1      | 0.0  | 0.0       | 16.95 | 0.0   | 0.0        | 0.0  | 16.95       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      | 100.0         | 2.0      | 0.0  | 0.0       | 102.0 | 25.0 | 7.99       | 0.0  | 77.0        |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    |
      | 20240201 | Repayment        | 25.0   | 24.42     | 0.58     | 0.0  | 0.0       | 75.58        | false    |
    When Admin sets the business date to "20240315"
    When Admin creates a Loan re-aging transaction with the following data:
      | frequencyNumber | frequencyType | startDate     | numberOfInstallments |
      | 1               | MONTHS        | 20240301 | 6                    |
    Then Loan Repayment schedule has 8 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101  |                  | 100.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 31   | 20240201 | 20240201 | 83.57           | 16.43         | 0.58     | 0.0  | 0.0       | 17.01 | 17.01 | 0.0        | 0.0  | 0.0         |
      | 2  | 29   | 20240301    | 20240301    | 75.58           | 7.99          | 0.0      | 0.0  | 0.0       | 7.99  | 7.99  | 7.99       | 0.0  | 0.0         |
      | 3  | 0    | 20240301    |                  | 63.16           | 12.42         | 0.44     | 0.0  | 0.0       | 12.86 | 0.0   | 0.0        | 0.0  | 12.86       |
      | 4  | 31   | 20240401    |                  | 50.7            | 12.46         | 0.4      | 0.0  | 0.0       | 12.86 | 0.0   | 0.0        | 0.0  | 12.86       |
      | 5  | 30   | 20240501      |                  | 38.14           | 12.56         | 0.3      | 0.0  | 0.0       | 12.86 | 0.0   | 0.0        | 0.0  | 12.86       |
      | 6  | 31   | 20240601     |                  | 25.5            | 12.64         | 0.22     | 0.0  | 0.0       | 12.86 | 0.0   | 0.0        | 0.0  | 12.86       |
      | 7  | 30   | 20240701     |                  | 12.79           | 12.71         | 0.15     | 0.0  | 0.0       | 12.86 | 0.0   | 0.0        | 0.0  | 12.86       |
      | 8  | 31   | 20240801   |                  | 0.0             | 12.79         | 0.07     | 0.0  | 0.0       | 12.86 | 0.0   | 0.0        | 0.0  | 12.86       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 100.0         | 2.16     | 0.0  | 0.0       | 102.16 | 25.0 | 7.99       | 0.0  | 77.16       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240201 | Repayment        | 25.0   | 24.42     | 0.58     | 0.0  | 0.0       | 75.58        | false    | false    |
      | 20240301    | Re-age           | 76.02  | 75.58     | 0.44     | 0.0  | 0.0       | 0.0          | false    | false    |
    When Loan Pay-off is made on "20240315"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met
    Then Loan Repayment schedule has 8 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late  | Outstanding |
      |    |      | 20240101  |                  | 100.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |       |             |
      | 1  | 31   | 20240201 | 20240201 | 83.57           | 16.43         | 0.58     | 0.0  | 0.0       | 17.01 | 17.01 | 0.0        | 0.0   | 0.0         |
      | 2  | 29   | 20240301    | 20240301    | 75.58           | 7.99          | 0.0      | 0.0  | 0.0       | 7.99  | 7.99  | 7.99       | 0.0   | 0.0         |
      | 3  | 0    | 20240301    | 20240315    | 63.16           | 12.42         | 0.44     | 0.0  | 0.0       | 12.86 | 12.86 | 0.0        | 12.86 | 0.0         |
      | 4  | 31   | 20240401    | 20240315    | 50.5            | 12.66         | 0.2      | 0.0  | 0.0       | 12.86 | 12.86 | 12.86      | 0.0   | 0.0         |
      | 5  | 30   | 20240501      | 20240315    | 37.64           | 12.86         | 0.0      | 0.0  | 0.0       | 12.86 | 12.86 | 12.86      | 0.0   | 0.0         |
      | 6  | 31   | 20240601     | 20240315    | 24.78           | 12.86         | 0.0      | 0.0  | 0.0       | 12.86 | 12.86 | 12.86      | 0.0   | 0.0         |
      | 7  | 30   | 20240701     | 20240315    | 11.92           | 12.86         | 0.0      | 0.0  | 0.0       | 12.86 | 12.86 | 12.86      | 0.0   | 0.0         |
      | 8  | 31   | 20240801   | 20240315    | 0.0             | 11.92         | 0.0      | 0.0  | 0.0       | 11.92 | 11.92 | 11.92      | 0.0   | 0.0         |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late  | Outstanding |
      | 100.0         | 1.22     | 0.0  | 0.0       | 101.22 | 101.22 | 71.35      | 12.86 | 0.0         |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240201 | Repayment        | 25.0   | 24.42     | 0.58     | 0.0  | 0.0       | 75.58        | false    | false    |
      | 20240201 | Accrual Activity | 0.58   | 0.0       | 0.58     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240301    | Re-age           | 76.02  | 75.58     | 0.44     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240301    | Accrual Activity | 0.44   | 0.0       | 0.44     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240315    | Repayment        | 76.22  | 75.58     | 0.64     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240315    | Accrual          | 1.22   | 0.0       | 1.22     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240315    | Accrual Activity | 0.2    | 0.0       | 0.2      | 0.0  | 0.0       | 0.0          | false    | false    |

  @TestRailId:С4271 @AdvancedPaymentAllocation
  Scenario: Verify allowing Re-aging on interest bearing loan - Interest calculation: Default Behavior - re-aging with NEXT_INSTALLMENT allocation rule and overDue installments, due date and frequency changed - UC5.4
    When Admin sets the business date to "20240101"
    When Admin creates a client with random data
    When Admin set "LP2_ADV_CUSTOM_PMT_ALLOC_PROGRESSIVE_LOAN_SCHEDULE_HORIZONTAL" loan product "DEFAULT" transaction type to "NEXT_INSTALLMENT" future installment allocation rule
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
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240201 | Repayment        | 17.01  | 16.43     | 0.58     | 0.0  | 0.0       | 83.57        | false    | false    |
      | 20240301    | Repayment        | 17.01  | 16.52     | 0.49     | 0.0  | 0.0       | 67.05        | false    | false    |
    When Admin sets the business date to "20240501"
    When Admin creates a Loan re-aging transaction with the following data:
      | frequencyNumber | frequencyType | startDate     | numberOfInstallments |
      | 2               | WEEKS         | 20240402 | 6                    |
    Then Loan Repayment schedule has 10 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101  |                  | 100.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 31   | 20240201 | 20240201 | 83.57           | 16.43         | 0.58     | 0.0  | 0.0       | 17.01 | 17.01 | 0.0        | 0.0  | 0.0         |
      | 2  | 29   | 20240301    | 20240301    | 67.05           | 16.52         | 0.49     | 0.0  | 0.0       | 17.01 | 17.01 | 0.0        | 0.0  | 0.0         |
      | 3  | 31   | 20240401    | 20240402    | 67.05           | 0.0           | 0.0      | 0.0  | 0.0       | 0.0   | 0.0   | 0.0        | 0.0  | 0.0         |
      | 4  | 1    | 20240402    | 20240402    | 67.05           | 0.0           | 0.0      | 0.0  | 0.0       | 0.0   | 0.0   | 0.0        | 0.0  | 0.0         |
      | 5  | 0    | 20240402    |                  | 56.13           | 10.92         | 0.4      | 0.0  | 0.0       | 11.32 | 0.0   | 0.0        | 0.0  | 11.32       |
      | 6  | 14   | 20240416    |                  | 44.99           | 11.14         | 0.18     | 0.0  | 0.0       | 11.32 | 0.0   | 0.0        | 0.0  | 11.32       |
      | 7  | 14   | 20240430    |                  | 33.85           | 11.14         | 0.18     | 0.0  | 0.0       | 11.32 | 0.0   | 0.0        | 0.0  | 11.32       |
      | 8  | 14   | 20240514      |                  | 22.63           | 11.22         | 0.1      | 0.0  | 0.0       | 11.32 | 0.0   | 0.0        | 0.0  | 11.32       |
      | 9  | 14   | 20240528      |                  | 11.37           | 11.26         | 0.06     | 0.0  | 0.0       | 11.32 | 0.0   | 0.0        | 0.0  | 11.32       |
      | 10 | 14   | 20240611     |                  | 0.0             | 11.37         | 0.03     | 0.0  | 0.0       | 11.4  | 0.0   | 0.0        | 0.0  | 11.4        |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 100.0         | 2.02     | 0.0  | 0.0       | 102.02 | 34.02 | 0.0        | 0.0  | 68.0        |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240201 | Repayment        | 17.01  | 16.43     | 0.58     | 0.0  | 0.0       | 83.57        | false    | false    |
      | 20240301    | Repayment        | 17.01  | 16.52     | 0.49     | 0.0  | 0.0       | 67.05        | false    | false    |
      | 20240402    | Re-age           | 67.45  | 67.05     | 0.4      | 0.0  | 0.0       | 0.0          | false    | false    |
    When Loan Pay-off is made on "20240501"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met
    Then Loan Repayment schedule has 10 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late  | Outstanding |
      |    |      | 20240101  |                  | 100.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |       |             |
      | 1  | 31   | 20240201 | 20240201 | 83.57           | 16.43         | 0.58     | 0.0  | 0.0       | 17.01 | 17.01 | 0.0        | 0.0   | 0.0         |
      | 2  | 29   | 20240301    | 20240301    | 67.05           | 16.52         | 0.49     | 0.0  | 0.0       | 17.01 | 17.01 | 0.0        | 0.0   | 0.0         |
      | 3  | 31   | 20240401    | 20240402    | 67.05           | 0.0           | 0.0      | 0.0  | 0.0       | 0.0   | 0.0   | 0.0        | 0.0   | 0.0         |
      | 4  | 1    | 20240402    | 20240402    | 67.05           | 0.0           | 0.0      | 0.0  | 0.0       | 0.0   | 0.0   | 0.0        | 0.0   | 0.0         |
      | 5  | 0    | 20240402    | 20240501      | 56.13           | 10.92         | 0.4      | 0.0  | 0.0       | 11.32 | 11.32 | 0.0        | 11.32 | 0.0         |
      | 6  | 14   | 20240416    | 20240501      | 44.99           | 11.14         | 0.18     | 0.0  | 0.0       | 11.32 | 11.32 | 0.0        | 11.32 | 0.0         |
      | 7  | 14   | 20240430    | 20240501      | 33.85           | 11.14         | 0.18     | 0.0  | 0.0       | 11.32 | 11.32 | 0.0        | 11.32 | 0.0         |
      | 8  | 14   | 20240514      | 20240501      | 22.54           | 11.31         | 0.01     | 0.0  | 0.0       | 11.32 | 11.32 | 11.32      | 0.0   | 0.0         |
      | 9  | 14   | 20240528      | 20240501      | 11.22           | 11.32         | 0.0      | 0.0  | 0.0       | 11.32 | 11.32 | 11.32      | 0.0   | 0.0         |
      | 10 | 14   | 20240611     | 20240501      | 0.0             | 11.22         | 0.0      | 0.0  | 0.0       | 11.22 | 11.22 | 11.22      | 0.0   | 0.0         |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late  | Outstanding |
      | 100.0         | 1.84     | 0.0  | 0.0       | 101.84 | 101.84 | 33.86      | 33.96 | 0.0         |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240201 | Repayment        | 17.01  | 16.43     | 0.58     | 0.0  | 0.0       | 83.57        | false    | false    |
      | 20240201 | Accrual Activity | 0.58   | 0.0       | 0.58     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240301    | Repayment        | 17.01  | 16.52     | 0.49     | 0.0  | 0.0       | 67.05        | false    | false    |
      | 20240301    | Accrual Activity | 0.49   | 0.0       | 0.49     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240402    | Re-age           | 67.45  | 67.05     | 0.4      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240402    | Accrual Activity | 0.4    | 0.0       | 0.4      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240416    | Accrual Activity | 0.18   | 0.0       | 0.18     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240430    | Accrual Activity | 0.18   | 0.0       | 0.18     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240501      | Repayment        | 67.82  | 67.05     | 0.77     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240501      | Accrual          | 1.84   | 0.0       | 1.84     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240501      | Accrual Activity | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |

  @TestRailId:C4249 @AdvancedPaymentAllocation
  Scenario: Verify Loan re-aging trn with 2nd disb and partial chargeback(with custom pmnt alloc) after re-age - interest bearing multidisb loan with default behaviour - UC1
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
# - re-age transaction --- #
    When Admin sets the business date to "20240315"
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
      | 20240315    | Re-age           | 84.28  | 83.57     | 0.71     | 0.0  | 0.0       | 0.0          | false    | false    |
    Then LoanReAgeTransactionBusinessEvent has changedTerms "true"
# --- 2nd disbursement transaction --- #
    When Admin sets the business date to "20240401"
    When Admin disburses the loan on "20240401" with "50" EUR transaction amount
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
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240201 | Repayment        | 17.01  | 16.43     | 0.58     | 0.0  | 0.0       | 83.57        | false    | false    |
      | 20240315    | Re-age           | 84.28  | 83.57     | 0.71     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240401    | Disbursement     | 50.0   | 0.0       | 0.0      | 0.0  | 0.0       | 133.57       | false    | false    |
    Then LoanDisbursalTransactionBusinessEvent has changedTerms "false"
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
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240201 | Repayment        | 17.01  | 16.43     | 0.58     | 0.0  | 0.0       | 83.57        | false    | false    |
      | 20240315    | Re-age           | 84.28  | 83.57     | 0.71     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240401    | Disbursement     | 50.0   | 0.0       | 0.0      | 0.0  | 0.0       | 133.57       | false    | false    |
      | 20240401    | Chargeback       | 17.01  | 16.43     | 0.58     | 0.0  | 0.0       | 150.0        | false    | false    |
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
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240201 | Repayment        | 17.01  | 16.43     | 0.58     | 0.0  | 0.0       | 83.57        | false    | false    |
      | 20240315    | Re-age           | 84.28  | 83.57     | 0.71     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240401    | Chargeback       | 17.01  | 16.43     | 0.58     | 0.0  | 0.0       | 100.0        | false    | false    |
    When Loan Pay-off is made on "20240401"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C4252 @AdvancedPaymentAllocation
  Scenario: Verify Loan re-aging trn with backdated re-aging before 2nd disb - interest bearing multidisb loan with default re-aging behaviour - UC4
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

    When Admin sets the business date to "20240401"
    When Admin successfully disburse the loan on "20240401" with "50" EUR transaction amount
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101   |                  | 100.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 31   | 20240201  | 20240201 | 83.57           | 16.43         | 0.58     | 0.0  | 0.0       | 17.01 | 17.01 | 0.0        | 0.0  | 0.0         |
      | 2  | 29   | 20240301     |                  | 67.05           | 16.52         | 0.49     | 0.0  | 0.0       | 17.01 | 0.0   | 0.0        | 0.0  | 17.01       |
      | 3  | 31   | 20240401     |                  | 50.53           | 16.52         | 0.49     | 0.0  | 0.0       | 17.01 | 0.0   | 0.0        | 0.0  | 17.01       |
      |    |      | 20240401     |                  | 50.0            |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 4  | 30   | 20240501       |                  | 67.25           | 33.28         | 0.59     | 0.0  | 0.0       | 33.87 | 0.0   | 0.0        | 0.0  | 33.87       |
      | 5  | 31   | 20240601      |                  | 33.77           | 33.48         | 0.39     | 0.0  | 0.0       | 33.87 | 0.0   | 0.0        | 0.0  | 33.87       |
      | 6  | 30   | 20240701      |                  |  0.0            | 33.77         | 0.2      | 0.0  | 0.0       | 33.97 | 0.0   | 0.0        | 0.0  | 33.97       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 150.0         | 2.74     | 0.0  | 0.0       | 152.74 | 17.01 | 0.0        | 0.0  | 135.73      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240201 | Repayment        | 17.01  | 16.43     | 0.58     | 0.0  | 0.0       | 83.57        | false    | false    |
      | 20240401    | Disbursement     | 50.0   | 0.0       | 0.0      | 0.0  | 0.0       | 133.57       | false    | false    |
# --- backdated re-aging ---#
    When Admin creates a Loan re-aging transaction by Loan external ID with the following data:
      | frequencyNumber | frequencyType | startDate     | numberOfInstallments |
      | 1               | MONTHS        | 20240315 | 6                    |
    Then Loan Repayment schedule has 9 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101   |                  | 100.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 31   | 20240201  | 20240201 | 83.57           | 16.43         | 0.58     | 0.0  | 0.0       | 17.01 | 17.01 | 0.0        | 0.0  | 0.0         |
      | 2  | 29   | 20240301     | 20240315    | 83.57           |  0.0          | 0.0      | 0.0  | 0.0       | 0.0   | 0.0   | 0.0        | 0.0  | 0.0         |
      | 3  | 14   | 20240315     | 20240315    | 83.57           |  0.0          | 0.0      | 0.0  | 0.0       | 0.0   | 0.0   | 0.0        | 0.0  | 0.0         |
      | 4  | 0    | 20240315     |                  | 70.03           | 13.54         | 0.71     | 0.0  | 0.0       | 14.25 | 0.0   | 0.0        | 0.0  | 14.25       |
      |    |      | 20240401     |                  | 50.0            |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 5  | 31   | 20240415     |                  | 96.22           | 23.81         | 0.58     | 0.0  | 0.0       | 24.39 | 0.0   | 0.0        | 0.0  | 24.39       |
      | 6  | 30   | 20240515       |                  | 72.39           | 23.83         | 0.56     | 0.0  | 0.0       | 24.39 | 0.0   | 0.0        | 0.0  | 24.39       |
      | 7  | 31   | 20240615      |                  | 48.42           | 23.97         | 0.42     | 0.0  | 0.0       | 24.39 | 0.0   | 0.0        | 0.0  | 24.39       |
      | 8  | 30   | 20240715      |                  | 24.31           | 24.11         | 0.28     | 0.0  | 0.0       | 24.39 | 0.0   | 0.0        | 0.0  | 24.39       |
      | 9  | 31   | 20240815    |                  |  0.0            | 24.31         | 0.14     | 0.0  | 0.0       | 24.45 | 0.0   | 0.0        | 0.0  | 24.45       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 150.0         | 3.27     | 0.0  | 0.0       | 153.27 | 17.01 | 0.0        | 0.0  | 136.26      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240201 | Repayment        | 17.01  | 16.43     | 0.58     | 0.0  | 0.0       | 83.57        | false    | false    |
      | 20240315    | Re-age           | 84.28  | 83.57     | 0.71     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240401    | Disbursement     | 50.0   | 0.0       | 0.0      | 0.0  | 0.0       | 133.57       | false    | false    |

    When Loan Pay-off is made on "20240401"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C4255 @AdvancedPaymentAllocation
  Scenario: Verify Loan re-aging trn with backdated 2nd disb and chargeback after re-age - interest bearing multidisbursal loan with default behaviour - UC7
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
# --- add repayment --- #
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
# --- add re-age transaction ---#
    When Admin sets the business date to "20240315"
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
      | 20240315    | Re-age           | 84.28  | 83.57     | 0.71     | 0.0  | 0.0       | 0.0          | false    | false    |
    Then LoanReAgeTransactionBusinessEvent has changedTerms "true"
# --- add backdated 2nd disbursement --- #
    When Admin sets the business date to "20240401"
    When Admin disburses the loan on "20240301" with "50" EUR transaction amount
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
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240201 | Repayment        | 17.01  | 16.43     | 0.58     | 0.0  | 0.0       | 83.57        | false    | false    |
      | 20240301    | Disbursement     | 50.0   | 0.0       | 0.0      | 0.0  | 0.0       | 133.57       | false    | false    |
      | 20240315    | Re-age           | 134.41 | 133.57    | 0.84     | 0.0  | 0.0       | 0.0          | false    | true     |
    Then LoanDisbursalTransactionBusinessEvent has changedTerms "false"
# --- add chargeback --- #
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
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240201 | Repayment        | 17.01  | 16.43     | 0.58     | 0.0  | 0.0       | 83.57        | false    | false    |
      | 20240301    | Disbursement     | 50.0   | 0.0       | 0.0      | 0.0  | 0.0       | 133.57       | false    | false    |
      | 20240315    | Re-age           | 134.41 | 133.57    | 0.84     | 0.0  | 0.0       | 0.0          | false    | true     |
      | 20240401    | Chargeback       | 12.0   | 11.42     | 0.58     | 0.0  | 0.0       | 144.99       | false    | false    |
# --- undo last disbursement --- #
    When Admin successfully undo last disbursal
    Then Loan Repayment schedule has 9 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101   |                  | 100.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 31   | 20240201  | 20240201 | 83.57           | 16.43         | 0.58     | 0.0  | 0.0       | 17.01 | 17.01 | 0.0        | 0.0  | 0.0         |
      | 2  | 29   | 20240301     | 20240315    | 83.57           |  0.0          | 0.0      | 0.0  | 0.0       |  0.0  | 0.0   | 0.0        | 0.0  | 0.0         |
      | 3  | 14   | 20240315     | 20240315    | 83.57           | 0.0           | 0.0      | 0.0  | 0.0       | 0.0   | 0.0   | 0.0        | 0.0  | 0.0         |
      | 4  | 17   | 20240401     |                  | 70.25           | 13.32         | 0.98     | 0.0  | 0.0       | 14.3  | 0.0   | 0.0        | 0.0  | 14.3        |
      | 5  | 30   | 20240501       |                  | 56.43           | 25.24         | 1.06     | 0.0  | 0.0       | 26.3  | 0.0   | 0.0        | 0.0  | 26.3        |
      | 6  | 31   | 20240601      |                  | 42.46           | 13.97         | 0.33     | 0.0  | 0.0       | 14.3  | 0.0   | 0.0        | 0.0  | 14.3        |
      | 7  | 30   | 20240701      |                  | 28.41           | 14.05         | 0.25     | 0.0  | 0.0       | 14.3  | 0.0   | 0.0        | 0.0  | 14.3        |
      | 8  | 31   | 20240801    |                  | 14.28           | 14.13         | 0.17     | 0.0  | 0.0       | 14.3  | 0.0   | 0.0        | 0.0  | 14.3        |
      | 9  | 31   | 20240901 |                  |  0.0            | 14.28         | 0.08     | 0.0  | 0.0       | 14.36 | 0.0   | 0.0        | 0.0  | 14.36       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 111.42        | 3.45     | 0.0  | 0.0       | 114.87 | 17.01 | 0.0        | 0.0  | 97.86      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240201 | Repayment        | 17.01  | 16.43     | 0.58     | 0.0  | 0.0       | 83.57        | false    | false    |
      | 20240315    | Re-age           | 84.28  | 83.57     | 0.71     | 0.0  | 0.0       | 0.0          | false    | true     |
      | 20240401    | Chargeback       | 12.0   | 11.42     | 0.58     | 0.0  | 0.0       | 94.99        | false    | false    |
    When Loan Pay-off is made on "20240401"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C4258 @AdvancedPaymentAllocation
  Scenario: Verify Loan re-aging trn with CI after re-age with over applied amount - interest bearing multidisb loan with default behaviour - UC10
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
      | 100.0         | 2.8     | 0.0  | 0.0       | 102.8  | 17.01 | 0.0        | 0.0  | 85.79       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240201 | Repayment        | 17.01  | 16.43     | 0.58     | 0.0  | 0.0       | 83.57        | false    | false    |
      | 20240315    | Re-age           | 84.28  | 83.57     | 0.71     | 0.0  | 0.0       | 0.0          | false    | false    |

    When Admin sets the business date to "20240401"
    And Admin adds capitalized income with "AUTOPAY" payment type to the loan on "20240401" with "50" EUR transaction amount
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
      | 150.0         | 3.66     | 0.0  | 0.0       | 153.66 | 17.01 | 0.0        | 0.0  | 136.65      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type   | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement       | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240201 | Repayment          | 17.01  | 16.43     | 0.58     | 0.0  | 0.0       | 83.57        | false    | false    |
      | 20240315    | Re-age             | 84.28  | 83.57     | 0.71     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240401    | Capitalized Income | 50.0   | 50.0      | 0.0      | 0.0  | 0.0       | 133.57       | false    | false    |

    And Customer makes "AUTOPAY" repayment on "20240401" with 14.3 EUR transaction amount
    Then Loan Repayment schedule has 9 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101   |                  | 100.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 31   | 20240201  | 20240201 | 83.57           | 16.43         | 0.58     | 0.0  | 0.0       | 17.01 | 17.01 | 0.0        | 0.0  | 0.0         |
      | 2  | 29   | 20240301     | 20240315    | 83.57           |  0.0          | 0.0      | 0.0  | 0.0       | 0.0   | 0.0   | 0.0        | 0.0  | 0.0         |
      | 3  | 14   | 20240315     | 20240315    | 83.57           |  0.0          | 0.0      | 0.0  | 0.0       | 0.0   | 0.0   | 0.0        | 0.0  | 0.0         |
      | 4  | 17   | 20240401     | 20240401    | 70.25           | 13.32         | 0.98     | 0.0  | 0.0       | 14.3  | 14.3  | 0.0        | 0.0  | 0.0         |
      |    |      | 20240401     |                  | 50.0            |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 5  | 30   | 20240501       |                  | 96.48           | 23.77         | 0.7      | 0.0  | 0.0       | 24.47 | 0.0   | 0.0        | 0.0  | 24.47       |
      | 6  | 31   | 20240601      |                  | 72.57           | 23.91         | 0.56     | 0.0  | 0.0       | 24.47 | 0.0   | 0.0        | 0.0  | 24.47       |
      | 7  | 30   | 20240701      |                  | 48.52           | 24.05         | 0.42     | 0.0  | 0.0       | 24.47 | 0.0   | 0.0        | 0.0  | 24.47       |
      | 8  | 31   | 20240801    |                  | 24.33           | 24.19         | 0.28     | 0.0  | 0.0       | 24.47 | 0.0   | 0.0        | 0.0  | 24.47       |
      | 9  | 31   | 20240901 |                  |  0.0            | 24.33         | 0.14     | 0.0  | 0.0       | 24.47 | 0.0   | 0.0        | 0.0  | 24.47       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 150.0         | 3.66     | 0.0  | 0.0       | 153.66 | 31.31 | 0.0        | 0.0  | 122.35      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type   | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement       | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240201 | Repayment          | 17.01  | 16.43     | 0.58     | 0.0  | 0.0       | 83.57        | false    | false    |
      | 20240315    | Re-age             | 84.28  | 83.57     | 0.71     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240401    | Capitalized Income | 50.0   | 50.0      | 0.0      | 0.0  | 0.0       | 133.57       | false    | false    |
      | 20240401    | Repayment          | 14.3   | 13.32     | 0.98     | 0.0  | 0.0       | 120.25       | false    | false    |

    When Loan Pay-off is made on "20240401"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C4261 @AdvancedPaymentAllocation
  Scenario: Verify Loan re-aging trn with backdated CI and CI adj after re-age - interest bearing multidisb loan default behaviour - UC13
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
      | 20240315    | Re-age           | 84.28  | 83.57     | 0.71     | 0.0  | 0.0       | 0.0          | false    | false    |

    When Admin sets the business date to "20240401"
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
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type   | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement       | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240201 | Repayment          | 17.01  | 16.43     | 0.58     | 0.0  | 0.0       | 83.57        | false    | false     |
      | 20240301    | Capitalized Income | 50.0   | 50.0      | 0.0      | 0.0  | 0.0       | 133.57       | false    | false    |
      | 20240315    | Re-age             | 134.41 | 133.57    | 0.84     | 0.0  | 0.0       | 0.0          | false    | true     |

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
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type              | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement                  | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240201 | Repayment                     | 17.01  | 16.43     | 0.58     | 0.0  | 0.0       | 83.57        | false    | false    |
      | 20240301    | Capitalized Income            | 50.0   | 50.0      | 0.0      | 0.0  | 0.0       | 133.57       | false    | false    |
      | 20240315    | Re-age                        | 134.41 | 133.57    | 0.84     | 0.0  | 0.0       | 0.0          | false    | true     |
      | 20240401    | Capitalized Income Adjustment | 20.0   | 20.0      | 0.0      | 0.0  | 0.0       | 113.57       | false    | false    |

    When Loan Pay-off is made on "20240401"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C4264 @AdvancedPaymentAllocation
  Scenario: Verify Loan re-aging trn with 2nd disb and chargeback after re-age - interest bearing multidisb loan that expects tranches with default behaviour - UC16
    When Admin sets the business date to "20240101"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with disbursements details and following data:
      | LoanProduct                                                                                | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            | 1st_tranche_disb_expected_date | 1st_tranche_disb_principal | 2nd_tranche_disb_expected_date | 2nd_tranche_disb_principal |
      | LP2_ADV_PYMNT_INTEREST_DAILY_EMI_360_30_INTEREST_RECALC_DAILY_MULTIDISBURSE_EXPECT_TRANCHE | 20240101   | 150            | 7                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 6                 | MONTHS                | 1              | MONTHS                 | 6                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION | 20240101                | 100.0                      | 20240401                  | 50.0                       |
    And Admin successfully approves the loan on "20240101" with "150" amount and expected disbursement date on "20240101"
    When Admin successfully disburse the loan on "20240101" with "100" EUR transaction amount
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20240101  |           | 100.0           |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 31   | 20240201 |           | 83.57           | 16.43         | 0.58     | 0.0  | 0.0       | 17.01 | 0.0  | 0.0        | 0.0  | 17.01       |
      | 2  | 29   | 20240301    |           | 67.05           | 16.52         | 0.49     | 0.0  | 0.0       | 17.01 | 0.0  | 0.0        | 0.0  | 17.01       |
      | 3  | 31   | 20240401    |           | 50.43           | 16.62         | 0.39     | 0.0  | 0.0       | 17.01 | 0.0  | 0.0        | 0.0  | 17.01       |
      |    |      | 20240401    |           | 50.0            |               |          | 0.0  |           | 0.0   |      |            |      | 0.0         |
      | 4  | 30   | 20240501      |           | 83.71           | 16.72         | 0.29     | 0.0  | 0.0       | 17.01 | 0.0  | 0.0        | 0.0  | 17.01       |
      | 5  | 31   | 20240601     |           | 66.9            | 16.81         | 0.2      | 0.0  | 0.0       | 17.01 | 0.0  | 0.0        | 0.0  | 17.01       |
      | 6  | 30   | 20240701     |           | 50.0            | 16.9          | 0.1      | 0.0  | 0.0       | 17.0  | 0.0  | 0.0        | 0.0  | 17.0        |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 100.0         | 2.05     | 0.0  | 0.0       | 102.05 | 0.0  | 0.0        | 0.0  | 102.05      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
    Then Loan Tranche Details tab has the following data:
      | Expected Disbursement On | Disbursed On    | Principal   | Net Disbursal Amount |
      | 20240101          | 20240101 | 100.0       |                      |
      | 20240401            |                 |  50.0       |                      |

    When Admin sets the business date to "20240201"
    And Customer makes "AUTOPAY" repayment on "20240201" with 17.01 EUR transaction amount
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101  |                  | 100.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 31   | 20240201 | 20240201 | 83.57           | 16.43         | 0.58     | 0.0  | 0.0       | 17.01 | 17.01 | 0.0        | 0.0  | 0.0         |
      | 2  | 29   | 20240301    |                  | 67.05           | 16.52         | 0.49     | 0.0  | 0.0       | 17.01 | 0.0   | 0.0        | 0.0  | 17.01       |
      | 3  | 31   | 20240401    |                  | 50.43           | 16.62         | 0.39     | 0.0  | 0.0       | 17.01 | 0.0  | 0.0        | 0.0  | 17.01       |
      |    |      | 20240401    |                  | 50.0            |               |          | 0.0  |           | 0.0   |       |            |      | 0.0         |
      | 4  | 30   | 20240501      |                  | 83.71           | 16.72         | 0.29     | 0.0  | 0.0       | 17.01 | 0.0   | 0.0        | 0.0  | 17.01       |
      | 5  | 31   | 20240601     |                  | 66.9            | 16.81         | 0.2      | 0.0  | 0.0       | 17.01 | 0.0   | 0.0        | 0.0  | 17.01       |
      | 6  | 30   | 20240701     |                  | 50.0            | 16.9          | 0.1      | 0.0  | 0.0       | 17.0  | 0.0   | 0.0        | 0.0  | 17.0        |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 100.0         | 2.05     | 0.0  | 0.0       | 102.05 | 17.01 | 0.0        | 0.0  | 85.04       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240201 | Repayment        | 17.01  | 16.43     | 0.58     | 0.0  | 0.0       | 83.57        | false    | false    |

    When Admin sets the business date to "20240315"
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
      |    |      | 20240401     |                  | 50.0            |               |          | 0.0  |           | 0.0   |       |            |      | 0.0         |
      | 5  | 30   | 20240501       |                  | 106.36          | 13.89         | 0.41     | 0.0  | 0.0       | 14.3  | 0.0   | 0.0        | 0.0  | 14.3        |
      | 6  | 31   | 20240601      |                  | 92.39           | 13.97         | 0.33     | 0.0  | 0.0       | 14.3  | 0.0   | 0.0        | 0.0  | 14.3        |
      | 7  | 30   | 20240701      |                  | 78.34           | 14.05         | 0.25     | 0.0  | 0.0       | 14.3  | 0.0   | 0.0        | 0.0  | 14.3        |
      | 8  | 31   | 20240801    |                  | 64.21           | 14.13         | 0.17     | 0.0  | 0.0       | 14.3  | 0.0   | 0.0        | 0.0  | 14.3        |
      | 9  | 31   | 20240901 |                  | 50.0            | 14.21         | 0.08     | 0.0  | 0.0       | 14.29 | 0.0   | 0.0        | 0.0  | 14.29       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 100.0         | 2.8      | 0.0  | 0.0       | 102.8  | 17.01 | 0.0        | 0.0  | 85.79       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240201 | Repayment        | 17.01  | 16.43     | 0.58     | 0.0  | 0.0       | 83.57        | false    | false    |
      | 20240315    | Re-age           | 84.28  | 83.57     | 0.71     | 0.0  | 0.0       | 0.0          | false    | false    |

    When Admin sets the business date to "20240401"
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
      | 150.0         | 3.66     | 0.0  | 0.0       | 153.66 | 17.01 | 0.0        | 0.0  | 136.65      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240201 | Repayment        | 17.01  | 16.43     | 0.58     | 0.0  | 0.0       | 83.57        | false    | false    |
      | 20240315    | Re-age           | 84.28  | 83.57     | 0.71     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240401    | Disbursement     | 50.0   | 0.0       | 0.0      | 0.0  | 0.0       | 133.57       | false    | false    |
    Then Loan Tranche Details tab has the following data:
      | Expected Disbursement On | Disbursed On    | Principal   | Net Disbursal Amount |
      | 20240101          | 20240101 | 100.0       |                      |
      | 20240401            | 20240401   |  50.0       |                      |

    When Admin makes "REPAYMENT_ADJUSTMENT_CHARGEBACK" chargeback with 12 EUR transaction amount
    Then Loan Repayment schedule has 9 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101   |                  | 100.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 31   | 20240201  | 20240201 | 83.57           | 16.43         | 0.58     | 0.0  | 0.0       | 17.01 | 17.01 | 0.0        | 0.0  | 0.0         |
      | 2  | 29   | 20240301     | 20240315    | 83.57           |  0.0          | 0.0      | 0.0  | 0.0       | 0.0   | 0.0   | 0.0        | 0.0  | 0.0         |
      | 3  | 14   | 20240315     | 20240315    | 83.57           |  0.0          | 0.0      | 0.0  | 0.0       | 0.0   | 0.0   | 0.0        | 0.0  | 0.0         |
      | 4  | 17   | 20240401     |                  | 70.25           | 13.32         | 0.98     | 0.0  | 0.0       | 14.3  | 0.0   | 0.0        | 0.0  | 14.3        |
      |    |      | 20240401     |                  | 50.0            |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 5  | 30   | 20240501       |                  | 96.55           | 35.7          | 0.77     | 0.0  | 0.0       | 36.47 | 0.0   | 0.0        | 0.0  | 36.47       |
      | 6  | 31   | 20240601      |                  | 72.64           | 23.91         | 0.56     | 0.0  | 0.0       | 24.47 | 0.0   | 0.0        | 0.0  | 24.47       |
      | 7  | 30   | 20240701      |                  | 48.59           | 24.05         | 0.42     | 0.0  | 0.0       | 24.47 | 0.0   | 0.0        | 0.0  | 24.47       |
      | 8  | 31   | 20240801    |                  | 24.4            | 24.19         | 0.28     | 0.0  | 0.0       | 24.47 | 0.0   | 0.0        | 0.0  | 24.47       |
      | 9  | 31   | 20240901 |                  |  0.0            | 24.4          | 0.14     | 0.0  | 0.0       | 24.54 | 0.0   | 0.0        | 0.0  | 24.54      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 162.0         | 3.73     | 0.0  | 0.0       | 165.73 | 17.01 | 0.0        | 0.0  | 148.72      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240201 | Repayment        | 17.01  | 16.43     | 0.58     | 0.0  | 0.0       | 83.57        | false    | false    |
      | 20240315    | Re-age           | 84.28  | 83.57     | 0.71     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240401    | Disbursement     | 50.0   | 0.0       | 0.0      | 0.0  | 0.0       | 133.57       | false    | false    |
      | 20240401    | Chargeback       | 12.0   | 12.0      | 0.0      | 0.0  | 0.0       | 145.57       | false    | false    |
    When Loan Pay-off is made on "20240401"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C4272 @AdvancedPaymentAllocation
  Scenario: Verify Re-aging on interest bearing, no interest recalculation loan is not allowed (not implemented)
    When Admin sets the business date to "20240101"
    When Admin creates a client with random data
    When Admin set "LP2_ADV_PYMNT_INTEREST_DAILY_EMI_360_30_CHARGEBACK_PRINCIPAL_INTEREST_FEE" loan product "DEFAULT" transaction type to "NEXT_INSTALLMENT" future installment allocation rule
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                               | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_EMI_360_30_CHARGEBACK_PRINCIPAL_INTEREST_FEE | 20240101   | 100            | 7                       | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 6                 | MONTHS                | 1              | MONTHS                 | 6                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
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
    When Admin creates a Loan re-aging transaction by Loan external ID with the following data, but fails with 501 error code:
      | frequencyNumber | frequencyType | startDate        | numberOfInstallments |
      | 1               | MONTHS        | 20250116  | 5                    |
    When Loan Pay-off is made on "20240101"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C4274
  Scenario: Verify Re-aging with interest pause: UC2: Interest handling: DEFAULT, interest pause before re-aging
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
#    --- Check before re-age ---
    When Admin sets the business date to "20240315"
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
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240201 | Repayment        | 17.01  | 16.43     | 0.58     | 0.0  | 0.0       | 83.57        | false    | false    |
      | 20240315    | Re-age           | 83.78  | 83.57     | 0.21     | 0.0  | 0.0       | 0.0          | false    | false    |
#   --- Close loan ---
    When Loan Pay-off is made on "20240315"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

