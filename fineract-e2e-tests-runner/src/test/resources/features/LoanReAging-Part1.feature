@LoanReAgingFeature
Feature: LoanReAging - Part1

  @TestRailId:C3050 @AdvancedPaymentAllocation
  Scenario: Verify that Loan re-aging transaction happy path works properly
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
    When Admin sets the business date to "20240220"
    When Admin runs inline COB job for Loan
    Then Admin checks that delinquency range is: "RANGE_30" and has delinquentDate "2024-01-19"
    When Admin creates a Loan re-aging transaction with the following data:
      | frequencyNumber | frequencyType | startDate     | numberOfInstallments |
      | 1               | MONTHS        | 20240301 | 6                    |
    Then Loan Repayment schedule has 10 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101  |                  | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 0    | 20240101  | 20240101  | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0  | 0.0         |
      | 2  | 15   | 20240116  | 20240220 | 750.0           | 0.0           | 0.0      | 0.0  | 0.0       | 0.0   | 0.0   | 0.0        | 0.0  | 0.0         |
      | 3  | 15   | 20240131  | 20240220 | 750.0           | 0.0           | 0.0      | 0.0  | 0.0       | 0.0   | 0.0   | 0.0        | 0.0  | 0.0         |
      | 4  | 15   | 20240215 | 20240220 | 750.0           | 0.0           | 0.0      | 0.0  | 0.0       | 0.0   | 0.0   | 0.0        | 0.0  | 0.0         |
      | 5  | 15   | 20240301    |                  | 625.0           | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 0.0   | 0.0        | 0.0  | 125.0       |
      | 6  | 31   | 20240401    |                  | 500.0           | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 0.0   | 0.0        | 0.0  | 125.0       |
      | 7  | 30   | 20240501      |                  | 375.0           | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 0.0   | 0.0        | 0.0  | 125.0       |
      | 8  | 31   | 20240601     |                  | 250.0           | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 0.0   | 0.0        | 0.0  | 125.0       |
      | 9  | 30   | 20240701     |                  | 125.0           | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 0.0   | 0.0        | 0.0  | 125.0       |
      | 10 | 31   | 20240801   |                  | 0.0             | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 0.0   | 0.0        | 0.0  | 125.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 1000.0        | 0.0      | 0.0  | 0.0       | 1000.0 | 250.0 | 0.0        | 0.0  | 750.0       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20240101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       | false    |
      | 20240101  | Down Payment     | 250.0  | 250.0     | 0.0      | 0.0  | 0.0       | 750.0        | false    |
      | 20240220 | Re-age           | 750.0  | 750.0     | 0.0      | 0.0  | 0.0       | 0.0          | false    |
    Then Admin checks that delinquency range is: "NO_DELINQUENCY" and has delinquentDate ""
    Then LoanReAgeTransactionBusinessEvent has changedTerms "true"
    When Loan Pay-off is made on "20240220"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C3051 @AdvancedPaymentAllocation
  Scenario: Verify that Loan re-aging transaction made by Loan external ID happy path works properly
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
    When Admin sets the business date to "20240220"
    When Admin creates a Loan re-aging transaction by Loan external ID with the following data:
      | frequencyNumber | frequencyType | startDate     | numberOfInstallments |
      | 30              | DAYS          | 20240310 | 2                    |
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101  |                  | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 0    | 20240101  | 20240101  | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0  | 0.0         |
      | 2  | 15   | 20240116  | 20240220 | 750.0           | 0.0           | 0.0      | 0.0  | 0.0       | 0.0   | 0.0   | 0.0        | 0.0  | 0.0         |
      | 3  | 15   | 20240131  | 20240220 | 750.0           | 0.0           | 0.0      | 0.0  | 0.0       | 0.0   | 0.0   | 0.0        | 0.0  | 0.0         |
      | 4  | 15   | 20240215 | 20240220 | 750.0           | 0.0           | 0.0      | 0.0  | 0.0       | 0.0   | 0.0   | 0.0        | 0.0  | 0.0         |
      | 5  | 24   | 20240310    |                  | 375.0           | 375.0         | 0.0      | 0.0  | 0.0       | 375.0 | 0.0   | 0.0        | 0.0  | 375.0       |
      | 6  | 30   | 20240409    |                  | 0.0             | 375.0         | 0.0      | 0.0  | 0.0       | 375.0 | 0.0   | 0.0        | 0.0  | 375.0       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20240101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       | false    |
      | 20240101  | Down Payment     | 250.0  | 250.0     | 0.0      | 0.0  | 0.0       | 750.0        | false    |
      | 20240220 | Re-age           | 750.0  | 750.0     | 0.0      | 0.0  | 0.0       | 0.0          | false    |

    When Loan Pay-off is made on "20240220"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C3052 @AdvancedPaymentAllocation
  Scenario: Verify that Loan re-aging transaction undo works properly
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
    When Admin sets the business date to "20240220"
    When Admin runs inline COB job for Loan
    Then Admin checks that delinquency range is: "RANGE_30" and has delinquentDate "2024-01-19"
    When Admin creates a Loan re-aging transaction by Loan external ID with the following data:
      | frequencyNumber | frequencyType | startDate     | numberOfInstallments |
      | 1               | DAYS          | 20240310 | 1                    |
    When Admin sets the business date to "20240225"
    Then Loan Repayment schedule has 5 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101  |                  | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 0    | 20240101  | 20240101  | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0  | 0.0         |
      | 2  | 15   | 20240116  | 20240220 | 750.0           | 0.0           | 0.0      | 0.0  | 0.0       | 0.0   | 0.0   | 0.0        | 0.0  | 0.0         |
      | 3  | 15   | 20240131  | 20240220 | 750.0           | 0.0           | 0.0      | 0.0  | 0.0       | 0.0   | 0.0   | 0.0        | 0.0  | 0.0         |
      | 4  | 15   | 20240215 | 20240220 | 750.0           | 0.0           | 0.0      | 0.0  | 0.0       | 0.0   | 0.0   | 0.0        | 0.0  | 0.0         |
      | 5  | 24   | 20240310    |                  | 0.0             | 750.0         | 0.0      | 0.0  | 0.0       | 750.0 | 0.0   | 0.0        | 0.0  | 750.0       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20240101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       | false    |
      | 20240101  | Down Payment     | 250.0  | 250.0     | 0.0      | 0.0  | 0.0       | 750.0        | false    |
      | 20240220 | Re-age           | 750.0  | 750.0     | 0.0      | 0.0  | 0.0       | 0.0          | false    |
    Then Admin checks that delinquency range is: "NO_DELINQUENCY" and has delinquentDate ""
    When Admin successfully undo Loan re-aging transaction
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101  |                 | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 0    | 20240101  | 20240101 | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0  | 0.0         |
      | 2  | 15   | 20240116  |                 | 500.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0   | 0.0        | 0.0  | 250.0       |
      | 3  | 15   | 20240131  |                 | 250.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0   | 0.0        | 0.0  | 250.0       |
      | 4  | 15   | 20240215 |                 | 0.0             | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0   | 0.0        | 0.0  | 250.0       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20240101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       | false    |
      | 20240101  | Down Payment     | 250.0  | 250.0     | 0.0      | 0.0  | 0.0       | 750.0        | false    |
      | 20240220 | Re-age           | 750.0  | 750.0     | 0.0      | 0.0  | 0.0       | 0.0          | true     |
    Then Admin checks that delinquency range is: "RANGE_30" and has delinquentDate "2024-01-19"

    When Loan Pay-off is made on "20240220"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C3053 @AdvancedPaymentAllocation
  Scenario: Verify that Loan re-aging transaction works properly when chargeback happens after re-aging
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
    When Admin sets the business date to "20240220"
    When Admin runs inline COB job for Loan
    Then Admin checks that delinquency range is: "RANGE_30" and has delinquentDate "2024-01-04"
    And Customer makes "AUTOPAY" repayment on "20240101" with 250 EUR transaction amount
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101  |                 | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 0    | 20240101  | 20240101 | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0  | 0.0         |
      | 2  | 15   | 20240116  |                 | 500.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0   | 0.0        | 0.0  | 250.0       |
      | 3  | 15   | 20240131  |                 | 250.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0   | 0.0        | 0.0  | 250.0       |
      | 4  | 15   | 20240215 |                 | 0.0             | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0   | 0.0        | 0.0  | 250.0       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20240101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       | false    |
      | 20240101  | Repayment        | 250.0  | 250.0     | 0.0      | 0.0  | 0.0       | 750.0        | false    |
    When Admin sets the business date to "20240221"
    When Admin creates a Loan re-aging transaction by Loan external ID with the following data:
      | frequencyNumber | frequencyType | startDate     | numberOfInstallments |
      | 2               | MONTHS        | 20240310 | 3                    |
    Then Loan Repayment schedule has 7 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101  |                  | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 0    | 20240101  | 20240101  | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0  | 0.0         |
      | 2  | 15   | 20240116  | 20240221 | 750.0           | 0.0           | 0.0      | 0.0  | 0.0       | 0.0   | 0.0   | 0.0        | 0.0  | 0.0         |
      | 3  | 15   | 20240131  | 20240221 | 750.0           | 0.0           | 0.0      | 0.0  | 0.0       | 0.0   | 0.0   | 0.0        | 0.0  | 0.0         |
      | 4  | 15   | 20240215 | 20240221 | 750.0           | 0.0           | 0.0      | 0.0  | 0.0       | 0.0   | 0.0   | 0.0        | 0.0  | 0.0         |
      | 5  | 24   | 20240310    |                  | 500.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0   | 0.0        | 0.0  | 250.0       |
      | 6  | 61   | 20240510      |                  | 250.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0   | 0.0        | 0.0  | 250.0       |
      | 7  | 61   | 20240710     |                  | 0.0             | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0   | 0.0        | 0.0  | 250.0       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20240101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       | false    |
      | 20240101  | Repayment        | 250.0  | 250.0     | 0.0      | 0.0  | 0.0       | 750.0        | false    |
      | 20240221 | Re-age           | 750.0  | 750.0     | 0.0      | 0.0  | 0.0       | 0.0          | false    |
    When Admin sets the business date to "20240225"
    When Admin makes "REPAYMENT_ADJUSTMENT_CHARGEBACK" chargeback with 250 EUR transaction amount
    Then Loan Repayment schedule has 7 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101  |                  | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 0    | 20240101  | 20240101  | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0  | 0.0         |
      | 2  | 15   | 20240116  | 20240221 | 750.0           | 0.0           | 0.0      | 0.0  | 0.0       | 0.0   | 0.0   | 0.0        | 0.0  | 0.0         |
      | 3  | 15   | 20240131  | 20240221 | 750.0           | 0.0           | 0.0      | 0.0  | 0.0       | 0.0   | 0.0   | 0.0        | 0.0  | 0.0         |
      | 4  | 15   | 20240215 | 20240221 | 750.0           | 0.0           | 0.0      | 0.0  | 0.0       | 0.0   | 0.0   | 0.0        | 0.0  | 0.0         |
      | 5  | 24   | 20240310    |                  | 500.0           | 500.0         | 0.0      | 0.0  | 0.0       | 500.0 | 0.0   | 0.0        | 0.0  | 500.0       |
      | 6  | 61   | 20240510      |                  | 250.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0   | 0.0        | 0.0  | 250.0       |
      | 7  | 61   | 20240710     |                  | 0.0             | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0   | 0.0        | 0.0  | 250.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 1250.0        | 0.0      | 0.0  | 0.0       | 1250.0 | 250.0 | 0.0        | 0.0  | 1000.0      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20240101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       | false    |
      | 20240101  | Repayment        | 250.0  | 250.0     | 0.0      | 0.0  | 0.0       | 750.0        | false    |
      | 20240221 | Re-age           | 750.0  | 750.0     | 0.0      | 0.0  | 0.0       | 0.0          | false    |
      | 20240225 | Chargeback       | 250.0  | 250.0     | 0.0      | 0.0  | 0.0       | 1000.0       | false    |

    When Loan Pay-off is made on "20240225"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C3054 @AdvancedPaymentAllocation
  Scenario: Verify Loan re-aging transaction - reverse-replay scenario 1
    When Admin sets the business date to "20240101"
    When Admin creates a client with random data
    When Admin set "LP2_DOWNPAYMENT_AUTO_ADVANCED_PAYMENT_ALLOCATION" loan product "DEFAULT" transaction type to "NEXT_INSTALLMENT" future installment allocation rule
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                      | submitted on date | with Principal | ANNUAL interest rate % | interest type | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_DOWNPAYMENT_AUTO_ADVANCED_PAYMENT_ALLOCATION | 20240101   | 1000           | 0                      | FLAT          | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 45                | DAYS                  | 15             | DAYS                   | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240101" with "1000" amount and expected disbursement date on "20240101"
    When Admin successfully disburse the loan on "20240101" with "1000" EUR transaction amount
    When Admin runs inline COB job for Loan
    When Admin sets the business date to "20240201"
    When Admin runs inline COB job for Loan
    When Admin sets the business date to "20240227"
    When Admin creates a Loan re-aging transaction with the following data:
      | frequencyNumber | frequencyType | startDate     | numberOfInstallments |
      | 1               | MONTHS        | 20240301 | 6                    |
    And Customer makes "AUTOPAY" repayment on "20240201" with 250 EUR transaction amount
    When Admin successfully undo Loan re-aging transaction
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late  | Outstanding |
      |    |      | 20240101  |                  | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |       |             |
      | 1  | 0    | 20240101  | 20240101  | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0   | 0.0         |
      | 2  | 15   | 20240116  | 20240201 | 500.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 250.0 | 0.0         |
      | 3  | 15   | 20240131  |                  | 250.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0   | 0.0        | 0.0   | 250.0       |
      | 4  | 15   | 20240215 |                  | 0.0             | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0   | 0.0        | 0.0   | 250.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late  | Outstanding |
      | 1000.0        | 0.0      | 0.0  | 0.0       | 1000.0 | 500.0 | 0.0        | 250.0 | 500.0       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20240101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       | false    |
      | 20240101  | Down Payment     | 250.0  | 250.0     | 0.0      | 0.0  | 0.0       | 750.0        | false    |
      | 20240201 | Repayment        | 250.0  | 250.0     | 0.0      | 0.0  | 0.0       | 500.0        | false    |
      | 20240227 | Re-age           | 500.0  | 500.0     | 0.0      | 0.0  | 0.0       | 0.0          | true     |

    When Loan Pay-off is made on "20240227"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C3055 @AdvancedPaymentAllocation
  Scenario: Verify Loan re-aging transaction - reverse-replay scenario 2
    When Admin sets the business date to "20240101"
    When Admin creates a client with random data
    When Admin set "LP2_DOWNPAYMENT_AUTO_ADVANCED_PAYMENT_ALLOCATION" loan product "DEFAULT" transaction type to "NEXT_INSTALLMENT" future installment allocation rule
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                      | submitted on date | with Principal | ANNUAL interest rate % | interest type | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_DOWNPAYMENT_AUTO_ADVANCED_PAYMENT_ALLOCATION | 20240101   | 1000           | 0                      | FLAT          | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 45                | DAYS                  | 15             | DAYS                   | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240101" with "1000" amount and expected disbursement date on "20240101"
    When Admin successfully disburse the loan on "20240101" with "1000" EUR transaction amount
    When Admin runs inline COB job for Loan
    When Admin sets the business date to "20240201"
    When Admin runs inline COB job for Loan
    When Admin sets the business date to "20240227"
    When Admin creates a Loan re-aging transaction with the following data:
      | frequencyNumber | frequencyType | startDate     | numberOfInstallments |
      | 1               | MONTHS        | 20240301 | 6                    |
    When Customer undo "1"th "Down Payment" transaction made on "20240101"
    When Admin successfully undo Loan re-aging transaction
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20240101  |           | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 0    | 20240101  |           | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0  | 0.0        | 0.0  | 250.0       |
      | 2  | 15   | 20240116  |           | 500.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0  | 0.0        | 0.0  | 250.0       |
      | 3  | 15   | 20240131  |           | 250.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0  | 0.0        | 0.0  | 250.0       |
      | 4  | 15   | 20240215 |           | 0.0             | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0  | 0.0        | 0.0  | 250.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 1000.0        | 0.0      | 0.0  | 0.0       | 1000.0 | 0.0  | 0.0        | 0.0  | 1000.0      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20240101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       | false    |
      | 20240101  | Down Payment     | 250.0  | 250.0     | 0.0      | 0.0  | 0.0       | 750.0        | true     |
      | 20240227 | Re-age           | 1000.0 | 1000.0    | 0.0      | 0.0  | 0.0       | 0.0          | true     |

    When Loan Pay-off is made on "20240227"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C3056 @AdvancedPaymentAllocation
  Scenario: Verify that Loan re-aging transaction - chargeback before maturity and  prior to re-aging
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
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20240101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       | false    |
      | 20240101  | Repayment        | 250.0  | 250.0     | 0.0      | 0.0  | 0.0       | 750.0        | false    |
    When Admin sets the business date to "20240202"
    When Admin makes "REPAYMENT_ADJUSTMENT_CHARGEBACK" chargeback with 125 EUR transaction amount
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101  |                 | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 0    | 20240101  | 20240101 | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0  | 0.0         |
      | 2  | 15   | 20240116  |                 | 500.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0   | 0.0        | 0.0  | 250.0       |
      | 3  | 15   | 20240131  |                 | 250.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0   | 0.0        | 0.0  | 250.0       |
      | 4  | 15   | 20240215 |                 | 0.0             | 375.0         | 0.0      | 0.0  | 0.0       | 375.0 | 0.0   | 0.0        | 0.0  | 375.0       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20240101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       | false    |
      | 20240101  | Repayment        | 250.0  | 250.0     | 0.0      | 0.0  | 0.0       | 750.0        | false    |
      | 20240202 | Chargeback       | 125.0  | 125.0     | 0.0      | 0.0  | 0.0       | 875.0        | false    |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 1125.0        | 0.0      | 0.0  | 0.0       | 1125.0 | 250.0 | 0.0        | 0.0  | 875.0       |
    When Admin sets the business date to "20240221"
    When Admin creates a Loan re-aging transaction by Loan external ID with the following data:
      | frequencyNumber | frequencyType | startDate     | numberOfInstallments |
      | 2               | MONTHS        | 20240310 | 3                    |
    Then Loan Repayment schedule has 7 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101  |                  | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0   |            |      |             |
      | 1  | 0    | 20240101  | 20240101  | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0  | 250.0 | 0.0        | 0.0  | 0.0         |
      | 2  | 15   | 20240116  | 20240221 | 750.0           | 0.0           | 0.0      | 0.0  | 0.0       | 0.0    | 0.0   | 0.0        | 0.0  | 0.0         |
      | 3  | 15   | 20240131  | 20240221 | 750.0           | 0.0           | 0.0      | 0.0  | 0.0       | 0.0    | 0.0   | 0.0        | 0.0  | 0.0         |
      | 4  | 15   | 20240215 | 20240221 | 875.0           | 0.0           | 0.0      | 0.0  | 0.0       | 0.0    | 0.0   | 0.0        | 0.0  | 0.0         |
      | 5  | 24   | 20240310    |                  | 583.33          | 291.67        | 0.0      | 0.0  | 0.0       | 291.67 | 0.0   | 0.0        | 0.0  | 291.67      |
      | 6  | 61   | 20240510      |                  | 291.66          | 291.67        | 0.0      | 0.0  | 0.0       | 291.67 | 0.0   | 0.0        | 0.0  | 291.67      |
      | 7  | 61   | 20240710     |                  | 0.0             | 291.66        | 0.0      | 0.0  | 0.0       | 291.66 | 0.0   | 0.0        | 0.0  | 291.66      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20240101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       | false    |
      | 20240101  | Repayment        | 250.0  | 250.0     | 0.0      | 0.0  | 0.0       | 750.0        | false    |
      | 20240202 | Chargeback       | 125.0  | 125.0     | 0.0      | 0.0  | 0.0       | 875.0        | false    |
      | 20240221 | Re-age           | 875.0  | 875.0     | 0.0      | 0.0  | 0.0       | 0.0          | false    |

    When Loan Pay-off is made on "20240221"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C3057 @AdvancedPaymentAllocation
  Scenario: Verify that Loan re-aging transaction - chargeback after maturity date and prior to re-aging
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
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20240101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       | false    |
      | 20240101  | Repayment        | 250.0  | 250.0     | 0.0      | 0.0  | 0.0       | 750.0        | false    |
    When Admin sets the business date to "20240220"
    When Admin makes "REPAYMENT_ADJUSTMENT_CHARGEBACK" chargeback with 125 EUR transaction amount
    Then Loan Repayment schedule has 5 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101  |                 | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 0    | 20240101  | 20240101 | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0  | 0.0         |
      | 2  | 15   | 20240116  |                 | 500.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0   | 0.0        | 0.0  | 250.0       |
      | 3  | 15   | 20240131  |                 | 250.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0   | 0.0        | 0.0  | 250.0       |
      | 4  | 15   | 20240215 |                 | 0.0             | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0   | 0.0        | 0.0  | 250.0       |
      | 5  | 5    | 20240220 |                 | 0.0             | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 0.0   | 0.0        | 0.0  | 125.0       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20240101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       | false    |
      | 20240101  | Repayment        | 250.0  | 250.0     | 0.0      | 0.0  | 0.0       | 750.0        | false    |
      | 20240220 | Chargeback       | 125.0  | 125.0     | 0.0      | 0.0  | 0.0       | 875.0        | false    |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 1125.0        | 0.0      | 0.0  | 0.0       | 1125.0 | 250.0 | 0.0        | 0.0  | 875.0       |
    When Admin sets the business date to "20240221"
    When Admin creates a Loan re-aging transaction by Loan external ID with the following data:
      | frequencyNumber | frequencyType | startDate     | numberOfInstallments |
      | 2               | MONTHS        | 20240310 | 3                    |
    Then Loan Repayment schedule has 8 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101  |                  | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0   |            |      |             |
      | 1  | 0    | 20240101  | 20240101  | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0  | 250.0 | 0.0        | 0.0  | 0.0         |
      | 2  | 15   | 20240116  | 20240221 | 750.0           | 0.0           | 0.0      | 0.0  | 0.0       | 0.0    | 0.0   | 0.0        | 0.0  | 0.0         |
      | 3  | 15   | 20240131  | 20240221 | 750.0           | 0.0           | 0.0      | 0.0  | 0.0       | 0.0    | 0.0   | 0.0        | 0.0  | 0.0         |
      | 4  | 15   | 20240215 | 20240221 | 750.0           | 0.0           | 0.0      | 0.0  | 0.0       | 0.0    | 0.0   | 0.0        | 0.0  | 0.0         |
      | 5  | 5    | 20240220 | 20240221 | 875.0           | 0.0           | 0.0      | 0.0  | 0.0       | 0.0    | 0.0   | 0.0        | 0.0  | 0.0         |
      | 6  | 19   | 20240310    |                  | 583.33          | 291.67        | 0.0      | 0.0  | 0.0       | 291.67 | 0.0   | 0.0        | 0.0  | 291.67      |
      | 7  | 61   | 20240510      |                  | 291.66          | 291.67        | 0.0      | 0.0  | 0.0       | 291.67 | 0.0   | 0.0        | 0.0  | 291.67      |
      | 8  | 61   | 20240710     |                  | 0.0             | 291.66        | 0.0      | 0.0  | 0.0       | 291.66 | 0.0   | 0.0        | 0.0  | 291.66      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20240101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       | false    |
      | 20240101  | Repayment        | 250.0  | 250.0     | 0.0      | 0.0  | 0.0       | 750.0        | false    |
      | 20240220 | Chargeback       | 125.0  | 125.0     | 0.0      | 0.0  | 0.0       | 875.0        | false    |
      | 20240221 | Re-age           | 875.0  | 875.0     | 0.0      | 0.0  | 0.0       | 0.0          | false    |

    When Loan Pay-off is made on "20240221"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C3058 @AdvancedPaymentAllocation
  Scenario: Verify that Loan re-aging transaction - chargeback after maturity date and prior to re-aging with charge N+1 installment
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
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20240101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       | false    |
      | 20240101  | Repayment        | 250.0  | 250.0     | 0.0      | 0.0  | 0.0       | 750.0        | false    |
    When Admin sets the business date to "20240226"
    When Admin makes "REPAYMENT_ADJUSTMENT_CHARGEBACK" chargeback with 125 EUR transaction amount
    When Admin adds "LOAN_NSF_FEE" due date charge with "20240226" due date and 20 EUR transaction amount
    Then Loan Repayment schedule has 5 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101  |                 | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 0    | 20240101  | 20240101 | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0  | 0.0         |
      | 2  | 15   | 20240116  |                 | 500.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0   | 0.0        | 0.0  | 250.0       |
      | 3  | 15   | 20240131  |                 | 250.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0   | 0.0        | 0.0  | 250.0       |
      | 4  | 15   | 20240215 |                 | 0.0             | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0   | 0.0        | 0.0  | 250.0       |
      | 5  | 11   | 20240226 |                 | 0.0             | 125.0         | 0.0      | 0.0  | 20.0      | 145.0 | 0.0   | 0.0        | 0.0  | 145.0       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20240101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       | false    |
      | 20240101  | Repayment        | 250.0  | 250.0     | 0.0      | 0.0  | 0.0       | 750.0        | false    |
      | 20240226 | Chargeback       | 125.0  | 125.0     | 0.0      | 0.0  | 0.0       | 875.0        | false    |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 1125.0        | 0.0      | 0.0  | 20.0      | 1145.0 | 250.0 | 0.0        | 0.0  | 895.0       |
    When Admin sets the business date to "20240227"
    When Admin makes a charge adjustment for the last "LOAN_NSF_FEE" type charge which is due on "20240226" with 20 EUR transaction amount and externalId ""
    When Admin creates a Loan re-aging transaction by Loan external ID with the following data:
      | frequencyNumber | frequencyType | startDate     | numberOfInstallments |
      | 2               | MONTHS        | 20240310 | 3                    |
    Then Loan Repayment schedule has 8 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101  |                  | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 0    | 20240101  | 20240101  | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0  | 0.0         |
      | 2  | 15   | 20240116  | 20240227 | 730.0           | 20.0          | 0.0      | 0.0  | 0.0       | 20.0  | 20.0  | 0.0        | 20.0 | 0.0         |
      | 3  | 15   | 20240131  | 20240227 | 730.0           | 0.0           | 0.0      | 0.0  | 0.0       | 0.0   | 0.0   | 0.0        | 0.0  | 0.0         |
      | 4  | 15   | 20240215 | 20240227 | 730.0           | 0.0           | 0.0      | 0.0  | 0.0       | 0.0   | 0.0   | 0.0        | 0.0  | 0.0         |
      | 5  | 11   | 20240226 |                  | 855.0           | 0.0           | 0.0      | 0.0  | 20.0      | 20.0  | 0.0   | 0.0        | 0.0  | 20.0        |
      | 6  | 13   | 20240310    |                  | 570.0           | 285.0         | 0.0      | 0.0  | 0.0       | 285.0 | 0.0   | 0.0        | 0.0  | 285.0       |
      | 7  | 61   | 20240510      |                  | 285.0           | 285.0         | 0.0      | 0.0  | 0.0       | 285.0 | 0.0   | 0.0        | 0.0  | 285.0       |
      | 8  | 61   | 20240710     |                  | 0.0             | 285.0         | 0.0      | 0.0  | 0.0       | 285.0 | 0.0   | 0.0        | 0.0  | 285.0       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type  | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20240101  | Disbursement      | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       | false    |
      | 20240101  | Repayment         | 250.0  | 250.0     | 0.0      | 0.0  | 0.0       | 750.0        | false    |
      | 20240226 | Chargeback        | 125.0  | 125.0     | 0.0      | 0.0  | 0.0       | 875.0        | false    |
      | 20240227 | Charge Adjustment | 20.0   | 20.0      | 0.0      | 0.0  | 0.0       | 855.0        | false    |
      | 20240227 | Re-age            | 855.0  | 855.0     | 0.0      | 0.0  | 0.0       | 0.0          | false    |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 1125.0        | 0.0      | 0.0  | 20.0      | 1145.0 | 270.0 | 0.0        | 20.0 | 875.0       |

    When Loan Pay-off is made on "20240227"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C3059 @AdvancedPaymentAllocation
  Scenario: Verify Loan re-aging transaction - partial principal payment scenario + undo re-ageing
    When Admin sets the business date to "20240101"
    When Admin creates a client with random data
    When Admin set "LP2_DOWNPAYMENT_AUTO_ADVANCED_PAYMENT_ALLOCATION" loan product "DEFAULT" transaction type to "NEXT_INSTALLMENT" future installment allocation rule
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                      | submitted on date | with Principal | ANNUAL interest rate % | interest type | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_DOWNPAYMENT_AUTO_ADVANCED_PAYMENT_ALLOCATION | 20240101   | 500            | 0                      | FLAT          | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 45                | DAYS                  | 15             | DAYS                   | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240101" with "500" amount and expected disbursement date on "20240101"
    When Admin successfully disburse the loan on "20240101" with "500" EUR transaction amount
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101  |                 | 500.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 0    | 20240101  | 20240101 | 375.0           | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 125.0 | 0.0        | 0.0  | 0.0         |
      | 2  | 15   | 20240116  |                 | 250.0           | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 0.0   | 0.0        | 0.0  | 125.0       |
      | 3  | 15   | 20240131  |                 | 125.0           | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 0.0   | 0.0        | 0.0  | 125.0       |
      | 4  | 15   | 20240215 |                 | 0.0             | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 0.0   | 0.0        | 0.0  | 125.0       |
    When Admin sets the business date to "20240116"
    And Customer makes "AUTOPAY" repayment on "20240116" with 50 EUR transaction amount
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101  |                 | 500.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 0    | 20240101  | 20240101 | 375.0           | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 125.0 | 0.0        | 0.0  | 0.0         |
      | 2  | 15   | 20240116  |                 | 250.0           | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 50.0  | 0.0        | 0.0  | 75.0        |
      | 3  | 15   | 20240131  |                 | 125.0           | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 0.0   | 0.0        | 0.0  | 125.0       |
      | 4  | 15   | 20240215 |                 | 0.0             | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 0.0   | 0.0        | 0.0  | 125.0       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20240101  | Disbursement     | 500.0  | 0.0       | 0.0      | 0.0  | 0.0       | 500.0        | false    |
      | 20240101  | Down Payment     | 125.0  | 125.0     | 0.0      | 0.0  | 0.0       | 375.0        | false    |
      | 20240116  | Repayment        | 50.0   | 50.0      | 0.0      | 0.0  | 0.0       | 325.0        | false    |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      | 500.0         | 0.0      | 0.0  | 0.0       | 500.0 | 175.0 | 0.0        | 0.0  | 325.0       |
    When Admin sets the business date to "20240227"
    When Admin creates a Loan re-aging transaction with the following data:
      | frequencyNumber | frequencyType | startDate     | numberOfInstallments |
      | 1               | MONTHS        | 20240301 | 6                    |
    Then Loan Repayment schedule has 10 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101  |                  | 500.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 0    | 20240101  | 20240101  | 375.0           | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 125.0 | 0.0        | 0.0  | 0.0         |
      | 2  | 15   | 20240116  | 20240227 | 325.0           | 50.0          | 0.0      | 0.0  | 0.0       | 50.0  | 50.0  | 0.0        | 0.0  | 0.0         |
      | 3  | 15   | 20240131  | 20240227 | 325.0           | 0.0           | 0.0      | 0.0  | 0.0       | 0.0   | 0.0   | 0.0        | 0.0  | 0.0         |
      | 4  | 15   | 20240215 | 20240227 | 325.0           | 0.0           | 0.0      | 0.0  | 0.0       | 0.0   | 0.0   | 0.0        | 0.0  | 0.0         |
      | 5  | 15   | 20240301    |                  | 271.0           | 54.0          | 0.0      | 0.0  | 0.0       | 54.0  | 0.0   | 0.0        | 0.0  | 54.0        |
      | 6  | 31   | 20240401    |                  | 217.0           | 54.0          | 0.0      | 0.0  | 0.0       | 54.0  | 0.0   | 0.0        | 0.0  | 54.0        |
      | 7  | 30   | 20240501      |                  | 163.0           | 54.0          | 0.0      | 0.0  | 0.0       | 54.0  | 0.0   | 0.0        | 0.0  | 54.0        |
      | 8  | 31   | 20240601     |                  | 109.0           | 54.0          | 0.0      | 0.0  | 0.0       | 54.0  | 0.0   | 0.0        | 0.0  | 54.0        |
      | 9  | 30   | 20240701     |                  | 55.0            | 54.0          | 0.0      | 0.0  | 0.0       | 54.0  | 0.0   | 0.0        | 0.0  | 54.0        |
      | 10 | 31   | 20240801   |                  | 0.0             | 55.0          | 0.0      | 0.0  | 0.0       | 55.0  | 0.0   | 0.0        | 0.0  | 55.0        |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20240101  | Disbursement     | 500.0  | 0.0       | 0.0      | 0.0  | 0.0       | 500.0        | false    |
      | 20240101  | Down Payment     | 125.0  | 125.0     | 0.0      | 0.0  | 0.0       | 375.0        | false    |
      | 20240116  | Repayment        | 50.0   | 50.0      | 0.0      | 0.0  | 0.0       | 325.0        | false    |
      | 20240227 | Re-age           | 325.0  | 325.0     | 0.0      | 0.0  | 0.0       | 0.0          | false    |
    When Admin sets the business date to "20240229"
    When Admin successfully undo Loan re-aging transaction
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101  |                 | 500.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 0    | 20240101  | 20240101 | 375.0           | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 125.0 | 0.0        | 0.0  | 0.0         |
      | 2  | 15   | 20240116  |                 | 250.0           | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 50.0  | 0.0        | 0.0  | 75.0        |
      | 3  | 15   | 20240131  |                 | 125.0           | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 0.0   | 0.0        | 0.0  | 125.0       |
      | 4  | 15   | 20240215 |                 | 0.0             | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 0.0   | 0.0        | 0.0  | 125.0       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20240101  | Disbursement     | 500.0  | 0.0       | 0.0      | 0.0  | 0.0       | 500.0        | false    |
      | 20240101  | Down Payment     | 125.0  | 125.0     | 0.0      | 0.0  | 0.0       | 375.0        | false    |
      | 20240116  | Repayment        | 50.0   | 50.0      | 0.0      | 0.0  | 0.0       | 325.0        | false    |
      | 20240227 | Re-age           | 325.0  | 325.0     | 0.0      | 0.0  | 0.0       | 0.0          | true     |

    When Loan Pay-off is made on "20240229"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C3091 @AdvancedPaymentAllocation
  Scenario: Verify Loan re-age transaction - Event check
    When Admin sets the business date to "20240101"
    When Admin creates a client with random data
    When Admin set "LP2_DOWNPAYMENT_AUTO_ADVANCED_PAYMENT_ALLOCATION" loan product "DEFAULT" transaction type to "NEXT_INSTALLMENT" future installment allocation rule
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                      | submitted on date | with Principal | ANNUAL interest rate % | interest type | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_DOWNPAYMENT_AUTO_ADVANCED_PAYMENT_ALLOCATION | 20240101   | 500            | 0                      | FLAT          | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 45                | DAYS                  | 15             | DAYS                   | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240101" with "500" amount and expected disbursement date on "20240101"
    When Admin successfully disburse the loan on "20240101" with "500" EUR transaction amount
    When Admin sets the business date to "20240227"
    When Admin runs inline COB job for Loan
    Then LoanDelinquencyRangeChangeBusinessEvent is created
    When Admin creates a Loan re-aging transaction with the following data:
      | frequencyNumber | frequencyType | startDate     | numberOfInstallments |
      | 1               | MONTHS        | 20240301 | 6                    |
    Then LoanDelinquencyRangeChangeBusinessEvent is created
    Then LoanReAgeBusinessEvent is created

    When Loan Pay-off is made on "20240227"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C3107 @AdvancedPaymentAllocation
  Scenario: Verify Loan re-aging transaction reverse-replay - UC1: undo old repayment
    When Admin sets the business date to "20240101"
    When Admin creates a client with random data
    When Admin set "LP2_DOWNPAYMENT_AUTO_ADVANCED_PAYMENT_ALLOCATION" loan product "DEFAULT" transaction type to "NEXT_INSTALLMENT" future installment allocation rule
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                      | submitted on date | with Principal | ANNUAL interest rate % | interest type | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_DOWNPAYMENT_AUTO_ADVANCED_PAYMENT_ALLOCATION | 20240101   | 500            | 0                      | FLAT          | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 45                | DAYS                  | 15             | DAYS                   | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240101" with "500" amount and expected disbursement date on "20240101"
    When Admin successfully disburse the loan on "20240101" with "500" EUR transaction amount
    When Admin sets the business date to "20240116"
    And Customer makes "AUTOPAY" repayment on "20240116" with 125 EUR transaction amount
