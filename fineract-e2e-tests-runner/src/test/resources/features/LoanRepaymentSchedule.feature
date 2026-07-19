@LoanRepaymentSchedule
Feature: Loan repayment schedule handling

  @TestRailId:C3901
  Scenario: Verify Loan repayment schedule for progressive loan, interest type: Declining balance, interest calculation petiod: same as repayment  - UC1: 2nd disbursement on due date, interest recalculation enabled, partial period interest calculation enabled
    When Admin sets the business date to "20250101"
    And Admin creates a client with random data
    And Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                               | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DECL_BAL_SARP_EMI_360_30_INT_RECALC_DAILY_MULTIDISB_PARTIAL_PERIOD | 20250101   | 2000           | 12                     | DECLINING_BALANCE | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 3                 | MONTHS                | 1              | MONTHS                 | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20250101" with "2000" amount and expected disbursement date on "20250101"
    And Admin successfully disburse the loan on "20250101" with "1000" EUR transaction amount
    And Admin runs inline COB job for Loan
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      |    |      | 20250101  |           | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      | 1  | 31   | 20250201 |           | 669.98          | 330.02        | 10.0     | 0.0  | 0.0       | 340.02 | 0.0  | 0.0        | 0.0  | 340.02      |
      | 2  | 28   | 20250301    |           | 336.66          | 333.32        | 6.7      | 0.0  | 0.0       | 340.02 | 0.0  | 0.0        | 0.0  | 340.02      |
      | 3  | 31   | 20250401    |           | 0.0             | 336.66        | 3.37     | 0.0  | 0.0       | 340.03 | 0.0  | 0.0        | 0.0  | 340.03      |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid | In advance | Late | Outstanding |
      | 1000.0        | 20.07    | 0.0  | 0.0       | 1020.07 | 0.0  | 0.0        | 0.0  | 1020.07     |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20250101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       | false    | false    |
    #    --- 2nd Disbursement ---
    When Admin sets the business date to "20250201"
    And Admin successfully disburse the loan on "20250201" with "200" EUR transaction amount
    And Admin runs inline COB job for Loan
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      |    |      | 20250101  |           | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      |    |      | 20250201 |           | 200.0           |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      | 1  | 31   | 20250201 |           | 669.98          | 330.02        | 10.0     | 0.0  | 0.0       | 340.02 | 0.0  | 0.0        | 0.0  | 340.02      |
      | 2  | 28   | 20250301    |           | 437.15          | 432.83        | 8.7      | 0.0  | 0.0       | 441.53 | 0.0  | 0.0        | 0.0  | 441.53      |
      | 3  | 31   | 20250401    |           | 0.0             | 437.15        | 4.37     | 0.0  | 0.0       | 441.52 | 0.0  | 0.0        | 0.0  | 441.52      |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid | In advance | Late | Outstanding |
      | 1200.0        | 23.07    | 0.0  | 0.0       | 1223.07 | 0.0  | 0.0        | 0.0  | 1223.07     |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20250101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       | false    | false    |
      | 20250102  | Accrual          | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250103  | Accrual          | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250104  | Accrual          | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250105  | Accrual          | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250106  | Accrual          | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250107  | Accrual          | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250108  | Accrual          | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250109  | Accrual          | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250110  | Accrual          | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250111  | Accrual          | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250112  | Accrual          | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250113  | Accrual          | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250114  | Accrual          | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250115  | Accrual          | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250116  | Accrual          | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250117  | Accrual          | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250118  | Accrual          | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250119  | Accrual          | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250120  | Accrual          | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250121  | Accrual          | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250122  | Accrual          | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250123  | Accrual          | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250124  | Accrual          | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250125  | Accrual          | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250126  | Accrual          | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250127  | Accrual          | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250128  | Accrual          | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250129  | Accrual          | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250130  | Accrual          | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250131  | Accrual          | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250201 | Disbursement     | 200.0  | 0.0       | 0.0      | 0.0  | 0.0       | 1200.0       | false    | false    |

  @TestRailId:C3902
  Scenario: Verify Loan repayment schedule for progressive loan, interest type: Declining balance, interest calculation period: same as repayment - UC2: 2nd disbursement on due date, interest recalculation disabled, partial period interest calculation enabled
    When Admin sets the business date to "20250101"
    And Admin creates a client with random data
    And Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                            | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DECL_BAL_SARP_EMI_360_30_NO_INT_RECALC_MULTIDISB_PARTIAL_PERIOD | 20250101   | 2000           | 12                     | DECLINING_BALANCE | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 3                 | MONTHS                | 1              | MONTHS                 | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20250101" with "2000" amount and expected disbursement date on "20250101"
    And Admin successfully disburse the loan on "20250101" with "1000" EUR transaction amount
    And Admin runs inline COB job for Loan
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      |    |      | 20250101  |           | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      | 1  | 31   | 20250201 |           | 669.98          | 330.02        | 10.0     | 0.0  | 0.0       | 340.02 | 0.0  | 0.0        | 0.0  | 340.02      |
      | 2  | 28   | 20250301    |           | 336.66          | 333.32        | 6.7      | 0.0  | 0.0       | 340.02 | 0.0  | 0.0        | 0.0  | 340.02      |
      | 3  | 31   | 20250401    |           | 0.0             | 336.66        | 3.37     | 0.0  | 0.0       | 340.03 | 0.0  | 0.0        | 0.0  | 340.03      |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid | In advance | Late | Outstanding |
      | 1000.0        | 20.07    | 0.0  | 0.0       | 1020.07 | 0.0  | 0.0        | 0.0  | 1020.07     |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20250101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       | false    | false    |
    #    --- 2nd Disbursement ---
    When Admin sets the business date to "20250201"
    And Admin successfully disburse the loan on "20250201" with "200" EUR transaction amount
    And Admin runs inline COB job for Loan
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      |    |      | 20250101  |           | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      |    |      | 20250201 |           | 200.0           |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      | 1  | 31   | 20250201 |           | 669.98          | 330.02        | 10.0     | 0.0  | 0.0       | 340.02 | 0.0  | 0.0        | 0.0  | 340.02      |
      | 2  | 28   | 20250301    |           | 437.15          | 432.83        | 8.7      | 0.0  | 0.0       | 441.53 | 0.0  | 0.0        | 0.0  | 441.53      |
      | 3  | 31   | 20250401    |           | 0.0             | 437.15        | 4.37     | 0.0  | 0.0       | 441.52 | 0.0  | 0.0        | 0.0  | 441.52      |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid | In advance | Late | Outstanding |
      | 1200.0        | 23.07    | 0.0  | 0.0       | 1223.07 | 0.0  | 0.0        | 0.0  | 1223.07     |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20250101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       | false    | false    |
      | 20250102  | Accrual          | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250103  | Accrual          | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250104  | Accrual          | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250105  | Accrual          | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250106  | Accrual          | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250107  | Accrual          | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250108  | Accrual          | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250109  | Accrual          | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250110  | Accrual          | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250111  | Accrual          | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250112  | Accrual          | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250113  | Accrual          | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250114  | Accrual          | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250115  | Accrual          | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250116  | Accrual          | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250117  | Accrual          | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250118  | Accrual          | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250119  | Accrual          | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250120  | Accrual          | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250121  | Accrual          | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250122  | Accrual          | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250123  | Accrual          | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250124  | Accrual          | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250125  | Accrual          | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250126  | Accrual          | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250127  | Accrual          | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250128  | Accrual          | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250129  | Accrual          | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250130  | Accrual          | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250131  | Accrual          | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250201 | Disbursement     | 200.0  | 0.0       | 0.0      | 0.0  | 0.0       | 1200.0       | false    | false    |

  @TestRailId:C3903
  Scenario: Verify Loan repayment schedule for progressive loan, interest type: Declining balance, interest calculation period: same as repayment - UC3: 2nd disbursement on due date, interest recalculation disabled, partial period interest calculation disabled
    When Admin sets the business date to "20250101"
    And Admin creates a client with random data
    And Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                               | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DECL_BAL_SARP_EMI_360_30_NO_INT_RECALC_MULTIDISB_NO_PARTIAL_PERIOD | 20250101   | 2000           | 12                     | DECLINING_BALANCE | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 3                 | MONTHS                | 1              | MONTHS                 | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20250101" with "2000" amount and expected disbursement date on "20250101"
    And Admin successfully disburse the loan on "20250101" with "1000" EUR transaction amount
    And Admin runs inline COB job for Loan
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      |    |      | 20250101  |           | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      | 1  | 31   | 20250201 |           | 669.98          | 330.02        | 10.0     | 0.0  | 0.0       | 340.02 | 0.0  | 0.0        | 0.0  | 340.02      |
      | 2  | 28   | 20250301    |           | 336.66          | 333.32        | 6.7      | 0.0  | 0.0       | 340.02 | 0.0  | 0.0        | 0.0  | 340.02      |
      | 3  | 31   | 20250401    |           | 0.0             | 336.66        | 3.37     | 0.0  | 0.0       | 340.03 | 0.0  | 0.0        | 0.0  | 340.03      |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid | In advance | Late | Outstanding |
      | 1000.0        | 20.07    | 0.0  | 0.0       | 1020.07 | 0.0  | 0.0        | 0.0  | 1020.07     |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20250101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       | false    | false    |
    #    --- 2nd Disbursement ---
    When Admin sets the business date to "20250201"
    And Admin successfully disburse the loan on "20250201" with "200" EUR transaction amount
    And Admin runs inline COB job for Loan
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      |    |      | 20250101  |           | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      |    |      | 20250201 |           | 200.0           |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      | 1  | 31   | 20250201 |           | 669.98          | 330.02        | 10.0     | 0.0  | 0.0       | 340.02 | 0.0  | 0.0        | 0.0  | 340.02      |
      | 2  | 28   | 20250301    |           | 437.15          | 432.83        | 8.7      | 0.0  | 0.0       | 441.53 | 0.0  | 0.0        | 0.0  | 441.53      |
      | 3  | 31   | 20250401    |           | 0.0             | 437.15        | 4.37     | 0.0  | 0.0       | 441.52 | 0.0  | 0.0        | 0.0  | 441.52      |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid | In advance | Late | Outstanding |
      | 1200.0        | 23.07    | 0.0  | 0.0       | 1223.07 | 0.0  | 0.0        | 0.0  | 1223.07     |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20250101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       | false    | false    |
      | 20250102  | Accrual          | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250103  | Accrual          | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250104  | Accrual          | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250105  | Accrual          | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250106  | Accrual          | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250107  | Accrual          | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250108  | Accrual          | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250109  | Accrual          | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250110  | Accrual          | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250111  | Accrual          | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250112  | Accrual          | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250113  | Accrual          | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250114  | Accrual          | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250115  | Accrual          | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250116  | Accrual          | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250117  | Accrual          | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250118  | Accrual          | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250119  | Accrual          | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250120  | Accrual          | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250121  | Accrual          | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250122  | Accrual          | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250123  | Accrual          | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250124  | Accrual          | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250125  | Accrual          | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250126  | Accrual          | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250127  | Accrual          | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250128  | Accrual          | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250129  | Accrual          | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250130  | Accrual          | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250131  | Accrual          | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250201 | Disbursement     | 200.0  | 0.0       | 0.0      | 0.0  | 0.0       | 1200.0       | false    | false    |

  @TestRailId:C3904
  Scenario: Verify Loan repayment schedule for progressive loan, interest type: Declining balance, interest calculation petiod: same as repayment  - UC4: 2nd disbursement NOT on due date, interest recalculation enabled, partial period interest calculation enabled
    When Admin sets the business date to "20250101"
    And Admin creates a client with random data
    And Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                               | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DECL_BAL_SARP_EMI_360_30_INT_RECALC_DAILY_MULTIDISB_PARTIAL_PERIOD | 20250101   | 2000           | 12                     | DECLINING_BALANCE | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 3                 | MONTHS                | 1              | MONTHS                 | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20250101" with "2000" amount and expected disbursement date on "20250101"
    And Admin successfully disburse the loan on "20250101" with "1000" EUR transaction amount
    And Admin runs inline COB job for Loan
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      |    |      | 20250101  |           | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      | 1  | 31   | 20250201 |           | 669.98          | 330.02        | 10.0     | 0.0  | 0.0       | 340.02 | 0.0  | 0.0        | 0.0  | 340.02      |
      | 2  | 28   | 20250301    |           | 336.66          | 333.32        | 6.7      | 0.0  | 0.0       | 340.02 | 0.0  | 0.0        | 0.0  | 340.02      |
      | 3  | 31   | 20250401    |           | 0.0             | 336.66        | 3.37     | 0.0  | 0.0       | 340.03 | 0.0  | 0.0        | 0.0  | 340.03      |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid | In advance | Late | Outstanding |
      | 1000.0        | 20.07    | 0.0  | 0.0       | 1020.07 | 0.0  | 0.0        | 0.0  | 1020.07     |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20250101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       | false    | false    |
    #    --- 2nd Disbursement ---
    When Admin sets the business date to "20250115"
    And Admin successfully disburse the loan on "20250115" with "200" EUR transaction amount
    And Admin runs inline COB job for Loan
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      |    |      | 20250101  |           | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      |    |      | 20250115  |           | 200.0           |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      | 1  | 31   | 20250201 |           | 803.38          | 396.62        | 11.1     | 0.0  | 0.0       | 407.72 | 0.0  | 0.0        | 0.0  | 407.72      |
      | 2  | 28   | 20250301    |           | 403.69          | 399.69        | 8.03     | 0.0  | 0.0       | 407.72 | 0.0  | 0.0        | 0.0  | 407.72      |
      | 3  | 31   | 20250401    |           | 0.0             | 403.69        | 4.04     | 0.0  | 0.0       | 407.73 | 0.0  | 0.0        | 0.0  | 407.73      |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid | In advance | Late | Outstanding |
      | 1200.0        | 23.17    | 0.0  | 0.0       | 1223.17 | 0.0  | 0.0        | 0.0  | 1223.17     |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20250101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       | false    | false    |
      | 20250102  | Accrual          | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250103  | Accrual          | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250104  | Accrual          | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250105  | Accrual          | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250106  | Accrual          | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250107  | Accrual          | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250108  | Accrual          | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250109  | Accrual          | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250110  | Accrual          | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250111  | Accrual          | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250112  | Accrual          | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250113  | Accrual          | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250114  | Accrual          | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250115  | Disbursement     | 200.0  | 0.0       | 0.0      | 0.0  | 0.0       | 1200.0       | false    | false    |

  @TestRailId:C3905
  Scenario: Verify Loan repayment schedule for progressive loan, interest type: Declining balance, interest calculation period: same as repayment - UC5: 2nd disbursement NOT on due date, interest recalculation disabled, partial period interest calculation enabled
    When Admin sets the business date to "20250101"
    And Admin creates a client with random data
    And Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                            | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DECL_BAL_SARP_EMI_360_30_NO_INT_RECALC_MULTIDISB_PARTIAL_PERIOD | 20250101   | 2000           | 12                     | DECLINING_BALANCE | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 3                 | MONTHS                | 1              | MONTHS                 | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20250101" with "2000" amount and expected disbursement date on "20250101"
    And Admin successfully disburse the loan on "20250101" with "1000" EUR transaction amount
    And Admin runs inline COB job for Loan
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      |    |      | 20250101  |           | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      | 1  | 31   | 20250201 |           | 669.98          | 330.02        | 10.0     | 0.0  | 0.0       | 340.02 | 0.0  | 0.0        | 0.0  | 340.02      |
      | 2  | 28   | 20250301    |           | 336.66          | 333.32        | 6.7      | 0.0  | 0.0       | 340.02 | 0.0  | 0.0        | 0.0  | 340.02      |
      | 3  | 31   | 20250401    |           | 0.0             | 336.66        | 3.37     | 0.0  | 0.0       | 340.03 | 0.0  | 0.0        | 0.0  | 340.03      |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid | In advance | Late | Outstanding |
      | 1000.0        | 20.07    | 0.0  | 0.0       | 1020.07 | 0.0  | 0.0        | 0.0  | 1020.07     |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20250101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       | false    | false    |
    #    --- 2nd Disbursement ---
    When Admin sets the business date to "20250115"
    And Admin successfully disburse the loan on "20250115" with "200" EUR transaction amount
    And Admin runs inline COB job for Loan
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      |    |      | 20250101  |           | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      |    |      | 20250115  |           | 200.0           |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      | 1  | 31   | 20250201 |           | 803.38          | 396.62        | 11.1     | 0.0  | 0.0       | 407.72 | 0.0  | 0.0        | 0.0  | 407.72      |
      | 2  | 28   | 20250301    |           | 403.69          | 399.69        | 8.03     | 0.0  | 0.0       | 407.72 | 0.0  | 0.0        | 0.0  | 407.72      |
      | 3  | 31   | 20250401    |           | 0.0             | 403.69        | 4.04     | 0.0  | 0.0       | 407.73 | 0.0  | 0.0        | 0.0  | 407.73      |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid | In advance | Late | Outstanding |
      | 1200.0        | 23.17    | 0.0  | 0.0       | 1223.17 | 0.0  | 0.0        | 0.0  | 1223.17     |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20250101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       | false    | false    |
      | 20250102  | Accrual          | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250103  | Accrual          | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250104  | Accrual          | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250105  | Accrual          | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250106  | Accrual          | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250107  | Accrual          | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250108  | Accrual          | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250109  | Accrual          | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250110  | Accrual          | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250111  | Accrual          | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250112  | Accrual          | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250113  | Accrual          | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250114  | Accrual          | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250115  | Disbursement     | 200.0  | 0.0       | 0.0      | 0.0  | 0.0       | 1200.0       | false    | false    |

  @TestRailId:C3906
  Scenario: Verify Loan repayment schedule for progressive loan, interest type: Declining balance, interest calculation period: same as repayment - UC6: 2nd disbursement NOT on due date, interest recalculation disabled, partial period interest calculation disabled
    When Admin sets the business date to "20250101"
    And Admin creates a client with random data
    And Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                               | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DECL_BAL_SARP_EMI_360_30_NO_INT_RECALC_MULTIDISB_NO_PARTIAL_PERIOD | 20250101   | 2000           | 12                     | DECLINING_BALANCE | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 3                 | MONTHS                | 1              | MONTHS                 | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20250101" with "2000" amount and expected disbursement date on "20250101"
    And Admin successfully disburse the loan on "20250101" with "1000" EUR transaction amount
    And Admin runs inline COB job for Loan
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      |    |      | 20250101  |           | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      | 1  | 31   | 20250201 |           | 669.98          | 330.02        | 10.0     | 0.0  | 0.0       | 340.02 | 0.0  | 0.0        | 0.0  | 340.02      |
      | 2  | 28   | 20250301    |           | 336.66          | 333.32        | 6.7      | 0.0  | 0.0       | 340.02 | 0.0  | 0.0        | 0.0  | 340.02      |
      | 3  | 31   | 20250401    |           | 0.0             | 336.66        | 3.37     | 0.0  | 0.0       | 340.03 | 0.0  | 0.0        | 0.0  | 340.03      |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid | In advance | Late | Outstanding |
      | 1000.0        | 20.07    | 0.0  | 0.0       | 1020.07 | 0.0  | 0.0        | 0.0  | 1020.07     |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20250101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       | false    | false    |
    #    --- 2nd Disbursement ---
    When Admin sets the business date to "20250115"
    And Admin successfully disburse the loan on "20250115" with "200" EUR transaction amount
    And Admin runs inline COB job for Loan
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      |    |      | 20250101  |           | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      |    |      | 20250115  |           | 200.0           |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      | 1  | 31   | 20250201 |           | 803.97          | 396.03        | 12.0     | 0.0  | 0.0       | 408.03 | 0.0  | 0.0        | 0.0  | 408.03      |
      | 2  | 28   | 20250301    |           | 403.98          | 399.99        | 8.04     | 0.0  | 0.0       | 408.03 | 0.0  | 0.0        | 0.0  | 408.03      |
      | 3  | 31   | 20250401    |           | 0.0             | 403.98        | 4.04     | 0.0  | 0.0       | 408.02 | 0.0  | 0.0        | 0.0  | 408.02      |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid | In advance | Late | Outstanding |
      | 1200          | 24.08    | 0.0  | 0.0       | 1224.08 | 0.0  | 0.0        | 0.0  | 1224.08     |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20250101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       | false    | false    |
      | 20250102  | Accrual          | 0.39   | 0.0       | 0.39     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250103  | Accrual          | 0.38   | 0.0       | 0.38     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250104  | Accrual          | 0.39   | 0.0       | 0.39     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250105  | Accrual          | 0.39   | 0.0       | 0.39     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250106  | Accrual          | 0.39   | 0.0       | 0.39     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250107  | Accrual          | 0.38   | 0.0       | 0.38     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250108  | Accrual          | 0.39   | 0.0       | 0.39     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250109  | Accrual          | 0.39   | 0.0       | 0.39     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250110  | Accrual          | 0.38   | 0.0       | 0.38     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250111  | Accrual          | 0.39   | 0.0       | 0.39     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250112  | Accrual          | 0.39   | 0.0       | 0.39     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250113  | Accrual          | 0.39   | 0.0       | 0.39     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250114  | Accrual          | 0.38   | 0.0       | 0.38     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250115  | Disbursement     | 200.0  | 0.0       | 0.0      | 0.0  | 0.0       | 1200.0       | false    | false    |

  @TestRailId:C3907
  Scenario: Verify Loan repayment schedule for progressive loan, interest type: Declining balance, interest calculation period: same as repayment - UC7: 2nd disbursement is in the middle of 2nd period + backdated repayment, interest recalculation enabled, partial period interest calculation enabled
    When Admin sets the business date to "20250101"
    And Admin creates a client with random data
    And Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                               | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DECL_BAL_SARP_EMI_360_30_INT_RECALC_DAILY_MULTIDISB_PARTIAL_PERIOD | 20250101   | 2000           | 12                     | DECLINING_BALANCE | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 3                 | MONTHS                | 1              | MONTHS                 | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20250101" with "2000" amount and expected disbursement date on "20250101"
    And Admin successfully disburse the loan on "20250101" with "1000" EUR transaction amount
    And Admin runs inline COB job for Loan
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      |    |      | 20250101  |           | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      | 1  | 31   | 20250201 |           | 669.98          | 330.02        | 10.0     | 0.0  | 0.0       | 340.02 | 0.0  | 0.0        | 0.0  | 340.02      |
      | 2  | 28   | 20250301    |           | 336.66          | 333.32        | 6.7      | 0.0  | 0.0       | 340.02 | 0.0  | 0.0        | 0.0  | 340.02      |
      | 3  | 31   | 20250401    |           | 0.0             | 336.66        | 3.37     | 0.0  | 0.0       | 340.03 | 0.0  | 0.0        | 0.0  | 340.03      |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid | In advance | Late | Outstanding |
      | 1000.0        | 20.07    | 0.0  | 0.0       | 1020.07 | 0.0  | 0.0        | 0.0  | 1020.07     |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20250101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       | false    | false    |
    When Admin sets the business date to "20250201"
    And Admin runs inline COB job for Loan
