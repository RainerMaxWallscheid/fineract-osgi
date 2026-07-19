@CapitalizedIncomeFeature
Feature: Capitalized Income - Part1

  @TestRailId:C3635
  Scenario: As a user I want to add capitalized income to a progressive loan after disbursement for multidisbursal loan with downpayment - UC1
    When Admin sets the business date to "20240101"
    And Admin creates a client with random data
    And Admin creates a fully customized loan with the following data:
      | LoanProduct                                                    | submitted on date | with Principal | ANNUAL interest rate % | interest type | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_PROGRESSIVE_ADVANCED_PAYMENT_ALLOCATION_CAPITALIZED_INCOME | 20240101    | 1000.0         | 0                      | FLAT          | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 30                | DAYS                  | 30             | DAYS                   | 1                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240101" with "1000" amount and expected disbursement date on "20240101"
    And Admin successfully disburse the loan on "20240101" with "900" EUR transaction amount
    Then Loan status will be "ACTIVE"
    When Admin sets the business date to "20240102"
    And Admin adds capitalized income with "AUTOPAY" payment type to the loan on "20240102" with "100" EUR transaction amount
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
    And Deferred Capitalized Income contains the following data:
      | Amount | Amortized Amount | Unrecognized Amount | Adjusted Amount | Charged Off Amount |
      | 100.0  | 0.0              | 100.0               | 0.0             | 0.0                |

    When Loan Pay-off is made on "20240102"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C3637
  Scenario: As a user I want to add capitalized income to a progressive loan after disbursement - UC2
    When Admin sets the business date to "20240101"
    And Admin creates a client with random data
    And Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                      | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_EMI_360_30_INTEREST_RECALC_DAILY_CAPITALIZED_INCOME | 20240101   | 1000           | 7                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 1                 | MONTHS                | 1              | MONTHS                 | 1                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240101" with "1000" amount and expected disbursement date on "20240101"
    And Admin successfully disburse the loan on "20240101" with "900" EUR transaction amount
    Then Loan status will be "ACTIVE"
    When Admin sets the business date to "20240102"
    And Admin adds capitalized income with "AUTOPAY" payment type to the loan on "20240102" with "100" EUR transaction amount
    Then Loan Repayment schedule has 1 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due     | Paid | In advance | Late | Outstanding |
      |    |      | 20240101  |           | 900.0           |               |          | 0.0  |           | 0.0     | 0.0  |            |      |             |
      |    |      | 20240102  |           | 100.0           |               |          | 0.0  |           | 0.0     | 0.0  |            |      |             |
      | 1  | 31   | 20240201 |           | 0.0             | 1000.0        | 5.81     | 0.0  | 0.0       | 1005.81 | 0.0  | 0.0        | 0.0  | 1005.81     |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid | In advance | Late | Outstanding |
      | 1000.0        | 5.81     | 0.0  | 0.0       | 1005.81 | 0.0  | 0.0        | 0.0  | 1005.81     |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type   | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20240101  | Disbursement       | 900.0  | 0.0       | 0.0      | 0.0  | 0.0       | 900.0        | false    |
      | 20240102  | Capitalized Income | 100.0  | 100.0     | 0.0      | 0.0  | 0.0       | 1000.0       | false    |
    And Loan Transactions tab has a "CAPITALIZED_INCOME" transaction with date "20240102" which has the following Journal entries:
      | Type      | Account code | Account name                 | Debit  | Credit |
      | ASSET     | 112601       | Loans Receivable             | 100.0  |        |
      | LIABILITY | 145024       | Deferred Capitalized Income  |        | 100.0  |

    When Loan Pay-off is made on "20240102"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C3638
  Scenario: Verify capitalized income amount with disbursement amount calculation within approved amount for multidisbursal progressive loan - UC3
    When Admin sets the business date to "20240101"
    And Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                                     | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_EMI_360_30_INTEREST_RECALC_DAILY_MULTIDISBURSAL_CAPITALIZED_INCOME | 20240101   | 1000           | 7                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 6                 | MONTHS                | 1              | MONTHS                 | 6                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240101" with "1000" amount and expected disbursement date on "20240101"
    And Admin successfully disburse the loan on "20240101" with "600" EUR transaction amount
    Then Loan status will be "ACTIVE"
    When Admin sets the business date to "20240102"
    And Admin successfully disburse the loan on "20240102" with "200" EUR transaction amount
    When Admin sets the business date to "20240103"
    And Admin adds capitalized income with "AUTOPAY" payment type to the loan on "20240103" with "200" EUR transaction amount
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      |    |      | 20240101  |           | 600.0           |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      |    |      | 20240102  |           | 200.0           |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      |    |      | 20240103  |           | 200.0           |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      | 1  | 31   | 20240201 |           | 835.65          | 164.35        | 5.72     | 0.0  | 0.0       | 170.07 | 0.0  | 0.0        | 0.0  | 170.07      |
      | 2  | 29   | 20240301    |           | 670.45          | 165.2         | 4.87     | 0.0  | 0.0       | 170.07 | 0.0  | 0.0        | 0.0  | 170.07      |
      | 3  | 31   | 20240401    |           | 504.29          | 166.16        | 3.91     | 0.0  | 0.0       | 170.07 | 0.0  | 0.0        | 0.0  | 170.07      |
      | 4  | 30   | 20240501      |           | 337.16          | 167.13        | 2.94     | 0.0  | 0.0       | 170.07 | 0.0  | 0.0        | 0.0  | 170.07      |
      | 5  | 31   | 20240601     |           | 169.06          | 168.1         | 1.97     | 0.0  | 0.0       | 170.07 | 0.0  | 0.0        | 0.0  | 170.07      |
      | 6  | 30   | 20240701     |           | 0.0             | 169.06        | 0.99     | 0.0  | 0.0       | 170.05 | 0.0  | 0.0        | 0.0  | 170.05      |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 1000.0        | 20.4     | 0.0  | 0.0       | 1020.4 | 0.0  | 0.0        | 0.0  | 1020.4      |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type   | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20240101  | Disbursement       | 600.0  | 0.0       | 0.0      | 0.0  | 0.0       | 600.0        | false    |
      | 20240102  | Disbursement       | 200.0  | 0.0       | 0.0      | 0.0  | 0.0       | 800.0         | false    |
      | 20240103  | Capitalized Income | 200.0  | 200.0     | 0.0      | 0.0  | 0.0       | 1000.0        | false    |
    And Loan Transactions tab has a "CAPITALIZED_INCOME" transaction with date "20240103" which has the following Journal entries:
      | Type      | Account code | Account name                 | Debit  | Credit |
      | ASSET     | 112601       | Loans Receivable             | 200.0  |        |
      | LIABILITY | 145024       | Deferred Capitalized Income  |        | 200.0  |

    When Loan Pay-off is made on "20240103"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C3639
  Scenario: Verify validation of capitalized income amount with disbursement amount within approved amount for progressive loan - UC4
    When Admin sets the business date to "20240101"
    And Admin creates a client with random data
    And Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                      | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_EMI_360_30_INTEREST_RECALC_DAILY_CAPITALIZED_INCOME | 20240101   | 1000           | 7                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 1                 | MONTHS                | 1              | MONTHS                 | 1                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240101" with "1000" amount and expected disbursement date on "20240101"
    And Admin successfully disburse the loan on "20240101" with "900" EUR transaction amount
    Then Loan status will be "ACTIVE"
    When Admin sets the business date to "20240102"
    Then Capitalized income with payment type "AUTOPAY" on "20240102" is forbidden with amount "200" while exceed approved amount

    When Loan Pay-off is made on "20240102"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C3640
  Scenario: Verify validation of capitalized income amount with disbursement amount within approved amount for multidisbursal progressive loan - UC5
    When Admin sets the business date to "20240101"
    And Admin creates a client with random data
    And Admin creates a fully customized loan with the following data:
      | LoanProduct                                                    | submitted on date | with Principal | ANNUAL interest rate % | interest type | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_PROGRESSIVE_ADVANCED_PAYMENT_ALLOCATION_CAPITALIZED_INCOME | 20240101    | 1000.0         | 0                      | FLAT          | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 30                | DAYS                  | 30             | DAYS                   | 1                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240101" with "1000" amount and expected disbursement date on "20240101"
    And Admin successfully disburse the loan on "20240101" with "500" EUR transaction amount
    Then Loan status will be "ACTIVE"
    When Admin sets the business date to "20240102"
    And Admin successfully disburse the loan on "20240102" with "300" EUR transaction amount
    Then Capitalized income with payment type "AUTOPAY" on "20240102" is forbidden with amount "300" while exceed approved amount

    When Loan Pay-off is made on "20240102"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C3641
  Scenario: Verify validation of capitalized income amount with disbursement amount within approved amount after undo disbursement - UC6
    When Admin sets the business date to "20240101"
    And Admin creates a client with random data
    And Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                      | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_EMI_360_30_INTEREST_RECALC_DAILY_CAPITALIZED_INCOME | 20240101   | 1000           | 7                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 1                 | MONTHS                | 1              | MONTHS                 | 1                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240101" with "1000" amount and expected disbursement date on "20240101"
    And Admin successfully disburse the loan on "20240101" with "900" EUR transaction amount
    Then Loan status will be "ACTIVE"
    When Admin sets the business date to "20240102"
    And Admin adds capitalized income with "AUTOPAY" payment type to the loan on "20240102" with "100" EUR transaction amount
    Then Loan Repayment schedule has 1 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due     | Paid | In advance | Late | Outstanding |
      |    |      | 20240101  |           | 900.0           |               |          | 0.0  |           | 0.0     | 0.0  |            |      |             |
      |    |      | 20240102  |           | 100.0           |               |          | 0.0  |           | 0.0     | 0.0  |            |      |             |
      | 1  | 31   | 20240201 |           | 0.0             | 1000.0        | 5.81     | 0.0  | 0.0       | 1005.81 | 0.0  | 0.0        | 0.0  | 1005.81     |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid | In advance | Late | Outstanding |
      | 1000.0        | 5.81     | 0.0  | 0.0       | 1005.81 | 0.0  | 0.0        | 0.0  | 1005.81     |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type   | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20240101  | Disbursement       | 900.0  | 0.0       | 0.0      | 0.0  | 0.0       | 900.0        | false    |
      | 20240102  | Capitalized Income | 100.0  | 100.0     | 0.0      | 0.0  | 0.0       | 1000.0       | false    |
    And Loan Transactions tab has a "CAPITALIZED_INCOME" transaction with date "20240102" which has the following Journal entries:
      | Type      | Account code | Account name                 | Debit  | Credit |
      | ASSET     | 112601       | Loans Receivable             | 100.0  |        |
      | LIABILITY | 145024       | Deferred Capitalized Income  |        | 100.0  |
    When Admin successfully undo disbursal
    Then Loan status will be "APPROVED"
    When Admin sets the business date to "20240103"
    And Admin successfully disburse the loan on "20240103" with "800" EUR transaction amount
    And Admin adds capitalized income with "AUTOPAY" payment type to the loan on "20240103" with "200" EUR transaction amount
    Then Loan Repayment schedule has 1 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due     | Paid | In advance | Late | Outstanding |
      |    |      | 20240103  |           | 800.0           |               |          | 0.0  |           | 0.0     | 0.0  |            |      |             |
      |    |      | 20240103  |           | 200.0           |               |          | 0.0  |           | 0.0     | 0.0  |            |      |             |
      | 1  | 31   | 20240203 |           | 0.0             | 1000.0        | 5.83     | 0.0  | 0.0       | 1005.83 | 0.0  | 0.0        | 0.0  | 1005.83     |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid | In advance | Late | Outstanding |
      | 1000.0        | 5.83     | 0.0  | 0.0       | 1005.83 | 0.0  | 0.0        | 0.0  | 1005.83     |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type   | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20240103  | Disbursement       | 800.0  | 0.0       | 0.0      | 0.0  | 0.0       | 800.0        | false    |
      | 20240103  | Capitalized Income | 200.0  | 200.0     | 0.0      | 0.0  | 0.0       | 1000.0       | false    |
    And Loan Transactions tab has a "CAPITALIZED_INCOME" transaction with date "20240103" which has the following Journal entries:
      | Type      | Account code | Account name                 | Debit  | Credit |
      | ASSET     | 112601       | Loans Receivable             | 200.0  |        |
      | LIABILITY | 145024       | Deferred Capitalized Income  |        | 200.0  |

    When Loan Pay-off is made on "20240103"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C3642
  Scenario: Verify capitalized income amount with disbursement amount calculation within approved amount for multidisbursal loan after undo disbursement - UC7
    When Admin sets the business date to "20240101"
    And Admin creates a client with random data
    And Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                                     | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_EMI_360_30_INTEREST_RECALC_DAILY_MULTIDISBURSAL_CAPITALIZED_INCOME | 20240101   | 1000           | 7                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 6                 | MONTHS                | 1              | MONTHS                 | 6                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240101" with "1000" amount and expected disbursement date on "20240101"
    And Admin successfully disburse the loan on "20240101" with "600" EUR transaction amount
    Then Loan status will be "ACTIVE"
    When Admin sets the business date to "20240102"
    And Admin successfully disburse the loan on "20240102" with "200" EUR transaction amount
    And Admin adds capitalized income with "AUTOPAY" payment type to the loan on "20240102" with "200" EUR transaction amount
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      |    |      | 20240101  |           | 600.0           |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      |    |      | 20240102  |           | 200.0           |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      |    |      | 20240102  |           | 200.0           |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      | 1  | 31   | 20240201 |           | 835.69          | 164.31        | 5.76     | 0.0  | 0.0       | 170.07 | 0.0  | 0.0        | 0.0  | 170.07      |
      | 2  | 29   | 20240301    |           | 670.49          | 165.2         | 4.87     | 0.0  | 0.0       | 170.07 | 0.0  | 0.0        | 0.0  | 170.07      |
      | 3  | 31   | 20240401    |           | 504.33          | 166.16        | 3.91     | 0.0  | 0.0       | 170.07 | 0.0  | 0.0        | 0.0  | 170.07      |
      | 4  | 30   | 20240501      |           | 337.2           | 167.13        | 2.94     | 0.0  | 0.0       | 170.07 | 0.0  | 0.0        | 0.0  | 170.07      |
      | 5  | 31   | 20240601     |           | 169.1           | 168.1         | 1.97     | 0.0  | 0.0       | 170.07 | 0.0  | 0.0        | 0.0  | 170.07      |
      | 6  | 30   | 20240701     |           | 0.0             | 169.1         | 0.99     | 0.0  | 0.0       | 170.09 | 0.0  | 0.0        | 0.0  | 170.09      |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid | In advance | Late | Outstanding |
      | 1000.0        | 20.44    | 0.0  | 0.0       | 1020.44 | 0.0  | 0.0        | 0.0  | 1020.44     |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type   | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20240101  | Disbursement       | 600.0  | 0.0       | 0.0      | 0.0  | 0.0       | 600.0        | false    |
      | 20240102  | Disbursement       | 200.0  | 0.0       | 0.0      | 0.0  | 0.0       | 800.0        | false    |
      | 20240102  | Capitalized Income | 200.0  | 200.0     | 0.0      | 0.0  | 0.0       | 1000.0       | false    |
    And Loan Transactions tab has a "CAPITALIZED_INCOME" transaction with date "20240102" which has the following Journal entries:
      | Type      | Account code | Account name                 | Debit  | Credit |
      | ASSET     | 112601       | Loans Receivable             | 200.0  |        |
      | LIABILITY | 145024       | Deferred Capitalized Income  |        | 200.0  |
    When Admin successfully undo disbursal
    Then Loan status will be "APPROVED"
    When Admin sets the business date to "20240103"
    And Admin successfully disburse the loan on "20240103" with "500" EUR transaction amount
    And Admin sets the business date to "20240104"
    And Admin successfully disburse the loan on "20240104" with "200" EUR transaction amount
    And Admin adds capitalized income with "AUTOPAY" payment type to the loan on "20240104" with "300" EUR transaction amount
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      |    |      | 20240103  |           | 500.0           |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      |    |      | 20240104  |           | 200.0           |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      |    |      | 20240104  |           | 200.0           |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      | 1  | 31   | 20240203 |           | 835.67          | 164.33        | 5.74     | 0.0  | 0.0       | 170.07 | 0.0  | 0.0        | 0.0  | 170.07      |
      | 2  | 29   | 20240303    |           | 670.47          | 165.2         | 4.87     | 0.0  | 0.0       | 170.07 | 0.0  | 0.0        | 0.0  | 170.07      |
      | 3  | 31   | 20240403    |           | 504.31          | 166.16        | 3.91     | 0.0  | 0.0       | 170.07 | 0.0  | 0.0        | 0.0  | 170.07      |
      | 4  | 30   | 20240503      |           | 337.18          | 167.13        | 2.94     | 0.0  | 0.0       | 170.07 | 0.0  | 0.0        | 0.0  | 170.07      |
      | 5  | 31   | 20240603     |           | 169.08          | 168.1         | 1.97     | 0.0  | 0.0       | 170.07 | 0.0  | 0.0        | 0.0  | 170.07      |
      | 6  | 30   | 20240703     |           | 0.0             | 169.08        | 0.99     | 0.0  | 0.0       | 170.07 | 0.0  | 0.0        | 0.0  | 170.07      |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid | In advance | Late | Outstanding |
      | 1000.0        | 20.42    | 0.0  | 0.0       | 1020.42 | 0.0  | 0.0        | 0.0  | 1020.42     |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type   | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20240103  | Disbursement       | 500.0  | 0.0       | 0.0      | 0.0  | 0.0       | 500.0        | false    |
      | 20240104  | Disbursement       | 200.0  | 0.0       | 0.0      | 0.0  | 0.0       | 700.0        | false    |
      | 20240104  | Capitalized Income | 300.0  | 300.0     | 0.0      | 0.0  | 0.0       | 1000.0       | false    |
    And Loan Transactions tab has a "CAPITALIZED_INCOME" transaction with date "20240104" which has the following Journal entries:
      | Type      | Account code | Account name                 | Debit  | Credit |
      | ASSET     | 112601       | Loans Receivable             | 300.0  |        |
      | LIABILITY | 145024       | Deferred Capitalized Income  |        | 300.0  |

    When Loan Pay-off is made on "20240104"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C3720
  Scenario: Verify capitalized income amount with disbursement amount calculation within approved amount for multidisbursal loan - UC8
    When Admin sets the business date to "20240101"
    And Admin creates a client with random data
    And Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                                     | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_EMI_360_30_INTEREST_RECALC_DAILY_MULTIDISBURSAL_CAPITALIZED_INCOME | 20240101   | 1000           | 7                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 6                 | MONTHS                | 1              | MONTHS                 | 6                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240101" with "1000" amount and expected disbursement date on "20240101"
    And Admin successfully disburse the loan on "20240101" with "700" EUR transaction amount
    Then Loan status will be "ACTIVE"
    When Admin sets the business date to "20240102"
    And Admin adds capitalized income with "AUTOPAY" payment type to the loan on "20240102" with "200" EUR transaction amount
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      |    |      | 20240101  |           | 700.0           |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      |    |      | 20240102  |           | 200.0           |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      | 1  | 31   | 20240201 |           | 752.14          | 147.86        | 5.21     | 0.0  | 0.0       | 153.07 | 0.0  | 0.0        | 0.0  | 153.07      |
      | 2  | 29   | 20240301    |           | 603.46          | 148.68        | 4.39     | 0.0  | 0.0       | 153.07 | 0.0  | 0.0        | 0.0  | 153.07      |
      | 3  | 31   | 20240401    |           | 453.91          | 149.55        | 3.52     | 0.0  | 0.0       | 153.07 | 0.0  | 0.0        | 0.0  | 153.07      |
      | 4  | 30   | 20240501      |           | 303.49          | 150.42        | 2.65     | 0.0  | 0.0       | 153.07 | 0.0  | 0.0        | 0.0  | 153.07      |
      | 5  | 31   | 20240601     |           | 152.19          | 151.3         | 1.77     | 0.0  | 0.0       | 153.07 | 0.0  | 0.0        | 0.0  | 153.07      |
      | 6  | 30   | 20240701     |           | 0.0             | 152.19        | 0.89     | 0.0  | 0.0       | 153.08 | 0.0  | 0.0        | 0.0  | 153.08      |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid | In advance | Late | Outstanding |
      | 900.0         | 18.43    | 0.0  | 0.0       | 918.43  | 0.0  | 0.0        | 0.0  | 918.43      |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type   | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20240101  | Disbursement       | 700.0  | 0.0       | 0.0      | 0.0  | 0.0       | 700.0        | false    |
      | 20240102  | Capitalized Income | 200.0  | 200.0     | 0.0      | 0.0  | 0.0       | 900.0        | false    |
    And Loan Transactions tab has a "CAPITALIZED_INCOME" transaction with date "20240102" which has the following Journal entries:
      | Type      | Account code | Account name                 | Debit  | Credit |
      | ASSET     | 112601       | Loans Receivable             | 200.0  |        |
      | LIABILITY | 145024       | Deferred Capitalized Income  |        | 200.0  |
    Then Admin fails to disburse the loan on "20240102" with "200" EUR transaction amount due to exceed approved amount
    Then Capitalized income with payment type "AUTOPAY" on "20240102" is forbidden with amount "200" while exceed approved amount

    When Loan Pay-off is made on "20240102"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C3721
  Scenario: Verify capitalized income amount with disbursement amount calculation within approved amount for multidisbursal loan with undo last disbursal - UC9
    When Admin sets the business date to "20240101"
    And Admin creates a client with random data
    And Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                                     | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_EMI_360_30_INTEREST_RECALC_DAILY_MULTIDISBURSAL_CAPITALIZED_INCOME | 20240101   | 1000           | 7                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 6                 | MONTHS                | 1              | MONTHS                 | 6                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240101" with "1000" amount and expected disbursement date on "20240101"
    And Admin successfully disburse the loan on "20240101" with "500" EUR transaction amount
    Then Loan status will be "ACTIVE"
    When Admin sets the business date to "20240102"
    And Admin adds capitalized income with "AUTOPAY" payment type to the loan on "20240102" with "150" EUR transaction amount
    When Admin sets the business date to "20240103"
    And Admin successfully disburse the loan on "20240103" with "250" EUR transaction amount
    And Admin adds capitalized income with "AUTOPAY" payment type to the loan on "20240103" with "50" EUR transaction amount
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      |    |      | 20240101  |           | 500.0           |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      |    |      | 20240102  |           | 150.0           |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      |    |      | 20240103  |           | 250.0           |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      |    |      | 20240103  |           |  50.0           |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      | 1  | 31   | 20240201 |           | 793.84          | 156.16        | 5.4      | 0.0  | 0.0       | 161.56 | 0.0  | 0.0        | 0.0  | 161.56      |
      | 2  | 29   | 20240301    |           | 636.91          | 156.93        | 4.63     | 0.0  | 0.0       | 161.56 | 0.0  | 0.0        | 0.0  | 161.56      |
      | 3  | 31   | 20240401    |           | 479.07          | 157.84        | 3.72     | 0.0  | 0.0       | 161.56 | 0.0  | 0.0        | 0.0  | 161.56      |
      | 4  | 30   | 20240501      |           | 320.3           | 158.77        | 2.79     | 0.0  | 0.0       | 161.56 | 0.0  | 0.0        | 0.0  | 161.56      |
      | 5  | 31   | 20240601     |           | 160.61          | 159.69        | 1.87     | 0.0  | 0.0       | 161.56 | 0.0  | 0.0        | 0.0  | 161.56      |
      | 6  | 30   | 20240701     |           | 0.0             | 160.61        | 0.94     | 0.0  | 0.0       | 161.55 | 0.0  | 0.0        | 0.0  | 161.55      |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid | In advance | Late | Outstanding |
      | 950.0         | 19.35    | 0.0  | 0.0       | 969.35  | 0.0  | 0.0        | 0.0  | 969.35      |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type   | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20240101  | Disbursement       | 500.0  | 0.0       | 0.0      | 0.0  | 0.0       | 500.0        | false    |
      | 20240102  | Capitalized Income | 150.0  | 150.0     | 0.0      | 0.0  | 0.0       | 650.0        | false    |
      | 20240103  | Disbursement       | 250.0  | 0.0       | 0.0      | 0.0  | 0.0       | 900.0        | false    |
      | 20240103  | Capitalized Income | 50.0   | 50.0      | 0.0      | 0.0  | 0.0       | 950.0        | false    |
    And Loan Transactions tab has a "CAPITALIZED_INCOME" transaction with date "20240102" which has the following Journal entries:
      | Type      | Account code | Account name                 | Debit  | Credit |
      | ASSET     | 112601       | Loans Receivable             | 150.0  |        |
      | LIABILITY | 145024       | Deferred Capitalized Income  |        | 150.0  |
    Then Admin fails to disburse the loan on "20240103" with "100" EUR transaction amount due to exceed approved amount
    Then Capitalized income with payment type "AUTOPAY" on "20240103" is forbidden with amount "100" while exceed approved amount
# --- undo last disbursement --- #
    And Admin sets the business date to "20240104"
    When Admin successfully undo last disbursal
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type   | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20240101  | Disbursement       | 500.0  | 0.0       | 0.0      | 0.0  | 0.0       | 500.0        | false    |
      | 20240102  | Capitalized Income | 150.0  | 150.0     | 0.0      | 0.0  | 0.0       | 650.0        | false    |
      | 20240103  | Capitalized Income | 50.0   | 50.0      | 0.0      | 0.0  | 0.0       | 700.0        | false    |
    And Admin successfully disburse the loan on "20240104" with "100" EUR transaction amount
    And Admin adds capitalized income with "AUTOPAY" payment type to the loan on "20240104" with "100" EUR transaction amount
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      |    |      | 20240101  |           | 500.0           |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      |    |      | 20240102  |           | 150.0           |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      |    |      | 20240103  |           |  50.0           |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      |    |      | 20240104  |           | 100.0           |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      |    |      | 20240104  |           | 100.0           |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      | 1  | 31   | 20240201 |           | 752.04          | 147.96        | 5.09     | 0.0  | 0.0       | 153.05 | 0.0  | 0.0        | 0.0  | 153.05      |
      | 2  | 29   | 20240301    |           | 603.38          | 148.66        | 4.39     | 0.0  | 0.0       | 153.05 | 0.0  | 0.0        | 0.0  | 153.05      |
      | 3  | 31   | 20240401    |           | 453.85          | 149.53        | 3.52     | 0.0  | 0.0       | 153.05 | 0.0  | 0.0        | 0.0  | 153.05      |
      | 4  | 30   | 20240501      |           | 303.45          | 150.4         | 2.65     | 0.0  | 0.0       | 153.05 | 0.0  | 0.0        | 0.0  | 153.05      |
      | 5  | 31   | 20240601     |           | 152.17          | 151.28        | 1.77     | 0.0  | 0.0       | 153.05 | 0.0  | 0.0        | 0.0  | 153.05      |
      | 6  | 30   | 20240701     |           | 0.0             | 152.17        | 0.89     | 0.0  | 0.0       | 153.06 | 0.0  | 0.0        | 0.0  | 153.06      |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid | In advance | Late | Outstanding |
      | 900.0         | 18.31    | 0.0  | 0.0       | 918.31  | 0.0  | 0.0        | 0.0  | 918.31      |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type   | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20240101  | Disbursement       | 500.0  | 0.0       | 0.0      | 0.0  | 0.0       | 500.0        | false    |
      | 20240102  | Capitalized Income | 150.0  | 150.0     | 0.0      | 0.0  | 0.0       | 650.0        | false    |
      | 20240103  | Capitalized Income | 50.0   | 50.0      | 0.0      | 0.0  | 0.0       | 700.0        | false    |
      | 20240104  | Disbursement       | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 800.0        | false    |
      | 20240104  | Capitalized Income | 100.0  | 100.0     | 0.0      | 0.0  | 0.0       | 900.0        | false    |
    Then Admin fails to disburse the loan on "20240104" with "200" EUR transaction amount due to exceed approved amount
    Then Capitalized income with payment type "AUTOPAY" on "20240104" is forbidden with amount "200" while exceed approved amount

    When Loan Pay-off is made on "20240104"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C3723
  Scenario: Verify capitalized income with disbursement amount calculation within approved amount for multidisbursal loan with undo capitalized income - UC10
    When Admin sets the business date to "20240101"
    And Admin creates a client with random data
    And Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                                     | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_EMI_360_30_INTEREST_RECALC_DAILY_MULTIDISBURSAL_CAPITALIZED_INCOME | 20240101   | 1000           | 7                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 6                 | MONTHS                | 1              | MONTHS                 | 6                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240101" with "1000" amount and expected disbursement date on "20240101"
    And Admin successfully disburse the loan on "20240101" with "500" EUR transaction amount
    Then Loan status will be "ACTIVE"
    When Admin sets the business date to "20240102"
    And Admin adds capitalized income with "AUTOPAY" payment type to the loan on "20240102" with "150" EUR transaction amount
    When Admin sets the business date to "20240103"
    And Admin successfully disburse the loan on "20240103" with "250" EUR transaction amount
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      |    |      | 20240101  |           | 500.0           |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      |    |      | 20240102  |           | 150.0           |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      |    |      | 20240103  |           | 250.0           |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      | 1  | 31   | 20240201 |           | 752.07          | 147.93        | 5.13     | 0.0  | 0.0       | 153.06 | 0.0  | 0.0        | 0.0  | 153.06      |
      | 2  | 29   | 20240301    |           | 603.4           | 148.67        | 4.39     | 0.0  | 0.0       | 153.06 | 0.0  | 0.0        | 0.0  | 153.06      |
      | 3  | 31   | 20240401    |           | 453.86          | 149.54        | 3.52     | 0.0  | 0.0       | 153.06 | 0.0  | 0.0        | 0.0  | 153.06      |
      | 4  | 30   | 20240501      |           | 303.45          | 150.41        | 2.65     | 0.0  | 0.0       | 153.06 | 0.0  | 0.0        | 0.0  | 153.06      |
      | 5  | 31   | 20240601     |           | 152.16          | 151.29        | 1.77     | 0.0  | 0.0       | 153.06 | 0.0  | 0.0        | 0.0  | 153.06      |
      | 6  | 30   | 20240701     |           | 0.0             | 152.16        | 0.89     | 0.0  | 0.0       | 153.05 | 0.0  | 0.0        | 0.0  | 153.05      |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid | In advance | Late | Outstanding |
      | 900.0         | 18.35    | 0.0  | 0.0       | 918.35  | 0.0  | 0.0        | 0.0  | 918.35      |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type   | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20240101  | Disbursement       | 500.0  | 0.0       | 0.0      | 0.0  | 0.0       | 500.0        | false    |
      | 20240102  | Capitalized Income | 150.0  | 150.0     | 0.0      | 0.0  | 0.0       | 650.0        | false    |
      | 20240103  | Disbursement       | 250.0  | 0.0       | 0.0      | 0.0  | 0.0       | 900.0        | false    |
    And Loan Transactions tab has a "CAPITALIZED_INCOME" transaction with date "20240102" which has the following Journal entries:
      | Type      | Account code | Account name                 | Debit  | Credit |
      | ASSET     | 112601       | Loans Receivable             | 150.0  |        |
      | LIABILITY | 145024       | Deferred Capitalized Income  |        | 150.0  |
    And Deferred Capitalized Income by external-id contains the following data:
      | Amount | Amortized Amount | Unrecognized Amount | Adjusted Amount | Charged Off Amount |
      | 150.0  | 0.0              | 150.0               | 0.0             | 0.0                |
    Then Admin fails to disburse the loan on "20240102" with "200" EUR transaction amount due to exceed approved amount
    Then Capitalized income with payment type "AUTOPAY" on "20240102" is forbidden with amount "200" while exceed approved amount
    And Admin sets the business date to "20240104"