#    --- Re-aging transaction ---
    When Admin sets the business date to "20240220"
    When Admin creates a Loan re-aging transaction with the following data:
      | frequencyNumber | frequencyType | startDate     | numberOfInstallments |
      | 1               | MONTHS        | 20240301 | 2                    |
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101  |                  | 500.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 0    | 20240101  | 20240101  | 375.0           | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 125.0 | 0.0        | 0.0  | 0.0         |
      | 2  | 15   | 20240116  | 20240116  | 250.0           | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 125.0 | 0.0        | 0.0  | 0.0         |
      | 3  | 15   | 20240131  | 20240220 | 250.0           | 0.0           | 0.0      | 0.0  | 0.0       | 0.0   | 0.0   | 0.0        | 0.0  | 0.0         |
      | 4  | 15   | 20240215 | 20240220 | 250.0           | 0.0           | 0.0      | 0.0  | 0.0       | 0.0   | 0.0   | 0.0        | 0.0  | 0.0         |
      | 5  | 15   | 20240301    |                  | 125.0           | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 0.0   | 0.0        | 0.0  | 125.0       |
      | 6  | 31   | 20240401    |                  | 0.0             | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 0.0   | 0.0        | 0.0  | 125.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      | 500.0         | 0.0      | 0.0  | 0.0       | 500.0 | 250.0 | 0.0        | 0.0  | 250.0       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 500.0  | 0.0       | 0.0      | 0.0  | 0.0       | 500.0        | false    | false    |
      | 20240101  | Down Payment     | 125.0  | 125.0     | 0.0      | 0.0  | 0.0       | 375.0        | false    | false    |
      | 20240116  | Repayment        | 125.0  | 125.0     | 0.0      | 0.0  | 0.0       | 250.0        | false    | false    |
      | 20240220 | Re-age           | 250.0  | 250.0     | 0.0      | 0.0  | 0.0       | 0.0          | false    | false    |
#   --- Undo repayment ---
    When Admin sets the business date to "20240225"
    When Customer undo "1"th "Repayment" transaction made on "20240116"
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101  |                  | 500.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 0    | 20240101  | 20240101  | 375.0           | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 125.0 | 0.0        | 0.0  | 0.0         |
      | 2  | 15   | 20240116  | 20240220 | 375.0           | 0.0           | 0.0      | 0.0  | 0.0       | 0.0   | 0.0   | 0.0        | 0.0  | 0.0         |
      | 3  | 15   | 20240131  | 20240220 | 375.0           | 0.0           | 0.0      | 0.0  | 0.0       | 0.0   | 0.0   | 0.0        | 0.0  | 0.0         |
      | 4  | 15   | 20240215 | 20240220 | 375.0           | 0.0           | 0.0      | 0.0  | 0.0       | 0.0   | 0.0   | 0.0        | 0.0  | 0.0         |
      | 5  | 15   | 20240301    |                  | 187.0           | 188.0         | 0.0      | 0.0  | 0.0       | 188.0 | 0.0   | 0.0        | 0.0  | 188.0       |
      | 6  | 31   | 20240401    |                  | 0.0             | 187.0         | 0.0      | 0.0  | 0.0       | 187.0 | 0.0   | 0.0        | 0.0  | 187.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      | 500.0         | 0.0      | 0.0  | 0.0       | 500.0 | 125.0 | 0.0        | 0.0  | 375.0       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 500.0  | 0.0       | 0.0      | 0.0  | 0.0       | 500.0        | false    | false    |
      | 20240101  | Down Payment     | 125.0  | 125.0     | 0.0      | 0.0  | 0.0       | 375.0        | false    | false    |
      | 20240116  | Repayment        | 125.0  | 125.0     | 0.0      | 0.0  | 0.0       | 250.0        | true     | false    |
      | 20240220 | Re-age           | 375.0  | 375.0     | 0.0      | 0.0  | 0.0       | 0.0          | false    | true     |

    When Loan Pay-off is made on "20240225"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C3108 @AdvancedPaymentAllocation
  Scenario: Verify Loan re-aging transaction reverse-replay - UC2: backdated repayment
    When Admin sets the business date to "20240101"
    When Admin creates a client with random data
    When Admin set "LP2_DOWNPAYMENT_AUTO_ADVANCED_PAYMENT_ALLOCATION" loan product "DEFAULT" transaction type to "NEXT_INSTALLMENT" future installment allocation rule
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                      | submitted on date | with Principal | ANNUAL interest rate % | interest type | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_DOWNPAYMENT_AUTO_ADVANCED_PAYMENT_ALLOCATION | 20240101   | 500            | 0                      | FLAT          | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 45                | DAYS                  | 15             | DAYS                   | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240101" with "500" amount and expected disbursement date on "20240101"
    When Admin successfully disburse the loan on "20240101" with "500" EUR transaction amount
#    --- Re-aging transaction ---
    When Admin sets the business date to "20240220"
    When Admin creates a Loan re-aging transaction with the following data:
      | frequencyNumber | frequencyType | startDate     | numberOfInstallments |
      | 1               | MONTHS        | 20240301 | 2                    |
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101  |                  | 500.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 0    | 20240101  | 20240101  | 375.0           | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 125.0 | 0.0        | 0.0  | 0.0         |
      | 2  | 15   | 20240116  | 20240220 | 375.0           | 0.0           | 0.0      | 0.0  | 0.0       | 0.0   | 0.0   | 0.0        | 0.0  | 0.0         |
      | 3  | 15   | 20240131  | 20240220 | 375.0           | 0.0           | 0.0      | 0.0  | 0.0       | 0.0   | 0.0   | 0.0        | 0.0  | 0.0         |
      | 4  | 15   | 20240215 | 20240220 | 375.0           | 0.0           | 0.0      | 0.0  | 0.0       | 0.0   | 0.0   | 0.0        | 0.0  | 0.0         |
      | 5  | 15   | 20240301    |                  | 187.0           | 188.0         | 0.0      | 0.0  | 0.0       | 188.0 | 0.0   | 0.0        | 0.0  | 188.0       |
      | 6  | 31   | 20240401    |                  | 0.0             | 187.0         | 0.0      | 0.0  | 0.0       | 187.0 | 0.0   | 0.0        | 0.0  | 187.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      | 500.0         | 0.0      | 0.0  | 0.0       | 500.0 | 125.0 | 0.0        | 0.0  | 375.0       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 500.0  | 0.0       | 0.0      | 0.0  | 0.0       | 500.0        | false    | false    |
      | 20240101  | Down Payment     | 125.0  | 125.0     | 0.0      | 0.0  | 0.0       | 375.0        | false    | false    |
      | 20240220 | Re-age           | 375.0  | 375.0     | 0.0      | 0.0  | 0.0       | 0.0          | false    | false    |
#    --- Backdated repayment ---
    When Admin sets the business date to "20240225"
    And Customer makes "AUTOPAY" repayment on "20240116" with 125 EUR transaction amount
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101  |                  | 500.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 0    | 20240101  | 20240101  | 375.0           | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 125.0 | 0.0        | 0.0  | 0.0         |
      | 2  | 15   | 20240116  | 20240116  | 250.0           | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 125.0 | 0.0        | 0.0  | 0.0         |
      | 3  | 15   | 20240131  | 20240220 | 250.0           | 0.0           | 0.0      | 0.0  | 0.0       | 0.0   | 0.0   | 0.0        | 0.0  | 0.0         |
      | 4  | 15   | 20240215 | 20240220 | 250.0           | 0.0           | 0.0      | 0.0  | 0.0       | 0.0   | 0.0   | 0.0        | 0.0  | 0.0         |
      | 5  | 15   | 20240301    |                  | 125.0           | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 0.0   | 0.0        | 0.0  | 125.0       |
      | 6  | 31   | 20240401    |                  | 0.0             | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 0.0   | 0.0        | 0.0  | 125.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      | 500.0         | 0.0      | 0.0  | 0.0       | 500.0 | 250.0 | 0.0        | 0.0  | 250.0       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 500.0  | 0.0       | 0.0      | 0.0  | 0.0       | 500.0        | false    | false    |
      | 20240101  | Down Payment     | 125.0  | 125.0     | 0.0      | 0.0  | 0.0       | 375.0        | false    | false    |
      | 20240116  | Repayment        | 125.0  | 125.0     | 0.0      | 0.0  | 0.0       | 250.0        | false    | false    |
      | 20240220 | Re-age           | 250.0  | 250.0     | 0.0      | 0.0  | 0.0       | 0.0          | false    | true     |

    When Loan Pay-off is made on "20240225"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C3109 @AdvancedPaymentAllocation
  Scenario: Verify Loan re-aging transaction reverse-replay - UC3: backdated disbursement
    When Admin sets the business date to "20240101"
    When Admin creates a client with random data
    When Admin set "LP2_DOWNPAYMENT_AUTO_ADVANCED_PAYMENT_ALLOCATION" loan product "DEFAULT" transaction type to "NEXT_INSTALLMENT" future installment allocation rule
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                      | submitted on date | with Principal | ANNUAL interest rate % | interest type | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_DOWNPAYMENT_AUTO_ADVANCED_PAYMENT_ALLOCATION | 20240101   | 500            | 0                      | FLAT          | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 45                | DAYS                  | 15             | DAYS                   | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240101" with "500" amount and expected disbursement date on "20240101"
    When Admin successfully disburse the loan on "20240101" with "500" EUR transaction amount
#    --- Re-aging transaction ---
    When Admin sets the business date to "20240220"
    When Admin creates a Loan re-aging transaction with the following data:
      | frequencyNumber | frequencyType | startDate     | numberOfInstallments |
      | 1               | MONTHS        | 20240301 | 2                    |
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101  |                  | 500.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 0    | 20240101  | 20240101  | 375.0           | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 125.0 | 0.0        | 0.0  | 0.0         |
      | 2  | 15   | 20240116  | 20240220 | 375.0           | 0.0           | 0.0      | 0.0  | 0.0       | 0.0   | 0.0   | 0.0        | 0.0  | 0.0         |
      | 3  | 15   | 20240131  | 20240220 | 375.0           | 0.0           | 0.0      | 0.0  | 0.0       | 0.0   | 0.0   | 0.0        | 0.0  | 0.0         |
      | 4  | 15   | 20240215 | 20240220 | 375.0           | 0.0           | 0.0      | 0.0  | 0.0       | 0.0   | 0.0   | 0.0        | 0.0  | 0.0         |
      | 5  | 15   | 20240301    |                  | 187.0           | 188.0         | 0.0      | 0.0  | 0.0       | 188.0 | 0.0   | 0.0        | 0.0  | 188.0       |
      | 6  | 31   | 20240401    |                  | 0.0             | 187.0         | 0.0      | 0.0  | 0.0       | 187.0 | 0.0   | 0.0        | 0.0  | 187.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      | 500.0         | 0.0      | 0.0  | 0.0       | 500.0 | 125.0 | 0.0        | 0.0  | 375.0       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 500.0  | 0.0       | 0.0      | 0.0  | 0.0       | 500.0        | false    | false    |
      | 20240101  | Down Payment     | 125.0  | 125.0     | 0.0      | 0.0  | 0.0       | 375.0        | false    | false    |
      | 20240220 | Re-age           | 375.0  | 375.0     | 0.0      | 0.0  | 0.0       | 0.0          | false    | false    |
#    --- Backdated disbursement ---
    When Admin sets the business date to "20240225"
    When Admin successfully disburse the loan on "20240116" with "100" EUR transaction amount
    Then Loan Repayment schedule has 7 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101  |                  | 500.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 0    | 20240101  | 20240101  | 375.0           | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 125.0 | 0.0        | 0.0  | 0.0         |
      | 2  | 15   | 20240116  | 20240220 | 350.0           | 25.0          | 0.0      | 0.0  | 0.0       | 25.0  | 25.0  | 0.0        | 0.0  | 0.0         |
      |    |      | 20240116  |                  | 100.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 3  | 0    | 20240116  | 20240220 | 450.0           | 0.0           | 0.0      | 0.0  | 0.0       | 0.0   | 0.0   | 0.0        | 0.0  | 0.0         |
      | 4  | 15   | 20240131  | 20240220 | 450.0           | 0.0           | 0.0      | 0.0  | 0.0       | 0.0   | 0.0   | 0.0        | 0.0  | 0.0         |
      | 5  | 15   | 20240215 | 20240220 | 450.0           | 0.0           | 0.0      | 0.0  | 0.0       | 0.0   | 0.0   | 0.0        | 0.0  | 0.0         |
      | 6  | 15   | 20240301    |                  | 225.0           | 225.0         | 0.0      | 0.0  | 0.0       | 225.0 | 0.0   | 0.0        | 0.0  | 225.0       |
      | 7  | 31   | 20240401    |                  | 0.0             | 225.0         | 0.0      | 0.0  | 0.0       | 225.0 | 0.0   | 0.0        | 0.0  | 225.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      | 600.0         | 0.0      | 0.0  | 0.0       | 600.0 | 150.0 | 0.0        | 0.0  | 450.0       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 500.0  | 0.0       | 0.0      | 0.0  | 0.0       | 500.0        | false    | false    |
      | 20240101  | Down Payment     | 125.0  | 125.0     | 0.0      | 0.0  | 0.0       | 375.0        | false    | false    |
      | 20240116  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 475.0        | false    | false    |
      | 20240116  | Down Payment     | 25.0   | 25.0      | 0.0      | 0.0  | 0.0       | 450.0        | false    | false    |
      | 20240220 | Re-age           | 450.0  | 450.0     | 0.0      | 0.0  | 0.0       | 0.0          | false    | true     |

    When Loan Pay-off is made on "20240225"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C3110 @AdvancedPaymentAllocation
  Scenario: Verify Loan re-aging transaction reverse-replay - UC4: backdated charge
    When Admin sets the business date to "20240101"
    When Admin creates a client with random data
    When Admin set "LP2_DOWNPAYMENT_AUTO_ADVANCED_PAYMENT_ALLOCATION" loan product "DEFAULT" transaction type to "NEXT_INSTALLMENT" future installment allocation rule
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                      | submitted on date | with Principal | ANNUAL interest rate % | interest type | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_DOWNPAYMENT_AUTO_ADVANCED_PAYMENT_ALLOCATION | 20240101   | 500            | 0                      | FLAT          | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 45                | DAYS                  | 15             | DAYS                   | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240101" with "500" amount and expected disbursement date on "20240101"
    When Admin successfully disburse the loan on "20240101" with "500" EUR transaction amount
    When Admin sets the business date to "20240116"
    And Customer makes "AUTOPAY" repayment on "20240116" with 145 EUR transaction amount
#    --- Re-aging transaction ---
    When Admin sets the business date to "20240220"
    When Admin creates a Loan re-aging transaction with the following data:
      | frequencyNumber | frequencyType | startDate     | numberOfInstallments |
      | 1               | MONTHS        | 20240301 | 2                    |
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101  |                  | 500.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 0    | 20240101  | 20240101  | 375.0           | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 125.0 | 0.0        | 0.0  | 0.0         |
      | 2  | 15   | 20240116  | 20240116  | 250.0           | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 125.0 | 0.0        | 0.0  | 0.0         |
      | 3  | 15   | 20240131  | 20240220 | 230.0           | 20.0          | 0.0      | 0.0  | 0.0       | 20.0  | 20.0  | 20.0       | 0.0  | 0.0         |
      | 4  | 15   | 20240215 | 20240220 | 230.0           | 0.0           | 0.0      | 0.0  | 0.0       | 0.0   | 0.0   | 0.0        | 0.0  | 0.0         |
      | 5  | 15   | 20240301    |                  | 115.0           | 115.0         | 0.0      | 0.0  | 0.0       | 115.0 | 0.0   | 0.0        | 0.0  | 115.0       |
      | 6  | 31   | 20240401    |                  | 0.0             | 115.0         | 0.0      | 0.0  | 0.0       | 115.0 | 0.0   | 0.0        | 0.0  | 115.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      | 500.0         | 0.0      | 0.0  | 0.0       | 500.0 | 270.0 | 20.0       | 0.0  | 230.0       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 500.0  | 0.0       | 0.0      | 0.0  | 0.0       | 500.0        | false    | false    |
      | 20240101  | Down Payment     | 125.0  | 125.0     | 0.0      | 0.0  | 0.0       | 375.0        | false    | false    |
      | 20240116  | Repayment        | 145.0  | 145.0     | 0.0      | 0.0  | 0.0       | 230.0        | false    | false    |
      | 20240220 | Re-age           | 230.0  | 230.0     | 0.0      | 0.0  | 0.0       | 0.0          | false    | false    |
#    --- Backdated charge ---
    When Admin sets the business date to "20240225"
    When Admin adds "LOAN_NSF_FEE" due date charge with "20240115" due date and 20 EUR transaction amount
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101  |                  | 500.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 0    | 20240101  | 20240101  | 375.0           | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 125.0 | 0.0        | 0.0  | 0.0         |
      | 2  | 15   | 20240116  | 20240116  | 250.0           | 125.0         | 0.0      | 0.0  | 20.0      | 145.0 | 145.0 | 0.0        | 0.0  | 0.0         |
      | 3  | 15   | 20240131  | 20240220 | 250.0           | 0.0           | 0.0      | 0.0  | 0.0       | 0.0   | 0.0   | 0.0        | 0.0  | 0.0         |
      | 4  | 15   | 20240215 | 20240220 | 250.0           | 0.0           | 0.0      | 0.0  | 0.0       | 0.0   | 0.0   | 0.0        | 0.0  | 0.0         |
      | 5  | 15   | 20240301    |                  | 125.0           | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 0.0   | 0.0        | 0.0  | 125.0       |
      | 6  | 31   | 20240401    |                  | 0.0             | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 0.0   | 0.0        | 0.0  | 125.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      | 500.0         | 0.0      | 0.0  | 20.0      | 520.0 | 270.0 | 0.0        | 0.0  | 250.0       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 500.0  | 0.0       | 0.0      | 0.0  | 0.0       | 500.0        | false    | false    |
      | 20240101  | Down Payment     | 125.0  | 125.0     | 0.0      | 0.0  | 0.0       | 375.0        | false    | false    |
      | 20240116  | Repayment        | 145.0  | 125.0     | 0.0      | 0.0  | 20.0      | 250.0        | false    | true     |
      | 20240220 | Re-age           | 250.0  | 250.0     | 0.0      | 0.0  | 0.0       | 0.0          | false    | true     |

    When Loan Pay-off is made on "20240225"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C4036 @AdvancedPaymentAllocation
  Scenario: Verify that Loan re-aging transaction made by Loan external ID with undo and additional re-age trn at the same date works properly - UC1
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
    When Admin sets the business date to "20240220"
    When Admin creates a Loan re-aging transaction by Loan external ID with the following data:
      | frequencyNumber | frequencyType | startDate     | numberOfInstallments |
      | 30              | DAYS          | 20240310 | 2                    |
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101  |                  | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 0    | 20240101  | 20240101  | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0  | 0.0         |
      | 2  | 15   | 20240116  | 20240220 | 750.0           | 0.0           | 0.0      | 0.0  | 0.0       | 0.0   | 0.0   | 0.0        | 0.0  | 0.0         |
      | 3  | 15   | 20240131  | 20240220 | 750.0           | 0.0           | 0.0      | 0.0  | 0.0       | 0.0   | 0.0   | 0.0        | 0.0  | 0.0         |
      | 4  | 15   | 20240215 | 20240220 | 750.0           | 0.0           | 0.0      | 0.0  | 0.0       | 0.0   | 0.0   | 0.0        | 0.0  | 0.0         |
      | 5  | 24   | 20240310    |                  | 375.0           | 375.0         | 0.0      | 0.0  | 0.0       | 375.0 | 0.0   | 0.0        | 0.0  | 375.0       |
      | 6  | 30   | 20240409    |                  | 0.0             | 375.0         | 0.0      | 0.0  | 0.0       | 375.0 | 0.0   | 0.0        | 0.0  | 375.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 1000.0        | 0.0      | 0.0  | 0.0       | 1000.0 | 250.0 | 0.0        | 0.0  | 750.0       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       | false    | false    |
      | 20240101  | Down Payment     | 250.0  | 250.0     | 0.0      | 0.0  | 0.0       | 750.0        | false    | false    |
      | 20240220 | Re-age           | 750.0  | 750.0     | 0.0      | 0.0  | 0.0       | 0.0          | false    | false    |
#-- undo re-aging transaction ---#
    When Admin successfully undo Loan re-aging transaction
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
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       | false    | false    |
      | 20240101  | Down Payment     | 250.0  | 250.0     | 0.0      | 0.0  | 0.0       | 750.0        | false    | false    |
      | 20240220 | Re-age           | 750.0  | 750.0     | 0.0      | 0.0  | 0.0       | 0.0          | true     | false    |
    Then Admin checks that delinquency range is: "RANGE_30" and has delinquentDate "2024-01-19"