#    --- 2nd Disbursement ---
    When Admin sets the business date to "20250215"
    And Admin successfully disburse the loan on "20250215" with "200" EUR transaction amount
    And Admin runs inline COB job for Loan
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      |    |      | 20250101  |           | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      | 1  | 31   | 20250201 |           | 669.98          | 330.02        | 10.0     | 0.0  | 0.0       | 340.02 | 0.0  | 0.0        | 0.0  | 340.02      |
      |    |      | 20250215 |           | 200.0           |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      | 2  | 28   | 20250301    |           | 438.31          | 431.67        | 9.35     | 0.0  | 0.0       | 441.02 | 0.0  | 0.0        | 0.0  | 441.02      |
      | 3  | 31   | 20250401    |           | 0.0             | 438.31        | 4.38     | 0.0  | 0.0       | 442.69 | 0.0  | 0.0        | 0.0  | 442.69      |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid | In advance | Late | Outstanding |
      | 1200.0        | 23.73    | 0.0  | 0.0       | 1223.73 | 0.0  | 0.0        | 0.0  | 1223.73     |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20250101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       | false    | false    |
      | 20250102  | Accrual          | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250103  | Accrual          | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250104  | Accrual          | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250105  | Accrual          | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250106  | Accrual          | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250107  | Accrual          | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250108  | Accrual          | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250109  | Accrual          | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250110  | Accrual          | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250111  | Accrual          | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250112  | Accrual          | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250113  | Accrual          | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250114  | Accrual          | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250115  | Accrual          | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250116  | Accrual          | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250117  | Accrual          | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250118  | Accrual          | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250119  | Accrual          | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250120  | Accrual          | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250121  | Accrual          | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250122  | Accrual          | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250123  | Accrual          | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250124  | Accrual          | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250125  | Accrual          | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250126  | Accrual          | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250127  | Accrual          | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250128  | Accrual          | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250129  | Accrual          | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250130  | Accrual          | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250131  | Accrual          | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250201 | Accrual          | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250202 | Accrual          | 0.36   | 0.0       | 0.36     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250203 | Accrual          | 0.35   | 0.0       | 0.35     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250204 | Accrual          | 0.36   | 0.0       | 0.36     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250205 | Accrual          | 0.36   | 0.0       | 0.36     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250206 | Accrual          | 0.36   | 0.0       | 0.36     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250207 | Accrual          | 0.35   | 0.0       | 0.35     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250208 | Accrual          | 0.36   | 0.0       | 0.36     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250209 | Accrual          | 0.36   | 0.0       | 0.36     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250210 | Accrual          | 0.35   | 0.0       | 0.35     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250211 | Accrual          | 0.36   | 0.0       | 0.36     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250212 | Accrual          | 0.36   | 0.0       | 0.36     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250213 | Accrual          | 0.36   | 0.0       | 0.36     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250214 | Accrual          | 0.35   | 0.0       | 0.35     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250215 | Disbursement     | 200.0  | 0.0       | 0.0      | 0.0  | 0.0       | 1200.0       | false    | false    |