# -- undo last disbursal -- #
    When Admin successfully undo last disbursal
# -- undo capitalized income -- #
    When Customer undo "1"th "Capitalized Income" transaction made on "20240102"
    And Admin successfully disburse the loan on "20240104" with "200" EUR transaction amount
    And Admin adds capitalized income with "AUTOPAY" payment type to the loan on "20240104" with "200" EUR transaction amount
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      |    |      | 20240101  |           | 500.0           |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      |    |      | 20240104  |           | 200.0           |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      |    |      | 20240104  |           | 200.0           |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      | 1  | 31   | 20240201 |           | 751.98          | 148.02        | 5.02     | 0.0  | 0.0       | 153.04 | 0.0  | 0.0        | 0.0  | 153.04      |
      | 2  | 29   | 20240301    |           | 603.33          | 148.65        | 4.39     | 0.0  | 0.0       | 153.04 | 0.0  | 0.0        | 0.0  | 153.04      |
      | 3  | 31   | 20240401    |           | 453.81          | 149.52        | 3.52     | 0.0  | 0.0       | 153.04 | 0.0  | 0.0        | 0.0  | 153.04      |
      | 4  | 30   | 20240501      |           | 303.42          | 150.39        | 2.65     | 0.0  | 0.0       | 153.04 | 0.0  | 0.0        | 0.0  | 153.04      |
      | 5  | 31   | 20240601     |           | 152.15          | 151.27        | 1.77     | 0.0  | 0.0       | 153.04 | 0.0  | 0.0        | 0.0  | 153.04      |
      | 6  | 30   | 20240701     |           | 0.0             | 152.15        | 0.89     | 0.0  | 0.0       | 153.04 | 0.0  | 0.0        | 0.0  | 153.04      |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 900.0         | 18.24    | 0.0  | 0.0       | 918.24 | 0.0  | 0.0        | 0.0  | 918.24     |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type   | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Reverted |
      | 20240101  | Disbursement       | 500.0  | 0.0       | 0.0      | 0.0  | 0.0       | 500.0        | false    | false    |
      | 20240102  | Capitalized Income | 150.0  | 150.0     | 0.0      | 0.0  | 0.0       | 650.0        | true     | true     |
      | 20240104  | Disbursement       | 200.0  | 0.0       | 0.0      | 0.0  | 0.0       | 700.0        | false    | false    |
      | 20240104  | Capitalized Income | 200.0  | 200.0     | 0.0      | 0.0  | 0.0       | 900.0        | false    | false    |
    And Deferred Capitalized Income by external-id contains the following data:
      | Amount | Amortized Amount | Unrecognized Amount | Adjusted Amount | Charged Off Amount |
      | 200.0  | 0.0              | 200.0               | 0.0             | 0.0                |
    Then Admin fails to disburse the loan on "20240104" with "300" EUR transaction amount due to exceed approved amount
    Then Capitalized income with payment type "AUTOPAY" on "20240104" is forbidden with amount "300" while exceed approved amount

    When Loan Pay-off is made on "20240104"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C3730
  Scenario: Verify capitalized income amount with disbursement amount calculation within approved over applied amount with percentage type for multidisbursal loan - UC11
    When Admin sets the business date to "20240101"
    And Admin creates a client with random data
    And Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                                         | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_RECALC_EMI_360_30_MULTIDISB_OVER_APPLIED_PERCENTAGE_CAPITALIZED_INCOME | 20240101   | 1000           | 7                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 6                 | MONTHS                | 1              | MONTHS                 | 6                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240101" with "1500" amount and expected disbursement date on "20240101"
    And Admin successfully disburse the loan on "20240101" with "1000" EUR transaction amount
    Then Loan status will be "ACTIVE"
    When Admin sets the business date to "20240102"
    And Admin adds capitalized income with "AUTOPAY" payment type to the loan on "20240102" with "200" EUR transaction amount
    And Admin successfully disburse the loan on "20240102" with "200" EUR transaction amount
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      |    |      | 20240101  |           | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      |    |      | 20240102  |           | 200.0           |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      |    |      | 20240102  |           | 200.0           |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      | 1  | 31   | 20240201 |           | 1169.98         | 230.02        | 8.09     | 0.0  | 0.0       | 238.11 | 0.0  | 0.0        | 0.0  | 238.11      |
      | 2  | 29   | 20240301    |           |  938.69         | 231.29        | 6.82     | 0.0  | 0.0       | 238.11 | 0.0  | 0.0        | 0.0  | 238.11      |
      | 3  | 31   | 20240401    |           |  706.06         | 232.63        | 5.48     | 0.0  | 0.0       | 238.11 | 0.0  | 0.0        | 0.0  | 238.11      |
      | 4  | 30   | 20240501      |           |  472.07         | 233.99        | 4.12     | 0.0  | 0.0       | 238.11 | 0.0  | 0.0        | 0.0  | 238.11      |
      | 5  | 31   | 20240601     |           |  236.71         | 235.36        | 2.75     | 0.0  | 0.0       | 238.11 | 0.0  | 0.0        | 0.0  | 238.11      |
      | 6  | 30   | 20240701     |           |    0.0          | 236.71        | 1.38     | 0.0  | 0.0       | 238.09 | 0.0  | 0.0        | 0.0  | 238.09      |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid | In advance | Late | Outstanding |
      | 1400.0        | 28.64    | 0.0  | 0.0       | 1428.64 | 0.0  | 0.0        | 0.0  | 1428.64     |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type   | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20240101  | Disbursement       | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       | false    |
      | 20240102  | Capitalized Income | 200.0  | 200.0     | 0.0      | 0.0  | 0.0       | 1200.0       | false    |
      | 20240102  | Disbursement       | 200.0  | 0.0       | 0.0      | 0.0  | 0.0       | 1400.0       | false    |
    And Loan Transactions tab has a "CAPITALIZED_INCOME" transaction with date "20240102" which has the following Journal entries:
      | Type      | Account code | Account name                 | Debit  | Credit |
      | ASSET     | 112601       | Loans Receivable             | 200.0  |        |
      | LIABILITY | 145024       | Deferred Capitalized Income  |        | 200.0  |
    Then Admin fails to disburse the loan on "20240102" with "200" EUR trn amount with total disb amount "1400" and max disb amount "1500" due to exceed max applied amount
    Then Capitalized income with payment type "AUTOPAY" on "20240102" is forbidden with amount "200" while exceed approved amount
    When Admin successfully undo disbursal
    Then Loan status will be "APPROVED"
    When Admin sets the business date to "20240103"
    And Admin successfully disburse the loan on "20240103" with "1000" EUR transaction amount
    And Admin sets the business date to "20240104"
    And Admin adds capitalized income with "AUTOPAY" payment type to the loan on "20240104" with "500" EUR transaction amount
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      |    |      | 20240103  |           | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      |    |      | 20240104  |           |  500.0          |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      | 1  | 31   | 20240203 |           | 1253.55         | 246.45        | 8.66     | 0.0  | 0.0       | 255.11 | 0.0  | 0.0        | 0.0  | 255.11      |
      | 2  | 29   | 20240303    |           | 1005.75         | 247.8         | 7.31     | 0.0  | 0.0       | 255.11 | 0.0  | 0.0        | 0.0  | 255.11      |
      | 3  | 31   | 20240403    |           |  756.51         | 249.24        | 5.87     | 0.0  | 0.0       | 255.11 | 0.0  | 0.0        | 0.0  | 255.11      |
      | 4  | 30   | 20240503      |           |  505.81         | 250.7         | 4.41     | 0.0  | 0.0       | 255.11 | 0.0  | 0.0        | 0.0  | 255.11      |
      | 5  | 31   | 20240603     |           |  253.65         | 252.16        | 2.95     | 0.0  | 0.0       | 255.11 | 0.0  | 0.0        | 0.0  | 255.11      |
      | 6  | 30   | 20240703     |           |     0.0         | 253.65        | 1.48     | 0.0  | 0.0       | 255.13 | 0.0  | 0.0        | 0.0  | 255.13      |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid | In advance | Late | Outstanding |
      | 1500.0        | 30.68    | 0.0  | 0.0       | 1530.68 | 0.0  | 0.0        | 0.0  | 1530.68     |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type   | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20240103  | Disbursement       | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       | false    |
      | 20240104  | Capitalized Income | 500.0  | 500.0     | 0.0      | 0.0  | 0.0       | 1500.0       | false    |
    Then Admin fails to disburse the loan on "20240104" with "100" EUR trn amount with total disb amount "1100" and max disb amount "1500" due to exceed max applied amount
    Then Capitalized income with payment type "AUTOPAY" on "20240104" is forbidden with amount "100" while exceed approved amount

    When Loan Pay-off is made on "20240104"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C3764
  Scenario: Verify capitalized income with disbursement amount within approved over applied amount with flat type with undo last disbursal for multidisbursal loan - UC12
    When Admin sets the business date to "20240101"
    And Admin creates a client with random data
    And Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                                   | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_RECALC_EMI_360_30_MULTIDISB_OVER_APPLIED_FLAT_CAPITALIZED_INCOME | 20240101   | 1000           | 7                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 6                 | MONTHS                | 1              | MONTHS                 | 6                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240101" with "1500" amount and expected disbursement date on "20240101"
    And Admin successfully disburse the loan on "20240101" with "1000" EUR transaction amount
    Then Loan status will be "ACTIVE"
    When Admin sets the business date to "20240102"
    And Admin adds capitalized income with "AUTOPAY" payment type to the loan on "20240102" with "200" EUR transaction amount
    And Admin successfully disburse the loan on "20240102" with "800" EUR transaction amount
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      |    |      | 20240101  |           | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      |    |      | 20240102  |           | 800.0           |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      |    |      | 20240102  |           | 200.0           |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      | 1  | 31   | 20240201 |           | 1671.34         | 328.66        | 11.48    | 0.0  | 0.0       | 340.14 | 0.0  | 0.0        | 0.0  | 340.14      |
      | 2  | 29   | 20240301    |           | 1340.95         | 330.39        |  9.75    | 0.0  | 0.0       | 340.14 | 0.0  | 0.0        | 0.0  | 340.14      |
      | 3  | 31   | 20240401    |           | 1008.63         | 332.32        |  7.82    | 0.0  | 0.0       | 340.14 | 0.0  | 0.0        | 0.0  | 340.14      |
      | 4  | 30   | 20240501      |           |  674.37         | 334.26        |  5.88    | 0.0  | 0.0       | 340.14 | 0.0  | 0.0        | 0.0  | 340.14      |
      | 5  | 31   | 20240601     |           |  338.16         | 336.21        |  3.93    | 0.0  | 0.0       | 340.14 | 0.0  | 0.0        | 0.0  | 340.14      |
      | 6  | 30   | 20240701     |           |    0.0          | 338.16        |  1.97    | 0.0  | 0.0       | 340.13 | 0.0  | 0.0        | 0.0  | 340.13      |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid | In advance | Late | Outstanding |
      | 2000.0        | 40.83    | 0.0  | 0.0       | 2040.83 | 0.0  | 0.0        | 0.0  | 2040.83     |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type   | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20240101  | Disbursement       | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       | false    |
      | 20240102  | Capitalized Income | 200.0  | 200.0     | 0.0      | 0.0  | 0.0       | 1200.0       | false    |
      | 20240102  | Disbursement       | 800.0  | 0.0       | 0.0      | 0.0  | 0.0       | 2000.0       | false    |
    And Loan Transactions tab has a "CAPITALIZED_INCOME" transaction with date "20240102" which has the following Journal entries:
      | Type      | Account code | Account name                 | Debit  | Credit |
      | ASSET     | 112601       | Loans Receivable             | 200.0  |        |
      | LIABILITY | 145024       | Deferred Capitalized Income  |        | 200.0  |
    Then Admin fails to disburse the loan on "20240102" with "200" EUR trn amount with total disb amount "2000" and max disb amount "2000" due to exceed max applied amount
    Then Capitalized income with payment type "AUTOPAY" on "20240102" is forbidden with amount "101" while exceed approved amount
    When Admin successfully undo last disbursal
    When Admin sets the business date to "20240103"
    And Admin successfully disburse the loan on "20240103" with "600" EUR transaction amount
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      |    |      | 20240101  |           | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      |    |      | 20240102  |           |  200.0          |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      |    |      | 20240103  |           |  600.0          |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      | 1  | 31   | 20240201 |           | 1504.13         | 295.87        | 10.24    | 0.0  | 0.0       | 306.11 | 0.0  | 0.0        | 0.0  | 306.11      |
      | 2  | 29   | 20240301    |           | 1206.79         | 297.34        |  8.77    | 0.0  | 0.0       | 306.11 | 0.0  | 0.0        | 0.0  | 306.11      |
      | 3  | 31   | 20240401    |           |  907.72         | 299.07        |  7.04    | 0.0  | 0.0       | 306.11 | 0.0  | 0.0        | 0.0  | 306.11      |
      | 4  | 30   | 20240501      |           |  606.91         | 300.81        |  5.3     | 0.0  | 0.0       | 306.11 | 0.0  | 0.0        | 0.0  | 306.11      |
      | 5  | 31   | 20240601     |           |  304.34         | 302.57        |  3.54    | 0.0  | 0.0       | 306.11 | 0.0  | 0.0        | 0.0  | 306.11      |
      | 6  | 30   | 20240701     |           |     0.0         | 304.34        |  1.78    | 0.0  | 0.0       | 306.12 | 0.0  | 0.0        | 0.0  | 306.12      |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid | In advance | Late | Outstanding |
      | 1800.0        | 36.67    | 0.0  | 0.0       | 1836.67 | 0.0  | 0.0        | 0.0  | 1836.67    |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type   | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20240101  | Disbursement       | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       | false    |
      | 20240102  | Capitalized Income | 200.0  | 200.0     | 0.0      | 0.0  | 0.0       | 1200.0       | false    |
      | 20240103  | Disbursement       | 600.0  | 0.0       | 0.0      | 0.0  | 0.0       | 1800.0       | false    |
     Then Admin fails to disburse the loan on "20240103" with "201" EUR trn amount with total disb amount "1801" and max disb amount "2000" due to exceed max applied amount
    Then Capitalized income with payment type "AUTOPAY" on "20240103" is forbidden with amount "300" while exceed approved amount

    When Loan Pay-off is made on "20240103"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C3765
  Scenario: Verify capitalized income with disbursement amount within approved over applied amount with percentage type with undo disbursal for single disbursal loan - UC13
    When Admin sets the business date to "20240101"
    And Admin creates a client with random data
    And Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                                        | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_RECALC_EMI_360_30_APPROVED_OVER_APPLIED_PERCENTAGE_CAPITALIZED_INCOME | 20240101   | 1000           | 7                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 6                 | MONTHS                | 1              | MONTHS                 | 6                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240101" with "1500" amount and expected disbursement date on "20240101"
    And Admin successfully disburse the loan on "20240101" with "1000" EUR transaction amount
    Then Loan status will be "ACTIVE"
    When Admin sets the business date to "20240102"
    And Admin adds capitalized income with "AUTOPAY" payment type to the loan on "20240102" with "400" EUR transaction amount
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      |    |      | 20240101  |           | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      |    |      | 20240102  |           | 400.0           |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      | 1  | 31   | 20240201 |           | 1169.98         | 230.02        | 8.09     | 0.0  | 0.0       | 238.11 | 0.0  | 0.0        | 0.0  | 238.11      |
      | 2  | 29   | 20240301    |           |  938.69         | 231.29        | 6.82     | 0.0  | 0.0       | 238.11 | 0.0  | 0.0        | 0.0  | 238.11      |
      | 3  | 31   | 20240401    |           |  706.06         | 232.63        | 5.48     | 0.0  | 0.0       | 238.11 | 0.0  | 0.0        | 0.0  | 238.11      |
      | 4  | 30   | 20240501      |           |  472.07         | 233.99        | 4.12     | 0.0  | 0.0       | 238.11 | 0.0  | 0.0        | 0.0  | 238.11      |
      | 5  | 31   | 20240601     |           |  236.71         | 235.36        | 2.75     | 0.0  | 0.0       | 238.11 | 0.0  | 0.0        | 0.0  | 238.11      |
      | 6  | 30   | 20240701     |           |    0.0          | 236.71        | 1.38     | 0.0  | 0.0       | 238.09 | 0.0  | 0.0        | 0.0  | 238.09      |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid | In advance | Late | Outstanding |
      | 1400.0        | 28.64    | 0.0  | 0.0       | 1428.64 | 0.0  | 0.0        | 0.0  | 1428.64     |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type   | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20240101  | Disbursement       | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       | false    |
      | 20240102  | Capitalized Income | 400.0  | 400.0     | 0.0      | 0.0  | 0.0       | 1400.0       | false    |
     And Loan Transactions tab has a "CAPITALIZED_INCOME" transaction with date "20240102" which has the following Journal entries:
      | Type      | Account code | Account name                 | Debit  | Credit |
      | ASSET     | 112601       | Loans Receivable             | 400.0  |        |
      | LIABILITY | 145024       | Deferred Capitalized Income  |        | 400.0  |
    Then Capitalized income with payment type "AUTOPAY" on "20240102" is forbidden with amount "200" while exceed approved amount
    When Admin successfully undo disbursal
    Then Loan status will be "APPROVED"
    When Admin sets the business date to "20240103"
    And Admin successfully disburse the loan on "20240103" with "1000" EUR transaction amount
    And Admin sets the business date to "20240104"
    And Admin adds capitalized income with "AUTOPAY" payment type to the loan on "20240104" with "500" EUR transaction amount
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      |    |      | 20240103  |           | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      |    |      | 20240104  |           |  500.0          |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      | 1  | 31   | 20240203 |           | 1253.55         | 246.45        | 8.66     | 0.0  | 0.0       | 255.11 | 0.0  | 0.0        | 0.0  | 255.11      |
      | 2  | 29   | 20240303    |           | 1005.75         | 247.8         | 7.31     | 0.0  | 0.0       | 255.11 | 0.0  | 0.0        | 0.0  | 255.11      |
      | 3  | 31   | 20240403    |           |  756.51         | 249.24        | 5.87     | 0.0  | 0.0       | 255.11 | 0.0  | 0.0        | 0.0  | 255.11      |
      | 4  | 30   | 20240503      |           |  505.81         | 250.7         | 4.41     | 0.0  | 0.0       | 255.11 | 0.0  | 0.0        | 0.0  | 255.11      |
      | 5  | 31   | 20240603     |           |  253.65         | 252.16        | 2.95     | 0.0  | 0.0       | 255.11 | 0.0  | 0.0        | 0.0  | 255.11      |
      | 6  | 30   | 20240703     |           |     0.0         | 253.65        | 1.48     | 0.0  | 0.0       | 255.13 | 0.0  | 0.0        | 0.0  | 255.13      |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid | In advance | Late | Outstanding |
      | 1500.0        | 30.68    | 0.0  | 0.0       | 1530.68 | 0.0  | 0.0        | 0.0  | 1530.68     |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type   | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20240103  | Disbursement       | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       | false    |
      | 20240104  | Capitalized Income | 500.0  | 500.0     | 0.0      | 0.0  | 0.0       | 1500.0       | false    |
    Then Capitalized income with payment type "AUTOPAY" on "20240104" is forbidden with amount "100" while exceed approved amount

    When Loan Pay-off is made on "20240104"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C3766
  Scenario: Verify capitalized income with adjustment amount with disbursement amount within approved over applied amount with flat type for single disbursal loan - UC14
    When Admin sets the business date to "20240101"
    And Admin creates a client with random data
    And Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                                  | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_RECALC_EMI_360_30_APPROVED_OVER_APPLIED_FLAT_CAPITALIZED_INCOME | 20240101   | 1000           | 7                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 6                 | MONTHS                | 1              | MONTHS                 | 6                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240101" with "2000" amount and expected disbursement date on "20240101"
    And Admin successfully disburse the loan on "20240101" with "1500" EUR transaction amount
    Then Loan status will be "ACTIVE"
    When Admin sets the business date to "20240102"
    And Admin runs inline COB job for Loan
    And Admin adds capitalized income with "AUTOPAY" payment type to the loan on "20240102" with "400" EUR transaction amount
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      |    |      | 20240101  |           | 1500.0          |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      |    |      | 20240102  |           |  400.0          |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      | 1  | 31   | 20240201 |           | 1587.86         | 312.14        | 11.01    | 0.0  | 0.0       | 323.15 | 0.0  | 0.0        | 0.0  | 323.15      |
      | 2  | 29   | 20240301    |           | 1273.97         | 313.89        |  9.26    | 0.0  | 0.0       | 323.15 | 0.0  | 0.0        | 0.0  | 323.15      |
      | 3  | 31   | 20240401    |           |  958.25         | 315.72        |  7.43    | 0.0  | 0.0       | 323.15 | 0.0  | 0.0        | 0.0  | 323.15      |
      | 4  | 30   | 20240501      |           |  640.69         | 317.56        |  5.59    | 0.0  | 0.0       | 323.15 | 0.0  | 0.0        | 0.0  | 323.15      |
      | 5  | 31   | 20240601     |           |  321.28         | 319.41        |  3.74    | 0.0  | 0.0       | 323.15 | 0.0  | 0.0        | 0.0  | 323.15      |
      | 6  | 30   | 20240701     |           |    0.0          | 321.28        |  1.87    | 0.0  | 0.0       | 323.15 | 0.0  | 0.0        | 0.0  | 323.15      |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid | In advance | Late | Outstanding |
      | 1900.0        | 38.9     | 0.0  | 0.0       | 1938.9  | 0.0  | 0.0        | 0.0  | 1938.9      |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type   | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20240101  | Disbursement       | 1500.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1500.0       | false    |
      | 20240102  | Capitalized Income | 400.0  | 400.0     | 0.0      | 0.0  | 0.0       | 1900.0       | false    |
    And Loan Transactions tab has a "CAPITALIZED_INCOME" transaction with date "20240102" which has the following Journal entries:
      | Type      | Account code | Account name                 | Debit  | Credit |
      | ASSET     | 112601       | Loans Receivable             | 400.0  |        |
      | LIABILITY | 145024       | Deferred Capitalized Income  |        | 400.0  |
    Then Capitalized income with payment type "AUTOPAY" on "20240102" is forbidden with amount "200" while exceed approved amount
    And Admin adds capitalized income adjustment with "AUTOPAY" payment type to the loan on "20240102" with "200" EUR transaction amount
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type                | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20240101  | Disbursement                    | 1500.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1500.0       | false    |
      | 20240102  | Capitalized Income              | 400.0  | 400.0     | 0.0      | 0.0  | 0.0       | 1900.0       | false    |
      | 20240102  | Capitalized Income Adjustment   | 200.0  | 200.0     | 0.0      | 0.0  | 0.0       | 1700.0       | false    |
    Then Capitalized income with payment type "AUTOPAY" on "20240102" is forbidden with amount "200" while exceed approved amount

    When Loan Pay-off is made on "20240102"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C3776
  Scenario: Verify capitalized income amount with disbursement amount calculation within approved over applied amount with percentage type for multidisbursal loan - UC15
    When Admin sets the business date to "20240101"
    And Admin creates a client with random data
    And Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                                         | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_RECALC_EMI_360_30_MULTIDISB_OVER_APPLIED_PERCENTAGE_CAPITALIZED_INCOME | 20240101   | 1000           | 7                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 6                 | MONTHS                | 1              | MONTHS                 | 6                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240101" with "1300" amount and expected disbursement date on "20240101"
    And Admin successfully disburse the loan on "20240101" with "1000" EUR transaction amount
    Then Loan status will be "ACTIVE"
    When Admin sets the business date to "20240102"
    And Admin adds capitalized income with "AUTOPAY" payment type to the loan on "20240102" with "400" EUR transaction amount
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      |    |      | 20240101  |           | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      |    |      | 20240102  |           | 400.0           |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      | 1  | 31   | 20240201 |           | 1169.98         | 230.02        | 8.09     | 0.0  | 0.0       | 238.11 | 0.0  | 0.0        | 0.0  | 238.11      |
      | 2  | 29   | 20240301    |           |  938.69         | 231.29        | 6.82     | 0.0  | 0.0       | 238.11 | 0.0  | 0.0        | 0.0  | 238.11      |
      | 3  | 31   | 20240401    |           |  706.06         | 232.63        | 5.48     | 0.0  | 0.0       | 238.11 | 0.0  | 0.0        | 0.0  | 238.11      |
      | 4  | 30   | 20240501      |           |  472.07         | 233.99        | 4.12     | 0.0  | 0.0       | 238.11 | 0.0  | 0.0        | 0.0  | 238.11      |
      | 5  | 31   | 20240601     |           |  236.71         | 235.36        | 2.75     | 0.0  | 0.0       | 238.11 | 0.0  | 0.0        | 0.0  | 238.11      |
      | 6  | 30   | 20240701     |           |    0.0          | 236.71        | 1.38     | 0.0  | 0.0       | 238.09 | 0.0  | 0.0        | 0.0  | 238.09      |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid | In advance | Late | Outstanding |
      | 1400.0        | 28.64    | 0.0  | 0.0       | 1428.64 | 0.0  | 0.0        | 0.0  | 1428.64     |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type   | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20240101  | Disbursement       | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       | false    |
      | 20240102  | Capitalized Income | 400.0  | 400.0     | 0.0      | 0.0  | 0.0       | 1400.0       | false    |
    And Loan Transactions tab has a "CAPITALIZED_INCOME" transaction with date "20240102" which has the following Journal entries:
      | Type      | Account code | Account name                 | Debit  | Credit |
      | ASSET     | 112601       | Loans Receivable             | 400.0  |        |
      | LIABILITY | 145024       | Deferred Capitalized Income  |        | 400.0  |
    Then Admin fails to disburse the loan on "20240102" with "200" EUR trn amount with total disb amount "1200" and max disb amount "1500" due to exceed max applied amount
    Then Capitalized income with payment type "AUTOPAY" on "20240102" is forbidden with amount "200" while exceed approved amount
    When Admin successfully undo disbursal
    Then Loan status will be "APPROVED"
    When Admin sets the business date to "20240103"
    And Admin successfully disburse the loan on "20240103" with "1000" EUR transaction amount
    And Admin sets the business date to "20240104"
    And Admin adds capitalized income with "AUTOPAY" payment type to the loan on "20240104" with "500" EUR transaction amount
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      |    |      | 20240103  |           | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      |    |      | 20240104  |           |  500.0          |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      | 1  | 31   | 20240203 |           | 1253.55         | 246.45        | 8.66     | 0.0  | 0.0       | 255.11 | 0.0  | 0.0        | 0.0  | 255.11      |
      | 2  | 29   | 20240303    |           | 1005.75         | 247.8         | 7.31     | 0.0  | 0.0       | 255.11 | 0.0  | 0.0        | 0.0  | 255.11      |
      | 3  | 31   | 20240403    |           |  756.51         | 249.24        | 5.87     | 0.0  | 0.0       | 255.11 | 0.0  | 0.0        | 0.0  | 255.11      |
      | 4  | 30   | 20240503      |           |  505.81         | 250.7         | 4.41     | 0.0  | 0.0       | 255.11 | 0.0  | 0.0        | 0.0  | 255.11      |
      | 5  | 31   | 20240603     |           |  253.65         | 252.16        | 2.95     | 0.0  | 0.0       | 255.11 | 0.0  | 0.0        | 0.0  | 255.11      |
      | 6  | 30   | 20240703     |           |     0.0         | 253.65        | 1.48     | 0.0  | 0.0       | 255.13 | 0.0  | 0.0        | 0.0  | 255.13      |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid | In advance | Late | Outstanding |
      | 1500.0        | 30.68    | 0.0  | 0.0       | 1530.68 | 0.0  | 0.0        | 0.0  | 1530.68     |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type   | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20240103  | Disbursement       | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       | false    |
      | 20240104  | Capitalized Income | 500.0  | 500.0     | 0.0      | 0.0  | 0.0       | 1500.0       | false    |
    Then Admin fails to disburse the loan on "20240104" with "100" EUR trn amount with total disb amount "1100" and max disb amount "1500" due to exceed max applied amount
    Then Capitalized income with payment type "AUTOPAY" on "20240104" is forbidden with amount "100" while exceed approved amount

    When Loan Pay-off is made on "20240104"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C3777
  Scenario: Verify capitalized income with disbursement amount within approved over applied amount with flat type with undo last disbursal for multidisbursal loan - UC16
    When Admin sets the business date to "20240101"
    And Admin creates a client with random data
    And Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                                   | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_RECALC_EMI_360_30_MULTIDISB_OVER_APPLIED_FLAT_CAPITALIZED_INCOME | 20240101   | 1000           | 7                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 6                 | MONTHS                | 1              | MONTHS                 | 6                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240101" with "1500" amount and expected disbursement date on "20240101"
    And Admin successfully disburse the loan on "20240101" with "1000" EUR transaction amount
    Then Loan status will be "ACTIVE"
    When Admin sets the business date to "20240102"
    And Admin adds capitalized income with "AUTOPAY" payment type to the loan on "20240102" with "600" EUR transaction amount
    And Admin successfully disburse the loan on "20240102" with "400" EUR transaction amount
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      |    |      | 20240101  |           | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      |    |      | 20240102  |           | 400.0           |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      |    |      | 20240102  |           | 600.0           |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      | 1  | 31   | 20240201 |           | 1671.34         | 328.66        | 11.48    | 0.0  | 0.0       | 340.14 | 0.0  | 0.0        | 0.0  | 340.14      |
      | 2  | 29   | 20240301    |           | 1340.95         | 330.39        |  9.75    | 0.0  | 0.0       | 340.14 | 0.0  | 0.0        | 0.0  | 340.14      |
      | 3  | 31   | 20240401    |           | 1008.63         | 332.32        |  7.82    | 0.0  | 0.0       | 340.14 | 0.0  | 0.0        | 0.0  | 340.14      |
      | 4  | 30   | 20240501      |           |  674.37         | 334.26        |  5.88    | 0.0  | 0.0       | 340.14 | 0.0  | 0.0        | 0.0  | 340.14      |
      | 5  | 31   | 20240601     |           |  338.16         | 336.21        |  3.93    | 0.0  | 0.0       | 340.14 | 0.0  | 0.0        | 0.0  | 340.14      |
      | 6  | 30   | 20240701     |           |    0.0          | 338.16        |  1.97    | 0.0  | 0.0       | 340.13 | 0.0  | 0.0        | 0.0  | 340.13      |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid | In advance | Late | Outstanding |
      | 2000.0        | 40.83    | 0.0  | 0.0       | 2040.83 | 0.0  | 0.0        | 0.0  | 2040.83     |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type   | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20240101  | Disbursement       | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       | false    |
      | 20240102  | Capitalized Income | 600.0  | 600.0     | 0.0      | 0.0  | 0.0       | 1600.0       | false    |
      | 20240102  | Disbursement       | 400.0  | 0.0       | 0.0      | 0.0  | 0.0       | 2000.0       | false    |
    And Loan Transactions tab has a "CAPITALIZED_INCOME" transaction with date "20240102" which has the following Journal entries:
      | Type      | Account code | Account name                 | Debit  | Credit |
      | ASSET     | 112601       | Loans Receivable             | 600.0  |        |
      | LIABILITY | 145024       | Deferred Capitalized Income  |        | 600.0  |
    Then Admin fails to disburse the loan on "20240102" with "200" EUR trn amount with total disb amount "1600" and max disb amount "2000" due to exceed max applied amount
    Then Capitalized income with payment type "AUTOPAY" on "20240102" is forbidden with amount "101" while exceed approved amount
    When Admin successfully undo last disbursal
    When Admin sets the business date to "20240103"
    And Admin adds capitalized income with "AUTOPAY" payment type to the loan on "20240103" with "200" EUR transaction amount
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      |    |      | 20240101  |           | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      |    |      | 20240102  |           |  600.0          |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      |    |      | 20240103  |           |  200.0          |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      | 1  | 31   | 20240201 |           | 1504.19         | 295.81        | 10.31    | 0.0  | 0.0       | 306.12 | 0.0  | 0.0        | 0.0  | 306.12      |
      | 2  | 29   | 20240301    |           | 1206.84         | 297.35        |  8.77    | 0.0  | 0.0       | 306.12 | 0.0  | 0.0        | 0.0  | 306.12      |
      | 3  | 31   | 20240401    |           |  907.76         | 299.08        |  7.04    | 0.0  | 0.0       | 306.12 | 0.0  | 0.0        | 0.0  | 306.12      |
      | 4  | 30   | 20240501      |           |  606.94         | 300.82        |  5.3     | 0.0  | 0.0       | 306.12 | 0.0  | 0.0        | 0.0  | 306.12      |
      | 5  | 31   | 20240601     |           |  304.36         | 302.58        |  3.54    | 0.0  | 0.0       | 306.12 | 0.0  | 0.0        | 0.0  | 306.12      |
      | 6  | 30   | 20240701     |           |     0.0         | 304.36        |  1.78    | 0.0  | 0.0       | 306.14 | 0.0  | 0.0        | 0.0  | 306.14      |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid | In advance | Late | Outstanding |
      | 1800.0        | 36.74    | 0.0  | 0.0       | 1836.74 | 0.0  | 0.0        | 0.0  | 1836.74    |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type   | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20240101  | Disbursement       | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       | false    |
      | 20240102  | Capitalized Income | 600.0  | 600.0     | 0.0      | 0.0  | 0.0       | 1600.0       | false    |
      | 20240103  | Capitalized Income | 200.0  | 200.0     | 0.0      | 0.0  | 0.0       | 1800.0       | false    |
    Then Admin fails to disburse the loan on "20240103" with "201" EUR trn amount with total disb amount "1201" and max disb amount "2000" due to exceed max applied amount
    Then Capitalized income with payment type "AUTOPAY" on "20240103" is forbidden with amount "300" while exceed approved amount

    When Loan Pay-off is made on "20240103"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C3778
  Scenario: Verify capitalized income with disbursement amount within approved over applied amount with percentage type with undo disbursal for single disbursal loan - UC17
    When Admin sets the business date to "20240101"
    And Admin creates a client with random data
    And Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                                        | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_RECALC_EMI_360_30_APPROVED_OVER_APPLIED_PERCENTAGE_CAPITALIZED_INCOME | 20240101   | 1000           | 7                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 6                 | MONTHS                | 1              | MONTHS                 | 6                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240101" with "1200" amount and expected disbursement date on "20240101"
    And Admin successfully disburse the loan on "20240101" with "1000" EUR transaction amount
    Then Loan status will be "ACTIVE"
    When Admin sets the business date to "20240102"
    And Admin adds capitalized income with "AUTOPAY" payment type to the loan on "20240102" with "400" EUR transaction amount
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      |    |      | 20240101  |           | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      |    |      | 20240102  |           | 400.0           |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      | 1  | 31   | 20240201 |           | 1169.98         | 230.02        | 8.09     | 0.0  | 0.0       | 238.11 | 0.0  | 0.0        | 0.0  | 238.11      |
      | 2  | 29   | 20240301    |           |  938.69         | 231.29        | 6.82     | 0.0  | 0.0       | 238.11 | 0.0  | 0.0        | 0.0  | 238.11      |
      | 3  | 31   | 20240401    |           |  706.06         | 232.63        | 5.48     | 0.0  | 0.0       | 238.11 | 0.0  | 0.0        | 0.0  | 238.11      |
      | 4  | 30   | 20240501      |           |  472.07         | 233.99        | 4.12     | 0.0  | 0.0       | 238.11 | 0.0  | 0.0        | 0.0  | 238.11      |
      | 5  | 31   | 20240601     |           |  236.71         | 235.36        | 2.75     | 0.0  | 0.0       | 238.11 | 0.0  | 0.0        | 0.0  | 238.11      |
      | 6  | 30   | 20240701     |           |    0.0          | 236.71        | 1.38     | 0.0  | 0.0       | 238.09 | 0.0  | 0.0        | 0.0  | 238.09      |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid | In advance | Late | Outstanding |
      | 1400.0        | 28.64    | 0.0  | 0.0       | 1428.64 | 0.0  | 0.0        | 0.0  | 1428.64     |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type   | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20240101  | Disbursement       | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       | false    |
      | 20240102  | Capitalized Income | 400.0  | 400.0     | 0.0      | 0.0  | 0.0       | 1400.0       | false    |
    And Loan Transactions tab has a "CAPITALIZED_INCOME" transaction with date "20240102" which has the following Journal entries:
      | Type      | Account code | Account name                 | Debit  | Credit |
      | ASSET     | 112601       | Loans Receivable             | 400.0  |        |
      | LIABILITY | 145024       | Deferred Capitalized Income  |        | 400.0  |
    Then Capitalized income with payment type "AUTOPAY" on "20240102" is forbidden with amount "200" while exceed approved amount
    When Admin successfully undo disbursal
    Then Loan status will be "APPROVED"
    When Admin sets the business date to "20240103"
    And Admin successfully disburse the loan on "20240103" with "1000" EUR transaction amount
    And Admin sets the business date to "20240104"
    And Admin adds capitalized income with "AUTOPAY" payment type to the loan on "20240104" with "500" EUR transaction amount
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      |    |      | 20240103  |           | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      |    |      | 20240104  |           |  500.0          |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      | 1  | 31   | 20240203 |           | 1253.55         | 246.45        | 8.66     | 0.0  | 0.0       | 255.11 | 0.0  | 0.0        | 0.0  | 255.11      |
      | 2  | 29   | 20240303    |           | 1005.75         | 247.8         | 7.31     | 0.0  | 0.0       | 255.11 | 0.0  | 0.0        | 0.0  | 255.11      |
      | 3  | 31   | 20240403    |           |  756.51         | 249.24        | 5.87     | 0.0  | 0.0       | 255.11 | 0.0  | 0.0        | 0.0  | 255.11      |
      | 4  | 30   | 20240503      |           |  505.81         | 250.7         | 4.41     | 0.0  | 0.0       | 255.11 | 0.0  | 0.0        | 0.0  | 255.11      |
      | 5  | 31   | 20240603     |           |  253.65         | 252.16        | 2.95     | 0.0  | 0.0       | 255.11 | 0.0  | 0.0        | 0.0  | 255.11      |
      | 6  | 30   | 20240703     |           |     0.0         | 253.65        | 1.48     | 0.0  | 0.0       | 255.13 | 0.0  | 0.0        | 0.0  | 255.13      |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid | In advance | Late | Outstanding |
      | 1500.0        | 30.68    | 0.0  | 0.0       | 1530.68 | 0.0  | 0.0        | 0.0  | 1530.68     |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type   | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20240103  | Disbursement       | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       | false    |
      | 20240104  | Capitalized Income | 500.0  | 500.0     | 0.0      | 0.0  | 0.0       | 1500.0       | false    |
    Then Capitalized income with payment type "AUTOPAY" on "20240104" is forbidden with amount "100" while exceed approved amount

    When Loan Pay-off is made on "20240104"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C3779
  Scenario: Verify capitalized income with adjustment amount with disbursement amount within approved over applied amount with flat type for single disbursal loan - UC18
    When Admin sets the business date to "20240101"
    And Admin creates a client with random data
    And Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                                  | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_RECALC_EMI_360_30_APPROVED_OVER_APPLIED_FLAT_CAPITALIZED_INCOME | 20240101   | 1000           | 7                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 6                 | MONTHS                | 1              | MONTHS                 | 6                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240101" with "1800" amount and expected disbursement date on "20240101"
    And Admin successfully disburse the loan on "20240101" with "1500" EUR transaction amount
    Then Loan status will be "ACTIVE"
    When Admin sets the business date to "20240102"
    And Admin runs inline COB job for Loan
    And Admin adds capitalized income with "AUTOPAY" payment type to the loan on "20240102" with "400" EUR transaction amount
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      |    |      | 20240101  |           | 1500.0          |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      |    |      | 20240102  |           |  400.0          |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      | 1  | 31   | 20240201 |           | 1587.86         | 312.14        | 11.01    | 0.0  | 0.0       | 323.15 | 0.0  | 0.0        | 0.0  | 323.15      |
      | 2  | 29   | 20240301    |           | 1273.97         | 313.89        |  9.26    | 0.0  | 0.0       | 323.15 | 0.0  | 0.0        | 0.0  | 323.15      |
      | 3  | 31   | 20240401    |           |  958.25         | 315.72        |  7.43    | 0.0  | 0.0       | 323.15 | 0.0  | 0.0        | 0.0  | 323.15      |
      | 4  | 30   | 20240501      |           |  640.69         | 317.56        |  5.59    | 0.0  | 0.0       | 323.15 | 0.0  | 0.0        | 0.0  | 323.15      |
      | 5  | 31   | 20240601     |           |  321.28         | 319.41        |  3.74    | 0.0  | 0.0       | 323.15 | 0.0  | 0.0        | 0.0  | 323.15      |
      | 6  | 30   | 20240701     |           |    0.0          | 321.28        |  1.87    | 0.0  | 0.0       | 323.15 | 0.0  | 0.0        | 0.0  | 323.15      |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid | In advance | Late | Outstanding |
      | 1900.0        | 38.9     | 0.0  | 0.0       | 1938.9  | 0.0  | 0.0        | 0.0  | 1938.9      |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type   | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20240101  | Disbursement       | 1500.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1500.0       | false    |
      | 20240102  | Capitalized Income | 400.0  | 400.0     | 0.0      | 0.0  | 0.0       | 1900.0       | false    |
    And Loan Transactions tab has a "CAPITALIZED_INCOME" transaction with date "20240102" which has the following Journal entries:
      | Type      | Account code | Account name                 | Debit  | Credit |
      | ASSET     | 112601       | Loans Receivable             | 400.0  |        |
      | LIABILITY | 145024       | Deferred Capitalized Income  |        | 400.0  |
    Then Capitalized income with payment type "AUTOPAY" on "20240102" is forbidden with amount "200" while exceed approved amount
    And Admin adds capitalized income adjustment with "AUTOPAY" payment type to the loan on "20240102" with "200" EUR transaction amount
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type                | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20240101  | Disbursement                    | 1500.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1500.0       | false    |
      | 20240102  | Capitalized Income              | 400.0  | 400.0     | 0.0      | 0.0  | 0.0       | 1900.0       | false    |
      | 20240102  | Capitalized Income Adjustment   | 200.0  | 200.0     | 0.0      | 0.0  | 0.0       | 1700.0       | false    |
    And Deferred Capitalized Income by external-id contains the following data:
      | Amount | Amortized Amount | Unrecognized Amount | Adjusted Amount | Charged Off Amount |
      | 400.0  | 0.0              | 200.0               | 200.0           | 0.0                |
    Then Capitalized income with payment type "AUTOPAY" on "20240102" is forbidden with amount "200" while exceed approved amount

    When Loan Pay-off is made on "20240102"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C3646
  Scenario: As a user I want to add capitalized income to a progressive loan after disbursement and then make a full repayment - amortization in case of loan close event
    When Admin sets the business date to "20240101"
    And Admin creates a client with random data
    And Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                      | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_EMI_360_30_INTEREST_RECALC_DAILY_CAPITALIZED_INCOME | 20240101   | 1000           | 7                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 1                 | MONTHS                | 1              | MONTHS                 | 1                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240101" with "1000" amount and expected disbursement date on "20240101"
    And Admin successfully disburse the loan on "20240101" with "900" EUR transaction amount
    Then Loan status will be "ACTIVE"
    When Admin sets the business date to "20240102"
    And Admin adds capitalized income with "AUTOPAY" payment type to the loan on "20240102" with "100" EUR transaction amount
    Then Loan Repayment schedule has 1 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due     | Paid | In advance | Late | Outstanding |
      |    |      | 20240101  |           | 900.0           |               |          | 0.0  |           | 0.0     | 0.0  |            |      |             |
      |    |      | 20240102  |           | 100.0           |               |          | 0.0  |           | 0.0     | 0.0  |            |      |             |
      | 1  | 31   | 20240201 |           | 0.0             | 1000.0        | 5.81     | 0.0  | 0.0       | 1005.81 | 0.0  | 0.0        | 0.0  | 1005.81     |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid | In advance | Late | Outstanding |
      | 1000.0        | 5.81     | 0.0  | 0.0       | 1005.81 | 0.0  | 0.0        | 0.0  | 1005.81     |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type   | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20240101  | Disbursement       | 900.0  | 0.0       | 0.0      | 0.0  | 0.0       | 900.0        | false    |
      | 20240102  | Capitalized Income | 100.0  | 100.0     | 0.0      | 0.0  | 0.0       | 1000.0       | false    |
    And Loan Transactions tab has a "CAPITALIZED_INCOME" transaction with date "20240102" which has the following Journal entries:
      | Type      | Account code | Account name                 | Debit  | Credit |
      | ASSET     | 112601       | Loans Receivable             | 100.0  |        |
      | LIABILITY | 145024       | Deferred Capitalized Income  |        | 100.0  |
    When Customer makes "REPAYMENT" transaction with "AUTOPAY" payment type on "20240102" with 1000.17 EUR transaction amount and system-generated Idempotency key
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met
    Then Loan Repayment schedule has 1 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due     | Paid    | In advance | Late | Outstanding |
      |    |      | 20240101  |                 | 900.0           |               |          | 0.0  |           | 0.0     | 0.0     |            |      |             |
      |    |      | 20240102  |                 | 100.0           |               |          | 0.0  |           | 0.0     | 0.0     |            |      |             |
      | 1  | 31   | 20240201 | 20240102 | 0.0             | 1000.0        | 0.17     | 0.0  | 0.0       | 1000.17 | 1000.17 | 1000.17    | 0.0  | 0.0         |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid    | In advance | Late | Outstanding |
      | 1000.0        | 0.17     | 0.0  | 0.0       | 1000.17 | 1000.17 | 1000.17    | 0.0  | 0.0         |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type                | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20240101  | Disbursement                    | 900.0  | 0.0       | 0.0      | 0.0  | 0.0       | 900.0        | false    |
      | 20240102  | Capitalized Income              | 100.0  | 100.0     | 0.0      | 0.0  | 0.0       | 1000.0       | false    |
      | 20240102  | Repayment                       | 1000.17| 1000.0    | 0.17     | 0.0  | 0.0       | 0.0          | false    |
      | 20240102  | Accrual                         | 0.17   | 0.0       | 0.17     | 0.0  | 0.0       | 0.0          | false    |
      | 20240102  | Capitalized Income Amortization | 100.0  | 0.0       | 100.0    | 0.0  | 0.0       | 0.0          | false    |
    And Loan Transactions tab has a "CAPITALIZED_INCOME_AMORTIZATION" transaction with date "20240102" which has the following Journal entries:
      | Type      | Account code | Account name                 | Debit  | Credit |
      | INCOME    | 404000       | Interest Income              |        | 100.0  |
      | LIABILITY | 145024       | Deferred Capitalized Income  | 100.0  |        |
    And Deferred Capitalized Income by external-id contains the following data:
      | Amount | Amortized Amount | Unrecognized Amount | Adjusted Amount | Charged Off Amount |
      | 100.0  | 100.0            | 0.0                 | 0.0             | 0.0                |
    And LoanCapitalizedIncomeAmortizationTransactionCreatedBusinessEvent is raised on "20240102"

  @TestRailId:C3647
  Scenario: As a user I want to add capitalized income to a progressive loan after disbursement and then overpay loan - amortization in case of loan close event
    When Admin sets the business date to "20240101"
    And Admin creates a client with random data
    And Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                      | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_EMI_360_30_INTEREST_RECALC_DAILY_CAPITALIZED_INCOME | 20240101   | 1000           | 7                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 1                 | MONTHS                | 1              | MONTHS                 | 1                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240101" with "1000" amount and expected disbursement date on "20240101"
    And Admin successfully disburse the loan on "20240101" with "900" EUR transaction amount
    Then Loan status will be "ACTIVE"
    When Admin sets the business date to "20240102"
    And Admin adds capitalized income with "AUTOPAY" payment type to the loan on "20240102" with "100" EUR transaction amount
    Then Loan Repayment schedule has 1 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due     | Paid | In advance | Late | Outstanding |
      |    |      | 20240101  |           | 900.0           |               |          | 0.0  |           | 0.0     | 0.0  |            |      |             |
      |    |      | 20240102  |           | 100.0           |               |          | 0.0  |           | 0.0     | 0.0  |            |      |             |
      | 1  | 31   | 20240201 |           | 0.0             | 1000.0        | 5.81     | 0.0  | 0.0       | 1005.81 | 0.0  | 0.0        | 0.0  | 1005.81     |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid | In advance | Late | Outstanding |
      | 1000.0        | 5.81     | 0.0  | 0.0       | 1005.81 | 0.0  | 0.0        | 0.0  | 1005.81     |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type   | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20240101  | Disbursement       | 900.0  | 0.0       | 0.0      | 0.0  | 0.0       | 900.0        | false    |
      | 20240102  | Capitalized Income | 100.0  | 100.0     | 0.0      | 0.0  | 0.0       | 1000.0       | false    |
    And Loan Transactions tab has a "CAPITALIZED_INCOME" transaction with date "20240102" which has the following Journal entries:
      | Type      | Account code | Account name                 | Debit  | Credit |
      | ASSET     | 112601       | Loans Receivable             | 100.0  |        |
      | LIABILITY | 145024       | Deferred Capitalized Income  |        | 100.0  |
    When Customer makes "REPAYMENT" transaction with "AUTOPAY" payment type on "20240102" with 1100 EUR transaction amount and system-generated Idempotency key
    Then Loan Repayment schedule has 1 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due     | Paid    | In advance | Late | Outstanding |
      |    |      | 20240101  |                 | 900.0           |               |          | 0.0  |           | 0.0     | 0.0     |            |      |             |
      |    |      | 20240102  |                 | 100.0           |               |          | 0.0  |           | 0.0     | 0.0     |            |      |             |
      | 1  | 31   | 20240201 | 20240102 | 0.0             | 1000.0        | 0.17     | 0.0  | 0.0       | 1000.17 | 1000.17 | 1000.17    | 0.0  | 0.0         |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid    | In advance | Late | Outstanding |
      | 1000.0        | 0.17     | 0.0  | 0.0       | 1000.17 | 1000.17 | 1000.17    | 0.0  | 0.0         |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type                | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20240101  | Disbursement                    | 900.0  | 0.0       | 0.0      | 0.0  | 0.0       | 900.0        | false    |
      | 20240102  | Capitalized Income              | 100.0  | 100.0     | 0.0      | 0.0  | 0.0       | 1000.0       | false    |
      | 20240102  | Repayment                       | 1100.0 | 1000.0    | 0.17     | 0.0  | 0.0       | 0.0          | false    |
      | 20240102  | Accrual                         | 0.17   | 0.0       | 0.17     | 0.0  | 0.0       | 0.0          | false    |
      | 20240102  | Capitalized Income Amortization | 100.0  | 0.0       | 100.0    | 0.0  | 0.0       | 0.0          | false    |
    And Loan Transactions tab has a "CAPITALIZED_INCOME_AMORTIZATION" transaction with date "20240102" which has the following Journal entries:
      | Type      | Account code | Account name                 | Debit  | Credit |
      | INCOME    | 404000       | Interest Income              |        | 100.0  |
      | LIABILITY | 145024       | Deferred Capitalized Income  | 100.0  |        |
    And LoanCapitalizedIncomeAmortizationTransactionCreatedBusinessEvent is raised on "20240102"

    When Admin makes Credit Balance Refund transaction on "20240102" with 99.83 EUR transaction amount
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C3651
  Scenario: As a user I want to add capitalized income to a progressive loan after disbursement and then write off loan - amortization in case of loan close event
    When Admin sets the business date to "20240101"
    And Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                      | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_EMI_360_30_INTEREST_RECALC_DAILY_CAPITALIZED_INCOME | 20240101   | 1000           | 7                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 1                 | MONTHS                | 1              | MONTHS                 | 1                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240101" with "1000" amount and expected disbursement date on "20240101"
    And Admin successfully disburse the loan on "20240101" with "900" EUR transaction amount
    Then Loan status will be "ACTIVE"
    When Admin sets the business date to "20240102"
    And Admin adds capitalized income with "AUTOPAY" payment type to the loan on "20240102" with "100" EUR transaction amount
    Then Loan Repayment schedule has 1 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due     | Paid | In advance | Late | Outstanding |
      |    |      | 20240101  |           | 900.0           |               |          | 0.0  |           | 0.0     | 0.0  |            |      |             |
      |    |      | 20240102  |           | 100.0           |               |          | 0.0  |           | 0.0     | 0.0  |            |      |             |
      | 1  | 31   | 20240201 |           | 0.0             | 1000.0        | 5.81     | 0.0  | 0.0       | 1005.81 | 0.0  | 0.0        | 0.0  | 1005.81     |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid | In advance | Late | Outstanding |
      | 1000.0        | 5.81     | 0.0  | 0.0       | 1005.81 | 0.0  | 0.0        | 0.0  | 1005.81     |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type   | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20240101  | Disbursement       | 900.0  | 0.0       | 0.0      | 0.0  | 0.0       | 900.0        | false    |
      | 20240102  | Capitalized Income | 100.0  | 100.0     | 0.0      | 0.0  | 0.0       | 1000.0       | false    |
    Then Loan Transactions tab has a "CAPITALIZED_INCOME" transaction with date "20240102" which has the following Journal entries:
      | Type      | Account code | Account name                 | Debit  | Credit |
      | ASSET     | 112601       | Loans Receivable             | 100.0  |        |
      | LIABILITY | 145024       | Deferred Capitalized Income  |        | 100.0  |
    And Admin does write-off the loan on "20240102"
    Then Loan status will be "CLOSED_WRITTEN_OFF"
    Then Loan Repayment schedule has 1 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due     | Paid | In advance | Late | Outstanding |
      |    |      | 20240101  |                 | 900.0           |               |          | 0.0  |           | 0.0     | 0.0  |            |      |             |
      |    |      | 20240102  |                 | 100.0           |               |          | 0.0  |           | 0.0     | 0.0  |            |      |             |
      | 1  | 31   | 20240201 | 20240102 | 0.0             | 1000.0        | 5.81     | 0.0  | 0.0       | 1005.81 | 0.0  | 0.0        | 0.0  | 0.0         |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid | In advance | Late | Outstanding |
      | 1000.0        | 5.81     | 0.0  | 0.0       | 1005.81 | 0.0  | 0.0        | 0.0  | 0.0         |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type                | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20240101  | Disbursement                    | 900.0  | 0.0       | 0.0      | 0.0  | 0.0       | 900.0        | false    |
      | 20240102  | Capitalized Income              | 100.0  | 100.0     | 0.0      | 0.0  | 0.0       | 1000.0       | false    |
      | 20240102  | Close (as written-off)          | 1005.81| 1000.0    | 5.81     | 0.0  | 0.0       | 0.0          | false    |
      | 20240102  | Capitalized Income Amortization | 100.0  | 0.0       | 100.0    | 0.0  | 0.0       | 0.0          | false    |
    Then Loan Transactions tab has a "CAPITALIZED_INCOME_AMORTIZATION" transaction with date "20240102" which has the following Journal entries:
      | Type      | Account code | Account name                 | Debit  | Credit |
      | EXPENSE   | e4           | Written off                  |        | 100.0  |
      | LIABILITY | 145024       | Deferred Capitalized Income  | 100.0  |        |
    Then LoanCapitalizedIncomeAmortizationTransactionCreatedBusinessEvent is raised on "20240102"

  @TestRailId:C3648
  Scenario: Verify capitalized income: daily amortization - Capitalized Income type: interest
    When Admin sets the business date to "20240101"
    And Admin creates a client with random data
    And Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                      | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_EMI_360_30_INTEREST_RECALC_DAILY_CAPITALIZED_INCOME | 20240101   | 200            | 0                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 3                 | MONTHS                | 1              | MONTHS                 | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240101" with "200" amount and expected disbursement date on "20240101"
    And Admin successfully disburse the loan on "20240101" with "100" EUR transaction amount
    And Admin adds capitalized income with "AUTOPAY" payment type to the loan on "20240101" with "50" EUR transaction amount
    Then Loan status will be "ACTIVE"
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due  | Paid | In advance | Late | Outstanding |
      |    |      | 20240101  |           | 100.0           |               |          | 0.0  |           | 0.0  | 0.0  |            |      |             |
      |    |      | 20240101  |           | 50.0            |               |          | 0.0  |           | 0.0  | 0.0  |            |      |             |
      | 1  | 31   | 20240201 |           | 100.0           | 50.0          | 0.0      | 0.0  | 0.0       | 50.0 | 0.0  | 0.0        | 0.0  | 50.0        |
      | 2  | 29   | 20240301    |           | 50.0            | 50.0          | 0.0      | 0.0  | 0.0       | 50.0 | 0.0  | 0.0        | 0.0  | 50.0        |
      | 3  | 31   | 20240401    |           | 0.0             | 50.0          | 0.0      | 0.0  | 0.0       | 50.0 | 0.0  | 0.0        | 0.0  | 50.0        |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      | 150.0         | 0.0      | 0.0  | 0.0       | 150.0 | 0.0  | 0.0        | 0.0  | 150.0       |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type   | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement       | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240101  | Capitalized Income | 50.0   | 50.0      | 0.0      | 0.0  | 0.0       | 150.0        | false    | false    |
    And Loan Transactions tab has a "CAPITALIZED_INCOME" transaction with date "20240101" which has the following Journal entries:
      | Type      | Account code | Account name                | Debit | Credit |
      | LIABILITY | 145024       | Deferred Capitalized Income |       | 50.0   |
      | ASSET     | 112601       | Loans Receivable            | 50.0  |        |
    When Admin sets the business date to "20240102"
    And Admin runs inline COB job for Loan
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due  | Paid | In advance | Late | Outstanding |
      |    |      | 20240101  |           | 100.0           |               |          | 0.0  |           | 0.0  | 0.0  |            |      |             |
      |    |      | 20240101  |           | 50.0            |               |          | 0.0  |           | 0.0  | 0.0  |            |      |             |
      | 1  | 31   | 20240201 |           | 100.0           | 50.0          | 0.0      | 0.0  | 0.0       | 50.0 | 0.0  | 0.0        | 0.0  | 50.0        |
      | 2  | 29   | 20240301    |           | 50.0            | 50.0          | 0.0      | 0.0  | 0.0       | 50.0 | 0.0  | 0.0        | 0.0  | 50.0        |
      | 3  | 31   | 20240401    |           | 0.0             | 50.0          | 0.0      | 0.0  | 0.0       | 50.0 | 0.0  | 0.0        | 0.0  | 50.0        |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      | 150.0         | 0.0      | 0.0  | 0.0       | 150.0 | 0.0  | 0.0        | 0.0  | 150.0       |
    And Admin sets the business date to "20240201"
    And Admin runs inline COB job for Loan
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due  | Paid | In advance | Late | Outstanding |
      |    |      | 20240101  |           | 100.0           |               |          | 0.0  |           | 0.0  | 0.0  |            |      |             |
      |    |      | 20240101  |           | 50.0            |               |          | 0.0  |           | 0.0  | 0.0  |            |      |             |
      | 1  | 31   | 20240201 |           | 100.0           | 50.0          | 0.0      | 0.0  | 0.0       | 50.0 | 0.0  | 0.0        | 0.0  | 50.0        |
      | 2  | 29   | 20240301    |           | 50.0            | 50.0          | 0.0      | 0.0  | 0.0       | 50.0 | 0.0  | 0.0        | 0.0  | 50.0        |
      | 3  | 31   | 20240401    |           | 0.0             | 50.0          | 0.0      | 0.0  | 0.0       | 50.0 | 0.0  | 0.0        | 0.0  | 50.0        |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      | 150.0         | 0.0      | 0.0  | 0.0       | 150.0 | 0.0  | 0.0        | 0.0  | 150.0       |
    When Admin sets the business date to "20240301"
    And Admin runs inline COB job for Loan
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due  | Paid | In advance | Late | Outstanding |
      |    |      | 20240101  |           | 100.0           |               |          | 0.0  |           | 0.0  | 0.0  |            |      |             |
      |    |      | 20240101  |           | 50.0            |               |          | 0.0  |           | 0.0  | 0.0  |            |      |             |
      | 1  | 31   | 20240201 |           | 100.0           | 50.0          | 0.0      | 0.0  | 0.0       | 50.0 | 0.0  | 0.0        | 0.0  | 50.0        |
      | 2  | 29   | 20240301    |           | 50.0            | 50.0          | 0.0      | 0.0  | 0.0       | 50.0 | 0.0  | 0.0        | 0.0  | 50.0        |
      | 3  | 31   | 20240401    |           | 0.0             | 50.0          | 0.0      | 0.0  | 0.0       | 50.0 | 0.0  | 0.0        | 0.0  | 50.0        |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      | 150.0         | 0.0      | 0.0  | 0.0       | 150.0 | 0.0  | 0.0        | 0.0  | 150.0       |
    And Admin sets the business date to "20240401"
    And Admin runs inline COB job for Loan
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due  | Paid | In advance | Late | Outstanding |
      |    |      | 20240101  |           | 100.0           |               |          | 0.0  |           | 0.0  | 0.0  |            |      |             |
      |    |      | 20240101  |           | 50.0            |               |          | 0.0  |           | 0.0  | 0.0  |            |      |             |
      | 1  | 31   | 20240201 |           | 100.0           | 50.0          | 0.0      | 0.0  | 0.0       | 50.0 | 0.0  | 0.0        | 0.0  | 50.0        |
      | 2  | 29   | 20240301    |           | 50.0            | 50.0          | 0.0      | 0.0  | 0.0       | 50.0 | 0.0  | 0.0        | 0.0  | 50.0        |
      | 3  | 31   | 20240401    |           | 0.0             | 50.0          | 0.0      | 0.0  | 0.0       | 50.0 | 0.0  | 0.0        | 0.0  | 50.0        |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      | 150.0         | 0.0      | 0.0  | 0.0       | 150.0 | 0.0  | 0.0        | 0.0  | 150.0       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type                | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement                    | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240101  | Capitalized Income              | 50.0   | 50.0      | 0.0      | 0.0  | 0.0       | 150.0        | false    | false    |
      | 20240101  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240102  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240103  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240104  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240105  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240106  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240107  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240108  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240109  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240110  | Capitalized Income Amortization | 0.54   | 0.0       | 0.54     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240111  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240112  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240113  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240114  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240115  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240116  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240117  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240118  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240119  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240120  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240121  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240122  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240123  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240124  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240125  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240126  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240127  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240128  | Capitalized Income Amortization | 0.54   | 0.0       | 0.54     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240129  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240130  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240131  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |

      | 20240201 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240202 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240203 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240204 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240205 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240206 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240207 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240208 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240209 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240210 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240211 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240212 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240213 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240214 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240215 | Capitalized Income Amortization | 0.54   | 0.0       | 0.54     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240216 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240217 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240218 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240219 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240220 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240221 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240222 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240223 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240224 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240225 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240226 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240227 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240228 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240229 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |

      | 20240301    | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240302    | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240303    | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240304    | Capitalized Income Amortization | 0.54   | 0.0       | 0.54     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240305    | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240306    | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240307    | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240308    | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240309    | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240310    | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240311    | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240312    | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240313    | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240314    | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240315    | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240316    | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240317    | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240318    | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240319    | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240320    | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240321    | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240322    | Capitalized Income Amortization | 0.54   | 0.0       | 0.54     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240323    | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240324    | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240325    | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240326    | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240327    | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240328    | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240329    | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240330    | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240331    | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
    And Loan Transactions tab has a "CAPITALIZED_INCOME_AMORTIZATION" transaction with date "20240101" which has the following Journal entries:
      | Type      | Account code | Account name                | Debit | Credit |
      | INCOME    | 404000       | Interest Income             |       | 0.55   |
      | LIABILITY | 145024       | Deferred Capitalized Income | 0.55  |        |
    And Deferred Capitalized Income by external-id contains the following data:
      | Amount | Amortized Amount | Unrecognized Amount | Adjusted Amount | Charged Off Amount |
      | 50.0   | 50.0             | 0.0                 | 0.0             | 0.0                |
    And Loan Capitalized Income Amortization Transaction Created Business Event is created on "20240331"

    When Loan Pay-off is made on "20240401"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C3649
  Scenario: Verify capitalized income: daily amortization - Capitalized Income type: fee
    When Admin sets the business date to "20240101"
    And Admin creates a client with random data
    And Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                          | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_EMI_360_30_INTEREST_RECALC_DAILY_CAPITALIZED_INCOME_FEE | 20240101   | 200            | 0                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 3                 | MONTHS                | 1              | MONTHS                 | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240101" with "200" amount and expected disbursement date on "20240101"
    And Admin successfully disburse the loan on "20240101" with "100" EUR transaction amount
    And Admin adds capitalized income with "AUTOPAY" payment type to the loan on "20240101" with "50" EUR transaction amount
    Then Loan status will be "ACTIVE"
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due  | Paid | In advance | Late | Outstanding |
      |    |      | 20240101  |           | 100.0           |               |          | 0.0  |           | 0.0  | 0.0  |            |      |             |
      |    |      | 20240101  |           | 50.0            |               |          | 0.0  |           | 0.0  | 0.0  |            |      |             |
      | 1  | 31   | 20240201 |           | 100.0           | 50.0          | 0.0      | 0.0  | 0.0       | 50.0 | 0.0  | 0.0        | 0.0  | 50.0        |
      | 2  | 29   | 20240301    |           | 50.0            | 50.0          | 0.0      | 0.0  | 0.0       | 50.0 | 0.0  | 0.0        | 0.0  | 50.0        |
      | 3  | 31   | 20240401    |           | 0.0             | 50.0          | 0.0      | 0.0  | 0.0       | 50.0 | 0.0  | 0.0        | 0.0  | 50.0        |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      | 150.0         | 0.0      | 0.0  | 0.0       | 150.0 | 0.0  | 0.0        | 0.0  | 150.0       |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type   | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement       | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240101  | Capitalized Income | 50.0   | 50.0      | 0.0      | 0.0  | 0.0       | 150.0        | false    | false    |
    And Loan Transactions tab has a "CAPITALIZED_INCOME" transaction with date "20240101" which has the following Journal entries:
      | Type      | Account code | Account name                | Debit | Credit |
      | LIABILITY | 145024       | Deferred Capitalized Income |       | 50.0   |
      | ASSET     | 112601       | Loans Receivable            | 50.0  |        |
    When Admin sets the business date to "20240102"
    And Admin runs inline COB job for Loan
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due  | Paid | In advance | Late | Outstanding |
      |    |      | 20240101  |           | 100.0           |               |          | 0.0  |           | 0.0  | 0.0  |            |      |             |
      |    |      | 20240101  |           | 50.0            |               |          | 0.0  |           | 0.0  | 0.0  |            |      |             |
      | 1  | 31   | 20240201 |           | 100.0           | 50.0          | 0.0      | 0.0  | 0.0       | 50.0 | 0.0  | 0.0        | 0.0  | 50.0        |
      | 2  | 29   | 20240301    |           | 50.0            | 50.0          | 0.0      | 0.0  | 0.0       | 50.0 | 0.0  | 0.0        | 0.0  | 50.0        |
      | 3  | 31   | 20240401    |           | 0.0             | 50.0          | 0.0      | 0.0  | 0.0       | 50.0 | 0.0  | 0.0        | 0.0  | 50.0        |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      | 150.0         | 0.0      | 0.0  | 0.0       | 150.0 | 0.0  | 0.0        | 0.0  | 150.0       |
    And Admin sets the business date to "20240201"
    And Admin runs inline COB job for Loan
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due  | Paid | In advance | Late | Outstanding |
      |    |      | 20240101  |           | 100.0           |               |          | 0.0  |           | 0.0  | 0.0  |            |      |             |
      |    |      | 20240101  |           | 50.0            |               |          | 0.0  |           | 0.0  | 0.0  |            |      |             |
      | 1  | 31   | 20240201 |           | 100.0           | 50.0          | 0.0      | 0.0  | 0.0       | 50.0 | 0.0  | 0.0        | 0.0  | 50.0        |
      | 2  | 29   | 20240301    |           | 50.0            | 50.0          | 0.0      | 0.0  | 0.0       | 50.0 | 0.0  | 0.0        | 0.0  | 50.0        |
      | 3  | 31   | 20240401    |           | 0.0             | 50.0          | 0.0      | 0.0  | 0.0       | 50.0 | 0.0  | 0.0        | 0.0  | 50.0        |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      | 150.0         | 0.0      | 0.0  | 0.0       | 150.0 | 0.0  | 0.0        | 0.0  | 150.0       |
    When Admin sets the business date to "20240301"
    And Admin runs inline COB job for Loan
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due  | Paid | In advance | Late | Outstanding |
      |    |      | 20240101  |           | 100.0           |               |          | 0.0  |           | 0.0  | 0.0  |            |      |             |
      |    |      | 20240101  |           | 50.0            |               |          | 0.0  |           | 0.0  | 0.0  |            |      |             |
      | 1  | 31   | 20240201 |           | 100.0           | 50.0          | 0.0      | 0.0  | 0.0       | 50.0 | 0.0  | 0.0        | 0.0  | 50.0        |
      | 2  | 29   | 20240301    |           | 50.0            | 50.0          | 0.0      | 0.0  | 0.0       | 50.0 | 0.0  | 0.0        | 0.0  | 50.0        |
      | 3  | 31   | 20240401    |           | 0.0             | 50.0          | 0.0      | 0.0  | 0.0       | 50.0 | 0.0  | 0.0        | 0.0  | 50.0        |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      | 150.0         | 0.0      | 0.0  | 0.0       | 150.0 | 0.0  | 0.0        | 0.0  | 150.0       |
    And Admin sets the business date to "20240401"
    And Admin runs inline COB job for Loan
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due  | Paid | In advance | Late | Outstanding |
      |    |      | 20240101  |           | 100.0           |               |          | 0.0  |           | 0.0  | 0.0  |            |      |             |
      |    |      | 20240101  |           | 50.0            |               |          | 0.0  |           | 0.0  | 0.0  |            |      |             |
      | 1  | 31   | 20240201 |           | 100.0           | 50.0          | 0.0      | 0.0  | 0.0       | 50.0 | 0.0  | 0.0        | 0.0  | 50.0        |
      | 2  | 29   | 20240301    |           | 50.0            | 50.0          | 0.0      | 0.0  | 0.0       | 50.0 | 0.0  | 0.0        | 0.0  | 50.0        |
      | 3  | 31   | 20240401    |           | 0.0             | 50.0          | 0.0      | 0.0  | 0.0       | 50.0 | 0.0  | 0.0        | 0.0  | 50.0        |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      | 150.0         | 0.0      | 0.0  | 0.0       | 150.0 | 0.0  | 0.0        | 0.0  | 150.0       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type                | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement                    | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240101  | Capitalized Income              | 50.0   | 50.0      | 0.0      | 0.0  | 0.0       | 150.0        | false    | false    |
      | 20240101  | Capitalized Income Amortization | 0.55   | 0.0       | 0.0      | 0.55  | 0.0       | 0.0          | false    | false    |
      | 20240102  | Capitalized Income Amortization | 0.55   | 0.0       | 0.0      | 0.55  | 0.0       | 0.0          | false    | false    |
      | 20240103  | Capitalized Income Amortization | 0.55   | 0.0       | 0.0      | 0.55  | 0.0       | 0.0          | false    | false    |
      | 20240104  | Capitalized Income Amortization | 0.55   | 0.0       | 0.0      | 0.55  | 0.0       | 0.0          | false    | false    |
      | 20240105  | Capitalized Income Amortization | 0.55   | 0.0       | 0.0      | 0.55  | 0.0       | 0.0          | false    | false    |
      | 20240106  | Capitalized Income Amortization | 0.55   | 0.0       | 0.0      | 0.55  | 0.0       | 0.0          | false    | false    |
      | 20240107  | Capitalized Income Amortization | 0.55   | 0.0       | 0.0      | 0.55  | 0.0       | 0.0          | false    | false    |
      | 20240108  | Capitalized Income Amortization | 0.55   | 0.0       | 0.0      | 0.55  | 0.0       | 0.0          | false    | false    |
      | 20240109  | Capitalized Income Amortization | 0.55   | 0.0       | 0.0      | 0.55  | 0.0       | 0.0          | false    | false    |
      | 20240110  | Capitalized Income Amortization | 0.54   | 0.0       | 0.0      | 0.54  | 0.0       | 0.0          | false    | false    |
      | 20240111  | Capitalized Income Amortization | 0.55   | 0.0       | 0.0      | 0.55  | 0.0       | 0.0          | false    | false    |
      | 20240112  | Capitalized Income Amortization | 0.55   | 0.0       | 0.0      | 0.55  | 0.0       | 0.0          | false    | false    |
      | 20240113  | Capitalized Income Amortization | 0.55   | 0.0       | 0.0      | 0.55  | 0.0       | 0.0          | false    | false    |
      | 20240114  | Capitalized Income Amortization | 0.55   | 0.0       | 0.0      | 0.55  | 0.0       | 0.0          | false    | false    |
      | 20240115  | Capitalized Income Amortization | 0.55   | 0.0       | 0.0      | 0.55  | 0.0       | 0.0          | false    | false    |
      | 20240116  | Capitalized Income Amortization | 0.55   | 0.0       | 0.0      | 0.55  | 0.0       | 0.0          | false    | false    |
      | 20240117  | Capitalized Income Amortization | 0.55   | 0.0       | 0.0      | 0.55  | 0.0       | 0.0          | false    | false    |
      | 20240118  | Capitalized Income Amortization | 0.55   | 0.0       | 0.0      | 0.55  | 0.0       | 0.0          | false    | false    |
      | 20240119  | Capitalized Income Amortization | 0.55   | 0.0       | 0.0      | 0.55  | 0.0       | 0.0          | false    | false    |
      | 20240120  | Capitalized Income Amortization | 0.55   | 0.0       | 0.0      | 0.55  | 0.0       | 0.0          | false    | false    |
      | 20240121  | Capitalized Income Amortization | 0.55   | 0.0       | 0.0      | 0.55  | 0.0       | 0.0          | false    | false    |
      | 20240122  | Capitalized Income Amortization | 0.55   | 0.0       | 0.0      | 0.55  | 0.0       | 0.0          | false    | false    |
      | 20240123  | Capitalized Income Amortization | 0.55   | 0.0       | 0.0      | 0.55  | 0.0       | 0.0          | false    | false    |
      | 20240124  | Capitalized Income Amortization | 0.55   | 0.0       | 0.0      | 0.55  | 0.0       | 0.0          | false    | false    |
      | 20240125  | Capitalized Income Amortization | 0.55   | 0.0       | 0.0      | 0.55  | 0.0       | 0.0          | false    | false    |
      | 20240126  | Capitalized Income Amortization | 0.55   | 0.0       | 0.0      | 0.55  | 0.0       | 0.0          | false    | false    |
      | 20240127  | Capitalized Income Amortization | 0.55   | 0.0       | 0.0      | 0.55  | 0.0       | 0.0          | false    | false    |
      | 20240128  | Capitalized Income Amortization | 0.54   | 0.0       | 0.0      | 0.54  | 0.0       | 0.0          | false    | false    |
      | 20240129  | Capitalized Income Amortization | 0.55   | 0.0       | 0.0      | 0.55  | 0.0       | 0.0          | false    | false    |
      | 20240130  | Capitalized Income Amortization | 0.55   | 0.0       | 0.0      | 0.55  | 0.0       | 0.0          | false    | false    |
      | 20240131  | Capitalized Income Amortization | 0.55   | 0.0       | 0.0      | 0.55  | 0.0       | 0.0          | false    | false    |

      | 20240201 | Capitalized Income Amortization | 0.55   | 0.0       | 0.0      | 0.55  | 0.0       | 0.0          | false    | false    |
      | 20240202 | Capitalized Income Amortization | 0.55   | 0.0       | 0.0      | 0.55  | 0.0       | 0.0          | false    | false    |
      | 20240203 | Capitalized Income Amortization | 0.55   | 0.0       | 0.0      | 0.55  | 0.0       | 0.0          | false    | false    |
      | 20240204 | Capitalized Income Amortization | 0.55   | 0.0       | 0.0      | 0.55  | 0.0       | 0.0          | false    | false    |
      | 20240205 | Capitalized Income Amortization | 0.55   | 0.0       | 0.0      | 0.55  | 0.0       | 0.0          | false    | false    |
      | 20240206 | Capitalized Income Amortization | 0.55   | 0.0       | 0.0      | 0.55  | 0.0       | 0.0          | false    | false    |
      | 20240207 | Capitalized Income Amortization | 0.55   | 0.0       | 0.0      | 0.55  | 0.0       | 0.0          | false    | false    |
      | 20240208 | Capitalized Income Amortization | 0.55   | 0.0       | 0.0      | 0.55  | 0.0       | 0.0          | false    | false    |
      | 20240209 | Capitalized Income Amortization | 0.55   | 0.0       | 0.0      | 0.55  | 0.0       | 0.0          | false    | false    |
      | 20240210 | Capitalized Income Amortization | 0.55   | 0.0       | 0.0      | 0.55  | 0.0       | 0.0          | false    | false    |
      | 20240211 | Capitalized Income Amortization | 0.55   | 0.0       | 0.0      | 0.55  | 0.0       | 0.0          | false    | false    |
      | 20240212 | Capitalized Income Amortization | 0.55   | 0.0       | 0.0      | 0.55  | 0.0       | 0.0          | false    | false    |
      | 20240213 | Capitalized Income Amortization | 0.55   | 0.0       | 0.0      | 0.55  | 0.0       | 0.0          | false    | false    |
      | 20240214 | Capitalized Income Amortization | 0.55   | 0.0       | 0.0      | 0.55  | 0.0       | 0.0          | false    | false    |
      | 20240215 | Capitalized Income Amortization | 0.54   | 0.0       | 0.0      | 0.54  | 0.0       | 0.0          | false    | false    |
      | 20240216 | Capitalized Income Amortization | 0.55   | 0.0       | 0.0      | 0.55  | 0.0       | 0.0          | false    | false    |
      | 20240217 | Capitalized Income Amortization | 0.55   | 0.0       | 0.0      | 0.55  | 0.0       | 0.0          | false    | false    |
      | 20240218 | Capitalized Income Amortization | 0.55   | 0.0       | 0.0      | 0.55  | 0.0       | 0.0          | false    | false    |
      | 20240219 | Capitalized Income Amortization | 0.55   | 0.0       | 0.0      | 0.55  | 0.0       | 0.0          | false    | false    |
      | 20240220 | Capitalized Income Amortization | 0.55   | 0.0       | 0.0      | 0.55  | 0.0       | 0.0          | false    | false    |
      | 20240221 | Capitalized Income Amortization | 0.55   | 0.0       | 0.0      | 0.55  | 0.0       | 0.0          | false    | false    |
      | 20240222 | Capitalized Income Amortization | 0.55   | 0.0       | 0.0      | 0.55  | 0.0       | 0.0          | false    | false    |
      | 20240223 | Capitalized Income Amortization | 0.55   | 0.0       | 0.0      | 0.55  | 0.0       | 0.0          | false    | false    |
      | 20240224 | Capitalized Income Amortization | 0.55   | 0.0       | 0.0      | 0.55  | 0.0       | 0.0          | false    | false    |
      | 20240225 | Capitalized Income Amortization | 0.55   | 0.0       | 0.0      | 0.55  | 0.0       | 0.0          | false    | false    |
      | 20240226 | Capitalized Income Amortization | 0.55   | 0.0       | 0.0      | 0.55  | 0.0       | 0.0          | false    | false    |
      | 20240227 | Capitalized Income Amortization | 0.55   | 0.0       | 0.0      | 0.55  | 0.0       | 0.0          | false    | false    |
      | 20240228 | Capitalized Income Amortization | 0.55   | 0.0       | 0.0      | 0.55  | 0.0       | 0.0          | false    | false    |
      | 20240229 | Capitalized Income Amortization | 0.55   | 0.0       | 0.0      | 0.55  | 0.0       | 0.0          | false    | false    |

      | 20240301    | Capitalized Income Amortization | 0.55   | 0.0       | 0.0      | 0.55  | 0.0       | 0.0          | false    | false    |
      | 20240302    | Capitalized Income Amortization | 0.55   | 0.0       | 0.0      | 0.55  | 0.0       | 0.0          | false    | false    |
      | 20240303    | Capitalized Income Amortization | 0.55   | 0.0       | 0.0      | 0.55  | 0.0       | 0.0          | false    | false    |
      | 20240304    | Capitalized Income Amortization | 0.54   | 0.0       | 0.0      | 0.54  | 0.0       | 0.0          | false    | false    |
      | 20240305    | Capitalized Income Amortization | 0.55   | 0.0       | 0.0      | 0.55  | 0.0       | 0.0          | false    | false    |
      | 20240306    | Capitalized Income Amortization | 0.55   | 0.0       | 0.0      | 0.55  | 0.0       | 0.0          | false    | false    |
      | 20240307    | Capitalized Income Amortization | 0.55   | 0.0       | 0.0      | 0.55  | 0.0       | 0.0          | false    | false    |
      | 20240308    | Capitalized Income Amortization | 0.55   | 0.0       | 0.0      | 0.55  | 0.0       | 0.0          | false    | false    |
      | 20240309    | Capitalized Income Amortization | 0.55   | 0.0       | 0.0      | 0.55  | 0.0       | 0.0          | false    | false    |
      | 20240310    | Capitalized Income Amortization | 0.55   | 0.0       | 0.0      | 0.55  | 0.0       | 0.0          | false    | false    |
      | 20240311    | Capitalized Income Amortization | 0.55   | 0.0       | 0.0      | 0.55  | 0.0       | 0.0          | false    | false    |
      | 20240312    | Capitalized Income Amortization | 0.55   | 0.0       | 0.0      | 0.55  | 0.0       | 0.0          | false    | false    |
      | 20240313    | Capitalized Income Amortization | 0.55   | 0.0       | 0.0      | 0.55  | 0.0       | 0.0          | false    | false    |
      | 20240314    | Capitalized Income Amortization | 0.55   | 0.0       | 0.0      | 0.55  | 0.0       | 0.0          | false    | false    |
      | 20240315    | Capitalized Income Amortization | 0.55   | 0.0       | 0.0      | 0.55  | 0.0       | 0.0          | false    | false    |
      | 20240316    | Capitalized Income Amortization | 0.55   | 0.0       | 0.0      | 0.55  | 0.0       | 0.0          | false    | false    |
      | 20240317    | Capitalized Income Amortization | 0.55   | 0.0       | 0.0      | 0.55  | 0.0       | 0.0          | false    | false    |
      | 20240318    | Capitalized Income Amortization | 0.55   | 0.0       | 0.0      | 0.55  | 0.0       | 0.0          | false    | false    |
      | 20240319    | Capitalized Income Amortization | 0.55   | 0.0       | 0.0      | 0.55  | 0.0       | 0.0          | false    | false    |
      | 20240320    | Capitalized Income Amortization | 0.55   | 0.0       | 0.0      | 0.55  | 0.0       | 0.0          | false    | false    |
      | 20240321    | Capitalized Income Amortization | 0.55   | 0.0       | 0.0      | 0.55  | 0.0       | 0.0          | false    | false    |
      | 20240322    | Capitalized Income Amortization | 0.54   | 0.0       | 0.0      | 0.54  | 0.0       | 0.0          | false    | false    |
      | 20240323    | Capitalized Income Amortization | 0.55   | 0.0       | 0.0      | 0.55  | 0.0       | 0.0          | false    | false    |
      | 20240324    | Capitalized Income Amortization | 0.55   | 0.0       | 0.0      | 0.55  | 0.0       | 0.0          | false    | false    |
      | 20240325    | Capitalized Income Amortization | 0.55   | 0.0       | 0.0      | 0.55  | 0.0       | 0.0          | false    | false    |
      | 20240326    | Capitalized Income Amortization | 0.55   | 0.0       | 0.0      | 0.55  | 0.0       | 0.0          | false    | false    |
      | 20240327    | Capitalized Income Amortization | 0.55   | 0.0       | 0.0      | 0.55  | 0.0       | 0.0          | false    | false    |
      | 20240328    | Capitalized Income Amortization | 0.55   | 0.0       | 0.0      | 0.55  | 0.0       | 0.0          | false    | false    |
      | 20240329    | Capitalized Income Amortization | 0.55   | 0.0       | 0.0      | 0.55  | 0.0       | 0.0          | false    | false    |
      | 20240330    | Capitalized Income Amortization | 0.55   | 0.0       | 0.0      | 0.55  | 0.0       | 0.0          | false    | false    |
      | 20240331    | Capitalized Income Amortization | 0.55   | 0.0       | 0.0      | 0.55  | 0.0       | 0.0          | false    | false    |
    And Loan Transactions tab has a "CAPITALIZED_INCOME_AMORTIZATION" transaction with date "20240101" which has the following Journal entries:
      | Type      | Account code | Account name                | Debit | Credit |
      | INCOME    | 404000       | Interest Income             |       | 0.55   |
      | LIABILITY | 145024       | Deferred Capitalized Income | 0.55  |        |
    And Loan Capitalized Income Amortization Transaction Created Business Event is created on "20240331"

    When Loan Pay-off is made on "20240401"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C3661
  Scenario: As a user I want to add capitalized income to a progressive loan after disbursement and then charge-off the loan with "delinquent" reason - amortization in case of loan charge-off event
    When Admin sets the business date to "20240101"
    And Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                                 | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_ZERO_INTEREST_CHARGE_OFF_DELINQUENT_REASON_INTEREST_RECALC_CAPITALIZED_INCOME | 20240101   | 1000           | 7                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 1                 | MONTHS                | 1              | MONTHS                 | 1                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240101" with "1000" amount and expected disbursement date on "20240101"
    And Admin successfully disburse the loan on "20240101" with "900" EUR transaction amount
    Then Loan status will be "ACTIVE"
    When Admin sets the business date to "20240102"
    And Admin adds capitalized income with "AUTOPAY" payment type to the loan on "20240102" with "100" EUR transaction amount
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type   | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20240101  | Disbursement       | 900.0  | 0.0       | 0.0      | 0.0  | 0.0       | 900.0        | false    |
      | 20240102  | Capitalized Income | 100.0  | 100.0     | 0.0      | 0.0  | 0.0       | 1000.0       | false    |
    Then Loan Transactions tab has a "CAPITALIZED_INCOME" transaction with date "20240102" which has the following Journal entries:
      | Type      | Account code | Account name                 | Debit  | Credit |
      | ASSET     | 112601       | Loans Receivable             | 100.0  |        |
      | LIABILITY | 145024       | Deferred Capitalized Income  |        | 100.0  |
    Then Admin can successfully set Fraud flag to the loan
    When Admin sets the business date to "20240126"
    And Admin does charge-off the loan with reason "DELINQUENT" on "20240126"
    Then Loan Transactions tab has a "CHARGE_OFF" transaction with date "20240126" which has the following Journal entries:
      | Type    | Account code | Account name               | Debit | Credit |
      | ASSET   | 112601       | Loans Receivable           |       | 1000.0 |
      | ASSET   | 112603       | Interest/Fee Receivable    |       | 4.58   |
      | EXPENSE | 744007       | Credit Loss/Bad Debt       | 1000.0|        |
      | INCOME  | 404001       | Interest Income Charge Off | 4.58  |        |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type                | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20240101  | Disbursement                    | 900.0  | 0.0       | 0.0      | 0.0  | 0.0       | 900.0        | false    |
      | 20240102  | Capitalized Income              | 100.0  | 100.0     | 0.0      | 0.0  | 0.0       | 1000.0       | false    |
      | 20240126  | Capitalized Income Amortization | 83.33  | 0.0       | 83.33    | 0.0  | 0.0       | 0.0          | false    |
      | 20240126  | Accrual                         | 3.69   | 0.0       | 3.69     | 0.0  | 0.0       | 0.0          | false    |
      | 20240126  | Charge-off                      | 1004.58| 1000.0    | 4.58     | 0.0  | 0.0       | 0.0          | false    |
      | 20240126  | Capitalized Income Amortization | 16.67  | 0.0       | 16.67    | 0.0  | 0.0       | 0.0          | false    |