# --- make re-age transaction again ---#
    When Admin creates a Loan re-aging transaction by Loan external ID with the following data:
      | frequencyNumber | frequencyType | startDate     | numberOfInstallments |
      | 30              | DAYS          | 20240310 | 2                    |
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101  |                  | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 0    | 20240101  | 20240101  | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0  | 0.0         |
      | 2  | 15   | 20240116  | 20240220 | 750.0           | 0.0           | 0.0      | 0.0  | 0.0       | 0.0   | 0.0   | 0.0        | 0.0  | 0.0         |
      | 3  | 15   | 20240131  | 20240220 | 750.0           | 0.0           | 0.0      | 0.0  | 0.0       | 0.0   | 0.0   | 0.0        | 0.0  | 0.0         |
      | 4  | 15   | 20240215 | 20240220 | 750.0           | 0.0           | 0.0      | 0.0  | 0.0       | 0.0   | 0.0   | 0.0        | 0.0  | 0.0         |
      | 5  | 24   | 20240310    |                  | 375.0           | 375.0         | 0.0      | 0.0  | 0.0       | 375.0 | 0.0   | 0.0        | 0.0  | 375.0       |
      | 6  | 30   | 20240409    |                  | 0.0             | 375.0         | 0.0      | 0.0  | 0.0       | 375.0 | 0.0   | 0.0        | 0.0  | 375.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 1000.0        | 0.0      | 0.0  | 0.0       | 1000.0 | 250.0 | 0.0        | 0.0  | 750.0       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       | false    | false    |
      | 20240101  | Down Payment     | 250.0  | 250.0     | 0.0      | 0.0  | 0.0       | 750.0        | false    | false    |
      | 20240220 | Re-age           | 750.0  | 750.0     | 0.0      | 0.0  | 0.0       | 0.0          | true     | false    |
      | 20240220 | Re-age           | 750.0  | 750.0     | 0.0      | 0.0  | 0.0       | 0.0          | false    | false    |

    When Loan Pay-off is made on "20240220"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C4037 @AdvancedPaymentAllocation
  Scenario: Verify Loan re-aging transaction - reverse-replay scenario with undo and re-age trn again at the same date - UC2
    When Admin sets the business date to "20240101"
    When Admin creates a client with random data
    When Admin set "LP2_DOWNPAYMENT_AUTO_ADVANCED_PAYMENT_ALLOCATION" loan product "DEFAULT" transaction type to "NEXT_INSTALLMENT" future installment allocation rule
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                      | submitted on date | with Principal | ANNUAL interest rate % | interest type | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_DOWNPAYMENT_AUTO_ADVANCED_PAYMENT_ALLOCATION | 20240101   | 1000           | 0                      | FLAT          | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 45                | DAYS                  | 15             | DAYS                   | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240101" with "1000" amount and expected disbursement date on "20240101"
    When Admin successfully disburse the loan on "20240101" with "1000" EUR transaction amount
    When Admin runs inline COB job for Loan
    When Admin sets the business date to "20240201"
    When Admin runs inline COB job for Loan
    When Admin sets the business date to "20240227"
    When Admin creates a Loan re-aging transaction with the following data:
      | frequencyNumber | frequencyType | startDate     | numberOfInstallments |
      | 1               | MONTHS        | 20240301 | 3                    |
    And Customer makes "AUTOPAY" repayment on "20240201" with 250 EUR transaction amount
# --- undo re-aging transaction --- #
    When Admin successfully undo Loan re-aging transaction
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late  | Outstanding |
      |    |      | 20240101  |                  | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |       |             |
      | 1  | 0    | 20240101  | 20240101  | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0   | 0.0         |
      | 2  | 15   | 20240116  | 20240201 | 500.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 250.0 | 0.0         |
      | 3  | 15   | 20240131  |                  | 250.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0   | 0.0        | 0.0   | 250.0       |
      | 4  | 15   | 20240215 |                  | 0.0             | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0   | 0.0        | 0.0   | 250.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late  | Outstanding |
      | 1000.0        | 0.0      | 0.0  | 0.0       | 1000.0 | 500.0 | 0.0        | 250.0 | 500.0       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20240101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       | false    |
      | 20240101  | Down Payment     | 250.0  | 250.0     | 0.0      | 0.0  | 0.0       | 750.0        | false    |
      | 20240201 | Repayment        | 250.0  | 250.0     | 0.0      | 0.0  | 0.0       | 500.0        | false    |
      | 20240227 | Re-age           | 500.0  | 500.0     | 0.0      | 0.0  | 0.0       | 0.0          | true     |
# --- make re-age transaction again ---#
    When Admin creates a Loan re-aging transaction with the following data:
      | frequencyNumber | frequencyType | startDate     | numberOfInstallments |
      | 1               | MONTHS        | 20240301 | 3                    |
    Then Loan Repayment schedule has 7 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late  | Outstanding |
      |    |      | 20240101  |                  | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |       |             |
      | 1  | 0    | 20240101  | 20240101  | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0   | 0.0         |
      | 2  | 15   | 20240116  | 20240201 | 500.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 250.0 | 0.0         |
      | 3  | 15   | 20240131  | 20240227 | 500.0           |   0.0         | 0.0      | 0.0  | 0.0       |   0.0 | 0.0   | 0.0        | 0.0   | 0.0         |
      | 4  | 15   | 20240215 | 20240227 | 500.0           |   0.0         | 0.0      | 0.0  | 0.0       |   0.0 | 0.0   | 0.0        | 0.0   | 0.0         |
      | 5  | 15   | 20240301    |                  | 333.0           | 167.0         | 0.0      | 0.0  | 0.0       | 167.0 | 0.0   | 0.0        | 0.0   | 167.0       |
      | 6  | 31   | 20240401    |                  | 166.0           | 167.0         | 0.0      | 0.0  | 0.0       | 167.0 | 0.0   | 0.0        | 0.0   | 167.0       |
      | 7  | 30   | 20240501      |                  |   0.0           | 166.0         | 0.0      | 0.0  | 0.0       | 166.0 | 0.0   | 0.0        | 0.0   | 166.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late  | Outstanding |
      | 1000.0        | 0.0      | 0.0  | 0.0       | 1000.0 | 500.0 | 0.0        | 250.0 | 500.0       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20240101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       | false    |
      | 20240101  | Down Payment     | 250.0  | 250.0     | 0.0      | 0.0  | 0.0       | 750.0        | false    |
      | 20240201 | Repayment        | 250.0  | 250.0     | 0.0      | 0.0  | 0.0       | 500.0        | false    |
      | 20240227 | Re-age           | 500.0  | 500.0     | 0.0      | 0.0  | 0.0       | 0.0          | true     |
      | 20240227 | Re-age           | 500.0  | 500.0     | 0.0      | 0.0  | 0.0       | 0.0          | false    |

    When Loan Pay-off is made on "20240201"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C4038 @AdvancedPaymentAllocation
  Scenario: Verify that Loan re-aging transaction - chargeback before maturity and prior to re-aging - with undo and re-age trn again at the same date - UC3
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
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 1000.0        | 0.0      | 0.0  | 0.0       | 1000.0 | 0.0   | 0.0        | 0.0  | 1000.0      |
    When Admin sets the business date to "20240101"
    And Customer makes "AUTOPAY" repayment on "20240101" with 250 EUR transaction amount
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
      | 20240101  | Repayment        | 250.0  | 250.0     | 0.0      | 0.0  | 0.0       | 750.0        | false    |
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
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20240101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       | false    |
      | 20240101  | Repayment        | 250.0  | 250.0     | 0.0      | 0.0  | 0.0       | 750.0        | false    |
      | 20240202 | Chargeback       | 125.0  | 125.0     | 0.0      | 0.0  | 0.0       | 875.0        | false    |
    When Admin sets the business date to "20240221"
    When Admin creates a Loan re-aging transaction by Loan external ID with the following data:
      | frequencyNumber | frequencyType | startDate     | numberOfInstallments |
      | 2               | MONTHS        | 20240310 | 3                    |
    Then Loan Repayment schedule has 7 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101  |                  | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0   |            |      |             |
      | 1  | 0    | 20240101  | 20240101  | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0  | 250.0 | 0.0        | 0.0  | 0.0         |
      | 2  | 15   | 20240116  | 20240221 | 750.0           | 0.0           | 0.0      | 0.0  | 0.0       | 0.0    | 0.0   | 0.0        | 0.0  | 0.0         |
      | 3  | 15   | 20240131  | 20240221 | 750.0           | 0.0           | 0.0      | 0.0  | 0.0       | 0.0    | 0.0   | 0.0        | 0.0  | 0.0         |
      | 4  | 15   | 20240215 | 20240221 | 875.0           | 0.0           | 0.0      | 0.0  | 0.0       | 0.0    | 0.0   | 0.0        | 0.0  | 0.0         |
      | 5  | 24   | 20240310    |                  | 583.33          | 291.67        | 0.0      | 0.0  | 0.0       | 291.67 | 0.0   | 0.0        | 0.0  | 291.67      |
      | 6  | 61   | 20240510      |                  | 291.66          | 291.67        | 0.0      | 0.0  | 0.0       | 291.67 | 0.0   | 0.0        | 0.0  | 291.67      |
      | 7  | 61   | 20240710     |                  | 0.0             | 291.66        | 0.0      | 0.0  | 0.0       | 291.66 | 0.0   | 0.0        | 0.0  | 291.66      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20240101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       | false    |
      | 20240101  | Repayment        | 250.0  | 250.0     | 0.0      | 0.0  | 0.0       | 750.0        | false    |
      | 20240202 | Chargeback       | 125.0  | 125.0     | 0.0      | 0.0  | 0.0       | 875.0        | false    |
      | 20240221 | Re-age           | 875.0  | 875.0     | 0.0      | 0.0  | 0.0       | 0.0          | false    |
# --- undo re-aging transaction --- #
    When Admin successfully undo Loan re-aging transaction
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
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20240101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       | false    |
      | 20240101  | Repayment        | 250.0  | 250.0     | 0.0      | 0.0  | 0.0       | 750.0        | false    |
      | 20240202 | Chargeback       | 125.0  | 125.0     | 0.0      | 0.0  | 0.0       | 875.0        | false    |
      | 20240221 | Re-age           | 875.0  | 875.0     | 0.0      | 0.0  | 0.0       | 0.0          | true     |
# --- make re-age transaction again --- #
    When Admin creates a Loan re-aging transaction by Loan external ID with the following data:
      | frequencyNumber | frequencyType | startDate     | numberOfInstallments |
      | 2               | MONTHS        | 20240310 | 3                    |
    Then Loan Repayment schedule has 7 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101  |                  | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0   |            |      |             |
      | 1  | 0    | 20240101  | 20240101  | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0  | 250.0 | 0.0        | 0.0  | 0.0         |
      | 2  | 15   | 20240116  | 20240221 | 750.0           | 0.0           | 0.0      | 0.0  | 0.0       | 0.0    | 0.0   | 0.0        | 0.0  | 0.0         |
      | 3  | 15   | 20240131  | 20240221 | 750.0           | 0.0           | 0.0      | 0.0  | 0.0       | 0.0    | 0.0   | 0.0        | 0.0  | 0.0         |
      | 4  | 15   | 20240215 | 20240221 | 875.0           | 0.0           | 0.0      | 0.0  | 0.0       | 0.0    | 0.0   | 0.0        | 0.0  | 0.0         |
      | 5  | 24   | 20240310    |                  | 583.33          | 291.67        | 0.0      | 0.0  | 0.0       | 291.67 | 0.0   | 0.0        | 0.0  | 291.67      |
      | 6  | 61   | 20240510      |                  | 291.66          | 291.67        | 0.0      | 0.0  | 0.0       | 291.67 | 0.0   | 0.0        | 0.0  | 291.67      |
      | 7  | 61   | 20240710     |                  | 0.0             | 291.66        | 0.0      | 0.0  | 0.0       | 291.66 | 0.0   | 0.0        | 0.0  | 291.66      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 1125.0        | 0.0      | 0.0  | 0.0       | 1125.0 | 250.0 | 0.0        | 0.0  | 875.0       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20240101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       | false    |
      | 20240101  | Repayment        | 250.0  | 250.0     | 0.0      | 0.0  | 0.0       | 750.0        | false    |
      | 20240202 | Chargeback       | 125.0  | 125.0     | 0.0      | 0.0  | 0.0       | 875.0        | false    |
      | 20240221 | Re-age           | 875.0  | 875.0     | 0.0      | 0.0  | 0.0       | 0.0          | true     |
      | 20240221 | Re-age           | 875.0  | 875.0     | 0.0      | 0.0  | 0.0       | 0.0          | false    |

    When Loan Pay-off is made on "20240221"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C4039 @AdvancedPaymentAllocation
  Scenario: Verify that Loan re-aging transaction - chargeback after maturity date and prior to re-aging with charge N+1 installment - with undo and re-age trn again at the same date - UC4
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
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 1000.0        | 0.0      | 0.0  | 0.0       | 1000.0 | 0.0   | 0.0        | 0.0  | 1000.0      |
    When Admin sets the business date to "20240101"
    And Customer makes "AUTOPAY" repayment on "20240101" with 250 EUR transaction amount
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
      | 20240101  | Repayment        | 250.0  | 250.0     | 0.0      | 0.0  | 0.0       | 750.0        | false    |
    When Admin sets the business date to "20240226"
    When Admin makes "REPAYMENT_ADJUSTMENT_CHARGEBACK" chargeback with 125 EUR transaction amount
    When Admin adds "LOAN_NSF_FEE" due date charge with "20240226" due date and 20 EUR transaction amount
    Then Loan Repayment schedule has 5 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101  |                 | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 0    | 20240101  | 20240101 | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0  | 0.0         |
      | 2  | 15   | 20240116  |                 | 500.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0   | 0.0        | 0.0  | 250.0       |
      | 3  | 15   | 20240131  |                 | 250.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0   | 0.0        | 0.0  | 250.0       |
      | 4  | 15   | 20240215 |                 | 0.0             | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0   | 0.0        | 0.0  | 250.0       |
      | 5  | 11   | 20240226 |                 | 0.0             | 125.0         | 0.0      | 0.0  | 20.0      | 145.0 | 0.0   | 0.0        | 0.0  | 145.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 1125.0        | 0.0      | 0.0  | 20.0      | 1145.0 | 250.0 | 0.0        | 0.0  | 895.0       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20240101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       | false    |
      | 20240101  | Repayment        | 250.0  | 250.0     | 0.0      | 0.0  | 0.0       | 750.0        | false    |
      | 20240226 | Chargeback       | 125.0  | 125.0     | 0.0      | 0.0  | 0.0       | 875.0        | false    |
    When Admin sets the business date to "20240227"
    When Admin makes a charge adjustment for the last "LOAN_NSF_FEE" type charge which is due on "20240226" with 20 EUR transaction amount and externalId ""
    When Admin creates a Loan re-aging transaction by Loan external ID with the following data:
      | frequencyNumber | frequencyType | startDate     | numberOfInstallments |
      | 2               | MONTHS        | 20240310 | 3                    |
    Then Loan Repayment schedule has 8 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101  |                  | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 0    | 20240101  | 20240101  | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0  | 0.0         |
      | 2  | 15   | 20240116  | 20240227 | 730.0           | 20.0          | 0.0      | 0.0  | 0.0       | 20.0  | 20.0  | 0.0        | 20.0 | 0.0         |
      | 3  | 15   | 20240131  | 20240227 | 730.0           | 0.0           | 0.0      | 0.0  | 0.0       | 0.0   | 0.0   | 0.0        | 0.0  | 0.0         |
      | 4  | 15   | 20240215 | 20240227 | 730.0           | 0.0           | 0.0      | 0.0  | 0.0       | 0.0   | 0.0   | 0.0        | 0.0  | 0.0         |
      | 5  | 11   | 20240226 |                  | 855.0           | 0.0           | 0.0      | 0.0  | 20.0      | 20.0  | 0.0   | 0.0        | 0.0  | 20.0        |
      | 6  | 13   | 20240310    |                  | 570.0           | 285.0         | 0.0      | 0.0  | 0.0       | 285.0 | 0.0   | 0.0        | 0.0  | 285.0       |
      | 7  | 61   | 20240510      |                  | 285.0           | 285.0         | 0.0      | 0.0  | 0.0       | 285.0 | 0.0   | 0.0        | 0.0  | 285.0       |
      | 8  | 61   | 20240710     |                  | 0.0             | 285.0         | 0.0      | 0.0  | 0.0       | 285.0 | 0.0   | 0.0        | 0.0  | 285.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 1125.0        | 0.0      | 0.0  | 20.0      | 1145.0 | 270.0 | 0.0        | 20.0 | 875.0       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type  | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20240101  | Disbursement      | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       | false    |
      | 20240101  | Repayment         | 250.0  | 250.0     | 0.0      | 0.0  | 0.0       | 750.0        | false    |
      | 20240226 | Chargeback        | 125.0  | 125.0     | 0.0      | 0.0  | 0.0       | 875.0        | false    |
      | 20240227 | Charge Adjustment | 20.0   | 20.0      | 0.0      | 0.0  | 0.0       | 855.0        | false    |
      | 20240227 | Re-age            | 855.0  | 855.0     | 0.0      | 0.0  | 0.0       | 0.0          | false    |
# --- undo re-aging transaction --- #
    When Admin successfully undo Loan re-aging transaction
    Then Loan Repayment schedule has 5 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101  |                 | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 0    | 20240101  | 20240101 | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0  | 0.0         |
      | 2  | 15   | 20240116  |                 | 500.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 20.0  | 0.0        | 20.0 | 230.0       |
      | 3  | 15   | 20240131  |                 | 250.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0   | 0.0        | 0.0  | 250.0       |
      | 4  | 15   | 20240215 |                 | 0.0             | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0   | 0.0        | 0.0  | 250.0       |
      | 5  | 11   | 20240226 |                 | 0.0             | 125.0         | 0.0      | 0.0  | 20.0      | 145.0 | 0.0   | 0.0        | 0.0  | 145.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 1125.0        | 0.0      | 0.0  | 20.0      | 1145.0 | 270.0 | 0.0        | 20.0 | 875.0       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type  | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20240101  | Disbursement      | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       | false    |
      | 20240101  | Repayment         | 250.0  | 250.0     | 0.0      | 0.0  | 0.0       | 750.0        | false    |
      | 20240226 | Chargeback        | 125.0  | 125.0     | 0.0      | 0.0  | 0.0       | 875.0        | false    |
      | 20240227 | Charge Adjustment | 20.0   | 20.0      | 0.0      | 0.0  | 0.0       | 855.0        | false    |
      | 20240227 | Re-age            | 855.0  | 855.0     | 0.0      | 0.0  | 0.0       | 0.0          | true     |
# --- make re-age transaction again --- #
    When Admin creates a Loan re-aging transaction by Loan external ID with the following data:
      | frequencyNumber | frequencyType | startDate     | numberOfInstallments |
      | 2               | MONTHS        | 20240310 | 3                    |
    Then Loan Repayment schedule has 8 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101  |                  | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 0    | 20240101  | 20240101  | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0  | 0.0         |
      | 2  | 15   | 20240116  | 20240227 | 730.0           | 20.0          | 0.0      | 0.0  | 0.0       | 20.0  | 20.0  | 0.0        | 20.0 | 0.0         |
      | 3  | 15   | 20240131  | 20240227 | 730.0           | 0.0           | 0.0      | 0.0  | 0.0       | 0.0   | 0.0   | 0.0        | 0.0  | 0.0         |
      | 4  | 15   | 20240215 | 20240227 | 730.0           | 0.0           | 0.0      | 0.0  | 0.0       | 0.0   | 0.0   | 0.0        | 0.0  | 0.0         |
      | 5  | 11   | 20240226 |                  | 855.0           | 0.0           | 0.0      | 0.0  | 20.0      | 20.0  | 0.0   | 0.0        | 0.0  | 20.0        |
      | 6  | 13   | 20240310    |                  | 570.0           | 285.0         | 0.0      | 0.0  | 0.0       | 285.0 | 0.0   | 0.0        | 0.0  | 285.0       |
      | 7  | 61   | 20240510      |                  | 285.0           | 285.0         | 0.0      | 0.0  | 0.0       | 285.0 | 0.0   | 0.0        | 0.0  | 285.0       |
      | 8  | 61   | 20240710     |                  | 0.0             | 285.0         | 0.0      | 0.0  | 0.0       | 285.0 | 0.0   | 0.0        | 0.0  | 285.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 1125.0        | 0.0      | 0.0  | 20.0      | 1145.0 | 270.0 | 0.0        | 20.0 | 875.0       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type  | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20240101  | Disbursement      | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       | false    |
      | 20240101  | Repayment         | 250.0  | 250.0     | 0.0      | 0.0  | 0.0       | 750.0        | false    |
      | 20240226 | Chargeback        | 125.0  | 125.0     | 0.0      | 0.0  | 0.0       | 875.0        | false    |
      | 20240227 | Charge Adjustment | 20.0   | 20.0      | 0.0      | 0.0  | 0.0       | 855.0        | false    |
      | 20240227 | Re-age            | 855.0  | 855.0     | 0.0      | 0.0  | 0.0       | 0.0          | true     |
      | 20240227 | Re-age            | 855.0  | 855.0     | 0.0      | 0.0  | 0.0       | 0.0          | false    |

    When Loan Pay-off is made on "20240227"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C4044 @AdvancedPaymentAllocation
  Scenario: Verify that Loan re-aging transaction - with charge N+1 installment after maturity date prior to re-aging - UC1
    When Admin sets the business date to "20250101"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                        | submitted on date | with Principal | ANNUAL interest rate % | interest type | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_DOWNPAYMENT_ADV_PMT_ALLOC_PROGRESSIVE_LOAN_SCHEDULE_HORIZONTAL | 20250101   | 1000           | 0                      | FLAT          | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 3                 | MONTHS                 | 1             | MONTHS                 | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
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
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 1000.0        | 0.0      | 0.0  | 0.0       | 1000.0 | 0.0   | 0.0        | 0.0  | 1000.0      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type  | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20250101  | Disbursement      | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       | false    |
# --- add charge a month later --- #
    When Admin sets the business date to "20250503"
    And Admin adds "LOAN_NSF_FEE" due date charge with "20250503" due date and 10 EUR transaction amount
    Then Loan Repayment schedule has 5 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20250101  |           | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 0    | 20250101  |           | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0  | 0.0        | 0.0  | 250.0       |
      | 2  | 31   | 20250201 |           | 500.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0  | 0.0        | 0.0  | 250.0       |
      | 3  | 28   | 20250301    |           | 250.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0  | 0.0        | 0.0  | 250.0       |
      | 4  | 31   | 20250401    |           | 0.0             | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0  | 0.0        | 0.0  | 250.0       |
      | 5  | 32   | 20250503      |           | 0.0             |   0.0         | 0.0      | 0.0  | 10.0      |  10.0 | 0.0  | 0.0        | 0.0  |  10.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 1000.0        | 0.0      | 0.0  | 10.0      | 1010.0 | 0.0   | 0.0        | 0.0  | 1010.0      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type  | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20250101  | Disbursement      | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       | false    |
    Then Loan Charges tab has the following data:
      | Name    | isPenalty | Payment due at       | Due as of   | Calculation type | Due  | Paid | Waived | Outstanding |
      | NSF fee | true      | Specified due date   | 20250503 | Flat             | 10.0 | 0.0  | 0.0    | 10.0        |
# --- add re-aging trn with start date as maturity date --- #
    When Admin creates a Loan re-aging transaction by Loan external ID with the following data:
      | frequencyNumber | frequencyType | startDate     | numberOfInstallments |
      | 1               | WEEKS        | 20250401  | 1                    |
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date     | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      |    |      | 20250101  |               | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      | 1  | 0    | 20250101  | 20250401 | 1000.0          | 0.0           | 0.0      | 0.0  | 0.0       | 0.0    | 0.0  | 0.0        | 0.0  | 0.0         |
      | 2  | 31   | 20250201 | 20250401 | 1000.0          | 0.0           | 0.0      | 0.0  | 0.0       | 0.0    | 0.0  | 0.0        | 0.0  | 0.0         |
      | 3  | 28   | 20250301    | 20250401 | 1000.0          | 0.0           | 0.0      | 0.0  | 0.0       | 0.0    | 0.0  | 0.0        | 0.0  | 0.0         |
      | 4  | 31   | 20250401    | 20250401 | 1000.0             | 0.0        | 0.0      | 0.0  | 0.0       | 0.0  | 0.0  | 0.0        | 0.0  | 0.0      |
      | 5  | 0    | 20250401    |               | 0.0             | 1000.0        | 0.0      | 0.0  | 0.0       | 1000.0 | 0.0  | 0.0        | 0.0  | 1000.0      |
      | 6  | 32   | 20250503      |               | 0.0             | 0.0           | 0.0      | 0.0  | 10.0      | 10.0   | 0.0  | 0.0        | 0.0  | 10.0        |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 1000.0        | 0.0      | 0.0  | 10.0      | 1010.0 | 0.0  | 0.0        | 0.0  | 1010.0      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20250101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       | false    |
      | 20250401    | Re-age           | 1000.0 | 1000.0    | 0.0      | 0.0  | 0.0       | 0.0          | false    |
    Then Loan Charges tab has the following data:
      | Name    | isPenalty | Payment due at       | Due as of   | Calculation type | Due  | Paid | Waived | Outstanding |
      | NSF fee | true      | Specified due date   | 20250503 | Flat             | 10.0 | 0.0  | 0.0    | 10.0        |

    When Loan Pay-off is made on "20250503"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C4045 @AdvancedPaymentAllocation
  Scenario: Verify that Loan re-aging transaction with backdated repayment and charge - N+1 installment after maturity date prior to re-aging - UC2
    When Admin sets the business date to "20250101"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                        | submitted on date | with Principal | ANNUAL interest rate % | interest type | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_DOWNPAYMENT_ADV_PMT_ALLOC_PROGRESSIVE_LOAN_SCHEDULE_HORIZONTAL | 20250101   | 1000           | 0                      | FLAT          | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 3                 | MONTHS                 | 1             | MONTHS                 | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
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
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 1000.0        | 0.0      | 0.0  | 0.0       | 1000.0 | 0.0   | 0.0        | 0.0  | 1000.0      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type  | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20250101  | Disbursement      | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       | false    |
# --- add charge a month later --- #
    When Admin sets the business date to "20250503"
    And Customer makes "AUTOPAY" repayment on "20250301" with 250 EUR transaction amount
    And Admin adds "LOAN_NSF_FEE" due date charge with "20250503" due date and 10 EUR transaction amount
    Then Loan Repayment schedule has 5 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date     | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20250101  |               | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 0    | 20250101  | 20250301 | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0| 0.0        | 250.0|   0.0       |
      | 2  | 31   | 20250201 |               | 500.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0  | 0.0        | 0.0  | 250.0       |
      | 3  | 28   | 20250301    |               | 250.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0  | 0.0        | 0.0  | 250.0       |
      | 4  | 31   | 20250401    |               | 0.0             | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0  | 0.0        | 0.0  | 250.0       |
      | 5  | 32   | 20250503      |               | 0.0             |   0.0         | 0.0      | 0.0  | 10.0      |  10.0 | 0.0  | 0.0        | 0.0  |  10.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late  | Outstanding |
      | 1000.0        | 0.0      | 0.0  | 10.0      | 1010.0 | 250.0 | 0.0        | 250.0 | 760.0       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type  | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20250101  | Disbursement      | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       | false    |
      | 20250301    | Repayment         | 250.0  | 250.0     | 0.0      | 0.0  | 0.0       | 750.0        | false    |
    Then Loan Charges tab has the following data:
      | Name    | isPenalty | Payment due at       | Due as of   | Calculation type | Due  | Paid | Waived | Outstanding |
      | NSF fee | true      | Specified due date   | 20250503 | Flat             | 10.0 | 0.0  | 0.0    | 10.0        |
# --- add re-aging trn with start date as maturity date --- #
    When Admin creates a Loan re-aging transaction by Loan external ID with the following data:
      | frequencyNumber | frequencyType | startDate     | numberOfInstallments |
      | 1               | WEEKS         | 20250401  | 1                    |
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date     | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late  | Outstanding |
      |    |      | 20250101  |               | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |       |             |
      | 1  | 0    | 20250101  | 20250301 | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 250.0 | 0.0         |
      | 2  | 31   | 20250201 | 20250401 | 750.0           | 0.0           | 0.0      | 0.0  | 0.0       | 0.0   | 0.0   | 0.0        | 0.0   | 0.0         |
      | 3  | 28   | 20250301    | 20250401 | 750.0           | 0.0           | 0.0      | 0.0  | 0.0       | 0.0   | 0.0   | 0.0        | 0.0   | 0.0         |
      | 4  | 31   | 20250401    | 20250401 | 750.0           | 0.0           | 0.0      | 0.0  | 0.0       | 0.0   | 0.0   | 0.0        | 0.0   | 0.0         |
      | 5  | 0    | 20250401    |               | 0.0             | 750.0         | 0.0      | 0.0  | 0.0       | 750.0 | 0.0   | 0.0        | 0.0   | 750.0       |
      | 6  | 32   | 20250503      |               | 0.0             | 0.0           | 0.0      | 0.0  | 10.0      | 10.0  | 0.0   | 0.0        | 0.0   | 10.0        |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late  | Outstanding |
      | 1000.0        | 0.0      | 0.0  | 10.0      | 1010.0 | 250.0 | 0.0        | 250.0 | 760.0       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20250101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       | false    |
      | 20250301    | Repayment        | 250.0  | 250.0     | 0.0      | 0.0  | 0.0       | 750.0        | false    |
      | 20250401    | Re-age           | 750.0  | 750.0     | 0.0      | 0.0  | 0.0       | 0.0          | false    |
    Then Loan Charges tab has the following data:
      | Name    | isPenalty | Payment due at       | Due as of   | Calculation type | Due  | Paid | Waived | Outstanding |
      | NSF fee | true      | Specified due date   | 20250503 | Flat             | 10.0 | 0.0  | 0.0    | 10.0        |

    When Loan Pay-off is made on "20250503"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C4046 @AdvancedPaymentAllocation
  Scenario: Verify that Loan re-aging transaction with downpayment, payoff and charge - N+1 installment after maturity date prior to re-aging - UC3
    When Admin sets the business date to "20250101"
    When Admin creates a client with random data
    When Admin set "LP2_DOWNPAYMENT_AUTO_ADVANCED_PAYMENT_ALLOCATION" loan product "DEFAULT" transaction type to "NEXT_INSTALLMENT" future installment allocation rule
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                      | submitted on date | with Principal | ANNUAL interest rate % | interest type | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_DOWNPAYMENT_AUTO_ADVANCED_PAYMENT_ALLOCATION | 20250101   | 1000           | 0                      | FLAT          | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 45                | DAYS                  | 15             | DAYS                   | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20250101" with "1000" amount and expected disbursement date on "20250101"
    When Admin successfully disburse the loan on "20250101" with "1000" EUR transaction amount
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20250101  |                 | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 0    | 20250101  | 20250101 | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0  | 0.0         |
      | 2  | 15   | 20250116  |                 | 500.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0   | 0.0        | 0.0  | 250.0       |
      | 3  | 15   | 20250131  |                 | 250.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0   | 0.0        | 0.0  | 250.0       |
      | 4  | 15   | 20250215 |                 | 0.0             | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0   | 0.0        | 0.0  | 250.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 1000.0        | 0.0      | 0.0  | 0.0       | 1000.0 | 250.0 | 0.0        | 0.0  | 750.0       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type  | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20250101  | Disbursement      | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       | false    |
      | 20250101  | Down Payment      | 250.0  | 250.0     | 0.0      | 0.0  | 0.0       | 750.0        | false    |
