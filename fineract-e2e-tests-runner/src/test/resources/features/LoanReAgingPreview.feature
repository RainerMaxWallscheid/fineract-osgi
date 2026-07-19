@LoanReAgingPreviewFeature
Feature: LoanReAgingPreview

  @TestRailId:C4098
  Scenario: Basic verification of the loan re-aging preview schedule
    When Admin sets the business date to "20250101"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                        | submitted on date | with Principal | ANNUAL interest rate % | interest type | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_DOWNPAYMENT_ADV_PMT_ALLOC_PROGRESSIVE_LOAN_SCHEDULE_HORIZONTAL | 20250101   | 1000           | 0                      | FLAT          | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 3                 | MONTHS                | 1              | MONTHS                 | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20250101" with "1000" amount and expected disbursement date on "20250101"
    When Admin successfully disburse the loan on "20250101" with "1000" EUR transaction amount
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20250101  |           | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 0    | 20250101  |           | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0  | 0.0        | 0.0  | 250.0       |
      | 2  | 31   | 20250201 |           | 500.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0  | 0.0        | 0.0  | 250.0       |
      | 3  | 28   | 20250301    |           | 250.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0  | 0.0        | 0.0  | 250.0       |
      | 4  | 31   | 20250401    |           | 0.0             | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0  | 0.0        | 0.0  | 250.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 1000.0        | 0.0      | 0.0  | 0.0       | 1000.0 | 0.0  | 0.0        | 0.0  | 1000.0      |
    When Admin sets the business date to "20250415"
    When Admin creates a Loan re-aging preview by Loan external ID with the following data:
      | frequencyNumber | frequencyType | startDate     | numberOfInstallments |
      | 1               | MONTHS        | 20250415 | 3                    |
    Then Loan Re-Aged Repayment schedule preview has 7 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date     | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      |    |      | 20250101  |               | 1000.0          | 0.0           | 0.0      | 0.0  | 0.0       | 0.0    | 0.0  |            |      |             |
      | 1  | 0    | 20250101  | 20250415 | 1000.0          | 0.0           | 0.0      | 0.0  | 0.0       | 0.0    | 0.0  | 0.0        | 0.0  | 0.0         |
      | 2  | 31   | 20250201 | 20250415 | 1000.0          | 0.0           | 0.0      | 0.0  | 0.0       | 0.0    | 0.0  | 0.0        | 0.0  | 0.0         |
      | 3  | 28   | 20250301    | 20250415 | 1000.0          | 0.0           | 0.0      | 0.0  | 0.0       | 0.0    | 0.0  | 0.0        | 0.0  | 0.0         |
      | 4  | 31   | 20250401    | 20250415 | 1000.0          | 0.0           | 0.0      | 0.0  | 0.0       | 0.0    | 0.0  | 0.0        | 0.0  | 0.0         |
      | 5  | 14   | 20250415    |               | 666.67          | 333.33        | 0.0      | 0.0  | 0.0       | 333.33 | 0.0  | 0.0        | 0.0  | 333.33      |
      | 6  | 30   | 20250515      |               | 333.34          | 333.33        | 0.0      | 0.0  | 0.0       | 333.33 | 0.0  | 0.0        | 0.0  | 333.33      |
      | 7  | 31   | 20250615     |               | 0.0             | 333.34        | 0.0      | 0.0  | 0.0       | 333.34 | 0.0  | 0.0        | 0.0  | 333.34      |
    Then Loan Re-Aged Repayment schedule preview has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 1000.0        | 0.0      | 0.0  | 0.0       | 1000.0 | 0.0  | 0.0        | 0.0  | 1000.0      |
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20250101  |           | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 0    | 20250101  |           | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0  | 0.0        | 0.0  | 250.0       |
      | 2  | 31   | 20250201 |           | 500.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0  | 0.0        | 0.0  | 250.0       |
      | 3  | 28   | 20250301    |           | 250.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0  | 0.0        | 0.0  | 250.0       |
      | 4  | 31   | 20250401    |           | 0.0             | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0  | 0.0        | 0.0  | 250.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 1000.0        | 0.0      | 0.0  | 0.0       | 1000.0 | 0.0  | 0.0        | 0.0  | 1000.0      |

    When Loan Pay-off is made on "20250415"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C4099
  Scenario: Verify Loan re-aging preview with chargeback
    When Admin sets the business date to "20240101"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                        | submitted on date | with Principal | ANNUAL interest rate % | interest type | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_DOWNPAYMENT_ADV_PMT_ALLOC_PROGRESSIVE_LOAN_SCHEDULE_HORIZONTAL | 20240101   | 1000           | 0                      | FLAT          | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 45                | DAYS                  | 15             | DAYS                   | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240101" with "1000" amount and expected disbursement date on "20240101"
    When Admin successfully disburse the loan on "20240101" with "1000" EUR transaction amount
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20240101  |           | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 0    | 20240101  |           | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0  | 0.0        | 0.0  | 250.0       |
      | 2  | 15   | 20240116  |           | 500.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0  | 0.0        | 0.0  | 250.0       |
      | 3  | 15   | 20240131  |           | 250.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0  | 0.0        | 0.0  | 250.0       |
      | 4  | 15   | 20240215 |           | 0.0             | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0  | 0.0        | 0.0  | 250.0       |
    When Admin sets the business date to "20240101"
    And Customer makes "AUTOPAY" repayment on "20240101" with 250 EUR transaction amount
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101  |                 | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 0    | 20240101  | 20240101 | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0  | 0.0         |
      | 2  | 15   | 20240116  |                 | 500.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0   | 0.0        | 0.0  | 250.0       |
      | 3  | 15   | 20240131  |                 | 250.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0   | 0.0        | 0.0  | 250.0       |
      | 4  | 15   | 20240215 |                 | 0.0             | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0   | 0.0        | 0.0  | 250.0       |
    When Admin sets the business date to "20240202"
    When Admin makes "REPAYMENT_ADJUSTMENT_CHARGEBACK" chargeback with 125 EUR transaction amount
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101  |                 | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 0    | 20240101  | 20240101 | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0  | 0.0         |
      | 2  | 15   | 20240116  |                 | 500.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0   | 0.0        | 0.0  | 250.0       |
      | 3  | 15   | 20240131  |                 | 250.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0   | 0.0        | 0.0  | 250.0       |
      | 4  | 15   | 20240215 |                 | 0.0             | 375.0         | 0.0      | 0.0  | 0.0       | 375.0 | 0.0   | 0.0        | 0.0  | 375.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 1125.0        | 0.0      | 0.0  | 0.0       | 1125.0 | 250.0 | 0.0        | 0.0  | 875.0       |
    When Admin sets the business date to "20240221"
    When Admin creates a Loan re-aging preview by Loan external ID with the following data:
      | frequencyNumber | frequencyType | startDate     | numberOfInstallments |
      | 2               | MONTHS        | 20240310 | 3                    |
    Then Loan Re-Aged Repayment schedule preview has 7 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101  |                  | 1000.0          | 0.0           | 0.0      | 0.0  | 0.0       | 0.0    | 0.0   |            |      |             |
      | 1  | 0    | 20240101  | 20240101  | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0  | 250.0 | 0.0        | 0.0  | 0.0         |
      | 2  | 15   | 20240116  | 20240221 | 750.0           | 0.0           | 0.0      | 0.0  | 0.0       | 0.0    | 0.0   | 0.0        | 0.0  | 0.0         |
      | 3  | 15   | 20240131  | 20240221 | 750.0           | 0.0           | 0.0      | 0.0  | 0.0       | 0.0    | 0.0   | 0.0        | 0.0  | 0.0         |
      | 4  | 15   | 20240215 | 20240221 | 875.0           | 0.0           | 0.0      | 0.0  | 0.0       | 0.0    | 0.0   | 0.0        | 0.0  | 0.0         |
      | 5  | 24   | 20240310    |                  | 583.33          | 291.67        | 0.0      | 0.0  | 0.0       | 291.67 | 0.0   | 0.0        | 0.0  | 291.67      |
      | 6  | 61   | 20240510      |                  | 291.66          | 291.67        | 0.0      | 0.0  | 0.0       | 291.67 | 0.0   | 0.0        | 0.0  | 291.67      |
      | 7  | 61   | 20240710     |                  | 0.0             | 291.66        | 0.0      | 0.0  | 0.0       | 291.66 | 0.0   | 0.0        | 0.0  | 291.66      |
    And Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101  |                 | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 0    | 20240101  | 20240101 | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0  | 0.0         |
      | 2  | 15   | 20240116  |                 | 500.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0   | 0.0        | 0.0  | 250.0       |
      | 3  | 15   | 20240131  |                 | 250.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0   | 0.0        | 0.0  | 250.0       |
      | 4  | 15   | 20240215 |                 | 0.0             | 375.0         | 0.0      | 0.0  | 0.0       | 375.0 | 0.0   | 0.0        | 0.0  | 375.0       |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 1125.0        | 0.0      | 0.0  | 0.0       | 1125.0 | 250.0 | 0.0        | 0.0  | 875.0       |

    When Loan Pay-off is made on "20240202"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C4100
  Scenario: Verify Loan re-aging preview with charge N+1 installment after maturity date
    When Admin sets the business date to "20250101"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                        | submitted on date | with Principal | ANNUAL interest rate % | interest type | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_DOWNPAYMENT_ADV_PMT_ALLOC_PROGRESSIVE_LOAN_SCHEDULE_HORIZONTAL | 20250101   | 1000           | 0                      | FLAT          | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 3                 | MONTHS                | 1              | MONTHS                 | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20250101" with "1000" amount and expected disbursement date on "20250101"
    When Admin successfully disburse the loan on "20250101" with "1000" EUR transaction amount
    When Admin sets the business date to "20250503"
    And Admin adds "LOAN_NSF_FEE" due date charge with "20250503" due date and 10 EUR transaction amount
    Then Loan Repayment schedule has 5 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20250101  |           | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 0    | 20250101  |           | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0  | 0.0        | 0.0  | 250.0       |
      | 2  | 31   | 20250201 |           | 500.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0  | 0.0        | 0.0  | 250.0       |
      | 3  | 28   | 20250301    |           | 250.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0  | 0.0        | 0.0  | 250.0       |
      | 4  | 31   | 20250401    |           | 0.0             | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0  | 0.0        | 0.0  | 250.0       |
      | 5  | 32   | 20250503      |           | 0.0             | 0.0           | 0.0      | 0.0  | 10.0      | 10.0  | 0.0  | 0.0        | 0.0  | 10.0        |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 1000.0        | 0.0      | 0.0  | 10.0      | 1010.0 | 0.0  | 0.0        | 0.0  | 1010.0      |
    When Admin creates a Loan re-aging preview by Loan external ID with the following data:
      | frequencyNumber | frequencyType | startDate     | numberOfInstallments |
      | 1               | WEEKS         | 20250401 | 1                    |
    Then Loan Re-Aged Repayment schedule preview has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date     | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      |    |      | 20250101  |               | 1000.0          | 0.0           | 0.0      | 0.0  | 0.0       | 0.0    | 0.0  |            |      |             |
      | 1  | 0    | 20250101  | 20250401 | 1000.0          | 0.0           | 0.0      | 0.0  | 0.0       | 0.0    | 0.0  | 0.0        | 0.0  | 0.0         |
      | 2  | 31   | 20250201 | 20250401 | 1000.0          | 0.0           | 0.0      | 0.0  | 0.0       | 0.0    | 0.0  | 0.0        | 0.0  | 0.0         |
      | 3  | 28   | 20250301    | 20250401 | 1000.0          | 0.0           | 0.0      | 0.0  | 0.0       | 0.0    | 0.0  | 0.0        | 0.0  | 0.0         |
      | 4  | 31   | 20250401    | 20250401 | 1000.0          | 0.0           | 0.0      | 0.0  | 0.0       | 0.0    | 0.0  | 0.0        | 0.0  | 0.0         |
      | 5  | 0    | 20250401    |               | 0.0             | 1000.0        | 0.0      | 0.0  | 0.0       | 1000.0 | 0.0  | 0.0        | 0.0  | 1000.0      |
      | 6  | 32   | 20250503      |               | 0.0             | 0.0           | 0.0      | 0.0  | 10.0      | 10.0   | 0.0  | 0.0        | 0.0  | 10.0        |
    And Loan Re-Aged Repayment schedule preview has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 1000.0        | 0.0      | 0.0  | 10.0      | 1010.0 | 0.0  | 0.0        | 0.0  | 1010.0      |
    And Loan Repayment schedule has 5 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20250101  |           | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 0    | 20250101  |           | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0  | 0.0        | 0.0  | 250.0       |
      | 2  | 31   | 20250201 |           | 500.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0  | 0.0        | 0.0  | 250.0       |
      | 3  | 28   | 20250301    |           | 250.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0  | 0.0        | 0.0  | 250.0       |
      | 4  | 31   | 20250401    |           | 0.0             | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0  | 0.0        | 0.0  | 250.0       |
      | 5  | 32   | 20250503      |           | 0.0             | 0.0           | 0.0      | 0.0  | 10.0      | 10.0  | 0.0  | 0.0        | 0.0  | 10.0        |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 1000.0        | 0.0      | 0.0  | 10.0      | 1010.0 | 0.0  | 0.0        | 0.0  | 1010.0      |

    When Loan Pay-off is made on "20250503"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C4101
  Scenario: Verify Loan re-aging preview with backdated repayment, charge and N+1 installment after maturity date
    When Admin sets the business date to "20250101"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                        | submitted on date | with Principal | ANNUAL interest rate % | interest type | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_DOWNPAYMENT_ADV_PMT_ALLOC_PROGRESSIVE_LOAN_SCHEDULE_HORIZONTAL | 20250101   | 1000           | 0                      | FLAT          | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 3                 | MONTHS                | 1              | MONTHS                 | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20250101" with "1000" amount and expected disbursement date on "20250101"
    When Admin successfully disburse the loan on "20250101" with "1000" EUR transaction amount
    When Admin sets the business date to "20250503"
    And Customer makes "AUTOPAY" repayment on "20250301" with 250 EUR transaction amount
    And Admin adds "LOAN_NSF_FEE" due date charge with "20250503" due date and 10 EUR transaction amount
    Then Loan Repayment schedule has 5 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date     | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late  | Outstanding |
      |    |      | 20250101  |               | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |       |             |
      | 1  | 0    | 20250101  | 20250301 | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 250.0 | 0.0         |
      | 2  | 31   | 20250201 |               | 500.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0   | 0.0        | 0.0   | 250.0       |
      | 3  | 28   | 20250301    |               | 250.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0   | 0.0        | 0.0   | 250.0       |
      | 4  | 31   | 20250401    |               | 0.0             | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0   | 0.0        | 0.0   | 250.0       |
      | 5  | 32   | 20250503      |               | 0.0             | 0.0           | 0.0      | 0.0  | 10.0      | 10.0  | 0.0   | 0.0        | 0.0   | 10.0        |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late  | Outstanding |
      | 1000.0        | 0.0      | 0.0  | 10.0      | 1010.0 | 250.0 | 0.0        | 250.0 | 760.0       |
    When Admin creates a Loan re-aging preview by Loan external ID with the following data:
      | frequencyNumber | frequencyType | startDate     | numberOfInstallments |
      | 1               | WEEKS         | 20250401 | 1                    |
    Then Loan Re-Aged Repayment schedule preview has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date     | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late  | Outstanding |
      |    |      | 20250101  |               | 1000.0          | 0.0           | 0.0      | 0.0  | 0.0       | 0.0   | 0.0   |            |       |             |
      | 1  | 0    | 20250101  | 20250301 | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 250.0 | 0.0         |
      | 2  | 31   | 20250201 | 20250401 | 750.0           | 0.0           | 0.0      | 0.0  | 0.0       | 0.0   | 0.0   | 0.0        | 0.0   | 0.0         |
      | 3  | 28   | 20250301    | 20250401 | 750.0           | 0.0           | 0.0      | 0.0  | 0.0       | 0.0   | 0.0   | 0.0        | 0.0   | 0.0         |
      | 4  | 31   | 20250401    | 20250401 | 750.0           | 0.0           | 0.0      | 0.0  | 0.0       | 0.0   | 0.0   | 0.0        | 0.0   | 0.0         |
      | 5  | 0    | 20250401    |               | 0.0             | 750.0         | 0.0      | 0.0  | 0.0       | 750.0 | 0.0   | 0.0        | 0.0   | 750.0       |
      | 6  | 32   | 20250503      |               | 0.0             | 0.0           | 0.0      | 0.0  | 10.0      | 10.0  | 0.0   | 0.0        | 0.0   | 10.0        |
    And Loan Re-Aged Repayment schedule preview has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late  | Outstanding |
      | 1000.0        | 0.0      | 0.0  | 10.0      | 1010.0 | 250.0 | 0.0        | 250.0 | 760.0       |
    And Loan Repayment schedule has 5 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date     | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late  | Outstanding |
      |    |      | 20250101  |               | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |       |             |
      | 1  | 0    | 20250101  | 20250301 | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 250.0 | 0.0         |
      | 2  | 31   | 20250201 |               | 500.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0   | 0.0        | 0.0   | 250.0       |
      | 3  | 28   | 20250301    |               | 250.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0   | 0.0        | 0.0   | 250.0       |
      | 4  | 31   | 20250401    |               | 0.0             | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0   | 0.0        | 0.0   | 250.0       |
      | 5  | 32   | 20250503      |               | 0.0             | 0.0           | 0.0      | 0.0  | 10.0      | 10.0  | 0.0   | 0.0        | 0.0   | 10.0        |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late  | Outstanding |
      | 1000.0        | 0.0      | 0.0  | 10.0      | 1010.0 | 250.0 | 0.0        | 250.0 | 760.0       |

    When Loan Pay-off is made on "20250503"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C4102
  Scenario: Verify Loan re-aging preview with downpayment, payoff and charge - N+1 installment after maturity date
    When Admin sets the business date to "20250101"
    When Admin creates a client with random data
    When Admin set "LP2_DOWNPAYMENT_AUTO_ADVANCED_PAYMENT_ALLOCATION" loan product "DEFAULT" transaction type to "NEXT_INSTALLMENT" future installment allocation rule
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                      | submitted on date | with Principal | ANNUAL interest rate % | interest type | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_DOWNPAYMENT_AUTO_ADVANCED_PAYMENT_ALLOCATION | 20250101   | 1000           | 0                      | FLAT          | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 45                | DAYS                  | 15             | DAYS                   | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20250101" with "1000" amount and expected disbursement date on "20250101"
    When Admin successfully disburse the loan on "20250101" with "1000" EUR transaction amount
    When Admin sets the business date to "20250320"
    When Loan Pay-off is made on "20250320"
    And Admin adds "LOAN_NSF_FEE" due date charge with "20250320" due date and 10 EUR transaction amount
    Then Loan Repayment schedule has 5 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late  | Outstanding |
      |    |      | 20250101  |                 | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |       |             |
      | 1  | 0    | 20250101  | 20250101 | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0   | 0.0         |
      | 2  | 15   | 20250116  | 20250320   | 500.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 250.0 | 0.0         |
      | 3  | 15   | 20250131  | 20250320   | 250.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 250.0 | 0.0         |
      | 4  | 15   | 20250215 | 20250320   | 0.0             | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 250.0 | 0.0         |
      | 5  | 33   | 20250320    |                 | 0.0             | 0.0           | 0.0      | 0.0  | 10.0      | 10.0  | 0.0   | 0.0        | 0.0   | 10.0        |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late  | Outstanding |
      | 1000.0        | 0.0      | 0.0  | 10.0      | 1010.0 | 1000.0 | 0.0        | 750.0 | 10.0        |
    When Admin creates a Loan re-aging preview by Loan external ID with the following data:
      | frequencyNumber | frequencyType | startDate        | numberOfInstallments |
      | 1               | WEEKS         | 20250215 | 1                    |
    Then Loan Re-Aged Repayment schedule preview has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late  | Outstanding |
      |    |      | 20250101  |                  | 1000.0          | 0.0           | 0.0      | 0.0  | 0.0       | 0.0   | 0.0   |            |       |             |
      | 1  | 0    | 20250101  | 20250101  | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0   | 0.0         |
      | 2  | 15   | 20250116  | 20250215 | 750.0           | 0.0           | 0.0      | 0.0  | 0.0       | 0.0   | 0.0   | 0.0        | 0.0   | 0.0         |
      | 3  | 15   | 20250131  | 20250215 | 750.0           | 0.0           | 0.0      | 0.0  | 0.0       | 0.0   | 0.0   | 0.0        | 0.0   | 0.0         |
      | 4  | 15   | 20250215 | 20250215 | 750.0           | 0.0           | 0.0      | 0.0  | 0.0       | 0.0   | 0.0   | 0.0        | 0.0   | 0.0         |
      | 5  | 0    | 20250215 | 20250320    | 0.0             | 750.0         | 0.0      | 0.0  | 0.0       | 750.0 | 750.0 | 0.0        | 750.0 | 0.0         |
      | 6  | 33   | 20250320    |                  | 0.0             | 0.0           | 0.0      | 0.0  | 10.0      | 10.0  | 0.0   | 0.0        | 0.0   | 10.0        |
    And Loan Re-Aged Repayment schedule preview has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late  | Outstanding |
      | 1000.0        | 0.0      | 0.0  | 10.0      | 1010.0 | 1000.0 | 0.0        | 750.0 | 10.0        |
    And Loan Repayment schedule has 5 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late  | Outstanding |
      |    |      | 20250101  |                 | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |       |             |
      | 1  | 0    | 20250101  | 20250101 | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0   | 0.0         |
      | 2  | 15   | 20250116  | 20250320   | 500.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 250.0 | 0.0         |
      | 3  | 15   | 20250131  | 20250320   | 250.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 250.0 | 0.0         |
      | 4  | 15   | 20250215 | 20250320   | 0.0             | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 250.0 | 0.0         |
      | 5  | 33   | 20250320    |                 | 0.0             | 0.0           | 0.0      | 0.0  | 10.0      | 10.0  | 0.0   | 0.0        | 0.0   | 10.0        |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late  | Outstanding |
      | 1000.0        | 0.0      | 0.0  | 10.0      | 1010.0 | 1000.0 | 0.0        | 750.0 | 10.0        |

    When Loan Pay-off is made on "20250320"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C4103
  Scenario: Verify that Loan re-aging preview with repayment, chargeback and charge - N+1 installment after maturity date
    When Admin sets the business date to "20250101"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                        | submitted on date | with Principal | ANNUAL interest rate % | interest type | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_DOWNPAYMENT_ADV_PMT_ALLOC_PROGRESSIVE_LOAN_SCHEDULE_HORIZONTAL | 20250101   | 1000           | 0                      | FLAT          | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 3                 | MONTHS                | 1              | MONTHS                 | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20250101" with "1000" amount and expected disbursement date on "20250101"
    When Admin successfully disburse the loan on "20250101" with "1000" EUR transaction amount
    When Admin sets the business date to "20250503"
    And Customer makes "AUTOPAY" repayment on "20250301" with 250 EUR transaction amount
    When Admin makes "REPAYMENT_ADJUSTMENT_CHARGEBACK" chargeback with 125 EUR transaction amount
    And Admin adds "LOAN_NSF_FEE" due date charge with "20250503" due date and 10 EUR transaction amount
    Then Loan Repayment schedule has 5 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date     | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late  | Outstanding |
      |    |      | 20250101  |               | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |       |             |
      | 1  | 0    | 20250101  | 20250301 | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 250.0 | 0.0         |
      | 2  | 31   | 20250201 |               | 500.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0   | 0.0        | 0.0   | 250.0       |
      | 3  | 28   | 20250301    |               | 250.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0   | 0.0        | 0.0   | 250.0       |
      | 4  | 31   | 20250401    |               | 0.0             | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0   | 0.0        | 0.0   | 250.0       |
      | 5  | 32   | 20250503      |               | 0.0             | 125.0         | 0.0      | 0.0  | 10.0      | 135.0 | 0.0   | 0.0        | 0.0   | 135.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late  | Outstanding |
      | 1125.0        | 0.0      | 0.0  | 10.0      | 1135.0 | 250.0 | 0.0        | 250.0 | 885.0       |
    When Admin creates a Loan re-aging preview by Loan external ID with the following data:
      | frequencyNumber | frequencyType | startDate     | numberOfInstallments |
      | 1               | WEEKS         | 20250401 | 1                    |
    Then Loan Re-Aged Repayment schedule preview has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date     | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late  | Outstanding |
      |    |      | 20250101  |               | 1000.0          | 0.0           | 0.0      | 0.0  | 0.0       | 0.0   | 0.0   |            |       |             |
      | 1  | 0    | 20250101  | 20250301 | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 250.0 | 0.0         |
      | 2  | 31   | 20250201 | 20250401 | 750.0           | 0.0           | 0.0      | 0.0  | 0.0       | 0.0   | 0.0   | 0.0        | 0.0   | 0.0         |
      | 3  | 28   | 20250301    | 20250401 | 750.0           | 0.0           | 0.0      | 0.0  | 0.0       | 0.0   | 0.0   | 0.0        | 0.0   | 0.0         |
      | 4  | 31   | 20250401    | 20250401 | 750.0           | 0.0           | 0.0      | 0.0  | 0.0       | 0.0   | 0.0   | 0.0        | 0.0   | 0.0         |
      | 5  | 0    | 20250401    |               | 0.0             | 750.0         | 0.0      | 0.0  | 0.0       | 750.0 | 0.0   | 0.0        | 0.0   | 750.0       |
      | 6  | 32   | 20250503      |               | 0.0             | 125.0         | 0.0      | 0.0  | 10.0      | 135.0 | 0.0   | 0.0        | 0.0   | 135.0       |
    And Loan Re-Aged Repayment schedule preview has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late  | Outstanding |
      | 1125.0        | 0.0      | 0.0  | 10.0      | 1135.0 | 250.0 | 0.0        | 250.0 | 885.0       |
    And Loan Repayment schedule has 5 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date     | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late  | Outstanding |
      |    |      | 20250101  |               | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |       |             |
      | 1  | 0    | 20250101  | 20250301 | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 250.0 | 0.0         |
      | 2  | 31   | 20250201 |               | 500.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0   | 0.0        | 0.0   | 250.0       |
      | 3  | 28   | 20250301    |               | 250.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0   | 0.0        | 0.0   | 250.0       |
      | 4  | 31   | 20250401    |               | 0.0             | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0   | 0.0        | 0.0   | 250.0       |
      | 5  | 32   | 20250503      |               | 0.0             | 125.0         | 0.0      | 0.0  | 10.0      | 135.0 | 0.0   | 0.0        | 0.0   | 135.0       |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late  | Outstanding |
      | 1125.0        | 0.0      | 0.0  | 10.0      | 1135.0 | 250.0 | 0.0        | 250.0 | 885.0       |

    When Loan Pay-off is made on "20250503"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C4104
  Scenario: Verify that Loan re-aging preview with repayment, charge and charge adjustment - N+1 installment after maturity date
    When Admin sets the business date to "20250101"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                        | submitted on date | with Principal | ANNUAL interest rate % | interest type | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_DOWNPAYMENT_ADV_PMT_ALLOC_PROGRESSIVE_LOAN_SCHEDULE_HORIZONTAL | 20250101   | 1000           | 0                      | FLAT          | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 3                 | MONTHS                | 1              | MONTHS                 | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20250101" with "1000" amount and expected disbursement date on "20250101"
    When Admin successfully disburse the loan on "20250101" with "1000" EUR transaction amount
    When Admin sets the business date to "20250503"
    And Customer makes "AUTOPAY" repayment on "20250301" with 250 EUR transaction amount
    And Admin adds "LOAN_NSF_FEE" due date charge with "20250503" due date and 20 EUR transaction amount
    When Admin sets the business date to "20250504"
    When Admin makes a charge adjustment for the last "LOAN_NSF_FEE" type charge which is due on "20250503" with 20 EUR transaction amount and externalId ""
    Then Loan Repayment schedule has 5 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date     | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late  | Outstanding |
      |    |      | 20250101  |               | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |       |             |
      | 1  | 0    | 20250101  | 20250301 | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 250.0 | 0.0         |
      | 2  | 31   | 20250201 |               | 500.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 20.0  | 0.0        | 20.0  | 230.0       |
      | 3  | 28   | 20250301    |               | 250.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0   | 0.0        | 0.0   | 250.0       |
      | 4  | 31   | 20250401    |               | 0.0             | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0   | 0.0        | 0.0   | 250.0       |
      | 5  | 32   | 20250503      |               | 0.0             | 0.0           | 0.0      | 0.0  | 20.0      | 20.0  | 0.0   | 0.0        | 0.0   | 20.0        |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late  | Outstanding |
      | 1000.0        | 0.0      | 0.0  | 20.0      | 1020.0 | 270.0 | 0.0        | 270.0 | 750.0       |
    When Admin creates a Loan re-aging preview by Loan external ID with the following data:
      | frequencyNumber | frequencyType | startDate     | numberOfInstallments |
      | 1               | WEEKS         | 20250401 | 1                    |
    Then Loan Re-Aged Repayment schedule preview has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date     | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late  | Outstanding |
      |    |      | 20250101  |               | 1000.0          | 0.0           | 0.0      | 0.0  | 0.0       | 0.0   | 0.0   |            |       |             |
      | 1  | 0    | 20250101  | 20250301 | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 250.0 | 0.0         |
      | 2  | 31   | 20250201 | 20250401 | 750.0           | 0.0           | 0.0      | 0.0  | 0.0       | 0.0   | 0.0   | 0.0        | 0.0   | 0.0         |
      | 3  | 28   | 20250301    | 20250401 | 750.0           | 0.0           | 0.0      | 0.0  | 0.0       | 0.0   | 0.0   | 0.0        | 0.0   | 0.0         |
      | 4  | 31   | 20250401    | 20250401 | 750.0           | 0.0           | 0.0      | 0.0  | 0.0       | 0.0   | 0.0   | 0.0        | 0.0   | 0.0         |
      | 5  | 0    | 20250401    |               | 0.0             | 750.0         | 0.0      | 0.0  | 0.0       | 750.0 | 20.0  | 0.0        | 20.0  | 730.0       |
      | 6  | 32   | 20250503      |               | 0.0             | 0.0           | 0.0      | 0.0  | 20.0      | 20.0  | 0.0   | 0.0        | 0.0   | 20.0        |
    Then Loan Re-Aged Repayment schedule preview has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late  | Outstanding |
      | 1000.0        | 0.0      | 0.0  | 20.0      | 1020.0 | 270.0 | 0.0        | 270.0 | 750.0       |
    And Loan Repayment schedule has 5 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date     | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late  | Outstanding |
      |    |      | 20250101  |               | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |       |             |
      | 1  | 0    | 20250101  | 20250301 | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 250.0 | 0.0         |
      | 2  | 31   | 20250201 |               | 500.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 20.0  | 0.0        | 20.0  | 230.0       |
      | 3  | 28   | 20250301    |               | 250.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0   | 0.0        | 0.0   | 250.0       |
      | 4  | 31   | 20250401    |               | 0.0             | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0   | 0.0        | 0.0   | 250.0       |
      | 5  | 32   | 20250503      |               | 0.0             | 0.0           | 0.0      | 0.0  | 20.0      | 20.0  | 0.0   | 0.0        | 0.0   | 20.0        |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late  | Outstanding |
      | 1000.0        | 0.0      | 0.0  | 20.0      | 1020.0 | 270.0 | 0.0        | 270.0 | 750.0       |

    When Loan Pay-off is made on "20250504"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C4105
  Scenario: Verify that Loan re-aging transaction with MIR and charge - N+1 installment after maturity date
    When Admin sets the business date to "20250101"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                        | submitted on date | with Principal | ANNUAL interest rate % | interest type | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_DOWNPAYMENT_ADV_PMT_ALLOC_PROGRESSIVE_LOAN_SCHEDULE_HORIZONTAL | 20250101   | 1000           | 0                      | FLAT          | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 3                 | MONTHS                | 1              | MONTHS                 | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20250101" with "1000" amount and expected disbursement date on "20250101"
    And Admin successfully disburse the loan on "20250101" with "1000" EUR transaction amount
    And Admin sets the business date to "20250503"
    And Admin makes "MERCHANT_ISSUED_REFUND" transaction with "AUTOPAY" payment type on "20250401" with 100 EUR transaction amount
    And Admin adds "LOAN_NSF_FEE" due date charge with "20250503" due date and 20 EUR transaction amount
    Then Loan Repayment schedule has 5 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late  | Outstanding |
      |    |      | 20250101  |           | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |       |             |
      | 1  | 0    | 20250101  |           | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 100.0 | 0.0        | 100.0 | 150.0       |
      | 2  | 31   | 20250201 |           | 500.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0   | 0.0        | 0.0   | 250.0       |
      | 3  | 28   | 20250301    |           | 250.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0   | 0.0        | 0.0   | 250.0       |
      | 4  | 31   | 20250401    |           | 0.0             | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0   | 0.0        | 0.0   | 250.0       |
      | 5  | 32   | 20250503      |           | 0.0             | 0.0           | 0.0      | 0.0  | 20.0      | 20.0  | 0.0   | 0.0        | 0.0   | 20.0        |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late  | Outstanding |
      | 1000.0        | 0.0      | 0.0  | 20.0      | 1020.0 | 100.0 | 0.0        | 100.0 | 920.0       |
    When Admin creates a Loan re-aging preview by Loan external ID with the following data:
      | frequencyNumber | frequencyType | startDate     | numberOfInstallments |
      | 1               | WEEKS         | 20250401 | 1                    |
    Then Loan Re-Aged Repayment schedule preview has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date     | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late  | Outstanding |
      |    |      | 20250101  |               | 1000.0          | 0.0           | 0.0      | 0.0  | 0.0       | 0.0   | 0.0   |            |       |             |
      | 1  | 0    | 20250101  | 20250401 | 900.0           | 100.0         | 0.0      | 0.0  | 0.0       | 100.0 | 100.0 | 0.0        | 100.0 | 0.0         |
      | 2  | 31   | 20250201 | 20250401 | 900.0           | 0.0           | 0.0      | 0.0  | 0.0       | 0.0   | 0.0   | 0.0        | 0.0   | 0.0         |
      | 3  | 28   | 20250301    | 20250401 | 900.0           | 0.0           | 0.0      | 0.0  | 0.0       | 0.0   | 0.0   | 0.0        | 0.0   | 0.0         |
      | 4  | 31   | 20250401    | 20250401 | 900.0           | 0.0           | 0.0      | 0.0  | 0.0       | 0.0   | 0.0   | 0.0        | 0.0   | 0.0         |
      | 5  | 0    | 20250401    |               | 0.0             | 900.0         | 0.0      | 0.0  | 0.0       | 900.0 | 0.0   | 0.0        | 0.0   | 900.0       |
      | 6  | 32   | 20250503      |               | 0.0             | 0.0           | 0.0      | 0.0  | 20.0      | 20.0  | 0.0   | 0.0        | 0.0   | 20.0        |
    And Loan Re-Aged Repayment schedule preview has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late  | Outstanding |
      | 1000.0        | 0.0      | 0.0  | 20.0      | 1020.0 | 100.0 | 0.0        | 100.0 | 920.0       |
    And Loan Repayment schedule has 5 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late  | Outstanding |
      |    |      | 20250101  |           | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |       |             |
      | 1  | 0    | 20250101  |           | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 100.0 | 0.0        | 100.0 | 150.0       |
      | 2  | 31   | 20250201 |           | 500.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0   | 0.0        | 0.0   | 250.0       |
      | 3  | 28   | 20250301    |           | 250.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0   | 0.0        | 0.0   | 250.0       |
      | 4  | 31   | 20250401    |           | 0.0             | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0   | 0.0        | 0.0   | 250.0       |
      | 5  | 32   | 20250503      |           | 0.0             | 0.0           | 0.0      | 0.0  | 20.0      | 20.0  | 0.0   | 0.0        | 0.0   | 20.0        |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late  | Outstanding |
      | 1000.0        | 0.0      | 0.0  | 20.0      | 1020.0 | 100.0 | 0.0        | 100.0 | 920.0       |

    When Loan Pay-off is made on "20250503"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C4106
  Scenario: Verify that Loan re-aging preview with 2nd disbursement and charge - N+1 installment after maturity date
    When Admin sets the business date to "20250101"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                        | submitted on date | with Principal | ANNUAL interest rate % | interest type | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_DOWNPAYMENT_ADV_PMT_ALLOC_PROGRESSIVE_LOAN_SCHEDULE_HORIZONTAL | 20250101   | 1000           | 0                      | FLAT          | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 3                 | MONTHS                | 1              | MONTHS                 | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20250101" with "500" amount and expected disbursement date on "20250101"
    And Admin successfully disburse the loan on "20250101" with "500" EUR transaction amount
    And Admin sets the business date to "20250501"
    And Admin successfully disburse the loan on "20250116" with "100" EUR transaction amount
    And Admin adds "LOAN_NSF_FEE" due date charge with "20250501" due date and 20 EUR transaction amount
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20250101  |           | 500.0           |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 0    | 20250101  |           | 375.0           | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 0.0  | 0.0        | 0.0  | 125.0       |
      |    |      | 20250116  |           | 100.0           |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 2  | 0    | 20250116  |           | 450.0           | 25.0          | 0.0      | 0.0  | 0.0       | 25.0  | 0.0  | 0.0        | 0.0  | 25.0        |
      | 3  | 31   | 20250201 |           | 300.0           | 150.0         | 0.0      | 0.0  | 0.0       | 150.0 | 0.0  | 0.0        | 0.0  | 150.0       |
      | 4  | 28   | 20250301    |           | 150.0           | 150.0         | 0.0      | 0.0  | 0.0       | 150.0 | 0.0  | 0.0        | 0.0  | 150.0       |
      | 5  | 31   | 20250401    |           | 0.0             | 150.0         | 0.0      | 0.0  | 0.0       | 150.0 | 0.0  | 0.0        | 0.0  | 150.0       |
      | 6  | 30   | 20250501      |           | 0.0             | 0.0           | 0.0      | 0.0  | 20.0      | 20.0  | 0.0  | 0.0        | 0.0  | 20.0        |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      | 600.0         | 0.0      | 0.0  | 20.0      | 620.0 | 0.0  | 0.0        | 0.0  | 620.0       |
    When Admin creates a Loan re-aging preview by Loan external ID with the following data:
      | frequencyNumber | frequencyType | startDate     | numberOfInstallments |
      | 1               | WEEKS         | 20250401 | 1                    |
    Then Loan Re-Aged Repayment schedule preview has 7 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date     | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20250101  |               | 500.0           | 0.0           | 0.0      | 0.0  | 0.0       | 0.0   | 0.0  |            |      |             |
      | 1  | 0    | 20250101  | 20250401 | 500.0           | 0.0           | 0.0      | 0.0  | 0.0       | 0.0   | 0.0  | 0.0        | 0.0  | 0.0         |
      |    |      | 20250116  |               | 100.0           | 0.0           | 0.0      | 0.0  | 0.0       | 0.0   | 0.0  |            |      |             |
      | 2  | 0    | 20250116  | 20250401 | 600.0           | 0.0           | 0.0      | 0.0  | 0.0       | 0.0   | 0.0  | 0.0        | 0.0  | 0.0         |
      | 3  | 16   | 20250201 | 20250401 | 600.0           | 0.0           | 0.0      | 0.0  | 0.0       | 0.0   | 0.0  | 0.0        | 0.0  | 0.0         |
      | 4  | 28   | 20250301    | 20250401 | 600.0           | 0.0           | 0.0      | 0.0  | 0.0       | 0.0   | 0.0  | 0.0        | 0.0  | 0.0         |
      | 5  | 31   | 20250401    | 20250401 | 600.0           | 0.0           | 0.0      | 0.0  | 0.0       | 0.0   | 0.0  | 0.0        | 0.0  | 0.0         |
      | 6  | 0    | 20250401    |               | 0.0             | 600.0         | 0.0      | 0.0  | 0.0       | 600.0 | 0.0  | 0.0        | 0.0  | 600.0       |
      | 7  | 30   | 20250501      |               | 0.0             | 0.0           | 0.0      | 0.0  | 20.0      | 20.0  | 0.0  | 0.0        | 0.0  | 20.0        |
    Then Loan Re-Aged Repayment schedule preview has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      | 600.0         | 0.0      | 0.0  | 20.0      | 620.0 | 0.0  | 0.0        | 0.0  | 620.0       |
    And Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20250101  |           | 500.0           |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 0    | 20250101  |           | 375.0           | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 0.0  | 0.0        | 0.0  | 125.0       |
      |    |      | 20250116  |           | 100.0           |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 2  | 0    | 20250116  |           | 450.0           | 25.0          | 0.0      | 0.0  | 0.0       | 25.0  | 0.0  | 0.0        | 0.0  | 25.0        |
      | 3  | 31   | 20250201 |           | 300.0           | 150.0         | 0.0      | 0.0  | 0.0       | 150.0 | 0.0  | 0.0        | 0.0  | 150.0       |
      | 4  | 28   | 20250301    |           | 150.0           | 150.0         | 0.0      | 0.0  | 0.0       | 150.0 | 0.0  | 0.0        | 0.0  | 150.0       |
      | 5  | 31   | 20250401    |           | 0.0             | 150.0         | 0.0      | 0.0  | 0.0       | 150.0 | 0.0  | 0.0        | 0.0  | 150.0       |
      | 6  | 30   | 20250501      |           | 0.0             | 0.0           | 0.0      | 0.0  | 20.0      | 20.0  | 0.0  | 0.0        | 0.0  | 20.0        |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      | 600.0         | 0.0      | 0.0  | 20.0      | 620.0 | 0.0  | 0.0        | 0.0  | 620.0       |

    When Loan Pay-off is made on "20250501"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C4209 @AdvancedPaymentAllocation
  Scenario: Verify Re-aging preview on interest bearing loan - Interest calculation: Default Behavior - Interest Split scenario - UC1
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
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    |
      | 20240201 | Repayment        | 17.01  | 16.43     | 0.58     | 0.0  | 0.0       | 83.57        | false    |
    When Admin sets the business date to "20240315"
    When Admin creates a Loan re-aging preview by Loan external ID with the following data:
      | frequencyNumber | frequencyType | startDate    | numberOfInstallments |
      | 1               | MONTHS        | 20240401| 6                    |
    Then Loan Re-Aged Repayment schedule preview has 9 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101  |                  | 100.0           | 0.0           | 0.0      | 0.0  | 0.0       | 0.0   | 0.0   |            |      |             |
      | 1  | 31   | 20240201 | 20240201 | 83.57           | 16.43         | 0.58     | 0.0  | 0.0       | 17.01 | 17.01 | 0.0        | 0.0  | 0.0         |
      | 2  | 29   | 20240301    | 20240315    | 83.57           | 0.0           | 0.0      | 0.0  | 0.0       | 0.0   | 0.0   | 0.0        | 0.0  | 0.0         |
      | 3  | 14   | 20240315    | 20240315    | 83.57           | 0.0           | 0.0      | 0.0  | 0.0       | 0.0   | 0.0   | 0.0        | 0.0  | 0.0         |
      | 4  | 17   | 20240401    |                  | 70.25           | 13.32         | 0.98     | 0.0  | 0.0       | 14.3  | 0.0   | 0.0        | 0.0  | 14.3        |
      | 5  | 30   | 20240501      |                  | 56.36           | 13.89         | 0.41     | 0.0  | 0.0       | 14.3  | 0.0   | 0.0        | 0.0  | 14.3        |
      | 6  | 31   | 20240601     |                  | 42.39           | 13.97         | 0.33     | 0.0  | 0.0       | 14.3  | 0.0   | 0.0        | 0.0  | 14.3        |
      | 7  | 30   | 20240701     |                  | 28.34           | 14.05         | 0.25     | 0.0  | 0.0       | 14.3  | 0.0   | 0.0        | 0.0  | 14.3        |
      | 8  | 31   | 20240801   |                  | 14.21           | 14.13         | 0.17     | 0.0  | 0.0       | 14.3  | 0.0   | 0.0        | 0.0  | 14.3        |
      | 9  | 31   | 20240901|                  | 0.0             | 14.21         | 0.08     | 0.0  | 0.0       | 14.29 | 0.0   | 0.0        | 0.0  | 14.29       |
    Then Loan Re-Aged Repayment schedule preview has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      | 100.0         | 2.8      | 0.0  | 0.0       | 102.8 | 17.01 | 0.0        | 0.0  | 85.79       |

    When Loan Pay-off is made on "20240315"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C4210 @AdvancedPaymentAllocation
  Scenario: Verify Re-aging preview on interest bearing loan - Interest calculation: Default Behavior - Fees and Interest Split before re-aging - UC2
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
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    |
      | 20240201 | Repayment        | 17.01  | 16.43     | 0.58     | 0.0  | 0.0       | 83.57        | false    |
    And Loan Charges tab has the following data:
      | Name       | isPenalty | Payment due at     | Due as of        | Calculation type | Due  | Paid | Waived | Outstanding |
      | Snooze fee | false     | Specified due date | 20240215 | Flat             | 10.0 | 0.0  | 0.0    | 10.0        |
    When Admin sets the business date to "20240315"
    When Admin creates a Loan re-aging preview by Loan external ID with the following data:
      | frequencyNumber | frequencyType | startDate    | numberOfInstallments |
      | 1               | MONTHS        | 20240401| 6                    |
    Then Loan Re-Aged Repayment schedule preview has 9 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101  |                  | 100.0           | 0.0           | 0.0      | 0.0  | 0.0       | 0.0   | 0.0   |            |      |             |
      | 1  | 31   | 20240201 | 20240201 | 83.57           | 16.43         | 0.58     | 0.0  | 0.0       | 17.01 | 17.01 | 0.0        | 0.0  | 0.0         |
      | 2  | 29   | 20240301    |                  | 83.57           | 0.0           | 0.0      | 10.0 | 0.0       | 10.0  | 0.0   | 0.0        | 0.0  | 10.0        |
      | 3  | 14   | 20240315    | 20240315    | 83.57           | 0.0           | 0.0      | 0.0  | 0.0       | 0.0   | 0.0   | 0.0        | 0.0  | 0.0         |
      | 4  | 17   | 20240401    |                  | 70.25           | 13.32         | 0.98     | 0.0  | 0.0       | 14.3  | 0.0   | 0.0        | 0.0  | 14.3        |
      | 5  | 30   | 20240501      |                  | 56.36           | 13.89         | 0.41     | 0.0  | 0.0       | 14.3  | 0.0   | 0.0        | 0.0  | 14.3        |
      | 6  | 31   | 20240601     |                  | 42.39           | 13.97         | 0.33     | 0.0  | 0.0       | 14.3  | 0.0   | 0.0        | 0.0  | 14.3        |
      | 7  | 30   | 20240701     |                  | 28.34           | 14.05         | 0.25     | 0.0  | 0.0       | 14.3  | 0.0   | 0.0        | 0.0  | 14.3        |
      | 8  | 31   | 20240801   |                  | 14.21           | 14.13         | 0.17     | 0.0  | 0.0       | 14.3  | 0.0   | 0.0        | 0.0  | 14.3        |
      | 9  | 31   | 20240901|                  | 0.0             | 14.21         | 0.08     | 0.0  | 0.0       | 14.29 | 0.0   | 0.0        | 0.0  | 14.29       |
    Then Loan Re-Aged Repayment schedule preview has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      | 100.0         | 2.8      | 10.0 | 0.0       | 112.8 | 17.01 | 0.0        | 0.0  | 95.79       |

    When Loan Pay-off is made on "20240315"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C4211 @AdvancedPaymentAllocation
  Scenario: Verify allowing Re-aging preview on interest bearing loan - Interest calculation: Default Behavior - N+1 Scenario - UC4
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
    When Admin creates a Loan re-aging preview by Loan external ID with the following data:
      | frequencyNumber | frequencyType | startDate    | numberOfInstallments |
      | 1               | MONTHS        | 20240401| 6                    |
    Then Loan Re-Aged Repayment schedule preview has 9 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101  |                  | 100.0           | 0.0           | 0.0      | 0.0  | 0.0       | 0.0   | 0.0   |            |      |             |
      | 1  | 31   | 20240201 | 20240201 | 83.57           | 16.43         | 0.58     | 0.0  | 0.0       | 17.01 | 17.01 | 0.0        | 0.0  | 0.0         |
      | 2  | 29   | 20240301    | 20240315    | 83.57           | 0.0           | 0.0      | 0.0  | 0.0       | 0.0   | 0.0   | 0.0        | 0.0  | 0.0         |
      | 3  | 14   | 20240315    | 20240315    | 83.57           | 0.0           | 0.0      | 0.0  | 0.0       | 0.0   | 0.0   | 0.0        | 0.0  | 0.0         |
      | 4  | 17   | 20240401    |                  | 70.25           | 13.32         | 0.98     | 0.0  | 0.0       | 14.3  | 0.0   | 0.0        | 0.0  | 14.3        |
      | 5  | 30   | 20240501      |                  | 56.36           | 13.89         | 0.41     | 0.0  | 0.0       | 14.3  | 0.0   | 0.0        | 0.0  | 14.3        |
      | 6  | 31   | 20240601     |                  | 42.39           | 13.97         | 0.33     | 0.0  | 0.0       | 14.3  | 0.0   | 0.0        | 0.0  | 14.3        |
      | 7  | 30   | 20240701     |                  | 28.34           | 14.05         | 0.25     | 0.0  | 0.0       | 14.3  | 0.0   | 0.0        | 0.0  | 14.3        |
      | 8  | 31   | 20240801   |                  | 14.21           | 14.13         | 0.17     | 10.0 | 0.0       | 24.3  | 0.0   | 0.0        | 0.0  | 24.3        |
      | 9  | 31   | 20240901|                  | 0.0             | 14.21         | 0.08     | 0.0  | 0.0       | 14.29 | 0.0   | 0.0        | 0.0  | 14.29       |
    Then Loan Re-Aged Repayment schedule preview has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      | 100.0         | 2.8      | 10.0 | 0.0       | 112.8 | 17.01 | 0.0        | 0.0  | 95.79       |

    When Loan Pay-off is made on "20240315"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C4212 @AdvancedPaymentAllocation
  Scenario: Verify Re-aging preview on interest bearing loan - Interest calculation: Default Behavior - Partially paid installment - UC5
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
    When Admin creates a Loan re-aging preview by Loan external ID with the following data:
      | frequencyNumber | frequencyType | startDate    | numberOfInstallments |
      | 1               | MONTHS        | 20240401| 6                    |
    Then Loan Re-Aged Repayment schedule preview has 9 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101  |                  | 100.0           | 0.0           | 0.0      | 0.0  | 0.0       | 0.0   | 0.0   |            |      |             |
      | 1  | 31   | 20240201 | 20240201 | 83.57           | 16.43         | 0.58     | 0.0  | 0.0       | 17.01 | 17.01 | 0.0        | 0.0  | 0.0         |
      | 2  | 29   | 20240301    | 20240315    | 75.58           | 7.99          | 0.0      | 0.0  | 0.0       | 7.99  | 7.99  | 7.99       | 0.0  | 0.0         |
      | 3  | 14   | 20240315    | 20240315    | 75.58           | 0.0           | 0.0      | 0.0  | 0.0       | 0.0   | 0.0   | 0.0        | 0.0  | 0.0         |
      | 4  | 17   | 20240401    |                  | 63.53           | 12.05         | 0.88     | 0.0  | 0.0       | 12.93 | 0.0   | 0.0        | 0.0  | 12.93       |
      | 5  | 30   | 20240501      |                  | 50.97           | 12.56         | 0.37     | 0.0  | 0.0       | 12.93 | 0.0   | 0.0        | 0.0  | 12.93       |
      | 6  | 31   | 20240601     |                  | 38.34           | 12.63         | 0.3      | 0.0  | 0.0       | 12.93 | 0.0   | 0.0        | 0.0  | 12.93       |
      | 7  | 30   | 20240701     |                  | 25.63           | 12.71         | 0.22     | 0.0  | 0.0       | 12.93 | 0.0   | 0.0        | 0.0  | 12.93       |
      | 8  | 31   | 20240801   |                  | 12.85           | 12.78         | 0.15     | 0.0  | 0.0       | 12.93 | 0.0   | 0.0        | 0.0  | 12.93       |
      | 9  | 31   | 20240901|                  | 0.0             | 12.85         | 0.07     | 0.0  | 0.0       | 12.92 | 0.0   | 0.0        | 0.0  | 12.92       |
    Then Loan Re-Aged Repayment schedule preview has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 100.0         | 2.57     | 0.0  | 0.0       | 102.57 | 25.0 | 7.99       | 0.0  | 77.57       |

    When Loan Pay-off is made on "20240315"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C_4213 @AdvancedPaymentAllocation
  Scenario: Verify Re-aging preview on interest bearing loan - Interest calculation: Default Behavior - DownPayment Scenarios - UC7
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
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    |
      | 20240101  | Down Payment     | 25.0   | 25.0      | 0.0      | 0.0  | 0.0       | 75.0         | false    |
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
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    |
      | 20240101  | Down Payment     | 25.0   | 25.0      | 0.0      | 0.0  | 0.0       | 75.0         | false    |
      | 20240201 | Repayment        | 12.76  | 12.32     | 0.44     | 0.0  | 0.0       | 62.68        | false    |
    When Admin sets the business date to "20240315"
    When Admin creates a Loan re-aging preview by Loan external ID with the following data:
      | frequencyNumber | frequencyType | startDate     | numberOfInstallments |
      | 1               | MONTHS        | 20240401 | 6                    |
    Then Loan Re-Aged Repayment schedule preview has 10 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101   |                  | 100.0           | 0.0           | 0.0      | 0.0  | 0.0       | 0.0   | 0.0   |            |      |             |
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
    Then Loan Re-Aged Repayment schedule preview has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 100.0         | 2.11     | 0.0  | 0.0       | 102.11 | 37.76 | 0.0        | 0.0  | 64.35       |

    When Loan Pay-off is made on "20240315"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C4214 @AdvancedPaymentAllocation
  Scenario: Verify Re-aging preview on interest bearing loan - Interest calculation: Default Behavior - reversal of Re-aging - UC9
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
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    |
      | 20240201 | Repayment        | 17.01  | 16.43     | 0.58     | 0.0  | 0.0       | 83.57        | false    |
      | 20240315    | Re-age           | 84.28  | 83.57     | 0.71     | 0.0  | 0.0       | 0.0          | false    |
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
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    |
      | 20240201 | Repayment        | 17.01  | 16.43     | 0.58     | 0.0  | 0.0       | 83.57        | false    |
      | 20240315    | Re-age           | 84.28  | 83.57     | 0.71     | 0.0  | 0.0       | 0.0          | true     |

    When Admin creates a Loan re-aging preview by Loan external ID with the following data:
      | frequencyNumber | frequencyType | startDate     | numberOfInstallments |
      | 1               | MONTHS        | 20240401 | 6                    |
    Then Loan Re-Aged Repayment schedule preview has 9 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101  |                  | 100.0           | 0.0           | 0.0      | 0.0  | 0.0       | 0.0   | 0.0   |            |      |             |
      | 1  | 31   | 20240201 | 20240201 | 83.57           | 16.43         | 0.58     | 0.0  | 0.0       | 17.01 | 17.01 | 0.0        | 0.0  | 0.0         |
      | 2  | 29   | 20240301    | 20240401    | 83.57           | 0.0           | 0.0      | 0.0  | 0.0       | 0.0   | 0.0   | 0.0        | 0.0  | 0.0         |
      | 3  | 31   | 20240401    | 20240401    | 83.57           | 0.0           | 0.0      | 0.0  | 0.0       | 0.0   | 0.0   | 0.0        | 0.0  | 0.0         |
      | 4  | 0    | 20240401    |                  | 70.25           | 13.32         | 0.98     | 0.0  | 0.0       | 14.3  | 0.0   | 0.0        | 0.0  | 14.3        |
      | 5  | 30   | 20240501      |                  | 56.36           | 13.89         | 0.41     | 0.0  | 0.0       | 14.3  | 0.0   | 0.0        | 0.0  | 14.3        |
      | 6  | 31   | 20240601     |                  | 42.39           | 13.97         | 0.33     | 0.0  | 0.0       | 14.3  | 0.0   | 0.0        | 0.0  | 14.3        |
      | 7  | 30   | 20240701     |                  | 28.34           | 14.05         | 0.25     | 0.0  | 0.0       | 14.3  | 0.0   | 0.0        | 0.0  | 14.3        |
      | 8  | 31   | 20240801   |                  | 14.21           | 14.13         | 0.17     | 0.0  | 0.0       | 14.3  | 0.0   | 0.0        | 0.0  | 14.3        |
      | 9  | 31   | 20240901|                  | 0.0             | 14.21         | 0.08     | 0.0  | 0.0       | 14.29 | 0.0   | 0.0        | 0.0  | 14.29       |
    Then Loan Re-Aged Repayment schedule preview has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      | 100.0         | 2.8      | 0.0  | 0.0       | 102.8 | 17.01 | 0.0        | 0.0  | 85.79       |

    When Loan Pay-off is made on "20240315"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C4215 @AdvancedPaymentAllocation
  Scenario: Verify that Re-aging preview is forbidden on charged-off loan, interest bearing loan, Interest calculation: Default Behavior, Charge-off scenario (zero interest) - UC10
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
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    |
      | 20240201 | Repayment        | 17.01  | 16.43     | 0.58     | 0.0  | 0.0       | 83.57        | false    |
      | 20240301    | Accrual          | 1.07   | 0.0       | 1.07     | 0.0  | 0.0       | 0.0          | false    |
      | 20240301    | Charge-off       | 84.06  | 83.57     | 0.49     | 0.0  | 0.0       | 0.0          | false    |
    When Admin sets the business date to "20240315"
    Then Admin fails to create a Loan re-aging preview with the following data because loan was charged-off:
      | frequencyNumber | frequencyType | startDate     | numberOfInstallments |
      | 1               | MONTHS        | 20240401 | 6                    |

    When Loan Pay-off is made on "20240301"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C4216 @AdvancedPaymentAllocation
  Scenario: Verify that Re-aging preview is forbidden on contract terminated loan, interest bearing loan, Interest calculation: Default Behavior - UC10.2
    When Admin sets the business date to "20240101"
    When Admin creates a client with random data
    When Admin set "LP2_ADV_CUSTOM_PMT_ALLOC_PROGRESSIVE_LOAN_SCHEDULE_HORIZONTAL" loan product "DEFAULT" transaction type to "NEXT_INSTALLMENT" future installment allocation rule
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
    Then Admin fails to create a Loan re-aging preview with the following data because loan was contract terminated:
      | frequencyNumber | frequencyType | startDate   | numberOfInstallments |
      | 1               | MONTHS        | 20240501 | 6                    |

    When Loan Pay-off is made on "20240415"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C4217 @AdvancedPaymentAllocation
  Scenario: Verify Re-aging preview on interest bearing loan - Interest calculation: Default Behavior - Fees and Interest Split after re-aging - UC12
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
    When Admin creates a Loan re-aging preview by Loan external ID with the following data:
      | frequencyNumber | frequencyType | startDate     | numberOfInstallments |
      | 1               | MONTHS        | 20240401 | 6                    |
    Then Loan Re-Aged Repayment schedule preview has 9 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101  |                  | 100.0           | 0.0           | 0.0      | 0.0  | 0.0       | 0.0   | 0.0   |            |      |             |
      | 1  | 31   | 20240201 | 20240201 | 83.57           | 16.43         | 0.58     | 0.0  | 0.0       | 17.01 | 17.01 | 0.0        | 0.0  | 0.0         |
      | 2  | 29   | 20240301    | 20240315    | 83.57           | 0.0           | 0.0      | 0.0  | 0.0       | 0.0   | 0.0   | 0.0        | 0.0  | 0.0         |
      | 3  | 14   | 20240315    | 20240315    | 83.57           | 0.0           | 0.0      | 0.0  | 0.0       | 0.0   | 0.0   | 0.0        | 0.0  | 0.0         |
      | 4  | 17   | 20240401    |                  | 70.25           | 13.32         | 0.98     | 0.0  | 0.0       | 14.3  | 0.0   | 0.0        | 0.0  | 14.3        |
      | 5  | 30   | 20240501      |                  | 56.36           | 13.89         | 0.41     | 0.0  | 0.0       | 14.3  | 0.0   | 0.0        | 0.0  | 14.3        |
      | 6  | 31   | 20240601     |                  | 42.39           | 13.97         | 0.33     | 10.0 | 0.0       | 24.3  | 0.0   | 0.0        | 0.0  | 24.3        |
      | 7  | 30   | 20240701     |                  | 28.34           | 14.05         | 0.25     | 0.0  | 0.0       | 14.3  | 0.0   | 0.0        | 0.0  | 14.3        |
      | 8  | 31   | 20240801   |                  | 14.21           | 14.13         | 0.17     | 0.0  | 0.0       | 14.3  | 0.0   | 0.0        | 0.0  | 14.3        |
      | 9  | 31   | 20240901|                  | 0.0             | 14.21         | 0.08     | 0.0  | 0.0       | 14.29 | 0.0   | 0.0        | 0.0  | 14.29       |
    Then Loan Re-Aged Repayment schedule preview has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      | 100.0         | 2.8      | 10.0 | 0.0       | 112.8 | 17.01 | 0.0        | 0.0  | 95.79       |

    When Loan Pay-off is made on "20240315"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C4342 @AdvancedPaymentAllocation
  Scenario: Verify Loan re-aging preview on 1st installment after repay and chargeback on 1st due with partially paid installment; adjust to last - interest bearing loan with equal amortization; outstanding payable interest - UC4.1
    When Admin sets the business date to "20240101"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                               | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_INTEREST_RECALC_EMI_360_30_CHARGEBACK_PRINCIPAL_INTEREST_FEE | 20240101   | 100            | 7                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 6                 | MONTHS                | 1              | MONTHS                 | 6                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
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
    And Customer makes "AUTOPAY" repayment on "20240201" with 25 EUR transaction amount
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101  |                  | 100.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 31   | 20240201 | 20240201 | 83.57           | 16.43         | 0.58     | 0.0  | 0.0       | 17.01 | 17.01 | 0.0        | 0.0  | 0.0         |
      | 2  | 29   | 20240301    |                  | 67.0            | 16.57         | 0.44     | 0.0  | 0.0       | 17.01 | 7.99  | 7.99       | 0.0  | 9.02       |
      | 3  | 31   | 20240401    |                  | 50.38           | 16.62         | 0.39     | 0.0  | 0.0       | 17.01 | 0.0   | 0.0        | 0.0  | 17.01       |
      | 4  | 30   | 20240501      |                  | 33.66           | 16.72         | 0.29     | 0.0  | 0.0       | 17.01 | 0.0   | 0.0        | 0.0  | 17.01       |
      | 5  | 31   | 20240601     |                  | 16.85           | 16.81         | 0.2      | 0.0  | 0.0       | 17.01 | 0.0   | 0.0        | 0.0  | 17.01       |
      | 6  | 30   | 20240701     |                  | 0.0             | 16.85         | 0.1      | 0.0  | 0.0       | 16.95 | 0.0   | 0.0        | 0.0  | 16.95       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 100.0         | 2.0      | 0.0  | 0.0       | 102.0  | 25.0 | 7.99       | 0.0  | 77.0        |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240201 | Repayment        | 25.0   | 24.42     | 0.58     | 0.0  | 0.0       | 75.58        | false    | false    |

    When Admin makes "REPAYMENT_ADJUSTMENT_CHARGEBACK" chargeback with 17.01 EUR transaction amount
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101  |                  | 100.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 31   | 20240201 | 20240201 | 83.57           | 16.43         | 0.58     | 0.0  | 0.0       | 17.01 | 17.01 | 0.0        | 0.0  | 0.0         |
      | 2  | 29   | 20240301    |                  | 67.1            | 33.48         | 0.54     | 0.0  | 0.0       | 34.02 | 7.99  | 7.99       | 0.0  | 26.03      |
      | 3  | 31   | 20240401    |                  | 50.48           | 16.62         | 0.39     | 0.0  | 0.0       | 17.01 | 0.0   | 0.0        | 0.0  | 17.01       |
      | 4  | 30   | 20240501      |                  | 33.76           | 16.72         | 0.29     | 0.0  | 0.0       | 17.01 | 0.0   | 0.0        | 0.0  | 17.01       |
      | 5  | 31   | 20240601     |                  | 16.95           | 16.81         | 0.2      | 0.0  | 0.0       | 17.01 | 0.0   | 0.0        | 0.0  | 17.01       |
      | 6  | 30   | 20240701     |                  | 0.0             | 16.95         | 0.1      | 0.0  | 0.0       | 17.05 | 0.0   | 0.0        | 0.0  | 17.05       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 117.01        | 2.1      | 0.0  | 0.0       | 119.11 | 25.0 | 7.99       | 0.0  | 94.11       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240201 | Repayment        | 25.0   | 24.42     | 0.58     | 0.0  | 0.0       | 75.58        | false    | false    |
      | 20240201 | Chargeback       | 17.01  | 17.01     | 0.0      | 0.0  | 0.0       | 92.59        | false    | false    |

    When Admin sets the business date to "20240221"
    When Admin creates a Loan re-aging preview by Loan external ID with the following data:
      | frequencyNumber | frequencyType | startDate     | numberOfInstallments | reAgeInterestHandling               |
      | 1               | MONTHS        | 20240301 | 6                    | EQUAL_AMORTIZATION_PAYABLE_INTEREST |
    Then Loan Re-Aged Repayment schedule preview has 8 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101  |                  | 100.0           |   0.0         | 0.0      | 0.0  | 0.0       | 0.0   | 0.0   |            |      |             |
      | 1  | 31   | 20240201 | 20240201 | 83.57           | 16.43         | 0.58     | 0.0  | 0.0       | 17.01 | 17.01 | 0.0        | 0.0  | 0.0         |
      | 2  | 20   | 20240221 | 20240221 | 92.59           |  7.99         | 0.0      | 0.0  | 0.0       | 7.99  | 7.99  | 7.99       | 0.0  | 0.0         |
      | 3  |  9   | 20240301    |                  | 77.16           | 15.43         | 0.06     | 0.0  | 0.0       | 15.49 | 0.0   | 0.0        | 0.0  | 15.49       |
      | 4  | 31   | 20240401    |                  | 61.73           | 15.43         | 0.06     | 0.0  | 0.0       | 15.49 | 0.0   | 0.0        | 0.0  | 15.49       |
      | 5  | 30   | 20240501      |                  | 46.3            | 15.43         | 0.06     | 0.0  | 0.0       | 15.49 | 0.0   | 0.0        | 0.0  | 15.49       |
      | 6  | 31   | 20240601     |                  | 30.87           | 15.43         | 0.06     | 0.0  | 0.0       | 15.49 | 0.0   | 0.0        | 0.0  | 15.49       |
      | 7  | 30   | 20240701     |                  | 15.44           | 15.43         | 0.06     | 0.0  | 0.0       | 15.49 | 0.0   | 0.0        | 0.0  | 15.49       |
      | 8  | 31   | 20240801   |                  | 0.0             | 15.44         | 0.07     | 0.0  | 0.0       | 15.51 | 0.0   | 0.0        | 0.0  | 15.51       |
    Then Loan Re-Aged Repayment schedule preview has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 117.01        | 0.95     | 0.0  | 0.0       | 117.96 | 25.0  | 7.99       | 0.0  | 92.96       |

    When Loan Pay-off is made on "20240221"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C4343 @AdvancedPaymentAllocation
  Scenario: Verify Loan re-aging preview on 1st installment after repay and charge on 1st due with partially paid installment; adjust to last - interest bearing loan with equal amortization; outstanding payable interest - UC4.2
    When Admin sets the business date to "20240101"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                              | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_EMI_360_30_IR_DAILY_TILL_PRECLOSE_LAST_INSTALLMENT_STRATEGY | 20240101   | 100            | 7                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 6                 | MONTHS                | 1              | MONTHS                 | 6                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
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
    And Customer makes "AUTOPAY" repayment on "20240201" with 25 EUR transaction amount
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
      | 20240201 | Repayment        | 25.0   | 24.42     | 0.58     | 0.0  | 0.0       | 75.58        | false    | false    |

    And Admin adds "LOAN_NSF_FEE" due date charge with "20240201" due date and 10 EUR transaction amount
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101  |                  | 100.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 31   | 20240201 |                  | 83.57           | 16.43         | 0.58     | 0.0  | 10.0      | 27.01 | 17.01 | 0.0        | 0.0  | 10.0        |
      | 2  | 29   | 20240301    |                  | 67.0            | 16.57         | 0.44     | 0.0  | 0.0       | 17.01 | 0.0   | 0.0        | 0.0  | 17.01       |
      | 3  | 31   | 20240401    |                  | 50.33           | 16.67         | 0.34     | 0.0  | 0.0       | 17.01 | 0.0   | 0.0        | 0.0  | 17.01       |
      | 4  | 30   | 20240501      |                  | 33.57           | 16.76         | 0.25     | 0.0  | 0.0       | 17.01 | 0.0   | 0.0        | 0.0  | 17.01       |
      | 5  | 31   | 20240601     |                  | 16.71           | 16.86         | 0.15     | 0.0  | 0.0       | 17.01 | 0.0   | 0.0        | 0.0  | 17.01       |
      | 6  | 30   | 20240701     |                  | 0.0             | 16.71         | 0.05     | 0.0  | 0.0       | 16.76 | 7.99  | 7.99       | 0.0  | 8.77        |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 100.0         | 1.81     | 0.0  | 10.0      | 111.81 | 25.0 | 7.99       | 0.0  | 86.81       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240201 | Repayment        | 25.0   | 24.42     | 0.58     | 0.0  | 0.0       | 75.58        | false    | false    |
    Then Loan Charges tab has the following data:
      | Name    | isPenalty | Payment due at       | Due as of        | Calculation type | Due  | Paid | Waived | Outstanding |
      | NSF fee | true      | Specified due date   | 20240201 | Flat             | 10.0 | 0.0  | 0.0    | 10.0        |

    When Admin sets the business date to "20240221"
    When Admin creates a Loan re-aging preview by Loan external ID with the following data:
      | frequencyNumber | frequencyType | startDate        | numberOfInstallments | reAgeInterestHandling               |
      | 1               | MONTHS        | 20240221 | 6                    | EQUAL_AMORTIZATION_PAYABLE_INTEREST |
    Then Loan Re-Aged Repayment schedule preview has 8 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101  |                  | 100.0           |   0.0         | 0.0      | 0.0  | 0.0       | 0.0   | 0.0   |            |      |             |
      | 1  | 31   | 20240201 | 20240221 | 83.57           | 16.43         | 0.58     | 0.0  | 0.0       | 17.01 | 17.01 | 0.0        | 0.0  | 0.0         |
      | 2  | 20   | 20240221 | 20240221 | 75.58           |  7.99         | 0.0      | 0.0  | 0.0       |  7.99 | 7.99  | 7.99       | 0.0  | 0.0         |
      | 3  |  0   | 20240221 |                  | 62.99           | 12.59         | 0.05     | 0.0  | 1.67      | 14.31 | 0.0   | 0.0        | 0.0  | 14.31       |
      | 4  | 29   | 20240321    |                  | 50.4            | 12.59         | 0.05     | 0.0  | 1.67      | 14.31 | 0.0   | 0.0        | 0.0  | 14.31       |
      | 5  | 31   | 20240421    |                  | 37.81           | 12.59         | 0.05     | 0.0  | 1.67      | 14.31 | 0.0   | 0.0        | 0.0  | 14.31       |
      | 6  | 30   | 20240521      |                  | 25.22           | 12.59         | 0.05     | 0.0  | 1.67      | 14.31 | 0.0   | 0.0        | 0.0  | 14.31       |
      | 7  | 31   | 20240621     |                  | 12.63           | 12.59         | 0.05     | 0.0  | 1.67      | 14.31 | 0.0   | 0.0        | 0.0  | 14.31       |
      | 8  | 30   | 20240721     |                  |  0.0            | 12.63         | 0.05     | 0.0  | 1.65      | 14.33 | 0.0   | 0.0        | 0.0  | 14.33       |
    Then Loan Re-Aged Repayment schedule preview has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 100.0         | 0.88     | 0.0  | 10.0      | 110.88 | 25.0  | 7.99       | 0.0  | 85.88       |

    When Loan Pay-off is made on "20240221"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C4344 @AdvancedPaymentAllocation
  Scenario: Verify Loan re-aging preview on date after maturity date after repay and chargeback on 1st due with partially paid installment; adjust to last - interest bearing loan with equal amortization; outstanding payable interest - UC4.3
    When Admin sets the business date to "20240101"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                              | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_EMI_360_30_IR_DAILY_TILL_PRECLOSE_LAST_INSTALLMENT_STRATEGY | 20240101   | 100            | 7                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 6                 | MONTHS                | 1              | MONTHS                 | 6                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
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
    And Customer makes "AUTOPAY" repayment on "20240201" with 25 EUR transaction amount
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
      | 20240201 | Repayment        | 25.0   | 24.42     | 0.58     | 0.0  | 0.0       | 75.58        | false    | false    |

    When Admin makes "REPAYMENT_ADJUSTMENT_CHARGEBACK" chargeback with 17.01 EUR transaction amount
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101  |                  | 100.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 31   | 20240201 | 20240201 | 83.57           | 16.43         | 0.58     | 0.0  | 0.0       | 17.01 | 17.01 | 0.0        | 0.0  | 0.0         |
      | 2  | 29   | 20240301    |                  | 67.1            | 33.48         | 0.54     | 0.0  | 0.0       | 34.02 | 0.0   | 0.0        | 0.0  | 34.02       |
      | 3  | 31   | 20240401    |                  | 50.43           | 16.67         | 0.34     | 0.0  | 0.0       | 17.01 | 0.0   | 0.0        | 0.0  | 17.01       |
      | 4  | 30   | 20240501      |                  | 33.67           | 16.76         | 0.25     | 0.0  | 0.0       | 17.01 | 0.0   | 0.0        | 0.0  | 17.01       |
      | 5  | 31   | 20240601     |                  | 16.81           | 16.86         | 0.15     | 0.0  | 0.0       | 17.01 | 0.0   | 0.0        | 0.0  | 17.01       |
      | 6  | 30   | 20240701     |                  | 0.0             | 16.81         | 0.05     | 0.0  | 0.0       | 16.86 | 7.99  | 7.99       | 0.0  | 8.87        |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 117.01        | 1.91     | 0.0  | 0.0       | 118.92 | 25.0 | 7.99       | 0.0  | 93.92       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240201 | Repayment        | 25.0   | 24.42     | 0.58     | 0.0  | 0.0       | 75.58        | false    | false    |
      | 20240201 | Chargeback       | 17.01  | 17.01     | 0.0      | 0.0  | 0.0       | 92.59        | false    | false    |

    When Admin sets the business date to "20240301"
    When Admin creates a Loan re-aging preview by Loan external ID with the following data:
      | frequencyNumber | frequencyType | startDate      | numberOfInstallments | reAgeInterestHandling               |
      | 1               | MONTHS        | 20240801 | 6                    | EQUAL_AMORTIZATION_PAYABLE_INTEREST |
    Then Loan Re-Aged Repayment schedule preview has 8 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101   |                  | 100.0           |   0.0         | 0.0      | 0.0  | 0.0       | 0.0   | 0.0   |            |      |             |
      | 1  | 31   | 20240201  | 20240201 | 83.57           | 16.43         | 0.58     | 0.0  | 0.0       | 17.01 | 17.01 | 0.0        | 0.0  | 0.0         |
      | 2  | 29   | 20240301     | 20240301    | 92.59           |  7.99         | 0.0      | 0.0  | 0.0       | 7.99  | 7.99  | 7.99       | 0.0  | 0.0         |
      | 3  | 153  | 20240801    |                  | 77.16           | 15.43         | 0.09     | 0.0  | 0.0       | 15.52 | 0.0   | 0.0        | 0.0  | 15.52       |
      | 4  | 31   | 20240901 |                  | 61.73           | 15.43         | 0.09     | 0.0  | 0.0       | 15.52 | 0.0   | 0.0        | 0.0  | 15.52       |
      | 5  | 30   | 20241001   |                  | 46.3            | 15.43         | 0.09     | 0.0  | 0.0       | 15.52 | 0.0   | 0.0        | 0.0  | 15.52       |
      | 6  | 31   | 20241101  |                  | 30.87           | 15.43         | 0.09     | 0.0  | 0.0       | 15.52 | 0.0   | 0.0        | 0.0  | 15.52       |
      | 7  | 30   | 20241201  |                  | 15.44           | 15.43         | 0.09     | 0.0  | 0.0       | 15.52 | 0.0   | 0.0        | 0.0  | 15.52       |
      | 8  | 31   | 20250101   |                  |  0.0            | 15.44         | 0.09     | 0.0  | 0.0       | 15.53 | 0.0   | 0.0        | 0.0  | 15.53       |
    Then Loan Re-Aged Repayment schedule preview has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 117.01        | 1.12     | 0.0  | 0.0       | 118.13 | 25.0  | 7.99       | 0.0  | 93.13       |

    When Loan Pay-off is made on "20240301"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C4345 @AdvancedPaymentAllocation
  Scenario: Verify Loan backdated re-aging preview on 1st installment after repay and chargeback on 1st due with partially paid installment; adjust to next - interest bearing loan with equal amortization; outstanding payable interest - UC4.4
    When Admin sets the business date to "20240101"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                              | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_EMI_360_30_IR_DAILY_TILL_PRECLOSE_LAST_INSTALLMENT_STRATEGY | 20240101   | 100            | 7                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 6                 | MONTHS                | 1              | MONTHS                 | 6                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
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
    And Customer makes "AUTOPAY" repayment on "20240201" with 25 EUR transaction amount
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
      | 20240201 | Repayment        | 25.0   | 24.42     | 0.58     | 0.0  | 0.0       | 75.58        | false    | false    |

    When Admin makes "REPAYMENT_ADJUSTMENT_CHARGEBACK" chargeback with 17.01 EUR transaction amount
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101  |                  | 100.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 31   | 20240201 | 20240201 | 83.57           | 16.43         | 0.58     | 0.0  | 0.0       | 17.01 | 17.01 | 0.0        | 0.0  | 0.0         |
      | 2  | 29   | 20240301    |                  | 67.1            | 33.48         | 0.54     | 0.0  | 0.0       | 34.02 | 0.0   | 0.0        | 0.0  | 34.02       |
      | 3  | 31   | 20240401    |                  | 50.43           | 16.67         | 0.34     | 0.0  | 0.0       | 17.01 | 0.0   | 0.0        | 0.0  | 17.01       |
      | 4  | 30   | 20240501      |                  | 33.67           | 16.76         | 0.25     | 0.0  | 0.0       | 17.01 | 0.0   | 0.0        | 0.0  | 17.01       |
      | 5  | 31   | 20240601     |                  | 16.81           | 16.86         | 0.15     | 0.0  | 0.0       | 17.01 | 0.0   | 0.0        | 0.0  | 17.01       |
      | 6  | 30   | 20240701     |                  | 0.0             | 16.81         | 0.05     | 0.0  | 0.0       | 16.86 | 7.99  | 7.99       | 0.0  | 8.87        |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 117.01        | 1.91     | 0.0  | 0.0       | 118.92 | 25.0 | 7.99       | 0.0  | 93.92       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240201 | Repayment        | 25.0   | 24.42     | 0.58     | 0.0  | 0.0       | 75.58        | false    | false    |
      | 20240201 | Chargeback       | 17.01  | 17.01     | 0.0      | 0.0  | 0.0       | 92.59        | false    | false    |

    When Admin sets the business date to "20240301"
    When Admin creates a Loan re-aging preview by Loan external ID with the following data:
      | frequencyNumber | frequencyType | startDate     | numberOfInstallments | reAgeInterestHandling               |
      | 1               | MONTHS        | 20240301 | 6                    | EQUAL_AMORTIZATION_PAYABLE_INTEREST |
    Then Loan Re-Aged Repayment schedule preview has 8 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101  |                  | 100.0           |   0.0         | 0.0      | 0.0  | 0.0       | 0.0   | 0.0   |            |      |             |
      | 1  | 31   | 20240201 | 20240201 | 83.57           | 16.43         | 0.58     | 0.0  | 0.0       | 17.01 | 17.01 | 0.0        | 0.0  | 0.0         |
      | 2  | 29   | 20240301    | 20240301    | 92.59           | 7.99          | 0.0      | 0.0  | 0.0       |  7.99 | 7.99  | 7.99       | 0.0  | 0.0         |
      | 3  |  0   | 20240301    |                  | 77.16           | 15.43         | 0.09     | 0.0  | 0.0       | 15.52 | 0.0   | 0.0        | 0.0  | 15.52       |
      | 4  | 31   | 20240401    |                  | 61.73           | 15.43         | 0.09     | 0.0  | 0.0       | 15.52 | 0.0   | 0.0        | 0.0  | 15.52       |
      | 5  | 30   | 20240501      |                  | 46.3            | 15.43         | 0.09     | 0.0  | 0.0       | 15.52 | 0.0   | 0.0        | 0.0  | 15.52       |
      | 6  | 31   | 20240601     |                  | 30.87           | 15.43         | 0.09     | 0.0  | 0.0       | 15.52 | 0.0   | 0.0        | 0.0  | 15.52       |
      | 7  | 30   | 20240701     |                  | 15.44           | 15.43         | 0.09     | 0.0  | 0.0       | 15.52 | 0.0   | 0.0        | 0.0  | 15.52       |
      | 8  | 31   | 20240801   |                  |  0.0            | 15.44         | 0.09     | 0.0  | 0.0       | 15.53 | 0.0   | 0.0        | 0.0  | 15.53       |
    Then Loan Re-Aged Repayment schedule preview has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 117.01        | 1.12     | 0.0  | 0.0       | 118.13 | 25.0  | 7.99       | 0.0  | 93.13       |

    When Loan Pay-off is made on "20240301"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C4346 @AdvancedPaymentAllocation
  Scenario: Verify Loan re-aging preview on 1st installment after repay and chargeback on 1st due with partially paid installment; adjust to last - interest bearing loan with equal amortization; outstanding full interest - UC4.1
    When Admin sets the business date to "20240101"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                               | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_INTEREST_RECALC_EMI_360_30_CHARGEBACK_PRINCIPAL_INTEREST_FEE | 20240101   | 100            | 7                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 6                 | MONTHS                | 1              | MONTHS                 | 6                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
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
    And Customer makes "AUTOPAY" repayment on "20240201" with 25 EUR transaction amount
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101  |                  | 100.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 31   | 20240201 | 20240201 | 83.57           | 16.43         | 0.58     | 0.0  | 0.0       | 17.01 | 17.01 | 0.0        | 0.0  | 0.0         |
      | 2  | 29   | 20240301    |                  | 67.0            | 16.57         | 0.44     | 0.0  | 0.0       | 17.01 | 7.99  | 7.99       | 0.0  | 9.02       |
      | 3  | 31   | 20240401    |                  | 50.38           | 16.62         | 0.39     | 0.0  | 0.0       | 17.01 | 0.0   | 0.0        | 0.0  | 17.01       |
      | 4  | 30   | 20240501      |                  | 33.66           | 16.72         | 0.29     | 0.0  | 0.0       | 17.01 | 0.0   | 0.0        | 0.0  | 17.01       |
      | 5  | 31   | 20240601     |                  | 16.85           | 16.81         | 0.2      | 0.0  | 0.0       | 17.01 | 0.0   | 0.0        | 0.0  | 17.01       |
      | 6  | 30   | 20240701     |                  | 0.0             | 16.85         | 0.1      | 0.0  | 0.0       | 16.95 | 0.0   | 0.0        | 0.0  | 16.95       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 100.0         | 2.0      | 0.0  | 0.0       | 102.0  | 25.0 | 7.99       | 0.0  | 77.0        |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240201 | Repayment        | 25.0   | 24.42     | 0.58     | 0.0  | 0.0       | 75.58        | false    | false    |

    When Admin makes "REPAYMENT_ADJUSTMENT_CHARGEBACK" chargeback with 17.01 EUR transaction amount
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101  |                  | 100.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 31   | 20240201 | 20240201 | 83.57           | 16.43         | 0.58     | 0.0  | 0.0       | 17.01 | 17.01 | 0.0        | 0.0  | 0.0         |
      | 2  | 29   | 20240301    |                  | 67.1            | 33.48         | 0.54     | 0.0  | 0.0       | 34.02 | 7.99  | 7.99       | 0.0  | 26.03      |
      | 3  | 31   | 20240401    |                  | 50.48           | 16.62         | 0.39     | 0.0  | 0.0       | 17.01 | 0.0   | 0.0        | 0.0  | 17.01       |
      | 4  | 30   | 20240501      |                  | 33.76           | 16.72         | 0.29     | 0.0  | 0.0       | 17.01 | 0.0   | 0.0        | 0.0  | 17.01       |
      | 5  | 31   | 20240601     |                  | 16.95           | 16.81         | 0.2      | 0.0  | 0.0       | 17.01 | 0.0   | 0.0        | 0.0  | 17.01       |
      | 6  | 30   | 20240701     |                  | 0.0             | 16.95         | 0.1      | 0.0  | 0.0       | 17.05 | 0.0   | 0.0        | 0.0  | 17.05       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 117.01        | 2.1      | 0.0  | 0.0       | 119.11 | 25.0 | 7.99       | 0.0  | 94.11       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240201 | Repayment        | 25.0   | 24.42     | 0.58     | 0.0  | 0.0       | 75.58        | false    | false    |
      | 20240201 | Chargeback       | 17.01  | 17.01     | 0.0      | 0.0  | 0.0       | 92.59        | false    | false    |

    When Admin sets the business date to "20240221"
    When Admin creates a Loan re-aging preview by Loan external ID with the following data:
      | frequencyNumber | frequencyType | startDate     | numberOfInstallments | reAgeInterestHandling            |
      | 1               | MONTHS        | 20240301 | 6                    | EQUAL_AMORTIZATION_FULL_INTEREST |
    Then Loan Re-Aged Repayment schedule preview has 8 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101  |                  | 100.0           |   0.0         | 0.0      | 0.0  | 0.0       | 0.0   | 0.0   |            |      |             |
      | 1  | 31   | 20240201 | 20240201 | 83.57           | 16.43         | 0.58     | 0.0  | 0.0       | 17.01 | 17.01 | 0.0        | 0.0  | 0.0         |
      | 2  | 20   | 20240221 | 20240221 | 92.59           |  7.99         | 0.0      | 0.0  | 0.0       | 7.99  | 7.99  | 7.99       | 0.0  | 0.0         |
      | 3  |  9   | 20240301    |                  | 77.16           | 15.43         | 0.25     | 0.0  | 0.0       | 15.68 | 0.0   | 0.0        | 0.0  | 15.68       |
      | 4  | 31   | 20240401    |                  | 61.73           | 15.43         | 0.25     | 0.0  | 0.0       | 15.68 | 0.0   | 0.0        | 0.0  | 15.68       |
      | 5  | 30   | 20240501      |                  | 46.3            | 15.43         | 0.25     | 0.0  | 0.0       | 15.68 | 0.0   | 0.0        | 0.0  | 15.68       |
      | 6  | 31   | 20240601     |                  | 30.87           | 15.43         | 0.25     | 0.0  | 0.0       | 15.68 | 0.0   | 0.0        | 0.0  | 15.68       |
      | 7  | 30   | 20240701     |                  | 15.44           | 15.43         | 0.25     | 0.0  | 0.0       | 15.68 | 0.0   | 0.0        | 0.0  | 15.68       |
      | 8  | 31   | 20240801   |                  | 0.0             | 15.44         | 0.27     | 0.0  | 0.0       | 15.71 | 0.0   | 0.0        | 0.0  | 15.71       |
    Then Loan Re-Aged Repayment schedule preview has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 117.01        | 2.1      | 0.0  | 0.0       | 119.11 | 25.0  | 7.99       | 0.0  | 94.11       |

    When Loan Pay-off is made on "20240221"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C4347 @AdvancedPaymentAllocation
  Scenario: Verify Loan re-aging preview on 1st installment after repay and charge on 1st due with partially paid installment; adjust to last - interest bearing loan with equal amortization; outstanding full interest - UC4.2
    When Admin sets the business date to "20240101"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                              | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_EMI_360_30_IR_DAILY_TILL_PRECLOSE_LAST_INSTALLMENT_STRATEGY | 20240101   | 100            | 7                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 6                 | MONTHS                | 1              | MONTHS                 | 6                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
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
    And Customer makes "AUTOPAY" repayment on "20240201" with 34.02 EUR transaction amount
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101  |                  | 100.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 31   | 20240201 | 20240201 | 83.57           | 16.43         | 0.58     | 0.0  | 0.0       | 17.01 | 17.01 | 0.0        | 0.0  | 0.0         |
      | 2  | 29   | 20240301    |                  | 66.95           | 16.62         | 0.39     | 0.0  | 0.0       | 17.01 | 0.0   | 0.0        | 0.0  | 17.01       |
      | 3  | 31   | 20240401    |                  | 50.23           | 16.72         | 0.29     | 0.0  | 0.0       | 17.01 | 0.0   | 0.0        | 0.0  | 17.01       |
      | 4  | 30   | 20240501      |                  | 33.41           | 16.82         | 0.19     | 0.0  | 0.0       | 17.01 | 0.0   | 0.0        | 0.0  | 17.01       |
      | 5  | 31   | 20240601     |                  | 17.01           | 16.4          | 0.1      | 0.0  | 0.0       | 16.5  | 0.0   | 0.0        | 0.0  | 16.5        |
      | 6  | 30   | 20240701     | 20240201 | 0.0             | 17.01         | 0.0      | 0.0  | 0.0       | 17.01 | 17.01 | 17.01      | 0.0  | 0.0         |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 100.0         | 1.55     | 0.0  | 0.0       | 101.55 | 34.02 | 17.01      | 0.0  | 67.53       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240201 | Repayment        | 34.02  | 33.44     | 0.58     | 0.0  | 0.0       | 66.56        | false    | false    |

    When Admin sets the business date to "20240221"
    When Admin creates a Loan re-aging preview by Loan external ID with the following data:
      | frequencyNumber | frequencyType | startDate     | numberOfInstallments | reAgeInterestHandling            |
      | 1               | MONTHS        | 20240401 | 6                    | EQUAL_AMORTIZATION_FULL_INTEREST |
    Then Loan Re-Aged Repayment schedule preview has 8 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101   |                  | 100.0           |   0.0         | 0.0      | 0.0  | 0.0       | 0.0   | 0.0   |            |      |             |
      | 1  | 31   | 20240201  | 20240201 | 83.57           | 16.43         | 0.58     | 0.0  | 0.0       | 17.01 | 17.01 | 0.0        | 0.0  | 0.0         |
      | 2  | 20   | 20240221  | 20240221 | 66.56           | 17.01         | 0.0      | 0.0  | 0.0       | 17.01 | 17.01 | 17.01      | 0.0  | 0.0         |
      | 3  | 40   | 20240401     |                  | 55.46           | 11.1          | 0.16     | 0.0  | 0.0       | 11.26 | 0.0   | 0.0        | 0.0  | 11.26       |
      | 4  | 30   | 20240501       |                  | 44.36           | 11.1          | 0.16     | 0.0  | 0.0       | 11.26 | 0.0   | 0.0        | 0.0  | 11.26       |
      | 5  | 31   | 20240601      |                  | 33.26           | 11.1          | 0.16     | 0.0  | 0.0       | 11.26 | 0.0   | 0.0        | 0.0  | 11.26       |
      | 6  | 30   | 20240701      |                  | 22.16           | 11.1          | 0.16     | 0.0  | 0.0       | 11.26 | 0.0   | 0.0        | 0.0  | 11.26       |
      | 7  | 31   | 20240801    |                  | 11.06           | 11.1          | 0.16     | 0.0  | 0.0       | 11.26 | 0.0   | 0.0        | 0.0  | 11.26       |
      | 8  | 31   | 20240901 |                  |  0.0            | 11.06         | 0.17     | 0.0  | 0.0       | 11.23 | 0.0   | 0.0        | 0.0  | 11.23       |
    Then Loan Re-Aged Repayment schedule preview has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 100.0         | 1.55     | 0.0  | 0.0       | 101.55 | 34.02 | 17.01      | 0.0  | 67.53       |

    When Loan Pay-off is made on "20240221"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C4348 @AdvancedPaymentAllocation
  Scenario: Verify Loan re-aging preview on date after maturity date after repay and chargeback on 1st due with partially paid installment; adjust to last - interest bearing loan with equal amortization; outstanding full interest - UC4.3
    When Admin sets the business date to "20240101"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                              | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_EMI_360_30_IR_DAILY_TILL_PRECLOSE_LAST_INSTALLMENT_STRATEGY | 20240101   | 100            | 7                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 6                 | MONTHS                | 1              | MONTHS                 | 6                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
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
    And Customer makes "AUTOPAY" repayment on "20240201" with 25 EUR transaction amount
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
      | 20240201 | Repayment        | 25.0   | 24.42     | 0.58     | 0.0  | 0.0       | 75.58        | false    | false    |

    When Admin makes "REPAYMENT_ADJUSTMENT_CHARGEBACK" chargeback with 17.01 EUR transaction amount
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101  |                  | 100.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 31   | 20240201 | 20240201 | 83.57           | 16.43         | 0.58     | 0.0  | 0.0       | 17.01 | 17.01 | 0.0        | 0.0  | 0.0         |
      | 2  | 29   | 20240301    |                  | 67.1            | 33.48         | 0.54     | 0.0  | 0.0       | 34.02 | 0.0   | 0.0        | 0.0  | 34.02       |
      | 3  | 31   | 20240401    |                  | 50.43           | 16.67         | 0.34     | 0.0  | 0.0       | 17.01 | 0.0   | 0.0        | 0.0  | 17.01       |
      | 4  | 30   | 20240501      |                  | 33.67           | 16.76         | 0.25     | 0.0  | 0.0       | 17.01 | 0.0   | 0.0        | 0.0  | 17.01       |
      | 5  | 31   | 20240601     |                  | 16.81           | 16.86         | 0.15     | 0.0  | 0.0       | 17.01 | 0.0   | 0.0        | 0.0  | 17.01       |
      | 6  | 30   | 20240701     |                  | 0.0             | 16.81         | 0.05     | 0.0  | 0.0       | 16.86 | 7.99  | 7.99       | 0.0  | 8.87        |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 117.01        | 1.91     | 0.0  | 0.0       | 118.92 | 25.0 | 7.99       | 0.0  | 93.92       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240201 | Repayment        | 25.0   | 24.42     | 0.58     | 0.0  | 0.0       | 75.58        | false    | false    |
      | 20240201 | Chargeback       | 17.01  | 17.01     | 0.0      | 0.0  | 0.0       | 92.59        | false    | false    |

    When Admin sets the business date to "20240301"
    When Admin creates a Loan re-aging preview by Loan external ID with the following data:
      | frequencyNumber | frequencyType | startDate      | numberOfInstallments | reAgeInterestHandling             |
      | 1               | MONTHS        | 20240801 | 6                    | EQUAL_AMORTIZATION_FULL_INTEREST |
    Then Loan Re-Aged Repayment schedule preview has 8 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101   |                  | 100.0           |   0.0         | 0.0      | 0.0  | 0.0       | 0.0   | 0.0   |            |      |             |
      | 1  | 31   | 20240201  | 20240201 | 83.57           | 16.43         | 0.58     | 0.0  | 0.0       | 17.01 | 17.01 | 0.0        | 0.0  | 0.0         |
      | 2  | 29   | 20240301     | 20240301    | 92.59           |  7.99         | 0.0      | 0.0  | 0.0       | 7.99  | 7.99  | 7.99       | 0.0  | 0.0         |
      | 3  | 153  | 20240801    |                  | 77.16           | 15.43         | 0.22     | 0.0  | 0.0       | 15.65 | 0.0   | 0.0        | 0.0  | 15.65       |
      | 4  | 31   | 20240901 |                  | 61.73           | 15.43         | 0.22     | 0.0  | 0.0       | 15.65 | 0.0   | 0.0        | 0.0  | 15.65       |
      | 5  | 30   | 20241001   |                  | 46.3            | 15.43         | 0.22     | 0.0  | 0.0       | 15.65 | 0.0   | 0.0        | 0.0  | 15.65       |
      | 6  | 31   | 20241101  |                  | 30.87           | 15.43         | 0.22     | 0.0  | 0.0       | 15.65 | 0.0   | 0.0        | 0.0  | 15.65       |
      | 7  | 30   | 20241201  |                  | 15.44           | 15.43         | 0.22     | 0.0  | 0.0       | 15.65 | 0.0   | 0.0        | 0.0  | 15.65       |
      | 8  | 31   | 20250101   |                  |  0.0            | 15.44         | 0.23     | 0.0  | 0.0       | 15.67 | 0.0   | 0.0        | 0.0  | 15.67       |
    Then Loan Re-Aged Repayment schedule preview has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 117.01        | 1.91     | 0.0  | 0.0       | 118.92 | 25.0  | 7.99       | 0.0  | 93.92       |

    When Loan Pay-off is made on "20240301"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C4349 @AdvancedPaymentAllocation
  Scenario: Verify Loan backdated re-aging preview on 1st installment after repay and chargeback on 1st due with partially paid installment; adjust to next - interest bearing loan with equal amortization; outstanding full interest - UC4.4
    When Admin sets the business date to "20240101"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                              | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_EMI_360_30_IR_DAILY_TILL_PRECLOSE_LAST_INSTALLMENT_STRATEGY | 20240101   | 100            | 7                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 6                 | MONTHS                | 1              | MONTHS                 | 6                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
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
    And Customer makes "AUTOPAY" repayment on "20240201" with 25 EUR transaction amount
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
      | 20240201 | Repayment        | 25.0   | 24.42     | 0.58     | 0.0  | 0.0       | 75.58        | false    | false    |

    When Admin makes "REPAYMENT_ADJUSTMENT_CHARGEBACK" chargeback with 17.01 EUR transaction amount
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101  |                  | 100.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 31   | 20240201 | 20240201 | 83.57           | 16.43         | 0.58     | 0.0  | 0.0       | 17.01 | 17.01 | 0.0        | 0.0  | 0.0         |
      | 2  | 29   | 20240301    |                  | 67.1            | 33.48         | 0.54     | 0.0  | 0.0       | 34.02 | 0.0   | 0.0        | 0.0  | 34.02       |
      | 3  | 31   | 20240401    |                  | 50.43           | 16.67         | 0.34     | 0.0  | 0.0       | 17.01 | 0.0   | 0.0        | 0.0  | 17.01       |
      | 4  | 30   | 20240501      |                  | 33.67           | 16.76         | 0.25     | 0.0  | 0.0       | 17.01 | 0.0   | 0.0        | 0.0  | 17.01       |
      | 5  | 31   | 20240601     |                  | 16.81           | 16.86         | 0.15     | 0.0  | 0.0       | 17.01 | 0.0   | 0.0        | 0.0  | 17.01       |
      | 6  | 30   | 20240701     |                  | 0.0             | 16.81         | 0.05     | 0.0  | 0.0       | 16.86 | 7.99  | 7.99       | 0.0  | 8.87        |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 117.01        | 1.91     | 0.0  | 0.0       | 118.92 | 25.0 | 7.99       | 0.0  | 93.92       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240201 | Repayment        | 25.0   | 24.42     | 0.58     | 0.0  | 0.0       | 75.58        | false    | false    |
      | 20240201 | Chargeback       | 17.01  | 17.01     | 0.0      | 0.0  | 0.0       | 92.59        | false    | false    |

    When Admin sets the business date to "20240301"
    When Admin creates a Loan re-aging preview by Loan external ID with the following data:
      | frequencyNumber | frequencyType | startDate     | numberOfInstallments | reAgeInterestHandling            |
      | 1               | MONTHS        | 20240301 | 6                    | EQUAL_AMORTIZATION_FULL_INTEREST |
    Then Loan Re-Aged Repayment schedule preview has 8 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101  |                  | 100.0           |   0.0         | 0.0      | 0.0  | 0.0       | 0.0   | 0.0   |            |      |             |
      | 1  | 31   | 20240201 | 20240201 | 83.57           | 16.43         | 0.58     | 0.0  | 0.0       | 17.01 | 17.01 | 0.0        | 0.0  | 0.0         |
      | 2  | 29   | 20240301    | 20240301    | 92.59           | 7.99          | 0.0      | 0.0  | 0.0       |  7.99 | 7.99  | 7.99       | 0.0  | 0.0         |
      | 3  |  0   | 20240301    |                  | 77.16           | 15.43         | 0.22     | 0.0  | 0.0       | 15.65 | 0.0   | 0.0        | 0.0  | 15.65       |
      | 4  | 31   | 20240401    |                  | 61.73           | 15.43         | 0.22     | 0.0  | 0.0       | 15.65 | 0.0   | 0.0        | 0.0  | 15.65       |
      | 5  | 30   | 20240501      |                  | 46.3            | 15.43         | 0.22     | 0.0  | 0.0       | 15.65 | 0.0   | 0.0        | 0.0  | 15.65       |
      | 6  | 31   | 20240601     |                  | 30.87           | 15.43         | 0.22     | 0.0  | 0.0       | 15.65 | 0.0   | 0.0        | 0.0  | 15.65       |
      | 7  | 30   | 20240701     |                  | 15.44           | 15.43         | 0.22     | 0.0  | 0.0       | 15.65 | 0.0   | 0.0        | 0.0  | 15.65       |
      | 8  | 31   | 20240801   |                  |  0.0            | 15.44         | 0.23     | 0.0  | 0.0       | 15.67 | 0.0   | 0.0        | 0.0  | 15.67       |
    Then Loan Re-Aged Repayment schedule preview has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 117.01        | 1.91     | 0.0  | 0.0       | 118.92 | 25.0  | 7.99       | 0.0  | 93.92       |

    When Loan Pay-off is made on "20240301"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C4357 @AdvancedPaymentAllocation
  Scenario: Verify Loan re-aging preview with repayment - interest bearing loan with equal amortization; outstanding payable interest + outstanding principal - UC1
    When Admin sets the business date to "20240101"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                        | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_EMI_360_30_INTEREST_RECALCULATION_DAILY_TILL_PRECLOSE | 20240101   | 100            | 7                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 6                 | MONTHS                | 1              | MONTHS                 | 6                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
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
    When Admin creates a Loan re-aging preview by Loan external ID with the following data:
      | frequencyNumber | frequencyType | startDate     | numberOfInstallments | reAgeInterestHandling               |
      | 1               | MONTHS        | 20240401 | 6                    | EQUAL_AMORTIZATION_PAYABLE_INTEREST |
    Then Loan Re-Aged Repayment schedule preview has 9 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101   |                  | 100.0           | 0.0           | 0.0      | 0.0  | 0.0       | 0.0   | 0.0   |            |      |             |
      | 1  | 31   | 20240201  | 20240201 | 83.57           | 16.43         | 0.58     | 0.0  | 0.0       | 17.01 | 17.01 | 0.0        | 0.0  | 0.0         |
      | 2  | 29   | 20240301     | 20240315    | 83.57           | 0.0           | 0.0      | 0.0  | 0.0       | 0.0   | 0.0   | 0.0        | 0.0  | 0.0         |
      | 3  | 14   | 20240315     | 20240315    | 83.57           | 0.0           | 0.0      | 0.0  | 0.0       | 0.0   | 0.0   | 0.0        | 0.0  | 0.0         |
      | 4  | 17   | 20240401     |                  | 69.64           | 13.93         | 0.12     | 0.0  | 0.0       | 14.05 | 0.0   | 0.0        | 0.0  | 14.05       |
      | 5  | 30   | 20240501       |                  | 55.71           | 13.93         | 0.12     | 0.0  | 0.0       | 14.05 | 0.0   | 0.0        | 0.0  | 14.05       |
      | 6  | 31   | 20240601      |                  | 41.78           | 13.93         | 0.12     | 0.0  | 0.0       | 14.05 | 0.0   | 0.0        | 0.0  | 14.05       |
      | 7  | 30   | 20240701      |                  | 27.85           | 13.93         | 0.12     | 0.0  | 0.0       | 14.05 | 0.0   | 0.0        | 0.0  | 14.05       |
      | 8  | 31   | 20240801    |                  | 13.92           | 13.93         | 0.12     | 0.0  | 0.0       | 14.05 | 0.0   | 0.0        | 0.0  | 14.05       |
      | 9  | 31   | 20240901 |                  | 0.0             | 13.92         | 0.11     | 0.0  | 0.0       | 14.03 | 0.0   | 0.0        | 0.0  | 14.03       |
    Then Loan Re-Aged Repayment schedule preview has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 100.0         | 1.29     | 0.0  | 0.0       | 101.29 | 17.01 | 0.0        | 0.0  | 84.28       |

    When Loan Pay-off is made on "20240315"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C4358 @AdvancedPaymentAllocation
  Scenario: Verify Loan re-aging preview with repayment and charge - interest bearing loan with equal amortization; outstanding payable interest - UC2
    When Admin sets the business date to "20240101"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                        | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_EMI_360_30_INTEREST_RECALCULATION_DAILY_TILL_PRECLOSE | 20240101   | 100            | 7                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 6                 | MONTHS                | 1              | MONTHS                 | 6                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
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

    When Admin sets the business date to "20240215"
    When Admin runs inline COB job for Loan
    And Admin adds "LOAN_SNOOZE_FEE" due date charge with "20240215" due date and 10 EUR transaction amount
    Then Loan Charges tab has the following data:
      | Name       | isPenalty | Payment due at     | Due as of        | Calculation type | Due  | Paid | Waived | Outstanding |
      | Snooze fee | false     | Specified due date | 20240215 | Flat             | 10.0 | 0.0  | 0.0    | 10.0        |

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
      | 20240214 | Accrual          | 0.8    | 0.0       | 0.8      | 0.0  | 0.0       | 0.0          | false    | false    |

    When Admin sets the business date to "20240315"
    When Admin runs inline COB job for Loan
    When Admin creates a Loan re-aging preview by Loan external ID with the following data:
      | frequencyNumber | frequencyType | startDate     | numberOfInstallments | reAgeInterestHandling               |
      | 1               | MONTHS        | 20240401 | 6                    | EQUAL_AMORTIZATION_PAYABLE_INTEREST |
    Then Loan Re-Aged Repayment schedule preview has 9 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101   |                  | 100.0           | 0.0           | 0.0      | 0.0  | 0.0       | 0.0   | 0.0   |            |      |             |
      | 1  | 31   | 20240201  | 20240201 | 83.57           | 16.43         | 0.58     | 0.0  | 0.0       | 17.01 | 17.01 | 0.0        | 0.0  | 0.0         |
      | 2  | 29   | 20240301     | 20240315    | 83.57           | 0.0           | 0.0      | 0.0  | 0.0       | 0.0   | 0.0   | 0.0        | 0.0  | 0.0         |
      | 3  | 14   | 20240315     | 20240315    | 83.57           | 0.0           | 0.0      | 0.0  | 0.0       | 0.0   | 0.0   | 0.0        | 0.0  | 0.0         |
      | 4  | 17   | 20240401     |                  | 69.65           | 13.92         | 0.12     | 1.67 | 0.0       | 15.71 | 0.0   | 0.0        | 0.0  | 15.71       |
      | 5  | 30   | 20240501       |                  | 55.73           | 13.92         | 0.12     | 1.67 | 0.0       | 15.71 | 0.0   | 0.0        | 0.0  | 15.71       |
      | 6  | 31   | 20240601      |                  | 41.81           | 13.92         | 0.12     | 1.67 | 0.0       | 15.71 | 0.0   | 0.0        | 0.0  | 15.71       |
      | 7  | 30   | 20240701      |                  | 27.89           | 13.92         | 0.12     | 1.67 | 0.0       | 15.71 | 0.0   | 0.0        | 0.0  | 15.71       |
      | 8  | 31   | 20240801    |                  | 13.97           | 13.92         | 0.12     | 1.67 | 0.0       | 15.71 | 0.0   | 0.0        | 0.0  | 15.71       |
      | 9  | 31   | 20240901 |                  | 0.0             | 13.97         | 0.11     | 1.65 | 0.0       | 15.73 | 0.0   | 0.0        | 0.0  | 15.73       |
    Then Loan Re-Aged Repayment schedule preview has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 100.0         | 1.29     | 10.0 | 0.0       | 111.29 | 17.01 | 0.0        | 0.0  | 94.28       |

    When Loan Pay-off is made on "20240315"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C4359 @AdvancedPaymentAllocation
  Scenario: Verify Loan re-aging preview with repayment, charge and partial chargeback with payment alloc - interest bearing loan with equal amortization; outstanding payable interest - UC3.3
    When Admin sets the business date to "20240101"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                               | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_INTEREST_RECALC_EMI_360_30_CHARGEBACK_INTEREST_FEE_PRINCIPAL | 20240101   | 100            | 7                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 6                 | MONTHS                | 1              | MONTHS                 | 6                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
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
    And Admin adds "LOAN_SNOOZE_FEE" due date charge with "20240201" due date and 8 EUR transaction amount
    And Customer makes "AUTOPAY" repayment on "20240201" with 17.01 EUR transaction amount
    When Admin makes "REPAYMENT_ADJUSTMENT_CHARGEBACK" chargeback with 10 EUR transaction amount
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101  |           | 100.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 31   | 20240201 |           | 83.57           | 16.43         | 0.58     | 8.0  | 0.0       | 25.01 | 17.01 | 0.0        | 0.0  | 8.0         |
      | 2  | 29   | 20240301    |           | 67.06           | 18.51         | 0.5      | 8.0  | 0.0       | 27.01 | 0.0   | 0.0        | 0.0  | 27.01       |
      | 3  | 31   | 20240401    |           | 50.44           | 16.62         | 0.39     | 0.0  | 0.0       | 17.01 | 0.0   | 0.0        | 0.0  | 17.01       |
      | 4  | 30   | 20240501      |           | 33.72           | 16.72         | 0.29     | 0.0  | 0.0       | 17.01 | 0.0   | 0.0        | 0.0  | 17.01       |
      | 5  | 31   | 20240601     |           | 16.91           | 16.81         | 0.2      | 0.0  | 0.0       | 17.01 | 0.0   | 0.0        | 0.0  | 17.01       |
      | 6  | 30   | 20240701     |           | 0.0             | 16.91         | 0.1      | 0.0  | 0.0       | 17.01 | 0.0   | 0.0        | 0.0  | 17.01       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 102.0         | 2.06     | 16.0 | 0.0       | 120.06 | 17.01 | 0.0        | 0.0  | 103.05      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240201 | Repayment        | 17.01  | 9.01      | 0.0      | 8.0  | 0.0       | 90.99        | false    | false    |
      | 20240201 | Chargeback       | 10.0   | 2.0       | 0.0      | 8.0  | 0.0       | 92.99        | false    | false    |

    When Admin sets the business date to "20240315"
    When Admin runs inline COB job for Loan
    When Admin creates a Loan re-aging preview by Loan external ID with the following data:
      | frequencyNumber | frequencyType | startDate     | numberOfInstallments | reAgeInterestHandling               |
      | 1               | MONTHS        | 20240401 | 6                    | EQUAL_AMORTIZATION_PAYABLE_INTEREST |
    Then Loan Re-Aged Repayment schedule preview has 9 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date     | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101   |               | 100.0           | 0.0           | 0.0      | 0.0  | 0.0       | 0.0   | 0.0   |            |      |             |
      | 1  | 31   | 20240201  | 20240315 | 90.99           | 9.01          | 0.0      | 8.0  | 0.0       | 17.01 | 17.01 | 0.0        | 0.0  | 0.0         |
      | 2  | 29   | 20240301     | 20240315 | 92.99           | 0.0           | 0.0      | 0.0  | 0.0       | 0.0   | 0.0   | 0.0        | 0.0  | 0.0         |
      | 3  | 14   | 20240315     | 20240315 | 92.99           | 0.0           | 0.0      | 0.0  | 0.0       | 0.0   | 0.0   | 0.0        | 0.0  | 0.0         |
      | 4  | 17   | 20240401     |               | 77.49           | 15.5          | 0.23     | 1.33 | 0.0       | 17.06 | 0.0   | 0.0        | 0.0  | 17.06       |
      | 5  | 30   | 20240501       |               | 61.99           | 15.5          | 0.23     | 1.33 | 0.0       | 17.06 | 0.0   | 0.0        | 0.0  | 17.06       |
      | 6  | 31   | 20240601      |               | 46.49           | 15.5          | 0.23     | 1.33 | 0.0       | 17.06 | 0.0   | 0.0        | 0.0  | 17.06       |
      | 7  | 30   | 20240701      |               | 30.99           | 15.5          | 0.23     | 1.33 | 0.0       | 17.06 | 0.0   | 0.0        | 0.0  | 17.06       |
      | 8  | 31   | 20240801    |               | 15.49           | 15.5          | 0.23     | 1.33 | 0.0       | 17.06 | 0.0   | 0.0        | 0.0  | 17.06       |
      | 9  | 31   | 20240901 |               | 0.0             | 15.49         | 0.21     | 1.35 | 0.0       | 17.05 | 0.0   | 0.0        | 0.0  | 17.05       |
    Then Loan Re-Aged Repayment schedule preview has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 102.0         | 1.36     | 16.0 | 0.0       | 119.36 | 17.01 | 0.0        | 0.0  | 102.35      |

    When Loan Pay-off is made on "20240315"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C4360 @AdvancedPaymentAllocation
  Scenario: Verify Loan re-aging preview with repayment and 2nd disb before re-age - interest bearing multidisb loan with equal amortization; outstanding FULL interest - UC1.1
    When Admin sets the business date to "20240101"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                 | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_EMI_360_30_INTEREST_RECALC_DAILY_MULTIDISBURSE | 20240101   | 150            | 7                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 6                 | MONTHS                | 1              | MONTHS                 | 6                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
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

    When Admin successfully disburse the loan on "20240201" with "50" EUR transaction amount
    When Admin runs inline COB job for Loan
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101  |                  | 100.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 31   | 20240201 | 20240201 | 83.57           | 16.43         | 0.58     | 0.0  | 0.0       | 17.01 | 17.01 | 0.0        | 0.0  | 0.0         |
      |    |      | 20240201 |                  | 50.0            |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 2  | 29   | 20240301    |                  | 107.17          | 26.4          | 0.78     | 0.0  | 0.0       | 27.18 | 0.0   | 0.0        | 0.0  | 27.18       |
      | 3  | 31   | 20240401    |                  | 80.62           | 26.55         | 0.63     | 0.0  | 0.0       | 27.18 | 0.0   | 0.0        | 0.0  | 27.18       |
      | 4  | 30   | 20240501      |                  | 53.91           | 26.71         | 0.47     | 0.0  | 0.0       | 27.18 | 0.0   | 0.0        | 0.0  | 27.18       |
      | 5  | 31   | 20240601     |                  | 27.04           | 26.87         | 0.31     | 0.0  | 0.0       | 27.18 | 0.0   | 0.0        | 0.0  | 27.18       |
      | 6  | 30   | 20240701     |                  | 0.0             | 27.04         | 0.16     | 0.0  | 0.0       | 27.2  | 0.0   | 0.0        | 0.0  | 27.2        |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 150.0         | 2.93     | 0.0  | 0.0       | 152.93 | 17.01 | 0.0        | 0.0  | 135.92      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240131  | Accrual          | 0.56   | 0.0       | 0.56     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240201 | Repayment        | 17.01  | 16.43     | 0.58     | 0.0  | 0.0       | 83.57        | false    | false    |
      | 20240201 | Disbursement     | 50.0   | 0.0       | 0.0      | 0.0  | 0.0       | 133.57       | false    | false    |

    When Admin sets the business date to "20240315"
    When Admin runs inline COB job for Loan
    When Admin creates a Loan re-aging preview by Loan external ID with the following data:
      | frequencyNumber | frequencyType | startDate     | numberOfInstallments | reAgeInterestHandling            |
      | 1               | MONTHS        | 20240401 | 6                    | EQUAL_AMORTIZATION_FULL_INTEREST |
    Then Loan Re-Aged Repayment schedule preview has 9 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101   |                  | 100.0           | 0.0           | 0.0      | 0.0  | 0.0       | 0.0   | 0.0   |            |      |             |
      | 1  | 31   | 20240201  | 20240201 | 83.57           | 16.43         | 0.58     | 0.0  | 0.0       | 17.01 | 17.01 | 0.0        | 0.0  | 0.0         |
      |    |      | 20240201  |                  | 50.0            | 0.0           | 0.0      | 0.0  | 0.0       | 0.0   | 0.0   |            |      |             |
      | 2  | 29   | 20240301     | 20240315    | 133.57          | 0.0           | 0.0      | 0.0  | 0.0       | 0.0   | 0.0   | 0.0        | 0.0  | 0.0         |
      | 3  | 14   | 20240315     | 20240315    | 133.57          | 0.0           | 0.0      | 0.0  | 0.0       | 0.0   | 0.0   | 0.0        | 0.0  | 0.0         |
      | 4  | 17   | 20240401     |                  | 111.31          | 22.26         | 0.4      | 0.0  | 0.0       | 22.66 | 0.0   | 0.0        | 0.0  | 22.66       |
      | 5  | 30   | 20240501       |                  | 89.05           | 22.26         | 0.4      | 0.0  | 0.0       | 22.66 | 0.0   | 0.0        | 0.0  | 22.66       |
      | 6  | 31   | 20240601      |                  | 66.79           | 22.26         | 0.4      | 0.0  | 0.0       | 22.66 | 0.0   | 0.0        | 0.0  | 22.66       |
      | 7  | 30   | 20240701      |                  | 44.53           | 22.26         | 0.4      | 0.0  | 0.0       | 22.66 | 0.0   | 0.0        | 0.0  | 22.66       |
      | 8  | 31   | 20240801    |                  | 22.27           | 22.26         | 0.4      | 0.0  | 0.0       | 22.66 | 0.0   | 0.0        | 0.0  | 22.66       |
      | 9  | 31   | 20240901 |                  | 0.0             | 22.27         | 0.41     | 0.0  | 0.0       | 22.68 | 0.0   | 0.0        | 0.0  | 22.68       |
    Then Loan Re-Aged Repayment schedule preview has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 150.0         | 2.99     | 0.0  | 0.0       | 152.99 | 17.01 | 0.0        | 0.0  | 135.98      |

    When Loan Pay-off is made on "20240315"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C4361 @AdvancedPaymentAllocation
  Scenario: Verify Loan re-aging preview with charge and repayment - interest bearing loan with equal amortization; outstanding FULL interest - UC2.1
    When Admin sets the business date to "20240101"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                        | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_EMI_360_30_INTEREST_RECALCULATION_DAILY_TILL_PRECLOSE | 20240101   | 100            | 7                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 6                 | MONTHS                | 1              | MONTHS                 | 6                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
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

    When Admin sets the business date to "20240215"
    And Admin adds "LOAN_SNOOZE_FEE" due date charge with "20240215" due date and 10 EUR transaction amount
    Then Loan Charges tab has the following data:
      | Name       | isPenalty | Payment due at     | Due as of        | Calculation type | Due  | Paid | Waived | Outstanding |
      | Snooze fee | false     | Specified due date | 20240215 | Flat             | 10.0 | 0.0  | 0.0    | 10.0        |
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

    When Admin sets the business date to "20240216"
    And Customer makes "AUTOPAY" repayment on "20240216" with 10 EUR transaction amount
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

    When Admin sets the business date to "20240315"
    When Admin runs inline COB job for Loan
    When Admin creates a Loan re-aging preview by Loan external ID with the following data:
      | frequencyNumber | frequencyType | startDate     | numberOfInstallments | reAgeInterestHandling            |
      | 1               | MONTHS        | 20240401 | 6                    | EQUAL_AMORTIZATION_FULL_INTEREST |
    Then Loan Re-Aged Repayment schedule preview has 9 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101   |                  | 100.0           | 0.0           | 0.0      | 0.0  | 0.0       | 0.0   | 0.0   |            |      |             |
      | 1  | 31   | 20240201  | 20240201 | 83.57           | 16.43         | 0.58     | 0.0  | 0.0       | 17.01 | 17.01 | 0.0        | 0.0  | 0.0         |
      | 2  | 29   | 20240301     | 20240315    | 83.57           | 0.0           | 0.0      | 10.0 | 0.0       | 10.0  | 10.0  | 10.0       | 0.0  | 0.0         |
      | 3  | 14   | 20240315     | 20240315    | 83.57           | 0.0           | 0.0      | 0.0  | 0.0       | 0.0   | 0.0   | 0.0        | 0.0  | 0.0         |
      | 4  | 17   | 20240401     |                  | 69.64           | 13.93         | 0.25     | 0.0  | 0.0       | 14.18 | 0.0   | 0.0        | 0.0  | 14.18       |
      | 5  | 30   | 20240501       |                  | 55.71           | 13.93         | 0.25     | 0.0  | 0.0       | 14.18 | 0.0   | 0.0        | 0.0  | 14.18       |
      | 6  | 31   | 20240601      |                  | 41.78           | 13.93         | 0.25     | 0.0  | 0.0       | 14.18 | 0.0   | 0.0        | 0.0  | 14.18       |
      | 7  | 30   | 20240701      |                  | 27.85           | 13.93         | 0.25     | 0.0  | 0.0       | 14.18 | 0.0   | 0.0        | 0.0  | 14.18       |
      | 8  | 31   | 20240801    |                  | 13.92           | 13.93         | 0.25     | 0.0  | 0.0       | 14.18 | 0.0   | 0.0        | 0.0  | 14.18       |
      | 9  | 31   | 20240901 |                  | 0.0             | 13.92         | 0.26     | 0.0  | 0.0       | 14.18 | 0.0   | 0.0        | 0.0  | 14.18       |
    Then Loan Re-Aged Repayment schedule preview has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 100.0         | 2.09     | 10.0 | 0.0       | 112.09 | 27.01 | 10.0       | 0.0  | 85.08       |

    When Loan Pay-off is made on "20240315"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C4362 @AdvancedPaymentAllocation
  Scenario: Verify Loan re-aging preview with repayment and chargeback - interest bearing loan with equal amortization; outstanding FULL interest - UC3
    When Admin sets the business date to "20240101"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                        | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_EMI_360_30_INTEREST_RECALCULATION_DAILY_TILL_PRECLOSE | 20240101   | 100            | 7                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 6                 | MONTHS                | 1              | MONTHS                 | 6                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
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

    When Admin sets the business date to "20240315"
    When Admin runs inline COB job for Loan
    When Admin creates a Loan re-aging preview by Loan external ID with the following data:
      | frequencyNumber | frequencyType | startDate     | numberOfInstallments | reAgeInterestHandling            |
      | 1               | MONTHS        | 20240401 | 6                    | EQUAL_AMORTIZATION_FULL_INTEREST |
    Then Loan Re-Aged Repayment schedule preview has 9 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101   |                  | 100.0           | 0.0           | 0.0      | 0.0  | 0.0       | 0.0   | 0.0   |            |      |             |
      | 1  | 31   | 20240201  | 20240201 | 83.57           | 16.43         | 0.58     | 0.0  | 0.0       | 17.01 | 17.01 | 0.0        | 0.0  | 0.0         |
      | 2  | 29   | 20240301     | 20240315    | 100.58          | 0.0           | 0.0      | 0.0  | 0.0       | 0.0   | 0.0   | 0.0        | 0.0  | 0.0         |
      | 3  | 14   | 20240315     | 20240315    | 100.58          | 0.0           | 0.0      | 0.0  | 0.0       | 0.0   | 0.0   | 0.0        | 0.0  | 0.0         |
      | 4  | 17   | 20240401     |                  | 83.82           | 16.76         | 0.28     | 0.0  | 0.0       | 17.04 | 0.0   | 0.0        | 0.0  | 17.04       |
      | 5  | 30   | 20240501       |                  | 67.06           | 16.76         | 0.28     | 0.0  | 0.0       | 17.04 | 0.0   | 0.0        | 0.0  | 17.04       |
      | 6  | 31   | 20240601      |                  | 50.3            | 16.76         | 0.28     | 0.0  | 0.0       | 17.04 | 0.0   | 0.0        | 0.0  | 17.04       |
      | 7  | 30   | 20240701      |                  | 33.54           | 16.76         | 0.28     | 0.0  | 0.0       | 17.04 | 0.0   | 0.0        | 0.0  | 17.04       |
      | 8  | 31   | 20240801    |                  | 16.78           | 16.76         | 0.28     | 0.0  | 0.0       | 17.04 | 0.0   | 0.0        | 0.0  | 17.04       |
      | 9  | 31   | 20240901 |                  | 0.0             | 16.78         | 0.27     | 0.0  | 0.0       | 17.05 | 0.0   | 0.0        | 0.0  | 17.05       |
    Then Loan Re-Aged Repayment schedule preview has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 117.01        | 2.25     | 0.0  | 0.0       | 119.26 | 17.01 | 0.0        | 0.0  | 102.25      |

    When Loan Pay-off is made on "20240315"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C4363 @AdvancedPaymentAllocation
  Scenario: Verify Loan re-aging preview with repayment and charge - interest bearing loan with equal amortization; outstanding FULL interest - UC4
    When Admin sets the business date to "20240101"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                        | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_EMI_360_30_INTEREST_RECALCULATION_DAILY_TILL_PRECLOSE | 20240101   | 100            | 7                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 6                 | MONTHS                | 1              | MONTHS                 | 6                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
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

    And Admin adds "LOAN_SNOOZE_FEE" due date charge with "20240715" due date and 10 EUR transaction amount
    Then Loan Charges tab has the following data:
      | Name       | isPenalty | Payment due at     | Due as of    | Calculation type | Due  | Paid | Waived | Outstanding |
      | Snooze fee | false     | Specified due date | 20240715 | Flat             | 10.0 | 0.0  | 0.0    | 10.0        |

    When Admin sets the business date to "20240315"
    When Admin runs inline COB job for Loan
    When Admin creates a Loan re-aging preview by Loan external ID with the following data:
      | frequencyNumber | frequencyType | startDate     | numberOfInstallments | reAgeInterestHandling            |
      | 1               | MONTHS        | 20240401 | 6                    | EQUAL_AMORTIZATION_FULL_INTEREST |
    Then Loan Re-Aged Repayment schedule preview has 9 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101   |                  | 100.0           | 0.0           | 0.0      | 0.0  | 0.0       | 0.0   | 0.0   |            |      |             |
      | 1  | 31   | 20240201  | 20240201 | 83.57           | 16.43         | 0.58     | 0.0  | 0.0       | 17.01 | 17.01 | 0.0        | 0.0  | 0.0         |
      | 2  | 29   | 20240301     | 20240315    | 83.57           | 0.0           | 0.0      | 0.0  | 0.0       | 0.0   | 0.0   | 0.0        | 0.0  | 0.0         |
      | 3  | 14   | 20240315     | 20240315    | 83.57           | 0.0           | 0.0      | 0.0  | 0.0       | 0.0   | 0.0   | 0.0        | 0.0  | 0.0         |
      | 4  | 17   | 20240401     |                  | 69.64           | 13.93         | 0.25     | 1.67 | 0.0       | 15.85 | 0.0   | 0.0        | 0.0  | 15.85       |
      | 5  | 30   | 20240501       |                  | 55.71           | 13.93         | 0.25     | 1.67 | 0.0       | 15.85 | 0.0   | 0.0        | 0.0  | 15.85       |
      | 6  | 31   | 20240601      |                  | 41.78           | 13.93         | 0.25     | 1.67 | 0.0       | 15.85 | 0.0   | 0.0        | 0.0  | 15.85       |
      | 7  | 30   | 20240701      |                  | 27.85           | 13.93         | 0.25     | 1.67 | 0.0       | 15.85 | 0.0   | 0.0        | 0.0  | 15.85       |
      | 8  | 31   | 20240801    |                  | 13.92           | 13.93         | 0.25     | 1.67 | 0.0       | 15.85 | 0.0   | 0.0        | 0.0  | 15.85       |
      | 9  | 31   | 20240901 |                  | 0.0             | 13.92         | 0.26     | 1.65 | 0.0       | 15.83 | 0.0   | 0.0        | 0.0  | 15.83       |
    Then Loan Re-Aged Repayment schedule preview has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 100.0         | 2.09     | 10.0 | 0.0       | 112.09 | 17.01 | 0.0        | 0.0  | 95.08       |

    When Loan Pay-off is made on "20240315"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C4364 @AdvancedPaymentAllocation
  Scenario: Verify Loan re-aging preview with downpayment - interest bearing loan with equal amortization; outstanding FULL interest - UC7
    When Admin sets the business date to "20240101"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                          | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_RECALCULATION_DAILY_EMI_360_30_MULTIDISBURSE_AUTO_DOWNPAYMENT | 20240101   | 100            | 7                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 6                 | MONTHS                | 1              | MONTHS                 | 6                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
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
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101  |                  | 100.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 0    | 20240101  | 20240101  | 75.0            | 25.0          | 0.0      | 0.0  | 0.0       | 25.0  | 25.0  | 0.0        | 0.0  | 0.0         |
      | 2  | 31   | 20240201 | 20240201 | 62.68           | 12.32         | 0.44     | 0.0  | 0.0       | 12.76 | 12.76 | 0.0        | 0.0  | 0.0         |
      | 3  | 29   | 20240301    |                  | 50.29           | 12.39         | 0.37     | 0.0  | 0.0       | 12.76 | 0.0   | 0.0        | 0.0  | 12.76       |
      | 4  | 31   | 20240401    |                  | 37.82           | 12.47         | 0.29     | 0.0  | 0.0       | 12.76 | 0.0   | 0.0        | 0.0  | 12.76       |
      | 5  | 30   | 20240501      |                  | 25.28           | 12.54         | 0.22     | 0.0  | 0.0       | 12.76 | 0.0   | 0.0        | 0.0  | 12.76       |
      | 6  | 31   | 20240601     |                  | 12.67           | 12.61         | 0.15     | 0.0  | 0.0       | 12.76 | 0.0   | 0.0        | 0.0  | 12.76       |
      | 7  | 30   | 20240701     |                  | 0.0             | 12.67         | 0.07     | 0.0  | 0.0       | 12.74 | 0.0   | 0.0        | 0.0  | 12.74       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 100.0         | 1.54     | 0.0  | 0.0       | 101.54 | 37.76 | 0.0        | 0.0  | 63.78       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240101  | Down Payment     | 25.0   | 25.0      | 0.0      | 0.0  | 0.0       | 75.0         | false    | false    |
      | 20240201 | Repayment        | 12.76  | 12.32     | 0.44     | 0.0  | 0.0       | 62.68        | false    | false    |

    When Admin sets the business date to "20240315"
    When Admin runs inline COB job for Loan
    When Admin creates a Loan re-aging preview by Loan external ID with the following data:
      | frequencyNumber | frequencyType | startDate     | numberOfInstallments | reAgeInterestHandling            |
      | 1               | MONTHS        | 20240401 | 6                    | EQUAL_AMORTIZATION_FULL_INTEREST |
    Then Loan Re-Aged Repayment schedule preview has 10 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101   |                  | 100.0           | 0.0           | 0.0      | 0.0  | 0.0       | 0.0   | 0.0   |            |      |             |
      | 1  | 0    | 20240101   | 20240101  | 75.0            | 25.0          | 0.0      | 0.0  | 0.0       | 25.0  | 25.0  | 0.0        | 0.0  | 0.0         |
      | 2  | 31   | 20240201  | 20240201 | 62.68           | 12.32         | 0.44     | 0.0  | 0.0       | 12.76 | 12.76 | 0.0        | 0.0  | 0.0         |
      | 3  | 29   | 20240301     | 20240315    | 62.68           | 0.0           | 0.0      | 0.0  | 0.0       | 0.0   | 0.0   | 0.0        | 0.0  | 0.0         |
      | 4  | 14   | 20240315     | 20240315    | 62.68           | 0.0           | 0.0      | 0.0  | 0.0       | 0.0   | 0.0   | 0.0        | 0.0  | 0.0         |
      | 5  | 17   | 20240401     |                  | 52.23           | 10.45         | 0.19     | 0.0  | 0.0       | 10.64 | 0.0   | 0.0        | 0.0  | 10.64       |
      | 6  | 30   | 20240501       |                  | 41.78           | 10.45         | 0.19     | 0.0  | 0.0       | 10.64 | 0.0   | 0.0        | 0.0  | 10.64       |
      | 7  | 31   | 20240601      |                  | 31.33           | 10.45         | 0.19     | 0.0  | 0.0       | 10.64 | 0.0   | 0.0        | 0.0  | 10.64       |
      | 8  | 30   | 20240701      |                  | 20.88           | 10.45         | 0.19     | 0.0  | 0.0       | 10.64 | 0.0   | 0.0        | 0.0  | 10.64       |
      | 9  | 31   | 20240801    |                  | 10.43           | 10.45         | 0.19     | 0.0  | 0.0       | 10.64 | 0.0   | 0.0        | 0.0  | 10.64       |
      | 10 | 31   | 20240901 |                  | 0.0             | 10.43         | 0.19     | 0.0  | 0.0       | 10.62 | 0.0   | 0.0        | 0.0  | 10.62       |
    Then Loan Re-Aged Repayment schedule preview has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 100.0         | 1.58     | 0.0  | 0.0       | 101.58 | 37.76 | 0.0        | 0.0  | 63.82       |

    When Loan Pay-off is made on "20240315"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C4365 @AdvancedPaymentAllocation
  Scenario: Verify Loan re-aging preview with MIR trn before re-age - interest bearing multidisb loan with equal amortization; outstanding FULL interest - UC1.3
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

    When Admin sets the business date to "20240301"
    When Admin makes "MERCHANT_ISSUED_REFUND" transaction with "AUTOPAY" payment type on "20240301" with 34.02 EUR transaction amount
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101  |                  | 100.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 31   | 20240201 | 20240201 | 83.57           | 16.43         | 0.58     | 0.0  | 0.0       | 17.01 | 17.01 | 0.0        | 0.0  | 0.0         |
      | 2  | 29   | 20240301    | 20240301    | 67.05           | 16.52         | 0.49     | 0.0  | 0.0       | 17.01 | 17.01 | 0.0        | 0.0  | 0.0         |
      | 3  | 31   | 20240401    |                  | 50.33           | 16.72         | 0.29     | 0.0  | 0.0       | 17.01 | 4.25  | 4.25       | 0.0  | 12.76      |
      | 4  | 30   | 20240501      |                  | 33.54           | 16.79         | 0.22     | 0.0  | 0.0       | 17.01 | 4.25  | 4.25       | 0.0  | 12.76       |
      | 5  | 31   | 20240601     |                  | 16.68           | 16.86         | 0.15     | 0.0  | 0.0       | 17.01 | 4.25  | 4.25       | 0.0  | 12.76       |
      | 6  | 30   | 20240701     |                  | 0.0             | 16.68         | 0.07     | 0.0  | 0.0       | 16.75 | 4.26  | 4.26       | 0.0  | 12.49       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 100.0         | 1.8      | 0.0  | 0.0       | 101.8  | 51.03 | 17.01      | 0.0  | 50.77       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type       | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement           | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240201 | Repayment              | 17.01  | 16.43     | 0.58     | 0.0  | 0.0       | 83.57        | false    | false    |
      | 20240301    | Merchant Issued Refund | 34.02  | 33.53     | 0.49     | 0.0  | 0.0       | 50.04        | false    | false    |

    When Admin sets the business date to "20240315"
    When Admin creates a Loan re-aging preview by Loan external ID with the following data:
      | frequencyNumber | frequencyType | startDate     | numberOfInstallments | reAgeInterestHandling            |
      | 1               | MONTHS        | 20240401 | 6                    | EQUAL_AMORTIZATION_FULL_INTEREST |
    Then Loan Re-Aged Repayment schedule preview has 9 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101   |                  | 100.0           | 0.0           | 0.0      | 0.0  | 0.0       | 0.0   | 0.0   |            |      |             |
      | 1  | 31   | 20240201  | 20240201 | 83.57           | 16.43         | 0.58     | 0.0  | 0.0       | 17.01 | 17.01 | 0.0        | 0.0  | 0.0         |
      | 2  | 29   | 20240301     | 20240301    | 67.05           | 16.52         | 0.49     | 0.0  | 0.0       | 17.01 | 17.01 | 0.0        | 0.0  | 0.0         |
      | 3  | 14   | 20240315     | 20240315    | 50.04           | 17.01         | 0.0      | 0.0  | 0.0       | 17.01 | 17.01 | 17.01      | 0.0  | 0.0          |
      | 4  | 17   | 20240401     |                  | 41.7            | 8.34          | 0.12     | 0.0  | 0.0       | 8.46  | 0.0   | 0.0        | 0.0  | 8.46        |
      | 5  | 30   | 20240501       |                  | 33.36           | 8.34          | 0.12     | 0.0  | 0.0       | 8.46  | 0.0   | 0.0        | 0.0  | 8.46        |
      | 6  | 31   | 20240601      |                  | 25.02           | 8.34          | 0.12     | 0.0  | 0.0       | 8.46  | 0.0   | 0.0        | 0.0  | 8.46        |
      | 7  | 30   | 20240701      |                  | 16.68           | 8.34          | 0.12     | 0.0  | 0.0       | 8.46  | 0.0   | 0.0        | 0.0  | 8.46        |
      | 8  | 31   | 20240801    |                  |  8.34           | 8.34          | 0.12     | 0.0  | 0.0       | 8.46  | 0.0   | 0.0        | 0.0  | 8.46        |
      | 9  | 31   | 20240901 |                  |  0.0            | 8.34          | 0.13     | 0.0  | 0.0       | 8.47  | 0.0   | 0.0        | 0.0  | 8.47        |
    Then Loan Re-Aged Repayment schedule preview has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 100.0         | 1.8      | 0.0  | 0.0       | 101.8  | 51.03 | 17.01      | 0.0  | 50.77       |

    When Loan Pay-off is made on "20240315"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C_10 @AdvancedPaymentAllocation
  Scenario: Verify Loan re-aging preview with backdated re-aging before 2nd disb - interest bearing multidisb loan with equal amortization; outstanding payable interest - UC5
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
    When Admin creates a Loan re-aging preview by Loan external ID with the following data:
      | frequencyNumber | frequencyType | startDate     | numberOfInstallments | reAgeInterestHandling               |
      | 1               | MONTHS        | 20240315 | 6                    | EQUAL_AMORTIZATION_PAYABLE_INTEREST |
    Then Loan Re-Aged Repayment schedule preview has 9 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101   |                  | 100.0           | 0.0           | 0.0      | 0.0  | 0.0       | 0.0   | 0.0   |            |      |             |
      | 1  | 31   | 20240201  | 20240201 | 83.57           | 16.43         | 0.58     | 0.0  | 0.0       | 17.01 | 17.01 | 0.0        | 0.0  | 0.0         |
      | 2  | 29   | 20240301     | 20240315    | 83.57           |  0.0          | 0.0      | 0.0  | 0.0       | 0.0   | 0.0   | 0.0        | 0.0  | 0.0         |
      | 3  | 14   | 20240315     | 20240315    | 83.57           | 0.0           | 0.0      | 0.0  | 0.0       | 0.0   | 0.0   | 0.0        | 0.0  | 0.0         |
      | 4  | 0    | 20240315     |                  | 69.64           | 13.93         | 0.12     | 0.0  | 0.0       | 14.05 | 0.0   | 0.0        | 0.0  | 14.05       |
      |    |      | 20240401     |                  | 50.0            | 0.0           | 0.0      | 0.0  | 0.0       | 0.0   | 0.0   |            |      |             |
      | 5  | 31   | 20240415     |                  | 95.71           | 23.93         | 0.12     | 0.0  | 0.0       | 24.05 | 0.0   | 0.0        | 0.0  | 24.05       |
      | 6  | 30   | 20240515       |                  | 71.78           | 23.93         | 0.12     | 0.0  | 0.0       | 24.05 | 0.0   | 0.0        | 0.0  | 24.05       |
      | 7  | 31   | 20240615      |                  | 47.85           | 23.93         | 0.12     | 0.0  | 0.0       | 24.05 | 0.0   | 0.0        | 0.0  | 24.05       |
      | 8  | 30   | 20240715      |                  | 23.92           | 23.93         | 0.12     | 0.0  | 0.0       | 24.05 | 0.0   | 0.0        | 0.0  | 24.05       |
      | 9  | 31   | 20240815    |                  |  0.0            | 23.92         | 0.11     | 0.0  | 0.0       | 24.03 | 0.0   | 0.0        | 0.0  | 24.03       |
    Then Loan Re-Aged Repayment schedule preview has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 150.0         | 1.29     | 0.0  | 0.0       | 151.29 | 17.01 | 0.0        | 0.0  | 134.28      |

    When Loan Pay-off is made on "20240401"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C4690 @AdvancedPaymentAllocation
  Scenario: Verify Loan re-aging trn preview and actual repayment schedule - interest bearing loan with equal amortization; outstanding payable interest - UC1
    When Admin sets the business date to "20250912"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                   | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_EMI_ACTUAL_ACTUAL_NO_INTEREST_RECALC_REFUND_FULL | 20250912 | 1200           | 9.99                   | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 6                 | MONTHS                | 1              | MONTHS                 | 6                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20250912" with "1200" amount and expected disbursement date on "20250912"
    When Admin successfully disburse the loan on "20250912" with "1200" EUR transaction amount
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      |    |      | 20250912 |           | 1200.0          |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      | 1  | 30   | 20251012   |           | 1003.99         | 196.01        | 9.85     | 0.0  | 0.0       | 205.86 | 0.0  | 0.0        | 0.0  | 205.86      |
      | 2  | 31   | 20251112  |           | 806.65          | 197.34        | 8.52     | 0.0  | 0.0       | 205.86 | 0.0  | 0.0        | 0.0  | 205.86      |
      | 3  | 30   | 20251212  |           | 607.41          | 199.24        | 6.62     | 0.0  | 0.0       | 205.86 | 0.0  | 0.0        | 0.0  | 205.86      |
      | 4  | 31   | 20260112   |           | 406.7           | 200.71        | 5.15     | 0.0  | 0.0       | 205.86 | 0.0  | 0.0        | 0.0  | 205.86      |
      | 5  | 31   | 20260212  |           | 204.29          | 202.41        | 3.45     | 0.0  | 0.0       | 205.86 | 0.0  | 0.0        | 0.0  | 205.86      |
      | 6  | 28   | 20260312     |           | 0.0             | 204.29        | 1.57     | 0.0  | 0.0       | 205.86 | 0.0  | 0.0        | 0.0  | 205.86      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid | In advance | Late | Outstanding |
      | 1200.0        | 35.16    | 0.0  | 0.0       | 1235.16 | 0.0  | 0.0        | 0.0  | 1235.16     |
    Then Loan Transactions tab has the following data:
      | Transaction date  | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20250912 | Disbursement     | 1200.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1200.0       | false    | false    |
    When Admin sets the business date to "20251012"
    And Customer makes "AUTOPAY" repayment on "20251012" with 200 EUR transaction amount
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      |    |      | 20250912 |           | 1200.0          |               |          | 0.0  |           | 0.0    | 0.0   |            |      |             |
      | 1  | 30   | 20251012   |           | 1003.99         | 196.01        | 9.85     | 0.0  | 0.0       | 205.86 | 200.0 | 0.0        | 0.0  | 5.86        |
      | 2  | 31   | 20251112  |           | 806.65          | 197.34        | 8.52     | 0.0  | 0.0       | 205.86 | 0.0   | 0.0        | 0.0  | 205.86      |
      | 3  | 30   | 20251212  |           | 607.41          | 199.24        | 6.62     | 0.0  | 0.0       | 205.86 | 0.0   | 0.0        | 0.0  | 205.86      |
      | 4  | 31   | 20260112   |           | 406.7           | 200.71        | 5.15     | 0.0  | 0.0       | 205.86 | 0.0   | 0.0        | 0.0  | 205.86      |
      | 5  | 31   | 20260212  |           | 204.29          | 202.41        | 3.45     | 0.0  | 0.0       | 205.86 | 0.0   | 0.0        | 0.0  | 205.86      |
      | 6  | 28   | 20260312     |           | 0.0             | 204.29        | 1.57     | 0.0  | 0.0       | 205.86 | 0.0   | 0.0        | 0.0  | 205.86      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid  | In advance | Late | Outstanding |
      | 1200.0        | 35.16    | 0.0  | 0.0       | 1235.16 | 200.0 | 0.0        | 0.0  | 1035.16     |
    Then Loan Transactions tab has the following data:
      | Transaction date  | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20250912 | Disbursement     | 1200.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1200.0       | false    | false    |
      | 20251012   | Repayment        | 200.0  | 196.01    | 3.99     | 0.0  | 0.0       | 1003.99      | false    | false    |
    When Admin sets the business date to "20260212"
    When Admin runs inline COB job for Loan
    When Admin creates a Loan re-aging preview by Loan external ID with the following data:
      | frequencyNumber | frequencyType | startDate        | numberOfInstallments | reAgeInterestHandling               |
      | 1               | MONTHS        | 20260212 | 10                   | EQUAL_AMORTIZATION_PAYABLE_INTEREST |
    Then Loan Re-Aged Repayment schedule preview has 15 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      |    |      | 20250912 |                  | 1200.0          | 0.0           | 0.0      | 0.0  | 0.0       | 0.0    | 0.0   |            |      |             |
      | 1  | 30   | 20251012   | 20260212 | 1003.99         | 196.01        | 3.99     | 0.0  | 0.0       | 200.0  | 200.0 | 0.0        | 0.0  | 0.0         |
      | 2  | 31   | 20251112  | 20260212 | 1003.99         | 0.0           | 0.0      | 0.0  | 0.0       | 0.0    | 0.0   | 0.0        | 0.0  | 0.0         |
      | 3  | 30   | 20251212  | 20260212 | 1003.99         | 0.0           | 0.0      | 0.0  | 0.0       | 0.0    | 0.0   | 0.0        | 0.0  | 0.0         |
      | 4  | 31   | 20260112   | 20260212 | 1003.99         | 0.0           | 0.0      | 0.0  | 0.0       | 0.0    | 0.0   | 0.0        | 0.0  | 0.0         |
      | 5  | 31   | 20260212  | 20260212 | 1003.99         | 0.0           | 0.0      | 0.0  | 0.0       | 0.0    | 0.0   | 0.0        | 0.0  | 0.0         |
      | 6  | 0    | 20260212  |                  | 903.59          | 100.4         | 3.36     | 0.0  | 0.0       | 103.76 | 0.0   | 0.0        | 0.0  | 103.76      |
      | 7  | 28   | 20260312     |                  | 803.19          | 100.4         | 3.36     | 0.0  | 0.0       | 103.76 | 0.0   | 0.0        | 0.0  | 103.76      |
      | 8  | 31   | 20260412     |                  | 702.79          | 100.4         | 3.36     | 0.0  | 0.0       | 103.76 | 0.0   | 0.0        | 0.0  | 103.76      |
      | 9  | 30   | 20260512       |                  | 602.39          | 100.4         | 3.36     | 0.0  | 0.0       | 103.76 | 0.0   | 0.0        | 0.0  | 103.76      |
      | 10 | 31   | 20260612      |                  | 501.99          | 100.4         | 3.36     | 0.0  | 0.0       | 103.76 | 0.0   | 0.0        | 0.0  | 103.76      |
      | 11 | 30   | 20260712      |                  | 401.59          | 100.4         | 3.36     | 0.0  | 0.0       | 103.76 | 0.0   | 0.0        | 0.0  | 103.76      |
      | 12 | 31   | 20260812    |                  | 301.19          | 100.4         | 3.36     | 0.0  | 0.0       | 103.76 | 0.0   | 0.0        | 0.0  | 103.76      |
      | 13 | 31   | 20260912 |                  | 200.79          | 100.4         | 3.36     | 0.0  | 0.0       | 103.76 | 0.0   | 0.0        | 0.0  | 103.76      |
      | 14 | 30   | 20261012   |                  | 100.39          | 100.4         | 3.36     | 0.0  | 0.0       | 103.76 | 0.0   | 0.0        | 0.0  | 103.76      |
      | 15 | 31   | 20261112  |                  | 0.0             | 100.39        | 3.35     | 0.0  | 0.0       | 103.74 | 0.0   | 0.0        | 0.0  | 103.74      |
    Then Loan Re-Aged Repayment schedule preview has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid  | In advance | Late | Outstanding |
      | 1200.0        | 37.58    | 0.0  | 0.0       | 1237.58 | 200.0 | 0.0        | 0.0  | 1037.58     |
    When Admin creates a Loan re-aging transaction by Loan external ID with the following data:
      | frequencyNumber | frequencyType | startDate        | numberOfInstallments | reAgeInterestHandling               |
      | 1               | MONTHS        | 20260212 | 10                   | EQUAL_AMORTIZATION_PAYABLE_INTEREST |
    Then Loan Repayment schedule has 15 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      |    |      | 20250912 |                  | 1200.0          |               |          | 0.0  |           | 0.0    | 0.0   |            |      |             |
      | 1  | 30   | 20251012   | 20260212 | 1003.99         | 196.01        | 3.99     | 0.0  | 0.0       | 200.0  | 200.0 | 0.0        | 0.0  | 0.0         |
      | 2  | 31   | 20251112  | 20260212 | 1003.99         | 0.0           | 0.0      | 0.0  | 0.0       | 0.0    | 0.0   | 0.0        | 0.0  | 0.0         |
      | 3  | 30   | 20251212  | 20260212 | 1003.99         | 0.0           | 0.0      | 0.0  | 0.0       | 0.0    | 0.0   | 0.0        | 0.0  | 0.0         |
      | 4  | 31   | 20260112   | 20260212 | 1003.99         | 0.0           | 0.0      | 0.0  | 0.0       | 0.0    | 0.0   | 0.0        | 0.0  | 0.0         |
      | 5  | 31   | 20260212  | 20260212 | 1003.99         | 0.0           | 0.0      | 0.0  | 0.0       | 0.0    | 0.0   | 0.0        | 0.0  | 0.0         |
      | 6  | 0    | 20260212  |                  | 903.59          | 100.4         | 3.36     | 0.0  | 0.0       | 103.76 | 0.0   | 0.0        | 0.0  | 103.76      |
      | 7  | 28   | 20260312     |                  | 803.19          | 100.4         | 3.36     | 0.0  | 0.0       | 103.76 | 0.0   | 0.0        | 0.0  | 103.76      |
      | 8  | 31   | 20260412     |                  | 702.79          | 100.4         | 3.36     | 0.0  | 0.0       | 103.76 | 0.0   | 0.0        | 0.0  | 103.76      |
      | 9  | 30   | 20260512       |                  | 602.39          | 100.4         | 3.36     | 0.0  | 0.0       | 103.76 | 0.0   | 0.0        | 0.0  | 103.76      |
      | 10 | 31   | 20260612      |                  | 501.99          | 100.4         | 3.36     | 0.0  | 0.0       | 103.76 | 0.0   | 0.0        | 0.0  | 103.76      |
      | 11 | 30   | 20260712      |                  | 401.59          | 100.4         | 3.36     | 0.0  | 0.0       | 103.76 | 0.0   | 0.0        | 0.0  | 103.76      |
      | 12 | 31   | 20260812    |                  | 301.19          | 100.4         | 3.36     | 0.0  | 0.0       | 103.76 | 0.0   | 0.0        | 0.0  | 103.76      |
      | 13 | 31   | 20260912 |                  | 200.79          | 100.4         | 3.36     | 0.0  | 0.0       | 103.76 | 0.0   | 0.0        | 0.0  | 103.76      |
      | 14 | 30   | 20261012   |                  | 100.39          | 100.4         | 3.36     | 0.0  | 0.0       | 103.76 | 0.0   | 0.0        | 0.0  | 103.76      |
      | 15 | 31   | 20261112  |                  | 0.0             | 100.39        | 3.35     | 0.0  | 0.0       | 103.74 | 0.0   | 0.0        | 0.0  | 103.74      |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid  | In advance | Late | Outstanding |
      | 1200.0        | 37.58    | 0.0  | 0.0       | 1237.58 | 200.0 | 0.0        | 0.0  | 1037.58     |
    Then Loan Transactions tab has the following data:
      | Transaction date  | Transaction Type | Amount  | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20250912 | Disbursement     | 1200.0  | 0.0       | 0.0      | 0.0  | 0.0       | 1200.0       | false    | false    |
      | 20251012   | Repayment        | 200.0   | 196.01    | 3.99     | 0.0  | 0.0       | 1003.99      | false    | false    |
      | 20260211  | Accrual          | 33.48   | 0.0       | 33.48    | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20260212  | Re-age           | 1037.58 | 1003.99   | 33.59    | 0.0  | 0.0       | 0.0          | false    | false    |
    When Loan Pay-off is made on "20260212"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C4691 @AdvancedPaymentAllocation
  Scenario: Verify Loan re-aging trn preview and actual repayment schedule - interest bearing loan with equal amortization; outstanding FULL interest - UC2
    When Admin sets the business date to "20251012"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                   | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_CUSTOM_PMT_ALLOC_PROGRESSIVE_LOAN_SCHEDULE_HORIZONTAL_ZERO_CHARGE_OFF | 20250912   | 1200           | 9.99                   | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 6                 | MONTHS                | 1              | MONTHS                 | 6                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20250912" with "1200" amount and expected disbursement date on "20250912"
    When Admin successfully disburse the loan on "20250912" with "1200" EUR transaction amount
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      |    |      | 20250912 |           | 1200.0          |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      | 1  | 30   | 20251012   |           | 1004.12         | 195.88        | 9.99     | 0.0  | 0.0       | 205.87 | 0.0  | 0.0        | 0.0  | 205.87      |
      | 2  | 31   | 20251112  |           | 806.61          | 197.51        | 8.36     | 0.0  | 0.0       | 205.87 | 0.0  | 0.0        | 0.0  | 205.87      |
      | 3  | 30   | 20251212  |           | 607.46          | 199.15        | 6.72     | 0.0  | 0.0       | 205.87 | 0.0  | 0.0        | 0.0  | 205.87      |
      | 4  | 31   | 20260112   |           | 406.65          | 200.81        | 5.06     | 0.0  | 0.0       | 205.87 | 0.0  | 0.0        | 0.0  | 205.87      |
      | 5  | 31   | 20260212  |           | 204.17          | 202.48        | 3.39     | 0.0  | 0.0       | 205.87 | 0.0  | 0.0        | 0.0  | 205.87      |
      | 6  | 28   | 20260312     |           | 0.0             | 204.17        | 1.7      | 0.0  | 0.0       | 205.87 | 0.0  | 0.0        | 0.0  | 205.87      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid | In advance | Late | Outstanding |
      | 1200.0        | 35.22    | 0.0  | 0.0       | 1235.22 | 0.0  | 0.0        | 0.0  | 1235.22     |
    Then Loan Transactions tab has the following data:
      | Transaction date  | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20250912 | Disbursement     | 1200.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1200.0       | false    | false    |
    When Admin sets the business date to "20251012"
    And Customer makes "AUTOPAY" repayment on "20251012" with 200 EUR transaction amount
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      |    |      | 20250912 |           | 1200.0          |               |          | 0.0  |           | 0.0    | 0.0   |            |      |             |
      | 1  | 30   | 20251012   |           | 1004.12         | 195.88        | 9.99     | 0.0  | 0.0       | 205.87 | 200.0 | 0.0        | 0.0  | 5.87        |
      | 2  | 31   | 20251112  |           | 806.61          | 197.51        | 8.36     | 0.0  | 0.0       | 205.87 | 0.0   | 0.0        | 0.0  | 205.87      |
      | 3  | 30   | 20251212  |           | 607.46          | 199.15        | 6.72     | 0.0  | 0.0       | 205.87 | 0.0   | 0.0        | 0.0  | 205.87      |
      | 4  | 31   | 20260112   |           | 406.65          | 200.81        | 5.06     | 0.0  | 0.0       | 205.87 | 0.0   | 0.0        | 0.0  | 205.87      |
      | 5  | 31   | 20260212  |           | 204.17          | 202.48        | 3.39     | 0.0  | 0.0       | 205.87 | 0.0   | 0.0        | 0.0  | 205.87      |
      | 6  | 28   | 20260312     |           | 0.0             | 204.17        | 1.7      | 0.0  | 0.0       | 205.87 | 0.0   | 0.0        | 0.0  | 205.87      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid  | In advance | Late | Outstanding |
      | 1200.0        | 35.22    | 0.0  | 0.0       | 1235.22 | 200.0 | 0.0        | 0.0  | 1035.22     |
    Then Loan Transactions tab has the following data:
      | Transaction date  | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20250912 | Disbursement     | 1200.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1200.0       | false    | false    |
      | 20251012   | Repayment        | 200.0  | 190.01    | 9.99     | 0.0  | 0.0       | 1009.99      | false    | false    |
    When Admin sets the business date to "20260224"
    When Admin runs inline COB job for Loan
    When Admin creates a Loan re-aging preview by Loan external ID with the following data:
      | frequencyNumber | frequencyType | startDate        | numberOfInstallments | reAgeInterestHandling            |
      | 1               | MONTHS        | 20260212 | 10                   | EQUAL_AMORTIZATION_FULL_INTEREST |
    Then Loan Re-Aged Repayment schedule preview has 15 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      |    |      | 20250912 |                  | 1200.0          | 0.0           | 0.0      | 0.0  | 0.0       | 0.0    | 0.0   |            |      |             |
      | 1  | 30   | 20251012   | 20260212 | 1009.99         | 190.01        | 9.99     | 0.0  | 0.0       | 200.0  | 200.0 | 0.0        | 0.0  | 0.0         |
      | 2  | 31   | 20251112  | 20260212 | 1009.99         | 0.0           | 0.0      | 0.0  | 0.0       | 0.0    | 0.0   | 0.0        | 0.0  | 0.0         |
      | 3  | 30   | 20251212  | 20260212 | 1009.99         | 0.0           | 0.0      | 0.0  | 0.0       | 0.0    | 0.0   | 0.0        | 0.0  | 0.0         |
      | 4  | 31   | 20260112   | 20260212 | 1009.99         | 0.0           | 0.0      | 0.0  | 0.0       | 0.0    | 0.0   | 0.0        | 0.0  | 0.0         |
      | 5  | 31   | 20260212  | 20260212 | 1009.99         | 0.0           | 0.0      | 0.0  | 0.0       | 0.0    | 0.0   | 0.0        | 0.0  | 0.0         |
      | 6  | 0    | 20260212  |                  | 908.99          | 101.0         | 3.54     | 0.0  | 0.0       | 104.54 | 0.0   | 0.0        | 0.0  | 104.54      |
      | 7  | 28   | 20260312     |                  | 807.99          | 101.0         | 3.54     | 0.0  | 0.0       | 104.54 | 0.0   | 0.0        | 0.0  | 104.54      |
      | 8  | 31   | 20260412     |                  | 706.99          | 101.0         | 3.54     | 0.0  | 0.0       | 104.54 | 0.0   | 0.0        | 0.0  | 104.54      |
      | 9  | 30   | 20260512       |                  | 605.99          | 101.0         | 3.54     | 0.0  | 0.0       | 104.54 | 0.0   | 0.0        | 0.0  | 104.54      |
      | 10 | 31   | 20260612      |                  | 504.99          | 101.0         | 3.54     | 0.0  | 0.0       | 104.54 | 0.0   | 0.0        | 0.0  | 104.54      |
      | 11 | 30   | 20260712      |                  | 403.99          | 101.0         | 3.54     | 0.0  | 0.0       | 104.54 | 0.0   | 0.0        | 0.0  | 104.54      |
      | 12 | 31   | 20260812    |                  | 302.99          | 101.0         | 3.54     | 0.0  | 0.0       | 104.54 | 0.0   | 0.0        | 0.0  | 104.54      |
      | 13 | 31   | 20260912 |                  | 201.99          | 101.0         | 3.54     | 0.0  | 0.0       | 104.54 | 0.0   | 0.0        | 0.0  | 104.54      |
      | 14 | 30   | 20261012   |                  | 100.99          | 101.0         | 3.54     | 0.0  | 0.0       | 104.54 | 0.0   | 0.0        | 0.0  | 104.54      |
      | 15 | 31   | 20261112  |                  | 0.0             | 100.99        | 3.56     | 0.0  | 0.0       | 104.55 | 0.0   | 0.0        | 0.0  | 104.55      |
    Then Loan Re-Aged Repayment schedule preview has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid  | In advance | Late | Outstanding |
      | 1200.0        | 45.41    | 0.0  | 0.0       | 1245.41 | 200.0 | 0.0        | 0.0  | 1045.41     |
    When Admin creates a Loan re-aging transaction by Loan external ID with the following data:
      | frequencyNumber | frequencyType | startDate        | numberOfInstallments | reAgeInterestHandling            |
      | 1               | MONTHS        | 20260212 | 10                   | EQUAL_AMORTIZATION_FULL_INTEREST |
    Then Loan Repayment schedule has 15 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      |    |      | 20250912 |                  | 1200.0          |               |          | 0.0  |           | 0.0    | 0.0   |            |      |             |
      | 1  | 30   | 20251012   | 20260212 | 1009.99         | 190.01        | 9.99     | 0.0  | 0.0       | 200.0  | 200.0 | 0.0        | 0.0  | 0.0         |
      | 2  | 31   | 20251112  | 20260212 | 1009.99         | 0.0           | 0.0      | 0.0  | 0.0       | 0.0    | 0.0   | 0.0        | 0.0  | 0.0         |
      | 3  | 30   | 20251212  | 20260212 | 1009.99         | 0.0           | 0.0      | 0.0  | 0.0       | 0.0    | 0.0   | 0.0        | 0.0  | 0.0         |
      | 4  | 31   | 20260112   | 20260212 | 1009.99         | 0.0           | 0.0      | 0.0  | 0.0       | 0.0    | 0.0   | 0.0        | 0.0  | 0.0         |
      | 5  | 31   | 20260212  | 20260212 | 1009.99         | 0.0           | 0.0      | 0.0  | 0.0       | 0.0    | 0.0   | 0.0        | 0.0  | 0.0         |
      | 6  | 0    | 20260212  |                  | 908.99          | 101.0         | 3.54     | 0.0  | 0.0       | 104.54 | 0.0   | 0.0        | 0.0  | 104.54      |
      | 7  | 28   | 20260312     |                  | 807.99          | 101.0         | 3.54     | 0.0  | 0.0       | 104.54 | 0.0   | 0.0        | 0.0  | 104.54      |
      | 8  | 31   | 20260412     |                  | 706.99          | 101.0         | 3.54     | 0.0  | 0.0       | 104.54 | 0.0   | 0.0        | 0.0  | 104.54      |
      | 9  | 30   | 20260512       |                  | 605.99          | 101.0         | 3.54     | 0.0  | 0.0       | 104.54 | 0.0   | 0.0        | 0.0  | 104.54      |
      | 10 | 31   | 20260612      |                  | 504.99          | 101.0         | 3.54     | 0.0  | 0.0       | 104.54 | 0.0   | 0.0        | 0.0  | 104.54      |
      | 11 | 30   | 20260712      |                  | 403.99          | 101.0         | 3.54     | 0.0  | 0.0       | 104.54 | 0.0   | 0.0        | 0.0  | 104.54      |
      | 12 | 31   | 20260812    |                  | 302.99          | 101.0         | 3.54     | 0.0  | 0.0       | 104.54 | 0.0   | 0.0        | 0.0  | 104.54      |
      | 13 | 31   | 20260912 |                  | 201.99          | 101.0         | 3.54     | 0.0  | 0.0       | 104.54 | 0.0   | 0.0        | 0.0  | 104.54      |
      | 14 | 30   | 20261012   |                  | 100.99          | 101.0         | 3.54     | 0.0  | 0.0       | 104.54 | 0.0   | 0.0        | 0.0  | 104.54      |
      | 15 | 31   | 20261112  |                  | 0.0             | 100.99        | 3.56     | 0.0  | 0.0       | 104.55 | 0.0   | 0.0        | 0.0  | 104.55      |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid  | In advance | Late | Outstanding |
      | 1200.0        | 45.41    | 0.0  | 0.0       | 1245.41 | 200.0 | 0.0        | 0.0  | 1045.41     |
    Then Loan Transactions tab has the following data:
      | Transaction date  | Transaction Type | Amount  | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20250912 | Disbursement     | 1200.0  | 0.0       | 0.0      | 0.0  | 0.0       | 1200.0       | false    | false    |
      | 20251012   | Repayment        | 200.0   | 190.01    | 9.99     | 0.0  | 0.0       | 1009.99      | false    | false    |
      | 20251012   | Accrual Activity | 9.99    | 0.0       | 9.99     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20260212  | Accrual Activity | 3.54    | 0.0       | 3.54     | 0.0  | 0.0       | 0.0          | false    | true     |
      | 20260212  | Re-age           | 1045.41 | 1009.99   | 35.42    | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20260223  | Accrual          | 36.82   | 0.0       | 36.82    | 0.0  | 0.0       | 0.0          | false    | false    |
    When Loan Pay-off is made on "20260224"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C4692 @AdvancedPaymentAllocation
  Scenario: Re-aging preview should not accumulate 1-day periods after repeated re-aging across month-end
    When Admin sets the business date to "20260128"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                              | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_INTEREST_RECALCULATION_CONTRACT_TERMINATION | 20260128   | 100            | 7                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 6                 | MONTHS                | 1              | MONTHS                 | 6                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20260128" with "100" amount and expected disbursement date on "20260128"
    When Admin successfully disburse the loan on "20260128" with "100" EUR transaction amount
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20260128   |           | 100.0           |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 31   | 20260228  |           | 83.57           | 16.43         | 0.58     | 0.0  | 0.0       | 17.01 | 0.0  | 0.0        | 0.0  | 17.01       |
      | 2  | 28   | 20260328     |           | 67.05           | 16.52         | 0.49     | 0.0  | 0.0       | 17.01 | 0.0  | 0.0        | 0.0  | 17.01       |
      | 3  | 31   | 20260428     |           | 50.43           | 16.62         | 0.39     | 0.0  | 0.0       | 17.01 | 0.0  | 0.0        | 0.0  | 17.01       |
      | 4  | 30   | 20260528       |           | 33.71           | 16.72         | 0.29     | 0.0  | 0.0       | 17.01 | 0.0  | 0.0        | 0.0  | 17.01       |
      | 5  | 31   | 20260628      |           | 16.9            | 16.81         | 0.2      | 0.0  | 0.0       | 17.01 | 0.0  | 0.0        | 0.0  | 17.01       |
      | 6  | 30   | 20260728      |           | 0.0             | 16.9          | 0.1      | 0.0  | 0.0       | 17.0  | 0.0  | 0.0        | 0.0  | 17.0        |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 100.0         | 2.05     | 0.0  | 0.0       | 102.05 | 0.0  | 0.0        | 0.0  | 102.05      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20260128  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