# --- check CIA journal entries for before and after charge-off trn processed --- #
    Then Loan Transactions tab has 2 a "CAPITALIZED_INCOME_AMORTIZATION" transactions with date "20240126" which has the following Journal entries:
      | Type      | Account code | Account name                 | Debit  | Credit |
      | INCOME    | 404000       | Interest Income              |        | 83.33  |
      | LIABILITY | 145024       | Deferred Capitalized Income  | 83.33  |        |
      | EXPENSE   | 744007       | Credit Loss/Bad Debt         |        | 16.67  |
      | LIABILITY | 145024       | Deferred Capitalized Income  | 16.67  |        |
    Then LoanCapitalizedIncomeAmortizationTransactionCreatedBusinessEvent is raised on "20240126"

    When Loan Pay-off is made on "20240126"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C3662
  Scenario: As a user I want to add capitalized income to a progressive loan after disbursement and then charge-off a fraud loan - amortization in case of loan charge-off event
    When Admin sets the business date to "20240101"
    And Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                                 | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_ZERO_INTEREST_CHARGE_OFF_DELINQUENT_REASON_INTEREST_RECALC_CAPITALIZED_INCOME | 20240101   | 1000           | 7                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 1                 | MONTHS                | 1              | MONTHS                 | 1                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240101" with "1000" amount and expected disbursement date on "20240101"
    And Admin successfully disburse the loan on "20240101" with "900" EUR transaction amount
    Then Loan status will be "ACTIVE"
    When Admin sets the business date to "20240102"
    And Admin adds capitalized income with "AUTOPAY" payment type to the loan on "20240102" with "100" EUR transaction amount
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type   | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20240101  | Disbursement       | 900.0  | 0.0       | 0.0      | 0.0  | 0.0       | 900.0        | false    |
      | 20240102  | Capitalized Income | 100.0  | 100.0     | 0.0      | 0.0  | 0.0       | 1000.0       | false    |
    Then Loan Transactions tab has a "CAPITALIZED_INCOME" transaction with date "20240102" which has the following Journal entries:
      | Type      | Account code | Account name                 | Debit  | Credit |
      | ASSET     | 112601       | Loans Receivable             | 100.0  |        |
      | LIABILITY | 145024       | Deferred Capitalized Income  |        | 100.0  |
    Then Admin can successfully set Fraud flag to the loan
    When Admin sets the business date to "20240126"
    And Admin does charge-off the loan on "20240126"
    Then Loan Transactions tab has a "CHARGE_OFF" transaction with date "20240126" which has the following Journal entries:
      | Type    | Account code | Account name               | Debit | Credit |
      | ASSET   | 112601       | Loans Receivable           |       | 1000.0 |
      | ASSET   | 112603       | Interest/Fee Receivable    |       | 4.58   |
      | EXPENSE | 744037       | Credit Loss/Bad Debt-Fraud | 1000.0|        |
      | INCOME  | 404001       | Interest Income Charge Off | 4.58  |        |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type                | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20240101  | Disbursement                    | 900.0  | 0.0       | 0.0      | 0.0  | 0.0       | 900.0        | false    |
      | 20240102  | Capitalized Income              | 100.0  | 100.0     | 0.0      | 0.0  | 0.0       | 1000.0       | false    |
      | 20240126  | Capitalized Income Amortization | 83.33  | 0.0       | 83.33    | 0.0  | 0.0       | 0.0          | false    |
      | 20240126  | Accrual                         | 3.69   | 0.0       | 3.69     | 0.0  | 0.0       | 0.0          | false    |
      | 20240126  | Charge-off                      | 1004.58| 1000.0    | 4.58     | 0.0  | 0.0       | 0.0          | false    |
      | 20240126  | Capitalized Income Amortization | 16.67  | 0.0       | 16.67    | 0.0  | 0.0       | 0.0          | false    |