#    --- Backdated repayment ---
    When Customer makes "AUTOPAY" repayment on "20250201" with 340.02 EUR transaction amount
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late | Outstanding |
      |    |      | 20250101  |                  | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0    |            |      |             |
      | 1  | 31   | 20250201 | 20250201 | 669.98          | 330.02        | 10.0     | 0.0  | 0.0       | 340.02 | 340.02 | 0.0        | 0.0  | 0.0         |
      |    |      | 20250215 |                  | 200.0           |               |          | 0.0  |           | 0.0    | 0.0    |            |      |             |
      | 2  | 28   | 20250301    |                  | 436.66          | 433.32        | 7.7      | 0.0  | 0.0       | 441.02 | 0.0    | 0.0        | 0.0  | 441.02      |
      | 3  | 31   | 20250401    |                  | 0.0             | 436.66        | 4.37     | 0.0  | 0.0       | 441.03 | 0.0    | 0.0        | 0.0  | 441.03      |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid   | In advance | Late | Outstanding |
      | 1200.0        | 22.07    | 0.0  | 0.0       | 1222.07 | 340.02 | 0.0        | 0.0  | 882.05      |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20250101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       | false    | false    |
      | 20250102  | Accrual          | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250103  | Accrual          | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250104  | Accrual          | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250105  | Accrual          | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250106  | Accrual          | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250107  | Accrual          | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250108  | Accrual          | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250109  | Accrual          | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250110  | Accrual          | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250111  | Accrual          | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250112  | Accrual          | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250113  | Accrual          | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250114  | Accrual          | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250115  | Accrual          | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250116  | Accrual          | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250117  | Accrual          | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250118  | Accrual          | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250119  | Accrual          | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250120  | Accrual          | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250121  | Accrual          | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250122  | Accrual          | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250123  | Accrual          | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250124  | Accrual          | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250125  | Accrual          | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250126  | Accrual          | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250127  | Accrual          | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250128  | Accrual          | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250129  | Accrual          | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250130  | Accrual          | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250131  | Accrual          | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250201 | Accrual          | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250201 | Repayment        | 340.02 | 330.02    | 10.0     | 0.0  | 0.0       | 669.98       | false    | false    |
      | 20250202 | Accrual          | 0.36   | 0.0       | 0.36     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250203 | Accrual          | 0.35   | 0.0       | 0.35     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250204 | Accrual          | 0.36   | 0.0       | 0.36     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250205 | Accrual          | 0.36   | 0.0       | 0.36     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250206 | Accrual          | 0.36   | 0.0       | 0.36     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250207 | Accrual          | 0.35   | 0.0       | 0.35     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250208 | Accrual          | 0.36   | 0.0       | 0.36     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250209 | Accrual          | 0.36   | 0.0       | 0.36     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250210 | Accrual          | 0.35   | 0.0       | 0.35     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250211 | Accrual          | 0.36   | 0.0       | 0.36     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250212 | Accrual          | 0.36   | 0.0       | 0.36     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250213 | Accrual          | 0.36   | 0.0       | 0.36     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250214 | Accrual          | 0.35   | 0.0       | 0.35     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250215 | Disbursement     | 200.0  | 0.0       | 0.0      | 0.0  | 0.0       | 869.98       | false    | false    |

  @TestRailId:C3908
  Scenario: Verify Loan repayment schedule for progressive loan, interest type: Declining balance, interest calculation period: same as repayment - UC8: 2nd disbursement is in the middle of 2nd period + backdated repayment, interest recalculation disabled, partial period interest calculation enabled
    When Admin sets the business date to "20250101"
    And Admin creates a client with random data
    And Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                            | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DECL_BAL_SARP_EMI_360_30_NO_INT_RECALC_MULTIDISB_PARTIAL_PERIOD | 20250101   | 2000           | 12                     | DECLINING_BALANCE | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 3                 | MONTHS                | 1              | MONTHS                 | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20250101" with "2000" amount and expected disbursement date on "20250101"
    And Admin successfully disburse the loan on "20250101" with "1000" EUR transaction amount
    And Admin runs inline COB job for Loan
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      |    |      | 20250101  |           | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      | 1  | 31   | 20250201 |           | 669.98          | 330.02        | 10.0     | 0.0  | 0.0       | 340.02 | 0.0  | 0.0        | 0.0  | 340.02      |
      | 2  | 28   | 20250301    |           | 336.66          | 333.32        | 6.7      | 0.0  | 0.0       | 340.02 | 0.0  | 0.0        | 0.0  | 340.02      |
      | 3  | 31   | 20250401    |           | 0.0             | 336.66        | 3.37     | 0.0  | 0.0       | 340.03 | 0.0  | 0.0        | 0.0  | 340.03      |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid | In advance | Late | Outstanding |
      | 1000.0        | 20.07    | 0.0  | 0.0       | 1020.07 | 0.0  | 0.0        | 0.0  | 1020.07     |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20250101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       | false    | false    |
    When Admin sets the business date to "20250201"
    And Admin runs inline COB job for Loan
    #    --- 2nd Disbursement ---
    When Admin sets the business date to "20250215"
    And Admin successfully disburse the loan on "20250215" with "200" EUR transaction amount
    And Admin runs inline COB job for Loan
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      |    |      | 20250101  |           | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      | 1  | 31   | 20250201 |           | 669.98          | 330.02        | 10.0     | 0.0  | 0.0       | 340.02 | 0.0  | 0.0        | 0.0  | 340.02      |
      |    |      | 20250215 |           | 200.0           |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      | 2  | 28   | 20250301    |           | 436.66          | 433.32        | 7.7      | 0.0  | 0.0       | 441.02 | 0.0  | 0.0        | 0.0  | 441.02      |
      | 3  | 31   | 20250401    |           | 0.0             | 436.66        | 4.37     | 0.0  | 0.0       | 441.03 | 0.0  | 0.0        | 0.0  | 441.03      |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid | In advance | Late | Outstanding |
      | 1200.0        | 22.07    | 0.0  | 0.0       | 1222.07 | 0.0  | 0.0        | 0.0  | 1222.07     |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20250101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       | false    | false    |
      | 20250102  | Accrual          | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250103  | Accrual          | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250104  | Accrual          | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250105  | Accrual          | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250106  | Accrual          | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250107  | Accrual          | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250108  | Accrual          | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250109  | Accrual          | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250110  | Accrual          | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250111  | Accrual          | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250112  | Accrual          | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250113  | Accrual          | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250114  | Accrual          | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250115  | Accrual          | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250116  | Accrual          | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250117  | Accrual          | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250118  | Accrual          | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250119  | Accrual          | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250120  | Accrual          | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250121  | Accrual          | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250122  | Accrual          | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250123  | Accrual          | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250124  | Accrual          | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250125  | Accrual          | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250126  | Accrual          | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250127  | Accrual          | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250128  | Accrual          | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250129  | Accrual          | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250130  | Accrual          | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250131  | Accrual          | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250201 | Accrual          | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250202 | Accrual          | 0.24   | 0.0       | 0.24     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250203 | Accrual          | 0.24   | 0.0       | 0.24     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250204 | Accrual          | 0.24   | 0.0       | 0.24     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250205 | Accrual          | 0.24   | 0.0       | 0.24     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250206 | Accrual          | 0.24   | 0.0       | 0.24     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250207 | Accrual          | 0.24   | 0.0       | 0.24     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250208 | Accrual          | 0.23   | 0.0       | 0.23     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250209 | Accrual          | 0.24   | 0.0       | 0.24     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250210 | Accrual          | 0.24   | 0.0       | 0.24     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250211 | Accrual          | 0.24   | 0.0       | 0.24     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250212 | Accrual          | 0.24   | 0.0       | 0.24     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250213 | Accrual          | 0.24   | 0.0       | 0.24     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250214 | Accrual          | 0.24   | 0.0       | 0.24     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250215 | Disbursement     | 200.0  | 0.0       | 0.0      | 0.0  | 0.0       | 1200.0       | false    | false    |
#    --- Backdated repayment ---
    When Customer makes "AUTOPAY" repayment on "20250201" with 340.02 EUR transaction amount
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late | Outstanding |
      |    |      | 20250101  |                  | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0    |            |      |             |
      | 1  | 31   | 20250201 | 20250201 | 669.98          | 330.02        | 10.0     | 0.0  | 0.0       | 340.02 | 340.02 | 0.0        | 0.0  | 0.0         |
      |    |      | 20250215 |                  | 200.0           |               |          | 0.0  |           | 0.0    | 0.0    |            |      |             |
      | 2  | 28   | 20250301    |                  | 436.66          | 433.32        | 7.7      | 0.0  | 0.0       | 441.02 | 0.0    | 0.0        | 0.0  | 441.02      |
      | 3  | 31   | 20250401    |                  | 0.0             | 436.66        | 4.37     | 0.0  | 0.0       | 441.03 | 0.0    | 0.0        | 0.0  | 441.03      |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid   | In advance | Late | Outstanding |
      | 1200.0        | 22.07    | 0.0  | 0.0       | 1222.07 | 340.02 | 0.0        | 0.0  | 882.05      |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20250101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       | false    | false    |
      | 20250102  | Accrual          | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250103  | Accrual          | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250104  | Accrual          | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250105  | Accrual          | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250106  | Accrual          | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250107  | Accrual          | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250108  | Accrual          | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250109  | Accrual          | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250110  | Accrual          | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250111  | Accrual          | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250112  | Accrual          | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250113  | Accrual          | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250114  | Accrual          | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250115  | Accrual          | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250116  | Accrual          | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250117  | Accrual          | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250118  | Accrual          | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250119  | Accrual          | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250120  | Accrual          | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250121  | Accrual          | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250122  | Accrual          | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250123  | Accrual          | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250124  | Accrual          | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250125  | Accrual          | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250126  | Accrual          | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250127  | Accrual          | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250128  | Accrual          | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250129  | Accrual          | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250130  | Accrual          | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250131  | Accrual          | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250201 | Accrual          | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250201 | Repayment        | 340.02 | 330.02    | 10.0     | 0.0  | 0.0       | 669.98       | false    | false    |
      | 20250202 | Accrual          | 0.24   | 0.0       | 0.24     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250203 | Accrual          | 0.24   | 0.0       | 0.24     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250204 | Accrual          | 0.24   | 0.0       | 0.24     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250205 | Accrual          | 0.24   | 0.0       | 0.24     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250206 | Accrual          | 0.24   | 0.0       | 0.24     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250207 | Accrual          | 0.24   | 0.0       | 0.24     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250208 | Accrual          | 0.23   | 0.0       | 0.23     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250209 | Accrual          | 0.24   | 0.0       | 0.24     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250210 | Accrual          | 0.24   | 0.0       | 0.24     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250211 | Accrual          | 0.24   | 0.0       | 0.24     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250212 | Accrual          | 0.24   | 0.0       | 0.24     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250213 | Accrual          | 0.24   | 0.0       | 0.24     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250214 | Accrual          | 0.24   | 0.0       | 0.24     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250215 | Disbursement     | 200.0  | 0.0       | 0.0      | 0.0  | 0.0       | 869.98       | false    | false    |

  @TestRailId:C3909
  Scenario: Verify Loan repayment schedule for progressive loan, interest type: Declining balance, interest calculation period: same as repayment - UC9: 2nd disbursement is in the middle of 2nd period + backdated repayment, interest recalculation disabled, partial period interest calculation disabled
    When Admin sets the business date to "20250101"
    And Admin creates a client with random data
    And Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                               | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DECL_BAL_SARP_EMI_360_30_NO_INT_RECALC_MULTIDISB_NO_PARTIAL_PERIOD | 20250101   | 2000           | 12                     | DECLINING_BALANCE | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 3                 | MONTHS                | 1              | MONTHS                 | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20250101" with "2000" amount and expected disbursement date on "20250101"
    And Admin successfully disburse the loan on "20250101" with "1000" EUR transaction amount
    And Admin runs inline COB job for Loan
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      |    |      | 20250101  |           | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      | 1  | 31   | 20250201 |           | 669.98          | 330.02        | 10.0     | 0.0  | 0.0       | 340.02 | 0.0  | 0.0        | 0.0  | 340.02      |
      | 2  | 28   | 20250301    |           | 336.66          | 333.32        | 6.7      | 0.0  | 0.0       | 340.02 | 0.0  | 0.0        | 0.0  | 340.02      |
      | 3  | 31   | 20250401    |           | 0.0             | 336.66        | 3.37     | 0.0  | 0.0       | 340.03 | 0.0  | 0.0        | 0.0  | 340.03      |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid | In advance | Late | Outstanding |
      | 1000.0        | 20.07    | 0.0  | 0.0       | 1020.07 | 0.0  | 0.0        | 0.0  | 1020.07     |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20250101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       | false    | false    |
    When Admin sets the business date to "20250201"
    And Admin runs inline COB job for Loan