# --- first re-age on disbursement date 20260128 --- #
    When Admin creates a Loan re-aging transaction with the following data:
      | frequencyNumber | frequencyType | startDate        | numberOfInstallments |
      | 1               | MONTHS        | 20260228 | 6                    |
    Then Loan Repayment schedule has 7 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20260128   |                  | 100.0           |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 0    | 20260128   | 20260128  | 100.0           | 0.0           | 0.0      | 0.0  | 0.0       | 0.0   | 0.0  | 0.0        | 0.0  | 0.0         |
      | 2  | 31   | 20260228  |                  | 83.57           | 16.43         | 0.58     | 0.0  | 0.0       | 17.01 | 0.0  | 0.0        | 0.0  | 17.01       |
      | 3  | 28   | 20260328     |                  | 67.05           | 16.52         | 0.49     | 0.0  | 0.0       | 17.01 | 0.0  | 0.0        | 0.0  | 17.01       |
      | 4  | 31   | 20260428     |                  | 50.43           | 16.62         | 0.39     | 0.0  | 0.0       | 17.01 | 0.0  | 0.0        | 0.0  | 17.01       |
      | 5  | 30   | 20260528       |                  | 33.71           | 16.72         | 0.29     | 0.0  | 0.0       | 17.01 | 0.0  | 0.0        | 0.0  | 17.01       |
      | 6  | 31   | 20260628      |                  | 16.9            | 16.81         | 0.2      | 0.0  | 0.0       | 17.01 | 0.0  | 0.0        | 0.0  | 17.01       |
      | 7  | 30   | 20260728      |                  | 0.0             | 16.9          | 0.1      | 0.0  | 0.0       | 17.0  | 0.0  | 0.0        | 0.0  | 17.0        |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 100.0         | 2.05     | 0.0  | 0.0       | 102.05 | 0.0  | 0.0        | 0.0  | 102.05      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20260128  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20260128  | Re-age           | 100.0  | 100.0     | 0.0      | 0.0  | 0.0       | 0.0          | false    | false    |