# --- check CIA journal entries for before and after charge-off trn processed --- #
    Then Loan Transactions tab has 2 a "CAPITALIZED_INCOME_AMORTIZATION" transactions with date "20240126" which has the following Journal entries:
      | Type      | Account code | Account name                 | Debit  | Credit |
      | INCOME    | 404000       | Interest Income              |        | 83.33  |
      | LIABILITY | 145024       | Deferred Capitalized Income  | 83.33  |        |
      | EXPENSE   | 744037       | Credit Loss/Bad Debt-Fraud   |        | 16.67  |
      | LIABILITY | 145024       | Deferred Capitalized Income  | 16.67  |        |
    And Deferred Capitalized Income by external-id contains the following data:
      | Amount | Amortized Amount | Unrecognized Amount | Adjusted Amount | Charged Off Amount |
      | 100.0  | 83.33            | 0.0                 | 0.0             | 16.67              |
    Then LoanCapitalizedIncomeAmortizationTransactionCreatedBusinessEvent is raised on "20240126"

    When Loan Pay-off is made on "20240126"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C3663
  Scenario: As a user I want to add capitalized income to a progressive loan after disbursement and then charge-off the loan - amortization in case of loan charge-off event
    When Admin sets the business date to "20240101"
    And Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                                 | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_ZERO_INTEREST_CHARGE_OFF_DELINQUENT_REASON_INTEREST_RECALC_CAPITALIZED_INCOME | 20240101   | 1000           | 7                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 1                 | MONTHS                | 1              | MONTHS                 | 1                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240101" with "1000" amount and expected disbursement date on "20240101"
    And Admin successfully disburse the loan on "20240101" with "900" EUR transaction amount
    Then Loan status will be "ACTIVE"
    When Admin sets the business date to "20240102"
    And Admin adds capitalized income with "AUTOPAY" payment type to the loan on "20240102" with "100" EUR transaction amount
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type   | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20240101  | Disbursement       | 900.0  | 0.0       | 0.0      | 0.0  | 0.0       | 900.0        | false    |
      | 20240102  | Capitalized Income | 100.0  | 100.0     | 0.0      | 0.0  | 0.0       | 1000.0       | false    |
    Then Loan Transactions tab has a "CAPITALIZED_INCOME" transaction with date "20240102" which has the following Journal entries:
      | Type      | Account code | Account name                 | Debit  | Credit |
      | ASSET     | 112601       | Loans Receivable             | 100.0  |        |
      | LIABILITY | 145024       | Deferred Capitalized Income  |        | 100.0  |
    Then Admin can successfully set Fraud flag to the loan
    When Admin sets the business date to "20240126"
    And Admin does charge-off the loan with reason "DELINQUENT" on "20240126"
    Then Loan Transactions tab has a "CHARGE_OFF" transaction with date "20240126" which has the following Journal entries:
      | Type    | Account code | Account name               | Debit | Credit |
      | ASSET   | 112601       | Loans Receivable           |       | 1000.0 |
      | ASSET   | 112603       | Interest/Fee Receivable    |       | 4.58   |
      | EXPENSE | 744007       | Credit Loss/Bad Debt       | 1000.0|        |
      | INCOME  | 404001       | Interest Income Charge Off | 4.58  |        |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type                | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20240101  | Disbursement                    | 900.0  | 0.0       | 0.0      | 0.0  | 0.0       | 900.0        | false    |
      | 20240102  | Capitalized Income              | 100.0  | 100.0     | 0.0      | 0.0  | 0.0       | 1000.0       | false    |
      | 20240126  | Capitalized Income Amortization | 83.33  | 0.0       | 83.33    | 0.0  | 0.0       | 0.0          | false    |
      | 20240126  | Accrual                         | 3.69   | 0.0       | 3.69     | 0.0  | 0.0       | 0.0          | false    |
      | 20240126  | Charge-off                      | 1004.58| 1000.0    | 4.58     | 0.0  | 0.0       | 0.0          | false    |
      | 20240126  | Capitalized Income Amortization | 16.67  | 0.0       | 16.67    | 0.0  | 0.0       | 0.0          | false    |