#    --- 2nd Disbursement ---
    When Admin sets the business date to "20250215"
    And Admin successfully disburse the loan on "20250215" with "200" EUR transaction amount
    And Admin runs inline COB job for Loan
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      |    |      | 20250101  |           | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      | 1  | 31   | 20250201 |           | 669.98          | 330.02        | 10.0     | 0.0  | 0.0       | 340.02 | 0.0  | 0.0        | 0.0  | 340.02      |
      |    |      | 20250215 |           | 200.0           |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      | 2  | 28   | 20250301    |           | 437.15          | 432.83        | 8.7      | 0.0  | 0.0       | 441.53 | 0.0  | 0.0        | 0.0  | 441.53      |
      | 3  | 31   | 20250401    |           | 0.0             | 437.15        | 4.37     | 0.0  | 0.0       | 441.52 | 0.0  | 0.0        | 0.0  | 441.52      |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid | In advance | Late | Outstanding |
      | 1200.0        | 23.07    | 0.0  | 0.0       | 1223.07 | 0.0  | 0.0        | 0.0  | 1223.07     |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20250101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       | false    | false    |
      | 20250102  | Accrual          | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250103  | Accrual          | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250104  | Accrual          | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250105  | Accrual          | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250106  | Accrual          | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250107  | Accrual          | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250108  | Accrual          | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250109  | Accrual          | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250110  | Accrual          | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250111  | Accrual          | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250112  | Accrual          | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250113  | Accrual          | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250114  | Accrual          | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250115  | Accrual          | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250116  | Accrual          | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250117  | Accrual          | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250118  | Accrual          | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250119  | Accrual          | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250120  | Accrual          | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250121  | Accrual          | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250122  | Accrual          | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250123  | Accrual          | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250124  | Accrual          | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250125  | Accrual          | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250126  | Accrual          | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250127  | Accrual          | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250128  | Accrual          | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250129  | Accrual          | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250130  | Accrual          | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250131  | Accrual          | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250201 | Accrual          | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250202 | Accrual          | 0.31   | 0.0       | 0.31     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250203 | Accrual          | 0.31   | 0.0       | 0.31     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250204 | Accrual          | 0.31   | 0.0       | 0.31     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250205 | Accrual          | 0.31   | 0.0       | 0.31     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250206 | Accrual          | 0.31   | 0.0       | 0.31     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250207 | Accrual          | 0.31   | 0.0       | 0.31     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250208 | Accrual          | 0.31   | 0.0       | 0.31     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250209 | Accrual          | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250210 | Accrual          | 0.31   | 0.0       | 0.31     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250211 | Accrual          | 0.31   | 0.0       | 0.31     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250212 | Accrual          | 0.31   | 0.0       | 0.31     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250213 | Accrual          | 0.31   | 0.0       | 0.31     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250214 | Accrual          | 0.31   | 0.0       | 0.31     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250215 | Disbursement     | 200.0  | 0.0       | 0.0      | 0.0  | 0.0       | 1200.0       | false    | false    |
#    --- Backdated repayment ---
    When Customer makes "AUTOPAY" repayment on "20250201" with 340.02 EUR transaction amount
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late | Outstanding |
      |    |      | 20250101  |                  | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0    |            |      |             |
      | 1  | 31   | 20250201 | 20250201 | 669.98          | 330.02        | 10.0     | 0.0  | 0.0       | 340.02 | 340.02 | 0.0        | 0.0  | 0.0         |
      |    |      | 20250215 |                  | 200.0           |               |          | 0.0  |           | 0.0    | 0.0    |            |      |             |
      | 2  | 28   | 20250301    |                  | 437.15          | 432.83        | 8.7      | 0.0  | 0.0       | 441.53 | 0.0    | 0.0        | 0.0  | 441.53      |
      | 3  | 31   | 20250401    |                  | 0.0             | 437.15        | 4.37     | 0.0  | 0.0       | 441.52 | 0.0    | 0.0        | 0.0  | 441.52      |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid   | In advance | Late | Outstanding |
      | 1200.0        | 23.07    | 0.0  | 0.0       | 1223.07 | 340.02 | 0.0        | 0.0  | 883.05      |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20250101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       | false    | false    |
      | 20250102  | Accrual          | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250103  | Accrual          | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250104  | Accrual          | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250105  | Accrual          | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250106  | Accrual          | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250107  | Accrual          | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250108  | Accrual          | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250109  | Accrual          | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250110  | Accrual          | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250111  | Accrual          | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250112  | Accrual          | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250113  | Accrual          | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250114  | Accrual          | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250115  | Accrual          | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250116  | Accrual          | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250117  | Accrual          | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250118  | Accrual          | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250119  | Accrual          | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250120  | Accrual          | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250121  | Accrual          | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250122  | Accrual          | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250123  | Accrual          | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250124  | Accrual          | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250125  | Accrual          | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250126  | Accrual          | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250127  | Accrual          | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250128  | Accrual          | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250129  | Accrual          | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250130  | Accrual          | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250131  | Accrual          | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250201 | Accrual          | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250201 | Repayment        | 340.02 | 330.02    | 10.0     | 0.0  | 0.0       | 669.98       | false    | false    |
      | 20250202 | Accrual          | 0.31   | 0.0       | 0.31     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250203 | Accrual          | 0.31   | 0.0       | 0.31     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250204 | Accrual          | 0.31   | 0.0       | 0.31     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250205 | Accrual          | 0.31   | 0.0       | 0.31     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250206 | Accrual          | 0.31   | 0.0       | 0.31     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250207 | Accrual          | 0.31   | 0.0       | 0.31     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250208 | Accrual          | 0.31   | 0.0       | 0.31     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250209 | Accrual          | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250210 | Accrual          | 0.31   | 0.0       | 0.31     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250211 | Accrual          | 0.31   | 0.0       | 0.31     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250212 | Accrual          | 0.31   | 0.0       | 0.31     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250213 | Accrual          | 0.31   | 0.0       | 0.31     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250214 | Accrual          | 0.31   | 0.0       | 0.31     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250215 | Disbursement     | 200.0  | 0.0       | 0.0      | 0.0  | 0.0       | 869.98       | false    | false    |

  @TestRailId:C3910
  Scenario: Verify Loan repayment schedule for progressive loan, interest type: Declining balance, interest calculation period: same as repayment - UC10: complex transactions, interest recalculation enabled, partial period interest calculation enabled
    When Admin sets the business date to "20250101"
    And Admin creates a client with random data
    And Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                               | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DECL_BAL_SARP_EMI_360_30_INT_RECALC_DAILY_MULTIDISB_PARTIAL_PERIOD | 20250101   | 2000           | 12                     | DECLINING_BALANCE | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 3                 | MONTHS                | 1              | MONTHS                 | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20250101" with "2000" amount and expected disbursement date on "20250101"
    And Admin successfully disburse the loan on "20250101" with "1000" EUR transaction amount
    And Admin runs inline COB job for Loan
    When Admin sets the business date to "20250201"
    And Admin runs inline COB job for Loan
#    --- 2nd Disbursement ---
    When Admin sets the business date to "20250215"
    And Admin runs inline COB job for Loan
    And Admin successfully disburse the loan on "20250215" with "200" EUR transaction amount
#    --- Backdated repayment (early repayment) ---
    When Customer makes "AUTOPAY" repayment on "20250115" with 340.02 EUR transaction amount
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late | Outstanding |
      |    |      | 20250101  |                 | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0    |            |      |             |
      | 1  | 31   | 20250201 | 20250115 | 664.5           | 335.5         | 4.52     | 0.0  | 0.0       | 340.02 | 340.02 | 340.02     | 0.0  | 0.0         |
      |    |      | 20250215 |                 | 200.0           |               |          | 0.0  |           | 0.0    | 0.0    |            |      |             |
      | 2  | 28   | 20250301    |                 | 434.76          | 429.74        | 11.28    | 0.0  | 0.0       | 441.02 | 0.0    | 0.0        | 0.0  | 441.02      |
      | 3  | 31   | 20250401    |                 | 0.0             | 434.76        | 4.35     | 0.0  | 0.0       | 439.11 | 0.0    | 0.0        | 0.0  | 439.11      |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid   | In advance | Late | Outstanding |
      | 1200.0        | 20.15    | 0.0  | 0.0       | 1220.15 | 340.02 | 340.02     | 0.0  | 880.13      |
#    --- Make full 2nd period repayment (late repayment) ---
    When Admin sets the business date to "20250315"
    And Admin runs inline COB job for Loan
    And Customer makes "AUTOPAY" repayment on "20250315" with 441.02 EUR transaction amount
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late   | Outstanding |
      |    |      | 20250101  |                 | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0    |            |        |             |
      | 1  | 31   | 20250201 | 20250115 | 664.5           | 335.5         | 4.52     | 0.0  | 0.0       | 340.02 | 340.02 | 340.02     | 0.0    | 0.0         |
      |    |      | 20250215 |                 | 200.0           |               |          | 0.0  |           | 0.0    | 0.0    |            |        |             |
      | 2  | 28   | 20250301    | 20250315   | 434.76          | 429.74        | 11.28    | 0.0  | 0.0       | 441.02 | 441.02 | 0.0        | 441.02 | 0.0         |
      | 3  | 31   | 20250401    |                 | 0.0             | 434.76        | 6.29     | 0.0  | 0.0       | 441.05 | 0.0    | 0.0        | 0.0    | 441.05      |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid   | In advance | Late   | Outstanding |
      | 1200.0        | 22.09    | 0.0  | 0.0       | 1222.09 | 781.04 | 340.02     | 441.02 | 441.05      |
  #    --- Make merchant issued refund ---
    When Admin sets the business date to "20250316"
    And Admin runs inline COB job for Loan
    And Customer makes "MERCHANT_ISSUED_REFUND" transaction with "AUTOPAY" payment type on "20250316" with 250 EUR transaction amount and system-generated Idempotency key
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late   | Outstanding |
      |    |      | 20250101  |                 | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0    |            |        |             |
      | 1  | 31   | 20250201 | 20250115 | 664.5           | 335.5         | 4.52     | 0.0  | 0.0       | 340.02 | 340.02 | 340.02     | 0.0    | 0.0         |
      |    |      | 20250215 |                 | 200.0           |               |          | 0.0  |           | 0.0    | 0.0    |            |        |             |
      | 2  | 28   | 20250301    | 20250315   | 434.76          | 429.74        | 11.28    | 0.0  | 0.0       | 441.02 | 441.02 | 0.0        | 441.02 | 0.0         |
      | 3  | 31   | 20250401    |                 | 0.0             | 434.76        | 5.0      | 0.0  | 0.0       | 439.76 | 250.0  | 250.0      | 0.0    | 189.76      |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid    | In advance | Late   | Outstanding |
      | 1200.0        | 20.8     | 0.0  | 0.0       | 1220.8 | 1031.04 | 590.02     | 441.02 | 189.76      |
#    --- Create chargeback ---
    When Admin sets the business date to "20250317"
    And Admin runs inline COB job for Loan
    And Admin makes "REPAYMENT_ADJUSTMENT_CHARGEBACK" chargeback with 250 EUR transaction amount
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late   | Outstanding |
      |    |      | 20250101  |                 | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0    |            |        |             |
      | 1  | 31   | 20250201 | 20250115 | 664.5           | 335.5         | 4.52     | 0.0  | 0.0       | 340.02 | 340.02 | 340.02     | 0.0    | 0.0         |
      |    |      | 20250215 |                 | 200.0           |               |          | 0.0  |           | 0.0    | 0.0    |            |        |             |
      | 2  | 28   | 20250301    | 20250315   | 434.76          | 429.74        | 11.28    | 0.0  | 0.0       | 441.02 | 441.02 | 0.0        | 441.02 | 0.0         |
      | 3  | 31   | 20250401    |                 | 0.0             | 684.76        | 6.21     | 0.0  | 0.0       | 690.97 | 250.0  | 250.0      | 0.0    | 440.97      |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid    | In advance | Late   | Outstanding |
      | 1450.0        | 22.01    | 0.0  | 0.0       | 1472.01 | 1031.04 | 590.02     | 441.02 | 440.97      |