# --- add charge a month later --- #
    When Admin sets the business date to "20250320"
    When Loan Pay-off is made on "20250320"
    And Admin adds "LOAN_NSF_FEE" due date charge with "20250320" due date and 10 EUR transaction amount
    Then Loan Repayment schedule has 5 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late  | Outstanding |
      |    |      | 20250101  |                 | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |       |             |
      | 1  | 0    | 20250101  | 20250101 | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        |   0.0 |   0.0       |
      | 2  | 15   | 20250116  | 20250320   | 500.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 250.0 |   0.0       |
      | 3  | 15   | 20250131  | 20250320   | 250.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 250.0 |   0.0       |
      | 4  | 15   | 20250215 | 20250320   | 0.0             | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 250.0 |   0.0       |
      | 5  | 33   | 20250320    |                 | 0.0             |   0.0         | 0.0      | 0.0  | 10.0      |  10.0 |   0.0 | 0.0        |   0.0 |  10.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late  | Outstanding |
      | 1000.0        | 0.0      | 0.0  | 10.0      | 1010.0 | 1000.0 | 0.0        | 750.0 | 10.0        |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type  | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20250101  | Disbursement      | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       | false    |
      | 20250101  | Down Payment      | 250.0  | 250.0     | 0.0      | 0.0  | 0.0       | 750.0        | false    |
      | 20250320    | Repayment         | 750.0  | 750.0     | 0.0      | 0.0  | 0.0       |   0.0        | false    |
    Then Loan Charges tab has the following data:
      | Name    | isPenalty | Payment due at       | Due as of     | Calculation type | Due  | Paid | Waived | Outstanding |
      | NSF fee | true      | Specified due date   | 20250320 | Flat             | 10.0 | 0.0  | 0.0    | 10.0        |
# --- add re-aging trn with start date as maturity date --- #
    When Admin creates a Loan re-aging transaction by Loan external ID with the following data:
      | frequencyNumber | frequencyType | startDate        | numberOfInstallments |
      | 1               | WEEKS         | 20250215 | 1                    |
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late  | Outstanding |
      |    |      | 20250101  |                  | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |       |             |
      | 1  | 0    | 20250101  | 20250101  | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0   | 0.0         |
      | 2  | 15   | 20250116  | 20250215 | 750.0           | 0.0           | 0.0      | 0.0  | 0.0       | 0.0   | 0.0   | 0.0        | 0.0   | 0.0         |
      | 3  | 15   | 20250131  | 20250215 | 750.0           | 0.0           | 0.0      | 0.0  | 0.0       | 0.0   | 0.0   | 0.0        | 0.0   | 0.0         |
      | 4  | 15   | 20250215 | 20250215 | 750.0           | 0.0           | 0.0      | 0.0  | 0.0       | 0.0   | 0.0   | 0.0        | 0.0   | 0.0         |
      | 5  | 0    | 20250215 | 20250320    | 0.0             | 750.0         | 0.0      | 0.0  | 0.0       | 750.0 | 750.0 | 0.0        | 750.0 | 0.0         |
      | 6  | 33   | 20250320    |                  | 0.0             | 0.0           | 0.0      | 0.0  | 10.0      | 10.0  | 0.0   | 0.0        | 0.0   | 10.0        |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late  | Outstanding |
      | 1000.0        | 0.0      | 0.0  | 10.0      | 1010.0 | 1000.0 | 0.0        | 750.0 | 10.0        |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20250101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       | false    |
      | 20250101  | Down Payment     | 250.0  | 250.0     | 0.0      | 0.0  | 0.0       | 750.0        | false    |
      | 20250320    | Repayment        | 750.0  | 750.0     | 0.0      | 0.0  | 0.0       | 0.0          | false    |
      | 20250215 | Re-age           | 750.0  | 750.0     | 0.0      | 0.0  | 0.0       | 0.0          | false    |
    Then Loan Charges tab has the following data:
      | Name    | isPenalty | Payment due at       | Due as of     | Calculation type | Due  | Paid | Waived | Outstanding |
      | NSF fee | true      | Specified due date   | 20250320 | Flat             | 10.0 | 0.0  | 0.0    | 10.0        |

    When Loan Pay-off is made on "20250320"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C4047 @AdvancedPaymentAllocation
  Scenario: Verify that Loan re-aging transaction with backdated repayment and chargeback - N+1 installment after maturity date prior to re-aging - UC4
    When Admin sets the business date to "20250101"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                        | submitted on date | with Principal | ANNUAL interest rate % | interest type | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_DOWNPAYMENT_ADV_PMT_ALLOC_PROGRESSIVE_LOAN_SCHEDULE_HORIZONTAL | 20250101   | 1000           | 0                      | FLAT          | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 3                 | MONTHS                 | 1             | MONTHS                 | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
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
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 1000.0        | 0.0      | 0.0  | 0.0       | 1000.0 | 0.0   | 0.0        | 0.0  | 1000.0      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type  | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20250101  | Disbursement      | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       | false    |
# --- add charge a month later --- #
    When Admin sets the business date to "20250503"
    And Customer makes "AUTOPAY" repayment on "20250301" with 250 EUR transaction amount
    When Admin makes "REPAYMENT_ADJUSTMENT_CHARGEBACK" chargeback with 125 EUR transaction amount
    Then Loan Repayment schedule has 5 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date     | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20250101  |               | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 0    | 20250101  | 20250301 | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0| 0.0        | 250.0|   0.0       |
      | 2  | 31   | 20250201 |               | 500.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0  | 0.0        | 0.0  | 250.0       |
      | 3  | 28   | 20250301    |               | 250.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0  | 0.0        | 0.0  | 250.0       |
      | 4  | 31   | 20250401    |               | 0.0             | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0  | 0.0        | 0.0  | 250.0       |
      | 5  | 32   | 20250503      |               | 0.0             | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 0.0  | 0.0        | 0.0  | 125.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 1125.0        | 0.0      | 0.0  | 0.0       | 1125.0 | 250.0 | 0.0        | 250.0| 875.0      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type  | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20250101  | Disbursement      | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       | false    |
      | 20250301    | Repayment         | 250.0  | 250.0     | 0.0      | 0.0  | 0.0       | 750.0        | false    |
      | 20250503      | Chargeback        | 125.0  | 125.0     | 0.0      | 0.0  | 0.0       | 875.0        | false    |
# --- add re-aging trn with start date as maturity date --- #
    When Admin creates a Loan re-aging transaction by Loan external ID with the following data:
      | frequencyNumber | frequencyType | startDate     | numberOfInstallments |
      | 1               | WEEKS        | 20250401  | 1                    |
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date     | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late  | Outstanding |
      |    |      | 20250101  |               | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |       |             |
      | 1  | 0    | 20250101  | 20250301 | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 250.0 | 0.0         |
      | 2  | 31   | 20250201 | 20250401 | 750.0           | 0.0           | 0.0      | 0.0  | 0.0       | 0.0   | 0.0   | 0.0        | 0.0   | 0.0         |
      | 3  | 28   | 20250301    | 20250401 | 750.0           | 0.0           | 0.0      | 0.0  | 0.0       | 0.0   | 0.0   | 0.0        | 0.0   | 0.0         |
      | 4  | 31   | 20250401    | 20250401 | 750.0           | 0.0           | 0.0      | 0.0  | 0.0       | 0.0   | 0.0   | 0.0        | 0.0   | 0.0         |
      | 5  | 0    | 20250401    |               | 0.0             | 750.0         | 0.0      | 0.0  | 0.0       | 750.0 | 0.0   | 0.0        | 0.0   | 750.0       |
      | 6  | 32   | 20250503      |               | 0.0             | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 0.0   | 0.0        | 0.0   | 125.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 1125.0        | 0.0      | 0.0  | 0.0       | 1125.0 | 250.0 | 0.0        | 250.0| 875.0      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type  | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20250101  | Disbursement      | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       | false    |
      | 20250301    | Repayment         | 250.0  | 250.0     | 0.0      | 0.0  | 0.0       |  750.0       | false    |
      | 20250503      | Chargeback        | 125.0  | 125.0     | 0.0      | 0.0  | 0.0       |  875.0       | false    |
      | 20250401    | Re-age            | 750.0  | 750.0     | 0.0      | 0.0  | 0.0       |    0.0       | false    |

    When Loan Pay-off is made on "20250503"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C4048 @AdvancedPaymentAllocation
  Scenario: Verify that Loan re-aging transaction with repayment, chargeback and charge - N+1 installment after maturity date prior to re-aging - UC5
    When Admin sets the business date to "20250101"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                        | submitted on date | with Principal | ANNUAL interest rate % | interest type | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_DOWNPAYMENT_ADV_PMT_ALLOC_PROGRESSIVE_LOAN_SCHEDULE_HORIZONTAL | 20250101   | 1000           | 0                      | FLAT          | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 3                 | MONTHS                 | 1             | MONTHS                 | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
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
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 1000.0        | 0.0      | 0.0  | 0.0       | 1000.0 | 0.0   | 0.0        | 0.0  | 1000.0      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type  | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20250101  | Disbursement      | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       | false    |
# --- add charge a month later --- #
    When Admin sets the business date to "20250503"
    And Customer makes "AUTOPAY" repayment on "20250301" with 250 EUR transaction amount
    When Admin makes "REPAYMENT_ADJUSTMENT_CHARGEBACK" chargeback with 125 EUR transaction amount
    And Admin adds "LOAN_NSF_FEE" due date charge with "20250503" due date and 10 EUR transaction amount
    Then Loan Repayment schedule has 5 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date     | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20250101  |               | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 0    | 20250101  | 20250301 | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0| 0.0        | 250.0|   0.0       |
      | 2  | 31   | 20250201 |               | 500.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0  | 0.0        | 0.0  | 250.0       |
      | 3  | 28   | 20250301    |               | 250.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0  | 0.0        | 0.0  | 250.0       |
      | 4  | 31   | 20250401    |               | 0.0             | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0  | 0.0        | 0.0  | 250.0       |
      | 5  | 32   | 20250503      |               | 0.0             | 125.0         | 0.0      | 0.0  | 10.0      | 135.0 | 0.0  | 0.0        | 0.0  | 135.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 1125.0        | 0.0      | 0.0  | 10.0      | 1135.0 | 250.0 | 0.0        | 250.0| 885.0      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type  | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20250101  | Disbursement      | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       | false    |
      | 20250301    | Repayment         | 250.0  | 250.0     | 0.0      | 0.0  | 0.0       | 750.0        | false    |
      | 20250503      | Chargeback        | 125.0  | 125.0     | 0.0      | 0.0  | 0.0       | 875.0        | false    |
    Then Loan Charges tab has the following data:
      | Name    | isPenalty | Payment due at       | Due as of   | Calculation type | Due  | Paid | Waived | Outstanding |
      | NSF fee | true      | Specified due date   | 20250503 | Flat             | 10.0 | 0.0  | 0.0    | 10.0        |
# --- add re-aging trn with start date as maturity date --- #
    When Admin creates a Loan re-aging transaction by Loan external ID with the following data:
      | frequencyNumber | frequencyType | startDate     | numberOfInstallments |
      | 1               | WEEKS        | 20250401  | 1                    |
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date     | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late  | Outstanding |
      |    |      | 20250101  |               | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |       |             |
      | 1  | 0    | 20250101  | 20250301 | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 250.0 | 0.0         |
      | 2  | 31   | 20250201 | 20250401 | 750.0           | 0.0           | 0.0      | 0.0  | 0.0       | 0.0   | 0.0   | 0.0        | 0.0   | 0.0         |
      | 3  | 28   | 20250301    | 20250401 | 750.0           | 0.0           | 0.0      | 0.0  | 0.0       | 0.0   | 0.0   | 0.0        | 0.0   | 0.0         |
      | 4  | 31   | 20250401    | 20250401 | 750.0           | 0.0           | 0.0      | 0.0  | 0.0       | 0.0   | 0.0   | 0.0        | 0.0   | 0.0         |
      | 5  | 0    | 20250401    |               | 0.0             | 750.0         | 0.0      | 0.0  | 0.0       | 750.0 | 0.0   | 0.0        | 0.0   | 750.0       |
      | 6  | 32   | 20250503      |               | 0.0             | 125.0         | 0.0      | 0.0  | 10.0      | 135.0 | 0.0   | 0.0        | 0.0   | 135.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late  | Outstanding |
      | 1125.0        | 0.0      | 0.0  | 10.0      | 1135.0 | 250.0 | 0.0        | 250.0 | 885.0       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20250101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       | false    |
      | 20250301    | Repayment        | 250.0  | 250.0     | 0.0      | 0.0  | 0.0       | 750.0        | false    |
      | 20250503      | Chargeback       | 125.0  | 125.0     | 0.0      | 0.0  | 0.0       | 875.0        | false    |
      | 20250401    | Re-age           | 750.0  | 750.0     | 0.0      | 0.0  | 0.0       | 0.0          | false    |
    Then Loan Charges tab has the following data:
      | Name    | isPenalty | Payment due at     | Due as of   | Calculation type | Due  | Paid | Waived | Outstanding |
      | NSF fee | true      | Specified due date | 20250503 | Flat             | 10.0 | 0.0  | 0.0    | 10.0        |

    When Loan Pay-off is made on "20250503"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C4049 @AdvancedPaymentAllocation
  Scenario: Verify that Loan re-aging transaction with repayment, charge and charge adjustment - N+1 installment after maturity date prior to re-aging - UC6
    When Admin sets the business date to "20250101"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                        | submitted on date | with Principal | ANNUAL interest rate % | interest type | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_DOWNPAYMENT_ADV_PMT_ALLOC_PROGRESSIVE_LOAN_SCHEDULE_HORIZONTAL | 20250101   | 1000           | 0                      | FLAT          | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 3                 | MONTHS                 | 1             | MONTHS                 | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
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
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 1000.0        | 0.0      | 0.0  | 0.0       | 1000.0 | 0.0   | 0.0        | 0.0  | 1000.0      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type  | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20250101  | Disbursement      | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       | false    |
# --- add charge a month later --- #
    When Admin sets the business date to "20250503"
    And Customer makes "AUTOPAY" repayment on "20250301" with 250 EUR transaction amount
    And Admin adds "LOAN_NSF_FEE" due date charge with "20250503" due date and 20 EUR transaction amount
    When Admin sets the business date to "20250504"
    When Admin makes a charge adjustment for the last "LOAN_NSF_FEE" type charge which is due on "20250503" with 20 EUR transaction amount and externalId ""
    Then Loan Repayment schedule has 5 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date     | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20250101  |               | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 0    | 20250101  | 20250301 | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0| 0.0        | 250.0|   0.0       |
      | 2  | 31   | 20250201 |               | 500.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 20.0 | 0.0        | 20.0 | 230.0       |
      | 3  | 28   | 20250301    |               | 250.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0  | 0.0        | 0.0  | 250.0       |
      | 4  | 31   | 20250401    |               | 0.0             | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0  | 0.0        | 0.0  | 250.0       |
      | 5  | 32   | 20250503      |               | 0.0             |   0.0         | 0.0      | 0.0  | 20.0      |  20.0 | 0.0  | 0.0        | 0.0  |  20.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 1000.0        | 0.0      | 0.0  | 20.0      | 1020.0 | 270.0 | 0.0        | 270.0| 750.0       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type  | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20250101  | Disbursement      | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       | false    |
      | 20250301    | Repayment         | 250.0  | 250.0     | 0.0      | 0.0  | 0.0       | 750.0        | false    |
      | 20250504      | Charge Adjustment |  20.0  |  20.0     | 0.0      | 0.0  | 0.0       | 730.0        | false    |
    Then Loan Charges tab has the following data:
      | Name    | isPenalty | Payment due at       | Due as of   | Calculation type | Due  | Paid | Waived | Outstanding |
      | NSF fee | true      | Specified due date   | 20250503 | Flat             | 20.0 | 0.0  | 0.0    | 20.0        |
# --- add re-aging trn with start date as maturity date --- #
    When Admin creates a Loan re-aging transaction by Loan external ID with the following data:
      | frequencyNumber | frequencyType | startDate     | numberOfInstallments |
      | 1               | WEEKS         | 20250401 | 1                    |
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date     | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late  | Outstanding |
      |    |      | 20250101  |               | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |       |             |
      | 1  | 0    | 20250101  | 20250301 | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 250.0 | 0.0         |
      | 2  | 31   | 20250201 | 20250401 | 750.0           | 0.0           | 0.0      | 0.0  | 0.0       | 0.0   | 0.0   | 0.0        | 0.0   | 0.0         |
      | 3  | 28   | 20250301    | 20250401 | 750.0           | 0.0           | 0.0      | 0.0  | 0.0       | 0.0   | 0.0   | 0.0        | 0.0   | 0.0         |
      | 4  | 31   | 20250401    | 20250401 | 750.0           | 0.0           | 0.0      | 0.0  | 0.0       | 0.0   | 0.0   | 0.0        | 0.0   | 0.0         |
      | 5  | 0    | 20250401    |               | 0.0             | 750.0         | 0.0      | 0.0  | 0.0       | 750.0 | 20.0  | 0.0        | 20.0  | 730.0       |
      | 6  | 32   | 20250503      |               | 0.0             | 0.0           | 0.0      | 0.0  | 20.0      | 20.0  | 0.0   | 0.0        | 0.0   | 20.0        |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late  | Outstanding |
      | 1000.0        | 0.0      | 0.0  | 20.0      | 1020.0 | 270.0 | 0.0        | 270.0 | 750.0       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type  | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20250101  | Disbursement      | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       | false    |
      | 20250301    | Repayment         | 250.0  | 250.0     | 0.0      | 0.0  | 0.0       | 750.0        | false    |
      | 20250504      | Charge Adjustment | 20.0   | 20.0      | 0.0      | 0.0  | 0.0       | 730.0        | false    |
      | 20250401    | Re-age            | 750.0  | 750.0     | 0.0      | 0.0  | 0.0       | 0.0          | false    |
    Then Loan Charges tab has the following data:
      | Name    | isPenalty | Payment due at     | Due as of   | Calculation type | Due  | Paid | Waived | Outstanding |
      | NSF fee | true      | Specified due date | 20250503 | Flat             | 20.0 | 0.0  | 0.0    | 20.0        |
    When Loan Pay-off is made on "20250503"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C4050 @AdvancedPaymentAllocation
  Scenario: Verify that Loan re-aging transaction with MIR and charge - N+1 installment after maturity date prior to re-aging - UC7
    When Admin sets the business date to "20250101"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                        | submitted on date | with Principal | ANNUAL interest rate % | interest type | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_DOWNPAYMENT_ADV_PMT_ALLOC_PROGRESSIVE_LOAN_SCHEDULE_HORIZONTAL | 20250101   | 1000           | 0                      | FLAT          | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 3                 | MONTHS                 | 1             | MONTHS                 | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
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
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 1000.0        | 0.0      | 0.0  | 0.0       | 1000.0 | 0.0   | 0.0        | 0.0  | 1000.0      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type  | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20250101  | Disbursement      | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       | false    |
# --- add charge a month later --- #
    When Admin sets the business date to "20250503"
    When Admin makes "MERCHANT_ISSUED_REFUND" transaction with "AUTOPAY" payment type on "20250401" with 100 EUR transaction amount
    And Admin adds "LOAN_NSF_FEE" due date charge with "20250503" due date and 20 EUR transaction amount
    Then Loan Repayment schedule has 5 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date     | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20250101  |               | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 0    | 20250101  |               | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 100.0| 0.0        | 100.0| 150.0       |
      | 2  | 31   | 20250201 |               | 500.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0  | 0.0        | 0.0  | 250.0       |
      | 3  | 28   | 20250301    |               | 250.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0  | 0.0        | 0.0  | 250.0       |
      | 4  | 31   | 20250401    |               | 0.0             | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0  | 0.0        | 0.0  | 250.0       |
      | 5  | 32   | 20250503      |               | 0.0             |   0.0         | 0.0      | 0.0  | 20.0      |  20.0 | 0.0  | 0.0        | 0.0  |  20.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late  | Outstanding |
      | 1000.0        | 0.0      | 0.0  | 20.0      | 1020.0 | 100.0 | 0.0        | 100.0 | 920.0       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type       | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20250101  | Disbursement           | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       | false    |
      | 20250401    | Merchant Issued Refund | 100.0  | 100.0     | 0.0      | 0.0  | 0.0       | 900.0        | false    |
    Then Loan Charges tab has the following data:
      | Name    | isPenalty | Payment due at       | Due as of   | Calculation type | Due  | Paid | Waived | Outstanding |
      | NSF fee | true      | Specified due date   | 20250503 | Flat             | 20.0 | 0.0  | 0.0    | 20.0        |
# --- add re-aging trn with start date as maturity date --- #
    When Admin creates a Loan re-aging transaction by Loan external ID with the following data:
      | frequencyNumber | frequencyType | startDate     | numberOfInstallments |
      | 1               | WEEKS         | 20250401 | 1                    |
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date     | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late  | Outstanding |
      |    |      | 20250101  |               | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |       |             |
      | 1  | 0    | 20250101  | 20250401 | 900.0           | 100.0         | 0.0      | 0.0  | 0.0       | 100.0 | 100.0 | 0.0        | 100.0 | 0.0         |
      | 2  | 31   | 20250201 | 20250401 | 900.0           | 0.0           | 0.0      | 0.0  | 0.0       | 0.0   | 0.0   | 0.0        | 0.0   | 0.0         |
      | 3  | 28   | 20250301    | 20250401 | 900.0           | 0.0           | 0.0      | 0.0  | 0.0       | 0.0   | 0.0   | 0.0        | 0.0   | 0.0         |
      | 4  | 31   | 20250401    | 20250401 | 900.0           | 0.0           | 0.0      | 0.0  | 0.0       | 0.0   | 0.0   | 0.0        | 0.0   | 0.0         |
      | 5  | 0    | 20250401    |               | 0.0             | 900.0         | 0.0      | 0.0  | 0.0       | 900.0 | 0.0   | 0.0        | 0.0   | 900.0       |
      | 6  | 32   | 20250503      |               | 0.0             | 0.0           | 0.0      | 0.0  | 20.0      | 20.0  | 0.0   | 0.0        | 0.0   | 20.0        |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late  | Outstanding |
      | 1000.0        | 0.0      | 0.0  | 20.0      | 1020.0 | 100.0 | 0.0        | 100.0 | 920.0       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type       | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20250101  | Disbursement           | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       | false    |
      | 20250401    | Merchant Issued Refund | 100.0  | 100.0     | 0.0      | 0.0  | 0.0       | 900.0        | false    |
      | 20250401    | Re-age                 | 900.0  | 900.0     | 0.0      | 0.0  | 0.0       | 0.0          | false    |
    Then Loan Charges tab has the following data:
      | Name    | isPenalty | Payment due at     | Due as of   | Calculation type | Due  | Paid | Waived | Outstanding |
      | NSF fee | true      | Specified due date | 20250503 | Flat             | 20.0 | 0.0  | 0.0    | 20.0        |
    When Loan Pay-off is made on "20250503"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C4051 @AdvancedPaymentAllocation
  Scenario: Verify that Loan re-aging transaction with 2nd disbursement and charge - N+1 installment after maturity date prior to re-aging - UC8
    When Admin sets the business date to "20250101"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                        | submitted on date | with Principal  | ANNUAL interest rate % | interest type | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_DOWNPAYMENT_ADV_PMT_ALLOC_PROGRESSIVE_LOAN_SCHEDULE_HORIZONTAL | 20250101   | 1000             | 0                      | FLAT          | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS  | 3                 | MONTHS                | 1              | MONTHS                 | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20250101" with "500" amount and expected disbursement date on "20250101"
    When Admin disburses the loan on "20250101" with "500" EUR transaction amount
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20250101  |                  | 500.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 0    | 20250101  |                  | 375.0           | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 0.0   | 0.0        | 0.0  | 125.0       |
      | 2  | 31   | 20250201 |                  | 250.0           | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 0.0   | 0.0        | 0.0  | 125.0       |
      | 3  | 28   | 20250301    |                  | 125.0           | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 0.0   | 0.0        | 0.0  | 125.0       |
      | 4  | 31   | 20250401    |                  | 0.0             | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 0.0   | 0.0        | 0.0  | 125.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 500.0         | 0.0      | 0.0  | 0.0       | 500.0  | 0.0   | 0.0        | 0.0  | 500.0       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type  | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20250101  | Disbursement      | 500.0  | 0.0       | 0.0      | 0.0  | 0.0       | 500.0        | false    |
#    --- backdated disbursement --- #
    When Admin sets the business date to "20250501"
    When Admin disburses the loan on "20250116" with "100" EUR transaction amount
# --- add charge a month later after maturity date --- #
    And Admin adds "LOAN_NSF_FEE" due date charge with "20250501" due date and 20 EUR transaction amount
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20250101  |                  | 500.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 0    | 20250101  |                  | 375.0           | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 0.0   | 0.0        | 0.0  | 125.0       |
      |    |      | 20250116  |                  | 100.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 2  | 0    | 20250116  |                  | 450.0           |  25.0         | 0.0      | 0.0  | 0.0       |  25.0 | 0.0   | 0.0        | 0.0  |  25.0       |
      | 3  | 31   | 20250201 |                  | 300.0           | 150.0         | 0.0      | 0.0  | 0.0       | 150.0 | 0.0   | 0.0        | 0.0  | 150.0       |
      | 4  | 28   | 20250301    |                  | 150.0           | 150.0         | 0.0      | 0.0  | 0.0       | 150.0 | 0.0   | 0.0        | 0.0  | 150.0       |
      | 5  | 31   | 20250401    |                  | 0.0             | 150.0         | 0.0      | 0.0  | 0.0       | 150.0 | 0.0   | 0.0        | 0.0  | 150.0       |
      | 6  | 30   | 20250501      |                  | 0.0             |   0.0         | 0.0      | 0.0  | 20.0      |  20.0 | 0.0   | 0.0        | 0.0  |  20.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 600.0         | 0.0      | 0.0  | 20.0      | 620.0  | 0.0   | 0.0        | 0.0  | 620.0      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type  | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20250101  | Disbursement      | 500.0  | 0.0       | 0.0      | 0.0  | 0.0       | 500.0        | false    |
      | 20250116  | Disbursement      | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 600.0        | false    |
    Then Loan Charges tab has the following data:
      | Name    | isPenalty | Payment due at       | Due as of   | Calculation type | Due  | Paid | Waived | Outstanding |
      | NSF fee | true      | Specified due date   | 20250501 | Flat             | 20.0 | 0.0  | 0.0    | 20.0        |
    Then LoanDisbursalTransactionBusinessEvent has changedTerms "false"