# --- check CIA journal entries for before and after charge-off trn processed --- #
    Then Loan Transactions tab has 2 a "CAPITALIZED_INCOME_AMORTIZATION" transactions with date "20240126" which has the following Journal entries:
      | Type      | Account code | Account name                 | Debit  | Credit |
      | INCOME    | 404000       | Interest Income              |        | 83.33  |
      | LIABILITY | 145024       | Deferred Capitalized Income  | 83.33  |        |
      | EXPENSE   | 744007       | Credit Loss/Bad Debt         |        | 16.67  |
      | LIABILITY | 145024       | Deferred Capitalized Income  | 16.67  |        |
    And Deferred Capitalized Income contains the following data:
      | Amount | Amortized Amount | Unrecognized Amount | Adjusted Amount | Charged Off Amount |
      | 100.0  | 83.33            | 0.0                 | 0.0             | 16.67              |
    Then LoanCapitalizedIncomeAmortizationTransactionCreatedBusinessEvent is raised on "20240126"

    When Loan Pay-off is made on "20240126"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C3664
  Scenario: As a user I want to add capitalized income to a progressive loan after disbursement and then undo the charge-off transaction with "delinquent" reason - amortization in case of loan charge-off event should also be reversed
    When Admin sets the business date to "20240101"
    And Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                                 | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_ZERO_INTEREST_CHARGE_OFF_DELINQUENT_REASON_INTEREST_RECALC_CAPITALIZED_INCOME | 20240101   | 1000           | 7                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 1                 | MONTHS                | 1              | MONTHS                 | 1                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240101" with "1000" amount and expected disbursement date on "20240101"
    And Admin successfully disburse the loan on "20240101" with "900" EUR transaction amount
    Then Loan status will be "ACTIVE"
    When Admin sets the business date to "20240102"
    And Admin adds capitalized income with "AUTOPAY" payment type to the loan on "20240102" with "100" EUR transaction amount
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type   | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20240101  | Disbursement       | 900.0  | 0.0       | 0.0      | 0.0  | 0.0       | 900.0        | false    |
      | 20240102  | Capitalized Income | 100.0  | 100.0     | 0.0      | 0.0  | 0.0       | 1000.0       | false    |
    Then Loan Transactions tab has a "CAPITALIZED_INCOME" transaction with date "20240102" which has the following Journal entries:
      | Type      | Account code | Account name                 | Debit  | Credit |
      | ASSET     | 112601       | Loans Receivable             | 100.0  |        |
      | LIABILITY | 145024       | Deferred Capitalized Income  |        | 100.0  |
    Then Admin can successfully set Fraud flag to the loan
    When Admin sets the business date to "20240126"
    And Admin does charge-off the loan with reason "DELINQUENT" on "20240126"
    Then Loan Transactions tab has a "CHARGE_OFF" transaction with date "20240126" which has the following Journal entries:
      | Type    | Account code | Account name               | Debit | Credit |
      | ASSET   | 112601       | Loans Receivable           |       | 1000.0 |
      | ASSET   | 112603       | Interest/Fee Receivable    |       | 4.58   |
      | EXPENSE | 744007       | Credit Loss/Bad Debt       | 1000.0|        |
      | INCOME  | 404001       | Interest Income Charge Off | 4.58  |        |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type                | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20240101  | Disbursement                    | 900.0  | 0.0       | 0.0      | 0.0  | 0.0       | 900.0        | false    |
      | 20240102  | Capitalized Income              | 100.0  | 100.0     | 0.0      | 0.0  | 0.0       | 1000.0       | false    |
      | 20240126  | Capitalized Income Amortization | 83.33  | 0.0       | 83.33    | 0.0  | 0.0       | 0.0          | false    |
      | 20240126  | Accrual                         | 3.69   | 0.0       | 3.69     | 0.0  | 0.0       | 0.0          | false    |
      | 20240126  | Charge-off                      | 1004.58| 1000.0    | 4.58     | 0.0  | 0.0       | 0.0          | false    |
      | 20240126  | Capitalized Income Amortization | 16.67  | 0.0       | 16.67    | 0.0  | 0.0       | 0.0          | false    |
    Then Loan Transactions tab has 2 a "CAPITALIZED_INCOME_AMORTIZATION" transactions with date "20240126" which has the following Journal entries:
      | Type      | Account code | Account name                 | Debit  | Credit |
      | INCOME    | 404000       | Interest Income              |        | 83.33  |
      | LIABILITY | 145024       | Deferred Capitalized Income  | 83.33  |        |
      | EXPENSE   | 744007       | Credit Loss/Bad Debt         |        | 16.67  |
      | LIABILITY | 145024       | Deferred Capitalized Income  | 16.67  |        |
    Then LoanCapitalizedIncomeAmortizationTransactionCreatedBusinessEvent is raised on "20240126"
    Then Admin does a charge-off undo the loan
    Then Loan Transactions tab has a "CHARGE_OFF" transaction with date "20240126" which has the following Journal entries:
      | Type    | Account code | Account name               | Debit | Credit |
      | ASSET   | 112601       | Loans Receivable           |       | 1000.0 |
      | ASSET   | 112603       | Interest/Fee Receivable    |       | 4.58   |
      | EXPENSE | 744007       | Credit Loss/Bad Debt       | 1000.0|        |
      | INCOME  | 404001       | Interest Income Charge Off | 4.58  |        |
      | ASSET   | 112601       | Loans Receivable           | 1000.0|        |
      | ASSET   | 112603       | Interest/Fee Receivable    | 4.58  |        |
      | EXPENSE | 744007       | Credit Loss/Bad Debt       |       | 1000.0 |
      | INCOME  | 404001       | Interest Income Charge Off |       | 4.58   |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type                | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20240101  | Disbursement                    | 900.0  | 0.0       | 0.0      | 0.0  | 0.0       | 900.0        | false    |
      | 20240102  | Capitalized Income              | 100.0  | 100.0     | 0.0      | 0.0  | 0.0       | 1000.0       | false    |
      | 20240126  | Capitalized Income Amortization | 83.33  | 0.0       | 83.33    | 0.0  | 0.0       | 0.0          | false    |
      | 20240126  | Accrual                         | 3.69   | 0.0       | 3.69     | 0.0  | 0.0       | 0.0          | false    |
      | 20240126  | Charge-off                      | 1004.58| 1000.0    | 4.58     | 0.0  | 0.0       | 0.0          | true     |
    Then Reversed loan capitalized income amortization transaction has the following Journal entries:
      | Type      | Account code | Account name                 | Debit  | Credit |
      | EXPENSE   | 744007       | Credit Loss/Bad Debt         |        | 16.67  |
      | LIABILITY | 145024       | Deferred Capitalized Income  | 16.67  |        |
      | EXPENSE   | 744007       | Credit Loss/Bad Debt         | 16.67  |        |
      | LIABILITY | 145024       | Deferred Capitalized Income  |        | 16.67  |
    And Deferred Capitalized Income by external-id contains the following data:
      | Amount | Amortized Amount | Unrecognized Amount | Adjusted Amount | Charged Off Amount |
      | 100.0  | 83.33            | 16.67               | 0.0             | 0.0                |

    When Loan Pay-off is made on "20240126"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C3673
  Scenario: Verify capitalized income: repayment schedule - UC1: Simple loan - full payment
    When Admin sets the business date to "20240101"
    And Admin creates a client with random data
    And Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                      | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_EMI_360_30_INTEREST_RECALC_DAILY_CAPITALIZED_INCOME | 20240101   | 200            | 7                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 3                 | MONTHS                | 1              | MONTHS                 | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240101" with "200" amount and expected disbursement date on "20240101"
    And Admin successfully disburse the loan on "20240101" with "100" EUR transaction amount
    And Admin adds capitalized income with "AUTOPAY" payment type to the loan on "20240101" with "50" EUR transaction amount
    Then Loan status will be "ACTIVE"
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type   | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement       | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240101  | Capitalized Income | 50.0   | 50.0      | 0.0      | 0.0  | 0.0       | 150.0        | false    | false    |
    And Loan Transactions tab has a "CAPITALIZED_INCOME" transaction with date "20240101" which has the following Journal entries:
      | Type      | Account code | Account name                | Debit | Credit |
      | LIABILITY | 145024       | Deferred Capitalized Income |       | 50.0   |
      | ASSET     | 112601       | Loans Receivable            | 50.0  |        |
    When Admin sets the business date to "20240102"
    And Admin runs inline COB job for Loan
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20240101  |           | 100.0           |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      |    |      | 20240101  |           | 50.0            |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 31   | 20240201 |           | 100.29          | 49.71         | 0.87     | 0.0  | 0.0       | 50.58 | 0.0  | 0.0        | 0.0  | 50.58       |
      | 2  | 29   | 20240301    |           | 50.3            | 49.99         | 0.59     | 0.0  | 0.0       | 50.58 | 0.0  | 0.0        | 0.0  | 50.58       |
      | 3  | 31   | 20240401    |           | 0.0             | 50.3          | 0.29     | 0.0  | 0.0       | 50.59 | 0.0  | 0.0        | 0.0  | 50.59       |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 150.0         | 1.75     | 0.0  | 0.0       | 151.75 | 0.0  | 0.0        | 0.0  | 151.75      |
#   --- First repayment ---
    When Admin sets the business date to "20240201"
    And Admin runs inline COB job for Loan
    And Customer makes "AUTOPAY" repayment on "20240201" with 50.58 EUR transaction amount
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101  |                  | 100.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      |    |      | 20240101  |                  | 50.0            |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 31   | 20240201 | 20240201 | 100.29          | 49.71         | 0.87     | 0.0  | 0.0       | 50.58 | 50.58 | 0.0        | 0.0  | 0.0         |
      | 2  | 29   | 20240301    |                  | 50.3            | 49.99         | 0.59     | 0.0  | 0.0       | 50.58 | 0.0   | 0.0        | 0.0  | 50.58       |
      | 3  | 31   | 20240401    |                  | 0.0             | 50.3          | 0.29     | 0.0  | 0.0       | 50.59 | 0.0   | 0.0        | 0.0  | 50.59       |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 150.0         | 1.75     | 0.0  | 0.0       | 151.75 | 50.58 | 0.0        | 0.0  | 101.17      |
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
#   --- Second repayment ---
    When Admin sets the business date to "20240301"
    And Admin runs inline COB job for Loan
    And Customer makes "AUTOPAY" repayment on "20240301" with 50.58 EUR transaction amount
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101  |                  | 100.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      |    |      | 20240101  |                  | 50.0            |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 31   | 20240201 | 20240201 | 100.29          | 49.71         | 0.87     | 0.0  | 0.0       | 50.58 | 50.58 | 0.0        | 0.0  | 0.0         |
      | 2  | 29   | 20240301    | 20240301    | 50.3            | 49.99         | 0.59     | 0.0  | 0.0       | 50.58 | 50.58 | 0.0        | 0.0  | 0.0         |
      | 3  | 31   | 20240401    |                  | 0.0             | 50.3          | 0.29     | 0.0  | 0.0       | 50.59 | 0.0   | 0.0        | 0.0  | 50.59       |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late | Outstanding |
      | 150.0         | 1.75     | 0.0  | 0.0       | 151.75 | 101.16 | 0.0        | 0.0  | 50.59       |
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
#   --- Third repayment ---
    And Admin sets the business date to "20240401"
    And Admin runs inline COB job for Loan
    And Customer makes "AUTOPAY" repayment on "20240401" with 50.59 EUR transaction amount
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101  |                  | 100.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      |    |      | 20240101  |                  | 50.0            |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 31   | 20240201 | 20240201 | 100.29          | 49.71         | 0.87     | 0.0  | 0.0       | 50.58 | 50.58 | 0.0        | 0.0  | 0.0         |
      | 2  | 29   | 20240301    | 20240301    | 50.3            | 49.99         | 0.59     | 0.0  | 0.0       | 50.58 | 50.58 | 0.0        | 0.0  | 0.0         |
      | 3  | 31   | 20240401    | 20240401    | 0.0             | 50.3          | 0.29     | 0.0  | 0.0       | 50.59 | 50.59 | 0.0        | 0.0  | 0.0         |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late | Outstanding |
      | 150.0         | 1.75     | 0.0  | 0.0       | 151.75 | 151.75 | 0.0        | 0.0  | 0.0         |
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
      | 20240401    | Repayment                       | 50.59  | 50.3      | 0.29     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240401    | Accrual                         | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |

  @TestRailId:C3674
  Scenario: Verify capitalized income: repayment schedule - UC2: loan - early payoff
    When Admin sets the business date to "20240101"
    And Admin creates a client with random data
    And Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                      | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_EMI_360_30_INTEREST_RECALC_DAILY_CAPITALIZED_INCOME | 20240101   | 200            | 7                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 3                 | MONTHS                | 1              | MONTHS                 | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240101" with "200" amount and expected disbursement date on "20240101"
    And Admin successfully disburse the loan on "20240101" with "100" EUR transaction amount
    And Admin adds capitalized income with "AUTOPAY" payment type to the loan on "20240101" with "50" EUR transaction amount
    Then Loan status will be "ACTIVE"
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type   | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement       | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240101  | Capitalized Income | 50.0   | 50.0      | 0.0      | 0.0  | 0.0       | 150.0        | false    | false    |
    And Loan Transactions tab has a "CAPITALIZED_INCOME" transaction with date "20240101" which has the following Journal entries:
      | Type      | Account code | Account name                | Debit | Credit |
      | LIABILITY | 145024       | Deferred Capitalized Income |       | 50.0   |
      | ASSET     | 112601       | Loans Receivable            | 50.0  |        |
    When Admin sets the business date to "20240102"
    And Admin runs inline COB job for Loan
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20240101  |           | 100.0           |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      |    |      | 20240101  |           | 50.0            |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 31   | 20240201 |           | 100.29          | 49.71         | 0.87     | 0.0  | 0.0       | 50.58 | 0.0  | 0.0        | 0.0  | 50.58       |
      | 2  | 29   | 20240301    |           | 50.3            | 49.99         | 0.59     | 0.0  | 0.0       | 50.58 | 0.0  | 0.0        | 0.0  | 50.58       |
      | 3  | 31   | 20240401    |           | 0.0             | 50.3          | 0.29     | 0.0  | 0.0       | 50.59 | 0.0  | 0.0        | 0.0  | 50.59       |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 150.0         | 1.75     | 0.0  | 0.0       | 151.75 | 0.0  | 0.0        | 0.0  | 151.75      |
#   --- First repayment ---
    When Admin sets the business date to "20240201"
    And Admin runs inline COB job for Loan
    And Customer makes "AUTOPAY" repayment on "20240201" with 50.58 EUR transaction amount
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101  |                  | 100.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      |    |      | 20240101  |                  | 50.0            |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 31   | 20240201 | 20240201 | 100.29          | 49.71         | 0.87     | 0.0  | 0.0       | 50.58 | 50.58 | 0.0        | 0.0  | 0.0         |
      | 2  | 29   | 20240301    |                  | 50.3            | 49.99         | 0.59     | 0.0  | 0.0       | 50.58 | 0.0   | 0.0        | 0.0  | 50.58       |
      | 3  | 31   | 20240401    |                  | 0.0             | 50.3          | 0.29     | 0.0  | 0.0       | 50.59 | 0.0   | 0.0        | 0.0  | 50.59       |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 150.0         | 1.75     | 0.0  | 0.0       | 151.75 | 50.58 | 0.0        | 0.0  | 101.17      |
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
#   --- Early pay-off ---
    When Admin sets the business date to "20240301"
    And Admin runs inline COB job for Loan
    And Loan Pay-off is made on "20240301"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met
    And Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101  |                  | 100.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      |    |      | 20240101  |                  | 50.0            |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 31   | 20240201 | 20240201 | 100.29          | 49.71         | 0.87     | 0.0  | 0.0       | 50.58 | 50.58 | 0.0        | 0.0  | 0.0         |
      | 2  | 29   | 20240301    | 20240301    | 50.3            | 49.99         | 0.59     | 0.0  | 0.0       | 50.58 | 50.58 | 0.0        | 0.0  | 0.0         |
      | 3  | 31   | 20240401    | 20240301    | 0.0             | 50.3          | 0.0      | 0.0  | 0.0       | 50.3  | 50.3  | 50.3       | 0.0  | 0.0         |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late | Outstanding |
      | 150.0         | 1.46     | 0.0  | 0.0       | 151.46 | 151.46 | 50.3       | 0.0  | 0.0         |
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
      | 20240301    | Repayment                       | 100.88 | 100.29    | 0.59     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240301    | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240301    | Capitalized Income Amortization | 17.03   | 0.0      | 17.03    | 0.0  | 0.0       | 0.0          | false    | false    |

  @TestRailId:C3675
  Scenario: Verify capitalized income: repayment schedule - UC3: loan - charge-off
    When Admin sets the business date to "20240101"
    And Admin creates a client with random data
    And Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                      | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_EMI_360_30_INTEREST_RECALC_DAILY_CAPITALIZED_INCOME | 20240101   | 200            | 7                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 3                 | MONTHS                | 1              | MONTHS                 | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240101" with "200" amount and expected disbursement date on "20240101"
    And Admin successfully disburse the loan on "20240101" with "100" EUR transaction amount
    And Admin adds capitalized income with "AUTOPAY" payment type to the loan on "20240101" with "50" EUR transaction amount
    Then Loan status will be "ACTIVE"
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type   | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement       | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240101  | Capitalized Income | 50.0   | 50.0      | 0.0      | 0.0  | 0.0       | 150.0        | false    | false    |
    And Loan Transactions tab has a "CAPITALIZED_INCOME" transaction with date "20240101" which has the following Journal entries:
      | Type      | Account code | Account name                | Debit | Credit |
      | LIABILITY | 145024       | Deferred Capitalized Income |       | 50.0   |
      | ASSET     | 112601       | Loans Receivable            | 50.0  |        |
    When Admin sets the business date to "20240102"
    And Admin runs inline COB job for Loan
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20240101  |           | 100.0           |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      |    |      | 20240101  |           | 50.0            |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 31   | 20240201 |           | 100.29          | 49.71         | 0.87     | 0.0  | 0.0       | 50.58 | 0.0  | 0.0        | 0.0  | 50.58       |
      | 2  | 29   | 20240301    |           | 50.3            | 49.99         | 0.59     | 0.0  | 0.0       | 50.58 | 0.0  | 0.0        | 0.0  | 50.58       |
      | 3  | 31   | 20240401    |           | 0.0             | 50.3          | 0.29     | 0.0  | 0.0       | 50.59 | 0.0  | 0.0        | 0.0  | 50.59       |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 150.0         | 1.75     | 0.0  | 0.0       | 151.75 | 0.0  | 0.0        | 0.0  | 151.75      |