#    --- Make repayment with amount to close the loan ---
    When Admin sets the business date to "20250318"
    And Admin runs inline COB job for Loan
    And Customer makes "AUTOPAY" repayment on "20250318" with 439 EUR transaction amount
    Then Loan status will be "CLOSED_OBLIGATIONS_MET"
    And Loan has 0 outstanding amount
    And Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late   | Outstanding |
      |    |      | 20250101  |                 | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0    |            |        |             |
      | 1  | 31   | 20250201 | 20250115 | 664.5           | 335.5         | 4.52     | 0.0  | 0.0       | 340.02 | 340.02 | 340.02     | 0.0    | 0.0         |
      |    |      | 20250215 |                 | 200.0           |               |          | 0.0  |           | 0.0    | 0.0    |            |        |             |
      | 2  | 28   | 20250301    | 20250315   | 434.76          | 429.74        | 11.28    | 0.0  | 0.0       | 441.02 | 441.02 | 0.0        | 441.02 | 0.0         |
      | 3  | 31   | 20250401    | 20250318   | 0.0             | 684.76        | 4.24     | 0.0  | 0.0       | 689.0  | 689.0  | 689.0      | 0.0    | 0.0         |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid    | In advance | Late   | Outstanding |
      | 1450.0        | 20.04    | 0.0  | 0.0       | 1470.04 | 1470.04 | 1029.02    | 441.02 | 0.0         |
#    --- Undo last payment ---
    When Admin sets the business date to "20250319"
    And Admin runs inline COB job for Loan
    And Customer undo "1"th "Repayment" transaction made on "20250318"
    Then Loan status will be "ACTIVE"
    And Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late   | Outstanding |
      |    |      | 20250101  |                 | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0    |            |        |             |
      | 1  | 31   | 20250201 | 20250115 | 664.5           | 335.5         | 4.52     | 0.0  | 0.0       | 340.02 | 340.02 | 340.02     | 0.0    | 0.0         |
      |    |      | 20250215 |                 | 200.0           |               |          | 0.0  |           | 0.0    | 0.0    |            |        |             |
      | 2  | 28   | 20250301    | 20250315   | 434.76          | 429.74        | 11.28    | 0.0  | 0.0       | 441.02 | 441.02 | 0.0        | 441.02 | 0.0         |
      | 3  | 31   | 20250401    |                 | 0.0             | 684.76        | 6.21     | 0.0  | 0.0       | 690.97 | 250.0  | 250.0      | 0.0    | 440.97      |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid    | In advance | Late   | Outstanding |
      | 1450.0        | 22.01    | 0.0  | 0.0       | 1472.01 | 1031.04 | 590.02     | 441.02 | 440.97      |
#    --- Make repayment with amount that will overpay the loan with half of first repayment ---
    When Customer makes "AUTOPAY" repayment on "20250319" with 609.15 EUR transaction amount
    Then Loan status will be "OVERPAID"
    And Loan has 170.01 overpaid amount
    And Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late   | Outstanding |
      |    |      | 20250101  |                 | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0    |            |        |             |
      | 1  | 31   | 20250201 | 20250115 | 664.5           | 335.5         | 4.52     | 0.0  | 0.0       | 340.02 | 340.02 | 340.02     | 0.0    | 0.0         |
      |    |      | 20250215 |                 | 200.0           |               |          | 0.0  |           | 0.0    | 0.0    |            |        |             |
      | 2  | 28   | 20250301    | 20250315   | 434.76          | 429.74        | 11.28    | 0.0  | 0.0       | 441.02 | 441.02 | 0.0        | 441.02 | 0.0         |
      | 3  | 31   | 20250401    | 20250319   | 0.0             | 684.76        | 4.38     | 0.0  | 0.0       | 689.14 | 689.14 | 689.14     | 0.0    | 0.0         |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid    | In advance | Late   | Outstanding |
      | 1450.0        | 20.18    | 0.0  | 0.0       | 1470.18 | 1470.18 | 1029.16    | 441.02 | 0.0         |
#    --- Make credit balance refund ---
    When Admin makes Credit Balance Refund transaction on "20250319" with 170.01 EUR transaction amount
    Then Loan status will be "CLOSED_OBLIGATIONS_MET"
    And Loan has 0 outstanding amount
    And Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late   | Outstanding |
      |    |      | 20250101  |                 | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0    |            |        |             |
      | 1  | 31   | 20250201 | 20250115 | 664.5           | 335.5         | 4.52     | 0.0  | 0.0       | 340.02 | 340.02 | 340.02     | 0.0    | 0.0         |
      |    |      | 20250215 |                 | 200.0           |               |          | 0.0  |           | 0.0    | 0.0    |            |        |             |
      | 2  | 28   | 20250301    | 20250315   | 434.76          | 429.74        | 11.28    | 0.0  | 0.0       | 441.02 | 441.02 | 0.0        | 441.02 | 0.0         |
      | 3  | 31   | 20250401    | 20250319   | 0.0             | 684.76        | 4.38     | 0.0  | 0.0       | 689.14 | 689.14 | 689.14     | 0.0    | 0.0         |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid    | In advance | Late   | Outstanding |
      | 1450.0        | 20.18    | 0.0  | 0.0       | 1470.18 | 1470.18 | 1029.16    | 441.02 | 0.0         |
#    --- Make chargeback for first repayment ---
    When Admin makes "REPAYMENT_ADJUSTMENT_CHARGEBACK" chargeback with 340.02 EUR transaction amount for Payment nr. 1
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due     | Paid   | In advance | Late   | Outstanding |
      |    |      | 20250101  |                 | 1000.0          |               |          | 0.0  |           | 0.0     | 0.0    |            |        |             |
      | 1  | 31   | 20250201 | 20250115 | 664.5           | 335.5         | 4.52     | 0.0  | 0.0       | 340.02  | 340.02 | 340.02     | 0.0    | 0.0         |
      |    |      | 20250215 |                 | 200.0           |               |          | 0.0  |           | 0.0     | 0.0    |            |        |             |
      | 2  | 28   | 20250301    | 20250315   | 434.76          | 429.74        | 11.28    | 0.0  | 0.0       | 441.02  | 441.02 | 0.0        | 441.02 | 0.0         |
      | 3  | 31   | 20250401    |                 | 0.0             | 1024.78       | 5.81     | 0.0  | 0.0       | 1030.59 | 689.14 | 689.14     | 0.0    | 341.45      |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid    | In advance | Late   | Outstanding |
      | 1790.02       | 21.61    | 0.0  | 0.0       | 1811.63 | 1470.18 | 1029.16    | 441.02 | 341.45      |
#    --- Make repayment to close the loan ---
    When Customer makes "AUTOPAY" repayment on "20250319" with 340.02 EUR transaction amount
    Then Loan status will be "CLOSED_OBLIGATIONS_MET"
    And Loan has 0 outstanding amount
    And Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due     | Paid    | In advance | Late   | Outstanding |
      |    |      | 20250101  |                 | 1000.0          |               |          | 0.0  |           | 0.0     | 0.0     |            |        |             |
      | 1  | 31   | 20250201 | 20250115 | 664.5           | 335.5         | 4.52     | 0.0  | 0.0       | 340.02  | 340.02  | 340.02     | 0.0    | 0.0         |
      |    |      | 20250215 |                 | 200.0           |               |          | 0.0  |           | 0.0     | 0.0     |            |        |             |
      | 2  | 28   | 20250301    | 20250315   | 434.76          | 429.74        | 11.28    | 0.0  | 0.0       | 441.02  | 441.02  | 0.0        | 441.02 | 0.0         |
      | 3  | 31   | 20250401    | 20250319   | 0.0             | 1024.78       | 4.38     | 0.0  | 0.0       | 1029.16 | 1029.16 | 1029.16    | 0.0    | 0.0         |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid    | In advance | Late   | Outstanding |
      | 1790.02       | 20.18    | 0.0  | 0.0       | 1810.20 | 1810.20 | 1369.18    | 441.02 | 0.0         |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type       | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20250101  | Disbursement           | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       | false    | false    |
      | 20250102  | Accrual                | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250103  | Accrual                | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250104  | Accrual                | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250105  | Accrual                | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250106  | Accrual                | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250107  | Accrual                | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250108  | Accrual                | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250109  | Accrual                | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250110  | Accrual                | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250111  | Accrual                | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250112  | Accrual                | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250113  | Accrual                | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250114  | Accrual                | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250115  | Accrual                | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250115  | Repayment              | 340.02 | 335.5     | 4.52     | 0.0  | 0.0       | 664.5        | false    | false    |
      | 20250116  | Accrual                | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250117  | Accrual                | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250118  | Accrual                | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250119  | Accrual                | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250120  | Accrual                | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250121  | Accrual                | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250122  | Accrual                | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250123  | Accrual                | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250124  | Accrual                | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250125  | Accrual                | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250126  | Accrual                | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250127  | Accrual                | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250128  | Accrual                | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250129  | Accrual                | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250130  | Accrual                | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250131  | Accrual                | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250201 | Accrual                | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250202 | Accrual                | 0.36   | 0.0       | 0.36     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250203 | Accrual                | 0.35   | 0.0       | 0.35     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250204 | Accrual                | 0.36   | 0.0       | 0.36     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250205 | Accrual                | 0.36   | 0.0       | 0.36     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250206 | Accrual                | 0.36   | 0.0       | 0.36     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250207 | Accrual                | 0.35   | 0.0       | 0.35     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250208 | Accrual                | 0.36   | 0.0       | 0.36     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250209 | Accrual                | 0.36   | 0.0       | 0.36     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250210 | Accrual                | 0.35   | 0.0       | 0.35     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250211 | Accrual                | 0.36   | 0.0       | 0.36     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250212 | Accrual                | 0.36   | 0.0       | 0.36     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250213 | Accrual                | 0.36   | 0.0       | 0.36     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250214 | Accrual                | 0.35   | 0.0       | 0.35     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250215 | Disbursement           | 200.0  | 0.0       | 0.0      | 0.0  | 0.0       | 864.5        | false    | false    |
      | 20250215 | Accrual Adjustment     | 3.16   | 0.0       | 3.16     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250216 | Accrual                | 0.31   | 0.0       | 0.31     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250217 | Accrual                | 0.31   | 0.0       | 0.31     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250218 | Accrual                | 0.31   | 0.0       | 0.31     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250219 | Accrual                | 0.31   | 0.0       | 0.31     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250220 | Accrual                | 0.31   | 0.0       | 0.31     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250221 | Accrual                | 0.31   | 0.0       | 0.31     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250222 | Accrual                | 0.3    | 0.0       | 0.3      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250223 | Accrual                | 0.31   | 0.0       | 0.31     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250224 | Accrual                | 0.31   | 0.0       | 0.31     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250225 | Accrual                | 0.31   | 0.0       | 0.31     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250226 | Accrual                | 0.31   | 0.0       | 0.31     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250227 | Accrual                | 0.31   | 0.0       | 0.31     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250228 | Accrual                | 0.31   | 0.0       | 0.31     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250301    | Accrual                | 0.3    | 0.0       | 0.3      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250302    | Accrual                | 0.28   | 0.0       | 0.28     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250303    | Accrual                | 0.28   | 0.0       | 0.28     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250304    | Accrual                | 0.28   | 0.0       | 0.28     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250305    | Accrual                | 0.28   | 0.0       | 0.28     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250306    | Accrual                | 0.27   | 0.0       | 0.27     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250307    | Accrual                | 0.28   | 0.0       | 0.28     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250308    | Accrual                | 0.28   | 0.0       | 0.28     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250309    | Accrual                | 0.28   | 0.0       | 0.28     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250310    | Accrual                | 0.28   | 0.0       | 0.28     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250311    | Accrual                | 0.28   | 0.0       | 0.28     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250312    | Accrual                | 0.28   | 0.0       | 0.28     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250313    | Accrual                | 0.28   | 0.0       | 0.28     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250314    | Accrual                | 0.28   | 0.0       | 0.28     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250315    | Repayment              | 441.02 | 429.74    | 11.28    | 0.0  | 0.0       | 434.76       | false    | false    |
      | 20250315    | Accrual                | 0.27   | 0.0       | 0.27     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250316    | Merchant Issued Refund | 250.0  | 250.0     | 0.0      | 0.0  | 0.0       | 184.76       | false    | false    |
      | 20250316    | Accrual                | 0.14   | 0.0       | 0.14     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250317    | Chargeback             | 250.0  | 250.0     | 0.0      | 0.0  | 0.0       | 434.76       | false    | false    |
      | 20250317    | Accrual                | 0.06   | 0.0       | 0.06     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250318    | Repayment              | 439.0  | 434.76    | 4.24     | 0.0  | 0.0       | 0.0          | true     | false    |
      | 20250318    | Accrual                | 0.14   | 0.0       | 0.14     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250319    | Repayment              | 609.15 | 434.76    | 4.38     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250319    | Accrual                | 0.14   | 0.0       | 0.14     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250319    | Credit Balance Refund  | 170.01 | 0.0       | 0.0      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250319    | Chargeback             | 340.02 | 340.02    | 0.0      | 0.0  | 0.0       | 340.02       | false    | false    |
      | 20250319    | Repayment              | 340.02 | 340.02    | 0.0      | 0.0  | 0.0       | 0.0          | false    | false    |

  @TestRailId:C3911
  Scenario: Verify Loan repayment schedule for progressive loan, interest type: Declining balance, interest calculation period: same as repayment - UC11: complex transactions, interest recalculation disabled, partial period interest calculation enabled
    When Admin sets the business date to "20250101"
    And Admin creates a client with random data
    And Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                            | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DECL_BAL_SARP_EMI_360_30_NO_INT_RECALC_MULTIDISB_PARTIAL_PERIOD | 20250101   | 2000           | 12                     | DECLINING_BALANCE | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 3                 | MONTHS                | 1              | MONTHS                 | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20250101" with "2000" amount and expected disbursement date on "20250101"
    And Admin successfully disburse the loan on "20250101" with "1000" EUR transaction amount
    And Admin runs inline COB job for Loan
    When Admin sets the business date to "20250201"
    And Admin runs inline COB job for Loan