# --- second re-age on 20260129: schedule accumulates zeroed period boundary --- #
    When Admin sets the business date to "20260129"
    And Admin creates a Loan re-aging transaction with the following data:
      | frequencyNumber | frequencyType | startDate        | numberOfInstallments |
      | 1               | MONTHS        | 20260228 | 6                    |
    Then Loan Repayment schedule has 7 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20260128   |                  | 100.0           |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 1    | 20260129   | 20260128  | 100.0           | 0.0           | 0.0      | 0.0  | 0.0       | 0.0   | 0.0  | 0.0        | 0.0  | 0.0         |
      | 2  | 30   | 20260228  |                  | 83.59           | 16.41         | 0.6      | 0.0  | 0.0       | 17.01 | 0.0  | 0.0        | 0.0  | 17.01       |
      | 3  | 28   | 20260328     |                  | 67.07           | 16.52         | 0.49     | 0.0  | 0.0       | 17.01 | 0.0  | 0.0        | 0.0  | 17.01       |
      | 4  | 31   | 20260428     |                  | 50.45           | 16.62         | 0.39     | 0.0  | 0.0       | 17.01 | 0.0  | 0.0        | 0.0  | 17.01       |
      | 5  | 30   | 20260528       |                  | 33.73           | 16.72         | 0.29     | 0.0  | 0.0       | 17.01 | 0.0  | 0.0        | 0.0  | 17.01       |
      | 6  | 31   | 20260628      |                  | 16.92           | 16.81         | 0.2      | 0.0  | 0.0       | 17.01 | 0.0  | 0.0        | 0.0  | 17.01       |
      | 7  | 30   | 20260728      |                  | 0.0             | 16.92         | 0.1      | 0.0  | 0.0       | 17.02 | 0.0  | 0.0        | 0.0  | 17.02       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 100.0         | 2.07     | 0.0  | 0.0       | 102.07 | 0.0  | 0.0        | 0.0  | 102.07      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20260128  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20260128  | Re-age           | 100.0  | 100.0     | 0.0      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20260129  | Re-age           | 100.02 | 100.0     | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