#   --- First repayment ---
    When Admin sets the business date to "20240201"
    And Admin runs inline COB job for Loan
    And Customer makes "AUTOPAY" repayment on "20240201" with 50.58 EUR transaction amount
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101  |                  | 100.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      |    |      | 20240101  |                  | 50.0            |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 31   | 20240201 | 20240201 | 100.29          | 49.71         | 0.87     | 0.0  | 0.0       | 50.58 | 50.58 | 0.0        | 0.0  | 0.0         |
      | 2  | 29   | 20240301    |                  | 50.3            | 49.99         | 0.59     | 0.0  | 0.0       | 50.58 | 0.0   | 0.0        | 0.0  | 50.58       |
      | 3  | 31   | 20240401    |                  | 0.0             | 50.3          | 0.29     | 0.0  | 0.0       | 50.59 | 0.0   | 0.0        | 0.0  | 50.59       |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 150.0         | 1.75     | 0.0  | 0.0       | 151.75 | 50.58 | 0.0        | 0.0  | 101.17      |
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
#   --- Charge off ---
    When Admin sets the business date to "20240301"
    And Admin runs inline COB job for Loan
    And Admin does charge-off the loan on "20240301"
    Then Loan status will be "ACTIVE"
    And Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101  |                  | 100.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      |    |      | 20240101  |                  | 50.0            |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 31   | 20240201 | 20240201 | 100.29          | 49.71         | 0.87     | 0.0  | 0.0       | 50.58 | 50.58 | 0.0        | 0.0  | 0.0         |
      | 2  | 29   | 20240301    |                  | 50.3            | 49.99         | 0.59     | 0.0  | 0.0       | 50.58 | 0.0   | 0.0        | 0.0  | 50.58       |
      | 3  | 31   | 20240401    |                  | 0.0             | 50.3          | 0.29     | 0.0  | 0.0       | 50.59 | 0.0   | 0.0        | 0.0  | 50.59       |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 150.0         | 1.75     | 0.0  | 0.0       | 151.75 | 50.58 | 0.0        | 0.0  | 101.17      |
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
      | 20240301    | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240301    | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240301    | Charge-off                      | 101.17 | 100.29    | 0.88     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240301    | Capitalized Income Amortization | 16.48  | 0.0       | 16.48    | 0.0  | 0.0       | 0.0          | false    | false    |

    When Loan Pay-off is made on "20240301"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C3665
  Scenario: Verify Capitalized Income Adjustment with partial amortization and allocation strategy - Credit Adj < Bal - UC4
    When Admin sets the business date to "20240101"
    And Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                                       | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_EMI_360_30_INTEREST_RECALC_DAILY_CAPITALIZED_INCOME_ADJ_CUSTOM_ALLOC | 20240101   | 150            | 7                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 3                 | MONTHS                | 1              | MONTHS                 | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240101" with "150" amount and expected disbursement date on "20240101"
    And Admin successfully disburse the loan on "20240101" with "100" EUR transaction amount
    And Admin adds capitalized income with "AUTOPAY" payment type to the loan on "20240101" with "50" EUR transaction amount
    Then Loan status will be "ACTIVE"
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type   | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20240101  | Disbursement       | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    |
      | 20240101  | Capitalized Income | 50.0   | 50.0      | 0.0      | 0.0  | 0.0       | 150.0        | false    |
  # Journal entry checks for initial transactions
    Then Loan Transactions tab has a "DISBURSEMENT" transaction with date "20240101" which has the following Journal entries:
      | Type      | Account code | Account name              | Debit | Credit |
      | ASSET     | 112601       | Loans Receivable          | 100.0 |        |
      | LIABILITY | 145023       | Suspense/Clearing account |        | 100.0  |
    Then Loan Transactions tab has a "CAPITALIZED_INCOME" transaction with date "20240101" which has the following Journal entries:
      | Type      | Account code | Account name                 | Debit | Credit |
      | ASSET     | 112601       | Loans Receivable             | 50.0  |        |
      | LIABILITY | 145024       | Deferred Capitalized Income  |       | 50.0   |
    When Admin sets the business date to "20240201"
    When Customer makes "REPAYMENT" transaction with "AUTOPAY" payment type on "20240201" with 50.58 EUR transaction amount and system-generated Idempotency key
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type                | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20240101  | Disbursement                    | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    |
      | 20240101  | Capitalized Income              | 50.0   | 50.0      | 0.0      | 0.0  | 0.0       | 150.0        | false    |
      | 20240201 | Repayment                       | 50.58  | 49.71     | 0.87     | 0.0  | 0.0       | 100.29       | false    |
  # Journal entry check for repayment
    Then Loan Transactions tab has a "REPAYMENT" transaction with date "20240201" which has the following Journal entries:
      | Type      | Account code | Account name              | Debit | Credit |
      | ASSET     | 112601       | Loans Receivable          |       | 49.71  |
      | ASSET     | 112603       | Interest/Fee Receivable   |       | 0.87   |
      | LIABILITY | 145023       | Suspense/Clearing account | 50.58 |        |
    When Admin sets the business date to "20240202"
    And Admin runs inline COB job for Loan
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type                | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20240101  | Disbursement                    | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    |
      | 20240101  | Capitalized Income              | 50.0   | 50.0      | 0.0      | 0.0  | 0.0       | 150.0        | false    |
      | 20240201 | Accrual                         | 0.87   | 0.0       | 0.87     | 0.0  | 0.0       | 0.0          | false    |
      | 20240201 | Capitalized Income Amortization | 17.58  | 0.0       | 17.58    | 0.0  | 0.0       | 0.0          | false    |
      | 20240201 | Repayment                       | 50.58  | 49.71     | 0.87     | 0.0  | 0.0       | 100.29       | false    |
  # Journal entry check for accrual
    Then Loan Transactions tab has a "ACCRUAL" transaction with date "20240201" which has the following Journal entries:
      | Type   | Account code | Account name            | Debit | Credit |
      | ASSET  | 112603       | Interest/Fee Receivable | 0.87  |        |
      | INCOME | 404000       | Interest Income         |       | 0.87   |
    # Journal entry check for final capitalized income amortization
    Then Loan Transactions tab has a "CAPITALIZED_INCOME_AMORTIZATION" transaction with date "20240201" which has the following Journal entries:
      | Type      | Account code | Account name                 | Debit  | Credit |
      | INCOME    | 404000       | Interest Income              |        | 17.58  |
      | LIABILITY | 145024       | Deferred Capitalized Income  | 17.58  |        |
    When Admin sets the business date to "20240301"
    And Customer makes "REPAYMENT" transaction with "AUTOPAY" payment type on "20240301" with 50.58 EUR transaction amount and system-generated Idempotency key
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type                | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20240101  | Disbursement                    | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    |
      | 20240101  | Capitalized Income              | 50.0   | 50.0      | 0.0      | 0.0  | 0.0       | 150.0        | false    |
      | 20240201 | Accrual                         | 0.87   | 0.0       | 0.87     | 0.0  | 0.0       | 0.0          | false    |
      | 20240201 | Capitalized Income Amortization | 17.58  | 0.0       | 17.58    | 0.0  | 0.0       | 0.0          | false    |
      | 20240201 | Repayment                       | 50.58  | 49.71     | 0.87     | 0.0  | 0.0       | 100.29       | false    |
      | 20240301    | Repayment                       | 50.58  | 49.99     | 0.59     | 0.0  | 0.0       | 50.3         | false    |
  # Journal entry check for March repayment
    Then Loan Transactions tab has a "REPAYMENT" transaction with date "20240301" which has the following Journal entries:
      | Type      | Account code | Account name              | Debit | Credit |
      | ASSET     | 112601       | Loans Receivable          |       | 49.99  |
      | ASSET     | 112603       | Interest/Fee Receivable   |       | 0.59   |
      | LIABILITY | 145023       | Suspense/Clearing account | 50.58 |        |
    And Admin adds capitalized income adjustment with "AUTOPAY" payment type to the loan on "20240301" with "10" EUR transaction amount
    # Journal entry check for final capitalized income adjustment
    Then Loan Transactions tab has a "CAPITALIZED_INCOME_ADJUSTMENT" transaction with date "20240301" which has the following Journal entries:
      | Type      | Account code | Account name                 | Debit  | Credit |
      | ASSET     | 112601       | Loans Receivable             |        | 10.0   |
      | LIABILITY | 145024       | Deferred Capitalized Income  | 10.0   |        |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type                | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20240101  | Disbursement                    | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    |
      | 20240101  | Capitalized Income              | 50.0   | 50.0      | 0.0      | 0.0  | 0.0       | 150.0        | false    |
      | 20240201 | Accrual                         | 0.87   | 0.0       | 0.87     | 0.0  | 0.0       | 0.0          | false    |
      | 20240201 | Capitalized Income Amortization | 17.58  | 0.0       | 17.58    | 0.0  | 0.0       | 0.0          | false    |
      | 20240201 | Repayment                       | 50.58  | 49.71     | 0.87     | 0.0  | 0.0       | 100.29       | false    |
      | 20240301    | Repayment                       | 50.58  | 49.99     | 0.59     | 0.0  | 0.0       | 50.3         | false    |
      | 20240301    | Capitalized Income Adjustment   | 10.0   | 10.0      | 0.0      | 0.0  | 0.0       | 40.3         | false    |
    When Admin sets the business date to "20240401"
    And Customer makes "REPAYMENT" transaction with "AUTOPAY" payment type on "20240401" with 40.54 EUR transaction amount and system-generated Idempotency key
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type                | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20240101  | Disbursement                    | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    |
      | 20240101  | Capitalized Income              | 50.0   | 50.0      | 0.0      | 0.0  | 0.0       | 150.0        | false    |
      | 20240201 | Repayment                       | 50.58  | 49.71     | 0.87     | 0.0  | 0.0       | 100.29       | false    |
      | 20240201 | Accrual                         | 0.87   | 0.0       | 0.87     | 0.0  | 0.0       | 0.0          | false    |
      | 20240201 | Capitalized Income Amortization | 17.58  | 0.0       | 17.58    | 0.0  | 0.0       | 0.0          | false    |
      | 20240201 | Repayment                       | 50.58  | 49.71     | 0.87     | 0.0  | 0.0       | 100.29       | false    |
      | 20240301    | Capitalized Income Adjustment   | 10.0   | 10.0      | 0.0      | 0.0  | 0.0       | 40.3         | false    |
      | 20240401    | Repayment                       | 40.54  | 40.3      | 0.24     | 0.0  | 0.0       | 0.0          | false    |
      | 20240401    | Accrual                         | 0.83   | 0.0       | 0.83     | 0.0  | 0.0       | 0.0          | false    |
      | 20240401    | Capitalized Income Amortization | 22.42  | 0.0       | 22.42    | 0.0  | 0.0       | 0.0          | false    |
    And Deferred Capitalized Income by external-id contains the following data:
      | Amount | Amortized Amount | Unrecognized Amount | Adjusted Amount | Charged Off Amount |
      | 50.0   | 40.0             | 0.0                 | 10.0            | 0.0                |
  # Journal entry check for final repayment
    Then Loan Transactions tab has a "REPAYMENT" transaction with date "20240401" which has the following Journal entries:
      | Type      | Account code | Account name              | Debit | Credit |
      | ASSET     | 112601       | Loans Receivable          |       | 40.3   |
      | ASSET     | 112603       | Interest/Fee Receivable   |       | 0.24   |
      | LIABILITY | 145023       | Suspense/Clearing account | 40.54 |        |
  # Journal entry check for final accrual
    Then Loan Transactions tab has a "ACCRUAL" transaction with date "20240401" which has the following Journal entries:
      | Type   | Account code | Account name            | Debit | Credit |
      | ASSET  | 112603       | Interest/Fee Receivable | 0.83  |        |
      | INCOME | 404000       | Interest Income         |       | 0.83   |
  # Journal entry check for final capitalized income amortization
    Then Loan Transactions tab has a "CAPITALIZED_INCOME_AMORTIZATION" transaction with date "20240401" which has the following Journal entries:
      | Type      | Account code | Account name                | Debit | Credit |
      | INCOME    | 404000       | Interest Income             |       | 22.42  |
      | LIABILITY | 145024       | Deferred Capitalized Income | 22.42 |        |
  # Journal entry check for final capitalized income adjustment
    Then Loan Transactions tab has a "CAPITALIZED_INCOME_ADJUSTMENT" transaction with date "20240301" which has the following Journal entries:
      | Type      | Account code | Account name                 | Debit  | Credit |
      | ASSET     | 112601       | Loans Receivable             |        | 10.0   |
      | LIABILITY | 145024       | Deferred Capitalized Income  | 10.0   |        |

  @TestRailId:C3707
  Scenario: Verify Capitalized Income Adjustment with partial amortization and allocation strategy - Credit Adj > Bal - UC5
    When Admin sets the business date to "20240101"
    And Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                                       | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_EMI_360_30_INTEREST_RECALC_DAILY_CAPITALIZED_INCOME_ADJ_CUSTOM_ALLOC | 20240101   | 150            | 7                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 3                 | MONTHS                | 1              | MONTHS                 | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240101" with "150" amount and expected disbursement date on "20240101"
    And Admin successfully disburse the loan on "20240101" with "100" EUR transaction amount
    And Admin adds capitalized income with "AUTOPAY" payment type to the loan on "20240101" with "50" EUR transaction amount
    Then Loan status will be "ACTIVE"
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type   | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20240101  | Disbursement       | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    |
      | 20240101  | Capitalized Income | 50.0   | 50.0      | 0.0      | 0.0  | 0.0       | 150.0        | false    |
  # Journal entry checks for initial transactions
    Then Loan Transactions tab has a "DISBURSEMENT" transaction with date "20240101" which has the following Journal entries:
      | Type      | Account code | Account name              | Debit | Credit |
      | ASSET     | 112601       | Loans Receivable          | 100.0 |        |
      | LIABILITY | 145023       | Suspense/Clearing account |        | 100.0  |
    Then Loan Transactions tab has a "CAPITALIZED_INCOME" transaction with date "20240101" which has the following Journal entries:
      | Type      | Account code | Account name                 | Debit | Credit |
      | ASSET     | 112601       | Loans Receivable             | 50.0  |        |
      | LIABILITY | 145024       | Deferred Capitalized Income  |       | 50.0   |
    When Admin sets the business date to "20240201"
    When Customer makes "REPAYMENT" transaction with "AUTOPAY" payment type on "20240201" with 50.58 EUR transaction amount and system-generated Idempotency key
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type                | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20240101  | Disbursement                    | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    |
      | 20240101  | Capitalized Income              | 50.0   | 50.0      | 0.0      | 0.0  | 0.0       | 150.0        | false    |
      | 20240201 | Repayment                       | 50.58  | 49.71     | 0.87     | 0.0  | 0.0       | 100.29       | false    |
  # Journal entry check for February repayment
    Then Loan Transactions tab has a "REPAYMENT" transaction with date "20240201" which has the following Journal entries:
      | Type      | Account code | Account name              | Debit | Credit |
      | ASSET     | 112601       | Loans Receivable          |       | 49.71  |
      | ASSET     | 112603       | Interest/Fee Receivable   |       | 0.87   |
      | LIABILITY | 145023       | Suspense/Clearing account | 50.58 |        |
    When Admin sets the business date to "20240202"
    And Admin runs inline COB job for Loan
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type                | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20240101  | Disbursement                    | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    |
      | 20240101  | Capitalized Income              | 50.0   | 50.0      | 0.0      | 0.0  | 0.0       | 150.0        | false    |
      | 20240201 | Repayment                       | 50.58  | 49.71     | 0.87     | 0.0  | 0.0       | 100.29       | false    |
      | 20240201 | Accrual                         | 0.87   | 0.0       | 0.87     | 0.0  | 0.0       | 0.0          | false    |
      | 20240201 | Capitalized Income Amortization | 17.58  | 0.0       | 17.58    | 0.0  | 0.0       | 0.0          | false    |
  # Journal entry check for February accrual
    Then Loan Transactions tab has a "ACCRUAL" transaction with date "20240201" which has the following Journal entries:
      | Type   | Account code | Account name            | Debit | Credit |
      | ASSET  | 112603       | Interest/Fee Receivable | 0.87  |        |
      | INCOME | 404000       | Interest Income         |       | 0.87   |
  # Journal entry check for February capitalized income amortization
    Then Loan Transactions tab has a "CAPITALIZED_INCOME_AMORTIZATION" transaction with date "20240201" which has the following Journal entries:
      | Type      | Account code | Account name                 | Debit | Credit |
      | INCOME    | 404000       | Interest Income              |       | 17.58  |
      | LIABILITY | 145024       | Deferred Capitalized Income  | 17.58 |        |
    When Admin sets the business date to "20240301"
    When Customer makes "REPAYMENT" transaction with "AUTOPAY" payment type on "20240301" with 50.58 EUR transaction amount and system-generated Idempotency key
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type                | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20240101  | Disbursement                    | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    |
      | 20240101  | Capitalized Income              | 50.0   | 50.0      | 0.0      | 0.0  | 0.0       | 150.0        | false    |
      | 20240201 | Repayment                       | 50.58  | 49.71     | 0.87     | 0.0  | 0.0       | 100.29       | false    |
      | 20240201 | Accrual                         | 0.87   | 0.0       | 0.87     | 0.0  | 0.0       | 0.0          | false    |
      | 20240201 | Capitalized Income Amortization | 17.58  | 0.0       | 17.58    | 0.0  | 0.0       | 0.0          | false    |
      | 20240301    | Repayment                       | 50.58  | 49.99     | 0.59     | 0.0  | 0.0       | 50.3         | false    |
  # Journal entry check for March repayment
    Then Loan Transactions tab has a "REPAYMENT" transaction with date "20240301" which has the following Journal entries:
      | Type      | Account code | Account name              | Debit | Credit |
      | ASSET     | 112601       | Loans Receivable          |       | 49.99  |
      | ASSET     | 112603       | Interest/Fee Receivable   |       | 0.59   |
      | LIABILITY | 145023       | Suspense/Clearing account | 50.58 |        |
    And Admin adds capitalized income adjustment with "AUTOPAY" payment type to the loan on "20240301" with "10" EUR transaction amount
    # Journal entry checks for Capitalized Income Adjustment
    Then Loan Transactions tab has a "CAPITALIZED_INCOME_ADJUSTMENT" transaction with date "20240301" which has the following Journal entries:
      | Type      | Account code | Account name                 | Debit  | Credit |
      | ASSET     | 112601       | Loans Receivable             |        | 10.0   |
      | LIABILITY | 145024       | Deferred Capitalized Income  | 10.0   |        |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type                | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20240101  | Disbursement                    | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    |
      | 20240101  | Capitalized Income              | 50.0   | 50.0      | 0.0      | 0.0  | 0.0       | 150.0        | false    |
      | 20240201 | Repayment                       | 50.58  | 49.71     | 0.87     | 0.0  | 0.0       | 100.29       | false    |
      | 20240201 | Accrual                         | 0.87   | 0.0       | 0.87     | 0.0  | 0.0       | 0.0          | false    |
      | 20240201 | Capitalized Income Amortization | 17.58  | 0.0       | 17.58    | 0.0  | 0.0       | 0.0          | false    |
      | 20240301    | Repayment                       | 50.58  | 49.99     | 0.59     | 0.0  | 0.0       | 50.3         | false    |
      | 20240301    | Capitalized Income Adjustment   | 10.0   | 10.0      | 0.0      | 0.0  | 0.0       | 40.3         | false    |
    And Deferred Capitalized Income by external-id contains the following data:
      | Amount | Amortized Amount | Unrecognized Amount | Adjusted Amount | Charged Off Amount |
      | 50.0   | 17.58            | 22.42               | 10.0            | 0.0                |
    When Admin sets the business date to "20240315"
    # Journal entry checks for Capitalized Income Adjustment
    And Admin adds capitalized income adjustment with "AUTOPAY" payment type to the loan on "20240315" with "5" EUR transaction amount
    Then Loan Transactions tab has a "CAPITALIZED_INCOME_ADJUSTMENT" transaction with date "20240315" which has the following Journal entries:
      | Type      | Account code | Account name                 | Debit  | Credit |
      | ASSET     | 112601       | Loans Receivable             |        | 5.0    |
      | LIABILITY | 145024       | Deferred Capitalized Income  | 5.0    |        |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type                | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20240101  | Disbursement                    | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    |
      | 20240101  | Capitalized Income              | 50.0   | 50.0      | 0.0      | 0.0  | 0.0       | 150.0        | false    |
      | 20240201 | Repayment                       | 50.58  | 49.71     | 0.87     | 0.0  | 0.0       | 100.29       | false    |
      | 20240201 | Accrual                         | 0.87   | 0.0       | 0.87     | 0.0  | 0.0       | 0.0          | false    |
      | 20240201 | Capitalized Income Amortization | 17.58  | 0.0       | 17.58    | 0.0  | 0.0       | 0.0          | false    |
      | 20240301    | Repayment                       | 50.58  | 49.99     | 0.59     | 0.0  | 0.0       | 50.3         | false    |
      | 20240301    | Capitalized Income Adjustment   | 10.0   | 10.0      | 0.0      | 0.0  | 0.0       | 40.3         | false    |
      | 20240315    | Capitalized Income Adjustment   | 5.0    | 5.0       | 0.0      | 0.0  | 0.0       | 35.3         | false    |
    And Deferred Capitalized Income by external-id contains the following data:
      | Amount | Amortized Amount | Unrecognized Amount | Adjusted Amount | Charged Off Amount |
      | 50.0   | 17.58            | 17.42               | 15.0            | 0.0                |
    When Admin sets the business date to "20240401"
    And Customer makes "REPAYMENT" transaction with "AUTOPAY" payment type on "20240401" with 35.52 EUR transaction amount and system-generated Idempotency key
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type                | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20240101  | Disbursement                    | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    |
      | 20240101  | Capitalized Income              | 50.0   | 50.0      | 0.0      | 0.0  | 0.0       | 150.0        | false    |
      | 20240201 | Repayment                       | 50.58  | 49.71     | 0.87     | 0.0  | 0.0       | 100.29       | false    |
      | 20240201 | Accrual                         | 0.87   | 0.0       | 0.87     | 0.0  | 0.0       | 0.0          | false    |
      | 20240201 | Capitalized Income Amortization | 17.58  | 0.0       | 17.58    | 0.0  | 0.0       | 0.0          | false    |
      | 20240301    | Repayment                       | 50.58  | 49.99     | 0.59     | 0.0  | 0.0       | 50.3         | false    |
      | 20240301    | Capitalized Income Adjustment   | 10.0   | 10.0      | 0.0      | 0.0  | 0.0       | 40.3         | false    |
      | 20240315    | Capitalized Income Adjustment   | 5.0    | 5.0       | 0.0      | 0.0  | 0.0       | 35.3         | false    |
      | 20240401    | Repayment                       | 35.52  | 35.3      | 0.22     | 0.0  | 0.0       | 0.0          | false    |
      | 20240401    | Accrual                         | 0.81   | 0.0       | 0.81     | 0.0  | 0.0       | 0.0          | false    |
      | 20240401    | Capitalized Income Amortization | 17.42  | 0.0       | 17.42    | 0.0  | 0.0       | 0.0          | false    |
    And Deferred Capitalized Income by external-id contains the following data:
      | Amount | Amortized Amount | Unrecognized Amount | Adjusted Amount | Charged Off Amount |
      | 50.0   | 35.0             | 0.0                 | 15.0            | 0.0                |
  # Journal entry check for final April repayment
    Then Loan Transactions tab has a "REPAYMENT" transaction with date "20240401" which has the following Journal entries:
      | Type      | Account code | Account name              | Debit | Credit |
      | ASSET     | 112601       | Loans Receivable          |       | 35.3   |
      | ASSET     | 112603       | Interest/Fee Receivable   |       | 0.22   |
      | LIABILITY | 145023       | Suspense/Clearing account | 35.52 |        |
  # Journal entry check for final April accrual
    Then Loan Transactions tab has a "ACCRUAL" transaction with date "20240401" which has the following Journal entries:
      | Type   | Account code | Account name            | Debit | Credit |
      | ASSET  | 112603       | Interest/Fee Receivable | 0.81  |        |
      | INCOME | 404000       | Interest Income         |       | 0.81   |
  # Journal entry check for final April capitalized income amortization
    Then Loan Transactions tab has a "CAPITALIZED_INCOME_AMORTIZATION" transaction with date "20240401" which has the following Journal entries:
      | Type      | Account code | Account name                 | Debit | Credit |
      | INCOME    | 404000       | Interest Income              |       | 17.42  |
      | LIABILITY | 145024       | Deferred Capitalized Income  | 17.42 |        |
  # Journal entry checks for Capitalized Income Adjustments - INTACT
    Then Loan Transactions tab has a "CAPITALIZED_INCOME_ADJUSTMENT" transaction with date "20240301" which has the following Journal entries:
      | Type      | Account code | Account name                 | Debit  | Credit |
      | ASSET     | 112601       | Loans Receivable             |        | 10.0   |
      | LIABILITY | 145024       | Deferred Capitalized Income  | 10.0   |        |
    Then Loan Transactions tab has a "CAPITALIZED_INCOME_ADJUSTMENT" transaction with date "20240315" which has the following Journal entries:
      | Type      | Account code | Account name                 | Debit  | Credit |
      | ASSET     | 112601       | Loans Receivable             |        | 5.0    |
      | LIABILITY | 145024       | Deferred Capitalized Income  | 5.0    |        |

  @TestRailId:C3702
  Scenario: Verify Capitalized Income adjustment reverse replay with backdated repayment transaction
    When Admin sets the business date to "20240101"
    And Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                                       | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_EMI_360_30_INTEREST_RECALC_DAILY_CAPITALIZED_INCOME_ADJ_CUSTOM_ALLOC | 20240101   | 150            | 7                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 3                 | MONTHS                | 1              | MONTHS                 | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240101" with "150" amount and expected disbursement date on "20240101"
    And Admin successfully disburse the loan on "20240101" with "100" EUR transaction amount
    And Admin adds capitalized income with "AUTOPAY" payment type to the loan on "20240101" with "50" EUR transaction amount
    When Admin sets the business date to "20240102"
    And Admin runs inline COB job for Loan
    Then Loan status will be "ACTIVE"
    When Admin sets the business date to "20240301"
    And Admin runs inline COB job for Loan
    And Admin adds capitalized income adjustment with "AUTOPAY" payment type to the loan on "20240301" with "50" EUR transaction amount
    Then Loan Transactions tab has the following data:
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
      | 20240201 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240201 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240202 | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240202 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240203 | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240203 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240204 | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240204 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240205 | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240205 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240206 | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240206 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240207 | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240207 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240208 | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240208 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240209 | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240209 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240210 | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240210 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240211 | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240211 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240212 | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240212 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240213 | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240213 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240214 | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240214 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240215 | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240215 | Capitalized Income Amortization | 0.54   | 0.0       | 0.54     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240216 | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240216 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240217 | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240217 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240218 | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240218 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240219 | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240219 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240220 | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240220 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240221 | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240221 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240222 | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240222 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240223 | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240223 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240224 | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240224 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240225 | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240225 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240226 | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240226 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240227 | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240227 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240228 | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240228 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240229 | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240229 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240301    | Capitalized Income Adjustment   | 50.0   | 49.71     | 0.29     | 0.0  | 0.0       | 100.29       | false    | false    |
    Then Loan Transactions tab has a "CAPITALIZED_INCOME_ADJUSTMENT" transaction with date "20240301" which has the following Journal entries:
      | Type      | Account code | Account name                | Debit | Credit |
      | ASSET     | 112601       | Loans Receivable            |       | 49.71  |
      | ASSET     | 112603       | Interest/Fee Receivable     |       | 0.29   |
      | LIABILITY | 145024       | Deferred Capitalized Income | 50.0  |        |
    When Customer makes "REPAYMENT" transaction with "AUTOPAY" payment type on "20240201" with 33.72 EUR transaction amount and system-generated Idempotency key
    Then Loan Transactions tab has the following data:
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
      | 20240201 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240201 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240201 | Repayment                       | 33.72  | 33.72     | 0.0      | 0.0  | 0.0       | 116.28       | false    | false    |
      | 20240202 | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240202 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240203 | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240203 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240204 | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240204 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240205 | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240205 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240206 | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240206 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240207 | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240207 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240208 | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240208 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240209 | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240209 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240210 | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240210 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240211 | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240211 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240212 | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240212 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240213 | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240213 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240214 | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240214 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240215 | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240215 | Capitalized Income Amortization | 0.54   | 0.0       | 0.54     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240216 | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240216 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240217 | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240217 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240218 | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240218 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240219 | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240219 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240220 | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240220 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240221 | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240221 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240222 | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240222 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240223 | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240223 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240224 | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240224 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240225 | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240225 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240226 | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240226 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240227 | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240227 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240228 | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240228 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240229 | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240229 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240301    | Capitalized Income Adjustment   | 50.0   | 49.13     | 0.87     | 0.0  | 0.0       | 67.15        | false    | true     |
    Then Loan Transactions tab has a "CAPITALIZED_INCOME_ADJUSTMENT" transaction with date "20240301" which has the following Journal entries:
      | Type      | Account code | Account name                | Debit | Credit |
      | ASSET     | 112601       | Loans Receivable            |       | 49.13  |
      | ASSET     | 112603       | Interest/Fee Receivable     |       | 0.87   |
      | LIABILITY | 145024       | Deferred Capitalized Income | 50.0  |        |

    When Loan Pay-off is made on "20240301"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C3703
  Scenario: Verify Capitalized Income adjustment reverse replay with backdated charge
    When Admin sets the business date to "20240101"
    And Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                                       | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_EMI_360_30_INTEREST_RECALC_DAILY_CAPITALIZED_INCOME_ADJ_CUSTOM_ALLOC | 20240101   | 151            | 7                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 3                 | MONTHS                | 1              | MONTHS                 | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240101" with "151" amount and expected disbursement date on "20240101"
    And Admin successfully disburse the loan on "20240101" with "100" EUR transaction amount
    And Admin adds capitalized income with "AUTOPAY" payment type to the loan on "20240101" with "51" EUR transaction amount
    When Admin sets the business date to "20240102"
    And Admin runs inline COB job for Loan
    Then Loan status will be "ACTIVE"
    When Admin sets the business date to "20240301"
    And Admin runs inline COB job for Loan
    And Admin adds capitalized income adjustment with "AUTOPAY" payment type to the loan on "20240301" with "51" EUR transaction amount
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type                | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement                    | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240101  | Capitalized Income              | 51.0   | 51.0      | 0.0      | 0.0  | 0.0       | 151.0        | false    | false    |
      | 20240101  | Capitalized Income Amortization | 0.56   | 0.0       | 0.56     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240102  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240102  | Capitalized Income Amortization | 0.56   | 0.0       | 0.56     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240103  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240103  | Capitalized Income Amortization | 0.56   | 0.0       | 0.56     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240104  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240104  | Capitalized Income Amortization | 0.56   | 0.0       | 0.56     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240105  | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240105  | Capitalized Income Amortization | 0.56   | 0.0       | 0.56     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240106  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240106  | Capitalized Income Amortization | 0.56   | 0.0       | 0.56     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240107  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240107  | Capitalized Income Amortization | 0.56   | 0.0       | 0.56     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240108  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240108  | Capitalized Income Amortization | 0.56   | 0.0       | 0.56     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240109  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240109  | Capitalized Income Amortization | 0.56   | 0.0       | 0.56     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240110  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240110  | Capitalized Income Amortization | 0.56   | 0.0       | 0.56     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240111  | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240111  | Capitalized Income Amortization | 0.56   | 0.0       | 0.56     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240112  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240112  | Capitalized Income Amortization | 0.57   | 0.0       | 0.57     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240113  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240113  | Capitalized Income Amortization | 0.56   | 0.0       | 0.56     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240114  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240114  | Capitalized Income Amortization | 0.56   | 0.0       | 0.56     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240115  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240115  | Capitalized Income Amortization | 0.56   | 0.0       | 0.56     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240116  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240116  | Capitalized Income Amortization | 0.56   | 0.0       | 0.56     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240117  | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240117  | Capitalized Income Amortization | 0.56   | 0.0       | 0.56     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240118  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240118  | Capitalized Income Amortization | 0.56   | 0.0       | 0.56     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240119  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240119  | Capitalized Income Amortization | 0.56   | 0.0       | 0.56     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240120  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240120  | Capitalized Income Amortization | 0.56   | 0.0       | 0.56     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240121  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240121  | Capitalized Income Amortization | 0.56   | 0.0       | 0.56     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240122  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240122  | Capitalized Income Amortization | 0.56   | 0.0       | 0.56     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240123  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240123  | Capitalized Income Amortization | 0.56   | 0.0       | 0.56     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240124  | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240124  | Capitalized Income Amortization | 0.56   | 0.0       | 0.56     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240125  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240125  | Capitalized Income Amortization | 0.56   | 0.0       | 0.56     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240126  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240126  | Capitalized Income Amortization | 0.56   | 0.0       | 0.56     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240127  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240127  | Capitalized Income Amortization | 0.56   | 0.0       | 0.56     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240128  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240128  | Capitalized Income Amortization | 0.56   | 0.0       | 0.56     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240129  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240129  | Capitalized Income Amortization | 0.56   | 0.0       | 0.56     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240130  | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240130  | Capitalized Income Amortization | 0.56   | 0.0       | 0.56     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240131  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240131  | Capitalized Income Amortization | 0.56   | 0.0       | 0.56     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240201 | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240201 | Capitalized Income Amortization | 0.56   | 0.0       | 0.56     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240202 | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240202 | Capitalized Income Amortization | 0.56   | 0.0       | 0.56     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240203 | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240203 | Capitalized Income Amortization | 0.56   | 0.0       | 0.56     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240204 | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240204 | Capitalized Income Amortization | 0.57   | 0.0       | 0.57     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240205 | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240205 | Capitalized Income Amortization | 0.56   | 0.0       | 0.56     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240206 | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240206 | Capitalized Income Amortization | 0.56   | 0.0       | 0.56     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240207 | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240207 | Capitalized Income Amortization | 0.56   | 0.0       | 0.56     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240208 | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240208 | Capitalized Income Amortization | 0.56   | 0.0       | 0.56     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240209 | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240209 | Capitalized Income Amortization | 0.56   | 0.0       | 0.56     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240210 | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240210 | Capitalized Income Amortization | 0.56   | 0.0       | 0.56     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240211 | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240211 | Capitalized Income Amortization | 0.56   | 0.0       | 0.56     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240212 | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240212 | Capitalized Income Amortization | 0.56   | 0.0       | 0.56     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240213 | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240213 | Capitalized Income Amortization | 0.56   | 0.0       | 0.56     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240214 | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240214 | Capitalized Income Amortization | 0.56   | 0.0       | 0.56     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240215 | Accrual                         | 0.04   | 0.0       | 0.04     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240215 | Capitalized Income Amortization | 0.56   | 0.0       | 0.56     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240216 | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240216 | Capitalized Income Amortization | 0.56   | 0.0       | 0.56     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240217 | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240217 | Capitalized Income Amortization | 0.56   | 0.0       | 0.56     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240218 | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240218 | Capitalized Income Amortization | 0.56   | 0.0       | 0.56     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240219 | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240219 | Capitalized Income Amortization | 0.56   | 0.0       | 0.56     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240220 | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240220 | Capitalized Income Amortization | 0.56   | 0.0       | 0.56     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240221 | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240221 | Capitalized Income Amortization | 0.56   | 0.0       | 0.56     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240222 | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240222 | Capitalized Income Amortization | 0.56   | 0.0       | 0.56     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240223 | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240223 | Capitalized Income Amortization | 0.56   | 0.0       | 0.56     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240224 | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240224 | Capitalized Income Amortization | 0.56   | 0.0       | 0.56     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240225 | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240225 | Capitalized Income Amortization | 0.56   | 0.0       | 0.56     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240226 | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240226 | Capitalized Income Amortization | 0.57   | 0.0       | 0.57     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240227 | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240227 | Capitalized Income Amortization | 0.56   | 0.0       | 0.56     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240228 | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240228 | Capitalized Income Amortization | 0.56   | 0.0       | 0.56     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240229 | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240229 | Capitalized Income Amortization | 0.56   | 0.0       | 0.56     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240301    | Capitalized Income Adjustment   | 51.0   | 50.12     | 0.88     | 0.0  | 0.0       | 100.88       | false    | false    |
    And Deferred Capitalized Income by external-id contains the following data:
      | Amount | Amortized Amount | Unrecognized Amount | Adjusted Amount | Charged Off Amount |
      | 51.0   | 0.0              | 0.0                 | 51.0            | 0.0                |
    Then Loan Transactions tab has a "CAPITALIZED_INCOME_ADJUSTMENT" transaction with date "20240301" which has the following Journal entries:
      | Type      | Account code | Account name                | Debit | Credit |
      | ASSET     | 112601       | Loans Receivable            |       | 50.12  |
      | ASSET     | 112603       | Interest/Fee Receivable     |       | 0.88   |
      | LIABILITY | 145024       | Deferred Capitalized Income | 51.0  |        |
    When Admin adds "LOAN_SNOOZE_FEE" due date charge with "20240201" due date and 10 EUR transaction amount
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type                | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement                    | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240101  | Capitalized Income              | 51.0   | 51.0      | 0.0      | 0.0  | 0.0       | 151.0        | false    | false    |
      | 20240101  | Capitalized Income Amortization | 0.56   | 0.0       | 0.56     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240102  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240102  | Capitalized Income Amortization | 0.56   | 0.0       | 0.56     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240103  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240103  | Capitalized Income Amortization | 0.56   | 0.0       | 0.56     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240104  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240104  | Capitalized Income Amortization | 0.56   | 0.0       | 0.56     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240105  | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240105  | Capitalized Income Amortization | 0.56   | 0.0       | 0.56     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240106  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240106  | Capitalized Income Amortization | 0.56   | 0.0       | 0.56     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240107  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240107  | Capitalized Income Amortization | 0.56   | 0.0       | 0.56     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240108  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240108  | Capitalized Income Amortization | 0.56   | 0.0       | 0.56     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240109  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240109  | Capitalized Income Amortization | 0.56   | 0.0       | 0.56     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240110  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240110  | Capitalized Income Amortization | 0.56   | 0.0       | 0.56     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240111  | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240111  | Capitalized Income Amortization | 0.56   | 0.0       | 0.56     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240112  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240112  | Capitalized Income Amortization | 0.57   | 0.0       | 0.57     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240113  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240113  | Capitalized Income Amortization | 0.56   | 0.0       | 0.56     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240114  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240114  | Capitalized Income Amortization | 0.56   | 0.0       | 0.56     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240115  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240115  | Capitalized Income Amortization | 0.56   | 0.0       | 0.56     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240116  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240116  | Capitalized Income Amortization | 0.56   | 0.0       | 0.56     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240117  | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240117  | Capitalized Income Amortization | 0.56   | 0.0       | 0.56     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240118  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240118  | Capitalized Income Amortization | 0.56   | 0.0       | 0.56     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240119  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240119  | Capitalized Income Amortization | 0.56   | 0.0       | 0.56     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240120  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240120  | Capitalized Income Amortization | 0.56   | 0.0       | 0.56     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240121  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240121  | Capitalized Income Amortization | 0.56   | 0.0       | 0.56     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240122  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240122  | Capitalized Income Amortization | 0.56   | 0.0       | 0.56     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240123  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240123  | Capitalized Income Amortization | 0.56   | 0.0       | 0.56     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240124  | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240124  | Capitalized Income Amortization | 0.56   | 0.0       | 0.56     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240125  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240125  | Capitalized Income Amortization | 0.56   | 0.0       | 0.56     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240126  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240126  | Capitalized Income Amortization | 0.56   | 0.0       | 0.56     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240127  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240127  | Capitalized Income Amortization | 0.56   | 0.0       | 0.56     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240128  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240128  | Capitalized Income Amortization | 0.56   | 0.0       | 0.56     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240129  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240129  | Capitalized Income Amortization | 0.56   | 0.0       | 0.56     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240130  | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240130  | Capitalized Income Amortization | 0.56   | 0.0       | 0.56     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240131  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240131  | Capitalized Income Amortization | 0.56   | 0.0       | 0.56     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240201 | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240201 | Capitalized Income Amortization | 0.56   | 0.0       | 0.56     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240202 | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240202 | Capitalized Income Amortization | 0.56   | 0.0       | 0.56     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240203 | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240203 | Capitalized Income Amortization | 0.56   | 0.0       | 0.56     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240204 | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240204 | Capitalized Income Amortization | 0.57   | 0.0       | 0.57     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240205 | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240205 | Capitalized Income Amortization | 0.56   | 0.0       | 0.56     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240206 | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240206 | Capitalized Income Amortization | 0.56   | 0.0       | 0.56     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240207 | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240207 | Capitalized Income Amortization | 0.56   | 0.0       | 0.56     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240208 | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240208 | Capitalized Income Amortization | 0.56   | 0.0       | 0.56     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240209 | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240209 | Capitalized Income Amortization | 0.56   | 0.0       | 0.56     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240210 | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240210 | Capitalized Income Amortization | 0.56   | 0.0       | 0.56     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240211 | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240211 | Capitalized Income Amortization | 0.56   | 0.0       | 0.56     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240212 | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240212 | Capitalized Income Amortization | 0.56   | 0.0       | 0.56     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240213 | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240213 | Capitalized Income Amortization | 0.56   | 0.0       | 0.56     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240214 | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240214 | Capitalized Income Amortization | 0.56   | 0.0       | 0.56     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240215 | Accrual                         | 0.04   | 0.0       | 0.04     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240215 | Capitalized Income Amortization | 0.56   | 0.0       | 0.56     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240216 | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240216 | Capitalized Income Amortization | 0.56   | 0.0       | 0.56     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240217 | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240217 | Capitalized Income Amortization | 0.56   | 0.0       | 0.56     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240218 | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240218 | Capitalized Income Amortization | 0.56   | 0.0       | 0.56     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240219 | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240219 | Capitalized Income Amortization | 0.56   | 0.0       | 0.56     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240220 | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240220 | Capitalized Income Amortization | 0.56   | 0.0       | 0.56     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240221 | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240221 | Capitalized Income Amortization | 0.56   | 0.0       | 0.56     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240222 | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240222 | Capitalized Income Amortization | 0.56   | 0.0       | 0.56     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240223 | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240223 | Capitalized Income Amortization | 0.56   | 0.0       | 0.56     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240224 | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240224 | Capitalized Income Amortization | 0.56   | 0.0       | 0.56     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240225 | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240225 | Capitalized Income Amortization | 0.56   | 0.0       | 0.56     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240226 | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240226 | Capitalized Income Amortization | 0.57   | 0.0       | 0.57     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240227 | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240227 | Capitalized Income Amortization | 0.56   | 0.0       | 0.56     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240228 | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240228 | Capitalized Income Amortization | 0.56   | 0.0       | 0.56     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240229 | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240229 | Capitalized Income Amortization | 0.56   | 0.0       | 0.56     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240301    | Capitalized Income Adjustment   | 51.0   | 50.04     | 0.88     | 0.08 | 0.0       | 100.96       | false    | true     |
    Then Loan Transactions tab has a "CAPITALIZED_INCOME_ADJUSTMENT" transaction with date "20240301" which has the following Journal entries:
      | Type      | Account code | Account name                | Debit | Credit |
      | ASSET     | 112601       | Loans Receivable            |       | 50.04  |
      | ASSET     | 112603       | Interest/Fee Receivable     |       | 0.96   |
      | LIABILITY | 145024       | Deferred Capitalized Income | 51.0  |        |
    And Deferred Capitalized Income by external-id contains the following data:
      | Amount | Amortized Amount | Unrecognized Amount | Adjusted Amount | Charged Off Amount |
      | 51.0   | 0.0              | 0.0                 | 51.0            | 0.0                |

    When Loan Pay-off is made on "20240301"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C3712
  Scenario: Verify Capitalized Income Adjustment validation - Total adjustment amount cannot exceed original transaction amount
    When Admin sets the business date to "20240101"
    And Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                                       | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_EMI_360_30_INTEREST_RECALC_DAILY_CAPITALIZED_INCOME_ADJ_CUSTOM_ALLOC | 20240101   | 150            | 7                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 3                 | MONTHS                | 1              | MONTHS                 | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240101" with "150" amount and expected disbursement date on "20240101"
    And Admin successfully disburse the loan on "20240101" with "100" EUR transaction amount
    And Admin adds capitalized income with "AUTOPAY" payment type to the loan on "20240101" with "50" EUR transaction amount
    Then Loan status will be "ACTIVE"
    When Admin sets the business date to "20240201"
    # Try to adjust more than original capitalized income amount (50 EUR) - should fail
    And Admin adds invalid capitalized income adjustment with "AUTOPAY" payment type to the loan on "20240201" with "60" EUR transaction amount

    When Loan Pay-off is made on "20240201"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C3713
  Scenario: Verify Capitalized Income Adjustment validation - Adjustment transaction date cannot be earlier than original transaction date
    When Admin sets the business date to "20240101"
    And Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                                       | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_EMI_360_30_INTEREST_RECALC_DAILY_CAPITALIZED_INCOME_ADJ_CUSTOM_ALLOC | 20240101   | 150            | 7                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 3                 | MONTHS                | 1              | MONTHS                 | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240101" with "150" amount and expected disbursement date on "20240101"
    And Admin successfully disburse the loan on "20240101" with "100" EUR transaction amount
    And Admin adds capitalized income with "AUTOPAY" payment type to the loan on "20240101" with "50" EUR transaction amount
    Then Loan status will be "ACTIVE"
    When Admin sets the business date to "20240201"
  # Try to adjust with date earlier than original transaction (20231231) - should fail
    And Admin adds invalid capitalized income adjustment with "AUTOPAY" payment type to the loan on "20241231" with "60" EUR transaction amount

    When Loan Pay-off is made on "20240201"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C3714
  Scenario: Verify Capitalized Income Adjustment validation - Multiple adjustments cannot exceed original amount
    When Admin sets the business date to "20240101"
    And Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                                       | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_EMI_360_30_INTEREST_RECALC_DAILY_CAPITALIZED_INCOME_ADJ_CUSTOM_ALLOC | 20240101   | 150            | 7                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 3                 | MONTHS                | 1              | MONTHS                 | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240101" with "150" amount and expected disbursement date on "20240101"
    And Admin successfully disburse the loan on "20240101" with "100" EUR transaction amount
    And Admin adds capitalized income with "AUTOPAY" payment type to the loan on "20240101" with "50" EUR transaction amount
    Then Loan status will be "ACTIVE"
    When Admin sets the business date to "20240201"
    And Admin adds capitalized income adjustment with "AUTOPAY" payment type to the loan on "20240201" with "30" EUR transaction amount
    When Admin sets the business date to "20240301"
  # Try to add another adjustment that would exceed total
    And Admin adds invalid capitalized income adjustment with "AUTOPAY" payment type to the loan on "20240301" with "25" EUR transaction amount

    When Loan Pay-off is made on "20240301"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C3715
  Scenario: Verify Capitalized Income Adjustment - Balance cannot go negative, set to zero instead
    When Admin sets the business date to "20240101"
    And Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                                       | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_EMI_360_30_INTEREST_RECALC_DAILY_CAPITALIZED_INCOME_ADJ_CUSTOM_ALLOC | 20240101   | 150            | 7                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 3                 | MONTHS                | 1              | MONTHS                 | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240101" with "150" amount and expected disbursement date on "20240101"
    And Admin successfully disburse the loan on "20240101" with "100" EUR transaction amount
    And Admin adds capitalized income with "AUTOPAY" payment type to the loan on "20240101" with "50" EUR transaction amount
    When Admin sets the business date to "20240201"
    When Customer makes "REPAYMENT" transaction with "AUTOPAY" payment type on "20240201" with 50.58 EUR transaction amount and system-generated Idempotency key
    When Admin sets the business date to "20240202"
    And Admin runs inline COB job for Loan
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101  |                  | 100.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      |    |      | 20240101  |                  | 50.0            |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 31   | 20240201 | 20240201 | 100.29          | 49.71         | 0.87     | 0.0  | 0.0       | 50.58 | 50.58 | 0.0        | 0.0  | 0.0         |
      | 2  | 29   | 20240301    |                  | 50.3            | 49.99         | 0.59     | 0.0  | 0.0       | 50.58 | 0.0   | 0.0        | 0.0  | 50.58       |
      | 3  | 31   | 20240401    |                  | 0.0             | 50.3          | 0.29     | 0.0  | 0.0       | 50.59 | 0.0   | 0.0        | 0.0  | 50.59       |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 150.0         | 1.75     | 0.00 | 0.00      | 151.75 | 50.58 | 0.0        | 0.0  | 101.17      |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type                | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20240101  | Disbursement                    | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    |
      | 20240101  | Capitalized Income              | 50.0   | 50.0      | 0.0      | 0.0  | 0.0       | 150.0        | false    |
      | 20240201 | Repayment                       | 50.58  | 49.71     | 0.87     | 0.0  | 0.0       | 100.29       | false    |
      | 20240201 | Accrual                         | 0.87   | 0.0       | 0.87     | 0.0  | 0.0       | 0.0          | false    |
      | 20240201 | Capitalized Income Amortization | 17.58  | 0.0       | 17.58    | 0.0  | 0.0       | 0.0          | false    |
    And Deferred Capitalized Income by external-id contains the following data:
      | Amount | Amortized Amount | Unrecognized Amount | Adjusted Amount | Charged Off Amount |
      | 50.0   | 17.58            | 32.42               | 0.0             | 0.0                |
    When Admin sets the business date to "20240301"
    When Customer makes "REPAYMENT" transaction with "AUTOPAY" payment type on "20240301" with 50.89 EUR transaction amount and system-generated Idempotency key
    When Admin sets the business date to "20240302"
    And Admin adds capitalized income adjustment with "AUTOPAY" payment type to the loan on "20240302" with "50" EUR transaction amount
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101  |                  | 100.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      |    |      | 20240101  |                  | 50.0            |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 31   | 20240201 | 20240201 | 100.29          | 49.71         | 0.87     | 0.0  | 0.0       | 50.58 | 50.58 | 0.0        | 0.0  | 0.0         |
      | 2  | 29   | 20240301    | 20240301    | 50.3            | 49.99         | 0.59     | 0.0  | 0.0       | 50.58 | 50.58 | 0.0        | 0.0  | 0.0         |
      | 3  | 31   | 20240401    | 20240302    | 0.0             | 50.3          | 0.01     | 0.0  | 0.0       | 50.31 | 50.31 | 50.31      | 0.0  | 0.0         |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late | Outstanding |
      | 150.0         | 1.47     | 0.00 | 0.00      | 151.47 | 151.47 | 50.31      | 0.0  | 0.0         |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type                             | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20240101  | Disbursement                                 | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    |
      | 20240101  | Capitalized Income                           | 50.0   | 50.0      | 0.0      | 0.0  | 0.0       | 150.0        | false    |
      | 20240201 | Repayment                                    | 50.58  | 49.71     | 0.87     | 0.0  | 0.0       | 100.29       | false    |
      | 20240201 | Accrual                                      | 0.87   | 0.0       | 0.87     | 0.0  | 0.0       | 0.0          | false    |
      | 20240201 | Capitalized Income Amortization              | 17.58  | 0.0       | 17.58    | 0.0  | 0.0       | 0.0          | false    |
      | 20240301    | Repayment                                    | 50.89  | 50.3      | 0.59     | 0.0  | 0.0       | 49.99        | false    |
      | 20240302    | Capitalized Income Adjustment                | 50.0   | 49.99     | 0.01     | 0.0  | 0.0       | 0.0          | false    |
      | 20240302    | Accrual                                      | 0.6    | 0.0       | 0.6      | 0.0  | 0.0       | 0.0          | false    |
      | 20240302    | Capitalized Income Amortization Adjustment   | 17.58   | 0.0      | 17.58    | 0.0  | 0.0       | 0.0          | false    |
    And Deferred Capitalized Income by external-id contains the following data:
      | Amount | Amortized Amount | Unrecognized Amount | Adjusted Amount | Charged Off Amount |
      | 50.0   | 0.0              | 0.0                 | 50.0            | 0.0                |

  @TestRailId:C3716
  Scenario: Verify Capitalized Income/Adjustment validation - Transaction date can't be in a future
    When Admin sets the business date to "20240101"
    And Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                                       | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_EMI_360_30_INTEREST_RECALC_DAILY_CAPITALIZED_INCOME_ADJ_CUSTOM_ALLOC | 20240101   | 150            | 7                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 3                 | MONTHS                | 1              | MONTHS                 | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240101" with "150" amount and expected disbursement date on "20240101"
    And Admin successfully disburse the loan on "20240101" with "50" EUR transaction amount