# --- add re-aging trn with start date as maturity date --- #
    When Admin creates a Loan re-aging transaction by Loan external ID with the following data:
      | frequencyNumber | frequencyType | startDate      | numberOfInstallments |
      | 1               | WEEKS         | 20250401  | 1                    |
    Then Loan Repayment schedule has 7 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date     | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20250101  |               | 500.0           |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 0    | 20250101  | 20250401 | 500.0           | 0.0           | 0.0      | 0.0  | 0.0       | 0.0   | 0.0  | 0.0        | 0.0  | 0.0         |
      |    |      | 20250116  |               | 100.0           |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 2  | 0    | 20250116  | 20250401 | 600.0           | 0.0           | 0.0      | 0.0  | 0.0       | 0.0   | 0.0  | 0.0        | 0.0  | 0.0         |
      | 3  | 16   | 20250201 | 20250401 | 600.0           | 0.0           | 0.0      | 0.0  | 0.0       | 0.0   | 0.0  | 0.0        | 0.0  | 0.0         |
      | 4  | 28   | 20250301    | 20250401 | 600.0           | 0.0           | 0.0      | 0.0  | 0.0       | 0.0   | 0.0  | 0.0        | 0.0  | 0.0         |
      | 5  | 31   | 20250401    | 20250401 | 600.0           | 0.0           | 0.0      | 0.0  | 0.0       | 0.0   | 0.0  | 0.0        | 0.0  | 0.0         |
      | 6  | 0    | 20250401    |               | 0.0             | 600.0         | 0.0      | 0.0  | 0.0       | 600.0 | 0.0  | 0.0        | 0.0  | 600.0       |
      | 7  | 30   | 20250501      |               | 0.0             | 0.0           | 0.0      | 0.0  | 20.0      | 20.0  | 0.0  | 0.0        | 0.0  | 20.0        |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 600.0         | 0.0      | 0.0  | 20.0      | 620.0  | 0.0   | 0.0        | 0.0  | 620.0      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type  | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20250101  | Disbursement      | 500.0  | 0.0       | 0.0      | 0.0  | 0.0       | 500.0        | false    |
      | 20250116  | Disbursement      | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 600.0        | false    |
      | 20250401    | Re-age            | 600.0  | 600.0     | 0.0      | 0.0  | 0.0       |   0.0        | false    |
    Then Loan Charges tab has the following data:
      | Name    | isPenalty | Payment due at       | Due as of   | Calculation type | Due  | Paid | Waived | Outstanding |
      | NSF fee | true      | Specified due date   | 20250501 | Flat             | 20.0 | 0.0  | 0.0    | 20.0        |
    Then LoanReAgeTransactionBusinessEvent has changedTerms "true"
    When Loan Pay-off is made on "20250501"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C4066 @AdvancedPaymentAllocation
  Scenario: Verify merging re-aging transaction with N+1 installment in the same bucket(YEARS)
    When Admin sets the business date to "20240101"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                      | submitted on date | with Principal | ANNUAL interest rate % | interest type | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_DOWNPAYMENT_AUTO_ADVANCED_PAYMENT_ALLOCATION | 20240101   | 100            | 0                      | FLAT          | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 3                 | MONTHS                | 1              | MONTHS                 | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240101" with "100" amount and expected disbursement date on "20240101"
    When Admin successfully disburse the loan on "20240101" with "100" EUR transaction amount
    When Admin sets the business date to "20240405"
    And Admin adds "LOAN_SNOOZE_FEE" due date charge with "20240503" due date and 100 EUR transaction amount
    When Admin creates a Loan re-aging transaction with the following data:
      | frequencyNumber | frequencyType | startDate     | numberOfInstallments |
      | 1               | YEARS         | 20240401 | 3                    |
    Then Loan Repayment schedule has 7 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees  | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20240101  |                 | 100.0           |               |          | 0.0   |           | 0.0   | 0.0  |            |      |             |
      | 1  | 0    | 20240101  | 20240101 | 75.0            | 25.0          | 0.0      | 0.0   | 0.0       | 25.0  | 25.0 | 0.0        | 0.0  | 0.0         |
      | 2  | 31   | 20240201 | 20240401   | 75.0            | 0.0           | 0.0      | 0.0   | 0.0       | 0.0   | 0.0  | 0.0        | 0.0  | 0.0         |
      | 3  | 29   | 20240301    | 20240401   | 75.0            | 0.0           | 0.0      | 0.0   | 0.0       | 0.0   | 0.0  | 0.0        | 0.0  | 0.0         |
      | 4  | 31   | 20240401    | 20240401   | 75.0            | 0.0           | 0.0      | 0.0   | 0.0       | 0.0   | 0.0  | 0.0        | 0.0  | 0.0         |
      | 5  | 0    | 20240401    |                 | 50.0            | 25.0          | 0.0      | 0.0   | 0.0       | 25.0  | 0.0  | 0.0        | 0.0  | 25.0        |
      | 6  | 365  | 20250401    |                 | 25.0            | 25.0          | 0.0      | 100.0 | 0.0       | 125.0 | 0.0  | 0.0        | 0.0  | 125.0       |
      | 7  | 365  | 20260401    |                 | 0.0             | 25.0          | 0.0      | 0.0   | 0.0       | 25.0  | 0.0  | 0.0        | 0.0  | 25.0        |
    When Loan Pay-off is made on "20240405"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C4067 @AdvancedPaymentAllocation
  Scenario: Verify merging re-aging transaction with N+1 installment in the same bucket(MONTHS)
    When Admin sets the business date to "20240101"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                      | submitted on date | with Principal | ANNUAL interest rate % | interest type | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_DOWNPAYMENT_AUTO_ADVANCED_PAYMENT_ALLOCATION | 20240101   | 100            | 0                      | FLAT          | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 3                 | MONTHS                | 1              | MONTHS                 | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240101" with "100" amount and expected disbursement date on "20240101"
    When Admin successfully disburse the loan on "20240101" with "100" EUR transaction amount
    When Admin sets the business date to "20240405"
    And Admin adds "LOAN_SNOOZE_FEE" due date charge with "20240503" due date and 100 EUR transaction amount
    When Admin creates a Loan re-aging transaction with the following data:
      | frequencyNumber | frequencyType | startDate     | numberOfInstallments |
      | 1               | MONTHS        | 20240401 | 3                    |
    Then Loan Repayment schedule has 7 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees  | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20240101  |                 | 100.0           |               |          | 0.0   |           | 0.0   | 0.0  |            |      |             |
      | 1  | 0    | 20240101  | 20240101 | 75.0            | 25.0          | 0.0      | 0.0   | 0.0       | 25.0  | 25.0 | 0.0        | 0.0  | 0.0         |
      | 2  | 31   | 20240201 | 20240401   | 75.0            | 0.0           | 0.0      | 0.0   | 0.0       | 0.0   | 0.0  | 0.0        | 0.0  | 0.0         |
      | 3  | 29   | 20240301    | 20240401   | 75.0            | 0.0           | 0.0      | 0.0   | 0.0       | 0.0   | 0.0  | 0.0        | 0.0  | 0.0         |
      | 4  | 31   | 20240401    | 20240401   | 75.0            | 0.0           | 0.0      | 0.0   | 0.0       | 0.0   | 0.0  | 0.0        | 0.0  | 0.0         |
      | 5  | 0    | 20240401    |                 | 50.0            | 25.0          | 0.0      | 0.0   | 0.0       | 25.0  | 0.0  | 0.0        | 0.0  | 25.0        |
      | 6  | 30   | 20240501      |                 | 25.0            | 25.0          | 0.0      | 0.0   | 0.0       | 25.0  | 0.0  | 0.0        | 0.0  | 25.0        |
      | 7  | 31   | 20240601     |                 | 0.0             | 25.0          | 0.0      | 100.0 | 0.0       | 125.0 | 0.0  | 0.0        | 0.0  | 125.0       |
    When Loan Pay-off is made on "20240405"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C4068 @AdvancedPaymentAllocation
  Scenario: Verify merging re-aging transaction with N+1 installment in the same bucket(WEEKS)
    When Admin sets the business date to "20240101"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                      | submitted on date | with Principal | ANNUAL interest rate % | interest type | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_DOWNPAYMENT_AUTO_ADVANCED_PAYMENT_ALLOCATION | 20240101   | 100            | 0                      | FLAT          | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 3                 | MONTHS                | 1              | MONTHS                 | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240101" with "100" amount and expected disbursement date on "20240101"
    When Admin successfully disburse the loan on "20240101" with "100" EUR transaction amount
    When Admin sets the business date to "20240405"
    And Admin adds "LOAN_SNOOZE_FEE" due date charge with "20240409" due date and 100 EUR transaction amount
    When Admin creates a Loan re-aging transaction with the following data:
      | frequencyNumber | frequencyType | startDate     | numberOfInstallments |
      | 1               | WEEKS         | 20240401 | 3                    |
    Then Loan Repayment schedule has 7 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees  | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20240101  |                 | 100.0           |               |          | 0.0   |           | 0.0   | 0.0  |            |      |             |
      | 1  | 0    | 20240101  | 20240101 | 75.0            | 25.0          | 0.0      | 0.0   | 0.0       | 25.0  | 25.0 | 0.0        | 0.0  | 0.0         |
      | 2  | 31   | 20240201 | 20240401   | 75.0            | 0.0           | 0.0      | 0.0   | 0.0       | 0.0   | 0.0  | 0.0        | 0.0  | 0.0         |
      | 3  | 29   | 20240301    | 20240401   | 75.0            | 0.0           | 0.0      | 0.0   | 0.0       | 0.0   | 0.0  | 0.0        | 0.0  | 0.0         |
      | 4  | 31   | 20240401    | 20240401   | 75.0            | 0.0           | 0.0      | 0.0   | 0.0       | 0.0   | 0.0  | 0.0        | 0.0  | 0.0         |
      | 5  | 0    | 20240401    |                 | 50.0            | 25.0          | 0.0      | 0.0   | 0.0       | 25.0  | 0.0  | 0.0        | 0.0  | 25.0        |
      | 6  | 7    | 20240408    |                 | 25.0            | 25.0          | 0.0      | 0.0   | 0.0       | 25.0  | 0.0  | 0.0        | 0.0  | 25.0        |
      | 7  | 7    | 20240415    |                 | 0.0             | 25.0          | 0.0      | 100.0 | 0.0       | 125.0 | 0.0  | 0.0        | 0.0  | 125.0       |
    When Loan Pay-off is made on "20240405"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C4069 @AdvancedPaymentAllocation
  Scenario: Verify merging re-aging transaction with N+1 installment in the same bucket(DAYS)
    When Admin sets the business date to "20240101"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                      | submitted on date | with Principal | ANNUAL interest rate % | interest type | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_DOWNPAYMENT_AUTO_ADVANCED_PAYMENT_ALLOCATION | 20240101   | 100            | 0                      | FLAT          | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 3                 | MONTHS                | 1              | MONTHS                 | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240101" with "100" amount and expected disbursement date on "20240101"
    When Admin successfully disburse the loan on "20240101" with "100" EUR transaction amount
    When Admin sets the business date to "20240405"
    And Admin adds "LOAN_SNOOZE_FEE" due date charge with "20240403" due date and 100 EUR transaction amount
    When Admin creates a Loan re-aging transaction with the following data:
      | frequencyNumber | frequencyType | startDate     | numberOfInstallments |
      | 1               | DAYS          | 20240401 | 3                    |
    Then Loan Repayment schedule has 7 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees  | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20240101  |                 | 100.0           |               |          | 0.0   |           | 0.0   | 0.0  |            |      |             |
      | 1  | 0    | 20240101  | 20240101 | 75.0            | 25.0          | 0.0      | 0.0   | 0.0       | 25.0  | 25.0 | 0.0        | 0.0  | 0.0         |
      | 2  | 31   | 20240201 | 20240401   | 75.0            | 0.0           | 0.0      | 0.0   | 0.0       | 0.0   | 0.0  | 0.0        | 0.0  | 0.0         |
      | 3  | 29   | 20240301    | 20240401   | 75.0            | 0.0           | 0.0      | 0.0   | 0.0       | 0.0   | 0.0  | 0.0        | 0.0  | 0.0         |
      | 4  | 31   | 20240401    | 20240401   | 75.0            | 0.0           | 0.0      | 0.0   | 0.0       | 0.0   | 0.0  | 0.0        | 0.0  | 0.0         |
      | 5  | 0    | 20240401    |                 | 50.0            | 25.0          | 0.0      | 0.0   | 0.0       | 25.0  | 0.0  | 0.0        | 0.0  | 25.0        |
      | 6  | 1    | 20240402    |                 | 25.0            | 25.0          | 0.0      | 0.0   | 0.0       | 25.0  | 0.0  | 0.0        | 0.0  | 25.0        |
      | 7  | 1    | 20240403    |                 | 0.0             | 25.0          | 0.0      | 100.0 | 0.0       | 125.0 | 0.0  | 0.0        | 0.0  | 125.0       |
    When Loan Pay-off is made on "20240405"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C4070 @AdvancedPaymentAllocation
  Scenario: Verify re-aging transaction with N+1 installment outside bucket
    When Admin sets the business date to "20240101"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                      | submitted on date | with Principal | ANNUAL interest rate % | interest type | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_DOWNPAYMENT_AUTO_ADVANCED_PAYMENT_ALLOCATION | 20240101   | 100            | 0                      | FLAT          | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 3                 | MONTHS                | 1              | MONTHS                 | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240101" with "100" amount and expected disbursement date on "20240101"
    When Admin successfully disburse the loan on "20240101" with "100" EUR transaction amount
    When Admin sets the business date to "20240405"
    And Admin adds "LOAN_SNOOZE_FEE" due date charge with "20240703" due date and 100 EUR transaction amount
    When Admin creates a Loan re-aging transaction with the following data:
      | frequencyNumber | frequencyType | startDate     | numberOfInstallments |
      | 1               | MONTHS        | 20240401 | 3                    |
    Then Loan Repayment schedule has 8 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees  | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20240101  |                 | 100.0           |               |          | 0.0   |           | 0.0   | 0.0  |            |      |             |
      | 1  | 0    | 20240101  | 20240101 | 75.0            | 25.0          | 0.0      | 0.0   | 0.0       | 25.0  | 25.0 | 0.0        | 0.0  | 0.0         |
      | 2  | 31   | 20240201 | 20240401   | 75.0            | 0.0           | 0.0      | 0.0   | 0.0       | 0.0   | 0.0  | 0.0        | 0.0  | 0.0         |
      | 3  | 29   | 20240301    | 20240401   | 75.0            | 0.0           | 0.0      | 0.0   | 0.0       | 0.0   | 0.0  | 0.0        | 0.0  | 0.0         |
      | 4  | 31   | 20240401    | 20240401   | 75.0            | 0.0           | 0.0      | 0.0   | 0.0       | 0.0   | 0.0  | 0.0        | 0.0  | 0.0         |
      | 5  | 0    | 20240401    |                 | 50.0            | 25.0          | 0.0      | 0.0   | 0.0       | 25.0  | 0.0  | 0.0        | 0.0  | 25.0        |
      | 6  | 30   | 20240501      |                 | 25.0            | 25.0          | 0.0      | 0.0   | 0.0       | 25.0  | 0.0  | 0.0        | 0.0  | 25.0        |
      | 7  | 31   | 20240601     |                 | 0.0             | 25.0          | 0.0      | 0.0   | 0.0       | 25.0  | 0.0  | 0.0        | 0.0  | 25.0        |
      | 8  | 32   | 20240703     |                 | 0.0             | 0.0           | 0.0      | 100.0 | 0.0       | 100.0 | 0.0  | 0.0        | 0.0  | 100.0       |
    When Loan Pay-off is made on "20240405"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C4071 @AdvancedPaymentAllocation
  Scenario: Verify that Loan re-aging transaction with backdated repayment and chargeback - N+1 installment after maturity date overlaps with re-aging - UC1
    When Admin sets the business date to "20250101"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                        | submitted on date | with Principal | ANNUAL interest rate % | interest type | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_DOWNPAYMENT_ADV_PMT_ALLOC_PROGRESSIVE_LOAN_SCHEDULE_HORIZONTAL | 20250101   | 1000           | 0                      | FLAT          | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 3                 | MONTHS                 | 1             | MONTHS                 | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
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
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 1000.0        | 0.0      | 0.0  | 0.0       | 1000.0 | 0.0   | 0.0        | 0.0  | 1000.0      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type  | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20250101  | Disbursement      | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       | false    |
# --- add charge a month later --- #
    When Admin sets the business date to "20250503"
    And Customer makes "AUTOPAY" repayment on "20250301" with 250 EUR transaction amount
    When Admin makes "REPAYMENT_ADJUSTMENT_CHARGEBACK" chargeback with 125 EUR transaction amount
    Then Loan Repayment schedule has 5 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date     | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20250101  |               | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 0    | 20250101  | 20250301 | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0| 0.0        | 250.0|   0.0       |
      | 2  | 31   | 20250201 |               | 500.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0  | 0.0        | 0.0  | 250.0       |
      | 3  | 28   | 20250301    |               | 250.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0  | 0.0        | 0.0  | 250.0       |
      | 4  | 31   | 20250401    |               | 0.0             | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0  | 0.0        | 0.0  | 250.0       |
      | 5  | 32   | 20250503      |               | 0.0             | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 0.0  | 0.0        | 0.0  | 125.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 1125.0        | 0.0      | 0.0  | 0.0       | 1125.0 | 250.0 | 0.0        | 250.0| 875.0      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type  | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20250101  | Disbursement      | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       | false    |
      | 20250301    | Repayment         | 250.0  | 250.0     | 0.0      | 0.0  | 0.0       | 750.0        | false    |
      | 20250503      | Chargeback        | 125.0  | 125.0     | 0.0      | 0.0  | 0.0       | 875.0        | false    |
# --- add re-aging trn with start date as maturity date --- #
    When Admin creates a Loan re-aging transaction by Loan external ID with the following data:
      | frequencyNumber | frequencyType | startDate     | numberOfInstallments |
      | 1               | WEEKS         | 20250401  | 6                    |
    Then Loan Repayment schedule has 10 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date     | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late  | Outstanding |
      |    |      | 20250101  |               | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |       |             |
      | 1  | 0    | 20250101  | 20250301 | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 250.0 | 0.0         |
      | 2  | 31   | 20250201 | 20250401 | 750.0           | 0.0           | 0.0      | 0.0  | 0.0       | 0.0   | 0.0   | 0.0        | 0.0   | 0.0         |
      | 3  | 28   | 20250301    | 20250401 | 750.0           | 0.0           | 0.0      | 0.0  | 0.0       | 0.0   | 0.0   | 0.0        | 0.0   | 0.0         |
      | 4  | 31   | 20250401    | 20250401 | 750.0           | 0.0           | 0.0      | 0.0  | 0.0       | 0.0   | 0.0   | 0.0        | 0.0   | 0.0         |
      | 5  | 0    | 20250401    |               | 625.0           | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 0.0   | 0.0        | 0.0   | 125.0       |
      | 6  | 7    | 20250408    |               | 500.0           | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 0.0   | 0.0        | 0.0   | 125.0       |
      | 7  | 7    | 20250415    |               | 375.0           | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 0.0   | 0.0        | 0.0   | 125.0       |
      | 8  | 7    | 20250422    |               | 250.0           | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 0.0   | 0.0        | 0.0   | 125.0       |
      | 9  | 7    | 20250429    |               | 125.0           | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 0.0   | 0.0        | 0.0   | 125.0       |
      | 10 | 7    | 20250506      |               | 0.0             | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0   | 0.0        | 0.0   | 250.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 1125.0        | 0.0      | 0.0  | 0.0       | 1125.0 | 250.0 | 0.0        | 250.0| 875.0      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type  | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20250101  | Disbursement      | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       | false    |
      | 20250301    | Repayment         | 250.0  | 250.0     | 0.0      | 0.0  | 0.0       |  750.0       | false    |
      | 20250503      | Chargeback        | 125.0  | 125.0     | 0.0      | 0.0  | 0.0       |  875.0       | false    |
      | 20250401    | Re-age            | 750.0  | 750.0     | 0.0      | 0.0  | 0.0       |    0.0       | false    |
    When Loan Pay-off is made on "20250503"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C4072 @AdvancedPaymentAllocation
  Scenario: Verify that Loan re-aging transaction with repayment, chargeback and charge - N+1 installment after maturity date overlaps with re-aging - UC2
    When Admin sets the business date to "20250101"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                        | submitted on date | with Principal | ANNUAL interest rate % | interest type | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_DOWNPAYMENT_ADV_PMT_ALLOC_PROGRESSIVE_LOAN_SCHEDULE_HORIZONTAL | 20250101   | 1000           | 0                      | FLAT          | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 3                 | MONTHS                 | 1             | MONTHS                 | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
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
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 1000.0        | 0.0      | 0.0  | 0.0       | 1000.0 | 0.0   | 0.0        | 0.0  | 1000.0      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type  | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20250101  | Disbursement      | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       | false    |
# --- add charge a month later --- #
    When Admin sets the business date to "20250503"
    And Customer makes "AUTOPAY" repayment on "20250301" with 250 EUR transaction amount
    When Admin makes "REPAYMENT_ADJUSTMENT_CHARGEBACK" chargeback with 125 EUR transaction amount
    And Admin adds "LOAN_NSF_FEE" due date charge with "20250503" due date and 10 EUR transaction amount
    Then Loan Repayment schedule has 5 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date     | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20250101  |               | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 0    | 20250101  | 20250301 | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0| 0.0        | 250.0|   0.0       |
      | 2  | 31   | 20250201 |               | 500.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0  | 0.0        | 0.0  | 250.0       |
      | 3  | 28   | 20250301    |               | 250.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0  | 0.0        | 0.0  | 250.0       |
      | 4  | 31   | 20250401    |               | 0.0             | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0  | 0.0        | 0.0  | 250.0       |
      | 5  | 32   | 20250503      |               | 0.0             | 125.0         | 0.0      | 0.0  | 10.0      | 135.0 | 0.0  | 0.0        | 0.0  | 135.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 1125.0        | 0.0      | 0.0  | 10.0      | 1135.0 | 250.0 | 0.0        | 250.0| 885.0      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type  | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20250101  | Disbursement      | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       | false    |
      | 20250301    | Repayment         | 250.0  | 250.0     | 0.0      | 0.0  | 0.0       | 750.0        | false    |
      | 20250503      | Chargeback        | 125.0  | 125.0     | 0.0      | 0.0  | 0.0       | 875.0        | false    |
    Then Loan Charges tab has the following data:
      | Name    | isPenalty | Payment due at       | Due as of   | Calculation type | Due  | Paid | Waived | Outstanding |
      | NSF fee | true      | Specified due date   | 20250503 | Flat             | 10.0 | 0.0  | 0.0    | 10.0        |
# --- add re-aging trn with start date as maturity date --- #
    When Admin creates a Loan re-aging transaction by Loan external ID with the following data:
      | frequencyNumber | frequencyType | startDate     | numberOfInstallments |
      | 1               | MONTHS        | 20250401 | 3                    |
    Then Loan Repayment schedule has 7 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date     | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late  | Outstanding |
      |    |      | 20250101  |               | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |       |             |
      | 1  | 0    | 20250101  | 20250301 | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 250.0 | 0.0         |
      | 2  | 31   | 20250201 | 20250401 | 750.0           | 0.0           | 0.0      | 0.0  | 0.0       | 0.0   | 0.0   | 0.0        | 0.0   | 0.0         |
      | 3  | 28   | 20250301    | 20250401 | 750.0           | 0.0           | 0.0      | 0.0  | 0.0       | 0.0   | 0.0   | 0.0        | 0.0   | 0.0         |
      | 4  | 31   | 20250401    | 20250401 | 750.0           | 0.0           | 0.0      | 0.0  | 0.0       | 0.0   | 0.0   | 0.0        | 0.0   | 0.0         |
      | 5  | 0    | 20250401    |               | 500.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0   | 0.0        | 0.0   | 250.0       |
      | 6  | 30   | 20250501      |               | 250.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0   | 0.0        | 0.0   | 250.0       |
      | 7  | 31   | 20250601     |               | 0.0             | 375.0         | 0.0      | 0.0  | 10.0      | 385.0 | 0.0   | 0.0        | 0.0   | 385.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 1125.0        | 0.0      | 0.0  | 10.0      | 1135.0 | 250.0 | 0.0        | 250.0| 885.0      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type  | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20250101  | Disbursement      | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       | false    |
      | 20250301    | Repayment         | 250.0  | 250.0     | 0.0      | 0.0  | 0.0       |  750.0       | false    |
      | 20250503      | Chargeback        | 125.0  | 125.0     | 0.0      | 0.0  | 0.0       |  875.0       | false    |
      | 20250401    | Re-age            | 750.0  | 750.0     | 0.0      | 0.0  | 0.0       |    0.0       | false    |
    Then Loan Charges tab has the following data:
      | Name    | isPenalty | Payment due at       | Due as of   | Calculation type | Due  | Paid | Waived | Outstanding |
      | NSF fee | true      | Specified due date   | 20250503 | Flat             | 10.0 | 0.0  | 0.0    | 10.0        |
    When Loan Pay-off is made on "20250503"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C4073 @AdvancedPaymentAllocation
  Scenario: Verify that Loan re-aging transaction with repayment, charge and charge adjustment - N+1 installment after maturity date overlaps with re-aging - UC3
    When Admin sets the business date to "20250101"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                        | submitted on date | with Principal | ANNUAL interest rate % | interest type | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_DOWNPAYMENT_ADV_PMT_ALLOC_PROGRESSIVE_LOAN_SCHEDULE_HORIZONTAL | 20250101   | 1000           | 0                      | FLAT          | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 3                 | MONTHS                 | 1             | MONTHS                 | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
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
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 1000.0        | 0.0      | 0.0  | 0.0       | 1000.0 | 0.0   | 0.0        | 0.0  | 1000.0      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type  | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20250101  | Disbursement      | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       | false    |
# --- add charge a month later --- #
    When Admin sets the business date to "20250503"
    And Customer makes "AUTOPAY" repayment on "20250301" with 250 EUR transaction amount
    And Admin adds "LOAN_NSF_FEE" due date charge with "20250503" due date and 20 EUR transaction amount
    When Admin sets the business date to "20250504"
    When Admin makes a charge adjustment for the last "LOAN_NSF_FEE" type charge which is due on "20250503" with 20 EUR transaction amount and externalId ""
    Then Loan Repayment schedule has 5 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date     | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20250101  |               | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 0    | 20250101  | 20250301 | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0| 0.0        | 250.0|   0.0       |
      | 2  | 31   | 20250201 |               | 500.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 20.0 | 0.0        | 20.0 | 230.0       |
      | 3  | 28   | 20250301    |               | 250.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0  | 0.0        | 0.0  | 250.0       |
      | 4  | 31   | 20250401    |               | 0.0             | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0  | 0.0        | 0.0  | 250.0       |
      | 5  | 32   | 20250503      |               | 0.0             |   0.0         | 0.0      | 0.0  | 20.0      |  20.0 | 0.0  | 0.0        | 0.0  |  20.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 1000.0        | 0.0      | 0.0  | 20.0      | 1020.0 | 270.0 | 0.0        | 270.0| 750.0       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type  | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20250101  | Disbursement      | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       | false    |
      | 20250301    | Repayment         | 250.0  | 250.0     | 0.0      | 0.0  | 0.0       | 750.0        | false    |
      | 20250504      | Charge Adjustment |  20.0  |  20.0     | 0.0      | 0.0  | 0.0       | 730.0        | false    |
    Then Loan Charges tab has the following data:
      | Name    | isPenalty | Payment due at       | Due as of   | Calculation type | Due  | Paid | Waived | Outstanding |
      | NSF fee | true      | Specified due date   | 20250503 | Flat             | 20.0 | 0.0  | 0.0    | 20.0        |
# --- add re-aging trn with start date as maturity date --- #
    When Admin creates a Loan re-aging transaction by Loan external ID with the following data:
      | frequencyNumber | frequencyType | startDate     | numberOfInstallments |
      | 20              | DAYS          | 20250401 | 4                    |
    Then Loan Repayment schedule has 8 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date     | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late  | Outstanding |
      |    |      | 20250101  |               | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |       |             |
      | 1  | 0    | 20250101  | 20250301 | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 250.0 | 0.0         |
      | 2  | 31   | 20250201 | 20250401 | 750.0           | 0.0           | 0.0      | 0.0  | 0.0       | 0.0   | 0.0   | 0.0        | 0.0   | 0.0         |
      | 3  | 28   | 20250301    | 20250401 | 750.0           | 0.0           | 0.0      | 0.0  | 0.0       | 0.0   | 0.0   | 0.0        | 0.0   | 0.0         |
      | 4  | 31   | 20250401    | 20250401 | 750.0           | 0.0           | 0.0      | 0.0  | 0.0       | 0.0   | 0.0   | 0.0        | 0.0   | 0.0         |
      | 5  | 0    | 20250401    |               | 562.5           | 187.5         | 0.0      | 0.0  | 0.0       | 187.5 | 20.0  | 0.0        | 20.0  | 167.5       |
      | 6  | 20   | 20250421    |               | 375.0           | 187.5         | 0.0      | 0.0  | 0.0       | 187.5 | 0.0   | 0.0        | 0.0   | 187.5       |
      | 7  | 20   | 20250511      |               | 187.5           | 187.5         | 0.0      | 0.0  | 20.0      | 207.5 | 0.0   | 0.0        | 0.0   | 207.5       |
      | 8  | 20   | 20250531      |               | 0.0             | 187.5         | 0.0      | 0.0  | 0.0       | 187.5 | 0.0   | 0.0        | 0.0   | 187.5       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late  | Outstanding |
      | 1000.0        | 0.0      | 0.0  | 20.0      | 1020.0 | 270.0 | 0.0        | 270.0 | 750.0       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type  | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20250101  | Disbursement      | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       | false    |
      | 20250301    | Repayment         | 250.0  | 250.0     | 0.0      | 0.0  | 0.0       | 750.0        | false    |
      | 20250504      | Charge Adjustment |  20.0  |  20.0     | 0.0      | 0.0  | 0.0       | 730.0        | false    |
      | 20250401    | Re-age            | 750.0  | 750.0     | 0.0      | 0.0  | 0.0       |    0.0       | false    |
    Then Loan Charges tab has the following data:
      | Name    | isPenalty | Payment due at       | Due as of   | Calculation type | Due  | Paid | Waived | Outstanding |
      | NSF fee | true      | Specified due date   | 20250503 | Flat             | 20.0 | 0.0  | 0.0    | 20.0        |

    When Loan Pay-off is made on "20250504"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C4074 @AdvancedPaymentAllocation
  Scenario: Verify that Loan re-aging transaction with MIR and charge - N+1 installment after maturity date overlaps with re-aging - UC4
    When Admin sets the business date to "20250101"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                        | submitted on date | with Principal | ANNUAL interest rate % | interest type | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_DOWNPAYMENT_ADV_PMT_ALLOC_PROGRESSIVE_LOAN_SCHEDULE_HORIZONTAL | 20250101   | 1000           | 0                      | FLAT          | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 3                 | MONTHS                 | 1             | MONTHS                 | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
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
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 1000.0        | 0.0      | 0.0  | 0.0       | 1000.0 | 0.0   | 0.0        | 0.0  | 1000.0      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type  | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20250101  | Disbursement      | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       | false    |
# --- add charge a month later --- #
    When Admin sets the business date to "20250503"
    When Admin makes "MERCHANT_ISSUED_REFUND" transaction with "AUTOPAY" payment type on "20250401" with 100 EUR transaction amount
    And Admin adds "LOAN_NSF_FEE" due date charge with "20250503" due date and 20 EUR transaction amount
    Then Loan Repayment schedule has 5 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date     | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20250101  |               | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 0    | 20250101  |               | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 100.0| 0.0        | 100.0| 150.0       |
      | 2  | 31   | 20250201 |               | 500.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0  | 0.0        | 0.0  | 250.0       |
      | 3  | 28   | 20250301    |               | 250.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0  | 0.0        | 0.0  | 250.0       |
      | 4  | 31   | 20250401    |               | 0.0             | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0  | 0.0        | 0.0  | 250.0       |
      | 5  | 32   | 20250503      |               | 0.0             |   0.0         | 0.0      | 0.0  | 20.0      |  20.0 | 0.0  | 0.0        | 0.0  |  20.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late  | Outstanding |
      | 1000.0        | 0.0      | 0.0  | 20.0      | 1020.0 | 100.0 | 0.0        | 100.0 | 920.0       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type       | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20250101  | Disbursement           | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       | false    |
      | 20250401    | Merchant Issued Refund | 100.0  | 100.0     | 0.0      | 0.0  | 0.0       | 900.0        | false    |
    Then Loan Charges tab has the following data:
      | Name    | isPenalty | Payment due at       | Due as of   | Calculation type | Due  | Paid | Waived | Outstanding |
      | NSF fee | true      | Specified due date   | 20250503 | Flat             | 20.0 | 0.0  | 0.0    | 20.0        |