# --- third re-age on 20260130 --- #
    When Admin sets the business date to "20260130"
    And Admin creates a Loan re-aging transaction with the following data:
      | frequencyNumber | frequencyType | startDate        | numberOfInstallments |
      | 1               | MONTHS        | 20260228 | 6                    |
    Then Loan Repayment schedule has 7 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20260128   |                  | 100.0           |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 2    | 20260130   | 20260128  | 100.0           | 0.0           | 0.0      | 0.0  | 0.0       | 0.0   | 0.0  | 0.0        | 0.0  | 0.0         |
      | 2  | 29   | 20260228  |                  | 83.61           | 16.39         | 0.62     | 0.0  | 0.0       | 17.01 | 0.0  | 0.0        | 0.0  | 17.01       |
      | 3  | 28   | 20260328     |                  | 67.09           | 16.52         | 0.49     | 0.0  | 0.0       | 17.01 | 0.0  | 0.0        | 0.0  | 17.01       |
      | 4  | 31   | 20260428     |                  | 50.47           | 16.62         | 0.39     | 0.0  | 0.0       | 17.01 | 0.0  | 0.0        | 0.0  | 17.01       |
      | 5  | 30   | 20260528       |                  | 33.75           | 16.72         | 0.29     | 0.0  | 0.0       | 17.01 | 0.0  | 0.0        | 0.0  | 17.01       |
      | 6  | 31   | 20260628      |                  | 16.94           | 16.81         | 0.2      | 0.0  | 0.0       | 17.01 | 0.0  | 0.0        | 0.0  | 17.01       |
      | 7  | 30   | 20260728      |                  | 0.0             | 16.94         | 0.1      | 0.0  | 0.0       | 17.04 | 0.0  | 0.0        | 0.0  | 17.04       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 100.0         | 2.09     | 0.0  | 0.0       | 102.09 | 0.0  | 0.0        | 0.0  | 102.09      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20260128  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20260128  | Re-age           | 100.0  | 100.0     | 0.0      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20260129  | Re-age           | 100.02 | 100.0     | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20260130  | Re-age           | 100.04 | 100.0     | 0.04     | 0.0  | 0.0       | 0.0          | false    | false    |