#    --- 2nd Disbursement ---
    When Admin sets the business date to "20250215"
    And Admin runs inline COB job for Loan
    And Admin successfully disburse the loan on "20250215" with "200" EUR transaction amount
#    --- Backdated repayment (early repayment) ---
    When Customer makes "AUTOPAY" repayment on "20250115" with 340.02 EUR transaction amount
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late | Outstanding |
      |    |      | 20250101  |                 | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0    |            |      |             |
      | 1  | 31   | 20250201 | 20250115 | 669.98          | 330.02        | 10.0     | 0.0  | 0.0       | 340.02 | 340.02 | 340.02     | 0.0  | 0.0         |
      |    |      | 20250215 |                 | 200.0           |               |          | 0.0  |           | 0.0    | 0.0    |            |      |             |
      | 2  | 28   | 20250301    |                 | 436.66          | 433.32        | 7.7      | 0.0  | 0.0       | 441.02 | 0.0    | 0.0        | 0.0  | 441.02      |
      | 3  | 31   | 20250401    |                 | 0.0             | 436.66        | 4.37     | 0.0  | 0.0       | 441.03 | 0.0    | 0.0        | 0.0  | 441.03      |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid   | In advance | Late | Outstanding |
      | 1200.0        | 22.07    | 0.0  | 0.0       | 1222.07 | 340.02 | 340.02     | 0.0  | 882.05      |
#    --- Make full 2nd period repayment (late repayment) ---
    When Admin sets the business date to "20250315"
    And Admin runs inline COB job for Loan
    And Customer makes "AUTOPAY" repayment on "20250315" with 441.02 EUR transaction amount
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late   | Outstanding |
      |    |      | 20250101  |                 | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0    |            |        |             |
      | 1  | 31   | 20250201 | 20250115 | 669.98          | 330.02        | 10.0     | 0.0  | 0.0       | 340.02 | 340.02 | 340.02     | 0.0    | 0.0         |
      |    |      | 20250215 |                 | 200.0           |               |          | 0.0  |           | 0.0    | 0.0    |            |        |             |
      | 2  | 28   | 20250301    | 20250315   | 436.66          | 433.32        | 7.7      | 0.0  | 0.0       | 441.02 | 441.02 | 0.0        | 441.02 | 0.0         |
      | 3  | 31   | 20250401    |                 | 0.0             | 436.66        | 4.37     | 0.0  | 0.0       | 441.03 | 0.0    | 0.0        | 0.0    | 441.03      |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid   | In advance | Late   | Outstanding |
      | 1200.0        | 22.07    | 0.0  | 0.0       | 1222.07 | 781.04 | 340.02     | 441.02 | 441.03      |
  #    --- Make merchant issued refund ---
    When Admin sets the business date to "20250316"
    And Admin runs inline COB job for Loan
    And Customer makes "MERCHANT_ISSUED_REFUND" transaction with "AUTOPAY" payment type on "20250316" with 250 EUR transaction amount and system-generated Idempotency key
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late   | Outstanding |
      |    |      | 20250101  |                 | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0    |            |        |             |
      | 1  | 31   | 20250201 | 20250115 | 669.98          | 330.02        | 10.0     | 0.0  | 0.0       | 340.02 | 340.02 | 340.02     | 0.0    | 0.0         |
      |    |      | 20250215 |                 | 200.0           |               |          | 0.0  |           | 0.0    | 0.0    |            |        |             |
      | 2  | 28   | 20250301    | 20250315   | 436.66          | 433.32        | 7.7      | 0.0  | 0.0       | 441.02 | 441.02 | 0.0        | 441.02 | 0.0         |
      | 3  | 31   | 20250401    |                 | 0.0             | 436.66        | 4.37     | 0.0  | 0.0       | 441.03 | 250.0  | 250.0      | 0.0    | 191.03      |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid    | In advance | Late   | Outstanding |
      | 1200.0        | 22.07    | 0.0  | 0.0       | 1222.07 | 1031.04 | 590.02     | 441.02 | 191.03      |
#    --- Create chargeback ---
    When Admin sets the business date to "20250317"
    And Admin runs inline COB job for Loan
    And Admin makes "REPAYMENT_ADJUSTMENT_CHARGEBACK" chargeback with 250 EUR transaction amount
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late   | Outstanding |
      |    |      | 20250101  |                 | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0    |            |        |             |
      | 1  | 31   | 20250201 | 20250115 | 669.98          | 330.02        | 10.0     | 0.0  | 0.0       | 340.02 | 340.02 | 340.02     | 0.0    | 0.0         |
      |    |      | 20250215 |                 | 200.0           |               |          | 0.0  |           | 0.0    | 0.0    |            |        |             |
      | 2  | 28   | 20250301    | 20250315   | 436.66          | 433.32        | 7.7      | 0.0  | 0.0       | 441.02 | 441.02 | 0.0        | 441.02 | 0.0         |
      | 3  | 31   | 20250401    |                 | 0.0             | 686.66        | 4.37     | 0.0  | 0.0       | 691.03 | 250.0  | 250.0      | 0.0    | 441.03      |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid    | In advance | Late   | Outstanding |
      | 1450.0        | 22.07    | 0.0  | 0.0       | 1472.07 | 1031.04 | 590.02     | 441.02 | 441.03      |
#    --- Make repayment with amount to close the loan ---
    When Admin sets the business date to "20250318"
    And Admin runs inline COB job for Loan
    And Customer makes "AUTOPAY" repayment on "20250318" with 441.03 EUR transaction amount
    Then Loan status will be "CLOSED_OBLIGATIONS_MET"
    And Loan has 0 outstanding amount
    And Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late   | Outstanding |
      |    |      | 20250101  |                 | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0    |            |        |             |
      | 1  | 31   | 20250201 | 20250115 | 669.98          | 330.02        | 10.0     | 0.0  | 0.0       | 340.02 | 340.02 | 340.02     | 0.0    | 0.0         |
      |    |      | 20250215 |                 | 200.0           |               |          | 0.0  |           | 0.0    | 0.0    |            |        |             |
      | 2  | 28   | 20250301    | 20250315   | 436.66          | 433.32        | 7.7      | 0.0  | 0.0       | 441.02 | 441.02 | 0.0        | 441.02 | 0.0         |
      | 3  | 31   | 20250401    | 20250318   | 0.0             | 686.66        | 4.37     | 0.0  | 0.0       | 691.03 | 691.03 | 691.03     | 0.0    | 0.0         |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid    | In advance | Late   | Outstanding |
      | 1450.0        | 22.07    | 0.0  | 0.0       | 1472.07 | 1472.07 | 1031.05    | 441.02 | 0.0         |
#    --- Undo last payment ---
    When Admin sets the business date to "20250319"
    And Admin runs inline COB job for Loan
    And Customer undo "1"th "Repayment" transaction made on "20250318"
    Then Loan status will be "ACTIVE"
    And Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late   | Outstanding |
      |    |      | 20250101  |                 | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0    |            |        |             |
      | 1  | 31   | 20250201 | 20250115 | 669.98          | 330.02        | 10.0     | 0.0  | 0.0       | 340.02 | 340.02 | 340.02     | 0.0    | 0.0         |
      |    |      | 20250215 |                 | 200.0           |               |          | 0.0  |           | 0.0    | 0.0    |            |        |             |
      | 2  | 28   | 20250301    | 20250315   | 436.66          | 433.32        | 7.7      | 0.0  | 0.0       | 441.02 | 441.02 | 0.0        | 441.02 | 0.0         |
      | 3  | 31   | 20250401    |                 | 0.0             | 686.66        | 4.37     | 0.0  | 0.0       | 691.03 | 250.0  | 250.0      | 0.0    | 441.03      |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid    | In advance | Late   | Outstanding |
      | 1450.0        | 22.07    | 0.0  | 0.0       | 1472.07 | 1031.04 | 590.02     | 441.02 | 441.03      |
#    --- Make repayment with amount that will overpay the loan with half of first repayment ---
    When Customer makes "AUTOPAY" repayment on "20250319" with 611.04 EUR transaction amount
    Then Loan status will be "OVERPAID"
    And Loan has 170.01 overpaid amount
    And Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late   | Outstanding |
      |    |      | 20250101  |                 | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0    |            |        |             |
      | 1  | 31   | 20250201 | 20250115 | 669.98          | 330.02        | 10.0     | 0.0  | 0.0       | 340.02 | 340.02 | 340.02     | 0.0    | 0.0         |
      |    |      | 20250215 |                 | 200.0           |               |          | 0.0  |           | 0.0    | 0.0    |            |        |             |
      | 2  | 28   | 20250301    | 20250315   | 436.66          | 433.32        | 7.7      | 0.0  | 0.0       | 441.02 | 441.02 | 0.0        | 441.02 | 0.0         |
      | 3  | 31   | 20250401    | 20250319   | 0.0             | 686.66        | 4.37     | 0.0  | 0.0       | 691.03 | 691.03 | 691.03     | 0.0    | 0.0         |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid    | In advance | Late   | Outstanding |
      | 1450.0        | 22.07    | 0.0  | 0.0       | 1472.07 | 1472.07 | 1031.05    | 441.02 | 0.0         |
#    --- Make credit balance refund ---
    When Admin makes Credit Balance Refund transaction on "20250319" with 170.01 EUR transaction amount
    Then Loan status will be "CLOSED_OBLIGATIONS_MET"
    And Loan has 0 outstanding amount
    And Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late   | Outstanding |
      |    |      | 20250101  |                 | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0    |            |        |             |
      | 1  | 31   | 20250201 | 20250115 | 669.98          | 330.02        | 10.0     | 0.0  | 0.0       | 340.02 | 340.02 | 340.02     | 0.0    | 0.0         |
      |    |      | 20250215 |                 | 200.0           |               |          | 0.0  |           | 0.0    | 0.0    |            |        |             |
      | 2  | 28   | 20250301    | 20250315   | 436.66          | 433.32        | 7.7      | 0.0  | 0.0       | 441.02 | 441.02 | 0.0        | 441.02 | 0.0         |
      | 3  | 31   | 20250401    | 20250319   | 0.0             | 686.66        | 4.37     | 0.0  | 0.0       | 691.03 | 691.03 | 691.03     | 0.0    | 0.0         |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid    | In advance | Late   | Outstanding |
      | 1450.0        | 22.07    | 0.0  | 0.0       | 1472.07 | 1472.07 | 1031.05    | 441.02 | 0.0         |
#    --- Make chargeback for first repayment ---
    When Admin makes "REPAYMENT_ADJUSTMENT_CHARGEBACK" chargeback with 340.02 EUR transaction amount for Payment nr. 1
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due     | Paid   | In advance | Late   | Outstanding |
      |    |      | 20250101  |                 | 1000.0          |               |          | 0.0  |           | 0.0     | 0.0    |            |        |             |
      | 1  | 31   | 20250201 | 20250115 | 669.98          | 330.02        | 10.0     | 0.0  | 0.0       | 340.02  | 340.02 | 340.02     | 0.0    | 0.0         |
      |    |      | 20250215 |                 | 200.0           |               |          | 0.0  |           | 0.0     | 0.0    |            |        |             |
      | 2  | 28   | 20250301    | 20250315   | 436.66          | 433.32        | 7.7      | 0.0  | 0.0       | 441.02  | 441.02 | 0.0        | 441.02 | 0.0         |
      | 3  | 31   | 20250401    |                 | 0.0             | 1026.68       | 4.37     | 0.0  | 0.0       | 1031.05 | 691.03 | 691.03     | 0.0    | 340.02      |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid    | In advance | Late   | Outstanding |
      | 1790.02       | 22.07    | 0.0  | 0.0       | 1812.09 | 1472.07 | 1031.05    | 441.02 | 340.02      |
