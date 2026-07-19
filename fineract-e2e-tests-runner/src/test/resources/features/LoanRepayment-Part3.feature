@Repayment
Feature: LoanRepayment - Part3

  @TestRailId:C2908 @AdvancedPaymentAllocation
  Scenario: Verify that in case of pre-payed installments for total amount (loan balance is 0) LoanRepaymentDueBusinessEvent is not sent - LP2 advanced payment allocation product
    When Admin sets the business date to "20231001"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                      | submitted on date | with Principal | ANNUAL interest rate % | interest type | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_DOWNPAYMENT_AUTO_ADVANCED_PAYMENT_ALLOCATION | 20231001   | 1000           | 0                      | FLAT          | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 45                | DAYS                  | 15             | DAYS                   | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20231001" with "1000" amount and expected disbursement date on "20231001"
    When Admin successfully disburse the loan on "20231001" with "1000" EUR transaction amount
    When Customer makes "REPAYMENT" transaction with "AUTOPAY" payment type on "20231001" with 750 EUR transaction amount and system-generated Idempotency key
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20231001  |                 | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 0    | 20231001  | 20231001 | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0  | 0.0         |
      | 2  | 15   | 20231016  | 20231001 | 500.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 250.0      | 0.0  | 0.0         |
      | 3  | 15   | 20231031  | 20231001 | 250.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 250.0      | 0.0  | 0.0         |
      | 4  | 15   | 20231115 | 20231001 | 0.0             | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 250.0      | 0.0  | 0.0         |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late | Outstanding |
      | 1000.0        | 0        | 0    | 0         | 1000.0 | 1000.0 | 750        | 0    | 0           |
    When Admin sets the business date to "20231016"
    When Admin runs inline COB job for Loan
    Then No new event with type "LoanRepaymentDueEvent" has been raised for the loan
    Then No new event with type "LoanRepaymentOverdueEvent" has been raised for the loan
    When Admin sets the business date to "20231031"
    When Admin runs inline COB job for Loan
    Then No new event with type "LoanRepaymentDueEvent" has been raised for the loan
    Then No new event with type "LoanRepaymentOverdueEvent" has been raised for the loan
    When Admin sets the business date to "20231115"
    When Admin runs inline COB job for Loan
    Then No new event with type "LoanRepaymentDueEvent" has been raised for the loan
    Then No new event with type "LoanRepaymentOverdueEvent" has been raised for the loan

  @TestRailId:C2961
  Scenario: Verify that outstanding amounts are rounded correctly in case of: installmentAmountInMultiplesOf=1, interestType: FLAT, amortizationType: EQUAL_INSTALLMENTS
    When Admin sets the business date to "20230901"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct       | submitted on date | with Principal | ANNUAL interest rate % | interest type | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy                                                             |
      | LP1_INTEREST_FLAT | 20230901 | 1250           | 15                     | FLAT          | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 4                 | MONTHS                | 1              | MONTHS                 | 4                  | 0                       | 0                      | 0                    | DUE_PENALTY_FEE_INTEREST_PRINCIPAL_IN_ADVANCE_PRINCIPAL_PENALTY_FEE_INTEREST |
    And Admin successfully approves the loan on "20230901" with "1250" amount and expected disbursement date on "20230901"
    When Admin successfully disburse the loan on "20230901" with "1250" EUR transaction amount
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20230901 |           | 1250.0          |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 30   | 20231001   |           | 937.62          | 312.38        | 15.62    | 0.0  | 0.0       | 328.0 | 0.0  | 0.0        | 0.0  | 328.0       |
      | 2  | 31   | 20231101  |           | 625.24          | 312.38        | 15.62    | 0.0  | 0.0       | 328.0 | 0.0  | 0.0        | 0.0  | 328.0       |
      | 3  | 30   | 20231201  |           | 312.86          | 312.38        | 15.62    | 0.0  | 0.0       | 328.0 | 0.0  | 0.0        | 0.0  | 328.0       |
      | 4  | 31   | 20240101   |           | 0.0             | 312.86        | 15.64    | 0.0  | 0.0       | 328.5 | 0.0  | 0.0        | 0.0  | 328.5       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid | In advance | Late | Outstanding |
      | 1250.0        | 62.50    | 0.0  | 0.0       | 1312.50 | 0.0  | 0.0        | 0.0  | 1312.50     |

  @TestRailId:C2962
  Scenario: Verify that outstanding amounts are rounded correctly in case of: installmentAmountInMultiplesOf=1, interestType: DECLINING_BALANCE, amortizationType: EQUAL_INSTALLMENTS
    When Admin sets the business date to "20230901"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                           | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy                                                             |
      | LP1_INTEREST_DECLINING_BALANCE_PERIOD_SAME_AS_PAYMENT | 20230901 | 1250           | 15                     | DECLINING_BALANCE | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 4                 | MONTHS                | 1              | MONTHS                 | 4                  | 0                       | 0                      | 0                    | DUE_PENALTY_FEE_INTEREST_PRINCIPAL_IN_ADVANCE_PRINCIPAL_PENALTY_FEE_INTEREST |
    And Admin successfully approves the loan on "20230901" with "1250" amount and expected disbursement date on "20230901"
    When Admin successfully disburse the loan on "20230901" with "1250" EUR transaction amount
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      |    |      | 20230901 |           | 1250.0          |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      | 1  | 30   | 20231001   |           | 943.62          | 306.38        | 15.62    | 0.0  | 0.0       | 322.0  | 0.0  | 0.0        | 0.0  | 322.0       |
      | 2  | 31   | 20231101  |           | 633.42          | 310.2         | 11.8     | 0.0  | 0.0       | 322.0  | 0.0  | 0.0        | 0.0  | 322.0       |
      | 3  | 30   | 20231201  |           | 319.34          | 314.08        | 7.92     | 0.0  | 0.0       | 322.0  | 0.0  | 0.0        | 0.0  | 322.0       |
      | 4  | 31   | 20240101   |           | 0.0             | 319.34        | 3.99     | 0.0  | 0.0       | 323.33 | 0.0  | 0.0        | 0.0  | 323.33      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid | In advance | Late | Outstanding |
      | 1250.0        | 39.33    | 0.0  | 0.0       | 1289.33 | 0.0  | 0.0        | 0.0  | 1289.33     |

  @TestRailId:C3106
  Scenario: Verify that there is not auto downpayment if disburseWithoutAutoDownPayment command is used
    When Admin sets the business date to "20240402"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct          | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy                                                             |
      | LP2_DOWNPAYMENT_AUTO | 20230402     | 1000           | 0                      | DECLINING_BALANCE | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 45                | DAYS                  | 15             | DAYS                   | 3                  | 0                       | 0                      | 0                    | DUE_PENALTY_INTEREST_PRINCIPAL_FEE_IN_ADVANCE_PENALTY_INTEREST_PRINCIPAL_FEE |
    And Admin successfully approves the loan on "20240402" with "1000" amount and expected disbursement date on "20240402"
    And Admin successfully disburse the loan without auto downpayment on "20240402" with "1000" EUR transaction amount
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date          | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20240402 |           | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 0    | 20240402 |           | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0  | 0.0        | 0.0  | 250.0       |
      | 2  | 15   | 20240417 |           | 500.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0  | 0.0        | 0.0  | 250.0       |
      | 3  | 15   | 20240502   |           | 250.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0  | 0.0        | 0.0  | 250.0       |
      | 4  | 15   | 20240517   |           | 0.0             | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0  | 0.0        | 0.0  | 250.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 1000.0        | 0        | 0    | 0         | 1000.0 | 0.0  | 0          | 0    | 1000        |

  @TestRailId:C3129 @AdvancedPaymentAllocation
  Scenario: Verify installment due date logic for monthly installments - last day of the month
    When Admin sets the business date to "20240131"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                      | submitted on date | with Principal | ANNUAL interest rate % | interest type | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_DOWNPAYMENT_AUTO_ADVANCED_PAYMENT_ALLOCATION | 20240131   | 1000           | 0                      | FLAT          | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 4                 | MONTHS                | 1              | MONTHS                 | 4                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    Then Loan Repayment schedule has 5 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20240131  |           | 1000.0          |               |          | 0.0  |           | 0.0   |      |            |      | 0.0         |
      | 1  | 0    | 20240131  |           | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0  | 0.0        | 0.0  | 250.0       |
      | 2  | 29   | 20240229 |           | 562.0           | 188.0         | 0.0      | 0.0  | 0.0       | 188.0 | 0.0  | 0.0        | 0.0  | 188.0       |
      | 3  | 31   | 20240331    |           | 374.0           | 188.0         | 0.0      | 0.0  | 0.0       | 188.0 | 0.0  | 0.0        | 0.0  | 188.0       |
      | 4  | 30   | 20240430    |           | 186.0           | 188.0         | 0.0      | 0.0  | 0.0       | 188.0 | 0.0  | 0.0        | 0.0  | 188.0       |
      | 5  | 31   | 20240531      |           | 0.0             | 186.0         | 0.0      | 0.0  | 0.0       | 186.0 | 0.0  | 0.0        | 0.0  | 186.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 1000.0        | 0.0      | 0.0  | 0.0       | 1000.0 | 0.0  | 0.0        | 0.0  | 1000.0      |
    And Admin successfully approves the loan on "20240131" with "1000" amount and expected disbursement date on "20240131"
    Then Loan Repayment schedule has 5 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20240131  |           | 1000.0          |               |          | 0.0  |           | 0.0   |      |            |      | 0.0         |
      | 1  | 0    | 20240131  |           | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0  | 0.0        | 0.0  | 250.0       |
      | 2  | 29   | 20240229 |           | 562.0           | 188.0         | 0.0      | 0.0  | 0.0       | 188.0 | 0.0  | 0.0        | 0.0  | 188.0       |
      | 3  | 31   | 20240331    |           | 374.0           | 188.0         | 0.0      | 0.0  | 0.0       | 188.0 | 0.0  | 0.0        | 0.0  | 188.0       |
      | 4  | 30   | 20240430    |           | 186.0           | 188.0         | 0.0      | 0.0  | 0.0       | 188.0 | 0.0  | 0.0        | 0.0  | 188.0       |
      | 5  | 31   | 20240531      |           | 0.0             | 186.0         | 0.0      | 0.0  | 0.0       | 186.0 | 0.0  | 0.0        | 0.0  | 186.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 1000.0        | 0.0      | 0.0  | 0.0       | 1000.0 | 0.0  | 0.0        | 0.0  | 1000.0      |
    When Admin successfully disburse the loan on "20240131" with "1000" EUR transaction amount
    Then Loan Repayment schedule has 5 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240131  |                 | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 0    | 20240131  | 20240131 | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0  | 0.0         |
      | 2  | 29   | 20240229 |                 | 562.0           | 188.0         | 0.0      | 0.0  | 0.0       | 188.0 | 0.0   | 0.0        | 0.0  | 188.0       |
      | 3  | 31   | 20240331    |                 | 374.0           | 188.0         | 0.0      | 0.0  | 0.0       | 188.0 | 0.0   | 0.0        | 0.0  | 188.0       |
      | 4  | 30   | 20240430    |                 | 186.0           | 188.0         | 0.0      | 0.0  | 0.0       | 188.0 | 0.0   | 0.0        | 0.0  | 188.0       |
      | 5  | 31   | 20240531      |                 | 0.0             | 186.0         | 0.0      | 0.0  | 0.0       | 186.0 | 0.0   | 0.0        | 0.0  | 186.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 1000.0        | 0.0      | 0.0  | 0.0       | 1000.0 | 250.0 | 0.0        | 0.0  | 750.0       |

  @TestRailId:C3130 @AdvancedPaymentAllocation
  Scenario: Verify installment due date logic for monthly installments - last day of the month, expected and real disbursement dates are different
    When Admin sets the business date to "20240130"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                      | submitted on date | with Principal | ANNUAL interest rate % | interest type | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_DOWNPAYMENT_AUTO_ADVANCED_PAYMENT_ALLOCATION | 20240130   | 1000           | 0                      | FLAT          | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 4                 | MONTHS                | 1              | MONTHS                 | 4                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    Then Loan Repayment schedule has 5 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20240130  |           | 1000.0          |               |          | 0.0  |           | 0.0   |      |            |      | 0.0         |
      | 1  | 0    | 20240130  |           | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0  | 0.0        | 0.0  | 250.0       |
      | 2  | 30   | 20240229 |           | 562.0           | 188.0         | 0.0      | 0.0  | 0.0       | 188.0 | 0.0  | 0.0        | 0.0  | 188.0       |
      | 3  | 30   | 20240330    |           | 374.0           | 188.0         | 0.0      | 0.0  | 0.0       | 188.0 | 0.0  | 0.0        | 0.0  | 188.0       |
      | 4  | 31   | 20240430    |           | 186.0           | 188.0         | 0.0      | 0.0  | 0.0       | 188.0 | 0.0  | 0.0        | 0.0  | 188.0       |
      | 5  | 30   | 20240530      |           | 0.0             | 186.0         | 0.0      | 0.0  | 0.0       | 186.0 | 0.0  | 0.0        | 0.0  | 186.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 1000.0        | 0.0      | 0.0  | 0.0       | 1000.0 | 0.0  | 0.0        | 0.0  | 1000.0      |
    And Admin successfully approves the loan on "20240130" with "1000" amount and expected disbursement date on "20240130"
    Then Loan Repayment schedule has 5 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20240130  |           | 1000.0          |               |          | 0.0  |           | 0.0   |      |            |      | 0.0         |
      | 1  | 0    | 20240130  |           | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0  | 0.0        | 0.0  | 250.0       |
      | 2  | 30   | 20240229 |           | 562.0           | 188.0         | 0.0      | 0.0  | 0.0       | 188.0 | 0.0  | 0.0        | 0.0  | 188.0       |
      | 3  | 30   | 20240330    |           | 374.0           | 188.0         | 0.0      | 0.0  | 0.0       | 188.0 | 0.0  | 0.0        | 0.0  | 188.0       |
      | 4  | 31   | 20240430    |           | 186.0           | 188.0         | 0.0      | 0.0  | 0.0       | 188.0 | 0.0  | 0.0        | 0.0  | 188.0       |
      | 5  | 30   | 20240530      |           | 0.0             | 186.0         | 0.0      | 0.0  | 0.0       | 186.0 | 0.0  | 0.0        | 0.0  | 186.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 1000.0        | 0.0      | 0.0  | 0.0       | 1000.0 | 0.0  | 0.0        | 0.0  | 1000.0      |
    When Admin sets the business date to "20240131"
    When Admin successfully disburse the loan on "20240131" with "1000" EUR transaction amount
    Then Loan Repayment schedule has 5 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240131  |                 | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 0    | 20240131  | 20240131 | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0  | 0.0         |
      | 2  | 29   | 20240229 |                 | 562.0           | 188.0         | 0.0      | 0.0  | 0.0       | 188.0 | 0.0   | 0.0        | 0.0  | 188.0       |
      | 3  | 31   | 20240331    |                 | 374.0           | 188.0         | 0.0      | 0.0  | 0.0       | 188.0 | 0.0   | 0.0        | 0.0  | 188.0       |
      | 4  | 30   | 20240430    |                 | 186.0           | 188.0         | 0.0      | 0.0  | 0.0       | 188.0 | 0.0   | 0.0        | 0.0  | 188.0       |
      | 5  | 31   | 20240531      |                 | 0.0             | 186.0         | 0.0      | 0.0  | 0.0       | 186.0 | 0.0   | 0.0        | 0.0  | 186.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 1000.0        | 0.0      | 0.0  | 0.0       | 1000.0 | 250.0 | 0.0        | 0.0  | 750.0       |

  @TestRailId:C3131 @AdvancedPaymentAllocation
  Scenario: Verify installment due date logic for monthly installments - last day of the month, repayment start calculated from Submitted on date - submit, approve, disburse on same date
    When Admin sets the business date to "20240131"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                | submitted on date | with Principal | ANNUAL interest rate % | interest type | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_DOWNPAYMENT_AUTO_ADVANCED_PAYMENT_ALLOCATION_REPAYMENT_START_SUBMITTED | 20240131   | 1000           | 0                      | FLAT          | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 4                 | MONTHS                | 1              | MONTHS                 | 4                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    Then Loan Repayment schedule has 5 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20240131  |           | 1000.0          |               |          | 0.0  |           | 0.0   |      |            |      | 0.0         |
      | 1  | 0    | 20240131  |           | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0  | 0.0        | 0.0  | 250.0       |
      | 2  | 29   | 20240229 |           | 562.0           | 188.0         | 0.0      | 0.0  | 0.0       | 188.0 | 0.0  | 0.0        | 0.0  | 188.0       |
      | 3  | 31   | 20240331    |           | 374.0           | 188.0         | 0.0      | 0.0  | 0.0       | 188.0 | 0.0  | 0.0        | 0.0  | 188.0       |
      | 4  | 30   | 20240430    |           | 186.0           | 188.0         | 0.0      | 0.0  | 0.0       | 188.0 | 0.0  | 0.0        | 0.0  | 188.0       |
      | 5  | 31   | 20240531      |           | 0.0             | 186.0         | 0.0      | 0.0  | 0.0       | 186.0 | 0.0  | 0.0        | 0.0  | 186.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 1000.0        | 0.0      | 0.0  | 0.0       | 1000.0 | 0.0  | 0.0        | 0.0  | 1000.0      |
    And Admin successfully approves the loan on "20240131" with "1000" amount and expected disbursement date on "20240131"
    Then Loan Repayment schedule has 5 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20240131  |           | 1000.0          |               |          | 0.0  |           | 0.0   |      |            |      | 0.0         |
      | 1  | 0    | 20240131  |           | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0  | 0.0        | 0.0  | 250.0       |
      | 2  | 29   | 20240229 |           | 562.0           | 188.0         | 0.0      | 0.0  | 0.0       | 188.0 | 0.0  | 0.0        | 0.0  | 188.0       |
      | 3  | 31   | 20240331    |           | 374.0           | 188.0         | 0.0      | 0.0  | 0.0       | 188.0 | 0.0  | 0.0        | 0.0  | 188.0       |
      | 4  | 30   | 20240430    |           | 186.0           | 188.0         | 0.0      | 0.0  | 0.0       | 188.0 | 0.0  | 0.0        | 0.0  | 188.0       |
      | 5  | 31   | 20240531      |           | 0.0             | 186.0         | 0.0      | 0.0  | 0.0       | 186.0 | 0.0  | 0.0        | 0.0  | 186.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 1000.0        | 0.0      | 0.0  | 0.0       | 1000.0 | 0.0  | 0.0        | 0.0  | 1000.0      |
    When Admin successfully disburse the loan on "20240131" with "1000" EUR transaction amount
    Then Loan Repayment schedule has 5 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240131  |                 | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 0    | 20240131  | 20240131 | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0  | 0.0         |
      | 2  | 29   | 20240229 |                 | 562.0           | 188.0         | 0.0      | 0.0  | 0.0       | 188.0 | 0.0   | 0.0        | 0.0  | 188.0       |
      | 3  | 31   | 20240331    |                 | 374.0           | 188.0         | 0.0      | 0.0  | 0.0       | 188.0 | 0.0   | 0.0        | 0.0  | 188.0       |
      | 4  | 30   | 20240430    |                 | 186.0           | 188.0         | 0.0      | 0.0  | 0.0       | 188.0 | 0.0   | 0.0        | 0.0  | 188.0       |
      | 5  | 31   | 20240531      |                 | 0.0             | 186.0         | 0.0      | 0.0  | 0.0       | 186.0 | 0.0   | 0.0        | 0.0  | 186.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 1000.0        | 0.0      | 0.0  | 0.0       | 1000.0 | 250.0 | 0.0        | 0.0  | 750.0       |

  @TestRailId:C3132 @AdvancedPaymentAllocation
  Scenario: Verify installment due date logic for monthly installments - last day of the month, repayment start calculated from Submitted on date - submit and approve on same date, disburse on next day
    When Admin sets the business date to "20240131"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                | submitted on date | with Principal | ANNUAL interest rate % | interest type | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_DOWNPAYMENT_AUTO_ADVANCED_PAYMENT_ALLOCATION_REPAYMENT_START_SUBMITTED | 20240131   | 1000           | 0                      | FLAT          | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 4                 | MONTHS                | 1              | MONTHS                 | 4                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    Then Loan Repayment schedule has 5 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20240131  |           | 1000.0          |               |          | 0.0  |           | 0.0   |      |            |      | 0.0         |
      | 1  | 0    | 20240131  |           | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0  | 0.0        | 0.0  | 250.0       |
      | 2  | 29   | 20240229 |           | 562.0           | 188.0         | 0.0      | 0.0  | 0.0       | 188.0 | 0.0  | 0.0        | 0.0  | 188.0       |
      | 3  | 31   | 20240331    |           | 374.0           | 188.0         | 0.0      | 0.0  | 0.0       | 188.0 | 0.0  | 0.0        | 0.0  | 188.0       |
      | 4  | 30   | 20240430    |           | 186.0           | 188.0         | 0.0      | 0.0  | 0.0       | 188.0 | 0.0  | 0.0        | 0.0  | 188.0       |
      | 5  | 31   | 20240531      |           | 0.0             | 186.0         | 0.0      | 0.0  | 0.0       | 186.0 | 0.0  | 0.0        | 0.0  | 186.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 1000.0        | 0.0      | 0.0  | 0.0       | 1000.0 | 0.0  | 0.0        | 0.0  | 1000.0      |
    And Admin successfully approves the loan on "20240131" with "1000" amount and expected disbursement date on "20240131"
    Then Loan Repayment schedule has 5 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20240131  |           | 1000.0          |               |          | 0.0  |           | 0.0   |      |            |      | 0.0         |
      | 1  | 0    | 20240131  |           | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0  | 0.0        | 0.0  | 250.0       |
      | 2  | 29   | 20240229 |           | 562.0           | 188.0         | 0.0      | 0.0  | 0.0       | 188.0 | 0.0  | 0.0        | 0.0  | 188.0       |
      | 3  | 31   | 20240331    |           | 374.0           | 188.0         | 0.0      | 0.0  | 0.0       | 188.0 | 0.0  | 0.0        | 0.0  | 188.0       |
      | 4  | 30   | 20240430    |           | 186.0           | 188.0         | 0.0      | 0.0  | 0.0       | 188.0 | 0.0  | 0.0        | 0.0  | 188.0       |
      | 5  | 31   | 20240531      |           | 0.0             | 186.0         | 0.0      | 0.0  | 0.0       | 186.0 | 0.0  | 0.0        | 0.0  | 186.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 1000.0        | 0.0      | 0.0  | 0.0       | 1000.0 | 0.0  | 0.0        | 0.0  | 1000.0      |
    When Admin sets the business date to "20240201"
    When Admin successfully disburse the loan on "20240201" with "1000" EUR transaction amount
    Then Loan Repayment schedule has 5 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240201 |                  | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 0    | 20240201 | 20240201 | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0  | 0.0         |
      | 2  | 29   | 20240229 |                  | 562.0           | 188.0         | 0.0      | 0.0  | 0.0       | 188.0 | 0.0   | 0.0        | 0.0  | 188.0       |
      | 3  | 31   | 20240331    |                  | 374.0           | 188.0         | 0.0      | 0.0  | 0.0       | 188.0 | 0.0   | 0.0        | 0.0  | 188.0       |
      | 4  | 30   | 20240430    |                  | 186.0           | 188.0         | 0.0      | 0.0  | 0.0       | 188.0 | 0.0   | 0.0        | 0.0  | 188.0       |
      | 5  | 31   | 20240531      |                  | 0.0             | 186.0         | 0.0      | 0.0  | 0.0       | 186.0 | 0.0   | 0.0        | 0.0  | 186.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 1000.0        | 0.0      | 0.0  | 0.0       | 1000.0 | 250.0 | 0.0        | 0.0  | 750.0       |

  @TestRailId:C3133 @AdvancedPaymentAllocation
  Scenario: Verify installment due date logic for monthly installments - last day of the month, repayment start calculated from Submitted on date - submit and approve on same date, expected disbursement date on next day
    When Admin sets the business date to "20240131"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                | submitted on date | with Principal | ANNUAL interest rate % | interest type | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_DOWNPAYMENT_AUTO_ADVANCED_PAYMENT_ALLOCATION_REPAYMENT_START_SUBMITTED | 20240131   | 1000           | 0                      | FLAT          | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 4                 | MONTHS                | 1              | MONTHS                 | 4                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    Then Loan Repayment schedule has 5 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20240131  |           | 1000.0          |               |          | 0.0  |           | 0.0   |      |            |      | 0.0         |
      | 1  | 0    | 20240131  |           | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0  | 0.0        | 0.0  | 250.0       |
      | 2  | 29   | 20240229 |           | 562.0           | 188.0         | 0.0      | 0.0  | 0.0       | 188.0 | 0.0  | 0.0        | 0.0  | 188.0       |
      | 3  | 31   | 20240331    |           | 374.0           | 188.0         | 0.0      | 0.0  | 0.0       | 188.0 | 0.0  | 0.0        | 0.0  | 188.0       |
      | 4  | 30   | 20240430    |           | 186.0           | 188.0         | 0.0      | 0.0  | 0.0       | 188.0 | 0.0  | 0.0        | 0.0  | 188.0       |
      | 5  | 31   | 20240531      |           | 0.0             | 186.0         | 0.0      | 0.0  | 0.0       | 186.0 | 0.0  | 0.0        | 0.0  | 186.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 1000.0        | 0.0      | 0.0  | 0.0       | 1000.0 | 0.0  | 0.0        | 0.0  | 1000.0      |
    And Admin successfully approves the loan on "20240131" with "1000" amount and expected disbursement date on "20240201"
    Then Loan Repayment schedule has 5 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20240201 |           | 1000.0          |               |          | 0.0  |           | 0.0   |      |            |      | 0.0         |
      | 1  | 0    | 20240201 |           | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0  | 0.0        | 0.0  | 250.0       |
      | 2  | 29   | 20240229 |           | 562.0           | 188.0         | 0.0      | 0.0  | 0.0       | 188.0 | 0.0  | 0.0        | 0.0  | 188.0       |
      | 3  | 31   | 20240331    |           | 374.0           | 188.0         | 0.0      | 0.0  | 0.0       | 188.0 | 0.0  | 0.0        | 0.0  | 188.0       |
      | 4  | 30   | 20240430    |           | 186.0           | 188.0         | 0.0      | 0.0  | 0.0       | 188.0 | 0.0  | 0.0        | 0.0  | 188.0       |
      | 5  | 31   | 20240531      |           | 0.0             | 186.0         | 0.0      | 0.0  | 0.0       | 186.0 | 0.0  | 0.0        | 0.0  | 186.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 1000.0        | 0.0      | 0.0  | 0.0       | 1000.0 | 0.0  | 0.0        | 0.0  | 1000.0      |
    When Admin sets the business date to "20240201"
    When Admin successfully disburse the loan on "20240201" with "1000" EUR transaction amount
    Then Loan Repayment schedule has 5 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240201 |                  | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 0    | 20240201 | 20240201 | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0  | 0.0         |
      | 2  | 29   | 20240229 |                  | 562.0           | 188.0         | 0.0      | 0.0  | 0.0       | 188.0 | 0.0   | 0.0        | 0.0  | 188.0       |
      | 3  | 31   | 20240331    |                  | 374.0           | 188.0         | 0.0      | 0.0  | 0.0       | 188.0 | 0.0   | 0.0        | 0.0  | 188.0       |
      | 4  | 30   | 20240430    |                  | 186.0           | 188.0         | 0.0      | 0.0  | 0.0       | 188.0 | 0.0   | 0.0        | 0.0  | 188.0       |
      | 5  | 31   | 20240531      |                  | 0.0             | 186.0         | 0.0      | 0.0  | 0.0       | 186.0 | 0.0   | 0.0        | 0.0  | 186.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 1000.0        | 0.0      | 0.0  | 0.0       | 1000.0 | 250.0 | 0.0        | 0.0  | 750.0       |

  @TestRailId:C3223 @AdvancedPaymentAllocation @ProgressiveLoanSchedule
  Scenario: Verify AdvancedPaymentAllocation behaviour: loanScheduleProcessingType-horizontal, charge after maturity, in advanced repayment (future installment type: NEXT_INSTALLMENT)
    When Global config "charge-accrual-date" value set to "submitted-date"
    When Admin sets the business date to "20230901"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                        | submitted on date | with Principal | ANNUAL interest rate % | interest type | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_DOWNPAYMENT_ADV_PMT_ALLOC_PROGRESSIVE_LOAN_SCHEDULE_HORIZONTAL | 20230901 | 1000           | 0                      | FLAT          | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 45                | DAYS                  | 15             | DAYS                   | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20230901" with "1000" amount and expected disbursement date on "20230901"
    When Admin successfully disburse the loan on "20230901" with "1000" EUR transaction amount
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20230901 |           | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 0    | 20230901 |           | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0  | 0.0        | 0.0  | 250.0       |
      | 2  | 15   | 20230916 |           | 500.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0  | 0.0        | 0.0  | 250.0       |
      | 3  | 15   | 20231001   |           | 250.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0  | 0.0        | 0.0  | 250.0       |
      | 4  | 15   | 20231016   |           | 0.0             | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0  | 0.0        | 0.0  | 250.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 1000.0        | 0.0      | 0.0  | 0.0       | 1000.0 | 0.0  | 0.0        | 0.0  | 1000.0      |
    Then Loan Transactions tab has the following data:
      | Transaction date  | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20230901 | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
#    Add charge after maturity
    When Admin adds "LOAN_NSF_FEE" due date charge with "20231017" due date and 20 EUR transaction amount
    Then Loan Repayment schedule has 5 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20230901 |           | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 0    | 20230901 |           | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0  | 0.0        | 0.0  | 250.0       |
      | 2  | 15   | 20230916 |           | 500.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0  | 0.0        | 0.0  | 250.0       |
      | 3  | 15   | 20231001   |           | 250.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0  | 0.0        | 0.0  | 250.0       |
      | 4  | 15   | 20231016   |           | 0.0             | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0  | 0.0        | 0.0  | 250.0       |
      | 5  | 1    | 20231017   |           | 0.0             | 0.0           | 0.0      | 0.0  | 20.0      | 20.0  | 0.0  | 0.0        | 0.0  | 20.0        |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 1000.0        | 0.0      | 0.0  | 20.0      | 1020.0 | 0.0  | 0.0        | 0.0  | 1020.0      |
    Then Loan Transactions tab has the following data:
      | Transaction date  | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20230901 | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
    Then Loan Charges tab has the following data:
      | Name    | isPenalty | Payment due at     | Due as of       | Calculation type | Due  | Paid | Waived | Outstanding |
      | NSF fee | true      | Specified due date | 20231017 | Flat             | 20.0 | 0.0  | 0.0    | 20.0        |
#    Make due date repayments
    And Customer makes "AUTOPAY" repayment on "20230901" with 250 EUR transaction amount
    When Admin sets the business date to "20230902"
    When Admin runs inline COB job for Loan
    When Admin sets the business date to "20230902"
    And Customer makes "AUTOPAY" repayment on "20230902" with 250 EUR transaction amount
    Then Loan Repayment schedule has 5 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date         | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20230901 |                   | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 0    | 20230901 | 20230901 | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0  | 0.0         |
      | 2  | 15   | 20230916 | 20230902 | 500.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 250.0      | 0.0  | 0.0         |
      | 3  | 15   | 20231001   |                   | 250.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0   | 0.0        | 0.0  | 250.0       |
      | 4  | 15   | 20231016   |                   | 0.0             | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0   | 0.0        | 0.0  | 250.0       |
      | 5  | 1    | 20231017   |                   | 0.0             | 0.0           | 0.0      | 0.0  | 20.0      | 20.0  | 0.0   | 0.0        | 0.0  | 20.0        |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 1000.0        | 0.0      | 0.0  | 20.0      | 1020.0 | 500.0 | 250.0      | 0.0  | 520.0       |
    Then Loan Transactions tab has the following data:
      | Transaction date  | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20230901 | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
      | 20230901 | Repayment        | 250.0  | 250.0     | 0.0      | 0.0  | 0.0       | 750.0        |
      | 20230901 | Accrual          | 20.0   | 0.0       | 0.0      | 0.0  | 20.0      | 0.0          |
      | 20230902 | Repayment        | 250.0  | 250.0     | 0.0      | 0.0  | 0.0       | 500.0        |
    Then Loan Charges tab has the following data:
      | Name    | isPenalty | Payment due at     | Due as of       | Calculation type | Due  | Paid | Waived | Outstanding |
      | NSF fee | true      | Specified due date | 20231017 | Flat             | 20.0 | 0.0  | 0.0    | 20.0        |
    When Admin sets the business date to "20230903"
    When Admin runs inline COB job for Loan
    #Make backdated repayment to trigger loan transaction reprocessing
    And Customer makes "AUTOPAY" repayment on "20230901" with 250 EUR transaction amount
    When Admin sets the business date to "20230904"
    #Run COB to check there is no accounting meltdown and accrual is handled properly
    When Admin runs inline COB job for Loan
    When Global config "charge-accrual-date" value set to "due-date"

  @TestRailId:C3224
  Scenario: Verify that interest recalculation works properly when triggered by COB
    When Admin sets the business date to "20240401"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                                   | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy                        |
      | LP1_INTEREST_DECLINING_BALANCE_SAR_RECALCULATION_SAME_AS_REPAYMENT_COMPOUNDING_NONE_MULTIDISB | 20240401     | 1000           | 12                     | DECLINING_BALANCE | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 45                | DAYS                  | 15             | DAYS                   | 3                  | 0                       | 0                      | 0                    | PENALTIES_FEES_INTEREST_PRINCIPAL_ORDER |
    And Admin successfully approves the loan on "20240401" with "1000" amount and expected disbursement date on "20240405"
    When Admin sets the business date to "20240405"
    When Admin successfully disburse the loan on "20240405" with "500" EUR transaction amount
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date          | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      |    |      | 20240405 |           | 500.0           |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      | 1  | 15   | 20240420 |           | 334.47          | 165.53        | 2.47     | 0.0  | 0.0       | 168.0  | 0.0  | 0.0        | 0.0  | 168.0       |
      | 2  | 15   | 20240505   |           | 168.12          | 166.35        | 1.65     | 0.0  | 0.0       | 168.0  | 0.0  | 0.0        | 0.0  | 168.0       |
      | 3  | 15   | 20240520   |           | 0.0             | 168.12        | 0.83     | 0.0  | 0.0       | 168.95 | 0.0  | 0.0        | 0.0  | 168.95      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20240405    | Disbursement     | 500.0  | 0.0       | 0.0      | 0.0  | 0.0       | 500.0        |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 500.0         | 4.95     | 0.0  | 0.0       | 504.95 | 0.0  | 0.0        | 0.0  | 504.95      |
    When Admin sets the business date to "20240421"
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date          | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      |    |      | 20240405 |           | 500.0           |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      | 1  | 15   | 20240420 |           | 334.47          | 165.53        | 2.47     | 0.0  | 0.0       | 168.0  | 0.0  | 0.0        | 0.0  | 168.0       |
      | 2  | 15   | 20240505   |           | 168.12          | 166.35        | 1.65     | 0.0  | 0.0       | 168.0  | 0.0  | 0.0        | 0.0  | 168.0       |
      | 3  | 15   | 20240520   |           | 0.0             | 168.12        | 0.83     | 0.0  | 0.0       | 168.95 | 0.0  | 0.0        | 0.0  | 168.95      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20240405    | Disbursement     | 500.0  | 0.0       | 0.0      | 0.0  | 0.0       | 500.0        |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 500.0         | 4.95     | 0.0  | 0.0       | 504.95 | 0.0  | 0.0        | 0.0  | 504.95      |
    When Admin runs inline COB job for Loan
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date          | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      |    |      | 20240405 |           | 500.0           |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      | 1  | 15   | 20240420 |           | 334.47          | 165.53        | 2.47     | 0.0  | 0.0       | 168.0  | 0.0  | 0.0        | 0.0  | 168.0       |
      | 2  | 15   | 20240505   |           | 168.94          | 165.53        | 2.47     | 0.0  | 0.0       | 168.0  | 0.0  | 0.0        | 0.0  | 168.0       |
      | 3  | 15   | 20240520   |           | 0.0             | 168.94        | 0.83     | 0.0  | 0.0       | 169.77 | 0.0  | 0.0        | 0.0  | 169.77      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 500.0         | 5.77     | 0.0  | 0.0       | 505.77 | 0.0  | 0.0        | 0.0  | 505.77      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20240405    | Disbursement     | 500.0  | 0.0       | 0.0      | 0.0  | 0.0       | 500.0        |
      | 20240420    | Accrual          | 2.47   | 0.0       | 2.47     | 0.0  | 0.0       | 0.0          |

  @TestRailId:C3225
  Scenario: Verify that payment allocation is correct in case of fee charged on an OVERPAID Loan and payment is backdated
#    --- 7/23 - Loan Created & Approved ---
    When Admin sets the business date to "20240723"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                            | submitted on date | with Principal | ANNUAL interest rate % | interest type | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP1_ADV_PMT_ALLOC_PROGRESSIVE_LOAN_SCHEDULE_HORIZONTAL | 20240723      | 150            | 0                      | FLAT          | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 1                 | MONTHS                | 1              | MONTHS                 | 1                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
#   --- 7/23 - Disbursement for 111.92 EUR ---
    And Admin successfully approves the loan on "20240723" with "111.92" amount and expected disbursement date on "20240723"
    When Admin successfully disburse the loan on "20240723" with "111.92" EUR transaction amount
#    --- 8/8 - Partial merchant issued refund - 76.48 Eur ---
    When Admin sets the business date to "20240808"
    When Customer makes "MERCHANT_ISSUED_REFUND" transaction with "AUTOPAY" payment type on "20240808" with 76.48 EUR transaction amount and system-generated Idempotency key
#    --- 8/13 - Manual Repayment - 35.44 Eur (Account closed) ---
    When Admin sets the business date to "20240813"
    And Customer makes "MONEY_TRANSFER" repayment on "20240813" with 35.44 EUR transaction amount
    Then Loan status will be "CLOSED_OBLIGATIONS_MET"
    Then Loan has 0 outstanding amount
#    --- 8/15 - Repayment reversed (Account reopened) ---
    When Admin sets the business date to "20240815"
    When Customer undo "1"th "Repayment" transaction made on "20240813"
    Then Loan status will be "ACTIVE"
    Then Loan has 35.44 outstanding amount
#    --- 8/22 - Autopay posted for 35.44 Eur ---
    When Admin sets the business date to "20240822"
    And Customer makes "AUTOPAY" repayment on "20240822" with 35.44 EUR transaction amount
    Then Loan status will be "CLOSED_OBLIGATIONS_MET"
    Then Loan has 0 outstanding amount
#    --- 8/24 - Autopay reversed ---
    When Admin sets the business date to "20240824"
    When Customer undo "1"th "Repayment" transaction made on "20240822"
    Then Loan status will be "ACTIVE"
    Then Loan has 35.44 outstanding amount
#    --- 8/24 - Loan Charge created for 2.80 Eur ---
    When Admin adds "LOAN_NSF_FEE" due date charge with "20240824" due date and 2.80 EUR transaction amount
    Then Loan status will be "ACTIVE"
    Then Loan has 38.24 outstanding amount
#    --- 8/24 (after COB) - Accrual created ---
    When Admin sets the business date to "20240825"
    When Admin runs inline COB job for Loan
    Then Loan Repayment schedule has 2 periods, with the following data for periods:
      | Nr | Days | Date           | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      |    |      | 20240723   |           | 111.92          |               |          | 0.0  |           | 0.0    | 0.0   |            |      |             |
      | 1  | 31   | 20240823 |           | 0.0             | 111.92        | 0.0      | 0.0  | 0.0       | 111.92 | 76.48 | 76.48      | 0.0  | 35.44       |
      | 2  | 1    | 20240824 |           | 0.0             | 0.0           | 0.0      | 0.0  | 2.8       | 2.8    | 0.0   | 0.0        | 0.0  | 2.8         |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 111.92        | 0.0      | 0.0  | 2.8       | 114.72 | 76.48 | 76.48      | 0.0  | 38.24       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type       | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240723     | Disbursement           | 111.92 | 0.0       | 0.0      | 0.0  | 0.0       | 111.92       | false    | false    |
      | 20240808   | Merchant Issued Refund | 76.48  | 76.48     | 0.0      | 0.0  | 0.0       | 35.44        | false    | false    |
      | 20240813   | Repayment              | 35.44  | 35.44     | 0.0      | 0.0  | 0.0       | 0.0          | true     | false    |
      | 20240822   | Repayment              | 35.44  | 35.44     | 0.0      | 0.0  | 0.0       | 0.0          | true     | false    |
      | 20240824   | Accrual                | 2.8    | 0.0       | 0.0      | 0.0  | 2.8       | 0.0          | false    | false    |
#    --- 8/28 - Backdated Autopay posted for 38.24 Eur (35.44 principal + 2.80 penalty) with transactionDate 8/22 ---
    When Admin sets the business date to "20240828"
    And Customer makes "AUTOPAY" repayment on "20240822" with 38.24 EUR transaction amount
    Then Loan status will be "CLOSED_OBLIGATIONS_MET"
    Then Loan has 0 outstanding amount
    Then Loan Repayment schedule has 2 periods, with the following data for periods:
      | Nr | Days | Date           | Paid date      | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late | Outstanding |
      |    |      | 20240723   |                | 111.92          |               |          | 0.0  |           | 0.0    | 0.0    |            |      |             |
      | 1  | 31   | 20240823 | 20240822 | 0.0             | 111.92        | 0.0      | 0.0  | 0.0       | 111.92 | 111.92 | 111.92     | 0.0  | 0.0         |
      | 2  | 1    | 20240824 | 20240822 | 0.0             | 0.0           | 0.0      | 0.0  | 2.8       | 2.8    | 2.8    | 2.8        | 0.0  | 0.0         |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late | Outstanding |
      | 111.92        | 0.0      | 0.0  | 2.8       | 114.72 | 114.72 | 114.72     | 0.0  | 0.0         |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type       | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240723     | Disbursement           | 111.92 | 0.0       | 0.0      | 0.0  | 0.0       | 111.92       | false    | false    |
      | 20240808   | Merchant Issued Refund | 76.48  | 76.48     | 0.0      | 0.0  | 0.0       | 35.44        | false    | false    |
      | 20240813   | Repayment              | 35.44  | 35.44     | 0.0      | 0.0  | 0.0       | 0.0          | true     | false    |
      | 20240822   | Repayment              | 35.44  | 35.44     | 0.0      | 0.0  | 0.0       | 0.0          | true     | false    |
      | 20240822   | Repayment              | 38.24  | 35.44     | 0.0      | 0.0  | 2.8       | 0.0          | false    | false    |
      | 20240824   | Accrual                | 2.8    | 0.0       | 0.0      | 0.0  | 2.8       | 0.0          | false    | false    |
    When Customer makes "AUTOPAY" repayment on "20240823" with 10 EUR transaction amount
    Then Loan status will be "OVERPAID"
    Then Loan has 0 outstanding amount
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type       | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20240723     | Disbursement           | 111.92 | 0.0       | 0.0      | 0.0  | 0.0       | 111.92       | false    |
      | 20240808   | Merchant Issued Refund | 76.48  | 76.48     | 0.0      | 0.0  | 0.0       | 35.44        | false    |
      | 20240813   | Repayment              | 35.44  | 35.44     | 0.0      | 0.0  | 0.0       | 0.0          | true     |
      | 20240822   | Repayment              | 35.44  | 35.44     | 0.0      | 0.0  | 0.0       | 0.0          | true     |
      | 20240822   | Repayment              | 38.24  | 35.44     | 0.0      | 0.0  | 2.8       | 0.0          | false    |
      | 20240823   | Repayment              | 10.0   | 0.0       | 0.0      | 0.0  | 0.0       | 0.0          | false    |
      | 20240824   | Accrual                | 2.8    | 0.0       | 0.0      | 0.0  | 2.8       | 0.0          | false    |
    Then Loan Repayment schedule has 2 periods, with the following data for periods:
      | Nr | Days | Date           | Paid date      | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late | Outstanding |
      |    |      | 20240723   |                | 111.92          |               |          | 0.0  |           | 0.0    | 0.0    |            |      |             |
      | 1  | 31   | 20240823 | 20240822 | 0.0             | 111.92        | 0.0      | 0.0  | 0.0       | 111.92 | 111.92 | 111.92     | 0.0  | 0.0         |
      | 2  | 1    | 20240824 | 20240822 | 0.0             | 0.0           | 0.0      | 0.0  | 2.8       | 2.8    | 2.8    | 2.8        | 0.0  | 0.0         |
    When Admin sets the business date to "20240829"
    When Admin runs inline COB job for Loan
    When Admin adds "LOAN_NSF_FEE" due date charge with "20240822" due date and 5 EUR transaction amount
    Then Loan status will be "OVERPAID"
    Then Loan has 0 outstanding amount
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type       | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20240723     | Disbursement           | 111.92 | 0.0       | 0.0      | 0.0  | 0.0       | 111.92       | false    |
      | 20240808   | Merchant Issued Refund | 76.48  | 76.48     | 0.0      | 0.0  | 0.0       | 35.44        | false    |
      | 20240813   | Repayment              | 35.44  | 35.44     | 0.0      | 0.0  | 0.0       | 0.0          | true     |
      | 20240822   | Repayment              | 35.44  | 35.44     | 0.0      | 0.0  | 0.0       | 0.0          | true     |
      | 20240822   | Repayment              | 38.24  | 35.44     | 0.0      | 0.0  | 2.8       | 0.0          | false    |
      | 20240823   | Repayment              | 10.0   | 0.0       | 0.0      | 0.0  | 5.0       | 0.0          | false    |
      | 20240824   | Accrual                | 2.8    | 0.0       | 0.0      | 0.0  | 2.8       | 0.0          | false    |
      | 20240824   | Accrual                | 5.0    | 0.0       | 0.0      | 0.0  | 5.0       | 0.0          | false    |
    Then Loan Repayment schedule has 2 periods, with the following data for periods:
      | Nr | Days | Date           | Paid date      | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late | Outstanding |
      |    |      | 20240723   |                | 111.92          |               |          | 0.0  |           | 0.0    | 0.0    |            |      |             |
      | 1  | 31   | 20240823 | 20240823 | 0.0             | 111.92        | 0.0      | 0.0  | 5.0       | 116.92 | 116.92 | 114.72     | 0.0  | 0.0         |
      | 2  | 1    | 20240824 | 20240823 | 0.0             | 0.0           | 0.0      | 0.0  | 2.8       | 2.8    | 2.8    | 2.8        | 0.0  | 0.0         |
    When Admin adds "LOAN_NSF_FEE" due date charge with "20240825" due date and 5 EUR transaction amount
    When Admin sets the business date to "20240830"
    When Admin runs inline COB job for Loan
    Then Loan status will be "CLOSED_OBLIGATIONS_MET"
    Then Loan has 0 outstanding amount
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type       | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20240723     | Disbursement           | 111.92 | 0.0       | 0.0      | 0.0  | 0.0       | 111.92       | false    |
      | 20240808   | Merchant Issued Refund | 76.48  | 76.48     | 0.0      | 0.0  | 0.0       | 35.44        | false    |
      | 20240813   | Repayment              | 35.44  | 35.44     | 0.0      | 0.0  | 0.0       | 0.0          | true     |
      | 20240822   | Repayment              | 35.44  | 35.44     | 0.0      | 0.0  | 0.0       | 0.0          | true     |
      | 20240822   | Repayment              | 38.24  | 35.44     | 0.0      | 0.0  | 2.8       | 0.0          | false    |
      | 20240823   | Repayment              | 10.0   | 0.0       | 0.0      | 0.0  | 10.0      | 0.0          | false    |
      | 20240824   | Accrual                | 2.8    | 0.0       | 0.0      | 0.0  | 2.8       | 0.0          | false    |
      | 20240824   | Accrual                | 5.0    | 0.0       | 0.0      | 0.0  | 5.0       | 0.0          | false    |
      | 20240825   | Accrual                | 5.0    | 0.0       | 0.0      | 0.0  | 5.0       | 0.0          | false    |
    Then Loan Repayment schedule has 2 periods, with the following data for periods:
      | Nr | Days | Date           | Paid date      | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late | Outstanding |
      |    |      | 20240723   |                | 111.92          |               |          | 0.0  |           | 0.0    | 0.0    |            |      |             |
      | 1  | 31   | 20240823 | 20240823 | 0.0             | 111.92        | 0.0      | 0.0  | 5.0       | 116.92 | 116.92 | 114.72     | 0.0  | 0.0         |
      | 2  | 2    | 20240825 | 20240823 | 0.0             | 0.0           | 0.0      | 0.0  | 7.8       | 7.8    | 7.8    | 7.8        | 0.0  | 0.0         |

  @TestRailId:C3247
  Scenario: Verify that repayment reversal is created as the result of backdated repayment transaction for interest bearing product
    When Admin sets the business date to "20240623"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                        | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_EMI_360_30_INTEREST_RECALCULATION_DAILY_TILL_PRECLOSE | 20240623       | 400            | 0                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 30                | DAYS                  | 30             | DAYS                   | 1                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240623" with "400" amount and expected disbursement date on "20240623"
    And Admin successfully disburse the loan on "20240623" with "400" EUR transaction amount
    When Admin sets the business date to "20240910"
    And Customer makes "MERCHANT_ISSUED_REFUND" transaction with "AUTOPAY" payment type on "20240910" with 200 EUR transaction amount and self-generated Idempotency key
    Then Loan Repayment schedule has 1 periods, with the following data for periods:
      | Nr | Days | Date         | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late  | Outstanding |
      |    |      | 20240623 |           | 400.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |       |             |
      | 1  | 30   | 20240723 |           | 0.0             | 400.0         | 0.0      | 0.0  | 0.0       | 400.0 | 200.0 | 0.0        | 200.0 | 200.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late  | Outstanding |
      | 400.0         | 0.0      | 0.0  | 0.0       | 400.0 | 200.0 | 0.0        | 200.0 | 200.0       |
    Then Loan Transactions tab has the following data:
      | Transaction date  | Transaction Type       | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20240623      | Disbursement           | 400.0  | 0.0       | 0.0      | 0.0  | 0.0       | 400.0        |
      | 20240910 | Merchant Issued Refund | 200.0  | 200.0     | 0.0      | 0.0  | 0.0       | 200.0        |
    When Customer makes "AUTOPAY" repayment on "20240624" with 100 EUR transaction amount
    Then Loan Repayment schedule has 1 periods, with the following data for periods:
      | Nr | Days | Date         | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late  | Outstanding |
      |    |      | 20240623 |           | 400.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |       |             |
      | 1  | 30   | 20240723 |           | 0.0             | 400.0         | 0.0      | 0.0  | 0.0       | 400.0 | 300.0 | 100.0      | 200.0 | 100.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late  | Outstanding |
      | 400.0         | 0.0      | 0.0  | 0.0       | 400.0 | 300.0 | 100.0      | 200.0 | 100.0       |
    Then Loan Transactions tab has the following data:
      | Transaction date  | Transaction Type       | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20240623      | Disbursement           | 400.0  | 0.0       | 0.0      | 0.0  | 0.0       | 400.0        |
      | 20240624      | Repayment              | 100.0  | 100.0     | 0.0      | 0.0  | 0.0       | 300.0        |
      | 20240910 | Merchant Issued Refund | 200.0  | 200.0     | 0.0      | 0.0  | 0.0       | 100.0        |

  @TestRailId:C3261
  Scenario: Verify that repayment reversal is created as the result of backdated goodwill credit transaction for interest bearing product
    When Admin sets the business date to "20240623"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                        | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_EMI_360_30_INTEREST_RECALCULATION_DAILY_TILL_PRECLOSE | 20240623       | 400            | 0                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 30                | DAYS                  | 30             | DAYS                   | 1                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240623" with "400" amount and expected disbursement date on "20240623"
    And Admin successfully disburse the loan on "20240623" with "400" EUR transaction amount
    When Admin sets the business date to "20240910"
    And Customer makes "MERCHANT_ISSUED_REFUND" transaction with "AUTOPAY" payment type on "20240910" with 200 EUR transaction amount and self-generated Idempotency key
    Then Loan Repayment schedule has 1 periods, with the following data for periods:
      | Nr | Days | Date         | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late  | Outstanding |
      |    |      | 20240623 |           | 400.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |       |             |
      | 1  | 30   | 20240723 |           | 0.0             | 400.0         | 0.0      | 0.0  | 0.0       | 400.0 | 200.0 | 0.0        | 200.0 | 200.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late  | Outstanding |
      | 400.0         | 0.0      | 0.0  | 0.0       | 400.0 | 200.0 | 0.0        | 200.0 | 200.0       |
    Then Loan Transactions tab has the following data:
      | Transaction date  | Transaction Type       | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20240623      | Disbursement           | 400.0  | 0.0       | 0.0      | 0.0  | 0.0       | 400.0        |
      | 20240910 | Merchant Issued Refund | 200.0  | 200.0     | 0.0      | 0.0  | 0.0       | 200.0        |
    When Admin makes "GOODWILL_CREDIT" transaction with "AUTOPAY" payment type on "20240624" with 100 EUR transaction amount
    Then Loan Repayment schedule has 1 periods, with the following data for periods:
      | Nr | Days | Date         | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late  | Outstanding |
      |    |      | 20240623 |           | 400.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |       |             |
      | 1  | 30   | 20240723 |           | 0.0             | 400.0         | 0.0      | 0.0  | 0.0       | 400.0 | 300.0 | 100.0      | 200.0 | 100.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late  | Outstanding |
      | 400.0         | 0.0      | 0.0  | 0.0       | 400.0 | 300.0 | 100.0      | 200.0 | 100.0       |
    Then Loan Transactions tab has the following data:
      | Transaction date  | Transaction Type       | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20240623      | Disbursement           | 400.0  | 0.0       | 0.0      | 0.0  | 0.0       | 400.0        |
      | 20240624      | Goodwill Credit        | 100.0  | 100.0     | 0.0      | 0.0  | 0.0       | 300.0        |
      | 20240910 | Merchant Issued Refund | 200.0  | 200.0     | 0.0      | 0.0  | 0.0       | 100.0        |

  @TestRailId:C3262
  Scenario: Verify that repayment reversal is created as the result of backdated interest payment waiver transaction for interest bearing product
    When Admin sets the business date to "20240623"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                        | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_EMI_360_30_INTEREST_RECALCULATION_DAILY_TILL_PRECLOSE | 20240623       | 400            | 0                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 30                | DAYS                  | 30             | DAYS                   | 1                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240623" with "400" amount and expected disbursement date on "20240623"
    And Admin successfully disburse the loan on "20240623" with "400" EUR transaction amount
    When Admin sets the business date to "20240910"
    And Customer makes "MERCHANT_ISSUED_REFUND" transaction with "AUTOPAY" payment type on "20240910" with 200 EUR transaction amount and self-generated Idempotency key
    Then Loan Repayment schedule has 1 periods, with the following data for periods:
      | Nr | Days | Date         | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late  | Outstanding |
      |    |      | 20240623 |           | 400.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |       |             |
      | 1  | 30   | 20240723 |           | 0.0             | 400.0         | 0.0      | 0.0  | 0.0       | 400.0 | 200.0 | 0.0        | 200.0 | 200.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late  | Outstanding |
      | 400.0         | 0.0      | 0.0  | 0.0       | 400.0 | 200.0 | 0.0        | 200.0 | 200.0       |
    Then Loan Transactions tab has the following data:
      | Transaction date  | Transaction Type       | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20240623      | Disbursement           | 400.0  | 0.0       | 0.0      | 0.0  | 0.0       | 400.0        |
      | 20240910 | Merchant Issued Refund | 200.0  | 200.0     | 0.0      | 0.0  | 0.0       | 200.0        |
    When Admin makes "INTEREST_PAYMENT_WAIVER" transaction with "AUTOPAY" payment type on "20240624" with 100 EUR transaction amount
    Then Loan Repayment schedule has 1 periods, with the following data for periods:
      | Nr | Days | Date         | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late  | Outstanding |
      |    |      | 20240623 |           | 400.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |       |             |
      | 1  | 30   | 20240723 |           | 0.0             | 400.0         | 0.0      | 0.0  | 0.0       | 400.0 | 300.0 | 100.0      | 200.0 | 100.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late  | Outstanding |
      | 400.0         | 0.0      | 0.0  | 0.0       | 400.0 | 300.0 | 100.0      | 200.0 | 100.0       |
    Then Loan Transactions tab has the following data:
      | Transaction date  | Transaction Type        | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20240623      | Disbursement            | 400.0  | 0.0       | 0.0      | 0.0  | 0.0       | 400.0        |
      | 20240624      | Interest Payment Waiver | 100.0  | 100.0     | 0.0      | 0.0  | 0.0       | 300.0        |
      | 20240910 | Merchant Issued Refund  | 200.0  | 200.0     | 0.0      | 0.0  | 0.0       | 100.0        |

  @TestRailId:C3263
  Scenario: Verify that repayment reversal is created as the result of backdated merchant issued refund transaction for interest bearing product
    When Admin sets the business date to "20240623"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                        | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_EMI_360_30_INTEREST_RECALCULATION_DAILY_TILL_PRECLOSE | 20240623       | 400            | 0                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 30                | DAYS                  | 30             | DAYS                   | 1                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240623" with "400" amount and expected disbursement date on "20240623"
    And Admin successfully disburse the loan on "20240623" with "400" EUR transaction amount
    When Admin sets the business date to "20240910"
    And Customer makes "MERCHANT_ISSUED_REFUND" transaction with "AUTOPAY" payment type on "20240910" with 200 EUR transaction amount and self-generated Idempotency key
    Then Loan Repayment schedule has 1 periods, with the following data for periods:
      | Nr | Days | Date         | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late  | Outstanding |
      |    |      | 20240623 |           | 400.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |       |             |
      | 1  | 30   | 20240723 |           | 0.0             | 400.0         | 0.0      | 0.0  | 0.0       | 400.0 | 200.0 | 0.0        | 200.0 | 200.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late  | Outstanding |
      | 400.0         | 0.0      | 0.0  | 0.0       | 400.0 | 200.0 | 0.0        | 200.0 | 200.0       |
    Then Loan Transactions tab has the following data:
      | Transaction date  | Transaction Type       | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20240623      | Disbursement           | 400.0  | 0.0       | 0.0      | 0.0  | 0.0       | 400.0        |
      | 20240910 | Merchant Issued Refund | 200.0  | 200.0     | 0.0      | 0.0  | 0.0       | 200.0        |
    When Customer makes "MERCHANT_ISSUED_REFUND" transaction with "AUTOPAY" payment type on "20240624" with 100 EUR transaction amount and self-generated Idempotency key
    Then Loan Repayment schedule has 1 periods, with the following data for periods:
      | Nr | Days | Date         | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late  | Outstanding |
      |    |      | 20240623 |           | 400.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |       |             |
      | 1  | 30   | 20240723 |           | 0.0             | 400.0         | 0.0      | 0.0  | 0.0       | 400.0 | 300.0 | 100.0      | 200.0 | 100.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late  | Outstanding |
      | 400.0         | 0.0      | 0.0  | 0.0       | 400.0 | 300.0 | 100.0      | 200.0 | 100.0       |
    Then Loan Transactions tab has the following data:
      | Transaction date  | Transaction Type       | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20240623      | Disbursement           | 400.0  | 0.0       | 0.0      | 0.0  | 0.0       | 400.0        |
      | 20240624      | Merchant Issued Refund | 100.0  | 100.0     | 0.0      | 0.0  | 0.0       | 300.0        |
      | 20240910 | Merchant Issued Refund | 200.0  | 200.0     | 0.0      | 0.0  | 0.0       | 100.0        |

  @TestRailId:C3264
  Scenario: Verify that repayment reversal is created as the result of backdated payout refund transaction for interest bearing product
    When Admin sets the business date to "20240623"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                        | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_EMI_360_30_INTEREST_RECALCULATION_DAILY_TILL_PRECLOSE | 20240623       | 400            | 0                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 30                | DAYS                  | 30             | DAYS                   | 1                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240623" with "400" amount and expected disbursement date on "20240623"
    And Admin successfully disburse the loan on "20240623" with "400" EUR transaction amount
    When Admin sets the business date to "20240910"
    And Customer makes "MERCHANT_ISSUED_REFUND" transaction with "AUTOPAY" payment type on "20240910" with 200 EUR transaction amount and self-generated Idempotency key
    Then Loan Repayment schedule has 1 periods, with the following data for periods:
      | Nr | Days | Date         | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late  | Outstanding |
      |    |      | 20240623 |           | 400.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |       |             |
      | 1  | 30   | 20240723 |           | 0.0             | 400.0         | 0.0      | 0.0  | 0.0       | 400.0 | 200.0 | 0.0        | 200.0 | 200.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late  | Outstanding |
      | 400.0         | 0.0      | 0.0  | 0.0       | 400.0 | 200.0 | 0.0        | 200.0 | 200.0       |
    Then Loan Transactions tab has the following data:
      | Transaction date  | Transaction Type       | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20240623      | Disbursement           | 400.0  | 0.0       | 0.0      | 0.0  | 0.0       | 400.0        |
      | 20240910 | Merchant Issued Refund | 200.0  | 200.0     | 0.0      | 0.0  | 0.0       | 200.0        |
    When Customer makes "PAYOUT_REFUND" transaction with "AUTOPAY" payment type on "20240624" with 100 EUR transaction amount and system-generated Idempotency key
    Then Loan Repayment schedule has 1 periods, with the following data for periods:
      | Nr | Days | Date         | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late  | Outstanding |
      |    |      | 20240623 |           | 400.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |       |             |
      | 1  | 30   | 20240723 |           | 0.0             | 400.0         | 0.0      | 0.0  | 0.0       | 400.0 | 300.0 | 100.0      | 200.0 | 100.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late  | Outstanding |
      | 400.0         | 0.0      | 0.0  | 0.0       | 400.0 | 300.0 | 100.0      | 200.0 | 100.0       |
    Then Loan Transactions tab has the following data:
      | Transaction date  | Transaction Type       | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20240623      | Disbursement           | 400.0  | 0.0       | 0.0      | 0.0  | 0.0       | 400.0        |
      | 20240624      | Payout Refund          | 100.0  | 100.0     | 0.0      | 0.0  | 0.0       | 300.0        |
      | 20240910 | Merchant Issued Refund | 200.0  | 200.0     | 0.0      | 0.0  | 0.0       | 100.0        |

  @TestRailId:C3265
  Scenario: Verify that repayment reversal is created as the result of backdated charge adjustment transaction for interest bearing product
    When Admin sets the business date to "20240623"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                        | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_EMI_360_30_INTEREST_RECALCULATION_DAILY_TILL_PRECLOSE | 20240623       | 400            | 0                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 30                | DAYS                  | 30             | DAYS                   | 1                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240623" with "400" amount and expected disbursement date on "20240623"
    And Admin successfully disburse the loan on "20240623" with "400" EUR transaction amount
    When Admin sets the business date to "20240910"
    And Customer makes "MERCHANT_ISSUED_REFUND" transaction with "AUTOPAY" payment type on "20240910" with 200 EUR transaction amount and self-generated Idempotency key
    Then Loan Repayment schedule has 1 periods, with the following data for periods:
      | Nr | Days | Date         | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late  | Outstanding |
      |    |      | 20240623 |           | 400.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |       |             |
      | 1  | 30   | 20240723 |           | 0.0             | 400.0         | 0.0      | 0.0  | 0.0       | 400.0 | 200.0 | 0.0        | 200.0 | 200.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late  | Outstanding |
      | 400.0         | 0.0      | 0.0  | 0.0       | 400.0 | 200.0 | 0.0        | 200.0 | 200.0       |
    Then Loan Transactions tab has the following data:
      | Transaction date  | Transaction Type       | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20240623      | Disbursement           | 400.0  | 0.0       | 0.0      | 0.0  | 0.0       | 400.0        |
      | 20240910 | Merchant Issued Refund | 200.0  | 200.0     | 0.0      | 0.0  | 0.0       | 200.0        |
    When Admin sets the business date to "20240624"
    When Admin adds "LOAN_NSF_FEE" due date charge with "20240624" due date and 100 EUR transaction amount
    When Admin makes a charge adjustment for the last "LOAN_NSF_FEE" type charge which is due on "20240624" with 100 EUR transaction amount and externalId ""
    Then Loan Repayment schedule has 1 periods, with the following data for periods:
      | Nr | Days | Date         | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late  | Outstanding |
      |    |      | 20240623 |           | 400.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |       |             |
      | 1  | 30   | 20240723 |           | 0.0             | 400.0         | 0.0      | 0.0  | 100.0     | 500.0 | 300.0 | 100.0      | 200.0 | 200.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late  | Outstanding |
      | 400.0         | 0.0      | 0.0  | 100.0     | 500.0 | 300.0 | 100.0      | 200.0 | 200.0       |
    Then Loan Transactions tab has the following data:
      | Transaction date  | Transaction Type       | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20240623      | Disbursement           | 400.0  | 0.0       | 0.0      | 0.0  | 0.0       | 400.0        |
      | 20240624      | Charge Adjustment      | 100.0  | 100.0     | 0.0      | 0.0  | 0.0       | 300.0        |
      | 20240910 | Merchant Issued Refund | 200.0  | 100.0     | 0.0      | 0.0  | 100.0     | 200.0        |

  @TestRailId:C3266
  Scenario: Verify that repayment reversal is created as the result of backdated disbursal transaction for interest bearing product
    When Admin sets the business date to "20240623"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                           | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_EMI_360_30_MULTIDISBURSE | 20240623       | 500            | 0                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 30                | DAYS                  | 30             | DAYS                   | 1                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240623" with "500" amount and expected disbursement date on "20240623"
    And Admin successfully disburse the loan on "20240623" with "400" EUR transaction amount
    When Admin sets the business date to "20240910"
    And Customer makes "MERCHANT_ISSUED_REFUND" transaction with "AUTOPAY" payment type on "20240910" with 200 EUR transaction amount and self-generated Idempotency key
    Then Loan Repayment schedule has 1 periods, with the following data for periods:
      | Nr | Days | Date         | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late  | Outstanding |
      |    |      | 20240623 |           | 400.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |       |             |
      | 1  | 30   | 20240723 |           | 0.0             | 400.0         | 0.0      | 0.0  | 0.0       | 400.0 | 200.0 | 0.0        | 200.0 | 200.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late  | Outstanding |
      | 400.0         | 0.0      | 0.0  | 0.0       | 400.0 | 200.0 | 0.0        | 200.0 | 200.0       |
    Then Loan Transactions tab has the following data:
      | Transaction date  | Transaction Type       | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20240623      | Disbursement           | 400.0  | 0.0       | 0.0      | 0.0  | 0.0       | 400.0        |
      | 20240910 | Merchant Issued Refund | 200.0  | 200.0     | 0.0      | 0.0  | 0.0       | 200.0        |
    When Admin successfully disburse the loan on "20240624" with "100" EUR transaction amount
    Then Loan Repayment schedule has 1 periods, with the following data for periods:
      | Nr | Days | Date         | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late  | Outstanding |
      |    |      | 20240623 |           | 400.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |       |             |
      |    |      | 20240624 |           | 100.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |       |             |
      | 1  | 30   | 20240723 |           | 0.0             | 500.0         | 0.0      | 0.0  | 0.0       | 500.0 | 200.0 | 0.0        | 200.0 | 300.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late  | Outstanding |
      | 500.0         | 0.0      | 0.0  | 0.0       | 500.0 | 200.0 | 0.0        | 200.0 | 300.0       |
    Then Loan Transactions tab has the following data:
      | Transaction date  | Transaction Type       | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20240623      | Disbursement           | 400.0  | 0.0       | 0.0      | 0.0  | 0.0       | 400.0        |
      | 20240624      | Disbursement           | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 500.0        |
      | 20240910 | Merchant Issued Refund | 200.0  | 200.0     | 0.0      | 0.0  | 0.0       | 300.0        |

  @TestRailId:C3296
  Scenario: Verify the relationship for Interest Refund transaction after repayment by reverting related transaction
    When Admin sets the business date to "20240130"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                           | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_EMI_ACTUAL_ACTUAL_INTEREST_REFUND_INTEREST_RECALCULATION | 20240101   | 200            | 15                     | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 4                 | MONTHS                | 1              | MONTHS                 | 4                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240101" with "200" amount and expected disbursement date on "20240101"
    And Admin successfully disburse the loan on "20240101" with "200" EUR transaction amount
    When Customer makes "MERCHANT_ISSUED_REFUND" transaction with "AUTOPAY" payment type on "20240115" with 50 EUR transaction amount and self-generated Idempotency key
    And Customer makes "PAYOUT_REFUND" transaction with "AUTOPAY" payment type on "20240116" with 50 EUR transaction amount and self-generated Idempotency key
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type       | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20240101  | Disbursement           | 200.0  | 0.0       | 0.0      | 0.0  | 0.0       | 200.0        | false    |
      | 20240115  | Merchant Issued Refund | 50.0   | 50.0      | 0.0      | 0.0  | 0.0       | 150.0        | false    |
      | 20240115  | Interest Refund        | 0.29   | 0.29      | 0.0      | 0.0  | 0.0       | 149.71       | false    |
      | 20240116  | Payout Refund          | 50.0   | 48.79     | 1.21     | 0.0  | 0.0       | 100.92       | false    |
      | 20240116  | Interest Refund        | 0.31   | 0.31      | 0.0      | 0.0  | 0.0       | 100.61       | false    |
    Then In Loan Transactions the "3"th Transaction has relationship type=RELATED with the "2"th Transaction
    Then In Loan Transactions the "5"th Transaction has relationship type=RELATED with the "4"th Transaction
    When Customer makes "AUTOPAY" repayment on "20240110" with 25 EUR transaction amount
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type       | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20240101  | Disbursement           | 200.0  | 0.0       | 0.0      | 0.0  | 0.0       | 200.0        | false    |
      | 20240110  | Repayment              | 25.0   | 25.0      | 0.0      | 0.0  | 0.0       | 175.0        | false    |
      | 20240115  | Merchant Issued Refund | 50.0   | 48.9      | 1.1      | 0.0  | 0.0       | 126.1        | false    |
      | 20240115  | Interest Refund        | 0.29   | 0.29      | 0.0      | 0.0  | 0.0       | 125.81       | false    |
      | 20240116  | Payout Refund          | 50.0   | 49.95     | 0.05     | 0.0  | 0.0       | 75.86        | false    |
      | 20240116  | Interest Refund        | 0.31   | 0.31      | 0.0      | 0.0  | 0.0       | 75.55        | false    |
    Then In Loan Transactions the "4"th Transaction has relationship type=RELATED with the "3"th Transaction
    Then In Loan Transactions the "6"th Transaction has relationship type=RELATED with the "5"th Transaction
    When Customer undo "1"th "Merchant Issued Refund" transaction made on "20240115"
    When Customer undo "1"th "Payout Refund" transaction made on "20240116"
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type       | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20240101  | Disbursement           | 200.0  | 0.0       | 0.0      | 0.0  | 0.0       | 200.0        | false    |
      | 20240110  | Repayment              | 25.0   | 25.0      | 0.0      | 0.0  | 0.0       | 175.0        | false    |
      | 20240115  | Merchant Issued Refund | 50.0   | 48.9      | 1.1      | 0.0  | 0.0       | 126.1        | true     |
      | 20240115  | Interest Refund        | 0.29   | 0.29      | 0.0      | 0.0  | 0.0       | 125.81       | true     |
      | 20240116  | Payout Refund          | 50.0   | 48.83     | 1.17     | 0.0  | 0.0       | 126.17       | true     |
      | 20240116  | Interest Refund        | 0.31   | 0.31      | 0.0      | 0.0  | 0.0       | 125.86       | true     |

  @TestRailId:C3293
  Scenario: Verify that repayment made during downpayment period should not call payInterest or payPrincipal methods on the EmiCalculator for interest bearing progressive product with interest recalculation
    When Admin sets the business date to "20240623"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                     | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_RECALCULATION_DAILY_EMI_360_30_MULTIDISBURSE_DOWNPAYMENT | 20240623       | 1000           | 25                     | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 30                | DAYS                  | 30             | DAYS                   | 1                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240623" with "400" amount and expected disbursement date on "20240623"
    And Admin successfully disburse the loan on "20240623" with "400" EUR transaction amount
    When Customer makes "AUTOPAY" repayment on "20240623" with 100 EUR transaction amount
    Then Loan Repayment schedule has 2 periods, with the following data for periods:
      | Nr | Days | Date         | Paid date    | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      |    |      | 20240623 |              | 400.0           |               |          | 0.0  |           | 0.0    | 0.0   |            |      |             |
      | 1  | 0    | 20240623 | 20240623 | 300.0           | 100.0         | 0.0      | 0.0  | 0.0       | 100.0  | 100.0 | 0.0        | 0.0  | 0.0         |
      | 2  | 30   | 20240723 |              | 0.0             | 300.0         | 6.25     | 0.0  | 0.0       | 306.25 | 0.0   | 0.0        | 0.0  | 306.25      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 400.0         | 6.25     | 0.0  | 0.0       | 406.25 | 100.0 | 0.0        | 0.0  | 306.25      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20240623     | Disbursement     | 400.0  | 0.0       | 0.0      | 0.0  | 0.0       | 400.0        |
      | 20240623     | Repayment        | 100.0  | 100.0     | 0.0      | 0.0  | 0.0       | 300.0        |

  @TestRailId:C3294
  Scenario: Verify that payment transactions made during downpayment period should not call payInterest or payPrincipal methods on the EmiCalculator for interest bearing progressive product with interest recalculation
    When Admin sets the business date to "20240623"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                     | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_RECALCULATION_DAILY_EMI_360_30_MULTIDISBURSE_DOWNPAYMENT | 20240623       | 1000           | 25                     | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 30                | DAYS                  | 30             | DAYS                   | 1                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240623" with "400" amount and expected disbursement date on "20240623"
    And Admin successfully disburse the loan on "20240623" with "400" EUR transaction amount
    And Customer makes "MERCHANT_ISSUED_REFUND" transaction with "AUTOPAY" payment type on "20240623" with 25 EUR transaction amount and self-generated Idempotency key
    And Customer makes "GOODWILL_CREDIT" transaction with "AUTOPAY" payment type on "20240623" with 25 EUR transaction amount and self-generated Idempotency key
    And Customer makes "INTEREST_PAYMENT_WAIVER" transaction with "AUTOPAY" payment type on "20240623" with 25 EUR transaction amount and self-generated Idempotency key
    And Customer makes "PAYOUT_REFUND" transaction with "AUTOPAY" payment type on "20240623" with 25 EUR transaction amount and self-generated Idempotency key
    Then Loan Repayment schedule has 2 periods, with the following data for periods:
      | Nr | Days | Date         | Paid date    | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      |    |      | 20240623 |              | 400.0           |               |          | 0.0  |           | 0.0    | 0.0   |            |      |             |
      | 1  | 0    | 20240623 | 20240623 | 300.0           | 100.0         | 0.0      | 0.0  | 0.0       | 100.0  | 100.0 | 0.0        | 0.0  | 0.0         |
      | 2  | 30   | 20240723 |              | 0.0             | 300.0         | 6.25     | 0.0  | 0.0       | 306.25 | 0.0   | 0.0        | 0.0  | 306.25      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 400.0         | 6.25     | 0.0  | 0.0       | 406.25 | 100.0 | 0.0        | 0.0  | 306.25      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type        | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20240623     | Disbursement            | 400.0  | 0.0       | 0.0      | 0.0  | 0.0       | 400.0        |
      | 20240623     | Merchant Issued Refund  | 25.0   | 25.0      | 0.0      | 0.0  | 0.0       | 375.0        |
      | 20240623     | Goodwill Credit         | 25.0   | 25.0      | 0.0      | 0.0  | 0.0       | 350.0        |
      | 20240623     | Interest Payment Waiver | 25.0   | 25.0      | 0.0      | 0.0  | 0.0       | 325.0        |
      | 20240623     | Payout Refund           | 25.0   | 25.0      | 0.0      | 0.0  | 0.0       | 300.0        |

  @TestRailId:C3295
  Scenario: Verify that backdated repayment made after loan maturity date should not call payInterest or payPrincipal methods on the EmiCalculator for interest bearing progressive product with interest recalculation
    When Admin sets the business date to "20240623"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                     | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_RECALCULATION_DAILY_EMI_360_30_MULTIDISBURSE_DOWNPAYMENT | 20240623       | 1000           | 25                     | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 30                | DAYS                  | 30             | DAYS                   | 1                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240623" with "400" amount and expected disbursement date on "20240623"
    And Admin successfully disburse the loan on "20240623" with "400" EUR transaction amount
    When Admin sets the business date to "20240724"
    When Customer makes "AUTOPAY" repayment on "20240623" with 100 EUR transaction amount
    Then Loan Repayment schedule has 2 periods, with the following data for periods:
      | Nr | Days | Date         | Paid date    | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      |    |      | 20240623 |              | 400.0           |               |          | 0.0  |           | 0.0    | 0.0   |            |      |             |
      | 1  | 0    | 20240623 | 20240623 | 300.0           | 100.0         | 0.0      | 0.0  | 0.0       | 100.0  | 100.0 | 0.0        | 0.0  | 0.0         |
      | 2  | 30   | 20240723 |              | 0.0             | 300.0         | 6.25     | 0.0  | 0.0       | 306.25 | 0.0   | 0.0        | 0.0  | 306.25      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 400.0         | 6.25     | 0.0  | 0.0       | 406.25 | 100.0 | 0.0        | 0.0  | 306.25      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20240623     | Disbursement     | 400.0  | 0.0       | 0.0      | 0.0  | 0.0       | 400.0        |
      | 20240623     | Repayment        | 100.0  | 100.0     | 0.0      | 0.0  | 0.0       | 300.0        |

  @TestRailId:C3382
  Scenario: Verify repayment reversal on interest bearing loan with NSF fee without down payment when accrual activity is present
    When Admin sets the business date to "20241222"
    And Admin creates a client with random data
    And Admin creates a fully customized loan with the following data:
      | LoanProduct                                                     | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_EMI_ACTUAL_ACTUAL_ACCRUAL_ACTIVITY | 20241222  | 10000          | 9.99                   | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 3                 | MONTHS                | 1              | MONTHS                 | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20241222" with "10000" amount and expected disbursement date on "20241222"
    And Admin successfully disburse the loan on "20241222" with "10000" EUR transaction amount
    And Admin adds an NSF fee because of payment bounce with "20241222" transaction date
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due     | Paid | In advance | Late | Outstanding |
      |    |      | 20241222 |           | 10000.0         |               |          | 0.0  |           | 0.0     | 0.0  |            |      |             |
      | 1  | 31   | 20250122  |           | 6695.66         | 3304.34       | 84.78    | 0.0  | 10.0      | 3399.12 | 0.0  | 0.0        | 0.0  | 3399.12     |
      | 2  | 31   | 20250222 |           | 3363.35         | 3332.31       | 56.81    | 0.0  | 0.0       | 3389.12 | 0.0  | 0.0        | 0.0  | 3389.12     |
      | 3  | 28   | 20250322    |           | 0.0             | 3363.35       | 25.78    | 0.0  | 0.0       | 3389.13 | 0.0  | 0.0        | 0.0  | 3389.13     |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due      | Paid | In advance | Late | Outstanding |
      | 10000.0       | 167.37   | 0.0  | 10.0      | 10177.37 | 0.0  | 0.0        | 0.0  | 10177.37    |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount  | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20241222 | Disbursement     | 10000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 10000.0      | false    |
    And Customer makes "AUTOPAY" repayment on "20241222" with 10177.37 EUR transaction amount
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due     | Paid    | In advance | Late | Outstanding |
      |    |      | 20241222 |                  | 10000.0         |               |          | 0.0  |           | 0.0     | 0.0     |            |      |             |
      | 1  | 31   | 20250122  | 20241222 | 6695.66         | 3304.34       | 84.78    | 0.0  | 10.0      | 3399.12 | 3399.12 | 3399.12    | 0.0  | 0.0         |
      | 2  | 31   | 20250222 | 20241222 | 3363.35         | 3332.31       | 56.81    | 0.0  | 0.0       | 3389.12 | 3389.12 | 3389.12    | 0.0  | 0.0         |
      | 3  | 28   | 20250322    | 20241222 | 0.0             | 3363.35       | 25.78    | 0.0  | 0.0       | 3389.13 | 3389.13 | 3389.13    | 0.0  | 0.0         |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due      | Paid     | In advance | Late | Outstanding |
      | 10000.0       | 167.37   | 0.0  | 10.0      | 10177.37 | 10177.37 | 10177.37   | 0.0  | 0.0         |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount   | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20241222 | Disbursement     | 10000.0  | 0.0       | 0.0      | 0.0  | 0.0       | 10000.0      | false    |
      | 20241222 | Repayment        | 10177.37 | 10000.0   | 167.37   | 0.0  | 10.0      | 0.0          | false    |
      | 20241222 | Accrual          | 177.37   | 0.0       | 167.37   | 0.0  | 10.0      | 0.0          | false    |
      | 20241222 | Accrual Activity | 177.37   | 0.0       | 167.37   | 0.0  | 10.0      | 0.0          | false    |
    And Customer makes a repayment undo on "20241222"
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due     | Paid | In advance | Late | Outstanding |
      |    |      | 20241222 |           | 10000.0         |               |          | 0.0  |           | 0.0     | 0.0  |            |      |             |
      | 1  | 31   | 20250122  |           | 6695.66         | 3304.34       | 84.78    | 0.0  | 10.0      | 3399.12 | 0.0  | 0.0        | 0.0  | 3399.12     |
      | 2  | 31   | 20250222 |           | 3363.35         | 3332.31       | 56.81    | 0.0  | 0.0       | 3389.12 | 0.0  | 0.0        | 0.0  | 3389.12     |
      | 3  | 28   | 20250322    |           | 0.0             | 3363.35       | 25.78    | 0.0  | 0.0       | 3389.13 | 0.0  | 0.0        | 0.0  | 3389.13     |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due      | Paid | In advance | Late | Outstanding |
      | 10000.0       | 167.37   | 0.0  | 10.0      | 10177.37 | 0.0  | 0.0        | 0.0  | 10177.37    |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount   | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20241222 | Disbursement     | 10000.0  | 0.0       | 0.0      | 0.0  | 0.0       | 10000.0      | false    |
      | 20241222 | Repayment        | 10177.37 | 10000.0   | 167.37   | 0.0  | 10.0      | 0.0          | true     |
      | 20241222 | Accrual          | 177.37   | 0.0       | 167.37   | 0.0  | 10.0      | 0.0          | false    |

  @TestRailId:C3383
  Scenario: Verify repayment reversal on interest bearing loan with NSF fee with down payment when accrual activity is present
    When Admin sets the business date to "20241222"
    And Admin creates a client with random data
    And Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                      | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_AUTO_DOWNPAYMENT_EMI_ACTUAL_ACTUAL_ACCRUAL_ACTIVITY | 20241222  | 10000          | 9.99                   | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 3                 | MONTHS                | 1              | MONTHS                 | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20241222" with "6080.58" amount and expected disbursement date on "20241222"
    And Admin successfully disburse the loan on "20241222" with "6080.58" EUR transaction amount
    And Admin adds "LOAN_NSF_FEE" due date charge with "20241222" due date and 20 EUR transaction amount
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due     | Paid    | In advance | Late | Outstanding |
      |    |      | 20241222 |                  | 6080.58         |               |          | 0.0  |           | 0.0     | 0.0     |            |      |             |
      | 1  | 0    | 20241222 | 20241222 | 4560.44         | 1520.14       | 0.0      | 0.0  | 0.0       | 1520.14 | 1520.14 | 0.0        | 0.0  | 0.0         |
      | 2  | 31   | 20250122  |                  | 3053.51         | 1506.93       | 38.66    | 0.0  | 20.0      | 1565.59 | 0.0     | 0.0        | 0.0  | 1565.59     |
      | 3  | 31   | 20250222 |                  | 1533.83         | 1519.68       | 25.91    | 0.0  | 0.0       | 1545.59 | 0.0     | 0.0        | 0.0  | 1545.59     |
      | 4  | 28   | 20250322    |                  | 0.0             | 1533.83       | 11.75    | 0.0  | 0.0       | 1545.58 | 0.0     | 0.0        | 0.0  | 1545.58     |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid    | In advance | Late | Outstanding |
      | 6080.58       | 76.32    | 0.0  | 20.0      | 6176.9 | 1520.14 | 0.0        | 0.0  | 4656.76     |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount  | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20241222 | Disbursement     | 6080.58 | 0.0       | 0.0      | 0.0  | 0.0       | 6080.58      | false    |
      | 20241222 | Down Payment     | 1520.14 | 1520.14   | 0.0      | 0.0  | 0.0       | 4560.44      | false    |
    And Customer makes "AUTOPAY" repayment on "20241222" with 6060.58 EUR transaction amount
    And Loan status will be "OVERPAID"
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due     | Paid    | In advance | Late | Outstanding |
      |    |      | 20241222 |                  | 6080.58         |               |          | 0.0  |           | 0.0     | 0.0     |            |      |             |
      | 1  | 0    | 20241222 | 20241222 | 4560.44         | 1520.14       | 0.0      | 0.0  | 0.0       | 1520.14 | 1520.14 | 0.0        | 0.0  | 0.0         |
      | 2  | 31   | 20250122  | 20241222 | 3053.51         | 1506.93       | 38.66    | 0.0  | 20.0      | 1565.59 | 1565.59 | 1565.59    | 0.0  | 0.0         |
      | 3  | 31   | 20250222 | 20241222 | 1533.83         | 1519.68       | 25.91    | 0.0  | 0.0       | 1545.59 | 1545.59 | 1545.59    | 0.0  | 0.0         |
      | 4  | 28   | 20250322    | 20241222 | 0.0             | 1533.83       | 11.75    | 0.0  | 0.0       | 1545.58 | 1545.58 | 1545.58    | 0.0  | 0.0         |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late | Outstanding |
      | 6080.58       | 76.32    | 0.0  | 20.0      | 6176.9 | 6176.9 | 4656.76    | 0.0  | 0.0         |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount  | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20241222 | Disbursement     | 6080.58 | 0.0       | 0.0      | 0.0  | 0.0       | 6080.58      | false    |
      | 20241222 | Down Payment     | 1520.14 | 1520.14   | 0.0      | 0.0  | 0.0       | 4560.44      | false    |
      | 20241222 | Repayment        | 6060.58 | 4560.44   | 76.32    | 0.0  | 20.0      | 0.0          | false    |
      | 20241222 | Accrual          | 96.32   | 0.0       | 76.32    | 0.0  | 20.0      | 0.0          | false    |
      | 20241222 | Accrual Activity | 96.32   | 0.0       | 76.32    | 0.0  | 20.0      | 0.0          | false    |
    And Customer makes a repayment undo on "20241222"
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due     | Paid    | In advance | Late | Outstanding |
      |    |      | 20241222 |                  | 6080.58         |               |          | 0.0  |           | 0.0     | 0.0     |            |      |             |
      | 1  | 0    | 20241222 | 20241222 | 4560.44         | 1520.14       | 0.0      | 0.0  | 0.0       | 1520.14 | 1520.14 | 0.0        | 0.0  | 0.0         |
      | 2  | 31   | 20250122  |                  | 3053.51         | 1506.93       | 38.66    | 0.0  | 20.0      | 1565.59 | 0.0     | 0.0        | 0.0  | 1565.59     |
      | 3  | 31   | 20250222 |                  | 1533.83         | 1519.68       | 25.91    | 0.0  | 0.0       | 1545.59 | 0.0     | 0.0        | 0.0  | 1545.59     |
      | 4  | 28   | 20250322    |                  | 0.0             | 1533.83       | 11.75    | 0.0  | 0.0       | 1545.58 | 0.0     | 0.0        | 0.0  | 1545.58     |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid    | In advance | Late | Outstanding |
      | 6080.58       | 76.32    | 0.0  | 20.0      | 6176.9 | 1520.14 | 0.0        | 0.0  | 4656.76     |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount  | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20241222 | Disbursement     | 6080.58 | 0.0       | 0.0      | 0.0  | 0.0       | 6080.58      | false    |
      | 20241222 | Down Payment     | 1520.14 | 1520.14   | 0.0      | 0.0  | 0.0       | 4560.44      | false    |
      | 20241222 | Repayment        | 6060.58 | 4560.44   | 76.32    | 0.0  | 20.0      | 0.0          | true     |
      | 20241222 | Accrual          | 96.32   | 0.0       | 76.32    | 0.0  | 20.0      | 0.0          | false    |

  @TestRailId:C3391
  Scenario: Validate interest calculation for on progressive interest bearing loan with multi-disbursement - MIR on disbursement date
    When Admin sets the business date to "20240101"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                         | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_EMI_360_30_MULTIDISBURSE               | 20240101   | 1000           | 7.0                    | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 6                 | MONTHS                | 1              | MONTHS                 | 6                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240101" with "500" amount and expected disbursement date on "20240101"
    When Admin successfully disburse the loan on "20240101" with "300" EUR transaction amount
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late | Outstanding |
      |    |      | 20240101  |                 | 300.0           |               |          | 0.0  |           | 0.0    | 0.0    |            |      |             |
      | 1  | 31   | 20240201 |                 | 250.72          | 49.28         | 1.75     | 0.0  | 0.0       | 51.03  | 0.0    | 0.0        | 0.0  | 51.03       |
      | 2  | 29   | 20240301    |                 | 201.15          | 49.57         | 1.46     | 0.0  | 0.0       | 51.03  | 0.0    | 0.0        | 0.0  | 51.03       |
      | 3  | 31   | 20240401    |                 | 151.29          | 49.86         | 1.17     | 0.0  | 0.0       | 51.03  | 0.0    | 0.0        | 0.0  | 51.03       |
      | 4  | 30   | 20240501      |                 | 101.14          | 50.15         | 0.88     | 0.0  | 0.0       | 51.03  | 0.0    | 0.0        | 0.0  | 51.03       |
      | 5  | 31   | 20240601     |                 | 50.7            | 50.44         | 0.59     | 0.0  | 0.0       | 51.03  | 0.0    | 0.0        | 0.0  | 51.03       |
      | 6  | 30   | 20240701     |                 | 0.0             | 50.7          | 0.3      | 0.0  | 0.0       | 51.0   | 0.0    | 0.0        | 0.0  | 51.0        |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid    | In advance | Late | Outstanding |
      | 300.0         | 6.15     | 0.0  | 0.0       | 306.15  | 0.0     | 0.0        | 0.0  | 306.15      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type       | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement           | 300.0  | 0.0       | 0.0      | 0.0  | 0.0       | 300.0        | false    | false    |
    When Customer makes "MERCHANT_ISSUED_REFUND" transaction with "AUTOPAY" payment type on "20240101" with 300 EUR transaction amount and system-generated Idempotency key
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late | Outstanding |
      |    |      | 20240101  |                 | 300.0           |               |          | 0.0  |           | 0.0    | 0.0    |            |      |             |
      | 1  | 31   | 20240201 |                 | 250.72          | 49.28         | 1.75     | 0.0  | 0.0       | 51.03  | 49.5   | 49.5       | 0.0  | 1.53        |
      | 2  | 29   | 20240301    |                 | 201.15          | 49.57         | 1.46     | 0.0  | 0.0       | 51.03  | 49.79  | 49.79      | 0.0  | 1.24        |
      | 3  | 31   | 20240401    |                 | 151.29          | 49.86         | 1.17     | 0.0  | 0.0       | 51.03  | 50.08  | 50.08      | 0.0  | 0.95        |
      | 4  | 30   | 20240501      |                 | 101.14          | 50.15         | 0.88     | 0.0  | 0.0       | 51.03  | 50.22  | 50.22      | 0.0  | 0.81        |
      | 5  | 31   | 20240601     |                 | 50.7            | 50.44         | 0.59     | 0.0  | 0.0       | 51.03  | 50.22  | 50.22      | 0.0  | 0.81        |
      | 6  | 30   | 20240701     |                 | 0.0             | 50.7          | 0.3      | 0.0  | 0.0       | 51.0   | 50.19  | 50.19      | 0.0  | 0.81        |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid    | In advance | Late | Outstanding |
      | 300.0         | 6.15     | 0.0  | 0.0       | 306.15  | 300.0   | 300.0      | 0.0  | 6.15      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type       | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement           | 300.0  | 0.0       | 0.0      | 0.0  | 0.0       | 300.0        | false    | false    |
      | 20240101  | Merchant Issued Refund | 300.0  | 298.71    | 1.29     | 0.0  | 0.0       | 1.29         | false    | false    |
    When Admin successfully disburse the loan on "20240101" with "200" EUR transaction amount
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late | Outstanding |
      |    |      | 20240101  |                 | 300.0           |               |          | 0.0  |           | 0.0    | 0.0    |            |      |             |
      |    |      | 20240101  |                 | 200.0           |               |          | 0.0  |           | 0.0    | 0.0    |            |      |             |
      | 1  | 31   | 20240201 |                 | 417.88	         | 82.12         | 2.92	    | 0.0  | 0.0       | 85.04  | 49.5   | 49.5       | 0.0  | 35.54       |
      | 2  | 29   | 20240301    |                 | 335.28	         | 82.6          | 2.44     | 0.0  | 0.0       | 85.04  | 49.79  | 49.79      | 0.0  | 35.25       |
      | 3  | 31   | 20240401    |                 | 252.2           | 83.08         | 1.96	    | 0.0  | 0.0       | 85.04  | 50.08  | 50.08      | 0.0  | 34.96       |
      | 4  | 30   | 20240501      |                 | 168.63          | 83.57	     | 1.47     | 0.0  | 0.0       | 85.04  | 50.22  | 50.22      | 0.0  | 34.82       |
      | 5  | 31   | 20240601     |                 | 84.57           | 84.06         | 0.98	    | 0.0  | 0.0       | 85.04  | 50.22  | 50.22      | 0.0  | 34.82       |
      | 6  | 30   | 20240701     |                 | 0.0             | 84.57	     | 0.49     | 0.0  | 0.0       | 85.06  | 50.19  | 50.19      | 0.0  | 34.87       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid    | In advance | Late | Outstanding |
      | 500.0         | 10.26    | 0.0  | 0.0       | 510.26  | 300.0   | 300.0      | 0.0  | 210.26      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type       | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement           | 300.0  | 0.0       | 0.0      | 0.0  | 0.0       | 300.0        | false    | false    |
      | 20240101  | Merchant Issued Refund | 300.0  | 298.71    | 1.29     | 0.0  | 0.0       | 1.29         | false    | false    |
      | 20240101  | Disbursement           | 200.0  | 0.0       | 0.0      | 0.0  | 0.0       | 201.29       | false    | false    |

  @TestRailId:C3392
  Scenario: Validate interest calculation for on progressive interest bearing loan with multi-disbursement - MIR on disbursement date, 2nd disbursement on middle of 2nd period
    When Admin sets the business date to "20240101"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                         | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_EMI_360_30_MULTIDISBURSE               | 20240101   | 1000           | 7.0                    | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 6                 | MONTHS                | 1              | MONTHS                 | 6                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240101" with "500" amount and expected disbursement date on "20240101"
    When Admin successfully disburse the loan on "20240101" with "300" EUR transaction amount
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late | Outstanding |
      |    |      | 20240101  |                 | 300.0           |               |          | 0.0  |           | 0.0    | 0.0    |            |      |             |
      | 1  | 31   | 20240201 |                 | 250.72          | 49.28         | 1.75     | 0.0  | 0.0       | 51.03  | 0.0    | 0.0        | 0.0  | 51.03       |
      | 2  | 29   | 20240301    |                 | 201.15          | 49.57         | 1.46     | 0.0  | 0.0       | 51.03  | 0.0    | 0.0        | 0.0  | 51.03       |
      | 3  | 31   | 20240401    |                 | 151.29          | 49.86         | 1.17     | 0.0  | 0.0       | 51.03  | 0.0    | 0.0        | 0.0  | 51.03       |
      | 4  | 30   | 20240501      |                 | 101.14          | 50.15         | 0.88     | 0.0  | 0.0       | 51.03  | 0.0    | 0.0        | 0.0  | 51.03       |
      | 5  | 31   | 20240601     |                 | 50.7            | 50.44         | 0.59     | 0.0  | 0.0       | 51.03  | 0.0    | 0.0        | 0.0  | 51.03       |
      | 6  | 30   | 20240701     |                 | 0.0             | 50.7          | 0.3      | 0.0  | 0.0       | 51.0   | 0.0    | 0.0        | 0.0  | 51.0        |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid    | In advance | Late | Outstanding |
      | 300.0         | 6.15     | 0.0  | 0.0       | 306.15  | 0.0     | 0.0        | 0.0  | 306.15      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type       | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement           | 300.0  | 0.0       | 0.0      | 0.0  | 0.0       | 300.0        | false    | false    |
    When Customer makes "MERCHANT_ISSUED_REFUND" transaction with "AUTOPAY" payment type on "20240101" with 300 EUR transaction amount and system-generated Idempotency key
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late | Outstanding |
      |    |      | 20240101  |                 | 300.0           |               |          | 0.0  |           | 0.0    | 0.0    |            |      |             |
      | 1  | 31   | 20240201 |                 | 250.72          | 49.28         | 1.75     | 0.0  | 0.0       | 51.03  | 49.5   | 49.5       | 0.0  | 1.53        |
      | 2  | 29   | 20240301    |                 | 201.15          | 49.57         | 1.46     | 0.0  | 0.0       | 51.03  | 49.79  | 49.79      | 0.0  | 1.24        |
      | 3  | 31   | 20240401    |                 | 151.29          | 49.86         | 1.17     | 0.0  | 0.0       | 51.03  | 50.08  | 50.08      | 0.0  | 0.95        |
      | 4  | 30   | 20240501      |                 | 101.14          | 50.15         | 0.88     | 0.0  | 0.0       | 51.03  | 50.22  | 50.22      | 0.0  | 0.81        |
      | 5  | 31   | 20240601     |                 | 50.7            | 50.44         | 0.59     | 0.0  | 0.0       | 51.03  | 50.22  | 50.22      | 0.0  | 0.81        |
      | 6  | 30   | 20240701     |                 | 0.0             | 50.7          | 0.3      | 0.0  | 0.0       | 51.0   | 50.19  | 50.19      | 0.0  | 0.81        |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid    | In advance | Late | Outstanding |
      | 300.0         | 6.15     | 0.0  | 0.0       | 306.15  | 300.0   | 300.0      | 0.0  | 6.15      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type       | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement           | 300.0  | 0.0       | 0.0      | 0.0  | 0.0       | 300.0        | false    | false    |
      | 20240101  | Merchant Issued Refund | 300.0  | 298.71    | 1.29     | 0.0  | 0.0       | 1.29         | false    | false    |
    When Admin sets the business date to "20240210"
    When Admin successfully disburse the loan on "20240210" with "200" EUR transaction amount
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late | Outstanding |
      |    |      | 20240101  |                 | 300.0           |               |          | 0.0  |           | 0.0    | 0.0    |            |      |             |
      | 1  | 31   | 20240201 |                 | 250.72	         | 49.28         | 1.75	    | 0.0  | 0.0       | 51.03  | 49.5   | 49.5       | 0.0  | 1.53        |
      |    |      | 20240210 |                 | 200.0           |               |          | 0.0  |           | 0.0    | 0.0    |            |      |             |
      | 2  | 29   | 20240301    |                 | 361.33	         | 89.39         | 2.27     | 0.0  | 0.0       | 91.66  | 49.79  | 49.79      | 0.0  | 41.87       |
      | 3  | 31   | 20240401    |                 | 271.78          | 89.55         | 2.11	    | 0.0  | 0.0       | 91.66  | 50.08  | 50.08      | 0.0  | 41.58       |
      | 4  | 30   | 20240501      |                 | 181.71          | 90.07	     | 1.59     | 0.0  | 0.0       | 91.66  | 50.22  | 50.22      | 0.0  | 41.44       |
      | 5  | 31   | 20240601     |                 | 91.11           | 90.6          | 1.06	    | 0.0  | 0.0       | 91.66  | 50.22  | 50.22      | 0.0  | 41.44       |
      | 6  | 30   | 20240701     |                 | 0.0             | 91.11         | 0.53     | 0.0  | 0.0       | 91.64  | 50.19  | 50.19      | 0.0  | 41.45       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid    | In advance | Late | Outstanding |
      | 500.0         | 9.31     | 0.0  | 0.0       | 509.31  | 300.0   | 300.0      | 0.0  | 209.31     |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type       | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement           | 300.0  | 0.0       | 0.0      | 0.0  | 0.0       | 300.0        | false    | false    |
      | 20240101  | Merchant Issued Refund | 300.0  | 298.71    | 1.29     | 0.0  | 0.0       | 1.29         | false    | false    |
      | 20240210 | Disbursement           | 200.0  | 0.0       | 0.0      | 0.0  | 0.0       | 201.29       | false    | false    |

  @TestRailId:C3442
  Scenario: Verify that after repayment reversal Goodwill credit is reversed and replayed with non null external-id
    When Admin sets the business date to "20250122"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                                   | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      |LP2_ADV_PYMNT_INTEREST_DAILY_EMI_360_30_INTEREST_RECALCULATION_DAILY_ACCRUAL_ACTIVITY_POSTING  | 20250121   | 800            | 7                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 6                 | MONTHS                | 1              | MONTHS                 | 6                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20250121" with "800" amount and expected disbursement date on "20250121"
    When Admin successfully disburse the loan on "20250121" with "800" EUR transaction amount
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      |    |      | 20250121  |           | 800.0           |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      | 1  | 31   | 20250221 |           | 668.6           | 131.4         | 4.67     | 0.0  | 0.0       | 136.07 | 0.0  | 0.0        | 0.0  | 136.07      |
      | 2  | 28   | 20250321    |           | 536.43          | 132.17        | 3.9      | 0.0  | 0.0       | 136.07 | 0.0  | 0.0        | 0.0  | 136.07      |
      | 3  | 31   | 20250421    |           | 403.49          | 132.94        | 3.13     | 0.0  | 0.0       | 136.07 | 0.0  | 0.0        | 0.0  | 136.07      |
      | 4  | 30   | 20250521    |           | 269.77          | 133.72        | 2.35     | 0.0  | 0.0       | 136.07 | 0.0  | 0.0        | 0.0  | 136.07      |
      | 5  | 31   | 20250621     |           | 135.27          | 134.5         | 1.57     | 0.0  | 0.0       | 136.07 | 0.0  | 0.0        | 0.0  | 136.07      |
      | 6  | 30   | 20250721     |           | 0.0             | 135.27        | 0.79     | 0.0  | 0.0       | 136.06 | 0.0  | 0.0        | 0.0  | 136.06      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 800.0         | 16.41    | 0.0  | 0.0       | 816.41 | 0.0  | 0.0        | 0.0  | 816.41      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20250121  | Disbursement     | 800.0  | 0.0       | 0.0      | 0.0  | 0.0       | 800.0        |
    When Admin runs inline COB job for Loan
    And Admin sets the business date to "20250125"
    And Customer makes "AUTOPAY" repayment on "20250125" with 720 EUR transaction amount
    When Admin runs inline COB job for Loan
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late | Outstanding |
      |    |      | 20250121  |                 | 800.0           |               |          | 0.0  |           | 0.0    | 0.0    |            |      |             |
      | 1  | 31   | 20250221 | 20250125 | 664.53          | 135.47        | 0.6      | 0.0  | 0.0       | 136.07 | 136.07 | 136.07     | 0.0  | 0.0         |
      | 2  | 28   | 20250321    | 20250125 | 528.46          | 136.07        | 0.0      | 0.0  | 0.0       | 136.07 | 136.07 | 136.07     | 0.0  | 0.0         |
      | 3  | 31   | 20250421    | 20250125 | 392.39          | 136.07        | 0.0      | 0.0  | 0.0       | 136.07 | 136.07 | 136.07     | 0.0  | 0.0         |
      | 4  | 30   | 20250521      | 20250125 | 256.32          | 136.07        | 0.0      | 0.0  | 0.0       | 136.07 | 136.07 | 136.07     | 0.0  | 0.0         |
      | 5  | 31   | 20250621     | 20250125 | 120.25          | 136.07        | 0.0      | 0.0  | 0.0       | 136.07 | 136.07 | 136.07     | 0.0  | 0.0         |
      | 6  | 30   | 20250721     |                 | 0.0             | 120.25        | 2.76     | 0.0  | 0.0       | 123.01 | 39.65  | 39.65      | 0.0  | 83.36       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 800.0         | 3.36     | 0.0  | 0.0       | 803.36 | 720.0 | 720.0      | 0.0  | 83.36       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20250121  | Disbursement     | 800.0  | 0.0       | 0.0      | 0.0  | 0.0       | 800.0        | false    | false    |
      | 20250122  | Accrual          | 0.15   | 0.0       | 0.15     | 0.0  | 0.0       |  0.0         | false    | false    |
      | 20250123  | Accrual          | 0.15   | 0.0       | 0.15     | 0.0  | 0.0       |  0.0         | false    | false    |
      | 20250124  | Accrual          | 0.15   | 0.0       | 0.15     | 0.0  | 0.0       |  0.0         | false    | false    |
      | 20250125  | Repayment        | 720.0  | 719.4     | 0.6      | 0.0  | 0.0       |  80.6        | false    | false    |
    When Admin makes "GOODWILL_CREDIT" transaction with "AUTOPAY" payment type on "20250125" with 200 EUR transaction amount
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late | Outstanding |
      |    |      | 20250121  |                 | 800.0           |               |          | 0.0  |           | 0.0    | 0.0    |            |      |             |
      | 1  | 31   | 20250221 | 20250125 | 664.53          | 135.47        | 0.6      | 0.0  | 0.0       | 136.07 | 136.07 | 136.07     | 0.0  | 0.0         |
      | 2  | 28   | 20250321    | 20250125 | 528.46          | 136.07        | 0.0      | 0.0  | 0.0       | 136.07 | 136.07 | 136.07     | 0.0  | 0.0         |
      | 3  | 31   | 20250421    | 20250125 | 392.39          | 136.07        | 0.0      | 0.0  | 0.0       | 136.07 | 136.07 | 136.07     | 0.0  | 0.0         |
      | 4  | 30   | 20250521      | 20250125 | 256.32          | 136.07        | 0.0      | 0.0  | 0.0       | 136.07 | 136.07 | 136.07     | 0.0  | 0.0         |
      | 5  | 31   | 20250621     | 20250125 | 120.25          | 136.07        | 0.0      | 0.0  | 0.0       | 136.07 | 136.07 | 136.07     | 0.0  | 0.0         |
      | 6  | 30   | 20250721     | 20250125 | 0.0             | 120.25        | 0.0      | 0.0  | 0.0       | 120.25 | 120.25 | 120.25     | 0.0  | 0.0         |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 800.0         | 0.6      | 0.0  | 0.0       | 800.6  | 800.6 | 800.6      | 0.0  | 0.0         |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20250121  | Disbursement     | 800.0  | 0.0       | 0.0      | 0.0  | 0.0       | 800.0        | false    | false    |
      | 20250122  | Accrual          | 0.15   | 0.0       | 0.15     | 0.0  | 0.0       |  0.0         | false    | false    |
      | 20250123  | Accrual          | 0.15   | 0.0       | 0.15     | 0.0  | 0.0       |  0.0         | false    | false    |
      | 20250124  | Accrual          | 0.15   | 0.0       | 0.15     | 0.0  | 0.0       |  0.0         | false    | false    |
      | 20250125  | Repayment        | 720.0  | 719.4     | 0.6      | 0.0  | 0.0       |  80.6        | false    | false    |
      | 20250125  | Goodwill Credit  | 200.0  | 80.6      | 0.0      | 0.0  | 0.0       |  0.0         | false    | false    |
      | 20250125  | Accrual          | 0.15   | 0.0       | 0.15     | 0.0  | 0.0       |  0.0         | false    | false    |
      | 20250125  | Accrual Activity | 0.6    | 0.0       | 0.6      | 0.0  | 0.0       |  0.0         | false    | false    |
    When Customer undo "1"th "Repayment" transaction made on "20250125"
    Then In Loan Transactions all transactions have non-null external-id
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late | Outstanding |
      |    |      | 20250121  |                 | 800.0           |               |          | 0.0  |           | 0.0    | 0.0    |            |      |             |
      | 1  | 31   | 20250221 |                 | 667.58          | 132.42        | 3.65     | 0.0  | 0.0       | 136.07 | 0.0    | 0.0        | 0.0  | 136.07      |
      | 2  | 28   | 20250321    |                 | 534.24          | 133.34        | 2.73     | 0.0  | 0.0       | 136.07 | 0.0    | 0.0        | 0.0  | 136.07      |
      | 3  | 31   | 20250421    |                 | 400.12          | 134.12        | 1.95     | 0.0  | 0.0       | 136.07 | 0.0    | 0.0        | 0.0  | 136.07      |
      | 4  | 30   | 20250521      |                 | 265.22          | 134.9         | 1.17     | 0.0  | 0.0       | 136.07 | 0.0    | 0.0        | 0.0  | 136.07      |
      | 5  | 31   | 20250621     |                 | 136.07          | 129.15        | 0.38     | 0.0  | 0.0       | 129.53 | 63.93  | 63.93      | 0.0  | 65.6        |
      | 6  | 30   | 20250721     | 20250125 | 0.0             | 136.07        | 0.0      | 0.0  | 0.0       | 136.07 | 136.07 | 136.07     | 0.0  | 0.0         |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 800.0         | 9.88     | 0.0  | 0.0       | 809.88 | 200.0 | 200.0      | 0.0  | 609.88      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20250121  | Disbursement     | 800.0  | 0.0       | 0.0      | 0.0  | 0.0       | 800.0        | false    | false    |
      | 20250122  | Accrual          | 0.15   | 0.0       | 0.15     | 0.0  | 0.0       |  0.0         | false    | false    |
      | 20250123  | Accrual          | 0.15   | 0.0       | 0.15     | 0.0  | 0.0       |  0.0         | false    | false    |
      | 20250124  | Accrual          | 0.15   | 0.0       | 0.15     | 0.0  | 0.0       |  0.0         | false    | false    |
      | 20250125  | Repayment        | 720.0  | 719.4     | 0.6      | 0.0  | 0.0       |  80.6        | true     | false    |
      | 20250125  | Accrual          | 0.15   | 0.0       | 0.15     | 0.0  | 0.0       |  0.0         | false    | false    |
      | 20250125  | Goodwill Credit  | 200.0  | 200.0     | 0.0      | 0.0  | 0.0       |  600.0       | false    | true     |

  @TestRailId:C3520
  Scenario: Verify the next/last installament payment allocation in case the repayment is before the installment date
    When Admin sets the business date to "20240101"
    When Admin creates a client with random data
    When Admin set "LP2_ADV_CUSTOM_PMT_ALLOC_PROGRESSIVE_LOAN_SCHEDULE_HORIZONTAL" loan product "DEFAULT" transaction type to "NEXT_LAST_INSTALLMENT" future installment allocation rule
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                   | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_CUSTOM_PMT_ALLOC_PROGRESSIVE_LOAN_SCHEDULE_HORIZONTAL | 20240101   | 100            | 7                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 6                 | MONTHS                | 1              | MONTHS                 | 6                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240101" with "100" amount and expected disbursement date on "20240101"
    When Admin successfully disburse the loan on "20240101" with "100" EUR transaction amount
    When Admin sets the business date to "20240115"
    And Customer makes "AUTOPAY" repayment on "20240115" with 20 EUR transaction amount
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101  |                 | 100.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 31   | 20240201 | 20240115 | 83.25           | 16.75         | 0.26     | 0.0  | 0.0       | 17.01 | 17.01 | 17.01      | 0.0  | 0.0         |
      | 2  | 29   | 20240301    |                 | 66.97           | 16.28         | 0.73     | 0.0  | 0.0       | 17.01 | 0.0   | 0.0        | 0.0  | 17.01       |
      | 3  | 31   | 20240401    |                 | 50.33           | 16.64         | 0.37     | 0.0  | 0.0       | 17.01 | 0.0   | 0.0        | 0.0  | 17.01       |
      | 4  | 30   | 20240501      |                 | 33.6            | 16.73         | 0.28     | 0.0  | 0.0       | 17.01 | 0.0   | 0.0        | 0.0  | 17.01       |
      | 5  | 31   | 20240601     |                 | 16.77           | 16.83         | 0.18     | 0.0  | 0.0       | 17.01 | 0.0   | 0.0        | 0.0  | 17.01       |
      | 6  | 30   | 20240701     |                 | 0.0             | 16.77         | 0.08     | 0.0  | 0.0       | 16.85 | 2.99  | 2.99       | 0.0  | 13.86       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      | 100.0         | 1.9      | 0.0  | 0.0       | 101.9 | 20.0 | 20.0       | 0.0  | 81.9        |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240115  | Repayment        | 20.0   | 19.74     | 0.26     | 0.0  | 0.0       | 80.26        | false    | false    |
    When Admin set "LP2_ADV_CUSTOM_PMT_ALLOC_PROGRESSIVE_LOAN_SCHEDULE_HORIZONTAL" loan product "DEFAULT" transaction type to "NEXT_INSTALLMENT" future installment allocation rule

  @TestRailId:C3521
  Scenario: Verify the next/last installament payment allocation in case the repayment is on the installment date
    When Admin sets the business date to "20240101"
    When Admin creates a client with random data
    When Admin set "LP2_ADV_CUSTOM_PMT_ALLOC_PROGRESSIVE_LOAN_SCHEDULE_HORIZONTAL" loan product "DEFAULT" transaction type to "NEXT_LAST_INSTALLMENT" future installment allocation rule
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                   | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_CUSTOM_PMT_ALLOC_PROGRESSIVE_LOAN_SCHEDULE_HORIZONTAL | 20240101   | 100            | 7                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 6                 | MONTHS                | 1              | MONTHS                 | 6                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240101" with "100" amount and expected disbursement date on "20240101"
    When Admin successfully disburse the loan on "20240101" with "100" EUR transaction amount
    When Admin sets the business date to "20240201"
    And Customer makes "AUTOPAY" repayment on "20240201" with 20 EUR transaction amount
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101  |                  | 100.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 31   | 20240201 | 20240201 | 83.57           | 16.43         | 0.58     | 0.0  | 0.0       | 17.01 | 17.01 | 0.0        | 0.0  | 0.0         |
      | 2  | 29   | 20240301    |                  | 67.03           | 16.54         | 0.47     | 0.0  | 0.0       | 17.01 | 2.99  | 2.99       | 0.0  | 14.02       |
      | 3  | 31   | 20240401    |                  | 50.41           | 16.62         | 0.39     | 0.0  | 0.0       | 17.01 | 0.0   | 0.0        | 0.0  | 17.01       |
      | 4  | 30   | 20240501      |                  | 33.69           | 16.72         | 0.29     | 0.0  | 0.0       | 17.01 | 0.0   | 0.0        | 0.0  | 17.01       |
      | 5  | 31   | 20240601     |                  | 16.88           | 16.81         | 0.2      | 0.0  | 0.0       | 17.01 | 0.0   | 0.0        | 0.0  | 17.01       |
      | 6  | 30   | 20240701     |                  | 0.0             | 16.88         | 0.1      | 0.0  | 0.0       | 16.98 | 0.0   | 0.0        | 0.0  | 16.98       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 100.0         | 2.03     | 0.0  | 0.0       | 102.03 | 20.0 | 2.99       | 0.0  | 82.03       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240201 | Repayment        | 20.0   | 19.42     | 0.58     | 0.0  | 0.0       | 80.58        | false    | false    |
    When Admin set "LP2_ADV_CUSTOM_PMT_ALLOC_PROGRESSIVE_LOAN_SCHEDULE_HORIZONTAL" loan product "DEFAULT" transaction type to "NEXT_INSTALLMENT" future installment allocation rule

  @TestRailId:C3569
  Scenario: Verify Loan is fully paid and closed after partial repayments, Merchant issued refund which overpays the loan, partial CBR and reversal of 1st repayment
    When Admin sets the business date to "20250328"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                   | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_CUSTOM_PMT_ALLOC_PROGRESSIVE_LOAN_SCHEDULE_HORIZONTAL | 20250326     | 120            | 35.29                  | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 3                 | MONTHS                | 1              | MONTHS                 | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20250326" with "120" amount and expected disbursement date on "20250326"
    When Admin successfully disburse the loan on "20250326" with "120" EUR transaction amount
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20250326    |                  | 120.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 31   | 20250426    |                  | 81.15           | 38.85         | 3.53     | 0.0  | 0.0       | 42.38 | 0.0   | 0.0        | 0.0  | 42.38       |
      | 2  | 30   | 20250526      |                  | 41.16           | 39.99         | 2.39     | 0.0  | 0.0       | 42.38 | 0.0   | 0.0        | 0.0  | 42.38       |
      | 3  | 31   | 20250626     |                  |   0.0           | 41.16         | 1.21     | 0.0  | 0.0       | 42.37 | 0.0   | 0.0        | 0.0  | 42.37       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 120.0         | 7.13     | 0.0  | 0.0       | 127.13 |  0.0 | 0.0        | 0.0  | 127.13      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20250326    | Disbursement     | 120.0  | 0.0       | 0.0      | 0.0  | 0.0       | 120.0        | false    | false    |
    And Customer makes "AUTOPAY" repayment on "20250327" with 20 EUR transaction amount
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20250326    |                  | 120.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 31   | 20250426    |                  | 80.58           | 39.42         | 2.96     | 0.0  | 0.0       | 42.38 | 20.0  | 20.0       | 0.0  | 22.38       |
      | 2  | 30   | 20250526      |                  | 40.57           | 40.01         | 2.37     | 0.0  | 0.0       | 42.38 | 0.0   | 0.0        | 0.0  | 42.38       |
      | 3  | 31   | 20250626     |                  |   0.0           | 40.57         | 1.19     | 0.0  | 0.0       | 41.76 | 0.0   | 0.0        | 0.0  | 41.76       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 120.0         | 6.52     | 0.0  | 0.0       | 126.52 | 20.0 | 20.0       | 0.0  | 106.52      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20250326    | Disbursement     | 120.0  | 0.0       | 0.0      | 0.0  | 0.0       | 120.0        | false    | false    |
      | 20250327    | Repayment        | 20.0   | 19.89     | 0.11     | 0.0  | 0.0       | 100.11       | false    | false    |
    And Customer makes "AUTOPAY" repayment on "20250327" with 20 EUR transaction amount
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20250326    |                  | 120.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 31   | 20250426    |                  | 80.01           | 39.99         | 2.39     | 0.0  | 0.0       | 42.38 | 40.0  | 40.0       | 0.0  |  2.38       |
      | 2  | 30   | 20250526      |                  | 39.98           | 40.03         | 2.35     | 0.0  | 0.0       | 42.38 | 0.0   | 0.0        | 0.0  | 42.38       |
      | 3  | 31   | 20250626     |                  |   0.0           | 39.98         | 1.18     | 0.0  | 0.0       | 41.16 | 0.0   | 0.0        | 0.0  | 41.16       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 120.0         | 5.92     | 0.0  | 0.0       | 125.92 | 40.0 | 40.0       | 0.0  |  85.92      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20250326    | Disbursement     | 120.0  | 0.0       | 0.0      | 0.0  | 0.0       | 120.0        | false    | false    |
      | 20250327    | Repayment        | 20.0   | 19.89     | 0.11     | 0.0  | 0.0       | 100.11       | false    | false    |
      | 20250327    | Repayment        | 20.0   | 20.0      | 0.0      | 0.0  | 0.0       |  80.11       | false    | false    |
    And Customer makes "MERCHANT_ISSUED_REFUND" transaction with "AUTOPAY" payment type on "20250327" with 120 EUR transaction amount and self-generated Idempotency key
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20250326    |                  | 120.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 31   | 20250426    | 20250327    | 80.11           | 39.89         | 0.11     | 0.0  | 0.0       | 40.0  | 40.0  | 40.0       | 0.0  |  0.0        |
      | 2  | 30   | 20250526      | 20250327    | 42.38           | 37.73         | 0.0      | 0.0  | 0.0       | 37.73 | 37.73 | 37.73      | 0.0  |  0.0        |
      | 3  | 31   | 20250626     | 20250327    |   0.0           | 42.38         | 0.0      | 0.0  | 0.0       | 42.38 | 42.38 | 42.38      | 0.0  |  0.0        |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late | Outstanding |
      | 120.0         | 0.11     | 0.0  | 0.0       | 120.11 | 120.11 | 120.11     | 0.0  |  0.0        |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type       | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20250326    | Disbursement           | 120.0  | 0.0       | 0.0      | 0.0  | 0.0       | 120.0        | false    | false    |
      | 20250327    | Repayment              | 20.0   | 19.89     | 0.11     | 0.0  | 0.0       | 100.11       | false    | false    |
      | 20250327    | Repayment              | 20.0   | 20.0      | 0.0      | 0.0  | 0.0       |  80.11       | false    | false    |
      | 20250327    | Merchant Issued Refund | 120.0  | 80.11     | 0.0      | 0.0  | 0.0       |   0.0        | false    | false    |
      | 20250327    | Interest Refund        | 0.11   | 0.0       | 0.0      | 0.0  | 0.0       |   0.0        | false    | false    |
      | 20250327    | Accrual Activity       | 0.11   | 0.0       | 0.11     | 0.0  | 0.0       |   0.0        | false    | false    |
      | 20250328    | Accrual                | 0.11   | 0.0       | 0.11     | 0.0  | 0.0       |   0.0        | false    | false    |
    Then Loan status will be "OVERPAID"
    Then Loan has 0 outstanding amount
    Then Loan has 40 overpaid amount
    And Admin makes Credit Balance Refund transaction on "20250328" with 20 EUR transaction amount
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20250326    |                  | 120.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 31   | 20250426    | 20250327    | 80.11           | 39.89         | 0.11     | 0.0  | 0.0       | 40.0  | 40.0  | 40.0       | 0.0  |  0.0        |
      | 2  | 30   | 20250526      | 20250327    | 42.38           | 37.73         | 0.0      | 0.0  | 0.0       | 37.73 | 37.73 | 37.73      | 0.0  |  0.0        |
      | 3  | 31   | 20250626     | 20250327    |   0.0           | 42.38         | 0.0      | 0.0  | 0.0       | 42.38 | 42.38 | 42.38      | 0.0  |  0.0        |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late | Outstanding |
      | 120.0         | 0.11     | 0.0  | 0.0       | 120.11 | 120.11 | 120.11     | 0.0  |  0.0        |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type       | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20250326    | Disbursement           | 120.0  | 0.0       | 0.0      | 0.0  | 0.0       | 120.0        | false    | false    |
      | 20250327    | Repayment              | 20.0   | 19.89     | 0.11     | 0.0  | 0.0       | 100.11       | false    | false    |
      | 20250327    | Repayment              | 20.0   | 20.0      | 0.0      | 0.0  | 0.0       |  80.11       | false    | false    |
      | 20250327    | Merchant Issued Refund | 120.0  | 80.11     | 0.0      | 0.0  | 0.0       |   0.0        | false    | false    |
      | 20250327    | Interest Refund        | 0.11   | 0.0       | 0.0      | 0.0  | 0.0       |   0.0        | false    | false    |
      | 20250327    | Accrual Activity       | 0.11   | 0.0       | 0.11     | 0.0  | 0.0       |   0.0        | false    | false    |
      | 20250328    | Accrual                | 0.11   | 0.0       | 0.11     | 0.0  | 0.0       |   0.0        | false    | false    |
      | 20250328    | Credit Balance Refund  | 20.0   | 0.0       | 0.0      | 0.0  | 0.0       |   0.0        | false    | false    |
    Then Loan status will be "OVERPAID"
    Then Loan has 0 outstanding amount
    Then Loan has 20 overpaid amount
    When Customer undo "1"th "Repayment" transaction made on "20250327"
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20250326    |                  | 120.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 31   | 20250426    | 20250327    | 84.76           | 35.24         | 0.11     | 0.0  | 0.0       | 35.35 | 35.35 | 35.35      | 0.0  |  0.0        |
      | 2  | 30   | 20250526      | 20250327    | 42.38           | 42.38         | 0.0      | 0.0  | 0.0       | 42.38 | 42.38 | 42.38      | 0.0  |  0.0        |
      | 3  | 31   | 20250626     | 20250327    |   0.0           | 42.38         | 0.0      | 0.0  | 0.0       | 42.38 | 42.38 | 42.38      | 0.0  |  0.0        |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late | Outstanding |
      | 120.0         | 0.11     | 0.0  | 0.0       | 120.11 | 120.11 | 120.11     | 0.0  |  0.0        |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type       | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20250326    | Disbursement           | 120.0  | 0.0       | 0.0      | 0.0  | 0.0       | 120.0        | false    | false    |
      | 20250327    | Repayment              | 20.0   | 19.89     | 0.11     | 0.0  | 0.0       | 100.11       | true     | false    |
      | 20250327    | Repayment              | 20.0   | 19.89     | 0.11     | 0.0  | 0.0       | 100.11       | false    | true     |
      | 20250327    | Merchant Issued Refund | 120.0  | 100.11    | 0.0      | 0.0  | 0.0       |   0.0        | false    | true     |
      | 20250327    | Interest Refund        | 0.11   | 0.0       | 0.0      | 0.0  | 0.0       |   0.0        | false    | true     |
      | 20250327    | Accrual Activity       | 0.11   | 0.0       | 0.11     | 0.0  | 0.0       |   0.0        | false    | false    |
      | 20250328    | Accrual                | 0.11   | 0.0       | 0.11     | 0.0  | 0.0       |   0.0        | false    | false    |
      | 20250328    | Credit Balance Refund  | 20.0   | 0.0       | 0.0      | 0.0  | 0.0       |   0.0        | false    | false    |
    Then Loan status will be "CLOSED_OBLIGATIONS_MET"
    Then Loan has 0 outstanding amount

  @TestRailId:C3589
  Scenario: Verify early repayment on high interest loan works properly and align the interest properly - UC1
    When Admin sets the business date to "20250410"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                   | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_CUSTOM_PMT_ALLOC_PROGRESSIVE_LOAN_SCHEDULE_HORIZONTAL | 20250410     | 1001           | 35.99                  | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 24                | MONTHS                | 1              | MONTHS                 | 24                 | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20250410" with "1001" amount and expected disbursement date on "20250410"
    When Admin successfully disburse the loan on "20250410" with "1001" EUR transaction amount
    Then Loan Repayment schedule has 24 periods, with the following data for periods:
      | Nr | Days | Date                 | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20250410        |                  | 1001.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 30   | 20250510          |                  | 971.92          | 29.08         | 30.02    | 0.0  | 0.0       | 59.1  | 0.0   | 0.0        | 0.0  | 59.1        |
      | 2  | 31   | 20250610         |                  | 941.97          | 29.95         | 29.15    | 0.0  | 0.0       | 59.1  | 0.0   | 0.0        | 0.0  | 59.1        |
      | 3  | 30   | 20250710         |                  | 911.12          | 30.85         | 28.25    | 0.0  | 0.0       | 59.1  | 0.0   | 0.0        | 0.0  | 59.1        |
      | 4  | 31   | 20250810       |                  | 879.35          | 31.77         | 27.33    | 0.0  | 0.0       | 59.1  | 0.0   | 0.0        | 0.0  | 59.1        |
      | 5  | 31   | 20250910    |                  | 846.62          | 32.73         | 26.37    | 0.0  | 0.0       | 59.1  | 0.0   | 0.0        | 0.0  | 59.1        |
      | 6  | 30   | 20251010      |                  | 812.91          | 33.71         | 25.39    | 0.0  | 0.0       | 59.1  | 0.0   | 0.0        | 0.0  | 59.1        |
      | 7  | 31   | 20251110     |                  | 778.19          | 34.72         | 24.38    | 0.0  | 0.0       | 59.1  | 0.0   | 0.0        | 0.0  | 59.1        |
      | 8  | 30   | 20251210     |                  | 742.43          | 35.76         | 23.34    | 0.0  | 0.0       | 59.1  | 0.0   | 0.0        | 0.0  | 59.1        |
      | 9  | 31   | 20260110      |                  | 705.6           | 36.83         | 22.27    | 0.0  | 0.0       | 59.1  | 0.0   | 0.0        | 0.0  | 59.1        |
      | 10 | 31   | 20260210     |                  | 667.66          | 37.94         | 21.16    | 0.0  | 0.0       | 59.1  | 0.0   | 0.0        | 0.0  | 59.1        |
      | 11 | 28   | 20260310        |                  | 628.58          | 39.08         | 20.02    | 0.0  | 0.0       | 59.1  | 0.0   | 0.0        | 0.0  | 59.1        |
      | 12 | 31   | 20260410        |                  | 588.33          | 40.25         | 18.85    | 0.0  | 0.0       | 59.1  | 0.0   | 0.0        | 0.0  | 59.1        |
      | 13 | 30   | 20260510          |                  | 546.87          | 41.46         | 17.64    | 0.0  | 0.0       | 59.1  | 0.0   | 0.0        | 0.0  | 59.1        |
      | 14 | 31   | 20260610         |                  | 504.17          | 42.7          | 16.4     | 0.0  | 0.0       | 59.1  | 0.0   | 0.0        | 0.0  | 59.1        |
      | 15 | 30   | 20260710         |                  | 460.19          | 43.98         | 15.12    | 0.0  | 0.0       | 59.1  | 0.0   | 0.0        | 0.0  | 59.1        |
      | 16 | 31   | 20260810       |                  | 414.89          | 45.3          | 13.8     | 0.0  | 0.0       | 59.1  | 0.0   | 0.0        | 0.0  | 59.1        |
      | 17 | 31   | 20260910    |                  | 368.23          | 46.66         | 12.44    | 0.0  | 0.0       | 59.1  | 0.0   | 0.0        | 0.0  | 59.1        |
      | 18 | 30   | 20261010      |                  | 320.17          | 48.06         | 11.04    | 0.0  | 0.0       | 59.1  | 0.0   | 0.0        | 0.0  | 59.1        |
      | 19 | 31   | 20261110     |                  | 270.67          | 49.5          |  9.6     | 0.0  | 0.0       | 59.1  | 0.0   | 0.0        | 0.0  | 59.1        |
      | 20 | 30   | 20261210     |                  | 219.69          | 50.98         |  8.12    | 0.0  | 0.0       | 59.1  | 0.0   | 0.0        | 0.0  | 59.1        |
      | 21 | 31   | 20270110      |                  | 167.18          | 52.51         |  6.59    | 0.0  | 0.0       | 59.1  | 0.0   | 0.0        | 0.0  | 59.1        |
      | 22 | 31   | 20270210     |                  | 113.09          | 54.09         |  5.01    | 0.0  | 0.0       | 59.1  | 0.0   | 0.0        | 0.0  | 59.1        |
      | 23 | 28   | 20270310        |                  |  57.38          | 55.71         |  3.39    | 0.0  | 0.0       | 59.1  | 0.0   | 0.0        | 0.0  | 59.1        |
      | 24 | 31   | 20270410        |                  |   0.0           | 57.38         |  1.72    | 0.0  | 0.0       | 59.1  | 0.0   | 0.0        | 0.0  | 59.1        |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 1001.0        | 417.4    | 0.0  | 0.0       | 1418.4 |  0.0 | 0.0        | 0.0  | 1418.4      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount  | Principal | Interest | Fees | Penalties | Loan Balance  | Reverted | Replayed |
      | 20250410    | Disbursement     | 1001.0  | 0.0       | 0.0      | 0.0  | 0.0       | 1001.0        | false    | false    |
    When Admin runs inline COB job for Loan
    When Admin sets the business date to "20250413"
    When Admin runs inline COB job for Loan
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount  | Principal | Interest | Fees | Penalties | Loan Balance  | Reverted | Replayed |
      | 20250410    | Disbursement     | 1001.0  | 0.0       | 0.0      | 0.0  | 0.0       | 1001.0        | false    | false    |
      | 20250411    | Accrual          | 1.0     | 0.0       | 1.0      | 0.0  | 0.0       |   0.0         | false    | false    |
      | 20250412    | Accrual          | 1.0     | 0.0       | 1.0      | 0.0  | 0.0       |   0.0         | false    | false    |
    And Customer makes "AUTOPAY" repayment on "20250410" with 100 EUR transaction amount
    Then Loan Repayment schedule has 24 periods, with the following data for periods:
      | Nr | Days | Date                 | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20250410        |                  | 1001.0          |               |          | 0.0  |           | 0.0   |  0.0  |            |      |             |
      | 1  | 30   | 20250510          | 20250410    | 941.9           | 59.1          |  0.0     | 0.0  | 0.0       | 59.1  | 59.1  | 59.1       | 0.0  |  0.0        |
      | 2  | 31   | 20250610         |                  | 882.8           | 59.1          |  0.0     | 0.0  | 0.0       | 59.1  | 40.9  | 40.9       | 0.0  | 18.2        |
      | 3  | 30   | 20250710         |                  | 882.8           |  0.0          | 59.1     | 0.0  | 0.0       | 59.1  |  0.0  |  0.0       | 0.0  | 59.1        |
      | 4  | 31   | 20250810       |                  | 871.6           | 11.2          | 47.9     | 0.0  | 0.0       | 59.1  |  0.0  |  0.0       | 0.0  | 59.1        |
      | 5  | 31   | 20250910    |                  | 838.64          | 32.96         | 26.14    | 0.0  | 0.0       | 59.1  |  0.0  |  0.0       | 0.0  | 59.1        |
      | 6  | 30   | 20251010      |                  | 804.69          | 33.95         | 25.15    | 0.0  | 0.0       | 59.1  |  0.0  |  0.0       | 0.0  | 59.1        |
      | 7  | 31   | 20251110     |                  | 769.72          | 34.97         | 24.13    | 0.0  | 0.0       | 59.1  |  0.0  |  0.0       | 0.0  | 59.1        |
      | 8  | 30   | 20251210     |                  | 733.71          | 36.01         | 23.09    | 0.0  | 0.0       | 59.1  |  0.0  |  0.0       | 0.0  | 59.1        |
      | 9  | 31   | 20260110      |                  | 696.62          | 37.09         | 22.01    | 0.0  | 0.0       | 59.1  |  0.0  |  0.0       | 0.0  | 59.1        |
      | 10 | 31   | 20260210     |                  | 658.41          | 38.21         | 20.89    | 0.0  | 0.0       | 59.1  |  0.0  |  0.0       | 0.0  | 59.1        |
      | 11 | 28   | 20260310        |                  | 619.06          | 39.35         | 19.75    | 0.0  | 0.0       | 59.1  |  0.0  |  0.0       | 0.0  | 59.1        |
      | 12 | 31   | 20260410        |                  | 578.53          | 40.53         | 18.57    | 0.0  | 0.0       | 59.1  |  0.0  |  0.0       | 0.0  | 59.1        |
      | 13 | 30   | 20260510          |                  | 536.78          | 41.75         | 17.35    | 0.0  | 0.0       | 59.1  |  0.0  |  0.0       | 0.0  | 59.1        |
      | 14 | 31   | 20260610         |                  | 493.78          | 43.0          | 16.1     | 0.0  | 0.0       | 59.1  |  0.0  |  0.0       | 0.0  | 59.1        |
      | 15 | 30   | 20260710         |                  | 449.49          | 44.29         | 14.81    | 0.0  | 0.0       | 59.1  |  0.0  |  0.0       | 0.0  | 59.1        |
      | 16 | 31   | 20260810       |                  | 403.87          | 45.62         | 13.48    | 0.0  | 0.0       | 59.1  |  0.0  |  0.0       | 0.0  | 59.1        |
      | 17 | 31   | 20260910    |                  | 356.88          | 46.99         | 12.11    | 0.0  | 0.0       | 59.1  |  0.0  |  0.0       | 0.0  | 59.1        |
      | 18 | 30   | 20261010      |                  | 308.48          | 48.4          | 10.7     | 0.0  | 0.0       | 59.1  |  0.0  |  0.0       | 0.0  | 59.1        |
      | 19 | 31   | 20261110     |                  | 258.63          | 49.85         |  9.25    | 0.0  | 0.0       | 59.1  |  0.0  |  0.0       | 0.0  | 59.1        |
      | 20 | 30   | 20261210     |                  | 207.29          | 51.34         |  7.76    | 0.0  | 0.0       | 59.1  |  0.0  |  0.0       | 0.0  | 59.1        |
      | 21 | 31   | 20270110      |                  | 154.41          | 52.88         |  6.22    | 0.0  | 0.0       | 59.1  |  0.0  |  0.0       | 0.0  | 59.1        |
      | 22 | 31   | 20270210     |                  |  99.94          | 54.47         |  4.63    | 0.0  | 0.0       | 59.1  |  0.0  |  0.0       | 0.0  | 59.1        |
      | 23 | 28   | 20270310        |                  |  43.84          | 56.1          |  3.0     | 0.0  | 0.0       | 59.1  |  0.0  |  0.0       | 0.0  | 59.1        |
      | 24 | 31   | 20270410        |                  |   0.0           | 43.84         |  1.31    | 0.0  | 0.0       | 45.15 |  0.0  |  0.0       | 0.0  | 45.15       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid    | In advance   | Late | Outstanding |
      | 1001.0        | 403.45   | 0.0  | 0.0       | 1404.45 |  100.0  | 100.0        | 0.0  | 1304.45     |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount  | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20250410    | Disbursement     | 1001.0  | 0.0       | 0.0      | 0.0  | 0.0       | 1001.0       | false    | false    |
      | 20250410    | Repayment        | 100.0   | 100.0     | 0.0      | 0.0  | 0.0       |  901.0       | false    | false    |
      | 20250411    | Accrual          | 1.0     | 0.0       | 1.0      | 0.0  | 0.0       |   0.0        | false    | false    |
      | 20250412    | Accrual          | 1.0     | 0.0       | 1.0      | 0.0  | 0.0       |   0.0        | false    | false    |
    When Admin sets the business date to "20250415"
    When Admin runs inline COB job for Loan
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount  | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20250410    | Disbursement     | 1001.0  | 0.0       | 0.0      | 0.0  | 0.0       | 1001.0       | false    | false    |
      | 20250410    | Repayment        | 100.0   | 100.0     | 0.0      | 0.0  | 0.0       |  901.0       | false    | false    |
      | 20250411    | Accrual          | 1.0     | 0.0       | 1.0      | 0.0  | 0.0       |   0.0        | false    | false    |
      | 20250412    | Accrual          | 1.0     | 0.0       | 1.0      | 0.0  | 0.0       |   0.0        | false    | false    |
      | 20250413    | Accrual          | 0.7     | 0.0       | 0.7      | 0.0  | 0.0       |   0.0        | false    | false    |
      | 20250414    | Accrual          | 0.9     | 0.0       | 0.9      | 0.0  | 0.0       |   0.0        | false    | false    |

  @TestRailId:C3614
  Scenario: Verify early repayment on high interest loan works properly and align the interest properly while increase interest rate - UC2
    When Admin sets the business date to "20250410"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                   | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_CUSTOM_PMT_ALLOC_PROGRESSIVE_LOAN_SCHEDULE_HORIZONTAL | 20250410     | 1001           | 17                     | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 24                | MONTHS                | 1              | MONTHS                 | 24                 | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20250410" with "1001" amount and expected disbursement date on "20250410"
    When Admin successfully disburse the loan on "20250410" with "1001" EUR transaction amount
    Then Loan Repayment schedule has 24 periods, with the following data for periods:
      | Nr | Days | Date                 | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20250410        |                  | 1001.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 30   | 20250510          |                  | 965.69          | 35.31         | 14.18    | 0.0  | 0.0       | 49.49 | 0.0   | 0.0        | 0.0  | 49.49       |
      | 2  | 31   | 20250610         |                  | 929.88          | 35.81         | 13.68    | 0.0  | 0.0       | 49.49 | 0.0   | 0.0        | 0.0  | 49.49       |
      | 3  | 30   | 20250710         |                  | 893.56          | 36.32         | 13.17    | 0.0  | 0.0       | 49.49 | 0.0   | 0.0        | 0.0  | 49.49       |
      | 4  | 31   | 20250810       |                  | 856.73          | 36.83         | 12.66    | 0.0  | 0.0       | 49.49 | 0.0   | 0.0        | 0.0  | 49.49       |
      | 5  | 31   | 20250910    |                  | 819.38          | 37.35         | 12.14    | 0.0  | 0.0       | 49.49 | 0.0   | 0.0        | 0.0  | 49.49       |
      | 6  | 30   | 20251010      |                  | 781.5           | 37.88         | 11.61    | 0.0  | 0.0       | 49.49 | 0.0   | 0.0        | 0.0  | 49.49       |
      | 7  | 31   | 20251110     |                  | 743.08          | 38.42         | 11.07    | 0.0  | 0.0       | 49.49 | 0.0   | 0.0        | 0.0  | 49.49       |
      | 8  | 30   | 20251210     |                  | 704.12          | 38.96         | 10.53    | 0.0  | 0.0       | 49.49 | 0.0   | 0.0        | 0.0  | 49.49       |
      | 9  | 31   | 20260110      |                  | 664.61          | 39.51         |  9.98    | 0.0  | 0.0       | 49.49 | 0.0   | 0.0        | 0.0  | 49.49       |
      | 10 | 31   | 20260210     |                  | 624.54          | 40.07         |  9.42    | 0.0  | 0.0       | 49.49 | 0.0   | 0.0        | 0.0  | 49.49       |
      | 11 | 28   | 20260310        |                  | 583.9           | 40.64         |  8.85    | 0.0  | 0.0       | 49.49 | 0.0   | 0.0        | 0.0  | 49.49       |
      | 12 | 31   | 20260410        |                  | 542.68          | 41.22         |  8.27    | 0.0  | 0.0       | 49.49 | 0.0   | 0.0        | 0.0  | 49.49       |
      | 13 | 30   | 20260510          |                  | 500.88          | 41.8          |  7.69    | 0.0  | 0.0       | 49.49 | 0.0   | 0.0        | 0.0  | 49.49       |
      | 14 | 31   | 20260610         |                  | 458.49          | 42.39         |  7.1     | 0.0  | 0.0       | 49.49 | 0.0   | 0.0        | 0.0  | 49.49       |
      | 15 | 30   | 20260710         |                  | 415.5           | 42.99         |  6.5     | 0.0  | 0.0       | 49.49 | 0.0   | 0.0        | 0.0  | 49.49       |
      | 16 | 31   | 20260810       |                  | 371.9           | 43.6          |  5.89    | 0.0  | 0.0       | 49.49 | 0.0   | 0.0        | 0.0  | 49.49       |
      | 17 | 31   | 20260910    |                  | 327.68          | 44.22         |  5.27    | 0.0  | 0.0       | 49.49 | 0.0   | 0.0        | 0.0  | 49.49       |
      | 18 | 30   | 20261010      |                  | 282.83          | 44.85         |  4.64    | 0.0  | 0.0       | 49.49 | 0.0   | 0.0        | 0.0  | 49.49       |
      | 19 | 31   | 20261110     |                  | 237.35          | 45.48         |  4.01    | 0.0  | 0.0       | 49.49 | 0.0   | 0.0        | 0.0  | 49.49       |
      | 20 | 30   | 20261210     |                  | 191.22          | 46.13         |  3.36    | 0.0  | 0.0       | 49.49 | 0.0   | 0.0        | 0.0  | 49.49       |
      | 21 | 31   | 20270110      |                  | 144.44          | 46.78         |  2.71    | 0.0  | 0.0       | 49.49 | 0.0   | 0.0        | 0.0  | 49.49       |
      | 22 | 31   | 20270210     |                  |  97.0           | 47.44         |  2.05    | 0.0  | 0.0       | 49.49 | 0.0   | 0.0        | 0.0  | 49.49       |
      | 23 | 28   | 20270310        |                  |  48.88          | 48.12         |  1.37    | 0.0  | 0.0       | 49.49 | 0.0   | 0.0        | 0.0  | 49.49       |
      | 24 | 31   | 20270410        |                  |   0.0           | 48.88         |  0.69    | 0.0  | 0.0       | 49.57 | 0.0   | 0.0        | 0.0  | 49.57       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid | In advance | Late | Outstanding |
      | 1001.0        | 186.84    | 0.0  | 0.0      | 1187.84 |  0.0 | 0.0        | 0.0  | 1187.84     |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount  | Principal | Interest | Fees | Penalties | Loan Balance  | Reverted | Replayed |
      | 20250410    | Disbursement     | 1001.0  | 0.0       | 0.0      | 0.0  | 0.0       | 1001.0        | false    | false    |
    When Admin runs inline COB job for Loan
    When Admin sets the business date to "20250413"
    When Admin runs inline COB job for Loan
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount  | Principal | Interest | Fees | Penalties | Loan Balance  | Reverted | Replayed |
      | 20250410    | Disbursement     | 1001.0  | 0.0       | 0.0      | 0.0  | 0.0       | 1001.0        | false    | false    |
      | 20250411    | Accrual          | 0.47    | 0.0       | 0.47     | 0.0  | 0.0       |   0.0         | false    | false    |
      | 20250412    | Accrual          | 0.48    | 0.0       | 0.48     | 0.0  | 0.0       |   0.0         | false    | false    |
    And Customer makes "AUTOPAY" repayment on "20250410" with 130 EUR transaction amount
    Then Loan Repayment schedule has 24 periods, with the following data for periods:
      | Nr | Days | Date                 | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20250410        |                  | 1001.0          |               |          | 0.0  |           | 0.0   |  0.0  |            |      |             |
      | 1  | 30   | 20250510          | 20250410    | 951.51          | 49.49         |  0.0     | 0.0  | 0.0       | 49.49 | 49.49 | 49.49      | 0.0  |  0.0        |
      | 2  | 31   | 20250610         | 20250410    | 902.02          | 49.49         |  0.0     | 0.0  | 0.0       | 49.49 | 49.49 | 49.49      | 0.0  |  0.0        |
      | 3  | 30   | 20250710         |                  | 852.53          | 49.49         |  0.0     | 0.0  | 0.0       | 49.49 | 31.02 | 31.02      | 0.0  | 18.47       |
      | 4  | 31   | 20250810       |                  | 852.14          |  0.39         | 49.1     | 0.0  | 0.0       | 49.49 |  0.0  |  0.0       | 0.0  | 49.49       |
      | 5  | 31   | 20250910    |                  | 814.72          | 37.42         | 12.07    | 0.0  | 0.0       | 49.49 |  0.0  |  0.0       | 0.0  | 49.49       |
      | 6  | 30   | 20251010      |                  | 776.77          | 37.95         | 11.54    | 0.0  | 0.0       | 49.49 |  0.0  |  0.0       | 0.0  | 49.49       |
      | 7  | 31   | 20251110     |                  | 738.28          | 38.49         | 11.0     | 0.0  | 0.0       | 49.49 |  0.0  |  0.0       | 0.0  | 49.49       |
      | 8  | 30   | 20251210     |                  | 699.25          | 39.03         | 10.46    | 0.0  | 0.0       | 49.49 |  0.0  |  0.0       | 0.0  | 49.49       |
      | 9  | 31   | 20260110      |                  | 659.67          | 39.58         |  9.91    | 0.0  | 0.0       | 49.49 |  0.0  |  0.0       | 0.0  | 49.49       |
      | 10 | 31   | 20260210     |                  | 619.53          | 40.14         |  9.35    | 0.0  | 0.0       | 49.49 |  0.0  |  0.0       | 0.0  | 49.49       |
      | 11 | 28   | 20260310        |                  | 578.82          | 40.71         |  8.78    | 0.0  | 0.0       | 49.49 |  0.0  |  0.0       | 0.0  | 49.49       |
      | 12 | 31   | 20260410        |                  | 537.53          | 41.29         |  8.2     | 0.0  | 0.0       | 49.49 |  0.0  |  0.0       | 0.0  | 49.49       |
      | 13 | 30   | 20260510          |                  | 495.66          | 41.87         |  7.62    | 0.0  | 0.0       | 49.49 |  0.0  |  0.0       | 0.0  | 49.49       |
      | 14 | 31   | 20260610         |                  | 453.19          | 42.47         |  7.02    | 0.0  | 0.0       | 49.49 |  0.0  |  0.0       | 0.0  | 49.49       |
      | 15 | 30   | 20260710         |                  | 410.12          | 43.07         |  6.42    | 0.0  | 0.0       | 49.49 |  0.0  |  0.0       | 0.0  | 49.49       |
      | 16 | 31   | 20260810       |                  | 366.44          | 43.68         |  5.81    | 0.0  | 0.0       | 49.49 |  0.0  |  0.0       | 0.0  | 49.49       |
      | 17 | 31   | 20260910    |                  | 322.14          | 44.3          |  5.19    | 0.0  | 0.0       | 49.49 |  0.0  |  0.0       | 0.0  | 49.49       |
      | 18 | 30   | 20261010      |                  | 277.21          | 44.93         |  4.56    | 0.0  | 0.0       | 49.49 |  0.0  |  0.0       | 0.0  | 49.49       |
      | 19 | 31   | 20261110     |                  | 231.65          | 45.56         |  3.93    | 0.0  | 0.0       | 49.49 |  0.0  |  0.0       | 0.0  | 49.49       |
      | 20 | 30   | 20261210     |                  | 185.44          | 46.21         |  3.28    | 0.0  | 0.0       | 49.49 |  0.0  |  0.0       | 0.0  | 49.49       |
      | 21 | 31   | 20270110      |                  | 138.58          | 46.86         |  2.63    | 0.0  | 0.0       | 49.49 |  0.0  |  0.0       | 0.0  | 49.49       |
      | 22 | 31   | 20270210     |                  |  91.05          | 47.53         |  1.96    | 0.0  | 0.0       | 49.49 |  0.0  |  0.0       | 0.0  | 49.49       |
      | 23 | 28   | 20270310        |                  |  42.85          | 48.2          |  1.29    | 0.0  | 0.0       | 49.49 |  0.0  |  0.0       | 0.0  | 49.49       |
      | 24 | 31   | 20270410        |                  |   0.0           | 42.85         |  0.61    | 0.0  | 0.0       | 43.46 |  0.0  |  0.0       | 0.0  | 43.46       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid    | In advance   | Late | Outstanding |
      | 1001.0        | 180.73   | 0.0  | 0.0       | 1181.73 |  130.0  | 130.0        | 0.0  | 1051.73     |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount  | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20250410    | Disbursement     | 1001.0  | 0.0       | 0.0      | 0.0  | 0.0       | 1001.0       | false    | false    |
      | 20250410    | Repayment        | 130.0   | 130.0     | 0.0      | 0.0  | 0.0       |  871.0       | false    | false    |
      | 20250411    | Accrual          | 0.47    | 0.0       | 0.47     | 0.0  | 0.0       |   0.0         | false    | false    |
      | 20250412    | Accrual          | 0.48    | 0.0       | 0.48     | 0.0  | 0.0       |   0.0         | false    | false    |
#   --- Loan reschedule: Interest rate modification effective from next day ---
    When Admin creates and approves Loan reschedule with the following data:
      | rescheduleFromDate | submittedOnDate  | adjustedDueDate | graceOnPrincipal | graceOnInterest | extraTerms | newInterestRate |
      | 20250414      | 20250413    |                 |                  |                 |            | 38              |
    When Admin sets the business date to "20250414"
    When Admin runs inline COB job for Loan
    Then Loan Repayment schedule has 24 periods, with the following data for periods:
      | Nr | Days | Date                 | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20250410        |                  | 1001.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 30   | 20250510          | 20250410    | 951.51          | 49.49         |  0.0     | 0.0  | 0.0       | 49.49 | 49.49 | 49.49      | 0.0  |  0.0        |
      | 2  | 31   | 20250610         | 20250410    | 902.02          | 49.49         |  0.0     | 0.0  | 0.0       | 49.49 | 49.49 | 49.49      | 0.0  |  0.0        |
      | 3  | 30   | 20250710         |                  | 842.82          | 59.2          |  0.0     | 0.0  | 0.0       | 59.2  | 31.02 | 31.02      | 0.0  | 28.18        |
      | 4  | 31   | 20250810       |                  | 842.82          |  0.0          | 59.2     | 0.0  | 0.0       | 59.2  | 0.0   | 0.0        | 0.0  | 59.2        |
      | 5  | 31   | 20250910    |                  | 842.82          |  0.0          | 59.2     | 0.0  | 0.0       | 59.2  | 0.0   | 0.0        | 0.0  | 59.2        |
      | 6  | 30   | 20251010      |                  | 823.73          | 19.09         | 40.11    | 0.0  | 0.0       | 59.2  | 0.0   | 0.0        | 0.0  | 59.2        |
      | 7  | 31   | 20251110     |                  | 790.0           | 33.73         | 25.47    | 0.0  | 0.0       | 59.2  | 0.0   | 0.0        | 0.0  | 59.2        |
      | 8  | 30   | 20251210     |                  | 755.2           | 34.8          | 24.4     | 0.0  | 0.0       | 59.2  | 0.0   | 0.0        | 0.0  | 59.2        |
      | 9  | 31   | 20260110      |                  | 719.3           | 35.9          | 23.3     | 0.0  | 0.0       | 59.2  | 0.0   | 0.0        | 0.0  | 59.2        |
      | 10 | 31   | 20260210     |                  | 682.26          | 37.04         | 22.16    | 0.0  | 0.0       | 59.2  | 0.0   | 0.0        | 0.0  | 59.2        |
      | 11 | 28   | 20260310        |                  | 644.05          | 38.21         | 20.99    | 0.0  | 0.0       | 59.2  | 0.0   | 0.0        | 0.0  | 59.2        |
      | 12 | 31   | 20260410        |                  | 604.63          | 39.42         | 19.78    | 0.0  | 0.0       | 59.2  | 0.0   | 0.0        | 0.0  | 59.2        |
      | 13 | 30   | 20260510          |                  | 563.96          | 40.67         | 18.53    | 0.0  | 0.0       | 59.2  | 0.0   | 0.0        | 0.0  | 59.2        |
      | 14 | 31   | 20260610         |                  | 522.0           | 41.96         | 17.24    | 0.0  | 0.0       | 59.2  | 0.0   | 0.0        | 0.0  | 59.2        |
      | 15 | 30   | 20260710         |                  | 478.72          | 43.28         | 15.92    | 0.0  | 0.0       | 59.2  | 0.0   | 0.0        | 0.0  | 59.2        |
      | 16 | 31   | 20260810       |                  | 434.06          | 44.66         | 14.54    | 0.0  | 0.0       | 59.2  | 0.0   | 0.0        | 0.0  | 59.2        |
      | 17 | 31   | 20260910    |                  | 387.99          | 46.07         | 13.13    | 0.0  | 0.0       | 59.2  | 0.0   | 0.0        | 0.0  | 59.2        |
      | 18 | 30   | 20261010      |                  | 340.46          | 47.53         | 11.67    | 0.0  | 0.0       | 59.2  | 0.0   | 0.0        | 0.0  | 59.2        |
      | 19 | 31   | 20261110     |                  | 291.43          | 49.03         | 10.17    | 0.0  | 0.0       | 59.2  | 0.0   | 0.0        | 0.0  | 59.2        |
      | 20 | 30   | 20261210     |                  | 240.84          | 50.59         |  8.61    | 0.0  | 0.0       | 59.2  | 0.0   | 0.0        | 0.0  | 59.2        |
      | 21 | 31   | 20270110      |                  | 188.65          | 52.19         |  7.01    | 0.0  | 0.0       | 59.2  | 0.0   | 0.0        | 0.0  | 59.2        |
      | 22 | 31   | 20270210     |                  | 134.81          | 53.84         |  5.36    | 0.0  | 0.0       | 59.2  | 0.0   | 0.0        | 0.0  | 59.2        |
      | 23 | 28   | 20270310        |                  | 79.26           | 55.55         |  3.65    | 0.0  | 0.0       | 59.2  | 0.0   | 0.0        | 0.0  | 59.2        |
      | 24 | 31   | 20270410        |                  | 19.42           | 59.84         |  1.89    | 0.0  | 0.0       | 61.73 | 0.0   | 0.0        | 0.0  | 61.73        |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid  | In advance | Late | Outstanding |
      | 981.58        | 422.33   | 0.0  | 0.0       | 1403.91 | 130.0 | 130.0      | 0.0  | 1273.91     |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount  | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20250410    | Disbursement     | 1001.0  | 0.0       | 0.0      | 0.0  | 0.0       | 1001.0       | false    | false    |
      | 20250410    | Repayment        | 130.0   | 130.0     | 0.0      | 0.0  | 0.0       |  871.0       | false    | false    |
      | 20250411    | Accrual          | 0.47    | 0.0       | 0.47     | 0.0  | 0.0       |   0.0        | false    | false    |
      | 20250412    | Accrual          | 0.48    | 0.0       | 0.48     | 0.0  | 0.0       |   0.0        | false    | false    |
      | 20250413    | Accrual          | 0.28    | 0.0       | 0.28     | 0.0  | 0.0       |   0.0        | false    | false    |
    And Customer makes "AUTOPAY" repayment on "20250414" with 170 EUR transaction amount
    Then Loan Repayment schedule has 24 periods, with the following data for periods:
      | Nr | Days | Date                 | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20250410        |                  | 1001.0          |               |          | 0.0  |           | 0.0   |  0.0  |            |      |             |
      | 1  | 30   | 20250510          | 20250414    | 943.95          | 57.05         |  2.15    | 0.0  | 0.0       | 59.2  | 59.2  | 59.2       | 0.0  |  0.0        |
      | 2  | 31   | 20250610         | 20250414    | 884.75          | 59.2          |  0.0     | 0.0  | 0.0       | 59.2  | 59.2  | 59.2       | 0.0  |  0.0        |
      | 3  | 30   | 20250710         | 20250414    | 825.55          | 59.2          |  0.0     | 0.0  | 0.0       | 59.2  | 59.2  | 59.2       | 0.0  |  0.0        |
      | 4  | 31   | 20250810       | 20250414    | 766.35          | 59.2          |  0.0     | 0.0  | 0.0       | 59.2  | 59.2  | 59.2       | 0.0  |  0.0        |
      | 5  | 31   | 20250910    | 20250414    | 707.15          | 59.2          |  0.0     | 0.0  | 0.0       | 59.2  | 59.2  | 59.2       | 0.0  |  0.0        |
      | 6  | 30   | 20251010      |                  | 647.95          | 59.2          |  0.0     | 0.0  | 0.0       | 59.2  |  4.0  |  4.0       | 0.0  | 55.2        |
      | 7  | 31   | 20251110     |                  | 647.95          |  0.0          | 59.2     | 0.0  | 0.0       | 59.2  |  0.0  |  0.0       | 0.0  | 59.2        |
      | 8  | 30   | 20251210     |                  | 647.95          |  0.0          | 59.2     | 0.0  | 0.0       | 59.2  |  0.0  |  0.0       | 0.0  | 59.2        |
      | 9  | 31   | 20260110      |                  | 647.95          |  0.0          | 59.2     | 0.0  | 0.0       | 59.2  |  0.0  |  0.0       | 0.0  | 59.2        |
      | 10 | 31   | 20260210     |                  | 623.88          | 24.07         | 35.13    | 0.0  | 0.0       | 59.2  |  0.0  |  0.0       | 0.0  | 59.2        |
      | 11 | 28   | 20260310        |                  | 584.44          | 39.44         | 19.76    | 0.0  | 0.0       | 59.2  |  0.0  |  0.0       | 0.0  | 59.2        |
      | 12 | 31   | 20260410        |                  | 543.75          | 40.69         | 18.51    | 0.0  | 0.0       | 59.2  |  0.0  |  0.0       | 0.0  | 59.2        |
      | 13 | 30   | 20260510          |                  | 501.77          | 41.98         | 17.22    | 0.0  | 0.0       | 59.2  |  0.0  |  0.0       | 0.0  | 59.2        |
      | 14 | 31   | 20260610         |                  | 458.46          | 43.31         | 15.89    | 0.0  | 0.0       | 59.2  |  0.0  |  0.0       | 0.0  | 59.2        |
      | 15 | 30   | 20260710         |                  | 413.78          | 44.68         | 14.52    | 0.0  | 0.0       | 59.2  |  0.0  |  0.0       | 0.0  | 59.2        |
      | 16 | 31   | 20260810       |                  | 367.68          | 46.1          | 13.1     | 0.0  | 0.0       | 59.2  |  0.0  |  0.0       | 0.0  | 59.2        |
      | 17 | 31   | 20260910    |                  | 320.12          | 47.56         | 11.64    | 0.0  | 0.0       | 59.2  |  0.0  |  0.0       | 0.0  | 59.2        |
      | 18 | 30   | 20261010      |                  | 271.06          | 49.06         | 10.14    | 0.0  | 0.0       | 59.2  |  0.0  |  0.0       | 0.0  | 59.2        |
      | 19 | 31   | 20261110     |                  | 220.44          | 50.62         |  8.58    | 0.0  | 0.0       | 59.2  |  0.0  |  0.0       | 0.0  | 59.2        |
      | 20 | 30   | 20261210     |                  | 168.22          | 52.22         |  6.98    | 0.0  | 0.0       | 59.2  |  0.0  |  0.0       | 0.0  | 59.2        |
      | 21 | 31   | 20270110      |                  | 114.35          | 53.87         |  5.33    | 0.0  | 0.0       | 59.2  |  0.0  |  0.0       | 0.0  | 59.2        |
      | 22 | 31   | 20270210     |                  |  58.77          | 55.58         |  3.62    | 0.0  | 0.0       | 59.2  |  0.0  |  0.0       | 0.0  | 59.2        |
      | 23 | 28   | 20270310        |                  |   1.43          | 57.34         |  1.86    | 0.0  | 0.0       | 59.2  |  0.0  |  0.0       | 0.0  | 59.2        |
      | 24 | 31   | 20270410        |                  |   0.0           |  1.43         |  0.05    | 0.0  | 0.0       |  1.48 |  0.0  |  0.0       | 0.0  |  1.48       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid    | In advance   | Late | Outstanding |
      | 1001.0        | 362.08   | 0.0  | 0.0       | 1363.08 |  300.0  | 300.0        | 0.0  | 1063.08     |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount  | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20250410    | Disbursement     | 1001.0  | 0.0       | 0.0      | 0.0  | 0.0       | 1001.0       | false    | false    |
      | 20250410    | Repayment        | 130.0   | 130.0     | 0.0      | 0.0  | 0.0       |  871.0       | false    | false    |
      | 20250411    | Accrual          | 0.47    | 0.0       | 0.47     | 0.0  | 0.0       |   0.0        | false    | false    |
      | 20250412    | Accrual          | 0.48    | 0.0       | 0.48     | 0.0  | 0.0       |   0.0        | false    | false    |
      | 20250413    | Accrual          | 0.28    | 0.0       | 0.28     | 0.0  | 0.0       |   0.0        | false    | false    |
      | 20250414    | Repayment        | 170.0   | 167.85    | 2.15     | 0.0  | 0.0       | 703.15       | false    | false    |
    When Admin sets the business date to "20250415"
    When Admin runs inline COB job for Loan
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount  | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20250410    | Disbursement     | 1001.0  | 0.0       | 0.0      | 0.0  | 0.0       | 1001.0       | false    | false    |
      | 20250410    | Repayment        | 130.0   | 130.0     | 0.0      | 0.0  | 0.0       |  871.0       | false    | false    |
      | 20250411    | Accrual          | 0.47    | 0.0       | 0.47     | 0.0  | 0.0       |   0.0        | false    | false    |
      | 20250412    | Accrual          | 0.48    | 0.0       | 0.48     | 0.0  | 0.0       |   0.0        | false    | false    |
      | 20250413    | Accrual          | 0.28    | 0.0       | 0.28     | 0.0  | 0.0       |   0.0        | false    | false    |
      | 20250414    | Repayment        | 170.0   | 167.85    | 2.15     | 0.0  | 0.0       | 703.15       | false    | false    |
      | 20250414    | Accrual          | 0.92    | 0.0       | 0.92     | 0.0  | 0.0       |   0.0        | false    | false    |

  @TestRailId:C3615
  Scenario: Verify early repayment on high interest loan works properly and align the interest properly while reduce interest rate with repayment undo - UC3
    When Admin sets the business date to "20250410"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                   | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_CUSTOM_PMT_ALLOC_PROGRESSIVE_LOAN_SCHEDULE_HORIZONTAL | 20250410     | 1001           | 36                     | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 24                | MONTHS                | 1              | MONTHS                 | 24                 | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20250410" with "1001" amount and expected disbursement date on "20250410"
    When Admin successfully disburse the loan on "20250410" with "1001" EUR transaction amount
    Then Loan Repayment schedule has 24 periods, with the following data for periods:
      | Nr | Days | Date                 | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20250410        |                  | 1001.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 30   | 20250510          |                  | 971.92          | 29.08         | 30.03    | 0.0  | 0.0       | 59.11 | 0.0   | 0.0        | 0.0  | 59.11       |
      | 2  | 31   | 20250610         |                  | 941.97          | 29.95         | 29.16    | 0.0  | 0.0       | 59.11 | 0.0   | 0.0        | 0.0  | 59.11       |
      | 3  | 30   | 20250710         |                  | 911.12          | 30.85         | 28.26    | 0.0  | 0.0       | 59.11 | 0.0   | 0.0        | 0.0  | 59.11       |
      | 4  | 31   | 20250810       |                  | 879.34          | 31.78         | 27.33    | 0.0  | 0.0       | 59.11 | 0.0   | 0.0        | 0.0  | 59.11       |
      | 5  | 31   | 20250910    |                  | 846.61          | 32.73         | 26.38    | 0.0  | 0.0       | 59.11 | 0.0   | 0.0        | 0.0  | 59.11       |
      | 6  | 30   | 20251010      |                  | 812.9           | 33.71         | 25.4     | 0.0  | 0.0       | 59.11 | 0.0   | 0.0        | 0.0  | 59.11       |
      | 7  | 31   | 20251110     |                  | 778.18          | 34.72         | 24.39    | 0.0  | 0.0       | 59.11 | 0.0   | 0.0        | 0.0  | 59.11       |
      | 8  | 30   | 20251210     |                  | 742.42          | 35.76         | 23.35    | 0.0  | 0.0       | 59.11 | 0.0   | 0.0        | 0.0  | 59.11       |
      | 9  | 31   | 20260110      |                  | 705.58          | 36.84         | 22.27    | 0.0  | 0.0       | 59.11 | 0.0   | 0.0        | 0.0  | 59.11       |
      | 10 | 31   | 20260210     |                  | 667.64          | 37.94         | 21.17    | 0.0  | 0.0       | 59.11 | 0.0   | 0.0        | 0.0  | 59.11       |
      | 11 | 28   | 20260310        |                  | 628.56          | 39.08         | 20.03    | 0.0  | 0.0       | 59.11 | 0.0   | 0.0        | 0.0  | 59.11       |
      | 12 | 31   | 20260410        |                  | 588.31          | 40.25         | 18.86    | 0.0  | 0.0       | 59.11 | 0.0   | 0.0        | 0.0  | 59.11       |
      | 13 | 30   | 20260510          |                  | 546.85          | 41.46         | 17.65    | 0.0  | 0.0       | 59.11 | 0.0   | 0.0        | 0.0  | 59.11       |
      | 14 | 31   | 20260610         |                  | 504.15          | 42.7          | 16.41    | 0.0  | 0.0       | 59.11 | 0.0   | 0.0        | 0.0  | 59.11       |
      | 15 | 30   | 20260710         |                  | 460.16          | 43.99         | 15.12    | 0.0  | 0.0       | 59.11 | 0.0   | 0.0        | 0.0  | 59.11       |
      | 16 | 31   | 20260810       |                  | 414.85          | 45.31         | 13.8     | 0.0  | 0.0       | 59.11 | 0.0   | 0.0        | 0.0  | 59.11       |
      | 17 | 31   | 20260910    |                  | 368.19          | 46.66         | 12.45    | 0.0  | 0.0       | 59.11 | 0.0   | 0.0        | 0.0  | 59.11       |
      | 18 | 30   | 20261010      |                  | 320.13          | 48.06         | 11.05    | 0.0  | 0.0       | 59.11 | 0.0   | 0.0        | 0.0  | 59.11       |
      | 19 | 31   | 20261110     |                  | 270.62          | 49.51         |  9.6     | 0.0  | 0.0       | 59.11 | 0.0   | 0.0        | 0.0  | 59.11       |
      | 20 | 30   | 20261210     |                  | 219.63          | 50.99         |  8.12    | 0.0  | 0.0       | 59.11 | 0.0   | 0.0        | 0.0  | 59.11       |
      | 21 | 31   | 20270110      |                  | 167.11          | 52.52         |  6.59    | 0.0  | 0.0       | 59.11 | 0.0   | 0.0        | 0.0  | 59.11       |
      | 22 | 31   | 20270210     |                  | 113.01          | 54.1          |  5.01    | 0.0  | 0.0       | 59.11 | 0.0   | 0.0        | 0.0  | 59.11       |
      | 23 | 28   | 20270310        |                  |  57.29          | 55.72         |  3.39    | 0.0  | 0.0       | 59.11 | 0.0   | 0.0        | 0.0  | 59.11       |
      | 24 | 31   | 20270410        |                  |   0.0           | 57.29         |  1.72    | 0.0  | 0.0       | 59.01 | 0.0   | 0.0        | 0.0  | 59.01       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid | In advance | Late | Outstanding |
      | 1001.0        | 417.54    | 0.0  | 0.0      | 1418.54 |  0.0 | 0.0        | 0.0  | 1418.54     |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount  | Principal | Interest | Fees | Penalties | Loan Balance  | Reverted | Replayed |
      | 20250410    | Disbursement     | 1001.0  | 0.0       | 0.0      | 0.0  | 0.0       | 1001.0        | false    | false    |
    When Admin runs inline COB job for Loan
    When Admin sets the business date to "20250413"
    When Admin runs inline COB job for Loan
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount  | Principal | Interest | Fees | Penalties | Loan Balance  | Reverted | Replayed |
      | 20250410    | Disbursement     | 1001.0  | 0.0       | 0.0      | 0.0  | 0.0       | 1001.0        | false    | false    |
      | 20250411    | Accrual          | 1.0     | 0.0       | 1.0      | 0.0  | 0.0       |   0.0         | false    | false    |
      | 20250412    | Accrual          | 1.0     | 0.0       | 1.0      | 0.0  | 0.0       |   0.0         | false    | false    |
    And Customer makes "AUTOPAY" repayment on "20250410" with 150 EUR transaction amount
    Then Loan Repayment schedule has 24 periods, with the following data for periods:
      | Nr | Days | Date                 | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20250410        |                  | 1001.0          |               |          | 0.0  |           | 0.0   |  0.0  |            |      |             |
      | 1  | 30   | 20250510          | 20250410    | 941.89          | 59.11         |  0.0     | 0.0  | 0.0       | 59.11 | 59.11 | 59.11      | 0.0  |  0.0        |
      | 2  | 31   | 20250610         | 20250410    | 882.78          | 59.11         |  0.0     | 0.0  | 0.0       | 59.11 | 59.11 | 59.11      | 0.0  |  0.0        |
      | 3  | 30   | 20250710         |                  | 823.67          | 59.11         |  0.0     | 0.0  | 0.0       | 59.11 | 31.78 | 31.78      | 0.0  | 27.33       |
      | 4  | 31   | 20250810       |                  | 823.67          | 0.0           | 59.11    | 0.0  | 0.0       | 59.11 |  0.0  |  0.0       | 0.0  | 59.11       |
      | 5  | 31   | 20250910    |                  | 823.67          | 0.0           | 59.11    | 0.0  | 0.0       | 59.11 |  0.0  |  0.0       | 0.0  | 59.11       |
      | 6  | 30   | 20251010      |                  | 797.06          | 26.61         | 32.5     | 0.0  | 0.0       | 59.11 |  0.0  |  0.0       | 0.0  | 59.11       |
      | 7  | 31   | 20251110     |                  | 761.86          | 35.2          | 23.91    | 0.0  | 0.0       | 59.11 |  0.0  |  0.0       | 0.0  | 59.11       |
      | 8  | 30   | 20251210     |                  | 725.61          | 36.25         | 22.86    | 0.0  | 0.0       | 59.11 |  0.0  |  0.0       | 0.0  | 59.11       |
      | 9  | 31   | 20260110      |                  | 688.27          | 37.34         | 21.77    | 0.0  | 0.0       | 59.11 |  0.0  |  0.0       | 0.0  | 59.11       |
      | 10 | 31   | 20260210     |                  | 649.81          | 38.46         | 20.65    | 0.0  | 0.0       | 59.11 |  0.0  |  0.0       | 0.0  | 59.11       |
      | 11 | 28   | 20260310        |                  | 610.19          | 39.62         | 19.49    | 0.0  | 0.0       | 59.11 |  0.0  |  0.0       | 0.0  | 59.11       |
      | 12 | 31   | 20260410        |                  | 569.39          | 40.8          | 18.31    | 0.0  | 0.0       | 59.11 |  0.0  |  0.0       | 0.0  | 59.11       |
      | 13 | 30   | 20260510          |                  | 527.36          | 42.03         | 17.08    | 0.0  | 0.0       | 59.11 |  0.0  |  0.0       | 0.0  | 59.11       |
      | 14 | 31   | 20260610         |                  | 484.07          | 43.29         | 15.82    | 0.0  | 0.0       | 59.11 |  0.0  |  0.0       | 0.0  | 59.11       |
      | 15 | 30   | 20260710         |                  | 439.48          | 44.59         | 14.52    | 0.0  | 0.0       | 59.11 |  0.0  |  0.0       | 0.0  | 59.11       |
      | 16 | 31   | 20260810       |                  | 393.55          | 45.93         | 13.18    | 0.0  | 0.0       | 59.11 |  0.0  |  0.0       | 0.0  | 59.11       |
      | 17 | 31   | 20260910    |                  | 346.25          | 47.3          | 11.81    | 0.0  | 0.0       | 59.11 |  0.0  |  0.0       | 0.0  | 59.11       |
      | 18 | 30   | 20261010      |                  | 297.53          | 48.72         | 10.39    | 0.0  | 0.0       | 59.11 |  0.0  |  0.0       | 0.0  | 59.11       |
      | 19 | 31   | 20261110     |                  | 247.35          | 50.18         |  8.93    | 0.0  | 0.0       | 59.11 |  0.0  |  0.0       | 0.0  | 59.11       |
      | 20 | 30   | 20261210     |                  | 195.66          | 51.69         |  7.42    | 0.0  | 0.0       | 59.11 |  0.0  |  0.0       | 0.0  | 59.11       |
      | 21 | 31   | 20270110      |                  | 142.42          | 53.24         |  5.87    | 0.0  | 0.0       | 59.11 |  0.0  |  0.0       | 0.0  | 59.11       |
      | 22 | 31   | 20270210     |                  |  87.58          | 54.84         |  4.27    | 0.0  | 0.0       | 59.11 |  0.0  |  0.0       | 0.0  | 59.11       |
      | 23 | 28   | 20270310        |                  |  31.1           | 56.48         |  2.63    | 0.0  | 0.0       | 59.11 |  0.0  |  0.0       | 0.0  | 59.11       |
      | 24 | 31   | 20270410        |                  |   0.0           | 31.1          |  0.93    | 0.0  | 0.0       | 32.03 |  0.0  |  0.0       | 0.0  | 32.03       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid    | In advance   | Late | Outstanding |
      | 1001.0        | 390.56   | 0.0  | 0.0       | 1391.56 |  150.0  | 150.0        | 0.0  | 1241.56     |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount  | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20250410    | Disbursement     | 1001.0  | 0.0       | 0.0      | 0.0  | 0.0       | 1001.0       | false    | false    |
      | 20250410    | Repayment        | 150.0   | 150.0     | 0.0      | 0.0  | 0.0       |  851.0       | false    | false    |
      | 20250411    | Accrual          | 1.0     | 0.0       | 1.0      | 0.0  | 0.0       |   0.0        | false    | false    |
      | 20250412    | Accrual          | 1.0     | 0.0       | 1.0      | 0.0  | 0.0       |   0.0        | false    | false    |
    When Customer undo "1"th "Repayment" transaction made on "20250410"
#   --- Loan reschedule: Interest rate modification effective from next day ---
    When Admin creates and approves Loan reschedule with the following data:
      | rescheduleFromDate | submittedOnDate  | adjustedDueDate | graceOnPrincipal | graceOnInterest | extraTerms | newInterestRate |
      | 20250414      | 20250413    |                 |                  |                 |            | 12              |
    When Admin sets the business date to "20250414"
    When Admin runs inline COB job for Loan
    Then Loan Repayment schedule has 24 periods, with the following data for periods:
      | Nr | Days | Date                 | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20250410        |                  | 1001.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 30   | 20250510          |                  | 965.8           | 35.2          | 12.01    | 0.0  | 0.0       | 47.21 | 0.0   | 0.0        | 0.0  | 47.21       |
      | 2  | 31   | 20250610         |                  | 928.25          | 37.55         |  9.66    | 0.0  | 0.0       | 47.21 | 0.0   | 0.0        | 0.0  | 47.21       |
      | 3  | 30   | 20250710         |                  | 890.32          | 37.93         |  9.28    | 0.0  | 0.0       | 47.21 | 0.0   | 0.0        | 0.0  | 47.21       |
      | 4  | 31   | 20250810       |                  | 852.01          | 38.31         |  8.9     | 0.0  | 0.0       | 47.21 | 0.0   | 0.0        | 0.0  | 47.21       |
      | 5  | 31   | 20250910    |                  | 813.32          | 38.69         |  8.52    | 0.0  | 0.0       | 47.21 | 0.0   | 0.0        | 0.0  | 47.21       |
      | 6  | 30   | 20251010      |                  | 774.24          | 39.08         |  8.13    | 0.0  | 0.0       | 47.21 | 0.0   | 0.0        | 0.0  | 47.21       |
      | 7  | 31   | 20251110     |                  | 734.77          | 39.47         |  7.74    | 0.0  | 0.0       | 47.21 | 0.0   | 0.0        | 0.0  | 47.21       |
      | 8  | 30   | 20251210     |                  | 694.91          | 39.86         |  7.35    | 0.0  | 0.0       | 47.21 | 0.0   | 0.0        | 0.0  | 47.21       |
      | 9  | 31   | 20260110      |                  | 654.65          | 40.26         |  6.95    | 0.0  | 0.0       | 47.21 | 0.0   | 0.0        | 0.0  | 47.21       |
      | 10 | 31   | 20260210     |                  | 613.99          | 40.66         |  6.55    | 0.0  | 0.0       | 47.21 | 0.0   | 0.0        | 0.0  | 47.21       |
      | 11 | 28   | 20260310        |                  | 572.92          | 41.07         |  6.14    | 0.0  | 0.0       | 47.21 | 0.0   | 0.0        | 0.0  | 47.21       |
      | 12 | 31   | 20260410        |                  | 531.44          | 41.48         |  5.73    | 0.0  | 0.0       | 47.21 | 0.0   | 0.0        | 0.0  | 47.21       |
      | 13 | 30   | 20260510          |                  | 489.54          | 41.9          |  5.31    | 0.0  | 0.0       | 47.21 | 0.0   | 0.0        | 0.0  | 47.21       |
      | 14 | 31   | 20260610         |                  | 447.23          | 42.31         |  4.9     | 0.0  | 0.0       | 47.21 | 0.0   | 0.0        | 0.0  | 47.21       |
      | 15 | 30   | 20260710         |                  | 404.49          | 42.74         |  4.47    | 0.0  | 0.0       | 47.21 | 0.0   | 0.0        | 0.0  | 47.21       |
      | 16 | 31   | 20260810       |                  | 361.32          | 43.17         |  4.04    | 0.0  | 0.0       | 47.21 | 0.0   | 0.0        | 0.0  | 47.21       |
      | 17 | 31   | 20260910    |                  | 317.72          | 43.6          |  3.61    | 0.0  | 0.0       | 47.21 | 0.0   | 0.0        | 0.0  | 47.21       |
      | 18 | 30   | 20261010      |                  | 273.69          | 44.03         |  3.18    | 0.0  | 0.0       | 47.21 | 0.0   | 0.0        | 0.0  | 47.21       |
      | 19 | 31   | 20261110     |                  | 229.22          | 44.47         |  2.74    | 0.0  | 0.0       | 47.21 | 0.0   | 0.0        | 0.0  | 47.21       |
      | 20 | 30   | 20261210     |                  | 184.3           | 44.92         |  2.29    | 0.0  | 0.0       | 47.21 | 0.0   | 0.0        | 0.0  | 47.21       |
      | 21 | 31   | 20270110      |                  | 138.93          | 45.37         |  1.84    | 0.0  | 0.0       | 47.21 | 0.0   | 0.0        | 0.0  | 47.21       |
      | 22 | 31   | 20270210     |                  |  93.11          | 45.82         |  1.39    | 0.0  | 0.0       | 47.21 | 0.0   | 0.0        | 0.0  | 47.21       |
      | 23 | 28   | 20270310        |                  |  46.83          | 46.28         |  0.93    | 0.0  | 0.0       | 47.21 | 0.0   | 0.0        | 0.0  | 47.21       |
      | 24 | 31   | 20270410        |                  |   0.0           | 46.83         |  0.47    | 0.0  | 0.0       | 47.3  | 0.0   | 0.0        | 0.0  | 47.3        |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid | In advance | Late | Outstanding |
      | 1001.0        | 132.13   | 0.0  | 0.0       | 1133.13 |  0.0 | 0.0        | 0.0  | 1133.13     |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount  | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20250410    | Disbursement     | 1001.0  | 0.0       | 0.0      | 0.0  | 0.0       | 1001.0       | false    | false    |
      | 20250410    | Repayment        | 150.0   | 150.0     | 0.0      | 0.0  | 0.0       |  851.0       | true     | false    |
      | 20250411    | Accrual          | 1.0     | 0.0       | 1.0      | 0.0  | 0.0       |   0.0        | false    | false    |
      | 20250412    | Accrual          | 1.0     | 0.0       | 1.0      | 0.0  | 0.0       |   0.0        | false    | false    |
      | 20250413    | Accrual          | 1.0     | 0.0       | 1.0      | 0.0  | 0.0       |   0.0        | false    | false    |
    And Customer makes "AUTOPAY" repayment on "20250414" with 120 EUR transaction amount
    Then Loan Repayment schedule has 24 periods, with the following data for periods:
      | Nr | Days | Date                 | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20250410        |                  | 1001.0          |               |          | 0.0  |           | 0.0   |  0.0  |            |      |             |
      | 1  | 30   | 20250510          | 20250414    | 957.13          | 43.87         |  3.34    | 0.0  | 0.0       | 47.21 | 47.21 | 47.21      | 0.0  |  0.0        |
      | 2  | 31   | 20250610         | 20250414    | 909.92          | 47.21         |  0.0     | 0.0  | 0.0       | 47.21 | 47.21 | 47.21      | 0.0  |  0.0        |
      | 3  | 30   | 20250710         |                  | 862.71          | 47.21         |  0.0     | 0.0  | 0.0       | 47.21 | 25.58 | 25.58      | 0.0  | 21.63       |
      | 4  | 31   | 20250810       |                  | 849.47          | 13.24         | 33.97    | 0.0  | 0.0       | 47.21 |  0.0  |  0.0       | 0.0  | 47.21       |
      | 5  | 31   | 20250910    |                  | 810.75          | 38.72         |  8.49    | 0.0  | 0.0       | 47.21 |  0.0  |  0.0       | 0.0  | 47.21       |
      | 6  | 30   | 20251010      |                  | 771.65          | 39.1          |  8.11    | 0.0  | 0.0       | 47.21 |  0.0  |  0.0       | 0.0  | 47.21       |
      | 7  | 31   | 20251110     |                  | 732.16          | 39.49         |  7.72    | 0.0  | 0.0       | 47.21 |  0.0  |  0.0       | 0.0  | 47.21       |
      | 8  | 30   | 20251210     |                  | 692.27          | 39.89         |  7.32    | 0.0  | 0.0       | 47.21 |  0.0  |  0.0       | 0.0  | 47.21       |
      | 9  | 31   | 20260110      |                  | 651.98          | 40.29         |  6.92    | 0.0  | 0.0       | 47.21 |  0.0  |  0.0       | 0.0  | 47.21       |
      | 10 | 31   | 20260210     |                  | 611.29          | 40.69         |  6.52    | 0.0  | 0.0       | 47.21 |  0.0  |  0.0       | 0.0  | 47.21       |
      | 11 | 28   | 20260310        |                  | 570.19          | 41.1          |  6.11    | 0.0  | 0.0       | 47.21 |  0.0  |  0.0       | 0.0  | 47.21       |
      | 12 | 31   | 20260410        |                  | 528.68          | 41.51         |  5.7     | 0.0  | 0.0       | 47.21 |  0.0  |  0.0       | 0.0  | 47.21       |
      | 13 | 30   | 20260510          |                  | 486.76          | 41.92         |  5.29    | 0.0  | 0.0       | 47.21 |  0.0  |  0.0       | 0.0  | 47.21       |
      | 14 | 31   | 20260610         |                  | 444.42          | 42.34         |  4.87    | 0.0  | 0.0       | 47.21 |  0.0  |  0.0       | 0.0  | 47.21       |
      | 15 | 30   | 20260710         |                  | 401.65          | 42.77         |  4.44    | 0.0  | 0.0       | 47.21 |  0.0  |  0.0       | 0.0  | 47.21       |
      | 16 | 31   | 20260810       |                  | 358.46          | 43.19         |  4.02    | 0.0  | 0.0       | 47.21 |  0.0  |  0.0       | 0.0  | 47.21       |
      | 17 | 31   | 20260910    |                  | 314.83          | 43.63         |  3.58    | 0.0  | 0.0       | 47.21 |  0.0  |  0.0       | 0.0  | 47.21       |
      | 18 | 30   | 20261010      |                  | 270.77          | 44.06         |  3.15    | 0.0  | 0.0       | 47.21 |  0.0  |  0.0       | 0.0  | 47.21       |
      | 19 | 31   | 20261110     |                  | 226.27          | 44.5          |  2.71    | 0.0  | 0.0       | 47.21 |  0.0  |  0.0       | 0.0  | 47.21       |
      | 20 | 30   | 20261210     |                  | 181.32          | 44.95         |  2.26    | 0.0  | 0.0       | 47.21 |  0.0  |  0.0       | 0.0  | 47.21       |
      | 21 | 31   | 20270110      |                  | 135.92          | 45.4          |  1.81    | 0.0  | 0.0       | 47.21 |  0.0  |  0.0       | 0.0  | 47.21       |
      | 22 | 31   | 20270210     |                  |  90.07          | 45.85         |  1.36    | 0.0  | 0.0       | 47.21 |  0.0  |  0.0       | 0.0  | 47.21       |
      | 23 | 28   | 20270310        |                  |  43.76          | 46.31         |  0.9     | 0.0  | 0.0       | 47.21 |  0.0  |  0.0       | 0.0  | 47.21       |
      | 24 | 31   | 20270410        |                  |   0.0           | 43.76         |  0.44    | 0.0  | 0.0       | 44.2  |  0.0  |  0.0       | 0.0  | 44.2        |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid    | In advance   | Late | Outstanding |
      | 1001.0        | 129.03   | 0.0  | 0.0       | 1130.03 |  120.0  | 120.0        | 0.0  | 1010.03     |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount  | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20250410    | Disbursement     | 1001.0  | 0.0       | 0.0      | 0.0  | 0.0       | 1001.0       | false    | false    |
      | 20250410    | Repayment        | 150.0   | 150.0     | 0.0      | 0.0  | 0.0       |  851.0       | true     | false    |
      | 20250411    | Accrual          | 1.0     | 0.0       | 1.0      | 0.0  | 0.0       |   0.0        | false    | false    |
      | 20250412    | Accrual          | 1.0     | 0.0       | 1.0      | 0.0  | 0.0       |   0.0        | false    | false    |
      | 20250413    | Accrual          | 1.0     | 0.0       | 1.0      | 0.0  | 0.0       |   0.0        | false    | false    |
      | 20250414    | Repayment        | 120.0   | 116.66    | 3.34     | 0.0  | 0.0       | 884.34       | false    | false    |
    When Admin sets the business date to "20250415"
    When Admin runs inline COB job for Loan
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount  | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20250410    | Disbursement     | 1001.0  | 0.0       | 0.0      | 0.0  | 0.0       | 1001.0       | false    | false    |
      | 20250410    | Repayment        | 150.0   | 150.0     | 0.0      | 0.0  | 0.0       |  851.0       | true     | false    |
      | 20250411    | Accrual          | 1.0     | 0.0       | 1.0      | 0.0  | 0.0       |   0.0        | false    | false    |
      | 20250412    | Accrual          | 1.0     | 0.0       | 1.0      | 0.0  | 0.0       |   0.0        | false    | false    |
      | 20250413    | Accrual          | 1.0     | 0.0       | 1.0      | 0.0  | 0.0       |   0.0        | false    | false    |
      | 20250414    | Repayment        | 120.0   | 116.66    | 3.34     | 0.0  | 0.0       | 884.34       | false    | false    |
      | 20250414    | Accrual          | 0.34    | 0.0       | 0.34     | 0.0  | 0.0       |   0.0        | false    | false    |

  @TestRailId:C3616
  Scenario: Verify early repayment on high interest loan works properly and align the interest properly with charge trans and charge-off transactions - UC4
    When Admin sets the business date to "20250410"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                   | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_CUSTOM_PMT_ALLOC_PROGRESSIVE_LOAN_SCHEDULE_HORIZONTAL | 20250410     | 1001           | 33                     | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 24                | MONTHS                | 1              | MONTHS                 | 24                 | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20250410" with "1001" amount and expected disbursement date on "20250410"
    When Admin successfully disburse the loan on "20250410" with "1001" EUR transaction amount
    Then Loan Repayment schedule has 24 periods, with the following data for periods:
      | Nr | Days | Date                 | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20250410        |                  | 1001.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 30   | 20250510          |                  | 971.0           | 30.0          | 27.53    | 0.0  | 0.0       | 57.53 | 0.0   | 0.0        | 0.0  | 57.53       |
      | 2  | 31   | 20250610         |                  | 940.17          | 30.83         | 26.7     | 0.0  | 0.0       | 57.53 | 0.0   | 0.0        | 0.0  | 57.53       |
      | 3  | 30   | 20250710         |                  | 908.49          | 31.68         | 25.85    | 0.0  | 0.0       | 57.53 | 0.0   | 0.0        | 0.0  | 57.53       |
      | 4  | 31   | 20250810       |                  | 875.94          | 32.55         | 24.98    | 0.0  | 0.0       | 57.53 | 0.0   | 0.0        | 0.0  | 57.53       |
      | 5  | 31   | 20250910    |                  | 842.5           | 33.44         | 24.09    | 0.0  | 0.0       | 57.53 | 0.0   | 0.0        | 0.0  | 57.53       |
      | 6  | 30   | 20251010      |                  | 808.14          | 34.36         | 23.17    | 0.0  | 0.0       | 57.53 | 0.0   | 0.0        | 0.0  | 57.53       |
      | 7  | 31   | 20251110     |                  | 772.83          | 35.31         | 22.22    | 0.0  | 0.0       | 57.53 | 0.0   | 0.0        | 0.0  | 57.53       |
      | 8  | 30   | 20251210     |                  | 736.55          | 36.28         | 21.25    | 0.0  | 0.0       | 57.53 | 0.0   | 0.0        | 0.0  | 57.53       |
      | 9  | 31   | 20260110      |                  | 699.28          | 37.27         | 20.26    | 0.0  | 0.0       | 57.53 | 0.0   | 0.0        | 0.0  | 57.53       |
      | 10 | 31   | 20260210     |                  | 660.98          | 38.3          | 19.23    | 0.0  | 0.0       | 57.53 | 0.0   | 0.0        | 0.0  | 57.53       |
      | 11 | 28   | 20260310        |                  | 621.63          | 39.35         | 18.18    | 0.0  | 0.0       | 57.53 | 0.0   | 0.0        | 0.0  | 57.53       |
      | 12 | 31   | 20260410        |                  | 581.19          | 40.44         | 17.09    | 0.0  | 0.0       | 57.53 | 0.0   | 0.0        | 0.0  | 57.53       |
      | 13 | 30   | 20260510          |                  | 539.64          | 41.55         | 15.98    | 0.0  | 0.0       | 57.53 | 0.0   | 0.0        | 0.0  | 57.53       |
      | 14 | 31   | 20260610         |                  | 496.95          | 42.69         | 14.84    | 0.0  | 0.0       | 57.53 | 0.0   | 0.0        | 0.0  | 57.53       |
      | 15 | 30   | 20260710         |                  | 453.09          | 43.86         | 13.67    | 0.0  | 0.0       | 57.53 | 0.0   | 0.0        | 0.0  | 57.53       |
      | 16 | 31   | 20260810       |                  | 408.02          | 45.07         | 12.46    | 0.0  | 0.0       | 57.53 | 0.0   | 0.0        | 0.0  | 57.53       |
      | 17 | 31   | 20260910    |                  | 361.71          | 46.31         | 11.22    | 0.0  | 0.0       | 57.53 | 0.0   | 0.0        | 0.0  | 57.53       |
      | 18 | 30   | 20261010      |                  | 314.13          | 47.58         |  9.95    | 0.0  | 0.0       | 57.53 | 0.0   | 0.0        | 0.0  | 57.53       |
      | 19 | 31   | 20261110     |                  | 265.24          | 48.89         |  8.64    | 0.0  | 0.0       | 57.53 | 0.0   | 0.0        | 0.0  | 57.53       |
      | 20 | 30   | 20261210     |                  | 215.0           | 50.24         |  7.29    | 0.0  | 0.0       | 57.53 | 0.0   | 0.0        | 0.0  | 57.53       |
      | 21 | 31   | 20270110      |                  | 163.38          | 51.62         |  5.91    | 0.0  | 0.0       | 57.53 | 0.0   | 0.0        | 0.0  | 57.53       |
      | 22 | 31   | 20270210     |                  | 110.34          | 53.04         |  4.49    | 0.0  | 0.0       | 57.53 | 0.0   | 0.0        | 0.0  | 57.53       |
      | 23 | 28   | 20270310        |                  |  55.84          | 54.5          |  3.03    | 0.0  | 0.0       | 57.53 | 0.0   | 0.0        | 0.0  | 57.53       |
      | 24 | 31   | 20270410        |                  |   0.0           | 55.84         |  1.54    | 0.0  | 0.0       | 57.38 | 0.0   | 0.0        | 0.0  | 57.38       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid | In advance | Late | Outstanding |
      | 1001.0        | 379.57    | 0.0  | 0.0      | 1380.57 |  0.0 | 0.0        | 0.0  | 1380.57     |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount  | Principal | Interest | Fees | Penalties | Loan Balance  | Reverted | Replayed |
      | 20250410    | Disbursement     | 1001.0  | 0.0       | 0.0      | 0.0  | 0.0       | 1001.0        | false    | false    |
    When Admin runs inline COB job for Loan
    When Admin sets the business date to "20250413"
    When Admin runs inline COB job for Loan
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount  | Principal | Interest | Fees | Penalties | Loan Balance  | Reverted | Replayed |
      | 20250410    | Disbursement     | 1001.0  | 0.0       | 0.0      | 0.0  | 0.0       | 1001.0        | false    | false    |
      | 20250411    | Accrual          | 0.92    | 0.0       | 0.92     | 0.0  | 0.0       |   0.0         | false    | false    |
      | 20250412    | Accrual          | 0.92    | 0.0       | 0.92     | 0.0  | 0.0       |   0.0         | false    | false    |
    And Admin adds "LOAN_NSF_FEE" due date charge with "20250413" due date and 115 EUR transaction amount
    And Admin waives due date charge
    And Loan Charges tab has the following data:
      | Name    | isPenalty | Payment due at     | Due as of     | Calculation type | Due   | Paid | Waived | Outstanding |
      | NSF fee | true      | Specified due date | 20250413 | Flat             | 115.0 | 0.0  | 115.0  | 0.0         |
    And Admin does charge-off the loan on "20250413"
    Then Loan Repayment schedule has 24 periods, with the following data for periods:
      | Nr | Days | Date                 | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      |    |      | 20250410        |                  | 1001.0          |               |          | 0.0  |           | 0.0    | 0.0   |            |      |             |
      | 1  | 30   | 20250510          |                  | 971.0           | 30.0          | 27.53    | 0.0  | 115.0     | 172.53 | 0.0   | 0.0        | 0.0  | 57.53       |
      | 2  | 31   | 20250610         |                  | 940.17          | 30.83         | 26.7     | 0.0  | 0.0       | 57.53  | 0.0   | 0.0        | 0.0  | 57.53       |
      | 3  | 30   | 20250710         |                  | 908.49          | 31.68         | 25.85    | 0.0  | 0.0       | 57.53  | 0.0   | 0.0        | 0.0  | 57.53       |
      | 4  | 31   | 20250810       |                  | 875.94          | 32.55         | 24.98    | 0.0  | 0.0       | 57.53  | 0.0   | 0.0        | 0.0  | 57.53       |
      | 5  | 31   | 20250910    |                  | 842.5           | 33.44         | 24.09    | 0.0  | 0.0       | 57.53  | 0.0   | 0.0        | 0.0  | 57.53       |
      | 6  | 30   | 20251010      |                  | 808.14          | 34.36         | 23.17    | 0.0  | 0.0       | 57.53  | 0.0   | 0.0        | 0.0  | 57.53       |
      | 7  | 31   | 20251110     |                  | 772.83          | 35.31         | 22.22    | 0.0  | 0.0       | 57.53  | 0.0   | 0.0        | 0.0  | 57.53       |
      | 8  | 30   | 20251210     |                  | 736.55          | 36.28         | 21.25    | 0.0  | 0.0       | 57.53  | 0.0   | 0.0        | 0.0  | 57.53       |
      | 9  | 31   | 20260110      |                  | 699.28          | 37.27         | 20.26    | 0.0  | 0.0       | 57.53  | 0.0   | 0.0        | 0.0  | 57.53       |
      | 10 | 31   | 20260210     |                  | 660.98          | 38.3          | 19.23    | 0.0  | 0.0       | 57.53  | 0.0   | 0.0        | 0.0  | 57.53       |
      | 11 | 28   | 20260310        |                  | 621.63          | 39.35         | 18.18    | 0.0  | 0.0       | 57.53  | 0.0   | 0.0        | 0.0  | 57.53       |
      | 12 | 31   | 20260410        |                  | 581.19          | 40.44         | 17.09    | 0.0  | 0.0       | 57.53  | 0.0   | 0.0        | 0.0  | 57.53       |
      | 13 | 30   | 20260510          |                  | 539.64          | 41.55         | 15.98    | 0.0  | 0.0       | 57.53  | 0.0   | 0.0        | 0.0  | 57.53       |
      | 14 | 31   | 20260610         |                  | 496.95          | 42.69         | 14.84    | 0.0  | 0.0       | 57.53  | 0.0   | 0.0        | 0.0  | 57.53       |
      | 15 | 30   | 20260710         |                  | 453.09          | 43.86         | 13.67    | 0.0  | 0.0       | 57.53  | 0.0   | 0.0        | 0.0  | 57.53       |
      | 16 | 31   | 20260810       |                  | 408.02          | 45.07         | 12.46    | 0.0  | 0.0       | 57.53  | 0.0   | 0.0        | 0.0  | 57.53       |
      | 17 | 31   | 20260910    |                  | 361.71          | 46.31         | 11.22    | 0.0  | 0.0       | 57.53  | 0.0   | 0.0        | 0.0  | 57.53       |
      | 18 | 30   | 20261010      |                  | 314.13          | 47.58         |  9.95    | 0.0  | 0.0       | 57.53  | 0.0   | 0.0        | 0.0  | 57.53       |
      | 19 | 31   | 20261110     |                  | 265.24          | 48.89         |  8.64    | 0.0  | 0.0       | 57.53  | 0.0   | 0.0        | 0.0  | 57.53       |
      | 20 | 30   | 20261210     |                  | 215.0           | 50.24         |  7.29    | 0.0  | 0.0       | 57.53  | 0.0   | 0.0        | 0.0  | 57.53       |
      | 21 | 31   | 20270110      |                  | 163.38          | 51.62         |  5.91    | 0.0  | 0.0       | 57.53  | 0.0   | 0.0        | 0.0  | 57.53       |
      | 22 | 31   | 20270210     |                  | 110.34          | 53.04         |  4.49    | 0.0  | 0.0       | 57.53  | 0.0   | 0.0        | 0.0  | 57.53       |
      | 23 | 28   | 20270310        |                  |  55.84          | 54.5          |  3.03    | 0.0  | 0.0       | 57.53  | 0.0   | 0.0        | 0.0  | 57.53       |
      | 24 | 31   | 20270410        |                  |   0.0           | 55.84         |  1.54    | 0.0  | 0.0       | 57.38  | 0.0   | 0.0        | 0.0  | 57.38       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid | In advance | Late | Outstanding |
      | 1001.0        | 379.57   | 0.0  | 115.0     | 1495.57 | 0.0  | 0.0        | 0.0  | 1380.57     |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type   | Amount  | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20250410    | Disbursement       | 1001.0  | 0.0       | 0.0      | 0.0  | 0.0       | 1001.0       | false    | false    |
      | 20250411    | Accrual            | 0.92    | 0.0       | 0.92     | 0.0  | 0.0       |   0.0        | false    | false    |
      | 20250412    | Accrual            | 0.92    | 0.0       | 0.92     | 0.0  | 0.0       |   0.0        | false    | false    |
      | 20250413    | Waive loan charges | 115.0   | 0.0       | 0.0      | 0.0  | 0.0       | 1001.0       | false    | false    |
      | 20250413    | Accrual            | 0.91    | 0.0       | 0.91     | 0.0  | 0.0       |   0.0        | false    | false    |
      | 20250413    | Charge-off         | 1380.57 | 1001.0    | 379.57   | 0.0  | 0.0       |   0.0        | false    | false    |
    When Admin sets the business date to "20250414"
    When Admin runs inline COB job for Loan
    And Customer makes "AUTOPAY" repayment on "20250412" with 250 EUR transaction amount
    Then Loan Repayment schedule has 24 periods, with the following data for periods:
      | Nr | Days | Date                 | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      |    |      | 20250410        |                  | 1001.0          |               |          | 0.0  |           | 0.0    | 0.0   |            |      |             |
      | 1  | 30   | 20250510          | 20250412    | 945.31          | 55.69         |  1.84    | 0.0  | 115.0     | 172.53 | 57.53 | 57.53      | 0.0  |  0.0        |
      | 2  | 31   | 20250610         | 20250412    | 887.78          | 57.53         |  0.0     | 0.0  | 0.0       | 57.53  | 57.53 | 57.53      | 0.0  |  0.0        |
      | 3  | 30   | 20250710         | 20250412    | 830.25          | 57.53         |  0.0     | 0.0  | 0.0       | 57.53  | 57.53 | 57.53      | 0.0  |  0.0        |
      | 4  | 31   | 20250810       | 20250412    | 772.72          | 57.53         |  0.0     | 0.0  | 0.0       | 57.53  | 57.53 | 57.53      | 0.0  |  0.0        |
      | 5  | 31   | 20250910    |                  | 715.19          | 57.53         |  0.0     | 0.0  | 0.0       | 57.53  | 19.88 | 19.88      | 0.0  | 37.65       |
      | 6  | 30   | 20251010      |                  | 715.19          |  0.0          |  57.53   | 0.0  | 0.0       | 57.53  | 0.0   | 0.0        | 0.0  | 57.53       |
      | 7  | 31   | 20251110     |                  | 715.19          |  0.0          |  57.53   | 0.0  | 0.0       | 57.53  | 0.0   | 0.0        | 0.0  | 57.53       |
      | 8  | 30   | 20251210     |                  | 703.73          | 11.46         |  46.07   | 0.0  | 0.0       | 57.53  | 0.0   | 0.0        | 0.0  | 57.53       |
      | 9  | 31   | 20260110      |                  | 665.55          | 38.18         |  19.35   | 0.0  | 0.0       | 57.53  | 0.0   | 0.0        | 0.0  | 57.53       |
      | 10 | 31   | 20260210     |                  | 626.32          | 39.23         |  18.3    | 0.0  | 0.0       | 57.53  | 0.0   | 0.0        | 0.0  | 57.53       |
      | 11 | 28   | 20260310        |                  | 586.01          | 40.31         |  17.22   | 0.0  | 0.0       | 57.53  | 0.0   | 0.0        | 0.0  | 57.53       |
      | 12 | 31   | 20260410        |                  | 544.6           | 41.41         |  16.12   | 0.0  | 0.0       | 57.53  | 0.0   | 0.0        | 0.0  | 57.53       |
      | 13 | 30   | 20260510          |                  | 502.05          | 42.55         |  14.98   | 0.0  | 0.0       | 57.53  | 0.0   | 0.0        | 0.0  | 57.53       |
      | 14 | 31   | 20260610         |                  | 458.33          | 43.72         |  13.81   | 0.0  | 0.0       | 57.53  | 0.0   | 0.0        | 0.0  | 57.53       |
      | 15 | 30   | 20260710         |                  | 413.4           | 44.93         |  12.6    | 0.0  | 0.0       | 57.53  | 0.0   | 0.0        | 0.0  | 57.53       |
      | 16 | 31   | 20260810       |                  | 367.24          | 46.16         |  11.37   | 0.0  | 0.0       | 57.53  | 0.0   | 0.0        | 0.0  | 57.53       |
      | 17 | 31   | 20260910    |                  | 319.81          | 47.43         |  10.1    | 0.0  | 0.0       | 57.53  | 0.0   | 0.0        | 0.0  | 57.53       |
      | 18 | 30   | 20261010      |                  | 271.07          | 48.74         |   8.79   | 0.0  | 0.0       | 57.53  | 0.0   | 0.0        | 0.0  | 57.53       |
      | 19 | 31   | 20261110     |                  | 220.99          | 50.08         |   7.45   | 0.0  | 0.0       | 57.53  | 0.0   | 0.0        | 0.0  | 57.53       |
      | 20 | 30   | 20261210     |                  | 169.54          | 51.45         |   6.08   | 0.0  | 0.0       | 57.53  | 0.0   | 0.0        | 0.0  | 57.53       |
      | 21 | 31   | 20270110      |                  | 116.67          | 52.87         |   4.66   | 0.0  | 0.0       | 57.53  | 0.0   | 0.0        | 0.0  | 57.53       |
      | 22 | 31   | 20270210     |                  |  62.35          | 54.32         |   3.21   | 0.0  | 0.0       | 57.53  | 0.0   | 0.0        | 0.0  | 57.53       |
      | 23 | 28   | 20270310        |                  |   6.53          | 55.82         |   1.71   | 0.0  | 0.0       | 57.53  | 0.0   | 0.0        | 0.0  | 57.53       |
      | 24 | 31   | 20270410        |                  |   0.0           |  6.53         |   0.18   | 0.0  | 0.0       |  6.71  | 0.0   | 0.0        | 0.0  |  6.71        |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid  | In advance | Late | Outstanding |
      | 1001.0        | 328.9    | 0.0  | 115.0     | 1444.9  | 250.0 | 250.0      | 0.0  | 1079.9      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type   | Amount  | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20250410    | Disbursement       | 1001.0  | 0.0       | 0.0      | 0.0  | 0.0       | 1001.0       | false    | false    |
      | 20250411    | Accrual            | 0.92    | 0.0       | 0.92     | 0.0  | 0.0       |   0.0        | false    | false    |
      | 20250412    | Accrual            | 0.92    | 0.0       | 0.92     | 0.0  | 0.0       |   0.0        | false    | false    |
      | 20250412    | Repayment          | 250.0   | 248.16    | 1.84     | 0.0  | 0.0       |  752.84      | false    | false    |
      | 20250413    | Waive loan charges | 115.0   | 0.0       | 0.0      | 0.0  | 0.0       |  752.84      | false    | false    |
      | 20250413    | Accrual            | 0.91    | 0.0       | 0.91     | 0.0  | 0.0       |   0.0        | false    | false    |
      | 20250413    | Accrual Adjustment | 0.22    | 0.0       | 0.22     | 0.0  | 0.0       |   0.0        | false    | false    |
      | 20250413    | Charge-off         | 1079.9  | 752.84    | 327.06   | 0.0  | 0.0       |   0.0        | false    | true     |

  @TestRailId:C3617
  Scenario: Verify early repayment on high interest loan works properly and align the interest properly with MIR and no interest recalculation - UC5
    When Admin sets the business date to "20250410"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                  | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_EMI_360_ACTUAL  | 20250410     | 1001           | 40                     | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 24                | MONTHS                | 1              | MONTHS                 | 24                 | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20250410" with "1001" amount and expected disbursement date on "20250410"
    When Admin successfully disburse the loan on "20250410" with "1001" EUR transaction amount
    Then Loan Repayment schedule has 24 periods, with the following data for periods:
      | Nr | Days | Date                 | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20250410        |                  | 1001.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 30   | 20250510          |                  | 972.79          | 28.21         | 33.37    | 0.0  | 0.0       | 61.58 | 0.0   | 0.0        | 0.0  | 61.58       |
      | 2  | 31   | 20250610         |                  | 944.72          | 28.07         | 33.51    | 0.0  | 0.0       | 61.58 | 0.0   | 0.0        | 0.0  | 61.58       |
      | 3  | 30   | 20250710         |                  | 914.63          | 30.09         | 31.49    | 0.0  | 0.0       | 61.58 | 0.0   | 0.0        | 0.0  | 61.58       |
      | 4  | 31   | 20250810       |                  | 884.55          | 30.08         | 31.5     | 0.0  | 0.0       | 61.58 | 0.0   | 0.0        | 0.0  | 61.58       |
      | 5  | 31   | 20250910    |                  | 853.44          | 31.11         | 30.47    | 0.0  | 0.0       | 61.58 | 0.0   | 0.0        | 0.0  | 61.58       |
      | 6  | 30   | 20251010      |                  | 820.31          | 33.13         | 28.45    | 0.0  | 0.0       | 61.58 | 0.0   | 0.0        | 0.0  | 61.58       |
      | 7  | 31   | 20251110     |                  | 786.99          | 33.32         | 28.26    | 0.0  | 0.0       | 61.58 | 0.0   | 0.0        | 0.0  | 61.58       |
      | 8  | 30   | 20251210     |                  | 751.64          | 35.35         | 26.23    | 0.0  | 0.0       | 61.58 | 0.0   | 0.0        | 0.0  | 61.58       |
      | 9  | 31   | 20260110      |                  | 715.95          | 35.69         | 25.89    | 0.0  | 0.0       | 61.58 | 0.0   | 0.0        | 0.0  | 61.58       |
      | 10 | 31   | 20260210     |                  | 679.03          | 36.92         | 24.66    | 0.0  | 0.0       | 61.58 | 0.0   | 0.0        | 0.0  | 61.58       |
      | 11 | 28   | 20260310        |                  | 638.58          | 40.45         | 21.13    | 0.0  | 0.0       | 61.58 | 0.0   | 0.0        | 0.0  | 61.58       |
      | 12 | 31   | 20260410        |                  | 599.0           | 39.58         | 22.0     | 0.0  | 0.0       | 61.58 | 0.0   | 0.0        | 0.0  | 61.58       |
      | 13 | 30   | 20260510          |                  | 557.39          | 41.61         | 19.97    | 0.0  | 0.0       | 61.58 | 0.0   | 0.0        | 0.0  | 61.58       |
      | 14 | 31   | 20260610         |                  | 515.01          | 42.38         | 19.2     | 0.0  | 0.0       | 61.58 | 0.0   | 0.0        | 0.0  | 61.58       |
      | 15 | 30   | 20260710         |                  | 470.6           | 44.41         | 17.17    | 0.0  | 0.0       | 61.58 | 0.0   | 0.0        | 0.0  | 61.58       |
      | 16 | 31   | 20260810       |                  | 425.23          | 45.37         | 16.21    | 0.0  | 0.0       | 61.58 | 0.0   | 0.0        | 0.0  | 61.58       |
      | 17 | 31   | 20260910    |                  | 378.3           | 46.93         | 14.65    | 0.0  | 0.0       | 61.58 | 0.0   | 0.0        | 0.0  | 61.58       |
      | 18 | 30   | 20261010      |                  | 329.33          | 48.97         | 12.61    | 0.0  | 0.0       | 61.58 | 0.0   | 0.0        | 0.0  | 61.58       |
      | 19 | 31   | 20261110     |                  | 279.09          | 50.24         | 11.34    | 0.0  | 0.0       | 61.58 | 0.0   | 0.0        | 0.0  | 61.58       |
      | 20 | 30   | 20261210     |                  | 226.81          | 52.28         |  9.3     | 0.0  | 0.0       | 61.58 | 0.0   | 0.0        | 0.0  | 61.58       |
      | 21 | 31   | 20270110      |                  | 173.04          | 53.77         |  7.81    | 0.0  | 0.0       | 61.58 | 0.0   | 0.0        | 0.0  | 61.58       |
      | 22 | 31   | 20270210     |                  | 117.42          | 55.62         |  5.96    | 0.0  | 0.0       | 61.58 | 0.0   | 0.0        | 0.0  | 61.58       |
      | 23 | 28   | 20270310        |                  |  59.49          | 57.93         |  3.65    | 0.0  | 0.0       | 61.58 | 0.0   | 0.0        | 0.0  | 61.58       |
      | 24 | 31   | 20270410        |                  |   0.0           | 59.49         |  2.05    | 0.0  | 0.0       | 61.54 | 0.0   | 0.0        | 0.0  | 61.54       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid | In advance | Late | Outstanding |
      | 1001.0        | 476.88    | 0.0  | 0.0      | 1477.88 |  0.0 | 0.0        | 0.0  | 1477.88    |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount  | Principal | Interest | Fees | Penalties | Loan Balance  | Reverted | Replayed |
      | 20250410    | Disbursement     | 1001.0  | 0.0       | 0.0      | 0.0  | 0.0       | 1001.0        | false    | false    |
    When Admin runs inline COB job for Loan
    When Admin sets the business date to "20250413"
    When Admin runs inline COB job for Loan
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount  | Principal | Interest | Fees | Penalties | Loan Balance  | Reverted | Replayed |
      | 20250410    | Disbursement     | 1001.0  | 0.0       | 0.0      | 0.0  | 0.0       | 1001.0        | false    | false    |
      | 20250411    | Accrual          | 1.11    | 0.0       | 1.11     | 0.0  | 0.0       |   0.0         | false    | false    |
      | 20250412    | Accrual          | 1.11    | 0.0       | 1.11     | 0.0  | 0.0       |   0.0         | false    | false    |
    And Customer makes "AUTOPAY" repayment on "20250413" with 300 EUR transaction amount
    Then Loan Repayment schedule has 24 periods, with the following data for periods:
      | Nr | Days | Date                 | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20250410        |                  | 1001.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 30   | 20250510          | 20250413    | 972.79          | 28.21         | 33.37    | 0.0  | 0.0       | 61.58 | 61.58 | 61.58      | 0.0  |  0.0        |
      | 2  | 31   | 20250610         | 20250413    | 944.72          | 28.07         | 33.51    | 0.0  | 0.0       | 61.58 | 61.58 | 61.58      | 0.0  |  0.0        |
      | 3  | 30   | 20250710         | 20250413    | 914.63          | 30.09         | 31.49    | 0.0  | 0.0       | 61.58 | 61.58 | 61.58      | 0.0  |  0.0        |
      | 4  | 31   | 20250810       | 20250413    | 884.55          | 30.08         | 31.5     | 0.0  | 0.0       | 61.58 | 61.58 | 61.58      | 0.0  |  0.0        |
      | 5  | 31   | 20250910    |                  | 853.44          | 31.11         | 30.47    | 0.0  | 0.0       | 61.58 | 53.68 | 53.68      | 0.0  |  7.9        |
      | 6  | 30   | 20251010      |                  | 820.31          | 33.13         | 28.45    | 0.0  | 0.0       | 61.58 | 0.0   | 0.0        | 0.0  | 61.58       |
      | 7  | 31   | 20251110     |                  | 786.99          | 33.32         | 28.26    | 0.0  | 0.0       | 61.58 | 0.0   | 0.0        | 0.0  | 61.58       |
      | 8  | 30   | 20251210     |                  | 751.64          | 35.35         | 26.23    | 0.0  | 0.0       | 61.58 | 0.0   | 0.0        | 0.0  | 61.58       |
      | 9  | 31   | 20260110      |                  | 715.95          | 35.69         | 25.89    | 0.0  | 0.0       | 61.58 | 0.0   | 0.0        | 0.0  | 61.58       |
      | 10 | 31   | 20260210     |                  | 679.03          | 36.92         | 24.66    | 0.0  | 0.0       | 61.58 | 0.0   | 0.0        | 0.0  | 61.58       |
      | 11 | 28   | 20260310        |                  | 638.58          | 40.45         | 21.13    | 0.0  | 0.0       | 61.58 | 0.0   | 0.0        | 0.0  | 61.58       |
      | 12 | 31   | 20260410        |                  | 599.0           | 39.58         | 22.0     | 0.0  | 0.0       | 61.58 | 0.0   | 0.0        | 0.0  | 61.58       |
      | 13 | 30   | 20260510          |                  | 557.39          | 41.61         | 19.97    | 0.0  | 0.0       | 61.58 | 0.0   | 0.0        | 0.0  | 61.58       |
      | 14 | 31   | 20260610         |                  | 515.01          | 42.38         | 19.2     | 0.0  | 0.0       | 61.58 | 0.0   | 0.0        | 0.0  | 61.58       |
      | 15 | 30   | 20260710         |                  | 470.6           | 44.41         | 17.17    | 0.0  | 0.0       | 61.58 | 0.0   | 0.0        | 0.0  | 61.58       |
      | 16 | 31   | 20260810       |                  | 425.23          | 45.37         | 16.21    | 0.0  | 0.0       | 61.58 | 0.0   | 0.0        | 0.0  | 61.58       |
      | 17 | 31   | 20260910    |                  | 378.3           | 46.93         | 14.65    | 0.0  | 0.0       | 61.58 | 0.0   | 0.0        | 0.0  | 61.58       |
      | 18 | 30   | 20261010      |                  | 329.33          | 48.97         | 12.61    | 0.0  | 0.0       | 61.58 | 0.0   | 0.0        | 0.0  | 61.58       |
      | 19 | 31   | 20261110     |                  | 279.09          | 50.24         | 11.34    | 0.0  | 0.0       | 61.58 | 0.0   | 0.0        | 0.0  | 61.58       |
      | 20 | 30   | 20261210     |                  | 226.81          | 52.28         |  9.3     | 0.0  | 0.0       | 61.58 | 0.0   | 0.0        | 0.0  | 61.58       |
      | 21 | 31   | 20270110      |                  | 173.04          | 53.77         |  7.81    | 0.0  | 0.0       | 61.58 | 0.0   | 0.0        | 0.0  | 61.58       |
      | 22 | 31   | 20270210     |                  | 117.42          | 55.62         |  5.96    | 0.0  | 0.0       | 61.58 | 0.0   | 0.0        | 0.0  | 61.58       |
      | 23 | 28   | 20270310        |                  |  59.49          | 57.93         |  3.65    | 0.0  | 0.0       | 61.58 | 0.0   | 0.0        | 0.0  | 61.58       |
      | 24 | 31   | 20270410        |                  |   0.0           | 59.49         |  2.05    | 0.0  | 0.0       | 61.54 | 0.0   | 0.0        | 0.0  | 61.54       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid  | In advance | Late | Outstanding |
      | 1001.0        | 476.88   | 0.0  | 0.0       | 1477.88 | 300.0 | 300.0      | 0.0  | 1177.88     |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount  | Principal | Interest | Fees | Penalties | Loan Balance  | Reverted | Replayed |
      | 20250410    | Disbursement     | 1001.0  | 0.0       | 0.0      | 0.0  | 0.0       | 1001.0        | false    | false    |
      | 20250411    | Accrual          | 1.11    | 0.0       | 1.11     | 0.0  | 0.0       |   0.0         | false    | false    |
      | 20250412    | Accrual          | 1.11    | 0.0       | 1.11     | 0.0  | 0.0       |   0.0         | false    | false    |
      | 20250413    | Repayment        | 300.0   | 147.56    | 152.44   | 0.0  | 0.0       |  853.44       | false    | false    |
    When Admin sets the business date to "20250414"
    When Admin runs inline COB job for Loan
    When Admin makes "MERCHANT_ISSUED_REFUND" transaction with "AUTOPAY" payment type on "20250414" with 100 EUR transaction amount
    Then Loan Repayment schedule has 24 periods, with the following data for periods:
      | Nr | Days | Date                 | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20250410        |                  | 1001.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 30   | 20250510          | 20250413    | 972.79          | 28.21         | 33.37    | 0.0  | 0.0       | 61.58 | 61.58 | 61.58      | 0.0  |  0.0        |
      | 2  | 31   | 20250610         | 20250413    | 944.72          | 28.07         | 33.51    | 0.0  | 0.0       | 61.58 | 61.58 | 61.58      | 0.0  |  0.0        |
      | 3  | 30   | 20250710         | 20250413    | 914.63          | 30.09         | 31.49    | 0.0  | 0.0       | 61.58 | 61.58 | 61.58      | 0.0  |  0.0        |
      | 4  | 31   | 20250810       | 20250413    | 884.55          | 30.08         | 31.5     | 0.0  | 0.0       | 61.58 | 61.58 | 61.58      | 0.0  |  0.0        |
      | 5  | 31   | 20250910    |                  | 853.44          | 31.11         | 30.47    | 0.0  | 0.0       | 61.58 | 53.93 | 53.93      | 0.0  |  7.65       |
      | 6  | 30   | 20251010      |                  | 820.31          | 33.13         | 28.45    | 0.0  | 0.0       | 61.58 |  5.25 |  5.25      | 0.0  | 56.33       |
      | 7  | 31   | 20251110     |                  | 786.99          | 33.32         | 28.26    | 0.0  | 0.0       | 61.58 |  5.25 |  5.25      | 0.0  | 56.33       |
      | 8  | 30   | 20251210     |                  | 751.64          | 35.35         | 26.23    | 0.0  | 0.0       | 61.58 |  5.25 |  5.25      | 0.0  | 56.33       |
      | 9  | 31   | 20260110      |                  | 715.95          | 35.69         | 25.89    | 0.0  | 0.0       | 61.58 |  5.25 |  5.25      | 0.0  | 56.33       |
      | 10 | 31   | 20260210     |                  | 679.03          | 36.92         | 24.66    | 0.0  | 0.0       | 61.58 |  5.25 |  5.25      | 0.0  | 56.33       |
      | 11 | 28   | 20260310        |                  | 638.58          | 40.45         | 21.13    | 0.0  | 0.0       | 61.58 |  5.25 |  5.25      | 0.0  | 56.33       |
      | 12 | 31   | 20260410        |                  | 599.0           | 39.58         | 22.0     | 0.0  | 0.0       | 61.58 |  5.25 |  5.25      | 0.0  | 56.33       |
      | 13 | 30   | 20260510          |                  | 557.39          | 41.61         | 19.97    | 0.0  | 0.0       | 61.58 |  5.25 |  5.25      | 0.0  | 56.33       |
      | 14 | 31   | 20260610         |                  | 515.01          | 42.38         | 19.2     | 0.0  | 0.0       | 61.58 |  5.25 |  5.25      | 0.0  | 56.33       |
      | 15 | 30   | 20260710         |                  | 470.6           | 44.41         | 17.17    | 0.0  | 0.0       | 61.58 |  5.25 |  5.25      | 0.0  | 56.33       |
      | 16 | 31   | 20260810       |                  | 425.23          | 45.37         | 16.21    | 0.0  | 0.0       | 61.58 |  5.25 |  5.25      | 0.0  | 56.33       |
      | 17 | 31   | 20260910    |                  | 378.3           | 46.93         | 14.65    | 0.0  | 0.0       | 61.58 |  5.25 |  5.25      | 0.0  | 56.33       |
      | 18 | 30   | 20261010      |                  | 329.33          | 48.97         | 12.61    | 0.0  | 0.0       | 61.58 |  5.25 |  5.25      | 0.0  | 56.33       |
      | 19 | 31   | 20261110     |                  | 279.09          | 50.24         | 11.34    | 0.0  | 0.0       | 61.58 |  5.25 |  5.25      | 0.0  | 56.33       |
      | 20 | 30   | 20261210     |                  | 226.81          | 52.28         |  9.3     | 0.0  | 0.0       | 61.58 |  5.25 |  5.25      | 0.0  | 56.33       |
      | 21 | 31   | 20270110      |                  | 173.04          | 53.77         |  7.81    | 0.0  | 0.0       | 61.58 |  5.25 |  5.25      | 0.0  | 56.33       |
      | 22 | 31   | 20270210     |                  | 117.42          | 55.62         |  5.96    | 0.0  | 0.0       | 61.58 |  5.25 |  5.25      | 0.0  | 56.33       |
      | 23 | 28   | 20270310        |                  |  59.49          | 57.93         |  3.65    | 0.0  | 0.0       | 61.58 |  5.25 |  5.25      | 0.0  | 56.33       |
      | 24 | 31   | 20270410        |                  |   0.0           | 59.49         |  2.05    | 0.0  | 0.0       | 61.54 |  5.25 |  5.25      | 0.0  | 56.29       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid  | In advance | Late | Outstanding |
      | 1001.0        | 476.88   | 0.0  | 0.0       | 1477.88 | 400.0 | 400.0      | 0.0  | 1077.88     |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type       | Amount  | Principal | Interest | Fees | Penalties | Loan Balance  | Reverted | Replayed |
      | 20250410    | Disbursement           | 1001.0  | 0.0       | 0.0      | 0.0  | 0.0       | 1001.0        | false    | false    |
      | 20250411    | Accrual                | 1.11    | 0.0       | 1.11     | 0.0  | 0.0       |   0.0         | false    | false    |
      | 20250412    | Accrual                | 1.11    | 0.0       | 1.11     | 0.0  | 0.0       |   0.0         | false    | false    |
      | 20250413    | Repayment              | 300.0   | 147.56    | 152.44   | 0.0  | 0.0       |  853.44       | false    | false    |
      | 20250413    | Accrual                | 1.12    | 0.0       | 1.12     | 0.0  | 0.0       |   0.0         | false    | false    |
      | 20250414    | Merchant Issued Refund | 100.0   | 95.0      | 5.0      | 0.0  | 0.0       |  758.44       | false    | false    |

  @TestRailId:C3590
  Scenario: Verify no accrual activity created for approved interest bearing loan
    When Admin sets the business date to "20250603"
    And Admin creates a client with random data
    And Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                           | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_EMI_ACTUAL_ACTUAL_INTEREST_REFUND_INTEREST_RECALCULATION | 20250603      | 200            | 15                     | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 1                 | MONTHS                | 1              | MONTHS                 | 1                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20250603" with "200" amount and expected disbursement date on "20250603"
    And Admin runs inline COB job for Loan
    Then Loan Repayment schedule has 1 periods, with the following data for periods:
      | Nr | Days | Date         | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      |    |      | 20250603 |           | 200.0           |               |          | 0.0  |           | 0.0    |      |            |      | 0.0         |
      | 1  | 30   | 20250703 |           | 0.0             | 200.0         | 2.47     | 0.0  | 0.0       | 202.47 | 0.0  | 0.0        | 0.0  | 202.47      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late  | Outstanding |
      | 200.0         | 2.47     | 0.0  | 0.0       | 202.47 | 0.0   | 0.0        | 0.0   | 202.47      |
    When Admin successfully disburse the loan on "20250603" with "200" EUR transaction amount
    And Admin sets the business date to "20250618"
    And Customer makes "MERCHANT_ISSUED_REFUND" transaction with "AUTOPAY" payment type on "20250618" with 50 EUR transaction amount and self-generated Idempotency key
    Then Loan Repayment schedule has 1 periods, with the following data for periods:
      | Nr | Days | Date         | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      |    |      | 20250603 |           | 200.0           |               |          | 0.0  |           | 0.0    | 0.0   |            |      |             |
      | 1  | 30   | 20250703 |           | 0.0             | 200.0         | 2.16     | 0.0  | 0.0       | 202.16 | 50.31 | 50.31      | 0.0  | 151.85      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late  | Outstanding |
      | 200.0         | 2.16     | 0.0  | 0.0       | 202.16 | 50.31 | 50.31      | 0.0   | 151.85      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type       | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20250603     | Disbursement           | 200.0  | 0.0       | 0.0      | 0.0  | 0.0       | 200.0        | false    |
      | 20250618     | Merchant Issued Refund | 50.0   | 50.0      | 0.0      | 0.0  | 0.0       | 150.0        | false    |
      | 20250618     | Interest Refund        | 0.31   | 0.31      | 0.0      | 0.0  | 0.0       | 149.69       | false    |

  @TestRailId:C3666
  Scenario: Verify the next/last installment payment allocation in case the repayment is before the installment date
    When Admin sets the business date to "20240101"
    When Admin creates a client with random data
    When Admin set "LP2_ADV_CUSTOM_PMT_ALLOC_PROGRESSIVE_LOAN_SCHEDULE_HORIZONTAL" loan product "DEFAULT" transaction type to "NEXT_LAST_INSTALLMENT" future installment allocation rule
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                   | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_CUSTOM_PMT_ALLOC_PROGRESSIVE_LOAN_SCHEDULE_HORIZONTAL | 20240101   | 100            | 7                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 6                 | MONTHS                | 1              | MONTHS                 | 6                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240101" with "100" amount and expected disbursement date on "20240101"
    When Admin successfully disburse the loan on "20240101" with "100" EUR transaction amount
    When Admin sets the business date to "20240115"
    And Customer makes "AUTOPAY" repayment on "20240115" with 10 EUR transaction amount
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20240101  |                 | 100.0           |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 31   | 20240201 |                 | 83.54           | 16.46         | 0.55     | 0.0  | 0.0       | 17.01 | 10.0 | 10.0       | 0.0  | 7.01        |
      | 2  | 29   | 20240301    |                 | 67.02           | 16.52         | 0.49     | 0.0  | 0.0       | 17.01 | 0.0  | 0.0        | 0.0  | 17.01       |
      | 3  | 31   | 20240401    |                 | 50.4            | 16.62         | 0.39     | 0.0  | 0.0       | 17.01 | 0.0  | 0.0        | 0.0  | 17.01       |
      | 4  | 30   | 20240501      |                 | 33.68           | 16.72         | 0.29     | 0.0  | 0.0       | 17.01 | 0.0  | 0.0        | 0.0  | 17.01       |
      | 5  | 31   | 20240601     |                 | 16.87           | 16.81         | 0.2      | 0.0  | 0.0       | 17.01 | 0.0  | 0.0        | 0.0  | 17.01       |
      | 6  | 30   | 20240701     |                 | 0.0             | 16.87         | 0.1      | 0.0  | 0.0       | 16.97 | 0.0  | 0.0        | 0.0  | 16.97       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 100.0         | 2.02     | 0.0  | 0.0       | 102.02 | 10.0 | 10.0       | 0.0  | 92.02       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240115  | Repayment        | 10.0   | 9.74      | 0.26     | 0.0  | 0.0       | 90.26        | false    | false    |
    When Admin sets the business date to "20240215"
    And Customer makes "AUTOPAY" repayment on "20240215" with 30 EUR transaction amount
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101  |                  | 100.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 31   | 20240201 | 20240215 | 83.54           | 16.46         | 0.55     | 0.0  | 0.0       | 17.01 | 17.01 | 10.0       | 7.01 | 0.0         |
      | 2  | 29   | 20240301    | 20240215 | 66.78           | 16.76         | 0.25     | 0.0  | 0.0       | 17.01 | 17.01 | 17.01      | 0.0  | 0.0         |
      | 3  | 31   | 20240401    |                  | 50.31           | 16.47         | 0.54     | 0.0  | 0.0       | 17.01 | 0.0   | 0.0        | 0.0  | 17.01       |
      | 4  | 30   | 20240501      |                  | 33.56           | 16.75         | 0.26     | 0.0  | 0.0       | 17.01 | 0.0   | 0.0        | 0.0  | 17.01       |
      | 5  | 31   | 20240601     |                  | 16.71           | 16.85         | 0.16     | 0.0  | 0.0       | 17.01 | 0.0   | 0.0        | 0.0  | 17.01       |
      | 6  | 30   | 20240701     |                  | 0.0             | 16.71         | 0.06     | 0.0  | 0.0       | 16.77 | 5.98  | 5.98       | 0.0  | 10.79       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 100.0         | 1.82     | 0.0  | 0.0       | 101.82 | 40.0 | 32.99      | 7.01 | 61.82       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240115  | Repayment        | 10.0   | 9.74      | 0.26     | 0.0  | 0.0       | 90.26        | false    | false    |
      | 20240215 | Repayment        | 30.0   | 29.46     | 0.54     | 0.0  | 0.0       | 60.8         | false    | false    |
    When Admin set "LP2_ADV_CUSTOM_PMT_ALLOC_PROGRESSIVE_LOAN_SCHEDULE_HORIZONTAL" loan product "DEFAULT" transaction type to "NEXT_INSTALLMENT" future installment allocation rule

  @TestRailId:C3667
  Scenario: Verify the next/last installment payment allocation in case the repayment is on the installment date, amount should go first to the next installment and only then to the last
    When Admin sets the business date to "20240101"
    When Admin creates a client with random data
    When Admin set "LP2_ADV_CUSTOM_PMT_ALLOC_PROGRESSIVE_LOAN_SCHEDULE_HORIZONTAL" loan product "DEFAULT" transaction type to "NEXT_LAST_INSTALLMENT" future installment allocation rule
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                   | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_CUSTOM_PMT_ALLOC_PROGRESSIVE_LOAN_SCHEDULE_HORIZONTAL | 20240101   | 100            | 7                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 6                 | MONTHS                | 1              | MONTHS                 | 6                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240101" with "100" amount and expected disbursement date on "20240101"
    When Admin successfully disburse the loan on "20240101" with "100" EUR transaction amount
    When Admin sets the business date to "20240201"
    And Customer makes "AUTOPAY" repayment on "20240201" with 40 EUR transaction amount
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101  |                  | 100.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 31   | 20240201 | 20240201 | 83.57           | 16.43         | 0.58     | 0.0  | 0.0       | 17.01 | 17.01 | 0.0        | 0.0  | 0.0         |
      | 2  | 29   | 20240301    | 20240201 | 66.56           | 17.01         | 0.0      | 0.0  | 0.0       | 17.01 | 17.01 | 17.01      | 0.0  | 0.0         |
      | 3  | 31   | 20240401    |                  | 50.25           | 16.31         | 0.7      | 0.0  | 0.0       | 17.01 | 0.0   | 0.0        | 0.0  | 17.01       |
      | 4  | 30   | 20240501      |                  | 33.5            | 16.75         | 0.26     | 0.0  | 0.0       | 17.01 | 0.0   | 0.0        | 0.0  | 17.01       |
      | 5  | 31   | 20240601     |                  | 16.65           | 16.85         | 0.16     | 0.0  | 0.0       | 17.01 | 0.0   | 0.0        | 0.0  | 17.01       |
      | 6  | 30   | 20240701     |                  | 0.0             | 16.65         | 0.06     | 0.0  | 0.0       | 16.71 | 5.98  | 5.98       | 0.0  | 10.73       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 100.0         | 1.76     | 0.0  | 0.0       | 101.76 | 40.0 | 22.99      | 0.0  | 61.76       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240201 | Repayment        | 40.0   | 39.42     | 0.58     | 0.0  | 0.0       | 60.58        | false    | false    |
    When Admin set "LP2_ADV_CUSTOM_PMT_ALLOC_PROGRESSIVE_LOAN_SCHEDULE_HORIZONTAL" loan product "DEFAULT" transaction type to "NEXT_INSTALLMENT" future installment allocation rule

  @TestRailId:C3840
  Scenario: Verify progressive loan repayment reversals with penalty charge and backdated repayment
    When Admin sets the business date to "20241020"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                            | submitted on date | with Principal | ANNUAL interest rate % | interest type | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_NO_INTEREST_RECALCULATION_ALLOCATION_PENALTY_FIRST | 20241020   | 100            | 0                      | FLAT          | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 30                | DAYS                  | 30             | DAYS                   | 1                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20241020" with "100" amount and expected disbursement date on "20241020"
    And Admin successfully disburse the loan on "20241020" with "100" EUR transaction amount
    Then Loan Repayment schedule has 1 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20241020  |           | 100.0           |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 30   | 20241119 |           | 0.0             | 100.0         | 0.0      | 0.0  | 0.0       | 100.0 | 0.0  | 0.0        | 0.0  | 100.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      | 100.0         | 0.0      | 0.0  | 0.0       | 100.0 | 0.0  | 0.0        | 0.0  | 100.0       |
    When Admin sets the business date to "20241022"
    And Customer makes "AUTOPAY" repayment on "20241022" with 100 EUR transaction amount
    Then Loan status will be "CLOSED_OBLIGATIONS_MET"
    Then Loan Repayment schedule has 1 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20241020  |                 | 100.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 30   | 20241119 | 20241022 | 0.0             | 100.0         | 0.0      | 0.0  | 0.0       | 100.0 | 100.0 | 100.0      | 0.0  | 0.0         |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20241020  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        |
      | 20241022  | Repayment        | 100.0  | 100.0     | 0.0      | 0.0  | 0.0       | 0.0          |
    When Admin sets the business date to "20241024"
    And Customer makes a repayment undo on "20241022"
    Then Loan status will be "ACTIVE"
    And Loan has 100 outstanding amount
    Then Loan Repayment schedule has 1 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20241020  |           | 100.0           |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 30   | 20241119 |           | 0.0             | 100.0         | 0.0      | 0.0  | 0.0       | 100.0 | 0.0  | 0.0        | 0.0  | 100.0       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20241020  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20241022  | Repayment        | 100.0  | 100.0     | 0.0      | 0.0  | 0.0       | 0.0          | true     | false     |
    When Admin sets the business date to "20241026"
    And Customer makes "AUTOPAY" repayment on "20241026" with 100 EUR transaction amount
    Then Loan status will be "CLOSED_OBLIGATIONS_MET"
    Then Loan Repayment schedule has 1 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20241020  |                 | 100.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 30   | 20241119 | 20241026 | 0.0             | 100.0         | 0.0      | 0.0  | 0.0       | 100.0 | 100.0 | 100.0      | 0.0  | 0.0         |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20241020  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20241022  | Repayment        | 100.0  | 100.0     | 0.0      | 0.0  | 0.0       | 0.0          | true     | false    |
      | 20241026  | Repayment        | 100.0  | 100.0     | 0.0      | 0.0  | 0.0       | 0.0          | false    | false    |
    When Admin sets the business date to "20241028"
    And Customer makes a repayment undo on "20241026"
    Then Loan status will be "ACTIVE"
    And Loan has 100 outstanding amount
    Then Loan Repayment schedule has 1 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20241020  |           | 100.0           |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 30   | 20241119 |           | 0.0             | 100.0         | 0.0      | 0.0  | 0.0       | 100.0 | 0.0  | 0.0        | 0.0  | 100.0       |
    When Admin adds "LOAN_NSF_FEE" due date charge with "20241028" due date and 10 EUR transaction amount
    Then Loan Repayment schedule has 1 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20241020  |           | 100.0           |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 30   | 20241119 |           | 0.0             | 100.0         | 0.0      | 0.0  | 10.0      | 110.0 | 0.0  | 0.0        | 0.0  | 110.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      | 100.0         | 0.0      | 0.0  | 10.0      | 110.0 | 0.0  | 0.0        | 0.0  | 110.0       |
    And Customer makes "AUTOPAY" repayment on "20241026" with 101 EUR transaction amount
    Then Loan Repayment schedule has 1 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20241020  |           | 100.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 30   | 20241119 |           | 0.0             | 100.0         | 0.0      | 0.0  | 10.0      | 110.0 | 101.0 | 101.0      | 0.0  | 9.0         |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      | 100.0         | 0.0      | 0.0  | 10.0      | 110.0 | 101.0 | 101.0      | 0.0  | 9.0         |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20241020  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20241022  | Repayment        | 100.0  | 100.0     | 0.0      | 0.0  | 0.0       | 0.0          | true     | false    |
      | 20241026  | Repayment        | 100.0  | 100.0     | 0.0      | 0.0  | 0.0       | 0.0          | true     | false    |
      | 20241026  | Repayment        | 101.0  | 100.0     | 0.0      | 0.0  | 1.0       | 0.0          | false    | false    |
    When Customer makes "AUTOPAY" repayment on "20241027" with 9 EUR transaction amount
    Then Loan status will be "CLOSED_OBLIGATIONS_MET"

  @TestRailId:C3841
  Scenario: Verify backdated repayment allocation respects payment order for future dated penalties
    When Admin sets the business date to "20241020"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                            | submitted on date | with Principal | ANNUAL interest rate % | interest type | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_NO_INTEREST_RECALCULATION_ALLOCATION_PENALTY_FIRST | 20241020   | 100            | 0                      | FLAT          | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 30                | DAYS                  | 30             | DAYS                   | 1                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20241020" with "100" amount and expected disbursement date on "20241020"
    And Admin successfully disburse the loan on "20241020" with "100" EUR transaction amount
    Then Loan Repayment schedule has 1 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20241020  |           | 100.0           |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 30   | 20241119 |           | 0.0             | 100.0         | 0.0      | 0.0  | 0.0       | 100.0 | 0.0  | 0.0        | 0.0  | 100.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      | 100.0         | 0.0      | 0.0  | 0.0       | 100.0 | 0.0  | 0.0        | 0.0  | 100.0       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20241020  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        |
  # Step 2: First repayment on 22 October
    When Admin sets the business date to "20241022"
    And Customer makes "AUTOPAY" repayment on "20241022" with 100 EUR transaction amount
    Then Loan status will be "CLOSED_OBLIGATIONS_MET"
    Then Loan Repayment schedule has 1 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20241020  |                 | 100.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 30   | 20241119 | 20241022 | 0.0             | 100.0         | 0.0      | 0.0  | 0.0       | 100.0 | 100.0 | 100.0      | 0.0  | 0.0         |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20241020  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        |
      | 20241022  | Repayment        | 100.0  | 100.0     | 0.0      | 0.0  | 0.0       | 0.0          |
  # Step 3: First repayment reversal on 24 October
    When Admin sets the business date to "20241024"
    And Customer makes a repayment undo on "20241022"
    Then Loan status will be "ACTIVE"
    And Loan has 100 outstanding amount
    Then Loan Repayment schedule has 1 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20241020  |           | 100.0           |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 30   | 20241119 |           | 0.0             | 100.0         | 0.0      | 0.0  | 0.0       | 100.0 | 0.0  | 0.0        | 0.0  | 100.0       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20241020  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    |
      | 20241022  | Repayment        | 100.0  | 100.0     | 0.0      | 0.0  | 0.0       | 0.0          | true     |
  # Step 4: Second repayment on 26 October
    When Admin sets the business date to "20241026"
    And Customer makes "AUTOPAY" repayment on "20241026" with 100 EUR transaction amount
    Then Loan status will be "CLOSED_OBLIGATIONS_MET"
    Then Loan Repayment schedule has 1 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20241020  |                 | 100.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 30   | 20241119 | 20241026 | 0.0             | 100.0         | 0.0      | 0.0  | 0.0       | 100.0 | 100.0 | 100.0      | 0.0  | 0.0         |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20241020  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    |
      | 20241022  | Repayment        | 100.0  | 100.0     | 0.0      | 0.0  | 0.0       | 0.0          | true     |
      | 20241026  | Repayment        | 100.0  | 100.0     | 0.0      | 0.0  | 0.0       | 0.0          | false    |
  # Step 5: Second repayment reversal on 28 October
    When Admin sets the business date to "20241028"
    And Customer makes a repayment undo on "20241026"
    Then Loan status will be "ACTIVE"
    And Loan has 100 outstanding amount
    Then Loan Repayment schedule has 1 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20241020  |           | 100.0           |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 30   | 20241119 |           | 0.0             | 100.0         | 0.0      | 0.0  | 0.0       | 100.0 | 0.0  | 0.0        | 0.0  | 100.0       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20241020  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    |
      | 20241022  | Repayment        | 100.0  | 100.0     | 0.0      | 0.0  | 0.0       | 0.0          | true     |
      | 20241026  | Repayment        | 100.0  | 100.0     | 0.0      | 0.0  | 0.0       | 0.0          | true     |
  # Step 6: Add penalty charge on 28 October
    When Admin adds "LOAN_NSF_FEE" due date charge with "20241028" due date and 10 EUR transaction amount
    Then Loan Repayment schedule has 1 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20241020  |           | 100.0           |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 30   | 20241119 |           | 0.0             | 100.0         | 0.0      | 0.0  | 10.0      | 110.0 | 0.0  | 0.0        | 0.0  | 110.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      | 100.0         | 0.0      | 0.0  | 10.0      | 110.0 | 0.0  | 0.0        | 0.0  | 110.0       |
  # Step 7: Backdated repayment on 26 October (while business date is 28 October)
    And Customer makes "AUTOPAY" repayment on "20241026" with 101 EUR transaction amount
    Then Loan Repayment schedule has 1 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20241020  |           | 100.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 30   | 20241119 |           | 0.0             | 100.0         | 0.0      | 0.0  | 10.0      | 110.0 | 101.0 | 101.0      | 0.0  | 9.0         |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      | 100.0         | 0.0      | 0.0  | 10.0      | 110.0 | 101.0 | 101.0      | 0.0  | 9.0         |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20241020  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    |
      | 20241022  | Repayment        | 100.0  | 100.0     | 0.0      | 0.0  | 0.0       | 0.0          | true     |
      | 20241026  | Repayment        | 100.0  | 100.0     | 0.0      | 0.0  | 0.0       | 0.0          | true     |
      | 20241026  | Repayment        | 101.0  | 100.0     | 0.0      | 0.0  | 1.0       | 0.0          | false    |

  @TestRailId:C4053
  Scenario: Verify repayment reversal after full repayment of principal and fee
    When Admin sets the business date to "20250516"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                   | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_CUSTOM_PMT_ALLOC_PROGRESSIVE_LOAN_SCHEDULE_HORIZONTAL | 20250516       | 186.99         | 11.3043                | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 3                 | MONTHS                | 1              | MONTHS                 | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20250516" with "186.99" amount and expected disbursement date on "20250516"
    When Admin successfully disburse the loan on "20250516" with "186.99" EUR transaction amount
    When Admin sets the business date to "20250816"
    And Customer makes "AUTOPAY" repayment on "20250816" with 192.27 EUR transaction amount
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date           | Paid date      | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late  | Outstanding |
      |    |      | 20250516    |                | 186.99          |               |          | 0.0  |           | 0.0   | 0.0   |            |       |             |
      | 1  | 31   | 20250616   | 20250816 | 125.24          | 61.75         | 1.76     | 0.0  | 0.0       | 63.51 | 63.51 | 0.0        | 63.51 | 0.0         |
      | 2  | 30   | 20250716   | 20250816 | 63.49           | 61.75         | 1.76     | 0.0  | 0.0       | 63.51 | 63.51 | 0.0        | 63.51 | 0.0         |
      | 3  | 31   | 20250816 | 20250816 | 0.0             | 63.49         | 1.76     | 0.0  | 0.0       | 65.25 | 65.25 | 0.0        | 0.0   | 0.0         |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late   | Outstanding |
      | 186.99        | 5.28     | 0.0  | 0.0       | 192.27 | 192.27 | 0.0        | 127.02 | 0.0         |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20250516      | Disbursement     | 186.99 | 0.0       | 0.0      | 0.0  | 0.0       | 186.99       | false    | false    |
      | 20250616     | Accrual Activity | 1.76   | 0.0       | 1.76     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250716     | Accrual Activity | 1.76   | 0.0       | 1.76     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250816   | Repayment        | 192.27 | 186.99    | 5.28     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250816   | Accrual          | 5.28   | 0.0       | 5.28     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250816   | Accrual Activity | 1.76   | 0.0       | 1.76     | 0.0  | 0.0       | 0.0          | false    | false    |
    Then Loan status will be "CLOSED_OBLIGATIONS_MET"
    Then Loan has 0 outstanding amount
    When Admin sets the business date to "20250821"
    And Customer makes a repayment undo on "20250816"
    And Admin adds "LOAN_NSF_FEE" due date charge with "20250821" due date and 2.8 EUR transaction amount
    And Loan Charges tab has the following data:
      | Name    | isPenalty | Payment due at     | Due as of      | Calculation type | Due | Paid | Waived | Outstanding |
      | NSF fee | true      | Specified due date | 20250821 | Flat             | 2.8 | 0.0  | 0.0    | 2.8         |
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date           | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20250516    |           | 186.99          |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 31   | 20250616   |           | 125.24          | 61.75         | 1.76     | 0.0  | 0.0       | 63.51 | 0.0  | 0.0        | 0.0  | 63.51       |
      | 2  | 30   | 20250716   |           | 63.49           | 61.75         | 1.76     | 0.0  | 0.0       | 63.51 | 0.0  | 0.0        | 0.0  | 63.51       |
      | 3  | 31   | 20250816 |           | 0.0             | 63.49         | 1.76     | 0.0  | 0.0       | 65.25 | 0.0  | 0.0        | 0.0  | 65.25       |
      | 4  | 5    | 20250821 |           | 0.0             | 0.0           | 0.0      | 0.0  | 2.8       | 2.8   | 0.0  | 0.0        | 0.0  | 2.8         |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 186.99        | 5.28     | 0.0  | 2.8       | 195.07 | 0.0  | 0.0        | 0.0  | 195.07      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20250516      | Disbursement     | 186.99 | 0.0       | 0.0      | 0.0  | 0.0       | 186.99       | false    | false    |
      | 20250616     | Accrual Activity | 1.76   | 0.0       | 1.76     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250716     | Accrual Activity | 1.76   | 0.0       | 1.76     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250816   | Repayment        | 192.27 | 186.99    | 5.28     | 0.0  | 0.0       | 0.0          | true     | false    |
      | 20250816   | Accrual          | 5.28   | 0.0       | 5.28     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250816   | Accrual Activity | 1.76   | 0.0       | 1.76     | 0.0  | 0.0       | 0.0          | false    | false    |
    When Admin sets the business date to "20250822"
    And Customer makes "AUTOPAY" repayment on "20250822" with 195.07 EUR transaction amount
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date           | Paid date      | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late  | Outstanding |
      |    |      | 20250516    |                | 186.99          |               |          | 0.0  |           | 0.0   | 0.0   |            |       |             |
      | 1  | 31   | 20250616   | 20250822 | 125.24          | 61.75         | 1.76     | 0.0  | 0.0       | 63.51 | 63.51 | 0.0        | 63.51 | 0.0         |
      | 2  | 30   | 20250716   | 20250822 | 63.49           | 61.75         | 1.76     | 0.0  | 0.0       | 63.51 | 63.51 | 0.0        | 63.51 | 0.0         |
      | 3  | 31   | 20250816 | 20250822 | 0.0             | 63.49         | 1.76     | 0.0  | 0.0       | 65.25 | 65.25 | 0.0        | 65.25 | 0.0         |
      | 4  | 5    | 20250821 | 20250822 | 0.0             | 0.0           | 0.0      | 0.0  | 2.8       | 2.8   | 2.8   | 0.0        | 2.8   | 0.0         |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late   | Outstanding |
      | 186.99        | 5.28     | 0.0  | 2.8       | 195.07 | 195.07 | 0.0        | 195.07 | 0.0         |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20250516      | Disbursement     | 186.99 | 0.0       | 0.0      | 0.0  | 0.0       | 186.99       | false    | false    |
      | 20250616     | Accrual Activity | 1.76   | 0.0       | 1.76     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250716     | Accrual Activity | 1.76   | 0.0       | 1.76     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250816   | Repayment        | 192.27 | 186.99    | 5.28     | 0.0  | 0.0       | 0.0          | true     | false    |
      | 20250816   | Accrual          | 5.28   | 0.0       | 5.28     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250816   | Accrual Activity | 1.76   | 0.0       | 1.76     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250821   | Accrual          | 2.8    | 0.0       | 0.0      | 0.0  | 2.8       | 0.0          | false    | false    |
      | 20250822   | Repayment        | 195.07 | 186.99    | 5.28     | 0.0  | 2.8       | 0.0          | false    | false    |
      | 20250822   | Accrual Activity | 2.8    | 0.0       | 0.0      | 0.0  | 2.8       | 0.0          | false    | false    |
    When Admin sets the business date to "20250829"
    And Customer makes a repayment undo on "20250822"
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date           | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20250516    |           | 186.99          |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 31   | 20250616   |           | 125.24          | 61.75         | 1.76     | 0.0  | 0.0       | 63.51 | 0.0  | 0.0        | 0.0  | 63.51       |
      | 2  | 30   | 20250716   |           | 63.49           | 61.75         | 1.76     | 0.0  | 0.0       | 63.51 | 0.0  | 0.0        | 0.0  | 63.51       |
      | 3  | 31   | 20250816 |           | 0.0             | 63.49         | 1.76     | 0.0  | 0.0       | 65.25 | 0.0  | 0.0        | 0.0  | 65.25       |
      | 4  | 5    | 20250821 |           | 0.0             | 0.0           | 0.0      | 0.0  | 2.8       | 2.8   | 0.0  | 0.0        | 0.0  | 2.8         |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 186.99        | 5.28     | 0.0  | 2.8       | 195.07 | 0.0  | 0.0        | 0.0  | 195.07      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20250516      | Disbursement     | 186.99 | 0.0       | 0.0      | 0.0  | 0.0       | 186.99       | false    | false    |
      | 20250616     | Accrual Activity | 1.76   | 0.0       | 1.76     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250716     | Accrual Activity | 1.76   | 0.0       | 1.76     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250816   | Repayment        | 192.27 | 186.99    | 5.28     | 0.0  | 0.0       | 0.0          | true     | false    |
      | 20250816   | Accrual          | 5.28   | 0.0       | 5.28     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250816   | Accrual Activity | 1.76   | 0.0       | 1.76     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250821   | Accrual          | 2.8    | 0.0       | 0.0      | 0.0  | 2.8       | 0.0          | false    | false    |
      | 20250821   | Accrual Activity | 2.8    | 0.0       | 0.0      | 0.0  | 2.8       | 0.0          | false    | true     |
      | 20250822   | Repayment        | 195.07 | 186.99    | 5.28     | 0.0  | 2.8       | 0.0          | true     | false    |
    Then Loan status will be "ACTIVE"
    Then Loan has 195.07 outstanding amount

  @TestRailId:C4148
  Scenario: Verify 2 months of EMIs to be paid early and late with repayment trn at last installment - UC1
    When Admin sets the business date to "20250416"
    And Admin creates a client with random data
    And Admin creates a fully customized loan with the following data:
      | LoanProduct                                                   | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_CUSTOM_PMT_ALLOC_PROGRESSIVE_LOAN_SCHEDULE_HORIZONTAL | 20250416      | 1000           | 35.99                  | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 6                | MONTHS                | 1              | MONTHS                 | 6                 | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20250416" with "1000" amount and expected disbursement date on "20250416"
    And Admin successfully disburse the loan on "20250416" with "1207.18" EUR transaction amount
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date      | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late  | Outstanding |
      |    |      | 20250416     |                | 1207.18         |               |          | 0.0  |           | 0.0    | 0.0   |            |       |             |
      | 1  | 30   | 20250516       |                | 1020.55         | 186.63        | 36.21    | 0.0  | 0.0       | 222.84 | 0.0   | 0.0        | 0.0   | 222.84      |
      | 2  | 31   | 20250616      |                |  828.32         | 192.23        | 30.61    | 0.0  | 0.0       | 222.84 | 0.0   | 0.0        | 0.0   | 222.84      |
      | 3  | 30   | 20250716      |                |  630.32         | 198.0         | 24.84    | 0.0  | 0.0       | 222.84 | 0.0   | 0.0        | 0.0   | 222.84      |
      | 4  | 31   | 20250816    |                |  426.38         | 203.94        | 18.9     | 0.0  | 0.0       | 222.84 | 0.0   | 0.0        | 0.0   | 222.84      |
      | 5  | 31   | 20250916 |                |  216.33         | 210.05        | 12.79    | 0.0  | 0.0       | 222.84 | 0.0   | 0.0        | 0.0   | 222.84      |
      | 6  | 30   | 20251016   |                |    0.0          | 216.33        |  6.49    | 0.0  | 0.0       | 222.82 | 0.0   | 0.0        | 0.0   | 222.82      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest   | Fees | Penalties | Due     | Paid   | In advance | Late   | Outstanding |
      | 1207.18       | 129.84     | 0.0  | 0.0       | 1337.02 | 0.0    | 0.0        | 0.0    | 1337.02     |
    Then Loan Transactions tab has the following data:
      | Transaction date   | Transaction Type | Amount  | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20250416      | Disbursement     | 1207.18 | 0.0       | 0.0      | 0.0  | 0.0       | 1207.18      | false    | false    |
    Then Loan status will be "ACTIVE"
    Then Loan has 1337.02 outstanding amount
    When Admin sets the business date to "20250510"
    And Customer makes "REPAYMENT" transaction with "AUTOPAY" payment type on "20250510" with 222.84 EUR transaction amount and system-generated Idempotency key
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date      | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid    | In advance | Late  | Outstanding |
      |    |      | 20250416     |                | 1207.18         |               |          | 0.0  |           | 0.0    | 0.0     |            |       |             |
      | 1  | 30   | 20250516       | 20250510    | 1013.3          | 193.88        | 28.96    | 0.0  | 0.0       | 222.84 | 222.84  | 222.84     | 0.0   |   0.0       |
      | 2  | 31   | 20250616      |                |  826.93         | 186.37        | 36.47    | 0.0  | 0.0       | 222.84 | 0.0     | 0.0        | 0.0   | 222.84      |
      | 3  | 30   | 20250716      |                |  628.89         | 198.04        | 24.8     | 0.0  | 0.0       | 222.84 | 0.0     | 0.0        | 0.0   | 222.84      |
      | 4  | 31   | 20250816    |                |  424.91         | 203.98        | 18.86    | 0.0  | 0.0       | 222.84 | 0.0     | 0.0        | 0.0   | 222.84      |
      | 5  | 31   | 20250916 |                |  214.81         | 210.1         | 12.74    | 0.0  | 0.0       | 222.84 | 0.0     | 0.0        | 0.0   | 222.84      |
      | 6  | 30   | 20251016   |                |    0.0          | 214.81        |  6.44    | 0.0  | 0.0       | 221.25 | 0.0     | 0.0        | 0.0   | 221.25      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest   | Fees | Penalties | Due     | Paid   | In advance | Late   | Outstanding |
      | 1207.18       | 128.27     | 0.0  | 0.0       | 1335.45 | 222.84 | 222.84     | 0.0    | 1112.61     |
    Then Loan Transactions tab has the following data:
      | Transaction date   | Transaction Type | Amount  | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20250416      | Disbursement     | 1207.18 | 0.0       | 0.0      | 0.0  | 0.0       | 1207.18      | false    | false    |
      | 20250510        | Repayment        | 222.84  | 193.88    | 28.96    | 0.0  | 0.0       | 1013.3       | false    | false    |
    Then Loan status will be "ACTIVE"
    Then Loan has 1112.61 outstanding amount
    When Admin sets the business date to "20250606"
    And Customer makes "REPAYMENT" transaction with "AUTOPAY" payment type on "20250606" with 222.84 EUR transaction amount and system-generated Idempotency key
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date      | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid    | In advance | Late  | Outstanding |
      |    |      | 20250416     |                | 1207.18         |               |          | 0.0  |           | 0.0    | 0.0     |            |       |             |
      | 1  | 30   | 20250516       | 20250510    | 1013.3          | 193.88        | 28.96    | 0.0  | 0.0       | 222.84 | 222.84  | 222.84     | 0.0   |   0.0       |
      | 2  | 31   | 20250616      | 20250606   |  817.13         | 196.17        | 26.67    | 0.0  | 0.0       | 222.84 | 222.84  | 222.84     | 0.0   |   0.0       |
      | 3  | 30   | 20250716      |                |  626.7          | 190.43        | 32.41    | 0.0  | 0.0       | 222.84 | 0.0     | 0.0        | 0.0   | 222.84      |
      | 4  | 31   | 20250816    |                |  422.66         | 204.04        | 18.8     | 0.0  | 0.0       | 222.84 | 0.0     | 0.0        | 0.0   | 222.84      |
      | 5  | 31   | 20250916 |                |  212.5          | 210.16        | 12.68    | 0.0  | 0.0       | 222.84 | 0.0     | 0.0        | 0.0   | 222.84      |
      | 6  | 30   | 20251016   |                |    0.0          | 212.5         |  6.37    | 0.0  | 0.0       | 218.87 | 0.0     | 0.0        | 0.0   | 218.87      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest   | Fees | Penalties | Due     | Paid   | In advance | Late   | Outstanding |
      | 1207.18       | 125.89     | 0.0  | 0.0       | 1333.07 | 445.68 | 445.68     | 0.0    | 887.39      |
    Then Loan Transactions tab has the following data:
      | Transaction date   | Transaction Type | Amount  | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20250416      | Disbursement     | 1207.18 | 0.0       | 0.0      | 0.0  | 0.0       | 1207.18      | false    | false    |
      | 20250510        | Repayment        | 222.84  | 193.88    | 28.96    | 0.0  | 0.0       | 1013.3       | false    | false    |
      | 20250606       | Repayment        | 222.84  | 196.17    | 26.67    | 0.0  | 0.0       | 817.13       | false    | false    |
    Then Loan status will be "ACTIVE"
    Then Loan has 887.39 outstanding amount
    When Admin sets the business date to "20250912"
    And Customer makes "REPAYMENT" transaction with "AUTOPAY" payment type on "20250912" with 445.68 EUR transaction amount and system-generated Idempotency key
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date           | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid    | In advance | Late    | Outstanding |
      |    |      | 20250416     |                     | 1207.18         |               |          | 0.0  |           | 0.0    | 0.0     |            |         |             |
      | 1  | 30   | 20250516       | 20250510         | 1013.3          | 193.88        | 28.96    | 0.0  | 0.0       | 222.84 | 222.84  | 222.84     | 0.0     |   0.0       |
      | 2  | 31   | 20250616      | 20250606        |  817.13         | 196.17        | 26.67    | 0.0  | 0.0       | 222.84 | 222.84  | 222.84     | 0.0     |   0.0       |
      | 3  | 30   | 20250716      | 20250912   |  626.7          | 190.43        | 32.41    | 0.0  | 0.0       | 222.84 | 222.84  | 0.0        | 222.84  |   0.0       |
      | 4  | 31   | 20250816    | 20250912   |  428.37         | 198.33        | 24.51    | 0.0  | 0.0       | 222.84 | 222.84  | 0.0        | 222.84  |   0.0       |
      | 5  | 31   | 20250916 |                     |  228.53         | 199.84        | 23.0     | 0.0  | 0.0       | 222.84 | 0.0     | 0.0        | 0.0     | 222.84      |
      | 6  | 30   | 20251016   |                     |    0.0          | 228.53        |  6.85    | 0.0  | 0.0       | 235.38 | 0.0     | 0.0        | 0.0     | 235.38      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest   | Fees | Penalties | Due     | Paid   | In advance | Late    | Outstanding |
      | 1207.18       | 142.4      | 0.0  | 0.0       | 1349.58 | 891.36 | 445.68     | 445.68  | 458.22      |
    Then Loan Transactions tab has the following data:
      | Transaction date   | Transaction Type | Amount  | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20250416      | Disbursement     | 1207.18 | 0.0       | 0.0      | 0.0  | 0.0       | 1207.18      | false    | false    |
      | 20250510        | Repayment        | 222.84  | 193.88    | 28.96    | 0.0  | 0.0       | 1013.3       | false    | false    |
      | 20250606       | Repayment        | 222.84  | 196.17    | 26.67    | 0.0  | 0.0       | 817.13       | false    | false    |
      | 20250912  | Repayment        | 445.68  | 388.76    | 56.92    | 0.0  | 0.0       | 428.37       | false    | false    |
    Then Loan status will be "ACTIVE"
    Then Loan has 458.22 outstanding amount
    And Customer makes "REPAYMENT" transaction with "AUTOPAY" payment type on "20250912" with 445.68 EUR transaction amount and system-generated Idempotency key
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date           | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid    | In advance | Late    | Outstanding |
      |    |      | 20250416     |                     | 1207.18         |               |          | 0.0  |           | 0.0    | 0.0     |            |         |             |
      | 1  | 30   | 20250516       | 20250510         | 1013.3          | 193.88        | 28.96    | 0.0  | 0.0       | 222.84 | 222.84  | 222.84     | 0.0     |   0.0       |
      | 2  | 31   | 20250616      | 20250606        |  817.13         | 196.17        | 26.67    | 0.0  | 0.0       | 222.84 | 222.84  | 222.84     | 0.0     |   0.0       |
      | 3  | 30   | 20250716      | 20250912   |  626.7          | 190.43        | 32.41    | 0.0  | 0.0       | 222.84 | 222.84  | 0.0        | 222.84  |   0.0       |
      | 4  | 31   | 20250816    | 20250912   |  428.37         | 198.33        | 24.51    | 0.0  | 0.0       | 222.84 | 222.84  | 0.0        | 222.84  |   0.0       |
      | 5  | 31   | 20250916 | 20250912   |  226.87         | 201.5         | 21.34    | 0.0  | 0.0       | 222.84 | 222.84  | 222.84     | 0.0     |   0.0       |
      | 6  | 30   | 20251016   |                     |    0.0          | 226.87        |  0.14    | 0.0  | 0.0       | 227.01 | 222.84  | 222.84     | 0.0     |   4.17      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest   | Fees | Penalties | Due     | Paid    | In advance | Late    | Outstanding |
      | 1207.18       | 134.03     | 0.0  | 0.0       | 1341.21 | 1337.04 | 891.36     | 445.68  |   4.17      |
    Then Loan Transactions tab has the following data:
      | Transaction date   | Transaction Type | Amount  | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20250416      | Disbursement     | 1207.18 | 0.0       | 0.0      | 0.0  | 0.0       | 1207.18      | false    | false    |
      | 20250510        | Repayment        | 222.84  | 193.88    | 28.96    | 0.0  | 0.0       | 1013.3       | false    | false    |
      | 20250606       | Repayment        | 222.84  | 196.17    | 26.67    | 0.0  | 0.0       | 817.13       | false    | false    |
      | 20250912  | Repayment        | 445.68  | 388.76    | 56.92    | 0.0  | 0.0       | 428.37       | false    | false    |
      | 20250912  | Repayment        | 445.68  | 424.34    | 21.34    | 0.0  | 0.0       |   4.03       | false    | false    |
    Then Loan status will be "ACTIVE"
    Then Loan has 4.17 outstanding amount
    When Admin sets the business date to "20251004"
    And Customer makes "REPAYMENT" transaction with "AUTOPAY" payment type on "20251004" with 4.03 EUR transaction amount and system-generated Idempotency key
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date           | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid    | In advance | Late    | Outstanding |
      |    |      | 20250416     |                     | 1207.18         |               |          | 0.0  |           | 0.0    | 0.0     |            |         |             |
      | 1  | 30   | 20250516       | 20250510         | 1013.3          | 193.88        | 28.96    | 0.0  | 0.0       | 222.84 | 222.84  | 222.84     | 0.0     |   0.0       |
      | 2  | 31   | 20250616      | 20250606        |  817.13         | 196.17        | 26.67    | 0.0  | 0.0       | 222.84 | 222.84  | 222.84     | 0.0     |   0.0       |
      | 3  | 30   | 20250716      | 20250912   |  626.7          | 190.43        | 32.41    | 0.0  | 0.0       | 222.84 | 222.84  | 0.0        | 222.84  |   0.0       |
      | 4  | 31   | 20250816    | 20250912   |  428.37         | 198.33        | 24.51    | 0.0  | 0.0       | 222.84 | 222.84  | 0.0        | 222.84  |   0.0       |
      | 5  | 31   | 20250916 | 20250912   |  226.87         | 201.5         | 21.34    | 0.0  | 0.0       | 222.84 | 222.84  | 222.84     | 0.0     |   0.0       |
      | 6  | 30   | 20251016   |                     |    0.0          | 226.87        |  0.09    | 0.0  | 0.0       | 226.96 | 226.87  | 226.87     | 0.0     |   0.09      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest   | Fees | Penalties | Due     | Paid    | In advance | Late    | Outstanding |
      | 1207.18       | 133.98     | 0.0  | 0.0       | 1341.16 | 1341.07 | 895.39     | 445.68  |   0.09      |
    Then Loan Transactions tab has the following data:
      | Transaction date   | Transaction Type | Amount  | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20250416      | Disbursement     | 1207.18 | 0.0       | 0.0      | 0.0  | 0.0       | 1207.18      | false    | false    |
      | 20250510        | Repayment        | 222.84  | 193.88    | 28.96    | 0.0  | 0.0       | 1013.3       | false    | false    |
      | 20250606       | Repayment        | 222.84  | 196.17    | 26.67    | 0.0  | 0.0       | 817.13       | false    | false    |
      | 20250912  | Repayment        | 445.68  | 388.76    | 56.92    | 0.0  | 0.0       | 428.37       | false    | false    |
      | 20250912  | Repayment        | 445.68  | 424.34    | 21.34    | 0.0  | 0.0       |   4.03       | false    | false    |
      | 20251004    | Repayment        |   4.03  |   3.94    |  0.09    | 0.0  | 0.0       |   0.09       | false    | false    |
    Then Loan status will be "ACTIVE"
    Then Loan has 0.09 outstanding amount
    When Admin sets the business date to "20251012"
    And Customer makes "REPAYMENT" transaction with "AUTOPAY" payment type on "20251012" with 0.09 EUR transaction amount and system-generated Idempotency key
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date           | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid    | In advance | Late    | Outstanding |
      |    |      | 20250416     |                     | 1207.18         |               |          | 0.0  |           | 0.0    | 0.0     |            |         |             |
      | 1  | 30   | 20250516       | 20250510         | 1013.3          | 193.88        | 28.96    | 0.0  | 0.0       | 222.84 | 222.84  | 222.84     | 0.0     |   0.0       |
      | 2  | 31   | 20250616      | 20250606        |  817.13         | 196.17        | 26.67    | 0.0  | 0.0       | 222.84 | 222.84  | 222.84     | 0.0     |   0.0       |
      | 3  | 30   | 20250716      | 20250912   |  626.7          | 190.43        | 32.41    | 0.0  | 0.0       | 222.84 | 222.84  | 0.0        | 222.84  |   0.0       |
      | 4  | 31   | 20250816    | 20250912   |  428.37         | 198.33        | 24.51    | 0.0  | 0.0       | 222.84 | 222.84  | 0.0        | 222.84  |   0.0       |
      | 5  | 31   | 20250916 | 20250912   |  226.87         | 201.5         | 21.34    | 0.0  | 0.0       | 222.84 | 222.84  | 222.84     | 0.0     |   0.0       |
      | 6  | 30   | 20251016   | 20251012     |    0.0          | 226.87        |  0.09    | 0.0  | 0.0       | 226.96 | 226.96  | 226.96     | 0.0     |   0.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest   | Fees | Penalties | Due     | Paid    | In advance | Late    | Outstanding |
      | 1207.18       | 133.98     | 0.0  | 0.0       | 1341.16 | 1341.16 | 895.48     | 445.68  |   0.0       |
    Then Loan Transactions tab has the following data:
      | Transaction date   | Transaction Type | Amount  | Principal | Interest | Fees | Penalties  | Loan Balance | Reverted | Replayed |
      | 20250416      | Disbursement     | 1207.18 | 0.0       |  0.0      | 0.0  | 0.0       | 1207.18      | false    | false    |
      | 20250510        | Repayment        | 222.84  | 193.88    |  28.96    | 0.0  | 0.0       | 1013.3       | false    | false    |
      | 20250516        | Accrual Activity |  28.96  |   0.0     |  28.96    | 0.0  | 0.0       |    0.0       | false    | false    |
      | 20250606       | Repayment        | 222.84  | 196.17    |  26.67    | 0.0  | 0.0       | 817.13       | false    | false    |
      | 20250616       | Accrual Activity |  26.67  |   0.0     |  26.67    | 0.0  | 0.0       |    0.0       | false    | false    |
      | 20250716       | Accrual Activity |  32.41  |   0.0     |  32.41    | 0.0  | 0.0       |    0.0       | false    | false    |
      | 20250816     | Accrual Activity |  24.51  |   0.0     |  24.51    | 0.0  | 0.0       |    0.0       | false    | false    |
      | 20250912  | Repayment        | 445.68  | 388.76    |  56.92    | 0.0  | 0.0       | 428.37       | false    | false    |
      | 20250912  | Repayment        | 445.68  | 424.34    |  21.34    | 0.0  | 0.0       |   4.03       | false    | false    |
      | 20250916  | Accrual Activity |  21.34  |   0.0     |  21.34    | 0.0  | 0.0       |    0.0       | false    | false    |
      | 20251004    | Repayment        |   4.03  |   3.94    |   0.09    | 0.0  | 0.0       |   0.09       | false    | false    |
      | 20251012    | Repayment        |   0.09  |   0.09    |   0.0     | 0.0  | 0.0       |    0.0       | false    | false    |
      | 20251012    | Accrual          |  133.98 |   0.0     | 133.98    | 0.0  | 0.0       |    0.0       | false    | false    |
      | 20251012    | Accrual Activity |    0.09 |   0.0     |   0.09    | 0.0  | 0.0       |    0.0       | false    | false    |
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C4149
  Scenario: Verify 2 months of EMIs to be paid early and late with MIR trn at last installment - UC2
    When Admin sets the business date to "20250416"
    And Admin creates a client with random data
    And Admin creates a fully customized loan with the following data:
      | LoanProduct                                                   | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_CUSTOM_PMT_ALLOC_PROGRESSIVE_LOAN_SCHEDULE_HORIZONTAL | 20250416      | 1000           | 35.99                  | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 6                | MONTHS                | 1              | MONTHS                 | 6                 | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20250416" with "1000" amount and expected disbursement date on "20250416"
    And Admin successfully disburse the loan on "20250416" with "1207.18" EUR transaction amount
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date      | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late  | Outstanding |
      |    |      | 20250416     |                | 1207.18         |               |          | 0.0  |           | 0.0    | 0.0   |            |       |             |
      | 1  | 30   | 20250516       |                | 1020.55         | 186.63        | 36.21    | 0.0  | 0.0       | 222.84 | 0.0   | 0.0        | 0.0   | 222.84      |
      | 2  | 31   | 20250616      |                |  828.32         | 192.23        | 30.61    | 0.0  | 0.0       | 222.84 | 0.0   | 0.0        | 0.0   | 222.84      |
      | 3  | 30   | 20250716      |                |  630.32         | 198.0         | 24.84    | 0.0  | 0.0       | 222.84 | 0.0   | 0.0        | 0.0   | 222.84      |
      | 4  | 31   | 20250816    |                |  426.38         | 203.94        | 18.9     | 0.0  | 0.0       | 222.84 | 0.0   | 0.0        | 0.0   | 222.84      |
      | 5  | 31   | 20250916 |                |  216.33         | 210.05        | 12.79    | 0.0  | 0.0       | 222.84 | 0.0   | 0.0        | 0.0   | 222.84      |
      | 6  | 30   | 20251016   |                |    0.0          | 216.33        |  6.49    | 0.0  | 0.0       | 222.82 | 0.0   | 0.0        | 0.0   | 222.82      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest   | Fees | Penalties | Due     | Paid   | In advance | Late   | Outstanding |
      | 1207.18       | 129.84     | 0.0  | 0.0       | 1337.02 | 0.0    | 0.0        | 0.0    | 1337.02     |
    Then Loan Transactions tab has the following data:
      | Transaction date   | Transaction Type | Amount  | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20250416      | Disbursement     | 1207.18 | 0.0       | 0.0      | 0.0  | 0.0       | 1207.18      | false    | false    |
    Then Loan status will be "ACTIVE"
    Then Loan has 1337.02 outstanding amount
    When Admin sets the business date to "20250510"
    And Customer makes "REPAYMENT" transaction with "AUTOPAY" payment type on "20250510" with 222.84 EUR transaction amount and system-generated Idempotency key
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date      | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid    | In advance | Late  | Outstanding |
      |    |      | 20250416     |                | 1207.18         |               |          | 0.0  |           | 0.0    | 0.0     |            |       |             |
      | 1  | 30   | 20250516       | 20250510    | 1013.3          | 193.88        | 28.96    | 0.0  | 0.0       | 222.84 | 222.84  | 222.84     | 0.0   |   0.0       |
      | 2  | 31   | 20250616      |                |  826.93         | 186.37        | 36.47    | 0.0  | 0.0       | 222.84 | 0.0     | 0.0        | 0.0   | 222.84      |
      | 3  | 30   | 20250716      |                |  628.89         | 198.04        | 24.8     | 0.0  | 0.0       | 222.84 | 0.0     | 0.0        | 0.0   | 222.84      |
      | 4  | 31   | 20250816    |                |  424.91         | 203.98        | 18.86    | 0.0  | 0.0       | 222.84 | 0.0     | 0.0        | 0.0   | 222.84      |
      | 5  | 31   | 20250916 |                |  214.81         | 210.1         | 12.74    | 0.0  | 0.0       | 222.84 | 0.0     | 0.0        | 0.0   | 222.84      |
      | 6  | 30   | 20251016   |                |    0.0          | 214.81        |  6.44    | 0.0  | 0.0       | 221.25 | 0.0     | 0.0        | 0.0   | 221.25      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest   | Fees | Penalties | Due     | Paid   | In advance | Late   | Outstanding |
      | 1207.18       | 128.27     | 0.0  | 0.0       | 1335.45 | 222.84 | 222.84     | 0.0    | 1112.61     |
    Then Loan Transactions tab has the following data:
      | Transaction date   | Transaction Type | Amount  | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20250416      | Disbursement     | 1207.18 | 0.0       | 0.0      | 0.0  | 0.0       | 1207.18      | false    | false    |
      | 20250510        | Repayment        | 222.84  | 193.88    | 28.96    | 0.0  | 0.0       | 1013.3       | false    | false    |
    Then Loan status will be "ACTIVE"
    Then Loan has 1112.61 outstanding amount
    When Admin sets the business date to "20250606"
    And Customer makes "REPAYMENT" transaction with "AUTOPAY" payment type on "20250606" with 222.84 EUR transaction amount and system-generated Idempotency key
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date      | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid    | In advance | Late  | Outstanding |
      |    |      | 20250416     |                | 1207.18         |               |          | 0.0  |           | 0.0    | 0.0     |            |       |             |
      | 1  | 30   | 20250516       | 20250510    | 1013.3          | 193.88        | 28.96    | 0.0  | 0.0       | 222.84 | 222.84  | 222.84     | 0.0   |   0.0       |
      | 2  | 31   | 20250616      | 20250606   |  817.13         | 196.17        | 26.67    | 0.0  | 0.0       | 222.84 | 222.84  | 222.84     | 0.0   |   0.0       |
      | 3  | 30   | 20250716      |                |  626.7          | 190.43        | 32.41    | 0.0  | 0.0       | 222.84 | 0.0     | 0.0        | 0.0   | 222.84      |
      | 4  | 31   | 20250816    |                |  422.66         | 204.04        | 18.8     | 0.0  | 0.0       | 222.84 | 0.0     | 0.0        | 0.0   | 222.84      |
      | 5  | 31   | 20250916 |                |  212.5          | 210.16        | 12.68    | 0.0  | 0.0       | 222.84 | 0.0     | 0.0        | 0.0   | 222.84      |
      | 6  | 30   | 20251016   |                |    0.0          | 212.5         |  6.37    | 0.0  | 0.0       | 218.87 | 0.0     | 0.0        | 0.0   | 218.87      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest   | Fees | Penalties | Due     | Paid   | In advance | Late   | Outstanding |
      | 1207.18       | 125.89     | 0.0  | 0.0       | 1333.07 | 445.68 | 445.68     | 0.0    | 887.39      |
    Then Loan Transactions tab has the following data:
      | Transaction date   | Transaction Type | Amount  | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20250416      | Disbursement     | 1207.18 | 0.0       | 0.0      | 0.0  | 0.0       | 1207.18      | false    | false    |
      | 20250510        | Repayment        | 222.84  | 193.88    | 28.96    | 0.0  | 0.0       | 1013.3       | false    | false    |
      | 20250606       | Repayment        | 222.84  | 196.17    | 26.67    | 0.0  | 0.0       | 817.13       | false    | false    |
    Then Loan status will be "ACTIVE"
    Then Loan has 887.39 outstanding amount
    When Admin sets the business date to "20250912"
    And Customer makes "REPAYMENT" transaction with "AUTOPAY" payment type on "20250912" with 445.68 EUR transaction amount and system-generated Idempotency key
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date           | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid    | In advance | Late    | Outstanding |
      |    |      | 20250416     |                     | 1207.18         |               |          | 0.0  |           | 0.0    | 0.0     |            |         |             |
      | 1  | 30   | 20250516       | 20250510         | 1013.3          | 193.88        | 28.96    | 0.0  | 0.0       | 222.84 | 222.84  | 222.84     | 0.0     |   0.0       |
      | 2  | 31   | 20250616      | 20250606        |  817.13         | 196.17        | 26.67    | 0.0  | 0.0       | 222.84 | 222.84  | 222.84     | 0.0     |   0.0       |
      | 3  | 30   | 20250716      | 20250912   |  626.7          | 190.43        | 32.41    | 0.0  | 0.0       | 222.84 | 222.84  | 0.0        | 222.84  |   0.0       |
      | 4  | 31   | 20250816    | 20250912   |  428.37         | 198.33        | 24.51    | 0.0  | 0.0       | 222.84 | 222.84  | 0.0        | 222.84  |   0.0       |
      | 5  | 31   | 20250916 |                     |  228.53         | 199.84        | 23.0     | 0.0  | 0.0       | 222.84 | 0.0     | 0.0        | 0.0     | 222.84      |
      | 6  | 30   | 20251016   |                     |    0.0          | 228.53        |  6.85    | 0.0  | 0.0       | 235.38 | 0.0     | 0.0        | 0.0     | 235.38      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest   | Fees | Penalties | Due     | Paid   | In advance | Late    | Outstanding |
      | 1207.18       | 142.4      | 0.0  | 0.0       | 1349.58 | 891.36 | 445.68     | 445.68  | 458.22      |
    Then Loan Transactions tab has the following data:
      | Transaction date   | Transaction Type | Amount  | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20250416      | Disbursement     | 1207.18 | 0.0       | 0.0      | 0.0  | 0.0       | 1207.18      | false    | false    |
      | 20250510        | Repayment        | 222.84  | 193.88    | 28.96    | 0.0  | 0.0       | 1013.3       | false    | false    |
      | 20250606       | Repayment        | 222.84  | 196.17    | 26.67    | 0.0  | 0.0       | 817.13       | false    | false    |
      | 20250912  | Repayment        | 445.68  | 388.76    | 56.92    | 0.0  | 0.0       | 428.37       | false    | false    |
    Then Loan status will be "ACTIVE"
    Then Loan has 458.22 outstanding amount
    And Customer makes "REPAYMENT" transaction with "AUTOPAY" payment type on "20250912" with 445.68 EUR transaction amount and system-generated Idempotency key
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date           | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid    | In advance | Late    | Outstanding |
      |    |      | 20250416     |                     | 1207.18         |               |          | 0.0  |           | 0.0    | 0.0     |            |         |             |
      | 1  | 30   | 20250516       | 20250510         | 1013.3          | 193.88        | 28.96    | 0.0  | 0.0       | 222.84 | 222.84  | 222.84     | 0.0     |   0.0       |
      | 2  | 31   | 20250616      | 20250606        |  817.13         | 196.17        | 26.67    | 0.0  | 0.0       | 222.84 | 222.84  | 222.84     | 0.0     |   0.0       |
      | 3  | 30   | 20250716      | 20250912   |  626.7          | 190.43        | 32.41    | 0.0  | 0.0       | 222.84 | 222.84  | 0.0        | 222.84  |   0.0       |
      | 4  | 31   | 20250816    | 20250912   |  428.37         | 198.33        | 24.51    | 0.0  | 0.0       | 222.84 | 222.84  | 0.0        | 222.84  |   0.0       |
      | 5  | 31   | 20250916 | 20250912   |  226.87         | 201.5         | 21.34    | 0.0  | 0.0       | 222.84 | 222.84  | 222.84     | 0.0     |   0.0       |
      | 6  | 30   | 20251016   |                     |    0.0          | 226.87        |  0.14    | 0.0  | 0.0       | 227.01 | 222.84  | 222.84     | 0.0     |   4.17      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest   | Fees | Penalties | Due     | Paid    | In advance | Late    | Outstanding |
      | 1207.18       | 134.03     | 0.0  | 0.0       | 1341.21 | 1337.04 | 891.36     | 445.68  |   4.17      |
    Then Loan Transactions tab has the following data:
      | Transaction date   | Transaction Type | Amount  | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20250416      | Disbursement     | 1207.18 | 0.0       | 0.0      | 0.0  | 0.0       | 1207.18      | false    | false    |
      | 20250510        | Repayment        | 222.84  | 193.88    | 28.96    | 0.0  | 0.0       | 1013.3       | false    | false    |
      | 20250606       | Repayment        | 222.84  | 196.17    | 26.67    | 0.0  | 0.0       | 817.13       | false    | false    |
      | 20250912  | Repayment        | 445.68  | 388.76    | 56.92    | 0.0  | 0.0       | 428.37       | false    | false    |
      | 20250912  | Repayment        | 445.68  | 424.34    | 21.34    | 0.0  | 0.0       |   4.03       | false    | false    |
    Then Loan status will be "ACTIVE"
    Then Loan has 4.17 outstanding amount
    When Admin sets the business date to "20251004"
    When Admin makes "MERCHANT_ISSUED_REFUND" transaction with "AUTOPAY" payment type on "20251004" with 3.43 EUR transaction amount
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date           | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid    | In advance | Late    | Outstanding |
      |    |      | 20250416     |                     | 1207.18         |               |          | 0.0  |           | 0.0    | 0.0     |            |         |             |
      | 1  | 30   | 20250516       | 20250510         | 1013.3          | 193.88        | 28.96    | 0.0  | 0.0       | 222.84 | 222.84  | 222.84     | 0.0     |   0.0       |
      | 2  | 31   | 20250616      | 20250606        |  817.13         | 196.17        | 26.67    | 0.0  | 0.0       | 222.84 | 222.84  | 222.84     | 0.0     |   0.0       |
      | 3  | 30   | 20250716      | 20250912   |  626.7          | 190.43        | 32.41    | 0.0  | 0.0       | 222.84 | 222.84  | 0.0        | 222.84  |   0.0       |
      | 4  | 31   | 20250816    | 20250912   |  428.37         | 198.33        | 24.51    | 0.0  | 0.0       | 222.84 | 222.84  | 0.0        | 222.84  |   0.0       |
      | 5  | 31   | 20250916 | 20250912   |  226.87         | 201.5         | 21.34    | 0.0  | 0.0       | 222.84 | 222.84  | 222.84     | 0.0     |   0.0       |
      | 6  | 30   | 20251016   |                     |    0.0          | 226.87        |  0.09    | 0.0  | 0.0       | 226.96 | 226.87  | 226.87     | 0.0     |   0.09      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest   | Fees | Penalties | Due     | Paid    | In advance | Late    | Outstanding |
      | 1207.18       | 133.98     | 0.0  | 0.0       | 1341.16 | 1341.07 | 895.39     | 445.68  |   0.09      |
    Then Loan Transactions tab has the following data:
      | Transaction date   | Transaction Type       | Amount  | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20250416      | Disbursement           | 1207.18 | 0.0       | 0.0      | 0.0  | 0.0       | 1207.18      | false    | false    |
      | 20250510        | Repayment              | 222.84  | 193.88    | 28.96    | 0.0  | 0.0       | 1013.3       | false    | false    |
      | 20250606       | Repayment              | 222.84  | 196.17    | 26.67    | 0.0  | 0.0       | 817.13       | false    | false    |
      | 20250912  | Repayment              | 445.68  | 388.76    | 56.92    | 0.0  | 0.0       | 428.37       | false    | false    |
      | 20250912  | Repayment              | 445.68  | 424.34    | 21.34    | 0.0  | 0.0       |   4.03       | false    | false    |
      | 20251004    | Merchant Issued Refund |   3.43  |   3.43    |  0.0     | 0.0  | 0.0       |   0.6        | false    | false    |
      | 20251004    | Interest Refund        |   0.6   |   0.51    |  0.09    | 0.0  | 0.0       |   0.09       | false    | false    |
    Then Loan status will be "ACTIVE"
    Then Loan has 0.09 outstanding amount
    When Admin sets the business date to "20251012"
    And Customer makes "REPAYMENT" transaction with "AUTOPAY" payment type on "20251012" with 0.09 EUR transaction amount and system-generated Idempotency key
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date           | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid    | In advance | Late    | Outstanding |
      |    |      | 20250416     |                     | 1207.18         |               |          | 0.0  |           | 0.0    | 0.0     |            |         |             |
      | 1  | 30   | 20250516       | 20250510         | 1013.3          | 193.88        | 28.96    | 0.0  | 0.0       | 222.84 | 222.84  | 222.84     | 0.0     |   0.0       |
      | 2  | 31   | 20250616      | 20250606        |  817.13         | 196.17        | 26.67    | 0.0  | 0.0       | 222.84 | 222.84  | 222.84     | 0.0     |   0.0       |
      | 3  | 30   | 20250716      | 20250912   |  626.7          | 190.43        | 32.41    | 0.0  | 0.0       | 222.84 | 222.84  | 0.0        | 222.84  |   0.0       |
      | 4  | 31   | 20250816    | 20250912   |  428.37         | 198.33        | 24.51    | 0.0  | 0.0       | 222.84 | 222.84  | 0.0        | 222.84  |   0.0       |
      | 5  | 31   | 20250916 | 20250912   |  226.87         | 201.5         | 21.34    | 0.0  | 0.0       | 222.84 | 222.84  | 222.84     | 0.0     |   0.0       |
      | 6  | 30   | 20251016   | 20251012     |    0.0          | 226.87        |  0.09    | 0.0  | 0.0       | 226.96 | 226.96  | 226.96     | 0.0     |   0.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest   | Fees | Penalties | Due     | Paid    | In advance | Late    | Outstanding |
      | 1207.18       | 133.98     | 0.0  | 0.0       | 1341.16 | 1341.16 | 895.48     | 445.68  |   0.0       |
    Then Loan Transactions tab has the following data:
      | Transaction date   | Transaction Type       | Amount  | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20250416      | Disbursement           | 1207.18 | 0.0       |  0.0      | 0.0  | 0.0       | 1207.18      | false    | false    |
      | 20250510        | Repayment              | 222.84  | 193.88    |  28.96    | 0.0  | 0.0       | 1013.3       | false    | false    |
      | 20250516        | Accrual Activity       |  28.96  |   0.0     |  28.96    | 0.0  | 0.0       |    0.0       | false    | false    |
      | 20250606       | Repayment              | 222.84  | 196.17    |  26.67    | 0.0  | 0.0       | 817.13       | false    | false    |
      | 20250616       | Accrual Activity       |  26.67  |   0.0     |  26.67    | 0.0  | 0.0       |    0.0       | false    | false    |
      | 20250716       | Accrual Activity       |  32.41  |   0.0     |  32.41    | 0.0  | 0.0       |    0.0       | false    | false    |
      | 20250816     | Accrual Activity       |  24.51  |   0.0     |  24.51    | 0.0  | 0.0       |    0.0       | false    | false    |
      | 20250912  | Repayment              | 445.68  | 388.76    |  56.92    | 0.0  | 0.0       | 428.37       | false    | false    |
      | 20250912  | Repayment              | 445.68  | 424.34    |  21.34    | 0.0  | 0.0       |   4.03       | false    | false    |
      | 20250916  | Accrual Activity       |  21.34  |   0.0     |  21.34    | 0.0  | 0.0       |    0.0       | false    | false    |
      | 20251004    | Merchant Issued Refund |   3.43  |   3.43    |  0.0      | 0.0  | 0.0       |    0.6       | false    | false    |
      | 20251004    | Interest Refund        |   0.6   |   0.51    |  0.09     | 0.0  | 0.0       |   0.09       | false    | false    |
      | 20251012    | Repayment              |   0.09  |   0.09    |   0.0     | 0.0  | 0.0       |    0.0       | false    | false    |
      | 20251012    | Accrual                |  133.98 |   0.0     | 133.98    | 0.0  | 0.0       |    0.0       | false    | false    |
      | 20251012    | Accrual Activity       |    0.09 |   0.0     |   0.09    | 0.0  | 0.0       |    0.0       | false    | false    |
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C4150
  Scenario: Verify 2 months of EMIs to be paid early and late with charge and repayment trns at last installment  - UC3
    When Admin sets the business date to "20250416"
    And Admin creates a client with random data
    And Admin creates a fully customized loan with the following data:
      | LoanProduct                                                   | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_CUSTOM_PMT_ALLOC_PROGRESSIVE_LOAN_SCHEDULE_HORIZONTAL | 20250416      | 1000           | 35.99                  | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 6                | MONTHS                | 1              | MONTHS                 | 6                 | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20250416" with "1000" amount and expected disbursement date on "20250416"
    And Admin successfully disburse the loan on "20250416" with "1207.18" EUR transaction amount
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date      | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late  | Outstanding |
      |    |      | 20250416     |                | 1207.18         |               |          | 0.0  |           | 0.0    | 0.0   |            |       |             |
      | 1  | 30   | 20250516       |                | 1020.55         | 186.63        | 36.21    | 0.0  | 0.0       | 222.84 | 0.0   | 0.0        | 0.0   | 222.84      |
      | 2  | 31   | 20250616      |                |  828.32         | 192.23        | 30.61    | 0.0  | 0.0       | 222.84 | 0.0   | 0.0        | 0.0   | 222.84      |
      | 3  | 30   | 20250716      |                |  630.32         | 198.0         | 24.84    | 0.0  | 0.0       | 222.84 | 0.0   | 0.0        | 0.0   | 222.84      |
      | 4  | 31   | 20250816    |                |  426.38         | 203.94        | 18.9     | 0.0  | 0.0       | 222.84 | 0.0   | 0.0        | 0.0   | 222.84      |
      | 5  | 31   | 20250916 |                |  216.33         | 210.05        | 12.79    | 0.0  | 0.0       | 222.84 | 0.0   | 0.0        | 0.0   | 222.84      |
      | 6  | 30   | 20251016   |                |    0.0          | 216.33        |  6.49    | 0.0  | 0.0       | 222.82 | 0.0   | 0.0        | 0.0   | 222.82      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest   | Fees | Penalties | Due     | Paid   | In advance | Late   | Outstanding |
      | 1207.18       | 129.84     | 0.0  | 0.0       | 1337.02 | 0.0    | 0.0        | 0.0    | 1337.02     |
    Then Loan Transactions tab has the following data:
      | Transaction date   | Transaction Type | Amount  | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20250416      | Disbursement     | 1207.18 | 0.0       | 0.0      | 0.0  | 0.0       | 1207.18      | false    | false    |
    Then Loan status will be "ACTIVE"
    Then Loan has 1337.02 outstanding amount
    When Admin sets the business date to "20250510"
    And Customer makes "REPAYMENT" transaction with "AUTOPAY" payment type on "20250510" with 222.84 EUR transaction amount and system-generated Idempotency key
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date      | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid    | In advance | Late  | Outstanding |
      |    |      | 20250416     |                | 1207.18         |               |          | 0.0  |           | 0.0    | 0.0     |            |       |             |
      | 1  | 30   | 20250516       | 20250510    | 1013.3          | 193.88        | 28.96    | 0.0  | 0.0       | 222.84 | 222.84  | 222.84     | 0.0   |   0.0       |
      | 2  | 31   | 20250616      |                |  826.93         | 186.37        | 36.47    | 0.0  | 0.0       | 222.84 | 0.0     | 0.0        | 0.0   | 222.84      |
      | 3  | 30   | 20250716      |                |  628.89         | 198.04        | 24.8     | 0.0  | 0.0       | 222.84 | 0.0     | 0.0        | 0.0   | 222.84      |
      | 4  | 31   | 20250816    |                |  424.91         | 203.98        | 18.86    | 0.0  | 0.0       | 222.84 | 0.0     | 0.0        | 0.0   | 222.84      |
      | 5  | 31   | 20250916 |                |  214.81         | 210.1         | 12.74    | 0.0  | 0.0       | 222.84 | 0.0     | 0.0        | 0.0   | 222.84      |
      | 6  | 30   | 20251016   |                |    0.0          | 214.81        |  6.44    | 0.0  | 0.0       | 221.25 | 0.0     | 0.0        | 0.0   | 221.25      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest   | Fees | Penalties | Due     | Paid   | In advance | Late   | Outstanding |
      | 1207.18       | 128.27     | 0.0  | 0.0       | 1335.45 | 222.84 | 222.84     | 0.0    | 1112.61     |
    Then Loan Transactions tab has the following data:
      | Transaction date   | Transaction Type | Amount  | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20250416      | Disbursement     | 1207.18 | 0.0       | 0.0      | 0.0  | 0.0       | 1207.18      | false    | false    |
      | 20250510        | Repayment        | 222.84  | 193.88    | 28.96    | 0.0  | 0.0       | 1013.3       | false    | false    |
    Then Loan status will be "ACTIVE"
    Then Loan has 1112.61 outstanding amount
    When Admin sets the business date to "20250606"
    And Customer makes "REPAYMENT" transaction with "AUTOPAY" payment type on "20250606" with 222.84 EUR transaction amount and system-generated Idempotency key
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date      | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid    | In advance | Late  | Outstanding |
      |    |      | 20250416     |                | 1207.18         |               |          | 0.0  |           | 0.0    | 0.0     |            |       |             |
      | 1  | 30   | 20250516       | 20250510    | 1013.3          | 193.88        | 28.96    | 0.0  | 0.0       | 222.84 | 222.84  | 222.84     | 0.0   |   0.0       |
      | 2  | 31   | 20250616      | 20250606   |  817.13         | 196.17        | 26.67    | 0.0  | 0.0       | 222.84 | 222.84  | 222.84     | 0.0   |   0.0       |
      | 3  | 30   | 20250716      |                |  626.7          | 190.43        | 32.41    | 0.0  | 0.0       | 222.84 | 0.0     | 0.0        | 0.0   | 222.84      |
      | 4  | 31   | 20250816    |                |  422.66         | 204.04        | 18.8     | 0.0  | 0.0       | 222.84 | 0.0     | 0.0        | 0.0   | 222.84      |
      | 5  | 31   | 20250916 |                |  212.5          | 210.16        | 12.68    | 0.0  | 0.0       | 222.84 | 0.0     | 0.0        | 0.0   | 222.84      |
      | 6  | 30   | 20251016   |                |    0.0          | 212.5         |  6.37    | 0.0  | 0.0       | 218.87 | 0.0     | 0.0        | 0.0   | 218.87      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest   | Fees | Penalties | Due     | Paid   | In advance | Late   | Outstanding |
      | 1207.18       | 125.89     | 0.0  | 0.0       | 1333.07 | 445.68 | 445.68     | 0.0    | 887.39      |
    Then Loan Transactions tab has the following data:
      | Transaction date   | Transaction Type | Amount  | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20250416      | Disbursement     | 1207.18 | 0.0       | 0.0      | 0.0  | 0.0       | 1207.18      | false    | false    |
      | 20250510        | Repayment        | 222.84  | 193.88    | 28.96    | 0.0  | 0.0       | 1013.3       | false    | false    |
      | 20250606       | Repayment        | 222.84  | 196.17    | 26.67    | 0.0  | 0.0       | 817.13       | false    | false    |
    Then Loan status will be "ACTIVE"
    Then Loan has 887.39 outstanding amount
    When Admin sets the business date to "20250912"
    And Customer makes "REPAYMENT" transaction with "AUTOPAY" payment type on "20250912" with 445.68 EUR transaction amount and system-generated Idempotency key
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date           | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid    | In advance | Late    | Outstanding |
      |    |      | 20250416     |                     | 1207.18         |               |          | 0.0  |           | 0.0    | 0.0     |            |         |             |
      | 1  | 30   | 20250516       | 20250510         | 1013.3          | 193.88        | 28.96    | 0.0  | 0.0       | 222.84 | 222.84  | 222.84     | 0.0     |   0.0       |
      | 2  | 31   | 20250616      | 20250606        |  817.13         | 196.17        | 26.67    | 0.0  | 0.0       | 222.84 | 222.84  | 222.84     | 0.0     |   0.0       |
      | 3  | 30   | 20250716      | 20250912   |  626.7          | 190.43        | 32.41    | 0.0  | 0.0       | 222.84 | 222.84  | 0.0        | 222.84  |   0.0       |
      | 4  | 31   | 20250816    | 20250912   |  428.37         | 198.33        | 24.51    | 0.0  | 0.0       | 222.84 | 222.84  | 0.0        | 222.84  |   0.0       |
      | 5  | 31   | 20250916 |                     |  228.53         | 199.84        | 23.0     | 0.0  | 0.0       | 222.84 | 0.0     | 0.0        | 0.0     | 222.84      |
      | 6  | 30   | 20251016   |                     |    0.0          | 228.53        |  6.85    | 0.0  | 0.0       | 235.38 | 0.0     | 0.0        | 0.0     | 235.38      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest   | Fees | Penalties | Due     | Paid   | In advance | Late    | Outstanding |
      | 1207.18       | 142.4      | 0.0  | 0.0       | 1349.58 | 891.36 | 445.68     | 445.68  | 458.22      |
    Then Loan Transactions tab has the following data:
      | Transaction date   | Transaction Type | Amount  | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20250416      | Disbursement     | 1207.18 | 0.0       | 0.0      | 0.0  | 0.0       | 1207.18      | false    | false    |
      | 20250510        | Repayment        | 222.84  | 193.88    | 28.96    | 0.0  | 0.0       | 1013.3       | false    | false    |
      | 20250606       | Repayment        | 222.84  | 196.17    | 26.67    | 0.0  | 0.0       | 817.13       | false    | false    |
      | 20250912  | Repayment        | 445.68  | 388.76    | 56.92    | 0.0  | 0.0       | 428.37       | false    | false    |
    Then Loan status will be "ACTIVE"
    Then Loan has 458.22 outstanding amount
    And Customer makes "REPAYMENT" transaction with "AUTOPAY" payment type on "20250912" with 445.68 EUR transaction amount and system-generated Idempotency key
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date           | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid    | In advance | Late    | Outstanding |
      |    |      | 20250416     |                     | 1207.18         |               |          | 0.0  |           | 0.0    | 0.0     |            |         |             |
      | 1  | 30   | 20250516       | 20250510         | 1013.3          | 193.88        | 28.96    | 0.0  | 0.0       | 222.84 | 222.84  | 222.84     | 0.0     |   0.0       |
      | 2  | 31   | 20250616      | 20250606        |  817.13         | 196.17        | 26.67    | 0.0  | 0.0       | 222.84 | 222.84  | 222.84     | 0.0     |   0.0       |
      | 3  | 30   | 20250716      | 20250912   |  626.7          | 190.43        | 32.41    | 0.0  | 0.0       | 222.84 | 222.84  | 0.0        | 222.84  |   0.0       |
      | 4  | 31   | 20250816    | 20250912   |  428.37         | 198.33        | 24.51    | 0.0  | 0.0       | 222.84 | 222.84  | 0.0        | 222.84  |   0.0       |
      | 5  | 31   | 20250916 | 20250912   |  226.87         | 201.5         | 21.34    | 0.0  | 0.0       | 222.84 | 222.84  | 222.84     | 0.0     |   0.0       |
      | 6  | 30   | 20251016   |                     |    0.0          | 226.87        |  0.14    | 0.0  | 0.0       | 227.01 | 222.84  | 222.84     | 0.0     |   4.17      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest   | Fees | Penalties | Due     | Paid    | In advance | Late    | Outstanding |
      | 1207.18       | 134.03     | 0.0  | 0.0       | 1341.21 | 1337.04 | 891.36     | 445.68  |   4.17      |
    Then Loan Transactions tab has the following data:
      | Transaction date   | Transaction Type | Amount  | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20250416      | Disbursement     | 1207.18 | 0.0       | 0.0      | 0.0  | 0.0       | 1207.18      | false    | false    |
      | 20250510        | Repayment        | 222.84  | 193.88    | 28.96    | 0.0  | 0.0       | 1013.3       | false    | false    |
      | 20250606       | Repayment        | 222.84  | 196.17    | 26.67    | 0.0  | 0.0       | 817.13       | false    | false    |
      | 20250912  | Repayment        | 445.68  | 388.76    | 56.92    | 0.0  | 0.0       | 428.37       | false    | false    |
      | 20250912  | Repayment        | 445.68  | 424.34    | 21.34    | 0.0  | 0.0       |   4.03       | false    | false    |
    Then Loan status will be "ACTIVE"
    Then Loan has 4.17 outstanding amount

    When Admin adds "LOAN_SNOOZE_FEE" due date charge with "20251004" due date and 3 EUR transaction amount
    Then Loan Charges tab has the following data:
      | Name       | isPenalty | Payment due at       | Due as of       | Calculation type | Due  | Paid | Waived | Outstanding |
      | Snooze fee | false     | Specified due date   | 20251004 | Flat             | 3.0  | 0.0  | 0.0    | 3.0         |

    When Admin sets the business date to "20251004"
    And Customer makes "REPAYMENT" transaction with "AUTOPAY" payment type on "20251004" with 7.03 EUR transaction amount and system-generated Idempotency key
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date           | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid    | In advance | Late    | Outstanding |
      |    |      | 20250416     |                     | 1207.18         |               |          | 0.0  |           | 0.0    | 0.0     |            |         |             |
      | 1  | 30   | 20250516       | 20250510         | 1013.3          | 193.88        | 28.96    | 0.0  | 0.0       | 222.84 | 222.84  | 222.84     | 0.0     |   0.0       |
      | 2  | 31   | 20250616      | 20250606        |  817.13         | 196.17        | 26.67    | 0.0  | 0.0       | 222.84 | 222.84  | 222.84     | 0.0     |   0.0       |
      | 3  | 30   | 20250716      | 20250912   |  626.7          | 190.43        | 32.41    | 0.0  | 0.0       | 222.84 | 222.84  | 0.0        | 222.84  |   0.0       |
      | 4  | 31   | 20250816    | 20250912   |  428.37         | 198.33        | 24.51    | 0.0  | 0.0       | 222.84 | 222.84  | 0.0        | 222.84  |   0.0       |
      | 5  | 31   | 20250916 | 20250912   |  226.87         | 201.5         | 21.34    | 0.0  | 0.0       | 222.84 | 222.84  | 222.84     | 0.0     |   0.0       |
      | 6  | 30   | 20251016   |                     |    0.0          | 226.87        |  0.09    | 3.0  | 0.0       | 229.96 | 229.87  | 229.87     | 0.0     |   0.09      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest   | Fees | Penalties | Due     | Paid    | In advance | Late    | Outstanding |
      | 1207.18       | 133.98     | 3.0  | 0.0       | 1344.16 | 1344.07 | 898.39     | 445.68  |   0.09      |
    Then Loan Transactions tab has the following data:
      | Transaction date   | Transaction Type | Amount  | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20250416      | Disbursement     | 1207.18 | 0.0       | 0.0      | 0.0  | 0.0       | 1207.18      | false    | false    |
      | 20250510        | Repayment        | 222.84  | 193.88    | 28.96    | 0.0  | 0.0       | 1013.3       | false    | false    |
      | 20250606       | Repayment        | 222.84  | 196.17    | 26.67    | 0.0  | 0.0       | 817.13       | false    | false    |
      | 20250912  | Repayment        | 445.68  | 388.76    | 56.92    | 0.0  | 0.0       | 428.37       | false    | false    |
      | 20250912  | Repayment        | 445.68  | 424.34    | 21.34    | 0.0  | 0.0       |   4.03       | false    | false    |
      | 20251004    | Repayment        |   7.03  |   4.03    |  0.09    | 2.91 | 0.0       |   0.0        | false    | false    |
    Then Loan status will be "ACTIVE"
    Then Loan has 0.09 outstanding amount
    When Admin sets the business date to "20251012"
    And Customer makes "REPAYMENT" transaction with "AUTOPAY" payment type on "20251012" with 0.09 EUR transaction amount and system-generated Idempotency key
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date           | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid    | In advance | Late    | Outstanding |
      |    |      | 20250416     |                     | 1207.18         |               |          | 0.0  |           | 0.0    | 0.0     |            |         |             |
      | 1  | 30   | 20250516       | 20250510         | 1013.3          | 193.88        | 28.96    | 0.0  | 0.0       | 222.84 | 222.84  | 222.84     | 0.0     |   0.0       |
      | 2  | 31   | 20250616      | 20250606        |  817.13         | 196.17        | 26.67    | 0.0  | 0.0       | 222.84 | 222.84  | 222.84     | 0.0     |   0.0       |
      | 3  | 30   | 20250716      | 20250912   |  626.7          | 190.43        | 32.41    | 0.0  | 0.0       | 222.84 | 222.84  | 0.0        | 222.84  |   0.0       |
      | 4  | 31   | 20250816    | 20250912   |  428.37         | 198.33        | 24.51    | 0.0  | 0.0       | 222.84 | 222.84  | 0.0        | 222.84  |   0.0       |
      | 5  | 31   | 20250916 | 20250912   |  226.87         | 201.5         | 21.34    | 0.0  | 0.0       | 222.84 | 222.84  | 222.84     | 0.0     |   0.0       |
      | 6  | 30   | 20251016   | 20251012     |    0.0          | 226.87        |  0.09    | 3.0  | 0.0       | 229.96 | 229.96  | 229.96     | 0.0     |   0.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest   | Fees | Penalties | Due     | Paid    | In advance | Late    | Outstanding |
      | 1207.18       | 133.98     | 3.0  | 0.0       | 1344.16 | 1344.16 | 898.48     | 445.68  |   0.0       |
    Then Loan Transactions tab has the following data:
      | Transaction date   | Transaction Type | Amount  | Principal | Interest  | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20250416      | Disbursement     | 1207.18 | 0.0       |  0.0      | 0.0  | 0.0       | 1207.18      | false    | false    |
      | 20250510        | Repayment        | 222.84  | 193.88    |  28.96    | 0.0  | 0.0       | 1013.3       | false    | false    |
      | 20250516        | Accrual Activity |  28.96  |   0.0     |  28.96    | 0.0  | 0.0       |    0.0       | false    | false    |
      | 20250606       | Repayment        | 222.84  | 196.17    |  26.67    | 0.0  | 0.0       | 817.13       | false    | false    |
      | 20250616       | Accrual Activity |  26.67  |   0.0     |  26.67    | 0.0  | 0.0       |    0.0       | false    | false    |
      | 20250716       | Accrual Activity |  32.41  |   0.0     |  32.41    | 0.0  | 0.0       |    0.0       | false    | false    |
      | 20250816     | Accrual Activity |  24.51  |   0.0     |  24.51    | 0.0  | 0.0       |    0.0       | false    | false    |
      | 20250912  | Repayment        | 445.68  | 388.76    |  56.92    | 0.0  | 0.0       | 428.37       | false    | false    |
      | 20250912  | Repayment        | 445.68  | 424.34    |  21.34    | 0.0  | 0.0       |   4.03       | false    | false    |
      | 20250916  | Accrual Activity |  21.34  |   0.0     |  21.34    | 0.0  | 0.0       |    0.0       | false    | false    |
      | 20251004    | Repayment        |   7.03  |   4.03    |   0.09    | 2.91 | 0.0       |    0.0       | false    | false    |
      | 20251012    | Repayment        |   0.09  |   0.0     |   0.0     | 0.09 | 0.0       |    0.0       | false    | false    |
      | 20251012    | Accrual          |  136.98 |   0.0     | 133.98    | 3.0  | 0.0       |    0.0       | false    | false    |
      | 20251012    | Accrual Activity |    3.09 |   0.0     |   0.09    | 3.0  | 0.0       |    0.0       | false    | false    |
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C4151
  Scenario: Verify near 2 months of EMIs to be paid early and late with repayment trn at last installment - UC1
    When Admin sets the business date to "20250416"
    And Admin creates a client with random data
    And Admin creates a fully customized loan with the following data:
      | LoanProduct                                                   | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_CUSTOM_PMT_ALLOC_PROGRESSIVE_LOAN_SCHEDULE_HORIZONTAL | 20250416      | 1000           | 35.99                  | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 6                | MONTHS                | 1              | MONTHS                 | 6                 | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20250416" with "1000" amount and expected disbursement date on "20250416"
    And Admin successfully disburse the loan on "20250416" with "1207.18" EUR transaction amount
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date      | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late  | Outstanding |
      |    |      | 20250416     |                | 1207.18         |               |          | 0.0  |           | 0.0    | 0.0   |            |       |             |
      | 1  | 30   | 20250516       |                | 1020.55         | 186.63        | 36.21    | 0.0  | 0.0       | 222.84 | 0.0   | 0.0        | 0.0   | 222.84      |
      | 2  | 31   | 20250616      |                |  828.32         | 192.23        | 30.61    | 0.0  | 0.0       | 222.84 | 0.0   | 0.0        | 0.0   | 222.84      |
      | 3  | 30   | 20250716      |                |  630.32         | 198.0         | 24.84    | 0.0  | 0.0       | 222.84 | 0.0   | 0.0        | 0.0   | 222.84      |
      | 4  | 31   | 20250816    |                |  426.38         | 203.94        | 18.9     | 0.0  | 0.0       | 222.84 | 0.0   | 0.0        | 0.0   | 222.84      |
      | 5  | 31   | 20250916 |                |  216.33         | 210.05        | 12.79    | 0.0  | 0.0       | 222.84 | 0.0   | 0.0        | 0.0   | 222.84      |
      | 6  | 30   | 20251016   |                |    0.0          | 216.33        |  6.49    | 0.0  | 0.0       | 222.82 | 0.0   | 0.0        | 0.0   | 222.82      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest   | Fees | Penalties | Due     | Paid   | In advance | Late   | Outstanding |
      | 1207.18       | 129.84     | 0.0  | 0.0       | 1337.02 | 0.0    | 0.0        | 0.0    | 1337.02     |
    Then Loan Transactions tab has the following data:
      | Transaction date   | Transaction Type | Amount  | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20250416      | Disbursement     | 1207.18 | 0.0       | 0.0      | 0.0  | 0.0       | 1207.18      | false    | false    |
    Then Loan status will be "ACTIVE"
    Then Loan has 1337.02 outstanding amount
    When Admin sets the business date to "20250510"
    And Customer makes "REPAYMENT" transaction with "AUTOPAY" payment type on "20250510" with 222.84 EUR transaction amount and system-generated Idempotency key
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date      | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid    | In advance | Late  | Outstanding |
      |    |      | 20250416     |                | 1207.18         |               |          | 0.0  |           | 0.0    | 0.0     |            |       |             |
      | 1  | 30   | 20250516       | 20250510    | 1013.3          | 193.88        | 28.96    | 0.0  | 0.0       | 222.84 | 222.84  | 222.84     | 0.0   |   0.0       |
      | 2  | 31   | 20250616      |                |  826.93         | 186.37        | 36.47    | 0.0  | 0.0       | 222.84 | 0.0     | 0.0        | 0.0   | 222.84      |
      | 3  | 30   | 20250716      |                |  628.89         | 198.04        | 24.8     | 0.0  | 0.0       | 222.84 | 0.0     | 0.0        | 0.0   | 222.84      |
      | 4  | 31   | 20250816    |                |  424.91         | 203.98        | 18.86    | 0.0  | 0.0       | 222.84 | 0.0     | 0.0        | 0.0   | 222.84      |
      | 5  | 31   | 20250916 |                |  214.81         | 210.1         | 12.74    | 0.0  | 0.0       | 222.84 | 0.0     | 0.0        | 0.0   | 222.84      |
      | 6  | 30   | 20251016   |                |    0.0          | 214.81        |  6.44    | 0.0  | 0.0       | 221.25 | 0.0     | 0.0        | 0.0   | 221.25      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest   | Fees | Penalties | Due     | Paid   | In advance | Late   | Outstanding |
      | 1207.18       | 128.27     | 0.0  | 0.0       | 1335.45 | 222.84 | 222.84     | 0.0    | 1112.61     |
    Then Loan Transactions tab has the following data:
      | Transaction date   | Transaction Type | Amount  | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20250416      | Disbursement     | 1207.18 | 0.0       | 0.0      | 0.0  | 0.0       | 1207.18      | false    | false    |
      | 20250510        | Repayment        | 222.84  | 193.88    | 28.96    | 0.0  | 0.0       | 1013.3       | false    | false    |
    Then Loan status will be "ACTIVE"
    Then Loan has 1112.61 outstanding amount
    When Admin sets the business date to "20250606"
    And Customer makes "REPAYMENT" transaction with "AUTOPAY" payment type on "20250606" with 222.84 EUR transaction amount and system-generated Idempotency key
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date      | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid    | In advance | Late  | Outstanding |
      |    |      | 20250416     |                | 1207.18         |               |          | 0.0  |           | 0.0    | 0.0     |            |       |             |
      | 1  | 30   | 20250516       | 20250510    | 1013.3          | 193.88        | 28.96    | 0.0  | 0.0       | 222.84 | 222.84  | 222.84     | 0.0   |   0.0       |
      | 2  | 31   | 20250616      | 20250606   |  817.13         | 196.17        | 26.67    | 0.0  | 0.0       | 222.84 | 222.84  | 222.84     | 0.0   |   0.0       |
      | 3  | 30   | 20250716      |                |  626.7          | 190.43        | 32.41    | 0.0  | 0.0       | 222.84 | 0.0     | 0.0        | 0.0   | 222.84      |
      | 4  | 31   | 20250816    |                |  422.66         | 204.04        | 18.8     | 0.0  | 0.0       | 222.84 | 0.0     | 0.0        | 0.0   | 222.84      |
      | 5  | 31   | 20250916 |                |  212.5          | 210.16        | 12.68    | 0.0  | 0.0       | 222.84 | 0.0     | 0.0        | 0.0   | 222.84      |
      | 6  | 30   | 20251016   |                |    0.0          | 212.5         |  6.37    | 0.0  | 0.0       | 218.87 | 0.0     | 0.0        | 0.0   | 218.87      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest   | Fees | Penalties | Due     | Paid   | In advance | Late   | Outstanding |
      | 1207.18       | 125.89     | 0.0  | 0.0       | 1333.07 | 445.68 | 445.68     | 0.0    | 887.39      |
    Then Loan Transactions tab has the following data:
      | Transaction date   | Transaction Type | Amount  | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20250416      | Disbursement     | 1207.18 | 0.0       | 0.0      | 0.0  | 0.0       | 1207.18      | false    | false    |
      | 20250510        | Repayment        | 222.84  | 193.88    | 28.96    | 0.0  | 0.0       | 1013.3       | false    | false    |
      | 20250606       | Repayment        | 222.84  | 196.17    | 26.67    | 0.0  | 0.0       | 817.13       | false    | false    |
    Then Loan status will be "ACTIVE"
    Then Loan has 887.39 outstanding amount
    When Admin sets the business date to "20250912"
    And Customer makes "REPAYMENT" transaction with "AUTOPAY" payment type on "20250912" with 445.68 EUR transaction amount and system-generated Idempotency key
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date           | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid    | In advance | Late    | Outstanding |
      |    |      | 20250416     |                     | 1207.18         |               |          | 0.0  |           | 0.0    | 0.0     |            |         |             |
      | 1  | 30   | 20250516       | 20250510         | 1013.3          | 193.88        | 28.96    | 0.0  | 0.0       | 222.84 | 222.84  | 222.84     | 0.0     |   0.0       |
      | 2  | 31   | 20250616      | 20250606        |  817.13         | 196.17        | 26.67    | 0.0  | 0.0       | 222.84 | 222.84  | 222.84     | 0.0     |   0.0       |
      | 3  | 30   | 20250716      | 20250912   |  626.7          | 190.43        | 32.41    | 0.0  | 0.0       | 222.84 | 222.84  | 0.0        | 222.84  |   0.0       |
      | 4  | 31   | 20250816    | 20250912   |  428.37         | 198.33        | 24.51    | 0.0  | 0.0       | 222.84 | 222.84  | 0.0        | 222.84  |   0.0       |
      | 5  | 31   | 20250916 |                     |  228.53         | 199.84        | 23.0     | 0.0  | 0.0       | 222.84 | 0.0     | 0.0        | 0.0     | 222.84      |
      | 6  | 30   | 20251016   |                     |    0.0          | 228.53        |  6.85    | 0.0  | 0.0       | 235.38 | 0.0     | 0.0        | 0.0     | 235.38      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest   | Fees | Penalties | Due     | Paid   | In advance | Late    | Outstanding |
      | 1207.18       | 142.4      | 0.0  | 0.0       | 1349.58 | 891.36 | 445.68     | 445.68  | 458.22      |
    Then Loan Transactions tab has the following data:
      | Transaction date   | Transaction Type | Amount  | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20250416      | Disbursement     | 1207.18 | 0.0       | 0.0      | 0.0  | 0.0       | 1207.18      | false    | false    |
      | 20250510        | Repayment        | 222.84  | 193.88    | 28.96    | 0.0  | 0.0       | 1013.3       | false    | false    |
      | 20250606       | Repayment        | 222.84  | 196.17    | 26.67    | 0.0  | 0.0       | 817.13       | false    | false    |
      | 20250912  | Repayment        | 445.68  | 388.76    | 56.92    | 0.0  | 0.0       | 428.37       | false    | false    |
    Then Loan status will be "ACTIVE"
    Then Loan has 458.22 outstanding amount
    And Customer makes "REPAYMENT" transaction with "AUTOPAY" payment type on "20250912" with 445.69 EUR transaction amount and system-generated Idempotency key
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date           | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid    | In advance | Late    | Outstanding |
      |    |      | 20250416     |                     | 1207.18         |               |          | 0.0  |           | 0.0    | 0.0     |            |         |             |
      | 1  | 30   | 20250516       | 20250510         | 1013.3          | 193.88        | 28.96    | 0.0  | 0.0       | 222.84 | 222.84  | 222.84     | 0.0     |   0.0       |
      | 2  | 31   | 20250616      | 20250606        |  817.13         | 196.17        | 26.67    | 0.0  | 0.0       | 222.84 | 222.84  | 222.84     | 0.0     |   0.0       |
      | 3  | 30   | 20250716      | 20250912   |  626.7          | 190.43        | 32.41    | 0.0  | 0.0       | 222.84 | 222.84  | 0.0        | 222.84  |   0.0       |
      | 4  | 31   | 20250816    | 20250912   |  428.37         | 198.33        | 24.51    | 0.0  | 0.0       | 222.84 | 222.84  | 0.0        | 222.84  |   0.0       |
      | 5  | 31   | 20250916 | 20250912   |  226.87         | 201.5         | 21.34    | 0.0  | 0.0       | 222.84 | 222.84  | 222.84     | 0.0     |   0.0       |
      | 6  | 30   | 20251016   |                     |    0.0          | 226.87        |  0.14    | 0.0  | 0.0       | 227.01 | 222.85  | 222.85     | 0.0     |   4.16      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest   | Fees | Penalties | Due     | Paid    | In advance | Late    | Outstanding |
      | 1207.18       | 134.03     | 0.0  | 0.0       | 1341.21 | 1337.05 | 891.37     | 445.68  |   4.16      |
    Then Loan Transactions tab has the following data:
      | Transaction date   | Transaction Type | Amount  | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20250416      | Disbursement     | 1207.18 | 0.0       | 0.0      | 0.0  | 0.0       | 1207.18      | false    | false    |
      | 20250510        | Repayment        | 222.84  | 193.88    | 28.96    | 0.0  | 0.0       | 1013.3       | false    | false    |
      | 20250606       | Repayment        | 222.84  | 196.17    | 26.67    | 0.0  | 0.0       | 817.13       | false    | false    |
      | 20250912  | Repayment        | 445.68  | 388.76    | 56.92    | 0.0  | 0.0       | 428.37       | false    | false    |
      | 20250912  | Repayment        | 445.69  | 424.35    | 21.34    | 0.0  | 0.0       |   4.02       | false    | false    |
    Then Loan status will be "ACTIVE"
    Then Loan has 4.16 outstanding amount
    When Admin sets the business date to "20251004"
    And Customer makes "REPAYMENT" transaction with "AUTOPAY" payment type on "20251004" with 4.11 EUR transaction amount and system-generated Idempotency key
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date           | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid    | In advance | Late    | Outstanding |
      |    |      | 20250416     |                     | 1207.18         |               |          | 0.0  |           | 0.0    | 0.0     |            |         |             |
      | 1  | 30   | 20250516       | 20250510         | 1013.3          | 193.88        | 28.96    | 0.0  | 0.0       | 222.84 | 222.84  | 222.84     | 0.0     |   0.0       |
      | 2  | 31   | 20250616      | 20250606        |  817.13         | 196.17        | 26.67    | 0.0  | 0.0       | 222.84 | 222.84  | 222.84     | 0.0     |   0.0       |
      | 3  | 30   | 20250716      | 20250912   |  626.7          | 190.43        | 32.41    | 0.0  | 0.0       | 222.84 | 222.84  | 0.0        | 222.84  |   0.0       |
      | 4  | 31   | 20250816    | 20250912   |  428.37         | 198.33        | 24.51    | 0.0  | 0.0       | 222.84 | 222.84  | 0.0        | 222.84  |   0.0       |
      | 5  | 31   | 20250916 | 20250912   |  226.87         | 201.5         | 21.34    | 0.0  | 0.0       | 222.84 | 222.84  | 222.84     | 0.0     |   0.0       |
      | 6  | 30   | 20251016   | 20251004     |    0.0          | 226.87        |  0.09    | 0.0  | 0.0       | 226.96 | 226.96  | 226.96     | 0.0     |   0.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest   | Fees | Penalties | Due     | Paid    | In advance | Late    | Outstanding |
      | 1207.18       | 133.98     | 0.0  | 0.0       | 1341.16 | 1341.16 | 895.48     | 445.68  |   0.0       |
    Then Loan Transactions tab has the following data:
      | Transaction date   | Transaction Type | Amount  | Principal | Interest | Fees | Penalties  | Loan Balance | Reverted | Replayed |
      | 20250416      | Disbursement     | 1207.18 | 0.0       |  0.0      | 0.0  | 0.0       | 1207.18      | false    | false    |
      | 20250510        | Repayment        | 222.84  | 193.88    |  28.96    | 0.0  | 0.0       | 1013.3       | false    | false    |
      | 20250516        | Accrual Activity |  28.96  |   0.0     |  28.96    | 0.0  | 0.0       |    0.0       | false    | false    |
      | 20250606       | Repayment        | 222.84  | 196.17    |  26.67    | 0.0  | 0.0       | 817.13       | false    | false    |
      | 20250616       | Accrual Activity |  26.67  |   0.0     |  26.67    | 0.0  | 0.0       |    0.0       | false    | false    |
      | 20250716       | Accrual Activity |  32.41  |   0.0     |  32.41    | 0.0  | 0.0       |    0.0       | false    | false    |
      | 20250816     | Accrual Activity |  24.51  |   0.0     |  24.51    | 0.0  | 0.0       |    0.0       | false    | false    |
      | 20250912  | Repayment        | 445.68  | 388.76    |  56.92    | 0.0  | 0.0       | 428.37       | false    | false    |
      | 20250912  | Repayment        | 445.69  | 424.35    |  21.34    | 0.0  | 0.0       |   4.02       | false    | false    |
      | 20250916  | Accrual Activity |  21.34  |   0.0     |  21.34    | 0.0  | 0.0       |    0.0       | false    | false    |
      | 20251004    | Repayment        |   4.11  |   4.02    |   0.09    | 0.0  | 0.0       |    0.0       | false    | false    |
      | 20251004    | Accrual          |  133.98 |   0.0     | 133.98    | 0.0  | 0.0       |    0.0       | false    | false    |
      | 20251004    | Accrual Activity |    0.09 |   0.0     |   0.09    | 0.0  | 0.0       |    0.0       | false    | false    |
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C4152
  Scenario: Verify near 2 months of EMIs to be paid early and late with repayment trn at last installment - UC2
    When Admin sets the business date to "20250416"
    And Admin creates a client with random data
    And Admin creates a fully customized loan with the following data:
      | LoanProduct                                                   | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_CUSTOM_PMT_ALLOC_PROGRESSIVE_LOAN_SCHEDULE_HORIZONTAL | 20250416      | 1000           | 35.99                  | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 6                | MONTHS                | 1              | MONTHS                 | 6                 | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20250416" with "1000" amount and expected disbursement date on "20250416"
    And Admin successfully disburse the loan on "20250416" with "1207.18" EUR transaction amount
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date      | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late  | Outstanding |
      |    |      | 20250416     |                | 1207.18         |               |          | 0.0  |           | 0.0    | 0.0   |            |       |             |
      | 1  | 30   | 20250516       |                | 1020.55         | 186.63        | 36.21    | 0.0  | 0.0       | 222.84 | 0.0   | 0.0        | 0.0   | 222.84      |
      | 2  | 31   | 20250616      |                |  828.32         | 192.23        | 30.61    | 0.0  | 0.0       | 222.84 | 0.0   | 0.0        | 0.0   | 222.84      |
      | 3  | 30   | 20250716      |                |  630.32         | 198.0         | 24.84    | 0.0  | 0.0       | 222.84 | 0.0   | 0.0        | 0.0   | 222.84      |
      | 4  | 31   | 20250816    |                |  426.38         | 203.94        | 18.9     | 0.0  | 0.0       | 222.84 | 0.0   | 0.0        | 0.0   | 222.84      |
      | 5  | 31   | 20250916 |                |  216.33         | 210.05        | 12.79    | 0.0  | 0.0       | 222.84 | 0.0   | 0.0        | 0.0   | 222.84      |
      | 6  | 30   | 20251016   |                |    0.0          | 216.33        |  6.49    | 0.0  | 0.0       | 222.82 | 0.0   | 0.0        | 0.0   | 222.82      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest   | Fees | Penalties | Due     | Paid   | In advance | Late   | Outstanding |
      | 1207.18       | 129.84     | 0.0  | 0.0       | 1337.02 | 0.0    | 0.0        | 0.0    | 1337.02     |
    Then Loan Transactions tab has the following data:
      | Transaction date   | Transaction Type | Amount  | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20250416      | Disbursement     | 1207.18 | 0.0       | 0.0      | 0.0  | 0.0       | 1207.18      | false    | false    |
    Then Loan status will be "ACTIVE"
    Then Loan has 1337.02 outstanding amount
    When Admin sets the business date to "20250510"
    And Customer makes "REPAYMENT" transaction with "AUTOPAY" payment type on "20250510" with 222.84 EUR transaction amount and system-generated Idempotency key
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date      | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid    | In advance | Late  | Outstanding |
      |    |      | 20250416     |                | 1207.18         |               |          | 0.0  |           | 0.0    | 0.0     |            |       |             |
      | 1  | 30   | 20250516       | 20250510    | 1013.3          | 193.88        | 28.96    | 0.0  | 0.0       | 222.84 | 222.84  | 222.84     | 0.0   |   0.0       |
      | 2  | 31   | 20250616      |                |  826.93         | 186.37        | 36.47    | 0.0  | 0.0       | 222.84 | 0.0     | 0.0        | 0.0   | 222.84      |
      | 3  | 30   | 20250716      |                |  628.89         | 198.04        | 24.8     | 0.0  | 0.0       | 222.84 | 0.0     | 0.0        | 0.0   | 222.84      |
      | 4  | 31   | 20250816    |                |  424.91         | 203.98        | 18.86    | 0.0  | 0.0       | 222.84 | 0.0     | 0.0        | 0.0   | 222.84      |
      | 5  | 31   | 20250916 |                |  214.81         | 210.1         | 12.74    | 0.0  | 0.0       | 222.84 | 0.0     | 0.0        | 0.0   | 222.84      |
      | 6  | 30   | 20251016   |                |    0.0          | 214.81        |  6.44    | 0.0  | 0.0       | 221.25 | 0.0     | 0.0        | 0.0   | 221.25      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest   | Fees | Penalties | Due     | Paid   | In advance | Late   | Outstanding |
      | 1207.18       | 128.27     | 0.0  | 0.0       | 1335.45 | 222.84 | 222.84     | 0.0    | 1112.61     |
    Then Loan Transactions tab has the following data:
      | Transaction date   | Transaction Type | Amount  | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20250416      | Disbursement     | 1207.18 | 0.0       | 0.0      | 0.0  | 0.0       | 1207.18      | false    | false    |
      | 20250510        | Repayment        | 222.84  | 193.88    | 28.96    | 0.0  | 0.0       | 1013.3       | false    | false    |
    Then Loan status will be "ACTIVE"
    Then Loan has 1112.61 outstanding amount
    When Admin sets the business date to "20250606"
    And Customer makes "REPAYMENT" transaction with "AUTOPAY" payment type on "20250606" with 222.84 EUR transaction amount and system-generated Idempotency key
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date      | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid    | In advance | Late  | Outstanding |
      |    |      | 20250416     |                | 1207.18         |               |          | 0.0  |           | 0.0    | 0.0     |            |       |             |
      | 1  | 30   | 20250516       | 20250510    | 1013.3          | 193.88        | 28.96    | 0.0  | 0.0       | 222.84 | 222.84  | 222.84     | 0.0   |   0.0       |
      | 2  | 31   | 20250616      | 20250606   |  817.13         | 196.17        | 26.67    | 0.0  | 0.0       | 222.84 | 222.84  | 222.84     | 0.0   |   0.0       |
      | 3  | 30   | 20250716      |                |  626.7          | 190.43        | 32.41    | 0.0  | 0.0       | 222.84 | 0.0     | 0.0        | 0.0   | 222.84      |
      | 4  | 31   | 20250816    |                |  422.66         | 204.04        | 18.8     | 0.0  | 0.0       | 222.84 | 0.0     | 0.0        | 0.0   | 222.84      |
      | 5  | 31   | 20250916 |                |  212.5          | 210.16        | 12.68    | 0.0  | 0.0       | 222.84 | 0.0     | 0.0        | 0.0   | 222.84      |
      | 6  | 30   | 20251016   |                |    0.0          | 212.5         |  6.37    | 0.0  | 0.0       | 218.87 | 0.0     | 0.0        | 0.0   | 218.87      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest   | Fees | Penalties | Due     | Paid   | In advance | Late   | Outstanding |
      | 1207.18       | 125.89     | 0.0  | 0.0       | 1333.07 | 445.68 | 445.68     | 0.0    | 887.39      |
    Then Loan Transactions tab has the following data:
      | Transaction date   | Transaction Type | Amount  | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20250416      | Disbursement     | 1207.18 | 0.0       | 0.0      | 0.0  | 0.0       | 1207.18      | false    | false    |
      | 20250510        | Repayment        | 222.84  | 193.88    | 28.96    | 0.0  | 0.0       | 1013.3       | false    | false    |
      | 20250606       | Repayment        | 222.84  | 196.17    | 26.67    | 0.0  | 0.0       | 817.13       | false    | false    |
    Then Loan status will be "ACTIVE"
    Then Loan has 887.39 outstanding amount
    When Admin sets the business date to "20250912"
    And Customer makes "REPAYMENT" transaction with "AUTOPAY" payment type on "20250912" with 445.68 EUR transaction amount and system-generated Idempotency key
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date           | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid    | In advance | Late    | Outstanding |
      |    |      | 20250416     |                     | 1207.18         |               |          | 0.0  |           | 0.0    | 0.0     |            |         |             |
      | 1  | 30   | 20250516       | 20250510         | 1013.3          | 193.88        | 28.96    | 0.0  | 0.0       | 222.84 | 222.84  | 222.84     | 0.0     |   0.0       |
      | 2  | 31   | 20250616      | 20250606        |  817.13         | 196.17        | 26.67    | 0.0  | 0.0       | 222.84 | 222.84  | 222.84     | 0.0     |   0.0       |
      | 3  | 30   | 20250716      | 20250912   |  626.7          | 190.43        | 32.41    | 0.0  | 0.0       | 222.84 | 222.84  | 0.0        | 222.84  |   0.0       |
      | 4  | 31   | 20250816    | 20250912   |  428.37         | 198.33        | 24.51    | 0.0  | 0.0       | 222.84 | 222.84  | 0.0        | 222.84  |   0.0       |
      | 5  | 31   | 20250916 |                     |  228.53         | 199.84        | 23.0     | 0.0  | 0.0       | 222.84 | 0.0     | 0.0        | 0.0     | 222.84      |
      | 6  | 30   | 20251016   |                     |    0.0          | 228.53        |  6.85    | 0.0  | 0.0       | 235.38 | 0.0     | 0.0        | 0.0     | 235.38      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest   | Fees | Penalties | Due     | Paid   | In advance | Late    | Outstanding |
      | 1207.18       | 142.4      | 0.0  | 0.0       | 1349.58 | 891.36 | 445.68     | 445.68  | 458.22      |
    Then Loan Transactions tab has the following data:
      | Transaction date   | Transaction Type | Amount  | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20250416      | Disbursement     | 1207.18 | 0.0       | 0.0      | 0.0  | 0.0       | 1207.18      | false    | false    |
      | 20250510        | Repayment        | 222.84  | 193.88    | 28.96    | 0.0  | 0.0       | 1013.3       | false    | false    |
      | 20250606       | Repayment        | 222.84  | 196.17    | 26.67    | 0.0  | 0.0       | 817.13       | false    | false    |
      | 20250912  | Repayment        | 445.68  | 388.76    | 56.92    | 0.0  | 0.0       | 428.37       | false    | false    |
    Then Loan status will be "ACTIVE"
    Then Loan has 458.22 outstanding amount
    And Customer makes "REPAYMENT" transaction with "AUTOPAY" payment type on "20250912" with 445.67 EUR transaction amount and system-generated Idempotency key
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date           | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid    | In advance | Late    | Outstanding |
      |    |      | 20250416     |                     | 1207.18         |               |          | 0.0  |           | 0.0    | 0.0     |            |         |             |
      | 1  | 30   | 20250516       | 20250510         | 1013.3          | 193.88        | 28.96    | 0.0  | 0.0       | 222.84 | 222.84  | 222.84     | 0.0     |   0.0       |
      | 2  | 31   | 20250616      | 20250606        |  817.13         | 196.17        | 26.67    | 0.0  | 0.0       | 222.84 | 222.84  | 222.84     | 0.0     |   0.0       |
      | 3  | 30   | 20250716      | 20250912   |  626.7          | 190.43        | 32.41    | 0.0  | 0.0       | 222.84 | 222.84  | 0.0        | 222.84  |   0.0       |
      | 4  | 31   | 20250816    | 20250912   |  428.37         | 198.33        | 24.51    | 0.0  | 0.0       | 222.84 | 222.84  | 0.0        | 222.84  |   0.0       |
      | 5  | 31   | 20250916 | 20250912   |  226.87         | 201.5         | 21.34    | 0.0  | 0.0       | 222.84 | 222.84  | 222.84     | 0.0     |   0.0       |
      | 6  | 30   | 20251016   |                     |    0.0          | 226.87        |  0.14    | 0.0  | 0.0       | 227.01 | 222.83  | 222.83     | 0.0     |   4.18      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest   | Fees | Penalties | Due     | Paid    | In advance | Late    | Outstanding |
      | 1207.18       | 134.03     | 0.0  | 0.0       | 1341.21 | 1337.03 | 891.35     | 445.68  |   4.18      |
    Then Loan Transactions tab has the following data:
      | Transaction date   | Transaction Type | Amount  | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20250416      | Disbursement     | 1207.18 | 0.0       | 0.0      | 0.0  | 0.0       | 1207.18      | false    | false    |
      | 20250510        | Repayment        | 222.84  | 193.88    | 28.96    | 0.0  | 0.0       | 1013.3       | false    | false    |
      | 20250606       | Repayment        | 222.84  | 196.17    | 26.67    | 0.0  | 0.0       | 817.13       | false    | false    |
      | 20250912  | Repayment        | 445.68  | 388.76    | 56.92    | 0.0  | 0.0       | 428.37       | false    | false    |
      | 20250912  | Repayment        | 445.67  | 424.33    | 21.34    | 0.0  | 0.0       |   4.04       | false    | false    |
    Then Loan status will be "ACTIVE"
    Then Loan has 4.18 outstanding amount
    When Admin sets the business date to "20251004"
    And Customer makes "REPAYMENT" transaction with "AUTOPAY" payment type on "20251004" with 4.13 EUR transaction amount and system-generated Idempotency key
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date           | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid    | In advance | Late    | Outstanding |
      |    |      | 20250416     |                     | 1207.18         |               |          | 0.0  |           | 0.0    | 0.0     |            |         |             |
      | 1  | 30   | 20250516       | 20250510         | 1013.3          | 193.88        | 28.96    | 0.0  | 0.0       | 222.84 | 222.84  | 222.84     | 0.0     |   0.0       |
      | 2  | 31   | 20250616      | 20250606        |  817.13         | 196.17        | 26.67    | 0.0  | 0.0       | 222.84 | 222.84  | 222.84     | 0.0     |   0.0       |
      | 3  | 30   | 20250716      | 20250912   |  626.7          | 190.43        | 32.41    | 0.0  | 0.0       | 222.84 | 222.84  | 0.0        | 222.84  |   0.0       |
      | 4  | 31   | 20250816    | 20250912   |  428.37         | 198.33        | 24.51    | 0.0  | 0.0       | 222.84 | 222.84  | 0.0        | 222.84  |   0.0       |
      | 5  | 31   | 20250916 | 20250912   |  226.87         | 201.5         | 21.34    | 0.0  | 0.0       | 222.84 | 222.84  | 222.84     | 0.0     |   0.0       |
      | 6  | 30   | 20251016   | 20251004     |    0.0          | 226.87        |  0.09    | 0.0  | 0.0       | 226.96 | 226.96  | 226.96     | 0.0     |   0.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest   | Fees | Penalties | Due     | Paid    | In advance | Late    | Outstanding |
      | 1207.18       | 133.98     | 0.0  | 0.0       | 1341.16 | 1341.16 | 895.48     | 445.68  |   0.0       |
    Then Loan Transactions tab has the following data:
      | Transaction date   | Transaction Type | Amount  | Principal | Interest | Fees | Penalties  | Loan Balance | Reverted | Replayed |
      | 20250416      | Disbursement     | 1207.18 | 0.0       |  0.0      | 0.0  | 0.0       | 1207.18      | false    | false    |
      | 20250510        | Repayment        | 222.84  | 193.88    |  28.96    | 0.0  | 0.0       | 1013.3       | false    | false    |
      | 20250516        | Accrual Activity |  28.96  |   0.0     |  28.96    | 0.0  | 0.0       |    0.0       | false    | false    |
      | 20250606       | Repayment        | 222.84  | 196.17    |  26.67    | 0.0  | 0.0       | 817.13       | false    | false    |
      | 20250616       | Accrual Activity |  26.67  |   0.0     |  26.67    | 0.0  | 0.0       |    0.0       | false    | false    |
      | 20250716       | Accrual Activity |  32.41  |   0.0     |  32.41    | 0.0  | 0.0       |    0.0       | false    | false    |
      | 20250816     | Accrual Activity |  24.51  |   0.0     |  24.51    | 0.0  | 0.0       |    0.0       | false    | false    |
      | 20250912  | Repayment        | 445.68  | 388.76    |  56.92    | 0.0  | 0.0       | 428.37       | false    | false    |
      | 20250912  | Repayment        | 445.67  | 424.33    |  21.34    | 0.0  | 0.0       |   4.04       | false    | false    |
      | 20250916  | Accrual Activity |  21.34  |   0.0     |  21.34    | 0.0  | 0.0       |    0.0       | false    | false    |
      | 20251004    | Repayment        |   4.13  |   4.04    |   0.09    | 0.0  | 0.0       |    0.0       | false    | false    |
      | 20251004    | Accrual          |  133.98 |   0.0     | 133.98    | 0.0  | 0.0       |    0.0       | false    | false    |
      | 20251004    | Accrual Activity |    0.09 |   0.0     |   0.09    | 0.0  | 0.0       |    0.0       | false    | false    |
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C4350
  Scenario: Verify the loan creation with total disbursement amount less then 1 for progressive loan
    When Admin sets the business date to "20251026"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with loan product`s charges and following data:
      | LoanProduct                                      | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_ZERO_INTEREST_CHARGE_OFF_BEHAVIOUR | 20251026   | 1              | 0                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 1                 | MONTHS                | 1              | MONTHS                 | 1                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20251026" with "1" amount and expected disbursement date on "20251026"
    Then Loan Repayment schedule has 1 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20251026  |           | 1.0             |               |          | 0.0  |           | 0.0   |      |            |      | 0.0         |
      | 1  | 31   | 20251126 |           | 0.0             | 1.0           | 0.0      | 0.0  | 0.0       | 1.0   | 0.0  | 0.0        | 0.0  | 1.0         |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 1.0           | 0.0      | 0.0  | 0.0       | 1.0    | 0.0  | 0.0        | 0.0  | 1.0         |
    When Admin successfully disburse the loan on "20251026" with "0.5" EUR transaction amount
    Then Loan Repayment schedule has 1 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20251026  |           | 0.5             |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 31   | 20251126 |           | 0.0             | 0.5           | 0.0      | 0.0  | 0.0       | 0.5   | 0.0  | 0.0        | 0.0  | 0.5         |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 0.5           | 0.0      | 0.0  | 0.0       | 0.5    | 0.0  | 0.0        | 0.0  | 0.5         |
    Then Loan Transactions tab has the following data:
      | Transaction date   | Transaction Type | Amount  | Principal | Interest | Fees | Penalties  | Loan Balance | Reverted | Replayed |
      | 20251026    | Disbursement     | 0.5     | 0.0       |  0.0      | 0.0  | 0.0       | 0.5          | false    | false    |
    When Admin sets the business date to "20251027"
    When Loan Pay-off is made on "20251027"
    Then Loan Repayment schedule has 1 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20251026  |                 | 0.5             |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 31   | 20251126 | 20251027 | 0.0             | 0.5           | 0.0      | 0.0  | 0.0       | 0.5   | 0.5  | 0.5        | 0.0  | 0.0         |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 0.5           | 0.0      | 0.0  | 0.0       | 0.5    | 0.5  | 0.5        | 0.0  | 0.0         |
    Then Loan Transactions tab has the following data:
      | Transaction date   | Transaction Type | Amount  | Principal | Interest | Fees | Penalties  | Loan Balance | Reverted | Replayed |
      | 20251026    | Disbursement     | 0.5     | 0.0       |  0.0      | 0.0  | 0.0       | 0.5          | false    | false    |
      | 20251027    | Repayment        | 0.5     | 0.5       |  0.0      | 0.0  | 0.0       | 0.0          | false    | false    |
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C4351
  Scenario: Verify the loan creation with total calculated EMI less than 1 for progressive loan - 3 repayment periods
    When Admin sets the business date to "20251026"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with loan product`s charges and following data:
      | LoanProduct                                      | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_ZERO_INTEREST_CHARGE_OFF_BEHAVIOUR | 20251026   | 3              | 0                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 3                 | MONTHS                | 1              | MONTHS                 | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20251026" with "1" amount and expected disbursement date on "20251026"
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20251026  |                  | 1.0             |               |          | 0.0  |           | 0.0   |      |            |      | 0.0         |
      | 1  | 31   | 20251126 |                  | 0.67            | 0.33          | 0.0      | 0.0  | 0.0       | 0.33  | 0.0  | 0.0        | 0.0  | 0.33        |
      | 2  | 30   | 20251226 |                  | 0.34            | 0.33          | 0.0      | 0.0  | 0.0       | 0.33  | 0.0  | 0.0        | 0.0  | 0.33        |
      | 3  | 31   | 20260126  |                  | 0.0             | 0.34          | 0.0      | 0.0  | 0.0       | 0.34  | 0.0  | 0.0        | 0.0  | 0.34        |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 1.0           | 0.0      | 0.0  | 0.0       | 1.0    | 0.0  | 0.0        | 0.0  | 1.0         |
    When Admin successfully disburse the loan on "20251026" with "1.5" EUR transaction amount
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20251026  |                  | 1.5             |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 31   | 20251126 |                  | 1.0             | 0.5           | 0.0      | 0.0  | 0.0       | 0.5   | 0.0  | 0.0        | 0.0  | 0.5         |
      | 2  | 30   | 20251226 |                  | 0.5             | 0.5           | 0.0      | 0.0  | 0.0       | 0.5   | 0.0  | 0.0        | 0.0  | 0.5         |
      | 3  | 31   | 20260126  |                  | 0.0             | 0.5           | 0.0      | 0.0  | 0.0       | 0.5   | 0.0  | 0.0        | 0.0  | 0.5         |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 1.5           | 0.0      | 0.0  | 0.0       | 1.5    | 0.0  | 0.0        | 0.0  | 1.5         |
    Then Loan Transactions tab has the following data:
      | Transaction date   | Transaction Type | Amount  | Principal | Interest | Fees | Penalties  | Loan Balance | Reverted | Replayed |
      | 20251026    | Disbursement     | 1.5     | 0.0       |  0.0      | 0.0  | 0.0       | 1.5          | false    | false    |
    When Admin sets the business date to "20251027"
    When Loan Pay-off is made on "20251027"
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20251026  |                  | 1.5             |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 31   | 20251126 | 20251027  | 1.0             | 0.5           | 0.0      | 0.0  | 0.0       | 0.5   | 0.5  | 0.5        | 0.0  | 0.0         |
      | 2  | 30   | 20251226 | 20251027  | 0.5             | 0.5           | 0.0      | 0.0  | 0.0       | 0.5   | 0.5  | 0.5        | 0.0  | 0.0         |
      | 3  | 31   | 20260126  | 20251027  | 0.0             | 0.5           | 0.0      | 0.0  | 0.0       | 0.5   | 0.5  | 0.5        | 0.0  | 0.0         |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 1.5           | 0.0      | 0.0  | 0.0       | 1.5    | 1.5  | 1.5        | 0.0  | 0.0         |
    Then Loan Transactions tab has the following data:
      | Transaction date   | Transaction Type | Amount  | Principal | Interest | Fees | Penalties  | Loan Balance | Reverted | Replayed |
      | 20251026    | Disbursement     | 1.5     | 0.0       |  0.0      | 0.0  | 0.0       | 1.5          | false    | false    |
      | 20251027    | Repayment        | 1.5     | 1.5       |  0.0      | 0.0  | 0.0       | 0.0          | false    | false    |
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C4352
  Scenario: Verify the loan creation with total calculated EMI less than 2 (rounded towards 1) for progressive loan - 3 repayment periods
    When Admin sets the business date to "20251026"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with loan product`s charges and following data:
      | LoanProduct                                      | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_ZERO_INTEREST_CHARGE_OFF_BEHAVIOUR | 20251026   | 4              | 0                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 3                 | MONTHS                | 1              | MONTHS                 | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20251026" with "2" amount and expected disbursement date on "20251026"
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20251026  |                  | 2.0             |               |          | 0.0  |           | 0.0   |      |            |      | 0.0         |
      | 1  | 31   | 20251126 |                  | 1.0             | 1.0           | 0.0      | 0.0  | 0.0       | 1.0   | 0.0  | 0.0        | 0.0  | 1.0         |
      | 2  | 30   | 20251226 |                  | 0.0             | 1.0           | 0.0      | 0.0  | 0.0       | 1.0   | 0.0  | 0.0        | 0.0  | 1.0         |
      | 3  | 31   | 20260126  |                  | 0.0             | 0.0           | 0.0      | 0.0  | 0.0       | 0.0   | 0.0  | 0.0        | 0.0  | 0.0         |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 2.0           | 0.0      | 0.0  | 0.0       | 2.0    | 0.0  | 0.0        | 0.0  | 2.0         |
    When Admin successfully disburse the loan on "20251026" with "4" EUR transaction amount
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20251026  |                  | 4.0             |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 31   | 20251126 |                  | 3.0             | 1.0           | 0.0      | 0.0  | 0.0       | 1.0   | 0.0  | 0.0        | 0.0  | 1.0         |
      | 2  | 30   | 20251226 |                  | 2.0             | 1.0           | 0.0      | 0.0  | 0.0       | 1.0   | 0.0  | 0.0        | 0.0  | 1.0         |
      | 3  | 31   | 20260126  |                  | 0.0             | 2.0           | 0.0      | 0.0  | 0.0       | 2.0   | 0.0  | 0.0        | 0.0  | 2.0         |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 4.0           | 0.0      | 0.0  | 0.0       | 4.0    | 0.0  | 0.0        | 0.0  | 4.0         |
    Then Loan Transactions tab has the following data:
      | Transaction date   | Transaction Type | Amount  | Principal | Interest | Fees | Penalties  | Loan Balance | Reverted | Replayed |
      | 20251026    | Disbursement     | 4.0     | 0.0       |  0.0     | 0.0  | 0.0        | 4.0          | false    | false    |
    When Admin sets the business date to "20251027"
    When Loan Pay-off is made on "20251027"
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20251026  |                  | 4.0             |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 31   | 20251126 | 20251027  | 3.0             | 1.0           | 0.0      | 0.0  | 0.0       | 1.0   | 1.0  | 1.0        | 0.0  | 0.0         |
      | 2  | 30   | 20251226 | 20251027  | 2.0             | 1.0           | 0.0      | 0.0  | 0.0       | 1.0   | 1.0  | 1.0        | 0.0  | 0.0         |
      | 3  | 31   | 20260126  | 20251027  | 0.0             | 2.0           | 0.0      | 0.0  | 0.0       | 2.0   | 2.0  | 2.0        | 0.0  | 0.0         |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 4.0           | 0.0      | 0.0  | 0.0       | 4.0    | 4.0  | 4.0        | 0.0  | 0.0         |
    Then Loan Transactions tab has the following data:
      | Transaction date   | Transaction Type | Amount  | Principal | Interest | Fees | Penalties  | Loan Balance | Reverted | Replayed |
      | 20251026    | Disbursement     | 4.0     | 0.0       |  0.0     | 0.0  | 0.0        | 4.0          | false    | false    |
      | 20251027    | Repayment        | 4.0     | 4.0       |  0.0     | 0.0  | 0.0        | 0.0          | false    | false    |
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