# --- fourth re-age on 20260131 --- #
    When Admin sets the business date to "20260131"
    And Admin creates a Loan re-aging transaction with the following data:
      | frequencyNumber | frequencyType | startDate        | numberOfInstallments |
      | 1               | MONTHS        | 20260228 | 6                    |
    Then Loan Repayment schedule has 7 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20260128   |                  | 100.0           |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 3    | 20260131   | 20260128  | 100.0           | 0.0           | 0.0      | 0.0  | 0.0       | 0.0   | 0.0  | 0.0        | 0.0  | 0.0         |
      | 2  | 28   | 20260228  |                  | 83.62           | 16.38         | 0.64     | 0.0  | 0.0       | 17.02 | 0.0  | 0.0        | 0.0  | 17.02       |
      | 3  | 28   | 20260328     |                  | 67.09           | 16.53         | 0.49     | 0.0  | 0.0       | 17.02 | 0.0  | 0.0        | 0.0  | 17.02       |
      | 4  | 31   | 20260428     |                  | 50.46           | 16.63         | 0.39     | 0.0  | 0.0       | 17.02 | 0.0  | 0.0        | 0.0  | 17.02       |
      | 5  | 30   | 20260528       |                  | 33.73           | 16.73         | 0.29     | 0.0  | 0.0       | 17.02 | 0.0  | 0.0        | 0.0  | 17.02       |
      | 6  | 31   | 20260628      |                  | 16.91           | 16.82         | 0.2      | 0.0  | 0.0       | 17.02 | 0.0  | 0.0        | 0.0  | 17.02       |
      | 7  | 30   | 20260728      |                  | 0.0             | 16.91         | 0.1      | 0.0  | 0.0       | 17.01 | 0.0  | 0.0        | 0.0  | 17.01       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 100.0         | 2.11     | 0.0  | 0.0       | 102.11 | 0.0  | 0.0        | 0.0  | 102.11      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20260128  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20260128  | Re-age           | 100.0  | 100.0     | 0.0      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20260129  | Re-age           | 100.02 | 100.0     | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20260130  | Re-age           | 100.04 | 100.0     | 0.04     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20260131  | Re-age           | 100.06 | 100.0     | 0.06     | 0.0  | 0.0       | 0.0          | false    | false    |