# --- add re-aging trn with start date as maturity date --- #
    When Admin creates a Loan re-aging transaction by Loan external ID with the following data:
      | frequencyNumber | frequencyType | startDate     | numberOfInstallments |
      | 1               | MONTHS        | 20250401 | 4                    |
    Then Loan Repayment schedule has 8 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date     | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late  | Outstanding |
      |    |      | 20250101  |               | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |       |             |
      | 1  | 0    | 20250101  | 20250401 | 900.0           | 100.0         | 0.0      | 0.0  | 0.0       | 100.0 | 100.0 | 0.0        | 100.0 | 0.0         |
      | 2  | 31   | 20250201 | 20250401 | 900.0           | 0.0           | 0.0      | 0.0  | 0.0       | 0.0   | 0.0   | 0.0        | 0.0   | 0.0         |
      | 3  | 28   | 20250301    | 20250401 | 900.0           | 0.0           | 0.0      | 0.0  | 0.0       | 0.0   | 0.0   | 0.0        | 0.0   | 0.0         |
      | 4  | 31   | 20250401    | 20250401 | 900.0           | 0.0           | 0.0      | 0.0  | 0.0       | 0.0   | 0.0   | 0.0        | 0.0   | 0.0         |
      | 5  | 0    | 20250401    |               | 675.0           | 225.0         | 0.0      | 0.0  | 0.0       | 225.0 | 0.0   | 0.0        | 0.0   | 225.0       |
      | 6  | 30   | 20250501      |               | 450.0           | 225.0         | 0.0      | 0.0  | 0.0       | 225.0 | 0.0   | 0.0        | 0.0   | 225.0       |
      | 7  | 31   | 20250601     |               | 225.0           | 225.0         | 0.0      | 0.0  | 20.0      | 245.0 | 0.0   | 0.0        | 0.0   | 245.0       |
      | 8  | 30   | 20250701     |               | 0.0             | 225.0         | 0.0      | 0.0  | 0.0       | 225.0 | 0.0   | 0.0        | 0.0   | 225.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late  | Outstanding |
      | 1000.0        | 0.0      | 0.0  | 20.0      | 1020.0 | 100.0 | 0.0        | 100.0 | 920.0       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type       | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20250101  | Disbursement           | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       | false    |
      | 20250401    | Merchant Issued Refund | 100.0  | 100.0     | 0.0      | 0.0  | 0.0       |  900.0       | false    |
      | 20250401    | Re-age                 | 900.0  | 900.0     | 0.0      | 0.0  | 0.0       |    0.0       | false    |
    Then Loan Charges tab has the following data:
      | Name    | isPenalty | Payment due at       | Due as of   | Calculation type | Due  | Paid | Waived | Outstanding |
      | NSF fee | true      | Specified due date   | 20250503 | Flat             | 20.0 | 0.0  | 0.0    | 20.0        |

    When Loan Pay-off is made on "20250503"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C4055 @AdvancedPaymentAllocation
  Scenario: Verify that Loan re-aging transaction - before maturity date and merges the corresponding normal installments - UC1
    When Admin sets the business date to "20240101"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                        | submitted on date | with Principal | ANNUAL interest rate % | interest type | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_DOWNPAYMENT_ADV_PMT_ALLOC_PROGRESSIVE_LOAN_SCHEDULE_HORIZONTAL | 20240101   | 1000           | 0                      | FLAT          | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 6                 | MONTHS                | 1              | MONTHS                 | 6                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240101" with "1000" amount and expected disbursement date on "20240101"
    When Admin successfully disburse the loan on "20240101" with "1000" EUR transaction amount
    Then Loan Repayment schedule has 7 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20240101  |           | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 0    | 20240101  |           | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0  | 0.0        | 0.0  | 250.0       |
      | 2  | 31   | 20240201 |           | 625.0           | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 0.0  | 0.0        | 0.0  | 125.0       |
      | 3  | 29   | 20240301    |           | 500.0           | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 0.0  | 0.0        | 0.0  | 125.0       |
      | 4  | 31   | 20240401    |           | 375.0           | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 0.0  | 0.0        | 0.0  | 125.0       |
      | 5  | 30   | 20240501      |           | 250.0           | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 0.0  | 0.0        | 0.0  | 125.0       |
      | 6  | 31   | 20240601     |           | 125.0           | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 0.0  | 0.0        | 0.0  | 125.0       |
      | 7  | 30   | 20240701     |           | 0.0             | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 0.0  | 0.0        | 0.0  | 125.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 1000.0        | 0.0      | 0.0  | 0.0       | 1000.0 | 0.0   | 0.0        | 0.0  | 1000.0      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type  | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20240101  | Disbursement      | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       | false    |

    When Admin sets the business date to "20240309"
    When Admin creates a Loan re-aging preview by Loan external ID with the following data:
      | frequencyNumber | frequencyType | startDate     | numberOfInstallments |
      | 1               | MONTHS        | 20240315 | 6                    |
    Then Loan Re-Aged Repayment schedule preview has 10 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date     | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      |    |      | 20240101  |               | 1000.0          |   0.0         | 0.0      | 0.0  | 0.0       | 0.0    | 0.0  |            |      |             |
      | 1  | 0    | 20240101  | 20240309 | 1000.0          |   0.0         | 0.0      | 0.0  | 0.0       | 0.0    | 0.0  | 0.0        | 0.0  | 0.0         |
      | 2  | 31   | 20240201 | 20240309 | 1000.0          |   0.0         | 0.0      | 0.0  | 0.0       | 0.0    | 0.0  | 0.0        | 0.0  | 0.0         |
      | 3  | 29   | 20240301    | 20240309 | 1000.0          |   0.0         | 0.0      | 0.0  | 0.0       | 0.0    | 0.0  | 0.0        | 0.0  | 0.0         |
      | 4  | 8    | 20240309    | 20240309 | 1000.0          |   0.0         | 0.0      | 0.0  | 0.0       | 0.0    | 0.0  | 0.0        | 0.0  | 0.0         |
      | 5  | 6    | 20240315    |               | 833.33          | 166.67        | 0.0      | 0.0  | 0.0       | 166.67 | 0.0  | 0.0        | 0.0  | 166.67      |
      | 6  | 31   | 20240415    |               | 666.66          | 166.67        | 0.0      | 0.0  | 0.0       | 166.67 | 0.0  | 0.0        | 0.0  | 166.67      |
      | 7  | 30   | 20240515      |               | 499.99          | 166.67        | 0.0      | 0.0  | 0.0       | 166.67 | 0.0  | 0.0        | 0.0  | 166.67      |
      | 8  | 31   | 20240615     |               | 333.32          | 166.67        | 0.0      | 0.0  | 0.0       | 166.67 | 0.0  | 0.0        | 0.0  | 166.67      |
      | 9  | 30   | 20240715     |               | 166.65          | 166.67        | 0.0      | 0.0  | 0.0       | 166.67 | 0.0  | 0.0        | 0.0  | 166.67      |
      | 10 | 31   | 20240815   |               | 0.0             | 166.65        | 0.0      | 0.0  | 0.0       | 166.65 | 0.0  | 0.0        | 0.0  | 166.65      |
    Then Loan Re-Aged Repayment schedule preview has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 1000.0        | 0.0      | 0.0  | 0.0       | 1000.0 | 0.0   | 0.0        | 0.0  | 1000.0      |

    When Admin creates a Loan re-aging transaction by Loan external ID with the following data:
      | frequencyNumber | frequencyType | startDate     | numberOfInstallments |
      | 1               | MONTHS        | 20240315 | 6                    |
    Then Loan Repayment schedule has 10 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date     | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      |    |      | 20240101  |               | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      | 1  | 0    | 20240101  | 20240309 | 1000.0          |   0.0         | 0.0      | 0.0  | 0.0       | 0.0    | 0.0  | 0.0        | 0.0  | 0.0         |
      | 2  | 31   | 20240201 | 20240309 | 1000.0          |   0.0         | 0.0      | 0.0  | 0.0       | 0.0    | 0.0  | 0.0        | 0.0  | 0.0         |
      | 3  | 29   | 20240301    | 20240309 | 1000.0          |   0.0         | 0.0      | 0.0  | 0.0       | 0.0    | 0.0  | 0.0        | 0.0  | 0.0         |
      | 4  | 8    | 20240309    | 20240309 | 1000.0          |   0.0         | 0.0      | 0.0  | 0.0       | 0.0    | 0.0  | 0.0        | 0.0  | 0.0         |
      | 5  | 6    | 20240315    |               | 833.33          | 166.67        | 0.0      | 0.0  | 0.0       | 166.67 | 0.0  | 0.0        | 0.0  | 166.67      |
      | 6  | 31   | 20240415    |               | 666.66          | 166.67        | 0.0      | 0.0  | 0.0       | 166.67 | 0.0  | 0.0        | 0.0  | 166.67      |
      | 7  | 30   | 20240515      |               | 499.99          | 166.67        | 0.0      | 0.0  | 0.0       | 166.67 | 0.0  | 0.0        | 0.0  | 166.67      |
      | 8  | 31   | 20240615     |               | 333.32          | 166.67        | 0.0      | 0.0  | 0.0       | 166.67 | 0.0  | 0.0        | 0.0  | 166.67      |
      | 9  | 30   | 20240715     |               | 166.65          | 166.67        | 0.0      | 0.0  | 0.0       | 166.67 | 0.0  | 0.0        | 0.0  | 166.67      |
      | 10 | 31   | 20240815   |               | 0.0             | 166.65        | 0.0      | 0.0  | 0.0       | 166.65 | 0.0  | 0.0        | 0.0  | 166.65      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 1000.0        | 0.0      | 0.0  | 0.0       | 1000.0 | 0.0   | 0.0        | 0.0  | 1000.0      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type  | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20240101  | Disbursement      | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       | false    |
      | 20240309    | Re-age            | 1000.0 | 1000.0    | 0.0      | 0.0  | 0.0       | 0.0          | false    |

    When Loan Pay-off is made on "20240309"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C4056 @AdvancedPaymentAllocation
  Scenario: Verify that Loan re-aging transaction - before maturity date and removes additional normal installments - UC2
    When Admin sets the business date to "20240101"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                        | submitted on date | with Principal | ANNUAL interest rate % | interest type | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_DOWNPAYMENT_ADV_PMT_ALLOC_PROGRESSIVE_LOAN_SCHEDULE_HORIZONTAL | 20240101   | 1000           | 0                      | FLAT          | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 6                 | MONTHS                  | 1             | MONTHS                   | 6                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240101" with "1000" amount and expected disbursement date on "20240101"
    When Admin successfully disburse the loan on "20240101" with "1000" EUR transaction amount
    Then Loan Repayment schedule has 7 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20240101  |           | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 0    | 20240101  |           | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0  | 0.0        | 0.0  | 250.0       |
      | 2  | 31   | 20240201 |           | 625.0           | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 0.0  | 0.0        | 0.0  | 125.0       |
      | 3  | 29   | 20240301    |           | 500.0           | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 0.0  | 0.0        | 0.0  | 125.0       |
      | 4  | 31   | 20240401    |           | 375.0           | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 0.0  | 0.0        | 0.0  | 125.0       |
      | 5  | 30   | 20240501      |           | 250.0           | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 0.0  | 0.0        | 0.0  | 125.0       |
      | 6  | 31   | 20240601     |           | 125.0           | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 0.0  | 0.0        | 0.0  | 125.0       |
      | 7  | 30   | 20240701     |           | 0.0             | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 0.0  | 0.0        | 0.0  | 125.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 1000.0        | 0.0      | 0.0  | 0.0       | 1000.0 | 0.0   | 0.0        | 0.0  | 1000.0      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type  | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20240101  | Disbursement      | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       | false    |
    When Admin sets the business date to "20240309"
    When Admin creates a Loan re-aging transaction by Loan external ID with the following data:
      | frequencyNumber | frequencyType | startDate     | numberOfInstallments |
      | 1               | MONTHS        | 20240315 | 1                    |
    Then Loan Repayment schedule has 5 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date     | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      |    |      | 20240101  |               | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      | 1  | 0    | 20240101  | 20240309 | 1000.0          | 0.0           | 0.0      | 0.0  | 0.0       | 0.0    | 0.0  | 0.0        | 0.0  | 0.0         |
      | 2  | 31   | 20240201 | 20240309 | 1000.0          | 0.0           | 0.0      | 0.0  | 0.0       | 0.0    | 0.0  | 0.0        | 0.0  | 0.0         |
      | 3  | 29   | 20240301    | 20240309 | 1000.0          | 0.0           | 0.0      | 0.0  | 0.0       | 0.0    | 0.0  | 0.0        | 0.0  | 0.0         |
      | 4  | 8    | 20240309    | 20240309 | 1000.0          | 0.0           | 0.0      | 0.0  | 0.0       | 0.0    | 0.0  | 0.0        | 0.0  | 0.0         |
      | 5  | 6    | 20240315    |               | 0.0             | 1000.0        | 0.0      | 0.0  | 0.0       | 1000.0 | 0.0  | 0.0        | 0.0  | 1000.0      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 1000.0        | 0.0      | 0.0  | 0.0       | 1000.0 | 0.0   | 0.0        | 0.0  | 1000.0      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type  | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20240101  | Disbursement      | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       | false    |
      | 20240309    | Re-age            | 1000.0 | 1000.0    | 0.0      | 0.0  | 0.0       | 0.0          | false    |
    Then LoanReAgeTransactionBusinessEvent has changedTerms "true"
    When Loan Pay-off is made on "20240309"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C4057 @AdvancedPaymentAllocation
  Scenario: Verify that Loan re-aging transaction with repayment and chargeback - before maturity date and merges the corresponding normal installments - UC3
    When Admin sets the business date to "20250101"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                            | submitted on date | with Principal | ANNUAL interest rate % | interest type | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP1_ADV_PMT_ALLOC_PROGRESSIVE_LOAN_SCHEDULE_HORIZONTAL | 20250101   | 1000           | 0                      | FLAT          | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 6                 | MONTHS                | 1              | MONTHS                 | 6                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20250101" with "1000" amount and expected disbursement date on "20250101"
    When Admin successfully disburse the loan on "20250101" with "1000" EUR transaction amount
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20250101   |           | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 31   | 20250201  |           | 833.0           | 167.0         | 0.0      | 0.0  | 0.0       | 167.0 | 0.0  | 0.0        | 0.0  | 167.0       |
      | 2  | 28   | 20250301     |           | 666.0           | 167.0         | 0.0      | 0.0  | 0.0       | 167.0 | 0.0  | 0.0        | 0.0  | 167.0       |
      | 3  | 31   | 20250401     |           | 499.0           | 167.0         | 0.0      | 0.0  | 0.0       | 167.0 | 0.0  | 0.0        | 0.0  | 167.0       |
      | 4  | 30   | 20250501       |           | 332.0           | 167.0         | 0.0      | 0.0  | 0.0       | 167.0 | 0.0  | 0.0        | 0.0  | 167.0       |
      | 5  | 31   | 20250601      |           | 165.0           | 167.0         | 0.0      | 0.0  | 0.0       | 167.0 | 0.0  | 0.0        | 0.0  | 167.0       |
      | 6  | 30   | 20250701      |           | 0.0             | 165.0         | 0.0      | 0.0  | 0.0       | 165.0 | 0.0  | 0.0        | 0.0  | 165.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 1000.0        | 0.0      | 0.0  | 0.0       | 1000.0 | 0.0  | 0.0        | 0.0  | 1000.0      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type  | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20250101  | Disbursement      | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       | false    |
# --- add repayment and chargeback --- #
    When Admin sets the business date to "20250203"
    And Customer makes "AUTOPAY" repayment on "20250203" with 167 EUR transaction amount
    When Admin makes "REPAYMENT_ADJUSTMENT_CHARGEBACK" chargeback with 100 EUR transaction amount
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late  | Outstanding |
      |    |      | 20250101   |                  | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |       |             |
      | 1  | 31   | 20250201  | 20250203 | 833.0           | 167.0         | 0.0      | 0.0  | 0.0       | 167.0 | 167.0 | 0.0        | 167.0 |   0.0       |
      | 2  | 28   | 20250301     |                  | 666.0           | 267.0         | 0.0      | 0.0  | 0.0       | 267.0 | 0.0   | 0.0        | 0.0   | 267.0       |
      | 3  | 31   | 20250401     |                  | 499.0           | 167.0         | 0.0      | 0.0  | 0.0       | 167.0 | 0.0   | 0.0        | 0.0   | 167.0       |
      | 4  | 30   | 20250501       |                  | 332.0           | 167.0         | 0.0      | 0.0  | 0.0       | 167.0 | 0.0   | 0.0        | 0.0   | 167.0       |
      | 5  | 31   | 20250601      |                  | 165.0           | 167.0         | 0.0      | 0.0  | 0.0       | 167.0 | 0.0   | 0.0        | 0.0   | 167.0       |
      | 6  | 30   | 20250701      |                  | 0.0             | 165.0         | 0.0      | 0.0  | 0.0       | 165.0 | 0.0   | 0.0        | 0.0   | 165.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late  | Outstanding |
      | 1100.0        | 0.0      | 0.0  | 0.0       | 1100.0 | 167.0 | 0.0        | 167.0 | 933.0       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type  | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20250101  | Disbursement      | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       | false    |
      | 20250203 | Repayment         | 167.0  | 167.0     | 0.0      | 0.0  | 0.0       | 833.0        | false    |
      | 20250203 | Chargeback        | 100.0  | 100.0     | 0.0      | 0.0  | 0.0       | 933.0        | false    |

    When Admin creates a Loan re-aging preview by Loan external ID with the following data:
      | frequencyNumber | frequencyType | startDate        | numberOfInstallments |
      | 1               | MONTHS        | 20250215 | 6                    |
    Then Loan Re-Aged Repayment schedule preview has 8 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late  | Outstanding |
      |    |      | 20250101   |                  | 1000.0          | 0.0           | 0.0      | 0.0  | 0.0       | 0.0   | 0.0   |            |       |             |
      | 1  | 31   | 20250201  | 20250203 | 833.0           | 167.0         | 0.0      | 0.0  | 0.0       | 167.0 | 167.0 | 0.0        | 167.0 |   0.0       |
      | 2  | 2    | 20250203  | 20250203 | 833.0           | 0.0           |  0.0     | 0.0  |  0.0      | 0.0   | 0.0   | 0.0        | 0.0   | 0.0         |
      | 3  | 12   | 20250215  |                  | 777.0           | 156.0         | 0.0      | 0.0  | 0.0       | 156.0 | 0.0   | 0.0        | 0.0   | 156.0       |
      | 4  | 28   | 20250315     |                  | 621.0           | 156.0         | 0.0      | 0.0  | 0.0       | 156.0 | 0.0   | 0.0        | 0.0   | 156.0       |
      | 5  | 31   | 20250415     |                  | 465.0           | 156.0         | 0.0      | 0.0  | 0.0       | 156.0 | 0.0   | 0.0        | 0.0   | 156.0       |
      | 6  | 30   | 20250515       |                  | 309.0           | 156.0         | 0.0      | 0.0  | 0.0       | 156.0 | 0.0   | 0.0        | 0.0   | 156.0       |
      | 7  | 31   | 20250615      |                  | 153.0           | 156.0         | 0.0      | 0.0  | 0.0       | 156.0 | 0.0   | 0.0        | 0.0   | 156.0       |
      | 8  | 30   | 20250715      |                  | 0.0             | 153.0         | 0.0      | 0.0  | 0.0       | 153.0 | 0.0   | 0.0        | 0.0   | 153.0       |
    Then Loan Re-Aged Repayment schedule preview has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late  | Outstanding |
      | 1100.0        | 0.0      | 0.0  | 0.0       | 1100.0 | 167.0 | 0.0        | 167.0 | 933.0       |

# --- re-age loan on 2nd installment ---#
    When Admin creates a Loan re-aging transaction by Loan external ID with the following data:
      | frequencyNumber | frequencyType | startDate        | numberOfInstallments |
      | 1               | MONTHS        | 20250215 | 6                    |
    Then Loan Repayment schedule has 8 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late  | Outstanding |
      |    |      | 20250101   |                  | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |       |             |
      | 1  | 31   | 20250201  | 20250203 | 833.0           | 167.0         | 0.0      | 0.0  | 0.0       | 167.0 | 167.0 | 0.0        | 167.0 |   0.0       |
      | 2  | 2    | 20250203  | 20250203 | 833.0           | 0.0           |  0.0     | 0.0  |  0.0      | 0.0   | 0.0   | 0.0        | 0.0   | 0.0         |
      | 3  | 12   | 20250215  |                  | 777.0           | 156.0         | 0.0      | 0.0  | 0.0       | 156.0 | 0.0   | 0.0        | 0.0   | 156.0       |
      | 4  | 28   | 20250315     |                  | 621.0           | 156.0         | 0.0      | 0.0  | 0.0       | 156.0 | 0.0   | 0.0        | 0.0   | 156.0       |
      | 5  | 31   | 20250415     |                  | 465.0           | 156.0         | 0.0      | 0.0  | 0.0       | 156.0 | 0.0   | 0.0        | 0.0   | 156.0       |
      | 6  | 30   | 20250515       |                  | 309.0           | 156.0         | 0.0      | 0.0  | 0.0       | 156.0 | 0.0   | 0.0        | 0.0   | 156.0       |
      | 7  | 31   | 20250615      |                  | 153.0           | 156.0         | 0.0      | 0.0  | 0.0       | 156.0 | 0.0   | 0.0        | 0.0   | 156.0       |
      | 8  | 30   | 20250715      |                  | 0.0             | 153.0         | 0.0      | 0.0  | 0.0       | 153.0 | 0.0   | 0.0        | 0.0   | 153.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late  | Outstanding |
      | 1100.0        | 0.0      | 0.0  | 0.0       | 1100.0 | 167.0 | 0.0        | 167.0 | 933.0       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type  | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20250101  | Disbursement      | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       | false    |
      | 20250203 | Repayment         | 167.0  | 167.0     | 0.0      | 0.0  | 0.0       | 833.0        | false    |
      | 20250203 | Chargeback        | 100.0  | 100.0     | 0.0      | 0.0  | 0.0       | 933.0        | false    |
      | 20250203 | Re-age            | 933.0  | 933.0     | 0.0      | 0.0  | 0.0       | 0.0          | false    |

    When Loan Pay-off is made on "20250203"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C4058 @AdvancedPaymentAllocation
  Scenario: Verify that Loan re-aging transaction with repayment and chargeback - before maturity date and removes additional installments - UC4
    When Admin sets the business date to "20250101"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                            | submitted on date | with Principal | ANNUAL interest rate % | interest type | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP1_ADV_PMT_ALLOC_PROGRESSIVE_LOAN_SCHEDULE_HORIZONTAL | 20250101   | 1000           | 0                      | FLAT          | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 6                 | MONTHS                | 1              | MONTHS                 | 6                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20250101" with "1000" amount and expected disbursement date on "20250101"
    When Admin successfully disburse the loan on "20250101" with "1000" EUR transaction amount
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20250101   |           | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 31   | 20250201  |           | 833.0           | 167.0         | 0.0      | 0.0  | 0.0       | 167.0 | 0.0  | 0.0        | 0.0  | 167.0       |
      | 2  | 28   | 20250301     |           | 666.0           | 167.0         | 0.0      | 0.0  | 0.0       | 167.0 | 0.0  | 0.0        | 0.0  | 167.0       |
      | 3  | 31   | 20250401     |           | 499.0           | 167.0         | 0.0      | 0.0  | 0.0       | 167.0 | 0.0  | 0.0        | 0.0  | 167.0       |
      | 4  | 30   | 20250501       |           | 332.0           | 167.0         | 0.0      | 0.0  | 0.0       | 167.0 | 0.0  | 0.0        | 0.0  | 167.0       |
      | 5  | 31   | 20250601      |           | 165.0           | 167.0         | 0.0      | 0.0  | 0.0       | 167.0 | 0.0  | 0.0        | 0.0  | 167.0       |
      | 6  | 30   | 20250701      |           | 0.0             | 165.0         | 0.0      | 0.0  | 0.0       | 165.0 | 0.0  | 0.0        | 0.0  | 165.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 1000.0        | 0.0      | 0.0  | 0.0       | 1000.0 | 0.0  | 0.0        | 0.0  | 1000.0      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type  | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20250101  | Disbursement      | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       | false    |
# --- add repayment and chargeback --- #
    When Admin sets the business date to "20250203"
    And Customer makes "AUTOPAY" repayment on "20250203" with 167 EUR transaction amount
    When Admin makes "REPAYMENT_ADJUSTMENT_CHARGEBACK" chargeback with 100 EUR transaction amount
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late  | Outstanding |
      |    |      | 20250101   |                  | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |       |             |
      | 1  | 31   | 20250201  | 20250203 | 833.0           | 167.0         | 0.0      | 0.0  | 0.0       | 167.0 | 167.0 | 0.0        | 167.0 |   0.0       |
      | 2  | 28   | 20250301     |                  | 666.0           | 267.0         | 0.0      | 0.0  | 0.0       | 267.0 | 0.0   | 0.0        | 0.0   | 267.0       |
      | 3  | 31   | 20250401     |                  | 499.0           | 167.0         | 0.0      | 0.0  | 0.0       | 167.0 | 0.0   | 0.0        | 0.0   | 167.0       |
      | 4  | 30   | 20250501       |                  | 332.0           | 167.0         | 0.0      | 0.0  | 0.0       | 167.0 | 0.0   | 0.0        | 0.0   | 167.0       |
      | 5  | 31   | 20250601      |                  | 165.0           | 167.0         | 0.0      | 0.0  | 0.0       | 167.0 | 0.0   | 0.0        | 0.0   | 167.0       |
      | 6  | 30   | 20250701      |                  | 0.0             | 165.0         | 0.0      | 0.0  | 0.0       | 165.0 | 0.0   | 0.0        | 0.0   | 165.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late  | Outstanding |
      | 1100.0        | 0.0      | 0.0  | 0.0       | 1100.0 | 167.0 | 0.0        | 167.0 | 933.0       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type  | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20250101  | Disbursement      | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       | false    |
      | 20250203 | Repayment         | 167.0  | 167.0     | 0.0      | 0.0  | 0.0       | 833.0        | false    |
      | 20250203 | Chargeback        | 100.0  | 100.0     | 0.0      | 0.0  | 0.0       | 933.0        | false    |

    When Admin creates a Loan re-aging preview by Loan external ID with the following data:
      | frequencyNumber | frequencyType | startDate        | numberOfInstallments |
      | 1               | MONTHS        | 20250215 | 1                    |
    Then Loan Re-Aged Repayment schedule preview has 3 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late  | Outstanding |
      |    |      | 20250101   |                  | 1000.0          | 0.0           |  0.0     | 0.0  |  0.0      | 0.0   | 0.0   |            |       |             |
      | 1  | 31   | 20250201  | 20250203 | 833.0           | 167.0         | 0.0      | 0.0  | 0.0       | 167.0 | 167.0 | 0.0        | 167.0 |   0.0       |
      | 2  | 2    | 20250203  | 20250203 | 833.0           | 0.0           |  0.0     | 0.0  |  0.0      | 0.0   | 0.0   | 0.0        | 0.0   | 0.0         |
      | 3  | 12   | 20250215  |                  |   0.0           | 933.0         | 0.0      | 0.0  | 0.0       | 933.0 | 0.0   | 0.0        | 0.0   | 933.0       |
    Then Loan Re-Aged Repayment schedule preview has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late  | Outstanding |
      | 1100.0        | 0.0      | 0.0  | 0.0       | 1100.0 | 167.0 | 0.0        | 167.0 | 933.0       |