#    --- Make repayment to close the loan ---
    When Customer makes "AUTOPAY" repayment on "20250319" with 340.02 EUR transaction amount
    Then Loan status will be "CLOSED_OBLIGATIONS_MET"
    And Loan has 0 outstanding amount
    And Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due     | Paid    | In advance | Late   | Outstanding |
      |    |      | 20250101  |                 | 1000.0          |               |          | 0.0  |           | 0.0     | 0.0     |            |        |             |
      | 1  | 31   | 20250201 | 20250115 | 669.98          | 330.02        | 10.0     | 0.0  | 0.0       | 340.02  | 340.02  | 340.02     | 0.0    | 0.0         |
      |    |      | 20250215 |                 | 200.0           |               |          | 0.0  |           | 0.0     | 0.0     |            |        |             |
      | 2  | 28   | 20250301    | 20250315   | 436.66          | 433.32        | 7.7      | 0.0  | 0.0       | 441.02  | 441.02  | 0.0        | 441.02 | 0.0         |
      | 3  | 31   | 20250401    | 20250319   | 0.0             | 1026.68       | 4.37     | 0.0  | 0.0       | 1031.05 | 1031.05 | 1031.05    | 0.0    | 0.0         |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid    | In advance | Late   | Outstanding |
      | 1790.02       | 22.07    | 0.0  | 0.0       | 1812.09 | 1812.09 | 1371.07    | 441.02 | 0.0         |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type       | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20250101  | Disbursement           | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       | false    | false    |
      | 20250102  | Accrual                | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250103  | Accrual                | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250104  | Accrual                | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250105  | Accrual                | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250106  | Accrual                | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250107  | Accrual                | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250108  | Accrual                | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250109  | Accrual                | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250110  | Accrual                | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250111  | Accrual                | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250112  | Accrual                | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250113  | Accrual                | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250114  | Accrual                | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250115  | Accrual                | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250115  | Repayment              | 340.02 | 330.02    | 10.0     | 0.0  | 0.0       | 669.98       | false    | false    |
      | 20250116  | Accrual                | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250117  | Accrual                | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250118  | Accrual                | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250119  | Accrual                | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250120  | Accrual                | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250121  | Accrual                | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250122  | Accrual                | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250123  | Accrual                | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250124  | Accrual                | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250125  | Accrual                | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250126  | Accrual                | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250127  | Accrual                | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250128  | Accrual                | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250129  | Accrual                | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250130  | Accrual                | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250131  | Accrual                | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250201 | Accrual                | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250202 | Accrual                | 0.24   | 0.0       | 0.24     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250203 | Accrual                | 0.24   | 0.0       | 0.24     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250204 | Accrual                | 0.24   | 0.0       | 0.24     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250205 | Accrual                | 0.24   | 0.0       | 0.24     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250206 | Accrual                | 0.24   | 0.0       | 0.24     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250207 | Accrual                | 0.24   | 0.0       | 0.24     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250208 | Accrual                | 0.23   | 0.0       | 0.23     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250209 | Accrual                | 0.24   | 0.0       | 0.24     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250210 | Accrual                | 0.24   | 0.0       | 0.24     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250211 | Accrual                | 0.24   | 0.0       | 0.24     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250212 | Accrual                | 0.24   | 0.0       | 0.24     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250213 | Accrual                | 0.24   | 0.0       | 0.24     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250214 | Accrual                | 0.24   | 0.0       | 0.24     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250215 | Disbursement           | 200.0  | 0.0       | 0.0      | 0.0  | 0.0       | 869.98       | false    | false    |
      | 20250215 | Accrual                | 0.24   | 0.0       | 0.24     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250216 | Accrual                | 0.31   | 0.0       | 0.31     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250217 | Accrual                | 0.31   | 0.0       | 0.31     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250218 | Accrual                | 0.31   | 0.0       | 0.31     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250219 | Accrual                | 0.31   | 0.0       | 0.31     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250220 | Accrual                | 0.31   | 0.0       | 0.31     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250221 | Accrual                | 0.31   | 0.0       | 0.31     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250222 | Accrual                | 0.31   | 0.0       | 0.31     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250223 | Accrual                | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250224 | Accrual                | 0.31   | 0.0       | 0.31     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250225 | Accrual                | 0.31   | 0.0       | 0.31     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250226 | Accrual                | 0.31   | 0.0       | 0.31     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250227 | Accrual                | 0.31   | 0.0       | 0.31     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250228 | Accrual                | 0.31   | 0.0       | 0.31     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250301    | Accrual                | 0.31   | 0.0       | 0.31     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250302    | Accrual                | 0.14   | 0.0       | 0.14     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250303    | Accrual                | 0.14   | 0.0       | 0.14     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250304    | Accrual                | 0.14   | 0.0       | 0.14     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250305    | Accrual                | 0.14   | 0.0       | 0.14     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250306    | Accrual                | 0.14   | 0.0       | 0.14     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250307    | Accrual                | 0.15   | 0.0       | 0.15     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250308    | Accrual                | 0.14   | 0.0       | 0.14     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250309    | Accrual                | 0.14   | 0.0       | 0.14     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250310    | Accrual                | 0.14   | 0.0       | 0.14     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250311    | Accrual                | 0.14   | 0.0       | 0.14     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250312    | Accrual                | 0.14   | 0.0       | 0.14     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250313    | Accrual                | 0.14   | 0.0       | 0.14     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250314    | Accrual                | 0.14   | 0.0       | 0.14     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250315    | Repayment              | 441.02 | 433.32    | 7.7      | 0.0  | 0.0       | 436.66       | false    | false    |
      | 20250315    | Accrual                | 0.14   | 0.0       | 0.14     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250316    | Merchant Issued Refund | 250.0  | 250.0     | 0.0      | 0.0  | 0.0       | 186.66       | false    | false    |
      | 20250316    | Accrual                | 0.14   | 0.0       | 0.14     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250317    | Chargeback             | 250.0  | 250.0     | 0.0      | 0.0  | 0.0       | 436.66       | false    | false    |
      | 20250317    | Accrual                | 0.14   | 0.0       | 0.14     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250318    | Repayment              | 441.03 | 436.66    | 4.37     | 0.0  | 0.0       | 0.0          | true     | false    |
      | 20250318    | Accrual                | 2.12   | 0.0       | 2.12     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250319    | Repayment              | 611.04 | 436.66    | 4.37     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250319    | Credit Balance Refund  | 170.01 | 0.0       | 0.0      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250319    | Chargeback             | 340.02 | 340.02    | 0.0      | 0.0  | 0.0       | 340.02       | false    | false    |
      | 20250319    | Repayment              | 340.02 | 340.02    | 0.0      | 0.0  | 0.0       | 0.0          | false    | false    |

  @TestRailId:C3912
  Scenario: Verify Loan repayment schedule for progressive loan, interest type: Declining balance, interest calculation period: same as repayment - UC12: complex transactions, interest recalculation disabled, partial period interest calculation disabled
    When Admin sets the business date to "20250101"
    And Admin creates a client with random data
    And Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                               | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DECL_BAL_SARP_EMI_360_30_NO_INT_RECALC_MULTIDISB_NO_PARTIAL_PERIOD | 20250101   | 2000           | 12                     | DECLINING_BALANCE | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 3                 | MONTHS                | 1              | MONTHS                 | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20250101" with "2000" amount and expected disbursement date on "20250101"
    And Admin successfully disburse the loan on "20250101" with "1000" EUR transaction amount
    And Admin runs inline COB job for Loan
    When Admin sets the business date to "20250201"
    And Admin runs inline COB job for Loan
#    --- 2nd Disbursement ---
    When Admin sets the business date to "20250215"
    And Admin runs inline COB job for Loan
    And Admin successfully disburse the loan on "20250215" with "200" EUR transaction amount
#    --- Backdated repayment (early repayment) ---
    When Customer makes "AUTOPAY" repayment on "20250115" with 340.02 EUR transaction amount
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late | Outstanding |
      |    |      | 20250101  |                 | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0    |            |      |             |
      | 1  | 31   | 20250201 | 20250115 | 669.98          | 330.02        | 10.0     | 0.0  | 0.0       | 340.02 | 340.02 | 340.02     | 0.0  | 0.0         |
      |    |      | 20250215 |                 | 200.0           |               |          | 0.0  |           | 0.0    | 0.0    |            |      |             |
      | 2  | 28   | 20250301    |                 | 437.15          | 432.83        | 8.7      | 0.0  | 0.0       | 441.53 | 0.0    | 0.0        | 0.0  | 441.53      |
      | 3  | 31   | 20250401    |                 | 0.0             | 437.15        | 4.37     | 0.0  | 0.0       | 441.52 | 0.0    | 0.0        | 0.0  | 441.52      |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid   | In advance | Late | Outstanding |
      | 1200.0        | 23.07    | 0.0  | 0.0       | 1223.07 | 340.02 | 340.02     | 0.0  | 883.05      |
#    --- Make full 2nd period repayment (late repayment) ---
    When Admin sets the business date to "20250315"
    And Admin runs inline COB job for Loan
    And Customer makes "AUTOPAY" repayment on "20250315" with 441.53 EUR transaction amount
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late   | Outstanding |
      |    |      | 20250101  |                 | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0    |            |        |             |
      | 1  | 31   | 20250201 | 20250115 | 669.98          | 330.02        | 10.0     | 0.0  | 0.0       | 340.02 | 340.02 | 340.02     | 0.0    | 0.0         |
      |    |      | 20250215 |                 | 200.0           |               |          | 0.0  |           | 0.0    | 0.0    |            |        |             |
      | 2  | 28   | 20250301    | 20250315   | 437.15          | 432.83        | 8.7      | 0.0  | 0.0       | 441.53 | 441.53 | 0.0        | 441.53 | 0.0         |
      | 3  | 31   | 20250401    |                 | 0.0             | 437.15        | 4.37     | 0.0  | 0.0       | 441.52 | 0.0    | 0.0        | 0.0    | 441.52      |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid   | In advance | Late   | Outstanding |
      | 1200.0        | 23.07    | 0.0  | 0.0       | 1223.07 | 781.55 | 340.02     | 441.53 | 441.52      |
  #    --- Make merchant issued refund ---
    When Admin sets the business date to "20250316"
    And Admin runs inline COB job for Loan
    And Customer makes "MERCHANT_ISSUED_REFUND" transaction with "AUTOPAY" payment type on "20250316" with 250 EUR transaction amount and system-generated Idempotency key
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late   | Outstanding |
      |    |      | 20250101  |                 | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0    |            |        |             |
      | 1  | 31   | 20250201 | 20250115 | 669.98          | 330.02        | 10.0     | 0.0  | 0.0       | 340.02 | 340.02 | 340.02     | 0.0    | 0.0         |
      |    |      | 20250215 |                 | 200.0           |               |          | 0.0  |           | 0.0    | 0.0    |            |        |             |
      | 2  | 28   | 20250301    | 20250315   | 437.15          | 432.83        | 8.7      | 0.0  | 0.0       | 441.53 | 441.53 | 0.0        | 441.53 | 0.0         |
      | 3  | 31   | 20250401    |                 | 0.0             | 437.15        | 4.37     | 0.0  | 0.0       | 441.52 | 250.0  | 250.0      | 0.0    | 191.52      |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid    | In advance | Late   | Outstanding |
      | 1200.0        | 23.07    | 0.0  | 0.0       | 1223.07 | 1031.55 | 590.02     | 441.53 | 191.52      |
#    --- Create chargeback ---
    When Admin sets the business date to "20250317"
    And Admin runs inline COB job for Loan
    And Admin makes "REPAYMENT_ADJUSTMENT_CHARGEBACK" chargeback with 250 EUR transaction amount
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late   | Outstanding |
      |    |      | 20250101  |                 | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0    |            |        |             |
      | 1  | 31   | 20250201 | 20250115 | 669.98          | 330.02        | 10.0     | 0.0  | 0.0       | 340.02 | 340.02 | 340.02     | 0.0    | 0.0         |
      |    |      | 20250215 |                 | 200.0           |               |          | 0.0  |           | 0.0    | 0.0    |            |        |             |
      | 2  | 28   | 20250301    | 20250315   | 437.15          | 432.83        | 8.7      | 0.0  | 0.0       | 441.53 | 441.53 | 0.0        | 441.53 | 0.0         |
      | 3  | 31   | 20250401    |                 | 0.0             | 687.15        | 4.37     | 0.0  | 0.0       | 691.52 | 250.0  | 250.0      | 0.0    | 441.52      |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid    | In advance | Late   | Outstanding |
      | 1450.0        | 23.07    | 0.0  | 0.0       | 1473.07 | 1031.55 | 590.02     | 441.53 | 441.52      |