# --- re-age preview on 20260201: must return exactly 6 new periods, NOT 12 with 1-day periods --- #
    When Admin sets the business date to "20260201"
    And Admin creates a Loan re-aging preview by Loan external ID with the following data:
      | frequencyNumber | frequencyType | startDate        | numberOfInstallments |
      | 1               | MONTHS        | 20260228 | 6                    |
    Then Loan Re-Aged Repayment schedule preview has 7 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20260128   |                 | 100.0           | 0.0           | 0.0      | 0.0  | 0.0       | 0.0   | 0.0  |            |      |             |
      | 1  | 4    | 20260201  | 20260128 | 100.0           | 0.0           | 0.0      | 0.0  | 0.0       | 0.0   | 0.0  | 0.0        | 0.0  | 0.0         |
      | 2  | 27   | 20260228  |                 | 83.62           | 16.38         | 0.64     | 0.0  | 0.0       | 17.02 | 0.0  | 0.0        | 0.0  | 17.02       |
      | 3  | 28   | 20260328     |                 | 67.09           | 16.53         | 0.49     | 0.0  | 0.0       | 17.02 | 0.0  | 0.0        | 0.0  | 17.02       |
      | 4  | 31   | 20260428     |                 | 50.46           | 16.63         | 0.39     | 0.0  | 0.0       | 17.02 | 0.0  | 0.0        | 0.0  | 17.02       |
      | 5  | 30   | 20260528       |                 | 33.73           | 16.73         | 0.29     | 0.0  | 0.0       | 17.02 | 0.0  | 0.0        | 0.0  | 17.02       |
      | 6  | 31   | 20260628      |                 | 16.91           | 16.82         | 0.2      | 0.0  | 0.0       | 17.02 | 0.0  | 0.0        | 0.0  | 17.02       |
      | 7  | 30   | 20260728      |                 | 0.0             | 16.91         | 0.1      | 0.0  | 0.0       | 17.01 | 0.0  | 0.0        | 0.0  | 17.01       |
    Then Loan Re-Aged Repayment schedule preview has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 100.0         | 2.11     | 0.0  | 0.0       | 102.11 | 0.0  | 0.0        | 0.0  | 102.11      |
    When Loan Pay-off is made on "20260201"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met