# --- re-age loan on 2nd installment ---#
    When Admin creates a Loan re-aging transaction by Loan external ID with the following data:
      | frequencyNumber | frequencyType | startDate        | numberOfInstallments |
      | 1               | MONTHS        | 20250215 | 1                    |
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late  | Outstanding |
      |    |      | 20250101   |                  | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |       |             |
      | 1  | 31   | 20250201  | 20250203 | 833.0           | 167.0         | 0.0      | 0.0  | 0.0       | 167.0 | 167.0 | 0.0        | 167.0 |   0.0       |
      | 2  | 2    | 20250203  | 20250203 | 833.0           | 0.0           |  0.0     | 0.0  |  0.0      | 0.0   | 0.0   | 0.0        | 0.0   | 0.0         |
      | 3  | 12   | 20250215  |                  |   0.0           | 933.0         | 0.0      | 0.0  | 0.0       | 933.0 | 0.0   | 0.0        | 0.0   | 933.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late  | Outstanding |
      | 1100.0        | 0.0      | 0.0  | 0.0       | 1100.0 | 167.0 | 0.0        | 167.0 | 933.0       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type  | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20250101  | Disbursement      | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       | false    |
      | 20250203 | Repayment         | 167.0  | 167.0     | 0.0      | 0.0  | 0.0       | 833.0        | false    |
      | 20250203 | Chargeback        | 100.0  | 100.0     | 0.0      | 0.0  | 0.0       | 933.0        | false    |
      | 20250203 | Re-age            | 933.0  | 933.0     | 0.0      | 0.0  | 0.0       | 0.0          | false    |

    When Loan Pay-off is made on "20250203"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C4059 @AdvancedPaymentAllocation
  Scenario: Verify that Loan re-aging transaction with downdpayment - before maturity date and removes additional installments - UC5
    When Admin sets the business date to "20250101"
    When Admin set "LP2_DOWNPAYMENT_AUTO_ADVANCED_PAYMENT_ALLOCATION" loan product "DEFAULT" transaction type to "NEXT_INSTALLMENT" future installment allocation rule
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                      | submitted on date | with Principal | ANNUAL interest rate % | interest type | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_DOWNPAYMENT_AUTO_ADVANCED_PAYMENT_ALLOCATION | 20250101   | 1000           | 0                      | FLAT          | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 6                 | MONTHS                | 1              | MONTHS                 | 6                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20250101" with "1000" amount and expected disbursement date on "20250101"
    When Admin successfully disburse the loan on "20250101" with "1000" EUR transaction amount
    Then Loan Repayment schedule has 7 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20250101  |                 | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 0    | 20250101  | 20250101 | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0  |   0.0       |
      | 2  | 31   | 20250201 |                 | 625.0           | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 0.0   | 0.0        | 0.0  | 125.0       |
      | 3  | 28   | 20250301    |                 | 500.0           | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 0.0   | 0.0        | 0.0  | 125.0       |
      | 4  | 31   | 20250401    |                 | 375.0           | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 0.0   | 0.0        | 0.0  | 125.0       |
      | 5  | 30   | 20250501      |                 | 250.0           | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 0.0   | 0.0        | 0.0  | 125.0       |
      | 6  | 31   | 20250601     |                 | 125.0           | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 0.0   | 0.0        | 0.0  | 125.0       |
      | 7  | 30   | 20250701     |                 | 0.0             | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 0.0   | 0.0        | 0.0  | 125.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 1000.0        | 0.0      | 0.0  | 0.0       | 1000.0 | 250.0 | 0.0        | 0.0  | 750.0       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type  | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20250101  | Disbursement      | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       | false    |
      | 20250101  | Down Payment      |  250.0 | 250.0     | 0.0      | 0.0  | 0.0       |  750.0       | false    |
# --- re-age loan on 2nd installment ---#
    When Admin sets the business date to "20250215"
    When Admin creates a Loan re-aging transaction by Loan external ID with the following data:
      | frequencyNumber | frequencyType | startDate     | numberOfInstallments |
      | 1               | MONTHS        | 20250301 | 2                    |
    Then Loan Repayment schedule has 5 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late  | Outstanding |
      |    |      | 20250101   |                  | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |       |             |
      | 1  | 0    | 20250101   | 20250101  | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0   |   0.0       |
      | 2  | 31   | 20250201  | 20250215 | 750.0           |   0.0         | 0.0      | 0.0  | 0.0       |   0.0 | 0.0   | 0.0        | 0.0   |   0.0       |
      | 3  | 14   | 20250215  | 20250215 | 750.0           |   0.0         | 0.0      | 0.0  | 0.0       |   0.0 | 0.0   | 0.0        | 0.0   |   0.0       |
      | 4  | 14   | 20250301     |                  | 375.0           | 375.0         | 0.0      | 0.0  | 0.0       | 375.0 | 0.0   | 0.0        | 0.0   | 375.0       |
      | 5  | 31   | 20250401     |                  |   0.0           | 375.0         | 0.0      | 0.0  | 0.0       | 375.0 | 0.0   | 0.0        | 0.0   | 375.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 1000.0        | 0.0      | 0.0  | 0.0       | 1000.0 | 250.0 | 0.0        | 0.0  | 750.0       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type  | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20250101  | Disbursement      | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       | false    |
      | 20250101  | Down Payment      |  250.0 | 250.0     | 0.0      | 0.0  | 0.0       |  750.0       | false    |
      | 20250215 | Re-age            |  750.0 | 750.0     | 0.0      | 0.0  | 0.0       |    0.0       | false    |
    When Loan Pay-off is made on "20250215"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C4060 @AdvancedPaymentAllocation
  Scenario: Verify that Loan re-aging transaction with multiple disbursements: 2nd disb before re-aging - before maturity date and removes additional installments - UC6
    When Admin sets the business date to "20250101"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                            | submitted on date | with Principal | ANNUAL interest rate % | interest type | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP1_ADV_PMT_ALLOC_PROGRESSIVE_LOAN_SCHEDULE_HORIZONTAL | 20250101   | 1000           | 0                      | FLAT          | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 6                 | MONTHS                | 1              | MONTHS                 | 6                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20250101" with "1000" amount and expected disbursement date on "20250101"
    When Admin successfully disburse the loan on "20250101" with "1000" EUR transaction amount
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20250101   |           | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 31   | 20250201  |           | 833.0           | 167.0         | 0.0      | 0.0  | 0.0       | 167.0 | 0.0  | 0.0        | 0.0  | 167.0       |
      | 2  | 28   | 20250301     |           | 666.0           | 167.0         | 0.0      | 0.0  | 0.0       | 167.0 | 0.0  | 0.0        | 0.0  | 167.0       |
      | 3  | 31   | 20250401     |           | 499.0           | 167.0         | 0.0      | 0.0  | 0.0       | 167.0 | 0.0  | 0.0        | 0.0  | 167.0       |
      | 4  | 30   | 20250501       |           | 332.0           | 167.0         | 0.0      | 0.0  | 0.0       | 167.0 | 0.0  | 0.0        | 0.0  | 167.0       |
      | 5  | 31   | 20250601      |           | 165.0           | 167.0         | 0.0      | 0.0  | 0.0       | 167.0 | 0.0  | 0.0        | 0.0  | 167.0       |
      | 6  | 30   | 20250701      |           | 0.0             | 165.0         | 0.0      | 0.0  | 0.0       | 165.0 | 0.0  | 0.0        | 0.0  | 165.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 1000.0        | 0.0      | 0.0  | 0.0       | 1000.0 | 0.0  | 0.0        | 0.0  | 1000.0      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type  | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20250101  | Disbursement      | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       | false    |
# --- add 2nd disbursement --- #
    When Admin sets the business date to "20250210"
    When Admin successfully disburse the loan on "20250210" with "500" EUR transaction amount
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20250101   |           | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 31   | 20250201  |           | 833.0           | 167.0         | 0.0      | 0.0  | 0.0       | 167.0 | 0.0  | 0.0        | 0.0  | 167.0       |
      |    |      | 20250210  |           | 500.0           |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 2  | 28   | 20250301     |           | 1066.0          | 267.0         | 0.0      | 0.0  | 0.0       | 267.0 | 0.0  | 0.0        | 0.0  | 267.0       |
      | 3  | 31   | 20250401     |           | 799.0           | 267.0         | 0.0      | 0.0  | 0.0       | 267.0 | 0.0  | 0.0        | 0.0  | 267.0       |
      | 4  | 30   | 20250501       |           | 532.0           | 267.0         | 0.0      | 0.0  | 0.0       | 267.0 | 0.0  | 0.0        | 0.0  | 267.0       |
      | 5  | 31   | 20250601      |           | 265.0           | 267.0         | 0.0      | 0.0  | 0.0       | 267.0 | 0.0  | 0.0        | 0.0  | 267.0       |
      | 6  | 30   | 20250701      |           | 0.0             | 265.0         | 0.0      | 0.0  | 0.0       | 265.0 | 0.0  | 0.0        | 0.0  | 265.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 1500.0        | 0.0      | 0.0  | 0.0       | 1500.0 | 0.0  | 0.0        | 0.0  | 1500.0      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type  | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20250101  | Disbursement      | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       | false    |
      | 20250210 | Disbursement      |  500.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1500.0       | false    |
    When Admin creates a Loan re-aging preview by Loan external ID with the following data:
      | frequencyNumber | frequencyType | startDate        | numberOfInstallments |
      | 1               | MONTHS        | 20250215 | 2                    |
    Then Loan Re-Aged Repayment schedule preview has 4 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20250101   |                  | 1000.0          | 0.0           | 0.0      | 0.0  | 0.0       | 0.0   | 0.0  |            |      |             |
      | 1  | 31   | 20250201  | 20250210 | 1000.0          | 0.0           | 0.0      | 0.0  | 0.0       | 0.0   | 0.0  | 0.0        | 0.0  | 0.0         |
      | 2  | 9    | 20250210  | 20250210 | 1000.0          | 0.0           | 0.0      | 0.0  | 0.0       | 0.0   | 0.0  | 0.0        | 0.0  | 0.0         |
      |    |      | 20250210  |                  | 500.0           | 0.0           | 0.0      | 0.0  | 0.0       | 0.0   | 0.0  |            |      |             |
      | 3  | 5    | 20250215  |                  | 750.0           | 750.0         | 0.0      | 0.0  | 0.0       | 750.0 | 0.0  | 0.0        | 0.0  | 750.0       |
      | 4  | 28   | 20250315     |                  | 0.0             | 750.0         | 0.0      | 0.0  | 0.0       | 750.0 | 0.0  | 0.0        | 0.0  | 750.0       |
    Then Loan Re-Aged Repayment schedule preview has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 1500.0        | 0.0      | 0.0  | 0.0       | 1500.0 | 0.0  | 0.0        | 0.0  | 1500.0      |
# --- re-age loan on 2nd installment ---#
    When Admin creates a Loan re-aging transaction by Loan external ID with the following data:
      | frequencyNumber | frequencyType | startDate        | numberOfInstallments |
      | 1               | MONTHS        | 20250215 | 2                    |
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20250101   |                  | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 31   | 20250201  | 20250210 | 1000.0          | 0.0           | 0.0      | 0.0  | 0.0       | 0.0   | 0.0  | 0.0        | 0.0  | 0.0         |
      | 2  | 9    | 20250210  | 20250210 | 1000.0          | 0.0           | 0.0      | 0.0  | 0.0       | 0.0   | 0.0  | 0.0        | 0.0  | 0.0         |
      |    |      | 20250210  |                  | 500.0           |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 3  | 5    | 20250215  |                  | 750.0           | 750.0         | 0.0      | 0.0  | 0.0       | 750.0 | 0.0  | 0.0        | 0.0  | 750.0       |
      | 4  | 28   | 20250315     |                  | 0.0             | 750.0         | 0.0      | 0.0  | 0.0       | 750.0 | 0.0  | 0.0        | 0.0  | 750.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 1500.0        | 0.0      | 0.0  | 0.0       | 1500.0 | 0.0  | 0.0        | 0.0  | 1500.0      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type  | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20250101  | Disbursement      | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       | false    |
      | 20250210 | Disbursement      | 500.0  | 0.0       | 0.0      | 0.0  | 0.0       | 1500.0       | false    |
      | 20250210 | Re-age            | 1500.0 | 1500.0    | 0.0      | 0.0  | 0.0       | 0.0          | false    |
    When Loan Pay-off is made on "20250210"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C4596 @AdvancedPaymentAllocation
  Scenario: Verify that Loan re-aging transaction with multiple disbursements: 2nd disb on the re-aging date - before maturity date and removes additional installments - UC6
    When Admin sets the business date to "20250101"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                            | submitted on date | with Principal | ANNUAL interest rate % | interest type | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP1_ADV_PMT_ALLOC_PROGRESSIVE_LOAN_SCHEDULE_HORIZONTAL | 20250101   | 1000           | 0                      | FLAT          | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 6                 | MONTHS                | 1              | MONTHS                 | 6                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20250101" with "1000" amount and expected disbursement date on "20250101"
    When Admin successfully disburse the loan on "20250101" with "1000" EUR transaction amount
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20250101   |           | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 31   | 20250201  |           | 833.0           | 167.0         | 0.0      | 0.0  | 0.0       | 167.0 | 0.0  | 0.0        | 0.0  | 167.0       |
      | 2  | 28   | 20250301     |           | 666.0           | 167.0         | 0.0      | 0.0  | 0.0       | 167.0 | 0.0  | 0.0        | 0.0  | 167.0       |
      | 3  | 31   | 20250401     |           | 499.0           | 167.0         | 0.0      | 0.0  | 0.0       | 167.0 | 0.0  | 0.0        | 0.0  | 167.0       |
      | 4  | 30   | 20250501       |           | 332.0           | 167.0         | 0.0      | 0.0  | 0.0       | 167.0 | 0.0  | 0.0        | 0.0  | 167.0       |
      | 5  | 31   | 20250601      |           | 165.0           | 167.0         | 0.0      | 0.0  | 0.0       | 167.0 | 0.0  | 0.0        | 0.0  | 167.0       |
      | 6  | 30   | 20250701      |           | 0.0             | 165.0         | 0.0      | 0.0  | 0.0       | 165.0 | 0.0  | 0.0        | 0.0  | 165.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 1000.0        | 0.0      | 0.0  | 0.0       | 1000.0 | 0.0  | 0.0        | 0.0  | 1000.0      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type  | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20250101  | Disbursement      | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       | false    |
# --- add 2nd disbursement --- #
    When Admin sets the business date to "20250210"
    When Admin successfully disburse the loan on "20250210" with "500" EUR transaction amount
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20250101   |           | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 31   | 20250201  |           | 833.0           | 167.0         | 0.0      | 0.0  | 0.0       | 167.0 | 0.0  | 0.0        | 0.0  | 167.0       |
      |    |      | 20250210  |           | 500.0           |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 2  | 28   | 20250301     |           | 1066.0          | 267.0         | 0.0      | 0.0  | 0.0       | 267.0 | 0.0  | 0.0        | 0.0  | 267.0       |
      | 3  | 31   | 20250401     |           | 799.0           | 267.0         | 0.0      | 0.0  | 0.0       | 267.0 | 0.0  | 0.0        | 0.0  | 267.0       |
      | 4  | 30   | 20250501       |           | 532.0           | 267.0         | 0.0      | 0.0  | 0.0       | 267.0 | 0.0  | 0.0        | 0.0  | 267.0       |
      | 5  | 31   | 20250601      |           | 265.0           | 267.0         | 0.0      | 0.0  | 0.0       | 267.0 | 0.0  | 0.0        | 0.0  | 267.0       |
      | 6  | 30   | 20250701      |           | 0.0             | 265.0         | 0.0      | 0.0  | 0.0       | 265.0 | 0.0  | 0.0        | 0.0  | 265.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 1500.0        | 0.0      | 0.0  | 0.0       | 1500.0 | 0.0  | 0.0        | 0.0  | 1500.0      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type  | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20250101  | Disbursement      | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       | false    |
      | 20250210 | Disbursement      |  500.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1500.0       | false    |
# --- re-age loan on 2nd installment ---#
    When Admin creates a Loan re-aging transaction by Loan external ID with the following data:
      | frequencyNumber | frequencyType | startDate        | numberOfInstallments |
      | 1               | MONTHS        | 20250210 | 2                    |
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20250101   |                  | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 31   | 20250201  | 20250210 | 1000.0          | 0.0           | 0.0      | 0.0  | 0.0       | 0.0   | 0.0  | 0.0        | 0.0  | 0.0         |
      | 2  | 9    | 20250210  | 20250210 | 1000.0          | 0.0           | 0.0      | 0.0  | 0.0       | 0.0   | 0.0  | 0.0        | 0.0  | 0.0         |
      |    |      | 20250210  |                  | 500.0           |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 3  | 0    | 20250210  |                  | 750.0           | 750.0         | 0.0      | 0.0  | 0.0       | 750.0 | 0.0  | 0.0        | 0.0  | 750.0       |
      | 4  | 28   | 20250310     |                  | 0.0             | 750.0         | 0.0      | 0.0  | 0.0       | 750.0 | 0.0  | 0.0        | 0.0  | 750.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 1500.0        | 0.0      | 0.0  | 0.0       | 1500.0 | 0.0  | 0.0        | 0.0  | 1500.0      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type  | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20250101  | Disbursement      | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       | false    |
      | 20250210 | Disbursement      | 500.0  | 0.0       | 0.0      | 0.0  | 0.0       | 1500.0       | false    |
      | 20250210 | Re-age            | 1500.0 | 1500.0    | 0.0      | 0.0  | 0.0       | 0.0          | false    |
    When Loan Pay-off is made on "20250210"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C4324 @AdvancedPaymentAllocation
  Scenario: Verify that Loan re-aging transaction with multiple disbursements: 2nd disb after re-aging - before maturity date and removes additional installments - UC6.1
    When Admin sets the business date to "20250101"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                            | submitted on date | with Principal | ANNUAL interest rate % | interest type | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP1_ADV_PMT_ALLOC_PROGRESSIVE_LOAN_SCHEDULE_HORIZONTAL | 20250101   | 1000           | 0                      | FLAT          | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 6                 | MONTHS                | 1              | MONTHS                 | 6                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20250101" with "1000" amount and expected disbursement date on "20250101"
    When Admin successfully disburse the loan on "20250101" with "1000" EUR transaction amount
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20250101   |           | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 31   | 20250201  |           | 833.0           | 167.0         | 0.0      | 0.0  | 0.0       | 167.0 | 0.0  | 0.0        | 0.0  | 167.0       |
      | 2  | 28   | 20250301     |           | 666.0           | 167.0         | 0.0      | 0.0  | 0.0       | 167.0 | 0.0  | 0.0        | 0.0  | 167.0       |
      | 3  | 31   | 20250401     |           | 499.0           | 167.0         | 0.0      | 0.0  | 0.0       | 167.0 | 0.0  | 0.0        | 0.0  | 167.0       |
      | 4  | 30   | 20250501       |           | 332.0           | 167.0         | 0.0      | 0.0  | 0.0       | 167.0 | 0.0  | 0.0        | 0.0  | 167.0       |
      | 5  | 31   | 20250601      |           | 165.0           | 167.0         | 0.0      | 0.0  | 0.0       | 167.0 | 0.0  | 0.0        | 0.0  | 167.0       |
      | 6  | 30   | 20250701      |           | 0.0             | 165.0         | 0.0      | 0.0  | 0.0       | 165.0 | 0.0  | 0.0        | 0.0  | 165.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 1000.0        | 0.0      | 0.0  | 0.0       | 1000.0 | 0.0  | 0.0        | 0.0  | 1000.0      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type  | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20250101  | Disbursement      | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       | false    |
# --- re-age loan on 2nd installment ---#
    When Admin sets the business date to "20250210"
    When Admin creates a Loan re-aging transaction by Loan external ID with the following data:
      | frequencyNumber | frequencyType | startDate        | numberOfInstallments |
      | 1               | MONTHS        | 20250215 | 2                    |
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20250101   |                  | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 31   | 20250201  | 20250210 | 1000.0          | 0.0           | 0.0      | 0.0  | 0.0       | 0.0   | 0.0  | 0.0        | 0.0  | 0.0         |
      | 2  | 9    | 20250210  | 20250210 | 1000.0          | 0.0           | 0.0      | 0.0  | 0.0       | 0.0   | 0.0  | 0.0        | 0.0  | 0.0         |
      | 3  | 5    | 20250215  |                  |  500.0          | 500.0         | 0.0      | 0.0  | 0.0       | 500.0 | 0.0  | 0.0        | 0.0  | 500.0       |
      | 4  | 28   | 20250315     |                  |    0.0          | 500.0         | 0.0      | 0.0  | 0.0       | 500.0 | 0.0  | 0.0        | 0.0  | 500.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 1000.0        | 0.0      | 0.0  | 0.0       | 1000.0 | 0.0  | 0.0        | 0.0  | 1000.0      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type  | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20250101  | Disbursement      | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       | false    |
      | 20250210 | Re-age            | 1000.0 | 1000.0    | 0.0      | 0.0  | 0.0       | 0.0          | false    |
# --- add 2nd disbursement --- #
    When Admin successfully disburse the loan on "20250210" with "500" EUR transaction amount
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20250101   |                  | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 31   | 20250201  | 20250210 | 1000.0          | 0.0           | 0.0      | 0.0  | 0.0       | 0.0   | 0.0  | 0.0        | 0.0  |   0.0       |
      | 2  | 9    | 20250210  | 20250210 | 1000.0          | 0.0           | 0.0      | 0.0  | 0.0       | 0.0   | 0.0  | 0.0        | 0.0  | 0.0         |
      |    |      | 20250210  |                  | 500.0           |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 3  | 5    | 20250215  |                  | 750.0           | 750.0         | 0.0      | 0.0  | 0.0       | 750.0 | 0.0  | 0.0        | 0.0  | 750.0       |
      | 4  | 28   | 20250315     |                  | 0.0             | 750.0         | 0.0      | 0.0  | 0.0       | 750.0 | 0.0  | 0.0        | 0.0  | 750.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 1500.0        | 0.0      | 0.0  | 0.0       | 1500.0 | 0.0  | 0.0        | 0.0  | 1500.0      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type  | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20250101  | Disbursement      | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       | false    |
      | 20250210 | Re-age            | 1000.0 | 1000.0    | 0.0      | 0.0  | 0.0       | 0.0          | false    |
      | 20250210 | Disbursement      |  500.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1500.0       | false    |
    When Loan Pay-off is made on "20250210"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C4061 @AdvancedPaymentAllocation
  Scenario: Verify Loan re-aging transaction at 1st installment with full repayment - before maturity date and merges the corresponding normal installments - UC7
    When Admin sets the business date to "20250101"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                            | submitted on date | with Principal | ANNUAL interest rate % | interest type | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP1_ADV_PMT_ALLOC_PROGRESSIVE_LOAN_SCHEDULE_HORIZONTAL | 20250101   | 1000           | 0                      | FLAT          | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 6                 | MONTHS                | 1              | MONTHS                 | 6                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20250101" with "1000" amount and expected disbursement date on "20250101"
    When Admin successfully disburse the loan on "20250101" with "1000" EUR transaction amount
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20250101   |           | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 31   | 20250201  |           | 833.0           | 167.0         | 0.0      | 0.0  | 0.0       | 167.0 | 0.0  | 0.0        | 0.0  | 167.0       |
      | 2  | 28   | 20250301     |           | 666.0           | 167.0         | 0.0      | 0.0  | 0.0       | 167.0 | 0.0  | 0.0        | 0.0  | 167.0       |
      | 3  | 31   | 20250401     |           | 499.0           | 167.0         | 0.0      | 0.0  | 0.0       | 167.0 | 0.0  | 0.0        | 0.0  | 167.0       |
      | 4  | 30   | 20250501       |           | 332.0           | 167.0         | 0.0      | 0.0  | 0.0       | 167.0 | 0.0  | 0.0        | 0.0  | 167.0       |
      | 5  | 31   | 20250601      |           | 165.0           | 167.0         | 0.0      | 0.0  | 0.0       | 167.0 | 0.0  | 0.0        | 0.0  | 167.0       |
      | 6  | 30   | 20250701      |           | 0.0             | 165.0         | 0.0      | 0.0  | 0.0       | 165.0 | 0.0  | 0.0        | 0.0  | 165.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 1000.0        | 0.0      | 0.0  | 0.0       | 1000.0 | 0.0  | 0.0        | 0.0  | 1000.0      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type  | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20250101  | Disbursement      | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       | false    |
# --- make early repayment --- #
    When Admin sets the business date to "20250115"
    And Customer makes "AUTOPAY" repayment on "20250115" with 167 EUR transaction amount
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20250101   |                 | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 31   | 20250201  | 20250115 | 833.0           | 167.0         | 0.0      | 0.0  | 0.0       | 167.0 | 167.0| 167.0      | 0.0  |   0.0       |
      | 2  | 28   | 20250301     |                 | 666.0           | 167.0         | 0.0      | 0.0  | 0.0       | 167.0 | 0.0  | 0.0        | 0.0  | 167.0       |
      | 3  | 31   | 20250401     |                 | 499.0           | 167.0         | 0.0      | 0.0  | 0.0       | 167.0 | 0.0  | 0.0        | 0.0  | 167.0       |
      | 4  | 30   | 20250501       |                 | 332.0           | 167.0         | 0.0      | 0.0  | 0.0       | 167.0 | 0.0  | 0.0        | 0.0  | 167.0       |
      | 5  | 31   | 20250601      |                 | 165.0           | 167.0         | 0.0      | 0.0  | 0.0       | 167.0 | 0.0  | 0.0        | 0.0  | 167.0       |
      | 6  | 30   | 20250701      |                 | 0.0             | 165.0         | 0.0      | 0.0  | 0.0       | 165.0 | 0.0  | 0.0        | 0.0  | 165.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 1000.0        | 0.0      | 0.0  | 0.0       | 1000.0 | 167.0 | 167.0      | 0.0  | 833.0       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type  | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20250101  | Disbursement      | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       | false    |
      | 20250115  | Repayment         |  167.0 | 167.0     | 0.0      | 0.0  | 0.0       | 833.0        | false    |
# --- re-age loan on 1st installment ---#
    When Admin creates a Loan re-aging transaction by Loan external ID with the following data:
      | frequencyNumber | frequencyType | startDate        | numberOfInstallments |
      | 1               | MONTHS        | 20250116  | 6                    |
    Then Loan Repayment schedule has 7 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20250101   |                 | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 14   | 20250115   | 20250115 | 833.0           | 167.0         | 0.0      | 0.0  | 0.0       | 167.0 | 167.0| 167.0      | 0.0  | 0.0         |
      | 2  | 1    | 20250116   |                 | 694.0           | 139.0         | 0.0      | 0.0  | 0.0       | 139.0 | 0.0  | 0.0        | 0.0  | 139.0       |
      | 3  | 31   | 20250216  |                 | 555.0           | 139.0         | 0.0      | 0.0  | 0.0       | 139.0 | 0.0  | 0.0        | 0.0  | 139.0       |
      | 4  | 28   | 20250316     |                 | 416.0           | 139.0         | 0.0      | 0.0  | 0.0       | 139.0 | 0.0  | 0.0        | 0.0  | 139.0       |
      | 5  | 31   | 20250416     |                 | 277.0           | 139.0         | 0.0      | 0.0  | 0.0       | 139.0 | 0.0  | 0.0        | 0.0  | 139.0       |
      | 6  | 30   | 20250516       |                 | 138.0           | 139.0         | 0.0      | 0.0  | 0.0       | 139.0 | 0.0  | 0.0        | 0.0  | 139.0       |
      | 7  | 31   | 20250616      |                 | 0.0             | 138.0         | 0.0      | 0.0  | 0.0       | 138.0 | 0.0  | 0.0        | 0.0  | 138.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late  | Outstanding |
      | 1000.0        | 0.0      | 0.0  | 0.0       | 1000.0 | 167.0 | 167.0      | 0.0   | 833.0       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type  | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20250101  | Disbursement      | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       | false    |
      | 20250115  | Repayment         |  167.0 | 167.0     | 0.0      | 0.0  | 0.0       | 833.0        | false    |
      | 20250115  | Re-age            |  833.0 | 833.0     | 0.0      | 0.0  | 0.0       | 0.0          | false    |
    When Loan Pay-off is made on "20250115"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C4062 @AdvancedPaymentAllocation
  Scenario: Verify Loan re-aging transaction at 1st installment with partial repayment - before maturity date and merges the corresponding normal installments - UC8
    When Admin sets the business date to "20250101"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                            | submitted on date | with Principal | ANNUAL interest rate % | interest type | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP1_ADV_PMT_ALLOC_PROGRESSIVE_LOAN_SCHEDULE_HORIZONTAL | 20250101   | 1000           | 0                      | FLAT          | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 6                 | MONTHS                | 1              | MONTHS                 | 6                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20250101" with "1000" amount and expected disbursement date on "20250101"
    When Admin successfully disburse the loan on "20250101" with "1000" EUR transaction amount
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20250101   |           | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 31   | 20250201  |           | 833.0           | 167.0         | 0.0      | 0.0  | 0.0       | 167.0 | 0.0  | 0.0        | 0.0  | 167.0       |
      | 2  | 28   | 20250301     |           | 666.0           | 167.0         | 0.0      | 0.0  | 0.0       | 167.0 | 0.0  | 0.0        | 0.0  | 167.0       |
      | 3  | 31   | 20250401     |           | 499.0           | 167.0         | 0.0      | 0.0  | 0.0       | 167.0 | 0.0  | 0.0        | 0.0  | 167.0       |
      | 4  | 30   | 20250501       |           | 332.0           | 167.0         | 0.0      | 0.0  | 0.0       | 167.0 | 0.0  | 0.0        | 0.0  | 167.0       |
      | 5  | 31   | 20250601      |           | 165.0           | 167.0         | 0.0      | 0.0  | 0.0       | 167.0 | 0.0  | 0.0        | 0.0  | 167.0       |
      | 6  | 30   | 20250701      |           | 0.0             | 165.0         | 0.0      | 0.0  | 0.0       | 165.0 | 0.0  | 0.0        | 0.0  | 165.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 1000.0        | 0.0      | 0.0  | 0.0       | 1000.0 | 0.0  | 0.0        | 0.0  | 1000.0      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type  | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20250101  | Disbursement      | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       | false    |