# try do add capitalized income with future date
    Then Capitalized income with payment type "AUTOPAY" on "20240201" is forbidden with amount "20" due to future date
    And Admin adds capitalized income with "AUTOPAY" payment type to the loan on "20240101" with "50" EUR transaction amount
    Then Loan status will be "ACTIVE"
    When Admin sets the business date to "20240201"
    Then Capitalized income with payment type "AUTOPAY" on "20240301" is forbidden with amount "20" due to future date
# try do add capitalized income adjustment with future date
    Then Capitalized income adjustment with payment type "AUTOPAY" on "20240301" is forbidden with amount "20" due to future date
    And Admin adds capitalized income adjustment with "AUTOPAY" payment type to the loan on "20240201" with "30" EUR transaction amount
    Then Capitalized income adjustment with payment type "AUTOPAY" on "20240401" is forbidden with amount "10" due to future date

    When Loan Pay-off is made on "20240201"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C3717
  Scenario: Verify Capitalized Income validation while run COB at first day of loan
    When Admin sets the business date to "20240101"
    And Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                                       | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_EMI_360_30_INTEREST_RECALC_DAILY_CAPITALIZED_INCOME_ADJ_CUSTOM_ALLOC | 20240101   | 150            | 7                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 3                 | MONTHS                | 1              | MONTHS                 | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240101" with "150" amount and expected disbursement date on "20240101"
    And Admin successfully disburse the loan on "20240101" with "100" EUR transaction amount
    And Admin adds capitalized income with "AUTOPAY" payment type to the loan on "20240101" with "50" EUR transaction amount
    And Admin runs inline COB job for Loan
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
      | Transaction date | Transaction Type                | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20240101  | Disbursement                    | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    |
      | 20240101  | Capitalized Income              | 50.0   | 50.0      | 0.0      | 0.0  | 0.0       | 150.0        | false    |
    When Admin sets the business date to "20240102"
    And Admin runs inline COB job for Loan
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type                | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement                    | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240101  | Capitalized Income              | 50.0   | 50.0      | 0.0      | 0.0  | 0.0       | 150.0        | false    | false    |
      | 20240101  | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |

    When Loan Pay-off is made on "20240102"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C3718
  Scenario: Verify Capitalized Income Adjustment validation while run COB at first day of loan
    When Admin sets the business date to "20240101"
    And Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                                       | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_EMI_360_30_INTEREST_RECALC_DAILY_CAPITALIZED_INCOME_ADJ_CUSTOM_ALLOC | 20240101   | 200            | 7                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 3                 | MONTHS                | 1              | MONTHS                 | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240101" with "200" amount and expected disbursement date on "20240101"
    And Admin successfully disburse the loan on "20240101" with "100" EUR transaction amount
    And Admin adds capitalized income with "AUTOPAY" payment type to the loan on "20240101" with "50" EUR transaction amount
    And Admin adds capitalized income adjustment with "AUTOPAY" payment type to the loan on "20240101" with "40" EUR transaction amount
    And Admin runs inline COB job for Loan
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
    When Admin sets the business date to "20240102"
    And Admin runs inline COB job for Loan
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type                | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement                    | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240101  | Capitalized Income              | 50.0   | 50.0      | 0.0      | 0.0  | 0.0       | 150.0        | false    | false    |
      | 20240101  | Capitalized Income Adjustment   | 40.0   | 40.0      | 0.0      | 0.0  | 0.0       | 110.0        | false    | false    |
      | 20240101  | Capitalized Income Amortization | 0.11   | 0.0       | 0.11     | 0.0  | 0.0       | 0.0          | false    | false    |
    And Deferred Capitalized Income by external-id contains the following data:
      | Amount | Amortized Amount | Unrecognized Amount | Adjusted Amount | Charged Off Amount |
      | 50.0   | 0.11             | 9.89                | 40.0            | 0.0                |

    When Loan Pay-off is made on "20240102"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C3704
  Scenario: Verify Capitalized Income adjustment reverse - UC1
    When Admin sets the business date to "20240101"
    And Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                                       | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_EMI_360_30_INTEREST_RECALC_DAILY_CAPITALIZED_INCOME_ADJ_CUSTOM_ALLOC | 20240101   | 150            | 7                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 3                 | MONTHS                | 1              | MONTHS                 | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240101" with "150" amount and expected disbursement date on "20240101"
    And Admin successfully disburse the loan on "20240101" with "100" EUR transaction amount
    And Admin adds capitalized income with "AUTOPAY" payment type to the loan on "20240101" with "50" EUR transaction amount
    When Admin sets the business date to "20240102"
    And Admin runs inline COB job for Loan
    Then Loan status will be "ACTIVE"
    When Admin sets the business date to "20240301"
    And Admin runs inline COB job for Loan
    And Admin adds capitalized income adjustment with "AUTOPAY" payment type to the loan on "20240301" with "40" EUR transaction amount
    Then Loan Transactions tab has the following data:
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
      | 20240201 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240201 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240202 | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240202 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240203 | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240203 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240204 | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240204 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240205 | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240205 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240206 | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240206 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240207 | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240207 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240208 | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240208 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240209 | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240209 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240210 | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240210 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240211 | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240211 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240212 | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240212 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240213 | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240213 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240214 | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240214 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240215 | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240215 | Capitalized Income Amortization | 0.54   | 0.0       | 0.54     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240216 | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240216 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240217 | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240217 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240218 | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240218 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240219 | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240219 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240220 | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240220 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240221 | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240221 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240222 | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240222 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240223 | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240223 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240224 | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240224 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240225 | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240225 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240226 | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240226 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240227 | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240227 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240228 | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240228 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240229 | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240229 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240301    | Capitalized Income Adjustment   | 40.0   | 40.0      | 0.0      | 0.0  | 0.0       | 110.0        | false    | false    |
    Then Loan Transactions tab has a "CAPITALIZED_INCOME_ADJUSTMENT" transaction with date "20240301" which has the following Journal entries:
      | Type      | Account code | Account name                | Debit | Credit |
      | ASSET     | 112601       | Loans Receivable            |       | 40.0   |
      | LIABILITY | 145024       | Deferred Capitalized Income | 40.0  |        |
    And Deferred Capitalized Income by external-id contains the following data:
      | Amount | Amortized Amount | Unrecognized Amount | Adjusted Amount | Charged Off Amount |
      | 50.0   | 10.0             | 0.0                 | 40.0            | 0.0                |
    When Admin sets the business date to "20240302"
    And Admin runs inline COB job for Loan
    And Customer undo "1"th capitalized income adjustment on "20240302"
    When Admin sets the business date to "20240303"
    And Admin runs inline COB job for Loan
    Then Loan Transactions tab has the following data:
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
      | 20240201 | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240201 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240202 | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240202 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240203 | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240203 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240204 | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240204 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240205 | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240205 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240206 | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240206 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240207 | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240207 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240208 | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240208 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240209 | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240209 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240210 | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240210 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240211 | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240211 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240212 | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240212 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240213 | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240213 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240214 | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240214 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240215 | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240215 | Capitalized Income Amortization | 0.54   | 0.0       | 0.54     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240216 | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240216 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240217 | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240217 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240218 | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240218 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240219 | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240219 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240220 | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240220 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240221 | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240221 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240222 | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240222 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240223 | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240223 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240224 | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240224 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240225 | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240225 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240226 | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240226 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240227 | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240227 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240228 | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240228 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240229 | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240229 | Capitalized Income Amortization | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240301    | Capitalized Income Adjustment   | 40.0   | 40.0      | 0.0      | 0.0  | 0.0       | 110.0        | true     | false    |
      | 20240301    | Capitalized Income Amortization Adjustment   | 22.97   | 0.0      | 22.97    | 0.0  | 0.0       | 0.0          | false     | false    |
      | 20240301    | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240302    | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240302    | Capitalized Income Amortization | 24.07  | 0.0       | 24.07    | 0.0  | 0.0       | 0.0          | false    | false    |
    Then Loan Transactions tab has a "CAPITALIZED_INCOME_ADJUSTMENT" transaction with date "20240301" which has the following Journal entries:
      | Type      | Account code | Account name                | Debit | Credit |
      | ASSET     | 112601       | Loans Receivable            |       | 40.0   |
      | LIABILITY | 145024       | Deferred Capitalized Income | 40.0  |        |
      | ASSET     | 112601       | Loans Receivable            | 40.0  |        |
      | LIABILITY | 145024       | Deferred Capitalized Income |       | 40.0   |
    And Deferred Capitalized Income by external-id contains the following data:
      | Amount | Amortized Amount | Unrecognized Amount | Adjusted Amount | Charged Off Amount |
      | 50.0   | 34.07            | 15.93               | 0.0             | 0.0                |

    When Loan Pay-off is made on "20240303"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C3705
  Scenario: Verify Capitalized Income adjustment reverse - UC2
    When Admin sets the business date to "20240101"
    And Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                                       | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_EMI_360_30_INTEREST_RECALC_DAILY_CAPITALIZED_INCOME_ADJ_CUSTOM_ALLOC | 20240101   | 150            | 7                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 3                 | MONTHS                | 1              | MONTHS                 | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240101" with "150" amount and expected disbursement date on "20240101"
    And Admin successfully disburse the loan on "20240101" with "100" EUR transaction amount
    And Admin adds capitalized income with "AUTOPAY" payment type to the loan on "20240101" with "50" EUR transaction amount
    When Admin sets the business date to "20240102"
    And Admin runs inline COB job for Loan
    Then Loan status will be "ACTIVE"
    When Admin sets the business date to "20240110"
    And Admin runs inline COB job for Loan
    And Admin adds capitalized income adjustment with "AUTOPAY" payment type to the loan on "20240110" with "40" EUR transaction amount
    When Admin sets the business date to "20240111"
    And Admin runs inline COB job for Loan
    Then Loan Transactions tab has the following data:
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
      | 20240110  | Capitalized Income Adjustment   | 40.0   | 40.0      | 0.0      | 0.0  | 0.0       | 110.0        | false    | false    |
      | 20240110  | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240110  | Capitalized Income Amortization | 0.06   | 0.0       | 0.06     | 0.0  | 0.0       | 0.0          | false    | false    |
    Then Loan Transactions tab has a "CAPITALIZED_INCOME_ADJUSTMENT" transaction with date "20240110" which has the following Journal entries:
      | Type      | Account code | Account name                | Debit | Credit |
      | ASSET     | 112601       | Loans Receivable            |       | 40.0   |
      | LIABILITY | 145024       | Deferred Capitalized Income | 40.0  |        |
    And Customer undo "1"th capitalized income adjustment on "20240111"
    When Admin sets the business date to "20240112"
    And Admin runs inline COB job for Loan
    Then Loan Transactions tab has the following data:
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
      | 20240110  | Capitalized Income Adjustment   | 40.0   | 40.0      | 0.0      | 0.0  | 0.0       | 110.0        | true     | false    |
      | 20240110  | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240110  | Capitalized Income Amortization | 0.06   | 0.0       | 0.06     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240111  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240111  | Capitalized Income Amortization | 1.03   | 0.0       | 1.03     | 0.0  | 0.0       | 0.0          | false    | false    |
    Then Loan Transactions tab has a "CAPITALIZED_INCOME_ADJUSTMENT" transaction with date "20240110" which has the following Journal entries:
      | Type      | Account code | Account name                | Debit | Credit |
      | ASSET     | 112601       | Loans Receivable            |       | 40.0   |
      | LIABILITY | 145024       | Deferred Capitalized Income | 40.0  |        |
      | ASSET     | 112601       | Loans Receivable            | 40.0  |        |
      | LIABILITY | 145024       | Deferred Capitalized Income |       |  40.0  |

    When Loan Pay-off is made on "20240112"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C3706
  Scenario: Verify Capitalized Income adjustment reverse - UC3
    When Admin sets the business date to "20240101"
    And Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                                       | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_EMI_360_30_INTEREST_RECALC_DAILY_CAPITALIZED_INCOME_ADJ_CUSTOM_ALLOC | 20240101   | 150            | 7                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 3                 | MONTHS                | 1              | MONTHS                 | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240101" with "150" amount and expected disbursement date on "20240101"
    And Admin successfully disburse the loan on "20240101" with "90" EUR transaction amount
    And Admin adds capitalized income with "AUTOPAY" payment type to the loan on "20240101" with "60" EUR transaction amount
    When Admin sets the business date to "20240102"
    And Admin runs inline COB job for Loan
    Then Loan status will be "ACTIVE"
    When Admin sets the business date to "20240110"
    And Admin runs inline COB job for Loan
    And Admin adds capitalized income adjustment with "AUTOPAY" payment type to the loan on "20240110" with "55" EUR transaction amount
    When Admin sets the business date to "20240111"
    And Admin runs inline COB job for Loan
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type                | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement                    | 90.0   | 0.0       | 0.0      | 0.0  | 0.0       | 90.0         | false    | false    |
      | 20240101  | Capitalized Income              | 60.0   | 60.0      | 0.0      | 0.0  | 0.0       | 150.0        | false    | false    |
      | 20240101  | Capitalized Income Amortization | 0.66   | 0.0       | 0.66     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240102  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240102  | Capitalized Income Amortization | 0.66   | 0.0       | 0.66     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240103  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240103  | Capitalized Income Amortization | 0.66   | 0.0       | 0.66     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240104  | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240104  | Capitalized Income Amortization | 0.66   | 0.0       | 0.66     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240105  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240105  | Capitalized Income Amortization | 0.66   | 0.0       | 0.66     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240106  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240106  | Capitalized Income Amortization | 0.66   | 0.0       | 0.66     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240107  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240107  | Capitalized Income Amortization | 0.66   | 0.0       | 0.66     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240108  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240108  | Capitalized Income Amortization | 0.65   | 0.0       | 0.65     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240109  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240109  | Capitalized Income Amortization | 0.66   | 0.0       | 0.66     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240110  | Capitalized Income Adjustment   | 55.0   | 54.75     | 0.25     | 0.0  | 0.0       | 95.25        | false    | false    |
      | 20240110  | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240110  | Capitalized Income Amortization Adjustment | 0.93   | 0.0       | 0.93     | 0.0  | 0.0       | 0.0          | false    | false    |
    Then Loan Transactions tab has a "CAPITALIZED_INCOME_ADJUSTMENT" transaction with date "20240110" which has the following Journal entries:
      | Type      | Account code | Account name                | Debit | Credit |
      | ASSET     | 112601       | Loans Receivable            |       | 54.75  |
      | ASSET     | 112603       | Interest/Fee Receivable     |       | 0.25   |
      | LIABILITY | 145024       | Deferred Capitalized Income | 55.0  |        |
    Then Customer is forbidden to undo "1"th "Capitalized Income" transaction made on "20240101" due to adjustment exists
    And Customer undo "1"th capitalized income adjustment on "20240111"
    When Admin sets the business date to "20240112"
    And Admin runs inline COB job for Loan
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type                | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement                    | 90.0   | 0.0       | 0.0      | 0.0  | 0.0       | 90.0         | false    | false    |
      | 20240101  | Capitalized Income              | 60.0   | 60.0      | 0.0      | 0.0  | 0.0       | 150.0        | false    | false    |
      | 20240101  | Capitalized Income Amortization | 0.66   | 0.0       | 0.66     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240102  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240102  | Capitalized Income Amortization | 0.66   | 0.0       | 0.66     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240103  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240103  | Capitalized Income Amortization | 0.66   | 0.0       | 0.66     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240104  | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240104  | Capitalized Income Amortization | 0.66   | 0.0       | 0.66     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240105  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240105  | Capitalized Income Amortization | 0.66   | 0.0       | 0.66     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240106  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240106  | Capitalized Income Amortization | 0.66   | 0.0       | 0.66     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240107  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240107  | Capitalized Income Amortization | 0.66   | 0.0       | 0.66     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240108  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240108  | Capitalized Income Amortization | 0.65   | 0.0       | 0.65     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240109  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240109  | Capitalized Income Amortization | 0.66   | 0.0       | 0.66     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240110  | Capitalized Income Adjustment   | 55.0   | 54.75     | 0.25     | 0.0  | 0.0       | 95.25        | true    | false    |
      | 20240110  | Accrual                         | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240110  | Capitalized Income Amortization Adjustment | 0.93   | 0.0       | 0.93     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240111  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240111  | Capitalized Income Amortization | 2.25   | 0.0       | 2.25     | 0.0  | 0.0       | 0.0          | false    | false    |
    Then Loan Transactions tab has a "CAPITALIZED_INCOME_ADJUSTMENT" transaction with date "20240110" which has the following Journal entries:
      | Type      | Account code | Account name                | Debit | Credit |
      | ASSET     | 112601       | Loans Receivable            |       | 54.75  |
      | ASSET     | 112603       | Interest/Fee Receivable     |       |  0.25  |
      | LIABILITY | 145024       | Deferred Capitalized Income | 55.0  |        |
      | ASSET     | 112601       | Loans Receivable            | 54.75 |        |
      | ASSET     | 112603       | Interest/Fee Receivable     |  0.25 |        |
      | LIABILITY | 145024       | Deferred Capitalized Income |       | 55.0   |

    When Loan Pay-off is made on "20240112"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C3756
  Scenario: Verify Capitalised Income Adjustment reversed on same biz date when added - UC4
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
    And Admin adds capitalized income with "AUTOPAY" payment type to the loan on "20240101" with "100" EUR transaction amount
    When Admin sets the business date to "20240102"
    And Admin runs inline COB job for Loan
    When Admin sets the business date to "20240103"
    And Admin runs inline COB job for Loan
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type                | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement                    | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240101  | Capitalized Income              | 100.0  | 100.0     | 0.0      | 0.0  | 0.0       | 200.0        | false    | false    |
      | 20240101  | Capitalized Income Amortization | 1.1    | 0.0       | 1.1      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240102  | Accrual                         | 0.04   | 0.0       | 0.04     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240102  | Capitalized Income Amortization | 1.1    | 0.0       | 1.1      | 0.0  | 0.0       | 0.0          | false    | false    |
    And Admin adds capitalized income adjustment with "AUTOPAY" payment type to the loan on "20240103" with "100" EUR trn amount with "20240101" date for capitalized income
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type                | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement                    | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240101  | Capitalized Income              | 100.0  | 100.0     | 0.0      | 0.0  | 0.0       | 200.0        | false    | false    |
      | 20240101  | Capitalized Income Amortization | 1.1    | 0.0       | 1.1      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240102  | Accrual                         | 0.04   | 0.0       | 0.04     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240102  | Capitalized Income Amortization | 1.1    | 0.0       | 1.1      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240103  | Capitalized Income Adjustment   | 100.0  | 99.92     | 0.08     | 0.0  | 0.0       | 100.08       | false    | false    |