#    --- Make repayment with amount to close the loan ---
    When Admin sets the business date to "20250318"
    And Admin runs inline COB job for Loan
    And Customer makes "AUTOPAY" repayment on "20250318" with 441.52 EUR transaction amount
    Then Loan status will be "CLOSED_OBLIGATIONS_MET"
    And Loan has 0 outstanding amount
    And Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late   | Outstanding |
      |    |      | 20250101  |                 | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0    |            |        |             |
      | 1  | 31   | 20250201 | 20250115 | 669.98          | 330.02        | 10.0     | 0.0  | 0.0       | 340.02 | 340.02 | 340.02     | 0.0    | 0.0         |
      |    |      | 20250215 |                 | 200.0           |               |          | 0.0  |           | 0.0    | 0.0    |            |        |             |
      | 2  | 28   | 20250301    | 20250315   | 437.15          | 432.83        | 8.7      | 0.0  | 0.0       | 441.53 | 441.53 | 0.0        | 441.53 | 0.0         |
      | 3  | 31   | 20250401    | 20250318   | 0.0             | 687.15        | 4.37     | 0.0  | 0.0       | 691.52 | 691.52 | 691.52     | 0.0    | 0.0         |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid    | In advance | Late   | Outstanding |
      | 1450.0        | 23.07    | 0.0  | 0.0       | 1473.07 | 1473.07 | 1031.54    | 441.53 | 0.0         |
#    --- Undo last payment ---
    When Admin sets the business date to "20250319"
    And Admin runs inline COB job for Loan
    And Customer undo "1"th "Repayment" transaction made on "20250318"
    Then Loan status will be "ACTIVE"
    And Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late   | Outstanding |
      |    |      | 20250101  |                 | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0    |            |        |             |
      | 1  | 31   | 20250201 | 20250115 | 669.98          | 330.02        | 10.0     | 0.0  | 0.0       | 340.02 | 340.02 | 340.02     | 0.0    | 0.0         |
      |    |      | 20250215 |                 | 200.0           |               |          | 0.0  |           | 0.0    | 0.0    |            |        |             |
      | 2  | 28   | 20250301    | 20250315   | 437.15          | 432.83        | 8.7      | 0.0  | 0.0       | 441.53 | 441.53 | 0.0        | 441.53 | 0.0         |
      | 3  | 31   | 20250401    |                 | 0.0             | 687.15        | 4.37     | 0.0  | 0.0       | 691.52 | 250.0  | 250.0      | 0.0    | 441.52      |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid    | In advance | Late   | Outstanding |
      | 1450.0        | 23.07    | 0.0  | 0.0       | 1473.07 | 1031.55 | 590.02     | 441.53 | 441.52      |
#    --- Make repayment with amount that will overpay the loan with half of first repayment ---
    When Customer makes "AUTOPAY" repayment on "20250319" with 611.53 EUR transaction amount
    Then Loan status will be "OVERPAID"
    And Loan has 170.01 overpaid amount
    And Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late   | Outstanding |
      |    |      | 20250101  |                 | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0    |            |        |             |
      | 1  | 31   | 20250201 | 20250115 | 669.98          | 330.02        | 10.0     | 0.0  | 0.0       | 340.02 | 340.02 | 340.02     | 0.0    | 0.0         |
      |    |      | 20250215 |                 | 200.0           |               |          | 0.0  |           | 0.0    | 0.0    |            |        |             |
      | 2  | 28   | 20250301    | 20250315   | 437.15          | 432.83        | 8.7      | 0.0  | 0.0       | 441.53 | 441.53 | 0.0        | 441.53 | 0.0         |
      | 3  | 31   | 20250401    | 20250319   | 0.0             | 687.15        | 4.37     | 0.0  | 0.0       | 691.52 | 691.52 | 691.52     | 0.0    | 0.0         |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid    | In advance | Late   | Outstanding |
      | 1450.0        | 23.07    | 0.0  | 0.0       | 1473.07 | 1473.07 | 1031.54    | 441.53 | 0.0         |
#    --- Make credit balance refund ---
    When Admin makes Credit Balance Refund transaction on "20250319" with 170.01 EUR transaction amount
    Then Loan status will be "CLOSED_OBLIGATIONS_MET"
    And Loan has 0 outstanding amount
    And Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late   | Outstanding |
      |    |      | 20250101  |                 | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0    |            |        |             |
      | 1  | 31   | 20250201 | 20250115 | 669.98          | 330.02        | 10.0     | 0.0  | 0.0       | 340.02 | 340.02 | 340.02     | 0.0    | 0.0         |
      |    |      | 20250215 |                 | 200.0           |               |          | 0.0  |           | 0.0    | 0.0    |            |        |             |
      | 2  | 28   | 20250301    | 20250315   | 437.15          | 432.83        | 8.7      | 0.0  | 0.0       | 441.53 | 441.53 | 0.0        | 441.53 | 0.0         |
      | 3  | 31   | 20250401    | 20250319   | 0.0             | 687.15        | 4.37     | 0.0  | 0.0       | 691.52 | 691.52 | 691.52     | 0.0    | 0.0         |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid    | In advance | Late   | Outstanding |
      | 1450.0        | 23.07    | 0.0  | 0.0       | 1473.07 | 1473.07 | 1031.54    | 441.53 | 0.0         |
#    --- Make chargeback for first repayment ---
    When Admin makes "REPAYMENT_ADJUSTMENT_CHARGEBACK" chargeback with 340.02 EUR transaction amount for Payment nr. 1
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due     | Paid   | In advance | Late   | Outstanding |
      |    |      | 20250101  |                 | 1000.0          |               |          | 0.0  |           | 0.0     | 0.0    |            |        |             |
      | 1  | 31   | 20250201 | 20250115 | 669.98          | 330.02        | 10.0     | 0.0  | 0.0       | 340.02  | 340.02 | 340.02     | 0.0    | 0.0         |
      |    |      | 20250215 |                 | 200.0           |               |          | 0.0  |           | 0.0     | 0.0    |            |        |             |
      | 2  | 28   | 20250301    | 20250315   | 437.15          | 432.83        | 8.7      | 0.0  | 0.0       | 441.53  | 441.53 | 0.0        | 441.53 | 0.0         |
      | 3  | 31   | 20250401    |                 | 0.0             | 1027.17       | 4.37     | 0.0  | 0.0       | 1031.54 | 691.52 | 691.52     | 0.0    | 340.02      |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid    | In advance | Late   | Outstanding |
      | 1790.02       | 23.07    | 0.0  | 0.0       | 1813.09 | 1473.07 | 1031.54    | 441.53 | 340.02      |
#    --- Make repayment to close the loan ---
    When Customer makes "AUTOPAY" repayment on "20250319" with 340.02 EUR transaction amount
    Then Loan status will be "CLOSED_OBLIGATIONS_MET"
    And Loan has 0 outstanding amount
    And Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due     | Paid    | In advance | Late   | Outstanding |
      |    |      | 20250101  |                 | 1000.0          |               |          | 0.0  |           | 0.0     | 0.0     |            |        |             |
      | 1  | 31   | 20250201 | 20250115 | 669.98          | 330.02        | 10.0     | 0.0  | 0.0       | 340.02  | 340.02  | 340.02     | 0.0    | 0.0         |
      |    |      | 20250215 |                 | 200.0           |               |          | 0.0  |           | 0.0     | 0.0     |            |        |             |
      | 2  | 28   | 20250301    | 20250315   | 437.15          | 432.83        | 8.7      | 0.0  | 0.0       | 441.53  | 441.53  | 0.0        | 441.53 | 0.0         |
      | 3  | 31   | 20250401    | 20250319   | 0.0             | 1027.17       | 4.37     | 0.0  | 0.0       | 1031.54 | 1031.54 | 1031.54    | 0.0    | 0.0         |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid    | In advance | Late   | Outstanding |
      | 1790.02       | 23.07    | 0.0  | 0.0       | 1813.09 | 1813.09 | 1371.56    | 441.53 | 0.0         |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type       | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20250101  | Disbursement           | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       | false    | false    |
      | 20250102  | Accrual                | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250103  | Accrual                | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250104  | Accrual                | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250105  | Accrual                | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250106  | Accrual                | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250107  | Accrual                | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250108  | Accrual                | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250109  | Accrual                | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250110  | Accrual                | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250111  | Accrual                | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250112  | Accrual                | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250113  | Accrual                | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250114  | Accrual                | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250115  | Accrual                | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250115  | Repayment              | 340.02 | 330.02    | 10.0     | 0.0  | 0.0       | 669.98       | false    | false    |
      | 20250116  | Accrual                | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250117  | Accrual                | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250118  | Accrual                | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250119  | Accrual                | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250120  | Accrual                | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250121  | Accrual                | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250122  | Accrual                | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250123  | Accrual                | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250124  | Accrual                | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250125  | Accrual                | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250126  | Accrual                | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250127  | Accrual                | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250128  | Accrual                | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250129  | Accrual                | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250130  | Accrual                | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250131  | Accrual                | 0.33   | 0.0       | 0.33     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250201 | Accrual                | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250202 | Accrual                | 0.24   | 0.0       | 0.24     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250203 | Accrual                | 0.24   | 0.0       | 0.24     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250204 | Accrual                | 0.24   | 0.0       | 0.24     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250205 | Accrual                | 0.24   | 0.0       | 0.24     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250206 | Accrual                | 0.24   | 0.0       | 0.24     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250207 | Accrual                | 0.24   | 0.0       | 0.24     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250208 | Accrual                | 0.23   | 0.0       | 0.23     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250209 | Accrual                | 0.24   | 0.0       | 0.24     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250210 | Accrual                | 0.24   | 0.0       | 0.24     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250211 | Accrual                | 0.24   | 0.0       | 0.24     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250212 | Accrual                | 0.24   | 0.0       | 0.24     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250213 | Accrual                | 0.24   | 0.0       | 0.24     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250214 | Accrual                | 0.24   | 0.0       | 0.24     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250215 | Disbursement           | 200.0  | 0.0       | 0.0      | 0.0  | 0.0       | 869.98       | false    | false    |
      | 20250215 | Accrual                | 1.24   | 0.0       | 1.24     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250216 | Accrual                | 0.31   | 0.0       | 0.31     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250217 | Accrual                | 0.31   | 0.0       | 0.31     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250218 | Accrual                | 0.31   | 0.0       | 0.31     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250219 | Accrual                | 0.31   | 0.0       | 0.31     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250220 | Accrual                | 0.31   | 0.0       | 0.31     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250221 | Accrual                | 0.31   | 0.0       | 0.31     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250222 | Accrual                | 0.31   | 0.0       | 0.31     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250223 | Accrual                | 0.32   | 0.0       | 0.32     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250224 | Accrual                | 0.31   | 0.0       | 0.31     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250225 | Accrual                | 0.31   | 0.0       | 0.31     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250226 | Accrual                | 0.31   | 0.0       | 0.31     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250227 | Accrual                | 0.31   | 0.0       | 0.31     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250228 | Accrual                | 0.31   | 0.0       | 0.31     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250301    | Accrual                | 0.31   | 0.0       | 0.31     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250302    | Accrual                | 0.14   | 0.0       | 0.14     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250303    | Accrual                | 0.14   | 0.0       | 0.14     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250304    | Accrual                | 0.14   | 0.0       | 0.14     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250305    | Accrual                | 0.14   | 0.0       | 0.14     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250306    | Accrual                | 0.15   | 0.0       | 0.15     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250307    | Accrual                | 0.14   | 0.0       | 0.14     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250308    | Accrual                | 0.14   | 0.0       | 0.14     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250309    | Accrual                | 0.14   | 0.0       | 0.14     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250310    | Accrual                | 0.14   | 0.0       | 0.14     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250311    | Accrual                | 0.14   | 0.0       | 0.14     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250312    | Accrual                | 0.14   | 0.0       | 0.14     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250313    | Accrual                | 0.14   | 0.0       | 0.14     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250314    | Accrual                | 0.14   | 0.0       | 0.14     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250315    | Repayment              | 441.53 | 432.83    | 8.7      | 0.0  | 0.0       | 437.15       | false    | false    |
      | 20250315    | Accrual                | 0.14   | 0.0       | 0.14     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250316    | Merchant Issued Refund | 250.0  | 250.0     | 0.0      | 0.0  | 0.0       | 187.15       | false    | false    |
      | 20250316    | Accrual                | 0.15   | 0.0       | 0.15     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250317    | Chargeback             | 250.0  | 250.0     | 0.0      | 0.0  | 0.0       | 437.15       | false    | false    |
      | 20250317    | Accrual                | 0.14   | 0.0       | 0.14     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250318    | Repayment              | 441.52 | 437.15    | 4.37     | 0.0  | 0.0       | 0.0          | true     | false    |
      | 20250318    | Accrual                | 2.11   | 0.0       | 2.11     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250319    | Repayment              | 611.53 | 437.15    | 4.37     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250319    | Credit Balance Refund  | 170.01 | 0.0       | 0.0      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250319    | Chargeback             | 340.02 | 340.02    | 0.0      | 0.0  | 0.0       | 340.02       | false    | false    |
      | 20250319    | Repayment              | 340.02 | 340.02    | 0.0      | 0.0  | 0.0       | 0.0          | false    | false    |