# --- make early repayment --- #
    When Admin sets the business date to "20250115"
    And Customer makes "AUTOPAY" repayment on "20250115" with 100 EUR transaction amount
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date  | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20250101   |            | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 31   | 20250201  |            | 833.0           | 167.0         | 0.0      | 0.0  | 0.0       | 167.0 | 100.0| 100.0      | 0.0  |  67.0       |
      | 2  | 28   | 20250301     |            | 666.0           | 167.0         | 0.0      | 0.0  | 0.0       | 167.0 | 0.0  | 0.0        | 0.0  | 167.0       |
      | 3  | 31   | 20250401     |            | 499.0           | 167.0         | 0.0      | 0.0  | 0.0       | 167.0 | 0.0  | 0.0        | 0.0  | 167.0       |
      | 4  | 30   | 20250501       |            | 332.0           | 167.0         | 0.0      | 0.0  | 0.0       | 167.0 | 0.0  | 0.0        | 0.0  | 167.0       |
      | 5  | 31   | 20250601      |            | 165.0           | 167.0         | 0.0      | 0.0  | 0.0       | 167.0 | 0.0  | 0.0        | 0.0  | 167.0       |
      | 6  | 30   | 20250701      |            | 0.0             | 165.0         | 0.0      | 0.0  | 0.0       | 165.0 | 0.0  | 0.0        | 0.0  | 165.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 1000.0        | 0.0      | 0.0  | 0.0       | 1000.0 | 100.0 | 100.0      | 0.0  | 900.0       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type  | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20250101  | Disbursement      | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       | false    |
      | 20250115  | Repayment         |  100.0 | 100.0     | 0.0      | 0.0  | 0.0       | 900.0        | false    |
# --- re-age loan on 1st installment ---#
    When Admin creates a Loan re-aging transaction by Loan external ID with the following data:
      | frequencyNumber | frequencyType | startDate        | numberOfInstallments |
      | 1               | MONTHS        | 20250116  | 6                    |
    Then Loan Repayment schedule has 7 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20250101   |                 | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 14   | 20250115   | 20250115 | 900.0           | 100.0         | 0.0      | 0.0  | 0.0       | 100.0 | 100.0| 100.0      | 0.0  | 0.0         |
      | 2  | 1    | 20250116   |                 | 750.0           | 150.0         | 0.0      | 0.0  | 0.0       | 150.0 | 0.0  | 0.0        | 0.0  | 150.0       |
      | 3  | 31   | 20250216  |                 | 600.0           | 150.0         | 0.0      | 0.0  | 0.0       | 150.0 | 0.0  | 0.0        | 0.0  | 150.0       |
      | 4  | 28   | 20250316     |                 | 450.0           | 150.0         | 0.0      | 0.0  | 0.0       | 150.0 | 0.0  | 0.0        | 0.0  | 150.0       |
      | 5  | 31   | 20250416     |                 | 300.0           | 150.0         | 0.0      | 0.0  | 0.0       | 150.0 | 0.0  | 0.0        | 0.0  | 150.0       |
      | 6  | 30   | 20250516       |                 | 150.0           | 150.0         | 0.0      | 0.0  | 0.0       | 150.0 | 0.0  | 0.0        | 0.0  | 150.0       |
      | 7  | 31   | 20250616      |                 | 0.0             | 150.0         | 0.0      | 0.0  | 0.0       | 150.0 | 0.0  | 0.0        | 0.0  | 150.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late  | Outstanding |
      | 1000.0        | 0.0      | 0.0  | 0.0       | 1000.0 | 100.0 | 100.0      | 0.0   | 900.0       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type  | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20250101  | Disbursement      | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       | false    |
      | 20250115  | Repayment         |  100.0 | 100.0     | 0.0      | 0.0  | 0.0       | 900.0        | false    |
      | 20250115  | Re-age            |  900.0 | 900.0     | 0.0      | 0.0  | 0.0       | 0.0          | false    |
    When Loan Pay-off is made on "20250115"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C4063 @AdvancedPaymentAllocation
  Scenario: Verify Loan re-aging transaction at 1st installment with repayment for a few installments - before maturity date and merges the corresponding normal installments - UC9
    When Admin sets the business date to "20250101"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                            | submitted on date | with Principal | ANNUAL interest rate % | interest type | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP1_ADV_PMT_ALLOC_PROGRESSIVE_LOAN_SCHEDULE_HORIZONTAL | 20250101   | 1000           | 0                      | FLAT          | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 6                 | MONTHS                | 1              | MONTHS                 | 6                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20250101" with "1000" amount and expected disbursement date on "20250101"
    When Admin successfully disburse the loan on "20250101" with "1000" EUR transaction amount
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20250101   |           | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 31   | 20250201  |           | 833.0           | 167.0         | 0.0      | 0.0  | 0.0       | 167.0 | 0.0  | 0.0        | 0.0  | 167.0       |
      | 2  | 28   | 20250301     |           | 666.0           | 167.0         | 0.0      | 0.0  | 0.0       | 167.0 | 0.0  | 0.0        | 0.0  | 167.0       |
      | 3  | 31   | 20250401     |           | 499.0           | 167.0         | 0.0      | 0.0  | 0.0       | 167.0 | 0.0  | 0.0        | 0.0  | 167.0       |
      | 4  | 30   | 20250501       |           | 332.0           | 167.0         | 0.0      | 0.0  | 0.0       | 167.0 | 0.0  | 0.0        | 0.0  | 167.0       |
      | 5  | 31   | 20250601      |           | 165.0           | 167.0         | 0.0      | 0.0  | 0.0       | 167.0 | 0.0  | 0.0        | 0.0  | 167.0       |
      | 6  | 30   | 20250701      |           | 0.0             | 165.0         | 0.0      | 0.0  | 0.0       | 165.0 | 0.0  | 0.0        | 0.0  | 165.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 1000.0        | 0.0      | 0.0  | 0.0       | 1000.0 | 0.0  | 0.0        | 0.0  | 1000.0      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type  | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20250101  | Disbursement      | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       | false    |
# --- make early repayment --- #
    When Admin sets the business date to "20250115"
    And Customer makes "AUTOPAY" repayment on "20250115" with 400 EUR transaction amount
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20250101   |                 | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 31   | 20250201  | 20250115 | 833.0           | 167.0         | 0.0      | 0.0  | 0.0       | 167.0 | 167.0 | 167.0      | 0.0  |   0.0       |
      | 2  | 28   | 20250301     | 20250115 | 666.0           | 167.0         | 0.0      | 0.0  | 0.0       | 167.0 | 167.0 | 167.0      | 0.0  |   0.0       |
      | 3  | 31   | 20250401     |                 | 499.0           | 167.0         | 0.0      | 0.0  | 0.0       | 167.0 | 66.0  | 66.0       | 0.0  | 101.0       |
      | 4  | 30   | 20250501       |                 | 332.0           | 167.0         | 0.0      | 0.0  | 0.0       | 167.0 | 0.0   | 0.0        | 0.0  | 167.0       |
      | 5  | 31   | 20250601      |                 | 165.0           | 167.0         | 0.0      | 0.0  | 0.0       | 167.0 | 0.0   | 0.0        | 0.0  | 167.0       |
      | 6  | 30   | 20250701      |                 | 0.0             | 165.0         | 0.0      | 0.0  | 0.0       | 165.0 | 0.0   | 0.0        | 0.0  | 165.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 1000.0        | 0.0      | 0.0  | 0.0       | 1000.0 | 400.0 | 400.0      | 0.0  | 600.0       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type  | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20250101  | Disbursement      | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       | false    |
      | 20250115  | Repayment         |  400.0 | 400.0     | 0.0      | 0.0  | 0.0       | 600.0        | false    |
# --- re-age loan on 1st installment ---#
    When Admin creates a Loan re-aging transaction by Loan external ID with the following data:
      | frequencyNumber | frequencyType | startDate        | numberOfInstallments |
      | 1               | MONTHS        | 20250116  | 6                    |
    Then Loan Repayment schedule has 7 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20250101   |                 | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 14   | 20250115   | 20250115 | 600.0           | 400.0         | 0.0      | 0.0  | 0.0       | 400.0 | 400.0 | 400.0      | 0.0  |   0.0       |
      | 2  | 1    | 20250116   |                 | 500.0           | 100.0         | 0.0      | 0.0  | 0.0       | 100.0 | 0.0   |   0.0      | 0.0  | 100.0       |
      | 3  | 31   | 20250216  |                 | 400.0           | 100.0         | 0.0      | 0.0  | 0.0       | 100.0 | 0.0   |   0.0      | 0.0  | 100.0       |
      | 4  | 28   | 20250316     |                 | 300.0           | 100.0         | 0.0      | 0.0  | 0.0       | 100.0 | 0.0   |   0.0      | 0.0  | 100.0       |
      | 5  | 31   | 20250416     |                 | 200.0           | 100.0         | 0.0      | 0.0  | 0.0       | 100.0 | 0.0   |   0.0      | 0.0  | 100.0       |
      | 6  | 30   | 20250516       |                 | 100.0           | 100.0         | 0.0      | 0.0  | 0.0       | 100.0 | 0.0   |   0.0      | 0.0  | 100.0       |
      | 7  | 31   | 20250616      |                 | 0.0             | 100.0         | 0.0      | 0.0  | 0.0       | 100.0 | 0.0   |   0.0      | 0.0  | 100.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late  | Outstanding |
      | 1000.0        | 0.0      | 0.0  | 0.0       | 1000.0 | 400.0 | 400.0      | 0.0   | 600.0       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type  | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20250101  | Disbursement      | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       | false    |
      | 20250115  | Repayment         |  400.0 | 400.0     | 0.0      | 0.0  | 0.0       | 600.0        | false    |
      | 20250115  | Re-age            |  600.0 | 600.0     | 0.0      | 0.0  | 0.0       | 0.0          | false    |
    When Loan Pay-off is made on "20250115"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C4064 @AdvancedPaymentAllocation
  Scenario: Verify Loan re-aging transaction at 1st installment with MIR - before maturity date and merges the corresponding normal installments - UC10
    When Admin sets the business date to "20250101"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                            | submitted on date | with Principal | ANNUAL interest rate % | interest type | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP1_ADV_PMT_ALLOC_PROGRESSIVE_LOAN_SCHEDULE_HORIZONTAL | 20250101   | 1000           | 0                      | FLAT          | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 6                 | MONTHS                | 1              | MONTHS                 | 6                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20250101" with "1000" amount and expected disbursement date on "20250101"
    When Admin successfully disburse the loan on "20250101" with "1000" EUR transaction amount
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20250101   |           | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 31   | 20250201  |           | 833.0           | 167.0         | 0.0      | 0.0  | 0.0       | 167.0 | 0.0  | 0.0        | 0.0  | 167.0       |
      | 2  | 28   | 20250301     |           | 666.0           | 167.0         | 0.0      | 0.0  | 0.0       | 167.0 | 0.0  | 0.0        | 0.0  | 167.0       |
      | 3  | 31   | 20250401     |           | 499.0           | 167.0         | 0.0      | 0.0  | 0.0       | 167.0 | 0.0  | 0.0        | 0.0  | 167.0       |
      | 4  | 30   | 20250501       |           | 332.0           | 167.0         | 0.0      | 0.0  | 0.0       | 167.0 | 0.0  | 0.0        | 0.0  | 167.0       |
      | 5  | 31   | 20250601      |           | 165.0           | 167.0         | 0.0      | 0.0  | 0.0       | 167.0 | 0.0  | 0.0        | 0.0  | 167.0       |
      | 6  | 30   | 20250701      |           | 0.0             | 165.0         | 0.0      | 0.0  | 0.0       | 165.0 | 0.0  | 0.0        | 0.0  | 165.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 1000.0        | 0.0      | 0.0  | 0.0       | 1000.0 | 0.0  | 0.0        | 0.0  | 1000.0      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type  | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20250101  | Disbursement      | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       | false    |
# --- make early repayment --- #
    When Admin sets the business date to "20250125"
    When Admin makes "MERCHANT_ISSUED_REFUND" transaction with "AUTOPAY" payment type on "20250125" with 300 EUR transaction amount
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20250101   |                 | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 31   | 20250201  | 20250125 | 833.0           | 167.0         | 0.0      | 0.0  | 0.0       | 167.0 | 167.0 | 167.0      | 0.0  |   0.0       |
      | 2  | 28   | 20250301     |                 | 666.0           | 167.0         | 0.0      | 0.0  | 0.0       | 167.0 | 133.0 | 133.0      | 0.0  |  34.0       |
      | 3  | 31   | 20250401     |                 | 499.0           | 167.0         | 0.0      | 0.0  | 0.0       | 167.0 | 0.0   | 0.0        | 0.0  | 167.0       |
      | 4  | 30   | 20250501       |                 | 332.0           | 167.0         | 0.0      | 0.0  | 0.0       | 167.0 | 0.0   | 0.0        | 0.0  | 167.0       |
      | 5  | 31   | 20250601      |                 | 165.0           | 167.0         | 0.0      | 0.0  | 0.0       | 167.0 | 0.0   | 0.0        | 0.0  | 167.0       |
      | 6  | 30   | 20250701      |                 | 0.0             | 165.0         | 0.0      | 0.0  | 0.0       | 165.0 | 0.0   | 0.0        | 0.0  | 165.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 1000.0        | 0.0      | 0.0  | 0.0       | 1000.0 | 300.0 | 300.0      | 0.0  | 700.0       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type       | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20250101  | Disbursement           | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       | false    |
      | 20250125  | Merchant Issued Refund | 300.0  | 300.0     | 0.0      | 0.0  | 0.0       | 700.0        | false    |
# --- re-age loan on 1st installment ---#
    When Admin creates a Loan re-aging transaction by Loan external ID with the following data:
      | frequencyNumber | frequencyType | startDate        | numberOfInstallments |
      | 1               | MONTHS        | 20250116  | 5                    |
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late  | Outstanding |
      |    |      | 20250101  |                 | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |       |             |
      | 1  | 15   | 20250116  | 20250116 | 1000.0          | 0.0           | 0.0      | 0.0  | 0.0       | 0.0   | 0.0   | 0.0        | 0.0   | 0.0         |
      | 2  | 0    | 20250116  | 20250125 | 800.0           | 200.0         | 0.0      | 0.0  | 0.0       | 200.0 | 200.0 | 0.0        | 200.0 | 0.0         |
      | 3  | 31   | 20250216 |                 | 600.0           | 200.0         | 0.0      | 0.0  | 0.0       | 200.0 | 100.0 | 100.0      | 0.0   | 100.0       |
      | 4  | 28   | 20250316    |                 | 400.0           | 200.0         | 0.0      | 0.0  | 0.0       | 200.0 | 0.0   | 0.0        | 0.0   | 200.0       |
      | 5  | 31   | 20250416    |                 | 200.0           | 200.0         | 0.0      | 0.0  | 0.0       | 200.0 | 0.0   | 0.0        | 0.0   | 200.0       |
      | 6  | 30   | 20250516      |                 | 0.0             | 200.0         | 0.0      | 0.0  | 0.0       | 200.0 | 0.0   | 0.0        | 0.0   | 200.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late  | Outstanding |
      | 1000.0        | 0.0      | 0.0  | 0.0       | 1000.0 | 300.0 | 100.0      | 200.0   | 700.0       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type       | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20250101  | Disbursement           | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       | false    |
      | 20250125  | Merchant Issued Refund | 300.0  | 300.0     | 0.0      | 0.0  | 0.0       | 700.0        | false    |
      | 20250116  | Re-age                 | 1000.0 | 1000.0    | 0.0      | 0.0  | 0.0       | 0.0          | false    |
    When Loan Pay-off is made on "20250125"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C4065 @AdvancedPaymentAllocation
  Scenario: Verify Loan re-aging transaction at 1st installment with repayment at last installment - before maturity date and merges the corresponding normal installments - UC11.1
    When Admin sets the business date to "20250101"
    When Admin creates a client with random data
    And Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                              | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_EMI_360_30_IR_DAILY_TILL_PRECLOSE_LAST_INSTALLMENT_STRATEGY | 20250101   | 1000.0         | 0                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 6                 | MONTHS                | 1              | MONTHS                 | 6                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20250101" with "1000" amount and expected disbursement date on "20250101"
    When Admin successfully disburse the loan on "20250101" with "1000" EUR transaction amount
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      |    |      | 20250101   |           | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      | 1  | 31   | 20250201  |           | 833.33          | 166.67        | 0.0      | 0.0  | 0.0       | 166.67 | 0.0  | 0.0        | 0.0  | 166.67      |
      | 2  | 28   | 20250301     |           | 666.66          | 166.67        | 0.0      | 0.0  | 0.0       | 166.67 | 0.0  | 0.0        | 0.0  | 166.67      |
      | 3  | 31   | 20250401     |           | 499.99          | 166.67        | 0.0      | 0.0  | 0.0       | 166.67 | 0.0  | 0.0        | 0.0  | 166.67      |
      | 4  | 30   | 20250501       |           | 333.32          | 166.67        | 0.0      | 0.0  | 0.0       | 166.67 | 0.0  | 0.0        | 0.0  | 166.67      |
      | 5  | 31   | 20250601      |           | 166.65          | 166.67        | 0.0      | 0.0  | 0.0       | 166.67 | 0.0  | 0.0        | 0.0  | 166.67      |
      | 6  | 30   | 20250701      |           | 0.0             | 166.65        | 0.0      | 0.0  | 0.0       | 166.65 | 0.0  | 0.0        | 0.0  | 166.65      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 1000.0        | 0.0      | 0.0  | 0.0       | 1000.0 | 0.0  | 0.0        | 0.0  | 1000.0      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type  | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20250101  | Disbursement      | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       | false    |
# --- make early repayment --- #
    When Admin sets the business date to "20250115"
    And Customer makes "AUTOPAY" repayment on "20250115" with 166.65 EUR transaction amount
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late | Outstanding |
      |    |      | 20250101   |                 | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0    |            |      |             |
      | 1  | 31   | 20250201  |                 | 833.33          | 166.67        | 0.0      | 0.0  | 0.0       | 166.67 | 0.0    | 0.0        | 0.0  | 166.67      |
      | 2  | 28   | 20250301     |                 | 666.66          | 166.67        | 0.0      | 0.0  | 0.0       | 166.67 | 0.0    | 0.0        | 0.0  | 166.67      |
      | 3  | 31   | 20250401     |                 | 499.99          | 166.67        | 0.0      | 0.0  | 0.0       | 166.67 | 0.0    | 0.0        | 0.0  | 166.67      |
      | 4  | 30   | 20250501       |                 | 333.32          | 166.67        | 0.0      | 0.0  | 0.0       | 166.67 | 0.0    | 0.0        | 0.0  | 166.67      |
      | 5  | 31   | 20250601      |                 | 166.65          | 166.67        | 0.0      | 0.0  | 0.0       | 166.67 | 0.0    | 0.0        | 0.0  | 166.67      |
      | 6  | 30   | 20250701      | 20250115 | 0.0             | 166.65        | 0.0      | 0.0  | 0.0       | 166.65 | 166.65 | 166.65     | 0.0  |   0.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late | Outstanding |
      | 1000.0        | 0.0      | 0.0  | 0.0       | 1000.0 | 166.65 | 166.65     | 0.0  | 833.35      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type  | Amount  | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20250101  | Disbursement      | 1000.0  | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       | false    |
      | 20250115  | Repayment         |  166.65 | 166.65    | 0.0      | 0.0  | 0.0       | 833.35       | false    |
# --- re-age loan on 1st installment ---#
    When Admin creates a Loan re-aging transaction by Loan external ID with the following data:
      | frequencyNumber | frequencyType | startDate        | numberOfInstallments |
      | 1               | MONTHS        | 20250116  | 8                    |
    Then Loan Repayment schedule has 9 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late | Outstanding |
      |    |      | 20250101   |                 | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0    |            |      |             |
      | 1  | 14   | 20250115   | 20250115 | 833.35          | 166.65        | 0.0      | 0.0  | 0.0       | 166.65 | 166.65 | 166.65     | 0.0  | 0.0         |
      | 2  | 1    | 20250116   |                 | 729.18          | 104.17        | 0.0      | 0.0  | 0.0       | 104.17 | 0.0    | 0.0        | 0.0  | 104.17      |
      | 3  | 31   | 20250216  |                 | 625.01          | 104.17        | 0.0      | 0.0  | 0.0       | 104.17 | 0.0    | 0.0        | 0.0  | 104.17      |
      | 4  | 28   | 20250316     |                 | 520.84          | 104.17        | 0.0      | 0.0  | 0.0       | 104.17 | 0.0    | 0.0        | 0.0  | 104.17      |
      | 5  | 31   | 20250416     |                 | 416.67          | 104.17        | 0.0      | 0.0  | 0.0       | 104.17 | 0.0    | 0.0        | 0.0  | 104.17      |
      | 6  | 30   | 20250516       |                 | 312.5           | 104.17        | 0.0      | 0.0  | 0.0       | 104.17 | 0.0    | 0.0        | 0.0  | 104.17      |
      | 7  | 31   | 20250616      |                 | 208.33          | 104.17        | 0.0      | 0.0  | 0.0       | 104.17 | 0.0    | 0.0        | 0.0  | 104.17      |
      | 8  | 30   | 20250716      |                 | 104.16          | 104.17        | 0.0      | 0.0  | 0.0       | 104.17 | 0.0    | 0.0        | 0.0  | 104.17      |
      | 9  | 31   | 20250816    |                 |   0.0           | 104.16        | 0.0      | 0.0  | 0.0       | 104.16 | 0.0    | 0.0        | 0.0  | 104.16      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late  | Outstanding |
      | 1000.0        | 0.0      | 0.0  | 0.0       | 1000.0 | 166.65 | 166.65     | 0.0   | 833.35       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type  | Amount  | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20250101  | Disbursement      | 1000.0  | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       | false    |
      | 20250115  | Repayment         |  166.65 | 166.65    | 0.0      | 0.0  | 0.0       | 833.35       | false    |
      | 20250115  | Re-age            |  833.35 | 833.35    | 0.0      | 0.0  | 0.0       | 0.0          | false    |
    When Loan Pay-off is made on "20250115"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C4078 @AdvancedPaymentAllocation
  Scenario: Verify Loan re-aging transaction at 1st installment with repayment at last installment - before maturity date and merges the corresponding normal installments - UC11.2
    When Admin sets the business date to "20250101"
    When Admin creates a client with random data
    And Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                              | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_EMI_360_30_IR_DAILY_TILL_PRECLOSE_LAST_INSTALLMENT_STRATEGY | 20250101   | 1000.0         | 0                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 6                 | MONTHS                | 1              | MONTHS                 | 6                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20250101" with "1000" amount and expected disbursement date on "20250101"
    When Admin successfully disburse the loan on "20250101" with "1000" EUR transaction amount
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      |    |      | 20250101   |           | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      | 1  | 31   | 20250201  |           | 833.33          | 166.67        | 0.0      | 0.0  | 0.0       | 166.67 | 0.0  | 0.0        | 0.0  | 166.67      |
      | 2  | 28   | 20250301     |           | 666.66          | 166.67        | 0.0      | 0.0  | 0.0       | 166.67 | 0.0  | 0.0        | 0.0  | 166.67      |
      | 3  | 31   | 20250401     |           | 499.99          | 166.67        | 0.0      | 0.0  | 0.0       | 166.67 | 0.0  | 0.0        | 0.0  | 166.67      |
      | 4  | 30   | 20250501       |           | 333.32          | 166.67        | 0.0      | 0.0  | 0.0       | 166.67 | 0.0  | 0.0        | 0.0  | 166.67      |
      | 5  | 31   | 20250601      |           | 166.65          | 166.67        | 0.0      | 0.0  | 0.0       | 166.67 | 0.0  | 0.0        | 0.0  | 166.67      |
      | 6  | 30   | 20250701      |           | 0.0             | 166.65        | 0.0      | 0.0  | 0.0       | 166.65 | 0.0  | 0.0        | 0.0  | 166.65      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 1000.0        | 0.0      | 0.0  | 0.0       | 1000.0 | 0.0  | 0.0        | 0.0  | 1000.0      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type  | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20250101  | Disbursement      | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       | false    |
# --- make early repayment --- #
    When Admin sets the business date to "20250115"
    And Customer makes "AUTOPAY" repayment on "20250115" with 166.65 EUR transaction amount
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late | Outstanding |
      |    |      | 20250101   |                 | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0    |            |      |             |
      | 1  | 31   | 20250201  |                 | 833.33          | 166.67        | 0.0      | 0.0  | 0.0       | 166.67 | 0.0    | 0.0        | 0.0  | 166.67      |
      | 2  | 28   | 20250301     |                 | 666.66          | 166.67        | 0.0      | 0.0  | 0.0       | 166.67 | 0.0    | 0.0        | 0.0  | 166.67      |
      | 3  | 31   | 20250401     |                 | 499.99          | 166.67        | 0.0      | 0.0  | 0.0       | 166.67 | 0.0    | 0.0        | 0.0  | 166.67      |
      | 4  | 30   | 20250501       |                 | 333.32          | 166.67        | 0.0      | 0.0  | 0.0       | 166.67 | 0.0    | 0.0        | 0.0  | 166.67      |
      | 5  | 31   | 20250601      |                 | 166.65          | 166.67        | 0.0      | 0.0  | 0.0       | 166.67 | 0.0    | 0.0        | 0.0  | 166.67      |
      | 6  | 30   | 20250701      | 20250115 | 0.0             | 166.65        | 0.0      | 0.0  | 0.0       | 166.65 | 166.65 | 166.65     | 0.0  |   0.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late | Outstanding |
      | 1000.0        | 0.0      | 0.0  | 0.0       | 1000.0 | 166.65 | 166.65     | 0.0  | 833.35      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type  | Amount  | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20250101  | Disbursement      | 1000.0  | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       | false    |
      | 20250115  | Repayment         |  166.65 | 166.65    | 0.0      | 0.0  | 0.0       | 833.35       | false    |
# --- re-age loan on 1st installment ---#
    When Admin creates a Loan re-aging transaction by Loan external ID with the following data:
      | frequencyNumber | frequencyType | startDate        | numberOfInstallments |
      | 1               | MONTHS        | 20250116  | 4                    |
    Then Loan Repayment schedule has 5 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late | Outstanding |
      |    |      | 20250101   |                 | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0    |            |      |             |
      | 1  | 14   | 20250115   | 20250115 |  833.35         | 166.65        | 0.0      | 0.0  | 0.0       | 166.65 | 166.65 | 166.65     | 0.0  |   0.0       |
      | 2  | 1    | 20250116   |                 |  625.01         | 208.34        | 0.0      | 0.0  | 0.0       | 208.34 | 0.0    | 0.0        | 0.0  | 208.34      |
      | 3  | 31   | 20250216  |                 |  416.67         | 208.34        | 0.0      | 0.0  | 0.0       | 208.34 | 0.0    | 0.0        | 0.0  | 208.34      |
      | 4  | 28   | 20250316     |                 |  208.33         | 208.34        | 0.0      | 0.0  | 0.0       | 208.34 | 0.0    | 0.0        | 0.0  | 208.34      |
      | 5  | 31   | 20250416     |                 |    0.0          | 208.33        | 0.0      | 0.0  | 0.0       | 208.33 | 0.0    | 0.0        | 0.0  | 208.33      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late | Outstanding |
      | 1000.0        | 0.0      | 0.0  | 0.0       | 1000.0 | 166.65 | 166.65     | 0.0  | 833.35      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type  | Amount  | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20250101  | Disbursement      | 1000.0  | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       | false    |
      | 20250115  | Repayment         |  166.65 | 166.65    | 0.0      | 0.0  | 0.0       | 833.35       | false    |
      | 20250115  | Re-age            |  833.35 | 833.35    | 0.0      | 0.0  | 0.0       | 0.0          | false    |
    When Loan Pay-off is made on "20250115"
    Then Loan status will be "CLOSED_OBLIGATIONS_MET"
    Then Loan has 0 outstanding amount