# -- undo Capitalized Income Adjustment transaction at the same biz date when it was added -- #
    When Customer undo "1"th "Capitalized Income Adjustment" transaction made on "20240103"
    When Admin sets the business date to "20240105"
    And Admin runs inline COB job for Loan
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date  | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101  |            | 100.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      |    |      | 20240101  |            | 100.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 31   | 20240201 |            | 133.72          | 66.28         | 1.17     | 0.0  | 0.0       | 67.45 | 0.0   | 0.0        | 0.0  | 67.45       |
      | 2  | 29   | 20240301    |            | 67.05           | 66.67         | 0.78     | 0.0  | 0.0       | 67.45 | 0.0   | 0.0        | 0.0  | 67.45       |
      | 3  | 31   | 20240401    |            | 0.0             | 67.05         | 0.39     | 0.0  | 0.0       | 67.44 | 0.0   | 0.0        | 0.0  | 67.44       |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 200.0         | 2.34     | 0.00 | 0.00      | 202.34 | 0.0   | 0.0        | 0.0  | 202.34      |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type                | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement                    | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240101  | Capitalized Income              | 100.0  | 100.0     | 0.0      | 0.0  | 0.0       | 200.0        | false    | false    |
      | 20240101  | Capitalized Income Amortization | 1.1    | 0.0       | 1.1      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240102  | Accrual                         | 0.04   | 0.0       | 0.04     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240102  | Capitalized Income Amortization | 1.1    | 0.0       | 1.1      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240103  | Capitalized Income Adjustment   | 100.0  | 99.92     | 0.08     | 0.0  | 0.0       | 100.08       | true     | false    |
      | 20240103  | Accrual                         | 0.04   | 0.0       | 0.04     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240103  | Capitalized Income Amortization | 1.1    | 0.0       | 1.1      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240104  | Accrual                         | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240104  | Capitalized Income Amortization | 1.1    | 0.0       | 1.1      | 0.0  | 0.0       | 0.0          | false    | false    |

    When Loan Pay-off is made on "20240105"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C3708
  Scenario: Verify capitalized income reversed after repayment - UC1
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
    And Admin sets the business date to "20240201"
    And Admin runs inline COB job for Loan
    And Customer makes "AUTOPAY" repayment on "20240201" with 50.58 EUR transaction amount
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date                | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101     |                  | 100.0           |               |          | 0.0  |           | 0.0    | 0.0   |            |      |             |
      |    |      | 20240101     |                  |  50.0           |               |          | 0.0  |           | 0.0    | 0.0   |            |      |             |
      | 1  | 31   | 20240201    | 20240201 | 100.29          |  49.71        | 0.87     | 0.0  | 0.0       | 50.58  | 50.58 | 0.0        | 0.0  |  0.0        |
      | 2  | 29   | 20240301       |                  |  50.3           |  49.99        | 0.59     | 0.0  | 0.0       | 50.58  | 0.0   | 0.0        | 0.0  | 50.58       |
      | 3  | 31   | 20240401       |                  |   0.0           |  50.3         | 0.29     | 0.0  | 0.0       | 50.59  | 0.0   | 0.0        | 0.0  | 50.59       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid  | In advance | Late | Outstanding |
      | 150.0         | 1.75     | 0.0  | 0.0       | 151.75  | 50.58 | 0.0        | 0.0  | 101.17      |
    Then Loan Transactions tab has the following data:
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
    And Loan Transactions tab has a "CAPITALIZED_INCOME_AMORTIZATION" transaction with date "20240101" which has the following Journal entries:
      | Type      | Account code | Account name                | Debit | Credit |
      | INCOME    | 404000       | Interest Income             |       | 0.55   |
      | LIABILITY | 145024       | Deferred Capitalized Income | 0.55  |        |
    And Admin sets the business date to "20240214"
    And Admin runs inline COB job for Loan
    When Customer undo "1"th "Capitalized Income" transaction made on "20240101"
    And Admin sets the business date to "20240215"
    And Admin runs inline COB job for Loan
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type                           | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement                               | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240101  | Capitalized Income                         | 50.0   | 50.0      | 0.0      | 0.0  | 0.0       | 150.0        | true     | false    |
      | 20240101  | Capitalized Income Amortization            | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240102  | Accrual                                    | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240102  | Capitalized Income Amortization            | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240103  | Accrual                                    | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240103  | Capitalized Income Amortization            | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240104  | Accrual                                    | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240104  | Capitalized Income Amortization            | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240105  | Accrual                                    | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240105  | Capitalized Income Amortization            | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240106  | Accrual                                    | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240106  | Capitalized Income Amortization            | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240107  | Accrual                                    | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240107  | Capitalized Income Amortization            | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240108  | Accrual                                    | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240108  | Capitalized Income Amortization            | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240109  | Accrual                                    | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240109  | Capitalized Income Amortization            | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240110  | Accrual                                    | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240110  | Capitalized Income Amortization            | 0.54   | 0.0       | 0.54     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240111  | Accrual                                    | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240111  | Capitalized Income Amortization            | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240112  | Accrual                                    | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240112  | Capitalized Income Amortization            | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240113  | Accrual                                    | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240113  | Capitalized Income Amortization            | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240114  | Accrual                                    | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240114  | Capitalized Income Amortization            | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240115  | Accrual                                    | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240115  | Capitalized Income Amortization            | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240116  | Accrual                                    | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240116  | Capitalized Income Amortization            | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240117  | Accrual                                    | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240117  | Capitalized Income Amortization            | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240118  | Accrual                                    | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240118  | Capitalized Income Amortization            | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240119  | Accrual                                    | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240119  | Capitalized Income Amortization            | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240120  | Accrual                                    | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240120  | Capitalized Income Amortization            | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240121  | Accrual                                    | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240121  | Capitalized Income Amortization            | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240122  | Accrual                                    | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240122  | Capitalized Income Amortization            | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240123  | Accrual                                    | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240123  | Capitalized Income Amortization            | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240124  | Accrual                                    | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240124  | Capitalized Income Amortization            | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240125  | Accrual                                    | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240125  | Capitalized Income Amortization            | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240126  | Accrual                                    | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240126  | Capitalized Income Amortization            | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240127  | Accrual                                    | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240127  | Capitalized Income Amortization            | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240128  | Accrual                                    | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240128  | Capitalized Income Amortization            | 0.54   | 0.0       | 0.54     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240129  | Accrual                                    | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240129  | Capitalized Income Amortization            | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240130  | Accrual                                    | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240130  | Capitalized Income Amortization            | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240131  | Accrual                                    | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240131  | Capitalized Income Amortization            | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240201 | Repayment                                  | 50.58  | 50.0      | 0.58     | 0.0  | 0.0       | 50.0         | false    | true     |
      | 20240201 | Accrual                                    | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240201 | Capitalized Income Amortization            | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240202 | Accrual                                    | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240202 | Capitalized Income Amortization            | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240203 | Accrual                                    | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240203 | Capitalized Income Amortization            | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240204 | Accrual                                    | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240204 | Capitalized Income Amortization            | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240205 | Accrual                                    | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240205 | Capitalized Income Amortization            | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240206 | Accrual                                    | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240206 | Capitalized Income Amortization            | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240207 | Accrual                                    | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240207 | Capitalized Income Amortization            | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240208 | Accrual                                    | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240208 | Capitalized Income Amortization            | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240209 | Accrual                                    | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240209 | Capitalized Income Amortization            | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240210 | Accrual                                    | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240210 | Capitalized Income Amortization            | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240211 | Accrual                                    | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240211 | Capitalized Income Amortization            | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240212 | Accrual                                    | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240212 | Capitalized Income Amortization            | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240213 | Accrual                                    | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240213 | Capitalized Income Amortization            | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240214 | Accrual Adjustment                         | 0.4    | 0.0       | 0.4      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240214 | Capitalized Income Amortization Adjustment | 24.18  | 0.0       | 24.18    | 0.0  | 0.0       | 0.0          | false    | false    |
    And Loan Transactions tab has a "CAPITALIZED_INCOME_AMORTIZATION_ADJUSTMENT" transaction with date "20240214" which has the following Journal entries:
      | Type      | Account code | Account name                | Debit | Credit |
      | INCOME    | 404000       | Interest Income             | 24.18 |        |
      | LIABILITY | 145024       | Deferred Capitalized Income |       | 24.18  |
    And Admin sets the business date to "20240216"
    And Admin runs inline COB job for Loan
    And Admin adds capitalized income with "AUTOPAY" payment type to the loan on "20240216" with "50" EUR transaction amount
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date                | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101     |                  | 100.0           |               |          | 0.0  |           | 0.0    | 0.0   |            |      |             |
      | 1  | 31   | 20240201    | 20240201 | 66.86           |  33.14        | 0.58     | 0.0  | 0.0       | 33.72  | 33.72 | 0.0        | 0.0  |  0.0        |
      |    |      | 20240216    |                  |  50.0           |               |          | 0.0  |           | 0.0    | 0.0   |            |      |             |
      | 2  | 29   | 20240301       |                  |  58.43          |  58.43        | 0.43     | 0.0  | 0.0       | 58.86  | 16.86 | 16.86      | 0.0  | 42.0        |
      | 3  | 31   | 20240401       |                  |   0.0           |  58.43        | 0.34     | 0.0  | 0.0       | 58.77  | 0.0   | 0.0        | 0.0  | 58.77       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid  | In advance | Late | Outstanding |
      | 150.0         | 1.35     | 0.0  | 0.0       | 151.35  | 50.58 | 16.86      | 0.0  | 100.77      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type                           | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement                               | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240101  | Capitalized Income                         | 50.0   | 50.0      | 0.0      | 0.0  | 0.0       | 150.0        | true     | false    |
      | 20240101  | Capitalized Income Amortization            | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240102  | Accrual                                    | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240102  | Capitalized Income Amortization            | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240103  | Accrual                                    | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240103  | Capitalized Income Amortization            | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240104  | Accrual                                    | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240104  | Capitalized Income Amortization            | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240105  | Accrual                                    | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240105  | Capitalized Income Amortization            | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240106  | Accrual                                    | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240106  | Capitalized Income Amortization            | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240107  | Accrual                                    | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240107  | Capitalized Income Amortization            | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240108  | Accrual                                    | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240108  | Capitalized Income Amortization            | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240109  | Accrual                                    | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240109  | Capitalized Income Amortization            | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240110  | Accrual                                    | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240110  | Capitalized Income Amortization            | 0.54   | 0.0       | 0.54     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240111  | Accrual                                    | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240111  | Capitalized Income Amortization            | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240112  | Accrual                                    | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240112  | Capitalized Income Amortization            | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240113  | Accrual                                    | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240113  | Capitalized Income Amortization            | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240114  | Accrual                                    | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240114  | Capitalized Income Amortization            | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240115  | Accrual                                    | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240115  | Capitalized Income Amortization            | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240116  | Accrual                                    | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240116  | Capitalized Income Amortization            | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240117  | Accrual                                    | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240117  | Capitalized Income Amortization            | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240118  | Accrual                                    | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240118  | Capitalized Income Amortization            | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240119  | Accrual                                    | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240119  | Capitalized Income Amortization            | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240120  | Accrual                                    | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240120  | Capitalized Income Amortization            | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240121  | Accrual                                    | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240121  | Capitalized Income Amortization            | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240122  | Accrual                                    | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240122  | Capitalized Income Amortization            | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240123  | Accrual                                    | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240123  | Capitalized Income Amortization            | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240124  | Accrual                                    | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240124  | Capitalized Income Amortization            | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240125  | Accrual                                    | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240125  | Capitalized Income Amortization            | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240126  | Accrual                                    | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240126  | Capitalized Income Amortization            | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240127  | Accrual                                    | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240127  | Capitalized Income Amortization            | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240128  | Accrual                                    | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240128  | Capitalized Income Amortization            | 0.54   | 0.0       | 0.54     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240129  | Accrual                                    | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240129  | Capitalized Income Amortization            | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240130  | Accrual                                    | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240130  | Capitalized Income Amortization            | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240131  | Accrual                                    | 0.03   | 0.0       | 0.03     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240131  | Capitalized Income Amortization            | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240201 | Repayment                                  | 50.58  | 50.0      | 0.58     | 0.0  | 0.0       | 50.0         | false    | true     |
      | 20240201 | Accrual                                    | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240201 | Capitalized Income Amortization            | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240202 | Accrual                                    | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240202 | Capitalized Income Amortization            | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240203 | Accrual                                    | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240203 | Capitalized Income Amortization            | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240204 | Accrual                                    | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240204 | Capitalized Income Amortization            | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240205 | Accrual                                    | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240205 | Capitalized Income Amortization            | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240206 | Accrual                                    | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240206 | Capitalized Income Amortization            | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240207 | Accrual                                    | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240207 | Capitalized Income Amortization            | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240208 | Accrual                                    | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240208 | Capitalized Income Amortization            | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240209 | Accrual                                    | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240209 | Capitalized Income Amortization            | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240210 | Accrual                                    | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240210 | Capitalized Income Amortization            | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240211 | Accrual                                    | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240211 | Capitalized Income Amortization            | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240212 | Accrual                                    | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240212 | Capitalized Income Amortization            | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240213 | Accrual                                    | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240213 | Capitalized Income Amortization            | 0.55   | 0.0       | 0.55     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240214 | Accrual Adjustment                         | 0.4    | 0.0       | 0.4      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240214 | Capitalized Income Amortization Adjustment | 24.18  | 0.0       | 24.18    | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240215 | Accrual                                    | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240216 | Capitalized Income                         | 50.0   | 50.0      | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
    Then LoanCapitalizedIncomeAmortizationAdjustmentTransactionCreatedBusinessEvent is raised on "20240214"
    Then Customer is forbidden to undo "1"th "Capitalized Income" transaction made on "20240101" due to transaction type is non-reversal

    When Loan Pay-off is made on "20240216"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C3737
  Scenario: Verify overpayment amount when capitalized income transactions are reversed and replayed - basic flow
    When Admin sets the business date to "20240101"
    And Admin creates a client with random data
    And Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                      | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_EMI_360_30_INTEREST_RECALC_DAILY_CAPITALIZED_INCOME | 20240101   | 1200           | 7                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 3                 | MONTHS                | 1              | MONTHS                 | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240101" with "1200" amount and expected disbursement date on "20240101"
    And Admin successfully disburse the loan on "20240101" with "1000" EUR transaction amount
    Then Loan status will be "ACTIVE"
    When Admin sets the business date to "20240105"
    And Admin adds capitalized income with "AUTOPAY" payment type to the loan on "20240105" with "200" EUR transaction amount
    Then Loan has 1213.88 outstanding amount
  # Make overpayment
    When Customer makes "REPAYMENT" transaction with "AUTOPAY" payment type on "20240105" with 1300 EUR transaction amount and system-generated Idempotency key
    Then Loan status will be "OVERPAID"
    And Loan has 0 outstanding amount
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type                | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20240101  | Disbursement                    | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       | false    |
      | 20240105  | Capitalized Income              | 200.0  | 200.0     | 0.0      | 0.0  | 0.0       | 1200.0       | false    |
      | 20240105  | Repayment                       | 1300.0 | 1200.0    | 0.75     | 0.0  | 0.0       | 0.0          | false    |
      | 20240105  | Accrual                         | 0.75   | 0.0       | 0.75     | 0.0  | 0.0       | 0.0          | false    |
      | 20240105  | Capitalized Income Amortization | 200.0  | 0.0       | 200.0    | 0.0  | 0.0       | 0.0          | false    |
  # Undo capitalized income - should trigger reverse-replay
    When Customer undo "1"th "Capitalized Income" transaction made on "20240105"
    Then Loan has 0 outstanding amount
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type                           | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement                               | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       | false    | false    |
      | 20240105  | Capitalized Income                         | 200.0  | 200.0     | 0.0      | 0.0  | 0.0       | 1200.0       | true     | false    |
      | 20240105  | Accrual                                    | 0.75   | 0.0       | 0.75     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240105  | Capitalized Income Amortization            | 200.0  | 0.0       | 200.0    | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240105  | Repayment                                  | 1300.0 | 1000.0    | 0.75     | 0.0  | 0.0       | 0.0          | false    | true     |
      | 20240105  | Capitalized Income Amortization Adjustment | 200.0  | 0.0       | 200.0    | 0.0  | 0.0       | 0.0          | false    | false    |
    Then Loan status will be "OVERPAID"
    Then Loan has 299.25 overpaid amount

    When Admin makes Credit Balance Refund transaction on "20240105" with 299.25 EUR transaction amount
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C3739
  Scenario: Verify multiple capitalized income transactions reversal with overpayment - selective middle transaction reversal
    When Admin sets the business date to "20240101"
    And Admin creates a client with random data
    And Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                      | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_EMI_360_30_INTEREST_RECALC_DAILY_CAPITALIZED_INCOME | 20240101   | 1600           | 7                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 3                 | MONTHS                | 1              | MONTHS                 | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240101" with "1600" amount and expected disbursement date on "20240101"
    And Admin successfully disburse the loan on "20240101" with "1000" EUR transaction amount
    Then Loan status will be "ACTIVE"
    When Admin sets the business date to "20240105"
    And Admin adds capitalized income with "AUTOPAY" payment type to the loan on "20240105" with "100" EUR transaction amount
    When Admin sets the business date to "20240110"
    And Admin adds capitalized income with "AUTOPAY" payment type to the loan on "20240110" with "150" EUR transaction amount
    When Admin sets the business date to "20240115"
    And Admin adds capitalized income with "AUTOPAY" payment type to the loan on "20240115" with "200" EUR transaction amount
    Then Loan has 1466.08 outstanding amount
  # Overpay the loan
    When Customer makes "REPAYMENT" transaction with "AUTOPAY" payment type on "20240115" with 1500 EUR transaction amount and system-generated Idempotency key
    Then Loan status will be "OVERPAID"
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type                | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20240101  | Disbursement                    | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       | false    |
      | 20240105  | Capitalized Income              | 100.0  | 100.0     | 0.0      | 0.0  | 0.0       | 1100.0       | false    |
      | 20240110  | Capitalized Income              | 150.0  | 150.0     | 0.0      | 0.0  | 0.0       | 1250.0       | false    |
      | 20240115  | Capitalized Income              | 200.0  | 200.0     | 0.0      | 0.0  | 0.0       | 1450.0       | false    |
      | 20240115  | Repayment                       | 1500.0 | 1450.0    | 2.96     | 0.0  | 0.0       | 0.0          | false    |
      | 20240115  | Accrual                         | 2.96   | 0.0       | 2.96     | 0.0  | 0.0       | 0.0          | false    |
      | 20240115  | Capitalized Income Amortization | 450.0  | 0.0       | 450.0    | 0.0  | 0.0       | 0.0          | false    |
  # Undo middle capitalized income transaction
    When Customer undo "1"th "Capitalized Income" transaction made on "20240110"
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type                           | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement                               | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       | false    | false    |
      | 20240105  | Capitalized Income                         | 100.0  | 100.0     | 0.0      | 0.0  | 0.0       | 1100.0       | false    | false    |
      | 20240110  | Capitalized Income                         | 150.0  | 150.0     | 0.0      | 0.0  | 0.0       | 1250.0       | true     | false    |
      | 20240115  | Capitalized Income                         | 200.0  | 200.0     | 0.0      | 0.0  | 0.0       | 1300.0       | false    | false    |
      | 20240115  | Accrual                                    | 2.96   | 0.0       | 2.96     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240115  | Capitalized Income Amortization            | 450.0  | 0.0       | 450.0    | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240115  | Repayment                                  | 1500.0 | 1300.0    | 2.82     | 0.0  | 0.0       | 0.0          | false    | true     |
      | 20240115  | Capitalized Income Amortization Adjustment | 150.0  | 0.0       | 150.0    | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240115  | Accrual Adjustment                         | 0.14   | 0.0       | 0.14     | 0.0  | 0.0       | 0.0          | false    | false    |
    Then Loan status will be "OVERPAID"
    Then Loan has 197.18 overpaid amount

    When Admin makes Credit Balance Refund transaction on "20240115" with 197.18 EUR transaction amount
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C3740
  Scenario: Verify capitalized income reversal with partial repayment when loan transitions from active to overpaid state
    When Admin sets the business date to "20240101"
    And Admin creates a client with random data
    And Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                      | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_EMI_360_30_INTEREST_RECALC_DAILY_CAPITALIZED_INCOME | 20240101   | 1800           | 7                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 3                 | MONTHS                | 1              | MONTHS                 | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240101" with "1800" amount and expected disbursement date on "20240101"
    And Admin successfully disburse the loan on "20240101" with "1000" EUR transaction amount
    Then Loan status will be "ACTIVE"
    When Admin sets the business date to "20240105"
    And Admin adds capitalized income with "AUTOPAY" payment type to the loan on "20240105" with "500" EUR transaction amount
    Then Loan has 1517.15 outstanding amount
  # Partial payment
    When Customer makes "REPAYMENT" transaction with "AUTOPAY" payment type on "20240105" with 1200 EUR transaction amount and system-generated Idempotency key
    Then Loan status will be "ACTIVE"
    And Loan has 305.78 outstanding amount
  # Undo capitalized income - this should cause overpayment
    When Customer undo "1"th "Capitalized Income" transaction made on "20240105"
    Then Loan status will be "OVERPAID"
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type   | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement       | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       | false    | false    |
      | 20240105  | Capitalized Income | 500.0  | 500.0     | 0.0      | 0.0  | 0.0       | 1500.0       | true     | false    |
      | 20240105  | Repayment          | 1200.0 | 1000.0    | 0.75     | 0.0  | 0.0       | 0.0          | false    | true    |
      | 20240105  | Accrual            | 0.75   | 0.0       | 0.75     | 0.0  | 0.0       | 0.0          | false    | false    |
    And Loan has 0.0 outstanding amount
    And Loan has 199.25 overpaid amount

    When Admin makes Credit Balance Refund transaction on "20240105" with 199.25 EUR transaction amount
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C3741
  Scenario: Verify backdated disbursement with capitalized income and overpayment reverse-replay
    When Admin sets the business date to "20240101"
    And Admin creates a client with random data
    And Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                                     | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_EMI_360_30_INTEREST_RECALC_DAILY_MULTIDISBURSAL_CAPITALIZED_INCOME | 20240101   | 1200           | 7                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 3                 | MONTHS                | 1              | MONTHS                 | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240101" with "1200" amount and expected disbursement date on "20240101"
    And Admin successfully disburse the loan on "20240101" with "500" EUR transaction amount
    Then Loan status will be "ACTIVE"
    When Admin sets the business date to "20240110"
    And Admin adds capitalized income with "AUTOPAY" payment type to the loan on "20240110" with "200" EUR transaction amount
  # Overpay current balance
    When Customer makes "REPAYMENT" transaction with "AUTOPAY" payment type on "20240110" with 750 EUR transaction amount and system-generated Idempotency key
    Then Loan status will be "OVERPAID"
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type                | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20240101  | Disbursement                    | 500.0  | 0.0       | 0.0      | 0.0  | 0.0       | 500.0        | false    |
      | 20240110  | Capitalized Income              | 200.0  | 200.0     | 0.0      | 0.0  | 0.0       | 700.0        | false    |
      | 20240110  | Repayment                       | 750.0  | 700.0     | 0.85     | 0.0  | 0.0       | 0.0          | false    |
      | 20240110  | Accrual                         | 0.85   | 0.0       | 0.85     | 0.0  | 0.0       | 0.0          | false    |
      | 20240110  | Capitalized Income Amortization | 200.0  | 0.0       | 200.0    | 0.0  | 0.0       | 0.0          | false    |
  # Backdated disbursement should trigger reverse-replay
    When Admin successfully disburse the loan on "20240105" with "300" EUR transaction amount
    Then Loan status will be "ACTIVE"
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type                | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement                    | 500.0  | 0.0       | 0.0      | 0.0  | 0.0       | 500.0        | false    | false    |
      | 20240105  | Disbursement                    | 300.0  | 0.0       | 0.0      | 0.0  | 0.0       | 800.0        | false    | true     |
      | 20240110  | Capitalized Income              | 200.0  | 200.0     | 0.0      | 0.0  | 0.0       | 1000.0       | false    | false    |
      | 20240110  | Accrual                         | 0.85   | 0.0       | 0.85     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240110  | Capitalized Income Amortization | 200.0  | 0.0       | 200.0    | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240110  | Repayment                       | 750.0  | 748.87    | 1.13     | 0.0  | 0.0       | 251.13       | false    | true     |
    And Loan has 255.09 outstanding amount

    When Loan Pay-off is made on "20240110"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

