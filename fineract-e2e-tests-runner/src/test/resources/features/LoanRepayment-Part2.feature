@Repayment
Feature: LoanRepayment - Part2

  @TestRailId:C2632
  Scenario: RP14 - Repayment Schedule with interest type: Declining Balance - Interest Recalculation Frequency: Same as Repayment Period - Partial payment
    When Admin sets the business date to "20221101"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                           | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy                        |
      | LP1_INTEREST_DECLINING_BALANCE_DAILY_RECALCULATION_SAME_AS_REPAYMENT_COMPOUNDING_NONE | 20221101  | 5000           | 12                     | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 6                 | MONTHS                | 1              | MONTHS                 | 6                  | 0                       | 0                      | 0                    | PENALTIES_FEES_INTEREST_PRINCIPAL_ORDER |
    And Admin successfully approves the loan on "20221101" with "5000" amount and expected disbursement date on "20231101"
    When Admin successfully disburse the loan on "20221101" with "5000" EUR transaction amount
    When Admin sets the business date to "20221120"
    And Customer makes "AUTOPAY" repayment on "20221120" with 200 EUR transaction amount
    When Admin sets the business date to "20230104"
    And Customer makes "AUTOPAY" repayment on "20230104" with 200 EUR transaction amount
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late  | Outstanding |
      |    |      | 20221101 |           | 5000.0          |               |          | 0.0  |           | 0.0    | 0.0   |            |       |             |
      | 1  | 30   | 20221201 |           | 4187.32         | 812.68        | 49.32    | 0.0  | 0.0       | 862.0  | 400.0 | 200.0      | 200.0 | 462.0       |
      | 2  | 31   | 20230101  |           | 3368.0          | 819.32        | 42.68    | 0.0  | 0.0       | 862.0  | 0.0   | 0.0        | 0.0   | 862.0       |
      | 3  | 31   | 20230201 |           | 2555.42         | 812.58        | 49.42    | 0.0  | 0.0       | 862.0  | 0.0   | 0.0        | 0.0   | 862.0       |
      | 4  | 28   | 20230301    |           | 1716.94         | 838.48        | 23.52    | 0.0  | 0.0       | 862.0  | 0.0   | 0.0        | 0.0   | 862.0       |
      | 5  | 31   | 20230401    |           | 872.44          | 844.5         | 17.5     | 0.0  | 0.0       | 862.0  | 0.0   | 0.0        | 0.0   | 862.0       |
      | 6  | 30   | 20230501      |           | 0.0             | 872.44        | 8.6      | 0.0  | 0.0       | 881.04 | 0.0   | 0.0        | 0.0   | 881.04      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid  | In advance | Late  | Outstanding |
      | 5000.0        | 191.04   | 0.0  | 0.0       | 5191.04 | 400.0 | 200.0      | 200.0 | 4791.04     |

  @TestRailId:C2633
  Scenario: RP15 - Repayment Schedule with interest type: Declining Balance - Interest Recalculation Frequency: Same as Repayment Period - Late payment
    When Admin sets the business date to "20221101"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                           | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy                        |
      | LP1_INTEREST_DECLINING_BALANCE_DAILY_RECALCULATION_SAME_AS_REPAYMENT_COMPOUNDING_NONE | 20221101  | 5000           | 12                     | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 6                 | MONTHS                | 1              | MONTHS                 | 6                  | 0                       | 0                      | 0                    | PENALTIES_FEES_INTEREST_PRINCIPAL_ORDER |
    And Admin successfully approves the loan on "20221101" with "5000" amount and expected disbursement date on "20231101"
    When Admin successfully disburse the loan on "20221101" with "5000" EUR transaction amount
    When Admin sets the business date to "20230201"
    And Customer makes "AUTOPAY" repayment on "20230201" with 862 EUR transaction amount
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late  | Outstanding |
      |    |      | 20221101 |                  | 5000.0          |               |          | 0.0  |           | 0.0    | 0.0   |            |       |             |
      | 1  | 30   | 20221201 | 20230201 | 4187.32         | 812.68        | 49.32    | 0.0  | 0.0       | 862.0  | 862.0 | 0.0        | 862.0 | 0.0         |
      | 2  | 31   | 20230101  |                  | 3368.0          | 819.32        | 42.68    | 0.0  | 0.0       | 862.0  | 0.0   | 0.0        | 0.0   | 862.0       |
      | 3  | 31   | 20230201 |                  | 2556.96         | 811.04        | 50.96    | 0.0  | 0.0       | 862.0  | 0.0   | 0.0        | 0.0   | 862.0       |
      | 4  | 28   | 20230301    |                  | 1718.5          | 838.46        | 23.54    | 0.0  | 0.0       | 862.0  | 0.0   | 0.0        | 0.0   | 862.0       |
      | 5  | 31   | 20230401    |                  | 874.01          | 844.49        | 17.51    | 0.0  | 0.0       | 862.0  | 0.0   | 0.0        | 0.0   | 862.0       |
      | 6  | 30   | 20230501      |                  | 0.0             | 874.01        | 8.62     | 0.0  | 0.0       | 882.63 | 0.0   | 0.0        | 0.0   | 882.63      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid  | In advance | Late  | Outstanding |
      | 5000.0        | 192.63   | 0.0  | 0.0       | 5192.63 | 862.0 | 0.0        | 862.0 | 4330.63     |

  @TestRailId:C2634
  Scenario: RP16 - Repayment Schedule with interest type: Declining Balance - Interest Recalculation Frequency: Same as Repayment Period - Multi-disbursement
    When Admin sets the business date to "20221101"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                                   | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy                        |
      | LP1_INTEREST_DECLINING_BALANCE_SAR_RECALCULATION_SAME_AS_REPAYMENT_COMPOUNDING_NONE_MULTIDISB | 20221101  | 10000          | 12                     | DECLINING_BALANCE | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 6                 | MONTHS                | 1              | MONTHS                 | 6                  | 0                       | 0                      | 0                    | PENALTIES_FEES_INTEREST_PRINCIPAL_ORDER |
    And Admin successfully approves the loan on "20221101" with "10000" amount and expected disbursement date on "20231101"
    When Admin successfully disburse the loan on "20221101" with "5000" EUR transaction amount
    When Admin sets the business date to "20221201"
    And Customer makes "AUTOPAY" repayment on "20221201" with 1725 EUR transaction amount
    When Admin sets the business date to "20230101"
    When Admin successfully disburse the loan on "20230101" with "3000" EUR transaction amount
    And Customer makes "AUTOPAY" repayment on "20230101" with 1725 EUR transaction amount
    When Admin sets the business date to "20230201"
    And Customer makes "AUTOPAY" repayment on "20230201" with 1725 EUR transaction amount
    When Admin sets the business date to "20230301"
    When Admin successfully disburse the loan on "20230301" with "2000" EUR transaction amount
    And Customer makes "AUTOPAY" repayment on "20230301" with 1725 EUR transaction amount
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due     | Paid   | In advance | Late | Outstanding |
      |    |      | 20221101 |                  | 5000.0          |               |          | 0.0  |           | 0.0     | 0.0    |            |      |             |
      | 1  | 30   | 20221201 | 20221201 | 3325.0          | 1675.0        | 50.0     | 0.0  | 0.0       | 1725.0  | 1725.0 | 0.0        | 0.0  | 0.0         |
      |    |      | 20230101  |                  | 3000.0          |               |          | 0.0  |           | 0.0     | 0.0    |            |      |             |
      | 2  | 31   | 20230101  | 20230101  | 4633.25         | 1691.75       | 33.25    | 0.0  | 0.0       | 1725.0  | 1725.0 | 0.0        | 0.0  | 0.0         |
      | 3  | 31   | 20230201 | 20230201 | 2954.58         | 1678.67       | 46.33    | 0.0  | 0.0       | 1725.0  | 1725.0 | 0.0        | 0.0  | 0.0         |
      |    |      | 20230301    |                  | 2000.0          |               |          | 0.0  |           | 0.0     | 0.0    |            |      |             |
      | 4  | 28   | 20230301    | 20230301    | 3259.13         | 1695.45       | 29.55    | 0.0  | 0.0       | 1725.0  | 1725.0 | 0.0        | 0.0  | 0.0         |
      | 5  | 31   | 20230401    |                  | 1566.72         | 1692.41       | 32.59    | 0.0  | 0.0       | 1725.0  | 0.0    | 0.0        | 0.0  | 1725.0      |
      | 6  | 30   | 20230501      |                  | 0.0             | 1566.72       | 15.67    | 0.0  | 0.0       | 1582.39 | 0.0    | 0.0        | 0.0  | 1582.39     |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due      | Paid   | In advance | Late | Outstanding |
      | 10000.0       | 207.39   | 0.0  | 0.0       | 10207.39 | 6900.0 | 0.0        | 0.0  | 3307.39     |

  @TestRailId:C2636 @PaymentStrategyDueInAdvance
  Scenario: Verify the due-penalty-fee-interest-principal-in-advance-principal-penalty-fee-interest-strategy payment strategy - adding charge due in the future
    When Admin sets the business date to "20230101"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                         | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy                                                             |
      | LP1_PAYMENT_STRATEGY_DUE_IN_ADVANCE | 20230101    | 1000           | 0                      | DECLINING_BALANCE | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 1                 | MONTHS                | 1              | MONTHS                 | 1                  | 0                       | 0                      | 0                    | DUE_PENALTY_FEE_INTEREST_PRINCIPAL_IN_ADVANCE_PRINCIPAL_PENALTY_FEE_INTEREST |
    And Admin successfully approves the loan on "20230101" with "1000" amount and expected disbursement date on "20230101"
    When Admin successfully disburse the loan on "20230101" with "1000" EUR transaction amount
    When Admin sets the business date to "20230110"
    And Customer makes "AUTOPAY" repayment on "20230110" with 500 EUR transaction amount
    When Admin sets the business date to "20230115"
    When Admin adds "LOAN_NSF_FEE" due date charge with "20230120" due date and 50 EUR transaction amount
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20230101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
      | 20230110  | Repayment        | 500.0  | 500.0     | 0.0      | 0.0  | 0.0       | 500.0        |
    Then Loan Charges tab has the following data:
      | Name    | isPenalty | Payment due at     | Due as of       | Calculation type | Due  | Paid | Waived | Outstanding |
      | NSF fee | true      | Specified due date | 20230120 | Flat             | 50.0 | 0.0  | 0.0    | 50.0        |
    Then Loan Repayment schedule has 1 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      |    |      | 20230101  |           | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0   |            |      |             |
      | 1  | 31   | 20230201 |           | 0.0             | 1000.0        | 0.0      | 0.0  | 50.0      | 1050.0 | 500.0 | 500.0      | 0.0  | 550.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due  | Paid | In advance | Late | Outstanding |
      | 1000          | 0        | 0    | 50        | 1050 | 500  | 500        | 0    | 550         |

  @TestRailId:C2637 @PaymentStrategyDueInAdvance
  Scenario: Verify the due-penalty-fee-interest-principal-in-advance-principal-penalty-fee-interest-strategy payment strategy - adding charge due in the future, then repayments before and after charge due date
    When Admin sets the business date to "20230101"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                         | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy                                                             |
      | LP1_PAYMENT_STRATEGY_DUE_IN_ADVANCE | 20230101    | 1000           | 0                      | DECLINING_BALANCE | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 1                 | MONTHS                | 1              | MONTHS                 | 1                  | 0                       | 0                      | 0                    | DUE_PENALTY_FEE_INTEREST_PRINCIPAL_IN_ADVANCE_PRINCIPAL_PENALTY_FEE_INTEREST |
    And Admin successfully approves the loan on "20230101" with "1000" amount and expected disbursement date on "20230101"
    When Admin successfully disburse the loan on "20230101" with "1000" EUR transaction amount
    When Admin sets the business date to "20230110"
    And Customer makes "AUTOPAY" repayment on "20230110" with 500 EUR transaction amount
    When Admin sets the business date to "20230115"
    When Admin adds "LOAN_NSF_FEE" due date charge with "20230120" due date and 50 EUR transaction amount
    When Admin sets the business date to "20230117"
    And Customer makes "AUTOPAY" repayment on "20230117" with 450 EUR transaction amount
    When Admin sets the business date to "20230121"
    And Customer makes "AUTOPAY" repayment on "20230121" with 50 EUR transaction amount
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20230101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
      | 20230110  | Repayment        | 500.0  | 500.0     | 0.0      | 0.0  | 0.0       | 500.0        |
      | 20230117  | Repayment        | 450.0  | 450.0     | 0.0      | 0.0  | 0.0       | 50.0         |
      | 20230121  | Repayment        | 50.0   | 0.0       | 0.0      | 0.0  | 50.0      | 50.0         |
    Then Loan Charges tab has the following data:
      | Name    | isPenalty | Payment due at     | Due as of       | Calculation type | Due  | Paid | Waived | Outstanding |
      | NSF fee | true      | Specified due date | 20230120 | Flat             | 50.0 | 50.0 | 0.0    | 0.0         |
    Then Loan Repayment schedule has 1 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late | Outstanding |
      |    |      | 20230101  |           | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0    |            |      |             |
      | 1  | 31   | 20230201 |           | 0.0             | 1000.0        | 0.0      | 0.0  | 50.0      | 1050.0 | 1000.0 | 1000.0     | 0.0  | 50.0        |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due  | Paid | In advance | Late | Outstanding |
      | 1000          | 0        | 0    | 50        | 1050 | 1000 | 1000       | 0    | 50          |

  @TestRailId:C2638 @PaymentStrategyDueInAdvance
  Scenario: Verify the due-penalty-fee-interest-principal-in-advance-principal-penalty-fee-interest-strategy payment strategy - adding charge due in the future, then repayment before due date, new charge with due date in future and repayment on first charge due date
    When Admin sets the business date to "20230101"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                         | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy                                                             |
      | LP1_PAYMENT_STRATEGY_DUE_IN_ADVANCE | 20230101    | 1000           | 0                      | DECLINING_BALANCE | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 1                 | MONTHS                | 1              | MONTHS                 | 1                  | 0                       | 0                      | 0                    | DUE_PENALTY_FEE_INTEREST_PRINCIPAL_IN_ADVANCE_PRINCIPAL_PENALTY_FEE_INTEREST |
    And Admin successfully approves the loan on "20230101" with "1000" amount and expected disbursement date on "20230101"
    When Admin successfully disburse the loan on "20230101" with "1000" EUR transaction amount
    When Admin sets the business date to "20230110"
    And Customer makes "AUTOPAY" repayment on "20230110" with 500 EUR transaction amount
    When Admin sets the business date to "20230115"
    When Admin adds "LOAN_NSF_FEE" due date charge with "20230120" due date and 50 EUR transaction amount
    When Admin sets the business date to "20230117"
    And Customer makes "AUTOPAY" repayment on "20230117" with 100 EUR transaction amount
    When Admin sets the business date to "20230119"
    When Admin adds "LOAN_NSF_FEE" due date charge with "20230123" due date and 10 EUR transaction amount
    When Admin sets the business date to "20230120"
    And Customer makes "AUTOPAY" repayment on "20230120" with 100 EUR transaction amount
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20230101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
      | 20230110  | Repayment        | 500.0  | 500.0     | 0.0      | 0.0  | 0.0       | 500.0        |
      | 20230117  | Repayment        | 100.0  | 100.0     | 0.0      | 0.0  | 0.0       | 400.0        |
      | 20230120  | Repayment        | 100.0  | 50.0      | 0.0      | 0.0  | 50.0      | 350.0        |
    Then Loan Charges tab has the following data:
      | Name    | isPenalty | Payment due at     | Due as of       | Calculation type | Due  | Paid | Waived | Outstanding |
      | NSF fee | true      | Specified due date | 20230120 | Flat             | 50.0 | 50.0 | 0.0    | 0.0         |
      | NSF fee | true      | Specified due date | 20230123 | Flat             | 10.0 | 0.0  | 0.0    | 10.0        |
    Then Loan Repayment schedule has 1 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      |    |      | 20230101  |           | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0   |            |      |             |
      | 1  | 31   | 20230201 |           | 0.0             | 1000.0        | 0.0      | 0.0  | 60.0      | 1060.0 | 700.0 | 700.0      | 0.0  | 360.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due  | Paid | In advance | Late | Outstanding |
      | 1000          | 0        | 0    | 60        | 1060 | 700  | 700        | 0    | 360         |

  @TestRailId:C2639 @PaymentStrategyDueInAdvance
  Scenario: Verify the due-penalty-fee-interest-principal-in-advance-principal-penalty-fee-interest-strategy payment strategy - adding charge due in the future, then repayment before due date with full amount
    When Admin sets the business date to "20230101"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                         | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy                                                             |
      | LP1_PAYMENT_STRATEGY_DUE_IN_ADVANCE | 20230101    | 1000           | 0                      | DECLINING_BALANCE | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 1                 | MONTHS                | 1              | MONTHS                 | 1                  | 0                       | 0                      | 0                    | DUE_PENALTY_FEE_INTEREST_PRINCIPAL_IN_ADVANCE_PRINCIPAL_PENALTY_FEE_INTEREST |
    And Admin successfully approves the loan on "20230101" with "1000" amount and expected disbursement date on "20230101"
    When Admin successfully disburse the loan on "20230101" with "1000" EUR transaction amount
    When Admin sets the business date to "20230110"
    And Customer makes "AUTOPAY" repayment on "20230110" with 500 EUR transaction amount
    When Admin sets the business date to "20230115"
    When Admin adds "LOAN_NSF_FEE" due date charge with "20230120" due date and 50 EUR transaction amount
    When Admin sets the business date to "20230117"
    And Customer makes "AUTOPAY" repayment on "20230117" with 550 EUR transaction amount
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20230101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
      | 20230110  | Repayment        | 500.0  | 500.0     | 0.0      | 0.0  | 0.0       | 500.0        |
      | 20230117  | Repayment        | 550.0  | 500.0     | 0.0      | 0.0  | 50.0      | 0.0          |
      | 20230117  | Accrual          | 50.0   | 0.0       | 0.0      | 0.0  | 50.0      | 0.0          |
    Then Loan Charges tab has the following data:
      | Name    | isPenalty | Payment due at     | Due as of       | Calculation type | Due  | Paid | Waived | Outstanding |
      | NSF fee | true      | Specified due date | 20230120 | Flat             | 50.0 | 50.0 | 0.0    | 0.0         |
    Then Loan Repayment schedule has 1 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late | Outstanding |
      |    |      | 20230101  |                 | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0    |            |      |             |
      | 1  | 31   | 20230201 | 20230117 | 0.0             | 1000.0        | 0.0      | 0.0  | 50.0      | 1050.0 | 1050.0 | 1050.0     | 0.0  | 0.0         |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due  | Paid | In advance | Late | Outstanding |
      | 1000          | 0        | 0    | 50        | 1050 | 1050 | 1050       | 0    | 0           |

  @TestRailId:C2655 @PaymentStrategyDueInAdvance
  Scenario: Verify the due-penalty-fee-interest-principal-in-advance-principal-penalty-fee-interest-strategy payment strategy - due principal
    When Admin sets the business date to "20230101"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                         | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy                                                             |
      | LP1_PAYMENT_STRATEGY_DUE_IN_ADVANCE | 20230101   | 3000           | 0                      | DECLINING_BALANCE | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 3                 | MONTHS                | 1              | MONTHS                 | 3                  | 0                       | 0                      | 0                    | DUE_PENALTY_FEE_INTEREST_PRINCIPAL_IN_ADVANCE_PRINCIPAL_PENALTY_FEE_INTEREST |
    And Admin successfully approves the loan on "20230101" with "3000" amount and expected disbursement date on "20230101"
    When Admin successfully disburse the loan on "20230101" with "3000" EUR transaction amount
    When Admin sets the business date to "20230201"
    And Customer makes "AUTOPAY" repayment on "20230201" with 1000 EUR transaction amount
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20230101  | Disbursement     | 3000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 3000.0       |
      | 20230201 | Repayment        | 1000.0 | 1000.0    | 0.0      | 0.0  | 0.0       | 2000.0       |
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late | Outstanding |
      |    |      | 20230101  |                  | 3000.0          |               |          | 0.0  |           | 0.0    | 0.0    |            |      |             |
      | 1  | 31   | 20230201 | 20230201 | 2000.0          | 1000.0        | 0.0      | 0.0  | 0.0       | 1000.0 | 1000.0 | 0.0        | 0.0  | 0.0         |
      | 2  | 28   | 20230301    |                  | 1000.0          | 1000.0        | 0.0      | 0.0  | 0.0       | 1000.0 | 0.0    | 0.0        | 0.0  | 1000.0      |
      | 3  | 31   | 20230401    |                  | 0.0             | 1000.0        | 0.0      | 0.0  | 0.0       | 1000.0 | 0.0    | 0.0        | 0.0  | 1000.0      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due  | Paid | In advance | Late | Outstanding |
      | 3000          | 0        | 0    | 0         | 3000 | 1000 | 0          | 0    | 2000        |

  @TestRailId:C2656 @PaymentStrategyDueInAdvance
  Scenario: Verify the due-penalty-fee-interest-principal-in-advance-principal-penalty-fee-interest-strategy payment strategy - inAdvance principal
    When Admin sets the business date to "20230101"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                         | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy                                                             |
      | LP1_PAYMENT_STRATEGY_DUE_IN_ADVANCE | 20230101   | 3000           | 0                      | DECLINING_BALANCE | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 3                 | MONTHS                | 1              | MONTHS                 | 3                  | 0                       | 0                      | 0                    | DUE_PENALTY_FEE_INTEREST_PRINCIPAL_IN_ADVANCE_PRINCIPAL_PENALTY_FEE_INTEREST |
    And Admin successfully approves the loan on "20230101" with "3000" amount and expected disbursement date on "20230101"
    When Admin successfully disburse the loan on "20230101" with "3000" EUR transaction amount
    When Admin sets the business date to "20230110"
    And Customer makes "AUTOPAY" repayment on "20230110" with 1000 EUR transaction amount
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20230101  | Disbursement     | 3000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 3000.0       |
      | 20230110  | Repayment        | 1000.0 | 1000.0    | 0.0      | 0.0  | 0.0       | 2000.0       |
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late | Outstanding |
      |    |      | 20230101  |                 | 3000.0          |               |          | 0.0  |           | 0.0    | 0.0    |            |      |             |
      | 1  | 31   | 20230201 | 20230110 | 2000.0          | 1000.0        | 0.0      | 0.0  | 0.0       | 1000.0 | 1000.0 | 1000.0     | 0.0  | 0.0         |
      | 2  | 28   | 20230301    |                 | 1000.0          | 1000.0        | 0.0      | 0.0  | 0.0       | 1000.0 | 0.0    | 0.0        | 0.0  | 1000.0      |
      | 3  | 31   | 20230401    |                 | 0.0             | 1000.0        | 0.0      | 0.0  | 0.0       | 1000.0 | 0.0    | 0.0        | 0.0  | 1000.0      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due  | Paid | In advance | Late | Outstanding |
      | 3000          | 0        | 0    | 0         | 3000 | 1000 | 1000       | 0    | 2000        |

  @TestRailId:C2657 @PaymentStrategyDueInAdvance
  Scenario: Verify the due-penalty-fee-interest-principal-in-advance-principal-penalty-fee-interest-strategy payment strategy - due + inAdvance principal
    When Admin sets the business date to "20230101"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                         | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy                                                             |
      | LP1_PAYMENT_STRATEGY_DUE_IN_ADVANCE | 20230101   | 3000           | 0                      | DECLINING_BALANCE | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 3                 | MONTHS                | 1              | MONTHS                 | 3                  | 0                       | 0                      | 0                    | DUE_PENALTY_FEE_INTEREST_PRINCIPAL_IN_ADVANCE_PRINCIPAL_PENALTY_FEE_INTEREST |
    And Admin successfully approves the loan on "20230101" with "3000" amount and expected disbursement date on "20230101"
    When Admin successfully disburse the loan on "20230101" with "3000" EUR transaction amount
    When Admin sets the business date to "20230201"
    And Customer makes "AUTOPAY" repayment on "20230201" with 1500 EUR transaction amount
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20230101  | Disbursement     | 3000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 3000.0       |
      | 20230201 | Repayment        | 1500.0 | 1500.0    | 0.0      | 0.0  | 0.0       | 1500.0       |
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late | Outstanding |
      |    |      | 20230101  |                  | 3000.0          |               |          | 0.0  |           | 0.0    | 0.0    |            |      |             |
      | 1  | 31   | 20230201 | 20230201 | 2000.0          | 1000.0        | 0.0      | 0.0  | 0.0       | 1000.0 | 1000.0 | 0.0        | 0.0  | 0.0         |
      | 2  | 28   | 20230301    |                  | 1000.0          | 1000.0        | 0.0      | 0.0  | 0.0       | 1000.0 | 500.0  | 500.0      | 0.0  | 500.0       |
      | 3  | 31   | 20230401    |                  | 0.0             | 1000.0        | 0.0      | 0.0  | 0.0       | 1000.0 | 0.0    | 0.0        | 0.0  | 1000.0      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due  | Paid | In advance | Late | Outstanding |
      | 3000          | 0        | 0    | 0         | 3000 | 1500 | 500        | 0    | 1500        |

  @TestRailId:C2658 @PaymentStrategyDueInAdvance
  Scenario: Verify the due-penalty-fee-interest-principal-in-advance-principal-penalty-fee-interest-strategy payment strategy - due penalty + due principal
    When Admin sets the business date to "20230101"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                         | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy                                                             |
      | LP1_PAYMENT_STRATEGY_DUE_IN_ADVANCE | 20230101   | 3000           | 0                      | DECLINING_BALANCE | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 3                 | MONTHS                | 1              | MONTHS                 | 3                  | 0                       | 0                      | 0                    | DUE_PENALTY_FEE_INTEREST_PRINCIPAL_IN_ADVANCE_PRINCIPAL_PENALTY_FEE_INTEREST |
    And Admin successfully approves the loan on "20230101" with "3000" amount and expected disbursement date on "20230101"
    When Admin successfully disburse the loan on "20230101" with "3000" EUR transaction amount
    When Admin sets the business date to "20230201"
    When Admin adds "LOAN_NSF_FEE" due date charge with "20230201" due date and 50 EUR transaction amount
    And Customer makes "AUTOPAY" repayment on "20230201" with 500 EUR transaction amount
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20230101  | Disbursement     | 3000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 3000.0       |
      | 20230201 | Repayment        | 500.0  | 450.0     | 0.0      | 0.0  | 50.0      | 2550.0       |
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      |    |      | 20230101  |           | 3000.0          |               |          | 0.0  |           | 0.0    | 0.0   |            |      |             |
      | 1  | 31   | 20230201 |           | 2000.0          | 1000.0        | 0.0      | 0.0  | 50.0      | 1050.0 | 500.0 | 0.0        | 0.0  | 550.0       |
      | 2  | 28   | 20230301    |           | 1000.0          | 1000.0        | 0.0      | 0.0  | 0.0       | 1000.0 | 0.0   | 0.0        | 0.0  | 1000.0      |
      | 3  | 31   | 20230401    |           | 0.0             | 1000.0        | 0.0      | 0.0  | 0.0       | 1000.0 | 0.0   | 0.0        | 0.0  | 1000.0      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due  | Paid | In advance | Late | Outstanding |
      | 3000          | 0        | 0    | 50        | 3050 | 500  | 0          | 0    | 2550        |

  @TestRailId:C2659 @PaymentStrategyDueInAdvance
  Scenario: Verify the due-penalty-fee-interest-principal-in-advance-principal-penalty-fee-interest-strategy payment strategy - due fee + due principal
    When Admin sets the business date to "20230101"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                         | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy                                                             |
      | LP1_PAYMENT_STRATEGY_DUE_IN_ADVANCE | 20230101   | 3000           | 0                      | DECLINING_BALANCE | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 3                 | MONTHS                | 1              | MONTHS                 | 3                  | 0                       | 0                      | 0                    | DUE_PENALTY_FEE_INTEREST_PRINCIPAL_IN_ADVANCE_PRINCIPAL_PENALTY_FEE_INTEREST |
    And Admin successfully approves the loan on "20230101" with "3000" amount and expected disbursement date on "20230101"
    When Admin successfully disburse the loan on "20230101" with "3000" EUR transaction amount
    When Admin sets the business date to "20230201"
    When Admin adds "LOAN_SNOOZE_FEE" due date charge with "20230201" due date and 50 EUR transaction amount
    And Customer makes "AUTOPAY" repayment on "20230201" with 500 EUR transaction amount
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20230101  | Disbursement     | 3000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 3000.0       |
      | 20230201 | Repayment        | 500.0  | 450.0     | 0.0      | 50.0 | 0.0       | 2550.0       |
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      |    |      | 20230101  |           | 3000.0          |               |          | 0.0  |           | 0.0    | 0.0   |            |      |             |
      | 1  | 31   | 20230201 |           | 2000.0          | 1000.0        | 0.0      | 50.0 | 0.0       | 1050.0 | 500.0 | 0.0        | 0.0  | 550.0       |
      | 2  | 28   | 20230301    |           | 1000.0          | 1000.0        | 0.0      | 0.0  | 0.0       | 1000.0 | 0.0   | 0.0        | 0.0  | 1000.0      |
      | 3  | 31   | 20230401    |           | 0.0             | 1000.0        | 0.0      | 0.0  | 0.0       | 1000.0 | 0.0   | 0.0        | 0.0  | 1000.0      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due  | Paid | In advance | Late | Outstanding |
      | 3000          | 0        | 50   | 0         | 3050 | 500  | 0          | 0    | 2550        |

  @TestRailId:C2660 @PaymentStrategyDueInAdvance
  Scenario: Verify the due-penalty-fee-interest-principal-in-advance-principal-penalty-fee-interest-strategy payment strategy - due interest + due principal
    When Admin sets the business date to "20230101"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                       | submitted on date | with Principal | ANNUAL interest rate % | interest type | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy                                                             |
      | LP1_PAYMENT_STRATEGY_DUE_IN_ADVANCE_INTEREST_FLAT | 20230101   | 3000           | 12                     | FLAT          | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 3                 | MONTHS                | 1              | MONTHS                 | 3                  | 0                       | 0                      | 0                    | DUE_PENALTY_FEE_INTEREST_PRINCIPAL_IN_ADVANCE_PRINCIPAL_PENALTY_FEE_INTEREST |
    And Admin successfully approves the loan on "20230101" with "3000" amount and expected disbursement date on "20230101"
    When Admin successfully disburse the loan on "20230101" with "3000" EUR transaction amount
    When Admin sets the business date to "20230201"
    And Customer makes "AUTOPAY" repayment on "20230201" with 500 EUR transaction amount
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20230101  | Disbursement     | 3000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 3000.0       |
      | 20230201 | Repayment        | 500.0  | 470.0     | 30.0     | 0.0  | 0.0       | 2530.0       |
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      |    |      | 20230101  |           | 3000.0          |               |          | 0.0  |           | 0.0    | 0.0   |            |      |             |
      | 1  | 31   | 20230201 |           | 2000.0          | 1000.0        | 30.0     | 0.0  | 0.0       | 1030.0 | 500.0 | 0.0        | 0.0  | 530.0       |
      | 2  | 28   | 20230301    |           | 1000.0          | 1000.0        | 30.0     | 0.0  | 0.0       | 1030.0 | 0.0   | 0.0        | 0.0  | 1030.0      |
      | 3  | 31   | 20230401    |           | 0.0             | 1000.0        | 30.0     | 0.0  | 0.0       | 1030.0 | 0.0   | 0.0        | 0.0  | 1030.0      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due  | Paid | In advance | Late | Outstanding |
      | 3000          | 90       | 0    | 0         | 3090 | 500  | 0          | 0    | 2590        |

  @TestRailId:C2661 @PaymentStrategyDueInAdvance
  Scenario: Verify the due-penalty-fee-interest-principal-in-advance-principal-penalty-fee-interest-strategy payment strategy - due penalty + due fee + due principal
    When Admin sets the business date to "20230101"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                         | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy                                                             |
      | LP1_PAYMENT_STRATEGY_DUE_IN_ADVANCE | 20230101   | 3000           | 0                      | DECLINING_BALANCE | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 3                 | MONTHS                | 1              | MONTHS                 | 3                  | 0                       | 0                      | 0                    | DUE_PENALTY_FEE_INTEREST_PRINCIPAL_IN_ADVANCE_PRINCIPAL_PENALTY_FEE_INTEREST |
    And Admin successfully approves the loan on "20230101" with "3000" amount and expected disbursement date on "20230101"
    When Admin successfully disburse the loan on "20230101" with "3000" EUR transaction amount
    When Admin sets the business date to "20230201"
    When Admin adds "LOAN_NSF_FEE" due date charge with "20230201" due date and 50 EUR transaction amount
    When Admin adds "LOAN_SNOOZE_FEE" due date charge with "20230201" due date and 50 EUR transaction amount
    And Customer makes "AUTOPAY" repayment on "20230201" with 500 EUR transaction amount
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20230101  | Disbursement     | 3000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 3000.0       |
      | 20230201 | Repayment        | 500.0  | 400.0     | 0.0      | 50.0 | 50.0      | 2600.0       |
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      |    |      | 20230101  |           | 3000.0          |               |          | 0.0  |           | 0.0    | 0.0   |            |      |             |
      | 1  | 31   | 20230201 |           | 2000.0          | 1000.0        | 0.0      | 50.0 | 50.0      | 1100.0 | 500.0 | 0.0        | 0.0  | 600.0       |
      | 2  | 28   | 20230301    |           | 1000.0          | 1000.0        | 0.0      | 0.0  | 0.0       | 1000.0 | 0.0   | 0.0        | 0.0  | 1000.0      |
      | 3  | 31   | 20230401    |           | 0.0             | 1000.0        | 0.0      | 0.0  | 0.0       | 1000.0 | 0.0   | 0.0        | 0.0  | 1000.0      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due  | Paid | In advance | Late | Outstanding |
      | 3000          | 0        | 50   | 50        | 3100 | 500  | 0          | 0    | 2600        |

  @TestRailId:C2662 @PaymentStrategyDueInAdvance
  Scenario: Verify the due-penalty-fee-interest-principal-in-advance-principal-penalty-fee-interest-strategy payment strategy - due penalty + inAdvance principal
    When Admin sets the business date to "20230101"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                         | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy                                                             |
      | LP1_PAYMENT_STRATEGY_DUE_IN_ADVANCE | 20230101   | 3000           | 0                      | DECLINING_BALANCE | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 3                 | MONTHS                | 1              | MONTHS                 | 3                  | 0                       | 0                      | 0                    | DUE_PENALTY_FEE_INTEREST_PRINCIPAL_IN_ADVANCE_PRINCIPAL_PENALTY_FEE_INTEREST |
    And Admin successfully approves the loan on "20230101" with "3000" amount and expected disbursement date on "20230101"
    When Admin successfully disburse the loan on "20230101" with "3000" EUR transaction amount
    When Admin sets the business date to "20230115"
    When Admin adds "LOAN_NSF_FEE" due date charge with "20230115" due date and 50 EUR transaction amount
    And Customer makes "AUTOPAY" repayment on "20230115" with 500 EUR transaction amount
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20230101  | Disbursement     | 3000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 3000.0       |
      | 20230115  | Repayment        | 500.0  | 450.0     | 0.0      | 0.0  | 50.0      | 2550.0       |
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      |    |      | 20230101  |           | 3000.0          |               |          | 0.0  |           | 0.0    | 0.0   |            |      |             |
      | 1  | 31   | 20230201 |           | 2000.0          | 1000.0        | 0.0      | 0.0  | 50.0      | 1050.0 | 500.0 | 500.0      | 0.0  | 550.0       |
      | 2  | 28   | 20230301    |           | 1000.0          | 1000.0        | 0.0      | 0.0  | 0.0       | 1000.0 | 0.0   | 0.0        | 0.0  | 1000.0      |
      | 3  | 31   | 20230401    |           | 0.0             | 1000.0        | 0.0      | 0.0  | 0.0       | 1000.0 | 0.0   | 0.0        | 0.0  | 1000.0      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due  | Paid | In advance | Late | Outstanding |
      | 3000          | 0        | 0    | 50        | 3050 | 500  | 500        | 0    | 2550        |

  @TestRailId:C2663 @PaymentStrategyDueInAdvance
  Scenario: Verify the due-penalty-fee-interest-principal-in-advance-principal-penalty-fee-interest-strategy payment strategy - due penalty + inAdvance principal + inAdvance penalty not effective because of partial payment
    When Admin sets the business date to "20230101"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                         | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy                                                             |
      | LP1_PAYMENT_STRATEGY_DUE_IN_ADVANCE | 20230101   | 3000           | 0                      | DECLINING_BALANCE | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 3                 | MONTHS                | 1              | MONTHS                 | 3                  | 0                       | 0                      | 0                    | DUE_PENALTY_FEE_INTEREST_PRINCIPAL_IN_ADVANCE_PRINCIPAL_PENALTY_FEE_INTEREST |
    And Admin successfully approves the loan on "20230101" with "3000" amount and expected disbursement date on "20230101"
    When Admin successfully disburse the loan on "20230101" with "3000" EUR transaction amount
    When Admin sets the business date to "20230115"
    When Admin adds "LOAN_NSF_FEE" due date charge with "20230115" due date and 50 EUR transaction amount
    When Admin adds "LOAN_NSF_FEE" due date charge with "20230120" due date and 50 EUR transaction amount
    And Customer makes "AUTOPAY" repayment on "20230115" with 500 EUR transaction amount
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20230101  | Disbursement     | 3000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 3000.0       |
      | 20230115  | Repayment        | 500.0  | 450.0     | 0.0      | 0.0  | 50.0      | 2550.0       |
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      |    |      | 20230101  |           | 3000.0          |               |          | 0.0  |           | 0.0    | 0.0   |            |      |             |
      | 1  | 31   | 20230201 |           | 2000.0          | 1000.0        | 0.0      | 0.0  | 100.0     | 1100.0 | 500.0 | 500.0      | 0.0  | 600.0       |
      | 2  | 28   | 20230301    |           | 1000.0          | 1000.0        | 0.0      | 0.0  | 0.0       | 1000.0 | 0.0   | 0.0        | 0.0  | 1000.0      |
      | 3  | 31   | 20230401    |           | 0.0             | 1000.0        | 0.0      | 0.0  | 0.0       | 1000.0 | 0.0   | 0.0        | 0.0  | 1000.0      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due  | Paid | In advance | Late | Outstanding |
      | 3000          | 0        | 0    | 100       | 3100 | 500  | 500        | 0    | 2600        |

  @TestRailId:C2664 @PaymentStrategyDueInAdvance
  Scenario: Verify the due-penalty-fee-interest-principal-in-advance-principal-penalty-fee-interest-strategy payment strategy - due penalty + inAdvance principal + inAdvance penalty
    When Admin sets the business date to "20230101"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                         | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy                                                             |
      | LP1_PAYMENT_STRATEGY_DUE_IN_ADVANCE | 20230101   | 3000           | 0                      | DECLINING_BALANCE | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 3                 | MONTHS                | 1              | MONTHS                 | 3                  | 0                       | 0                      | 0                    | DUE_PENALTY_FEE_INTEREST_PRINCIPAL_IN_ADVANCE_PRINCIPAL_PENALTY_FEE_INTEREST |
    And Admin successfully approves the loan on "20230101" with "3000" amount and expected disbursement date on "20230101"
    When Admin successfully disburse the loan on "20230101" with "3000" EUR transaction amount
    When Admin sets the business date to "20230115"
    When Admin adds "LOAN_NSF_FEE" due date charge with "20230115" due date and 50 EUR transaction amount
    When Admin adds "LOAN_NSF_FEE" due date charge with "20230120" due date and 50 EUR transaction amount
    And Customer makes "AUTOPAY" repayment on "20230115" with 1100 EUR transaction amount
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20230101  | Disbursement     | 3000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 3000.0       |
      | 20230115  | Repayment        | 1100.0 | 1000.0    | 0.0      | 0.0  | 100.0     | 2000.0       |
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late | Outstanding |
      |    |      | 20230101  |                 | 3000.0          |               |          | 0.0  |           | 0.0    | 0.0    |            |      |             |
      | 1  | 31   | 20230201 | 20230115 | 2000.0          | 1000.0        | 0.0      | 0.0  | 100.0     | 1100.0 | 1100.0 | 1100.0     | 0.0  | 0.0         |
      | 2  | 28   | 20230301    |                 | 1000.0          | 1000.0        | 0.0      | 0.0  | 0.0       | 1000.0 | 0.0    | 0.0        | 0.0  | 1000.0      |
      | 3  | 31   | 20230401    |                 | 0.0             | 1000.0        | 0.0      | 0.0  | 0.0       | 1000.0 | 0.0    | 0.0        | 0.0  | 1000.0      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due  | Paid | In advance | Late | Outstanding |
      | 3000          | 0        | 0    | 100       | 3100 | 1100 | 1100       | 0    | 2000        |

  @TestRailId:C2665 @PaymentStrategyDueInAdvance
  Scenario: Verify the due-penalty-fee-interest-principal-in-advance-principal-penalty-fee-interest-strategy payment strategy - due penalty + inAdvance principal + inAdvance penalty + inAdvance fee
    When Admin sets the business date to "20230101"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                         | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy                                                             |
      | LP1_PAYMENT_STRATEGY_DUE_IN_ADVANCE | 20230101   | 3000           | 0                      | DECLINING_BALANCE | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 3                 | MONTHS                | 1              | MONTHS                 | 3                  | 0                       | 0                      | 0                    | DUE_PENALTY_FEE_INTEREST_PRINCIPAL_IN_ADVANCE_PRINCIPAL_PENALTY_FEE_INTEREST |
    And Admin successfully approves the loan on "20230101" with "3000" amount and expected disbursement date on "20230101"
    When Admin successfully disburse the loan on "20230101" with "3000" EUR transaction amount
    When Admin sets the business date to "20230115"
    When Admin adds "LOAN_NSF_FEE" due date charge with "20230115" due date and 50 EUR transaction amount
    When Admin adds "LOAN_NSF_FEE" due date charge with "20230120" due date and 50 EUR transaction amount
    When Admin adds "LOAN_SNOOZE_FEE" due date charge with "20230120" due date and 50 EUR transaction amount
    And Customer makes "AUTOPAY" repayment on "20230115" with 1150 EUR transaction amount
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20230101  | Disbursement     | 3000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 3000.0       |
      | 20230115  | Repayment        | 1150.0 | 1000.0    | 0.0      | 50.0 | 100.0     | 2000.0       |
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late | Outstanding |
      |    |      | 20230101  |                 | 3000.0          |               |          | 0.0  |           | 0.0    | 0.0    |            |      |             |
      | 1  | 31   | 20230201 | 20230115 | 2000.0          | 1000.0        | 0.0      | 50.0 | 100.0     | 1150.0 | 1150.0 | 1150.0     | 0.0  | 0.0         |
      | 2  | 28   | 20230301    |                 | 1000.0          | 1000.0        | 0.0      | 0.0  | 0.0       | 1000.0 | 0.0    | 0.0        | 0.0  | 1000.0      |
      | 3  | 31   | 20230401    |                 | 0.0             | 1000.0        | 0.0      | 0.0  | 0.0       | 1000.0 | 0.0    | 0.0        | 0.0  | 1000.0      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due  | Paid | In advance | Late | Outstanding |
      | 3000          | 0        | 50   | 100       | 3150 | 1150 | 1150       | 0    | 2000        |

  @TestRailId:C2666 @PaymentStrategyDueInAdvance
  Scenario: Verify the due-penalty-fee-interest-principal-in-advance-principal-penalty-fee-interest-strategy payment strategy - due penalty + inAdvance principal + inAdvance penalty + inAdvance fee + inAdvance interest
    When Admin sets the business date to "20230101"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                       | submitted on date | with Principal | ANNUAL interest rate % | interest type | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy                                                             |
      | LP1_PAYMENT_STRATEGY_DUE_IN_ADVANCE_INTEREST_FLAT | 20230101   | 3000           | 12                     | FLAT          | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 3                 | MONTHS                | 1              | MONTHS                 | 3                  | 0                       | 0                      | 0                    | DUE_PENALTY_FEE_INTEREST_PRINCIPAL_IN_ADVANCE_PRINCIPAL_PENALTY_FEE_INTEREST |
    And Admin successfully approves the loan on "20230101" with "3000" amount and expected disbursement date on "20230101"
    When Admin successfully disburse the loan on "20230101" with "3000" EUR transaction amount
    When Admin sets the business date to "20230115"
    When Admin adds "LOAN_NSF_FEE" due date charge with "20230115" due date and 50 EUR transaction amount
    When Admin adds "LOAN_NSF_FEE" due date charge with "20230120" due date and 50 EUR transaction amount
    When Admin adds "LOAN_SNOOZE_FEE" due date charge with "20230120" due date and 50 EUR transaction amount
    And Customer makes "AUTOPAY" repayment on "20230115" with 1180 EUR transaction amount
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20230101  | Disbursement     | 3000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 3000.0       |
      | 20230115  | Repayment        | 1180.0 | 1000.0    | 30.0     | 50.0 | 100.0     | 2000.0       |
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late | Outstanding |
      |    |      | 20230101  |                 | 3000.0          |               |          | 0.0  |           | 0.0    | 0.0    |            |      |             |
      | 1  | 31   | 20230201 | 20230115 | 2000.0          | 1000.0        | 30.0     | 50.0 | 100.0     | 1180.0 | 1180.0 | 1180.0     | 0.0  | 0.0         |
      | 2  | 28   | 20230301    |                 | 1000.0          | 1000.0        | 30.0     | 0.0  | 0.0       | 1030.0 | 0.0    | 0.0        | 0.0  | 1030.0      |
      | 3  | 31   | 20230401    |                 | 0.0             | 1000.0        | 30.0     | 0.0  | 0.0       | 1030.0 | 0.0    | 0.0        | 0.0  | 1030.0      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due  | Paid | In advance | Late | Outstanding |
      | 3000          | 90       | 50   | 100       | 3240 | 1180 | 1180       | 0    | 2060        |

  @TestRailId:C2667 @PaymentStrategyDueInAdvance
  Scenario: Verify the due-penalty-fee-interest-principal-in-advance-principal-penalty-fee-interest-strategy payment strategy - repayment + reversal
    When Admin sets the business date to "20230101"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                       | submitted on date | with Principal | ANNUAL interest rate % | interest type | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy                                                             |
      | LP1_PAYMENT_STRATEGY_DUE_IN_ADVANCE_INTEREST_FLAT | 20230101   | 3000           | 12                     | FLAT          | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 3                 | MONTHS                | 1              | MONTHS                 | 3                  | 0                       | 0                      | 0                    | DUE_PENALTY_FEE_INTEREST_PRINCIPAL_IN_ADVANCE_PRINCIPAL_PENALTY_FEE_INTEREST |
    And Admin successfully approves the loan on "20230101" with "3000" amount and expected disbursement date on "20230101"
    When Admin successfully disburse the loan on "20230101" with "3000" EUR transaction amount
    When Admin sets the business date to "20230115"
    When Admin adds "LOAN_NSF_FEE" due date charge with "20230115" due date and 50 EUR transaction amount
    When Admin adds "LOAN_NSF_FEE" due date charge with "20230120" due date and 50 EUR transaction amount
    When Admin adds "LOAN_SNOOZE_FEE" due date charge with "20230120" due date and 50 EUR transaction amount
    And Customer makes "AUTOPAY" repayment on "20230115" with 1180 EUR transaction amount
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20230101  | Disbursement     | 3000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 3000.0       |
      | 20230115  | Repayment        | 1180.0 | 1000.0    | 30.0     | 50.0 | 100.0     | 2000.0       |
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late | Outstanding |
      |    |      | 20230101  |                 | 3000.0          |               |          | 0.0  |           | 0.0    | 0.0    |            |      |             |
      | 1  | 31   | 20230201 | 20230115 | 2000.0          | 1000.0        | 30.0     | 50.0 | 100.0     | 1180.0 | 1180.0 | 1180.0     | 0.0  | 0.0         |
      | 2  | 28   | 20230301    |                 | 1000.0          | 1000.0        | 30.0     | 0.0  | 0.0       | 1030.0 | 0.0    | 0.0        | 0.0  | 1030.0      |
      | 3  | 31   | 20230401    |                 | 0.0             | 1000.0        | 30.0     | 0.0  | 0.0       | 1030.0 | 0.0    | 0.0        | 0.0  | 1030.0      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due  | Paid | In advance | Late | Outstanding |
      | 3000          | 90       | 50   | 100       | 3240 | 1180 | 1180       | 0    | 2060        |
    When Customer undo "1"th transaction made on "20230115"
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20230101  | Disbursement     | 3000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 3000.0       |
      | 20230115  | Repayment        | 1180.0 | 1000.0    | 30.0     | 50.0 | 100.0     | 2000.0       |
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      |    |      | 20230101  |           | 3000.0          |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      | 1  | 31   | 20230201 |           | 2000.0          | 1000.0        | 30.0     | 50.0 | 100.0     | 1180.0 | 0.0  | 0.0        | 0.0  | 1180.0      |
      | 2  | 28   | 20230301    |           | 1000.0          | 1000.0        | 30.0     | 0.0  | 0.0       | 1030.0 | 0.0  | 0.0        | 0.0  | 1030.0      |
      | 3  | 31   | 20230401    |           | 0.0             | 1000.0        | 30.0     | 0.0  | 0.0       | 1030.0 | 0.0  | 0.0        | 0.0  | 1030.0      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due  | Paid | In advance | Late | Outstanding |
      | 3000          | 90       | 50   | 100       | 3240 | 0    | 0          | 0    | 3240        |

  @TestRailId:C2668 @PaymentStrategyDueInAdvance
  Scenario: Verify the due-penalty-fee-interest-principal-in-advance-principal-penalty-fee-interest-strategy payment strategy - merchant issued refund + reversal
    When Admin sets the business date to "20230101"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                       | submitted on date | with Principal | ANNUAL interest rate % | interest type | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy                                                             |
      | LP1_PAYMENT_STRATEGY_DUE_IN_ADVANCE_INTEREST_FLAT | 20230101   | 3000           | 12                     | FLAT          | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 3                 | MONTHS                | 1              | MONTHS                 | 3                  | 0                       | 0                      | 0                    | DUE_PENALTY_FEE_INTEREST_PRINCIPAL_IN_ADVANCE_PRINCIPAL_PENALTY_FEE_INTEREST |
    And Admin successfully approves the loan on "20230101" with "3000" amount and expected disbursement date on "20230101"
    When Admin successfully disburse the loan on "20230101" with "3000" EUR transaction amount
    When Admin sets the business date to "20230115"
    When Admin adds "LOAN_NSF_FEE" due date charge with "20230115" due date and 50 EUR transaction amount
    When Admin adds "LOAN_NSF_FEE" due date charge with "20230120" due date and 50 EUR transaction amount
    When Admin adds "LOAN_SNOOZE_FEE" due date charge with "20230120" due date and 50 EUR transaction amount
    When Customer makes "MERCHANT_ISSUED_REFUND" transaction with "AUTOPAY" payment type on "20230115" with 1180 EUR transaction amount and system-generated Idempotency key
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type       | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20230101  | Disbursement           | 3000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 3000.0       |
      | 20230115  | Merchant Issued Refund | 1180.0 | 1000.0    | 30.0     | 50.0 | 100.0     | 2000.0       |
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late | Outstanding |
      |    |      | 20230101  |                 | 3000.0          |               |          | 0.0  |           | 0.0    | 0.0    |            |      |             |
      | 1  | 31   | 20230201 | 20230115 | 2000.0          | 1000.0        | 30.0     | 50.0 | 100.0     | 1180.0 | 1180.0 | 1180.0     | 0.0  | 0.0         |
      | 2  | 28   | 20230301    |                 | 1000.0          | 1000.0        | 30.0     | 0.0  | 0.0       | 1030.0 | 0.0    | 0.0        | 0.0  | 1030.0      |
      | 3  | 31   | 20230401    |                 | 0.0             | 1000.0        | 30.0     | 0.0  | 0.0       | 1030.0 | 0.0    | 0.0        | 0.0  | 1030.0      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due  | Paid | In advance | Late | Outstanding |
      | 3000          | 90       | 50   | 100       | 3240 | 1180 | 1180       | 0    | 2060        |
    When Customer undo "1"th transaction made on "20230115"
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type       | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20230101  | Disbursement           | 3000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 3000.0       |
      | 20230115  | Merchant Issued Refund | 1180.0 | 1000.0    | 30.0     | 50.0 | 100.0     | 2000.0       |
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      |    |      | 20230101  |           | 3000.0          |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      | 1  | 31   | 20230201 |           | 2000.0          | 1000.0        | 30.0     | 50.0 | 100.0     | 1180.0 | 0.0  | 0.0        | 0.0  | 1180.0      |
      | 2  | 28   | 20230301    |           | 1000.0          | 1000.0        | 30.0     | 0.0  | 0.0       | 1030.0 | 0.0  | 0.0        | 0.0  | 1030.0      |
      | 3  | 31   | 20230401    |           | 0.0             | 1000.0        | 30.0     | 0.0  | 0.0       | 1030.0 | 0.0  | 0.0        | 0.0  | 1030.0      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due  | Paid | In advance | Late | Outstanding |
      | 3000          | 90       | 50   | 100       | 3240 | 0    | 0          | 0    | 3240        |

  @TestRailId:C2669 @PaymentStrategyDueInAdvance
  Scenario: Verify the due-penalty-fee-interest-principal-in-advance-principal-penalty-fee-interest-strategy payment strategy - payout refund + reversal
    When Admin sets the business date to "20230101"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                       | submitted on date | with Principal | ANNUAL interest rate % | interest type | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy                                                             |
      | LP1_PAYMENT_STRATEGY_DUE_IN_ADVANCE_INTEREST_FLAT | 20230101   | 3000           | 12                     | FLAT          | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 3                 | MONTHS                | 1              | MONTHS                 | 3                  | 0                       | 0                      | 0                    | DUE_PENALTY_FEE_INTEREST_PRINCIPAL_IN_ADVANCE_PRINCIPAL_PENALTY_FEE_INTEREST |
    And Admin successfully approves the loan on "20230101" with "3000" amount and expected disbursement date on "20230101"
    When Admin successfully disburse the loan on "20230101" with "3000" EUR transaction amount
    When Admin sets the business date to "20230115"
    When Admin adds "LOAN_NSF_FEE" due date charge with "20230115" due date and 50 EUR transaction amount
    When Admin adds "LOAN_NSF_FEE" due date charge with "20230120" due date and 50 EUR transaction amount
    When Admin adds "LOAN_SNOOZE_FEE" due date charge with "20230120" due date and 50 EUR transaction amount
    When Customer makes "PAYOUT_REFUND" transaction with "AUTOPAY" payment type on "20230115" with 1180 EUR transaction amount and system-generated Idempotency key
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20230101  | Disbursement     | 3000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 3000.0       |
      | 20230115  | Payout Refund    | 1180.0 | 1000.0    | 30.0     | 50.0 | 100.0     | 2000.0       |
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late | Outstanding |
      |    |      | 20230101  |                 | 3000.0          |               |          | 0.0  |           | 0.0    | 0.0    |            |      |             |
      | 1  | 31   | 20230201 | 20230115 | 2000.0          | 1000.0        | 30.0     | 50.0 | 100.0     | 1180.0 | 1180.0 | 1180.0     | 0.0  | 0.0         |
      | 2  | 28   | 20230301    |                 | 1000.0          | 1000.0        | 30.0     | 0.0  | 0.0       | 1030.0 | 0.0    | 0.0        | 0.0  | 1030.0      |
      | 3  | 31   | 20230401    |                 | 0.0             | 1000.0        | 30.0     | 0.0  | 0.0       | 1030.0 | 0.0    | 0.0        | 0.0  | 1030.0      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due  | Paid | In advance | Late | Outstanding |
      | 3000          | 90       | 50   | 100       | 3240 | 1180 | 1180       | 0    | 2060        |
    When Customer undo "1"th transaction made on "20230115"
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20230101  | Disbursement     | 3000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 3000.0       |
      | 20230115  | Payout Refund    | 1180.0 | 1000.0    | 30.0     | 50.0 | 100.0     | 2000.0       |
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      |    |      | 20230101  |           | 3000.0          |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      | 1  | 31   | 20230201 |           | 2000.0          | 1000.0        | 30.0     | 50.0 | 100.0     | 1180.0 | 0.0  | 0.0        | 0.0  | 1180.0      |
      | 2  | 28   | 20230301    |           | 1000.0          | 1000.0        | 30.0     | 0.0  | 0.0       | 1030.0 | 0.0  | 0.0        | 0.0  | 1030.0      |
      | 3  | 31   | 20230401    |           | 0.0             | 1000.0        | 30.0     | 0.0  | 0.0       | 1030.0 | 0.0  | 0.0        | 0.0  | 1030.0      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due  | Paid | In advance | Late | Outstanding |
      | 3000          | 90       | 50   | 100       | 3240 | 0    | 0          | 0    | 3240        |

  @TestRailId:C2670 @PaymentStrategyDueInAdvance
  Scenario: Verify the due-penalty-fee-interest-principal-in-advance-principal-penalty-fee-interest-strategy payment strategy - goodwill credit transaction + reversal
    When Admin sets the business date to "20230101"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                       | submitted on date | with Principal | ANNUAL interest rate % | interest type | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy                                                             |
      | LP1_PAYMENT_STRATEGY_DUE_IN_ADVANCE_INTEREST_FLAT | 20230101   | 3000           | 12                     | FLAT          | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 3                 | MONTHS                | 1              | MONTHS                 | 3                  | 0                       | 0                      | 0                    | DUE_PENALTY_FEE_INTEREST_PRINCIPAL_IN_ADVANCE_PRINCIPAL_PENALTY_FEE_INTEREST |
    And Admin successfully approves the loan on "20230101" with "3000" amount and expected disbursement date on "20230101"
    When Admin successfully disburse the loan on "20230101" with "3000" EUR transaction amount
    When Admin sets the business date to "20230115"
    When Admin adds "LOAN_NSF_FEE" due date charge with "20230115" due date and 50 EUR transaction amount
    When Admin adds "LOAN_NSF_FEE" due date charge with "20230120" due date and 50 EUR transaction amount
    When Admin adds "LOAN_SNOOZE_FEE" due date charge with "20230120" due date and 50 EUR transaction amount
    When Customer makes "GOODWILL_CREDIT" transaction with "AUTOPAY" payment type on "20230115" with 1180 EUR transaction amount and system-generated Idempotency key
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20230101  | Disbursement     | 3000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 3000.0       |
      | 20230115  | Goodwill Credit  | 1180.0 | 1000.0    | 30.0     | 50.0 | 100.0     | 2000.0       |
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late | Outstanding |
      |    |      | 20230101  |                 | 3000.0          |               |          | 0.0  |           | 0.0    | 0.0    |            |      |             |
      | 1  | 31   | 20230201 | 20230115 | 2000.0          | 1000.0        | 30.0     | 50.0 | 100.0     | 1180.0 | 1180.0 | 1180.0     | 0.0  | 0.0         |
      | 2  | 28   | 20230301    |                 | 1000.0          | 1000.0        | 30.0     | 0.0  | 0.0       | 1030.0 | 0.0    | 0.0        | 0.0  | 1030.0      |
      | 3  | 31   | 20230401    |                 | 0.0             | 1000.0        | 30.0     | 0.0  | 0.0       | 1030.0 | 0.0    | 0.0        | 0.0  | 1030.0      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due  | Paid | In advance | Late | Outstanding |
      | 3000          | 90       | 50   | 100       | 3240 | 1180 | 1180       | 0    | 2060        |
    When Customer undo "1"th transaction made on "20230115"
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20230101  | Disbursement     | 3000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 3000.0       |
      | 20230115  | Goodwill Credit  | 1180.0 | 1000.0    | 30.0     | 50.0 | 100.0     | 2000.0       |
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      |    |      | 20230101  |           | 3000.0          |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      | 1  | 31   | 20230201 |           | 2000.0          | 1000.0        | 30.0     | 50.0 | 100.0     | 1180.0 | 0.0  | 0.0        | 0.0  | 1180.0      |
      | 2  | 28   | 20230301    |           | 1000.0          | 1000.0        | 30.0     | 0.0  | 0.0       | 1030.0 | 0.0  | 0.0        | 0.0  | 1030.0      |
      | 3  | 31   | 20230401    |           | 0.0             | 1000.0        | 30.0     | 0.0  | 0.0       | 1030.0 | 0.0  | 0.0        | 0.0  | 1030.0      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due  | Paid | In advance | Late | Outstanding |
      | 3000          | 90       | 50   | 100       | 3240 | 0    | 0          | 0    | 3240        |

  @TestRailId:C2671 @PaymentStrategyDueInAdvance
  Scenario: Verify the due-penalty-fee-interest-principal-in-advance-principal-penalty-fee-interest-strategy payment strategy - repayment + charge adjustment + charge adjustment reversal
    When Admin sets the business date to "20230101"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                       | submitted on date | with Principal | ANNUAL interest rate % | interest type | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy                                                             |
      | LP1_PAYMENT_STRATEGY_DUE_IN_ADVANCE_INTEREST_FLAT | 20230101   | 3000           | 12                     | FLAT          | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 3                 | MONTHS                | 1              | MONTHS                 | 3                  | 0                       | 0                      | 0                    | DUE_PENALTY_FEE_INTEREST_PRINCIPAL_IN_ADVANCE_PRINCIPAL_PENALTY_FEE_INTEREST |
    And Admin successfully approves the loan on "20230101" with "3000" amount and expected disbursement date on "20230101"
    When Admin successfully disburse the loan on "20230101" with "3000" EUR transaction amount
    When Admin sets the business date to "20230115"
    When Admin adds "LOAN_NSF_FEE" due date charge with "20230115" due date and 50 EUR transaction amount
    When Admin adds "LOAN_NSF_FEE" due date charge with "20230120" due date and 50 EUR transaction amount
    When Admin adds "LOAN_SNOOZE_FEE" due date charge with "20230120" due date and 50 EUR transaction amount
    And Customer makes "AUTOPAY" repayment on "20230115" with 1180 EUR transaction amount
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20230101  | Disbursement     | 3000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 3000.0       |
      | 20230115  | Repayment        | 1180.0 | 1000.0    | 30.0     | 50.0 | 100.0     | 2000.0       |
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late | Outstanding |
      |    |      | 20230101  |                 | 3000.0          |               |          | 0.0  |           | 0.0    | 0.0    |            |      |             |
      | 1  | 31   | 20230201 | 20230115 | 2000.0          | 1000.0        | 30.0     | 50.0 | 100.0     | 1180.0 | 1180.0 | 1180.0     | 0.0  | 0.0         |
      | 2  | 28   | 20230301    |                 | 1000.0          | 1000.0        | 30.0     | 0.0  | 0.0       | 1030.0 | 0.0    | 0.0        | 0.0  | 1030.0      |
      | 3  | 31   | 20230401    |                 | 0.0             | 1000.0        | 30.0     | 0.0  | 0.0       | 1030.0 | 0.0    | 0.0        | 0.0  | 1030.0      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due  | Paid | In advance | Late | Outstanding |
      | 3000          | 90       | 50   | 100       | 3240 | 1180 | 1180       | 0    | 2060        |
    When Admin sets the business date to "20230127"
    When Admin makes a charge adjustment for the last "LOAN_NSF_FEE" type charge which is due on "20230120" with 50 EUR transaction amount and externalId ""
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type  | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20230101  | Disbursement      | 3000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 3000.0       |
      | 20230115  | Repayment         | 1180.0 | 1000.0    | 30.0     | 50.0 | 100.0     | 2000.0       |
      | 20230127  | Charge Adjustment | 50.0   | 50.0      | 0.0      | 0.0  | 0.0       | 1950.0       |
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late | Outstanding |
      |    |      | 20230101  |                 | 3000.0          |               |          | 0.0  |           | 0.0    | 0.0    |            |      |             |
      | 1  | 31   | 20230201 | 20230115 | 2000.0          | 1000.0        | 30.0     | 50.0 | 100.0     | 1180.0 | 1180.0 | 1180.0     | 0.0  | 0.0         |
      | 2  | 28   | 20230301    |                 | 1000.0          | 1000.0        | 30.0     | 0.0  | 0.0       | 1030.0 | 50.0   | 50.0       | 0.0  | 980.0       |
      | 3  | 31   | 20230401    |                 | 0.0             | 1000.0        | 30.0     | 0.0  | 0.0       | 1030.0 | 0.0    | 0.0        | 0.0  | 1030.0      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due  | Paid | In advance | Late | Outstanding |
      | 3000          | 90       | 50   | 100       | 3240 | 1230 | 1230       | 0    | 2010        |
    When Admin sets the business date to "20230130"
    When Admin reverts the charge adjustment which was raised on "20230127" with 50 EUR transaction amount
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type  | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20230101  | Disbursement      | 3000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 3000.0       | false    |
      | 20230115  | Repayment         | 1180.0 | 1000.0    | 30.0     | 50.0 | 100.0     | 2000.0       | false    |
      | 20230127  | Charge Adjustment | 50.0   | 50.0      | 0.0      | 0.0  | 0.0       | 1950.0       | true     |
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late | Outstanding |
      |    |      | 20230101  |                 | 3000.0          |               |          | 0.0  |           | 0.0    | 0.0    |            |      |             |
      | 1  | 31   | 20230201 | 20230115 | 2000.0          | 1000.0        | 30.0     | 50.0 | 100.0     | 1180.0 | 1180.0 | 1180.0     | 0.0  | 0.0         |
      | 2  | 28   | 20230301    |                 | 1000.0          | 1000.0        | 30.0     | 0.0  | 0.0       | 1030.0 | 0.0    | 0.0        | 0.0  | 1030.0      |
      | 3  | 31   | 20230401    |                 | 0.0             | 1000.0        | 30.0     | 0.0  | 0.0       | 1030.0 | 0.0    | 0.0        | 0.0  | 1030.0      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due  | Paid | In advance | Late | Outstanding |
      | 3000          | 90       | 50   | 100       | 3240 | 1180 | 1180       | 0    | 2060        |

  @TestRailId:C2682 @PaymentStrategyDueInAdvance
  Scenario: Verify the due-penalty-fee-interest-principal-in-advance-principal-penalty-fee-interest-strategy payment strategy - fee - repayment - nsffee - chargeback - repayment
    When Admin sets the business date to "20230101"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                         | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy                                                             |
      | LP1_PAYMENT_STRATEGY_DUE_IN_ADVANCE | 20230101   | 1000           | 0                      | DECLINING_BALANCE | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 1                 | MONTHS                | 1              | MONTHS                 | 1                  | 0                       | 0                      | 0                    | DUE_PENALTY_FEE_INTEREST_PRINCIPAL_IN_ADVANCE_PRINCIPAL_PENALTY_FEE_INTEREST |
    And Admin successfully approves the loan on "20230101" with "1000" amount and expected disbursement date on "20230101"
    When Admin successfully disburse the loan on "20230101" with "1000" EUR transaction amount
    When Admin sets the business date to "20230110"
    When Admin adds "LOAN_SNOOZE_FEE" due date charge with "20230110" due date and 10 EUR transaction amount
    When Admin sets the business date to "20230115"
    And Customer makes "AUTOPAY" repayment on "20230115" with 500 EUR transaction amount
    When Admin sets the business date to "20230118"
    When Admin adds "LOAN_NSF_FEE" due date charge with "20230118" due date and 25 EUR transaction amount
    And Admin makes "REPAYMENT_ADJUSTMENT_CHARGEBACK" chargeback with 500 EUR transaction amount for Payment nr. 1
    When Admin sets the business date to "20230121"
    And Customer makes "AUTOPAY" repayment on "20230121" with 500 EUR transaction amount
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20230101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
      | 20230115  | Repayment        | 500.0  | 490.0     | 0.0      | 10.0 | 0.0       | 510.0        |
      | 20230118  | Chargeback       | 500.0  | 500.0     | 0.0      | 0.0  | 0.0       | 1010.0       |
      | 20230121  | Repayment        | 500.0  | 475.0     | 0.0      | 0.0  | 25.0      | 535.0        |
    Then Loan Repayment schedule has 1 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late | Outstanding |
      |    |      | 20230101  |           | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0    |            |      |             |
      | 1  | 31   | 20230201 |           | 0.0             | 1500.0        | 0.0      | 10.0 | 25.0      | 1535.0 | 1000.0 | 1000.0     | 0.0  | 535.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due  | Paid | In advance | Late | Outstanding |
      | 1500          | 0        | 10   | 25        | 1535 | 1000 | 1000       | 0    | 535         |

  @TestRailId:C2799 @PaymentStrategyDueInAdvance
  Scenario: Verify the due-penalty-fee-interest-principal-in-advance-principal-penalty-fee-interest-strategy payment strategy: Same day transaction
    When Admin sets the business date to "20230101"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                         | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy                                                             |
      | LP1_PAYMENT_STRATEGY_DUE_IN_ADVANCE | 20230101    | 1000           | 0                      | DECLINING_BALANCE | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 1                 | MONTHS                | 1              | MONTHS                 | 1                  | 0                       | 0                      | 0                    | DUE_PENALTY_FEE_INTEREST_PRINCIPAL_IN_ADVANCE_PRINCIPAL_PENALTY_FEE_INTEREST |
    And Admin successfully approves the loan on "20230101" with "1000" amount and expected disbursement date on "20230101"
    When Admin successfully disburse the loan on "20230101" with "1000" EUR transaction amount
    When Admin sets the business date to "20230104"
    And Customer makes "AUTOPAY" repayment on "20230104" with 200 EUR transaction amount
    When Admin sets the business date to "20230112"
    And Customer makes "AUTOPAY" repayment on "20230112" with 300 EUR transaction amount
    And Admin adds a 1 % Processing charge to the loan with "en" locale on date: "20230112"
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20230101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
      | 20230104  | Repayment        | 200.0  | 200.0     | 0.0      | 0.0  | 0.0       | 800.0        |
      | 20230112  | Repayment        | 300.0  | 290.0     | 0.0      | 10.0 | 0.0       | 510.0        |
    And Customer makes "AUTOPAY" repayment on "20230112" with 510 EUR transaction amount
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20230101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
      | 20230104  | Repayment        | 200.0  | 200.0     | 0.0      | 0.0  | 0.0       | 800.0        |
      | 20230112  | Repayment        | 300.0  | 290.0     | 0.0      | 10.0 | 0.0       | 510.0        |
      | 20230112  | Accrual          | 10.0   | 0.0       | 0.0      | 10.0 | 0.0       | 0.0          |
      | 20230112  | Repayment        | 510.0  | 510.0     | 0.0      | 0.0  | 0.0       | 0.0          |

  @TestRailId:C2694 @PaymentStrategyDueInAdvancePenaltyInterestPrincipalFee
  Scenario: Verify the due-penalty-interest-principal-fee-in-advance-penalty-interest-principal-fee-strategy payment strategy: UC1 - no fees or penalties, due payment
    When Admin sets the business date to "20230101"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                        | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy                                                             |
      | LP1_PAYMENT_STRATEGY_DUE_IN_ADVANCE_PENALTY_INTEREST_PRINCIPAL_FEE | 20230101   | 1000           | 0                      | DECLINING_BALANCE | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 1                 | MONTHS                | 1              | MONTHS                 | 1                  | 0                       | 0                      | 0                    | DUE_PENALTY_INTEREST_PRINCIPAL_FEE_IN_ADVANCE_PENALTY_INTEREST_PRINCIPAL_FEE |
    And Admin successfully approves the loan on "20230101" with "1000" amount and expected disbursement date on "20230101"
    When Admin successfully disburse the loan on "20230101" with "1000" EUR transaction amount
    When Admin sets the business date to "20230201"
    And Customer makes "AUTOPAY" repayment on "20230201" with 1000 EUR transaction amount
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20230101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
      | 20230201 | Repayment        | 1000.0 | 1000.0    | 0.0      | 0.0  | 0.0       | 0.0          |
    Then Loan Repayment schedule has 1 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late | Outstanding |
      |    |      | 20230101  |                  | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0    |            |      |             |
      | 1  | 31   | 20230201 | 20230201 | 0.0             | 1000.0        | 0.0      | 0.0  | 0.0       | 1000.0 | 1000.0 | 0.0        | 0.0  | 0.0         |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due  | Paid | In advance | Late | Outstanding |
      | 1000          | 0        | 0    | 0         | 1000 | 1000 | 0          | 0    | 0           |

  @TestRailId:C2695 @PaymentStrategyDueInAdvancePenaltyInterestPrincipalFee
  Scenario: Verify the due-penalty-interest-principal-fee-in-advance-penalty-interest-principal-fee-strategy payment strategy: UC2 - due principal, fee
    When Admin sets the business date to "20230101"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                        | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy                                                             |
      | LP1_PAYMENT_STRATEGY_DUE_IN_ADVANCE_PENALTY_INTEREST_PRINCIPAL_FEE | 20230101   | 1000           | 0                      | DECLINING_BALANCE | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 1                 | MONTHS                | 1              | MONTHS                 | 1                  | 0                       | 0                      | 0                    | DUE_PENALTY_INTEREST_PRINCIPAL_FEE_IN_ADVANCE_PENALTY_INTEREST_PRINCIPAL_FEE |
    And Admin successfully approves the loan on "20230101" with "1000" amount and expected disbursement date on "20230101"
    When Admin successfully disburse the loan on "20230101" with "1000" EUR transaction amount
    When Admin sets the business date to "20230125"
    When Admin adds "LOAN_SNOOZE_FEE" due date charge with "20230201" due date and 20 EUR transaction amount
    When Admin sets the business date to "20230201"
    And Customer makes "AUTOPAY" repayment on "20230201" with 1020 EUR transaction amount
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20230101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
      | 20230201 | Repayment        | 1020.0 | 1000.0    | 0.0      | 20.0 | 0.0       | 0.0          |
      | 20230201 | Accrual          | 20.0   | 0.0       | 0.0      | 20.0 | 0.0       | 0.0          |
    Then Loan Charges tab has the following data:
      | Name       | isPenalty | Payment due at     | Due as of        | Calculation type | Due  | Paid | Waived | Outstanding |
      | Snooze fee | false     | Specified due date | 20230201 | Flat             | 20.0 | 20.0 | 0.0    | 0.0         |
    Then Loan Repayment schedule has 1 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late | Outstanding |
      |    |      | 20230101  |                  | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0    |            |      |             |
      | 1  | 31   | 20230201 | 20230201 | 0.0             | 1000.0        | 0.0      | 20.0 | 0.0       | 1020.0 | 1020.0 | 0.0        | 0.0  | 0.0         |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due  | Paid | In advance | Late | Outstanding |
      | 1000          | 0        | 20   | 0         | 1020 | 1020 | 0          | 0    | 0           |

  @TestRailId:C2696 @PaymentStrategyDueInAdvancePenaltyInterestPrincipalFee
  Scenario: Verify the due-penalty-interest-principal-fee-in-advance-penalty-interest-principal-fee-strategy payment strategy: UC3 - in advance principal, reverted, due penalty, principal
    When Admin sets the business date to "20230101"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                        | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy                                                             |
      | LP1_PAYMENT_STRATEGY_DUE_IN_ADVANCE_PENALTY_INTEREST_PRINCIPAL_FEE | 20230101   | 1000           | 0                      | DECLINING_BALANCE | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 1                 | MONTHS                | 1              | MONTHS                 | 1                  | 0                       | 0                      | 0                    | DUE_PENALTY_INTEREST_PRINCIPAL_FEE_IN_ADVANCE_PENALTY_INTEREST_PRINCIPAL_FEE |
    And Admin successfully approves the loan on "20230101" with "1000" amount and expected disbursement date on "20230101"
    When Admin successfully disburse the loan on "20230101" with "1000" EUR transaction amount

    When Admin sets the business date to "20230125"
    And Customer makes "AUTOPAY" repayment on "20230125" with 1000 EUR transaction amount
    Then Loan status will be "CLOSED_OBLIGATIONS_MET"
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20230101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
      | 20230125  | Repayment        | 1000.0 | 1000.0    | 0.0      | 0.0  | 0.0       | 0.0          |

    When Admin sets the business date to "20230128"
    When Customer undo "1"th "Repayment" transaction made on "20230125"
    When Admin adds "LOAN_NSF_FEE" due date charge with "20230128" due date and 20 EUR transaction amount
    Then Loan status will be "ACTIVE"
    Then On Loan Transactions tab the "Repayment" Transaction with date "20230125" is reverted
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20230101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
      | 20230125  | Repayment        | 1000.0 | 1000.0    | 0.0      | 0.0  | 0.0       | 0.0          |
    Then Loan Charges tab has the following data:
      | Name    | isPenalty | Payment due at     | Due as of       | Calculation type | Due  | Paid | Waived | Outstanding |
      | NSF fee | true      | Specified due date | 20230128 | Flat             | 20.0 | 0.0  | 0.0    | 20.0        |

    When Admin sets the business date to "20230201"
    And Customer makes "AUTOPAY" repayment on "20230201" with 1020 EUR transaction amount
    Then On Loan Transactions tab the "Repayment" Transaction with date "20230125" is reverted
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20230101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
      | 20230125  | Repayment        | 1000.0 | 1000.0    | 0.0      | 0.0  | 0.0       | 0.0          |
      | 20230201 | Repayment        | 1020.0 | 1000.0    | 0.0      | 0.0  | 20.0      | 0.0          |
      | 20230201 | Accrual          | 20.0   | 0.0       | 0.0      | 0.0  | 20.0      | 0.0          |
    Then Loan Charges tab has the following data:
      | Name    | isPenalty | Payment due at     | Due as of       | Calculation type | Due  | Paid | Waived | Outstanding |
      | NSF fee | true      | Specified due date | 20230128 | Flat             | 20.0 | 20.0 | 0.0    | 0.0         |
    Then Loan Repayment schedule has 1 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late | Outstanding |
      |    |      | 20230101  |                  | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0    |            |      |             |
      | 1  | 31   | 20230201 | 20230201 | 0.0             | 1000.0        | 0.0      | 0.0  | 20.0      | 1020.0 | 1020.0 | 0.0        | 0.0  | 0.0         |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due  | Paid | In advance | Late | Outstanding |
      | 1000          | 0        | 0    | 20        | 1020 | 1020 | 0          | 0    | 0           |

  @TestRailId:C2697 @PaymentStrategyDueInAdvancePenaltyInterestPrincipalFee
  Scenario: Verify the due-penalty-interest-principal-fee-in-advance-penalty-interest-principal-fee-strategy payment strategy: UC4 - in advance principal, fee, reverted, due penalty, principal, fee
    When Admin sets the business date to "20230101"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                        | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy                                                             |
      | LP1_PAYMENT_STRATEGY_DUE_IN_ADVANCE_PENALTY_INTEREST_PRINCIPAL_FEE | 20230101   | 1000           | 0                      | DECLINING_BALANCE | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 1                 | MONTHS                | 1              | MONTHS                 | 1                  | 0                       | 0                      | 0                    | DUE_PENALTY_INTEREST_PRINCIPAL_FEE_IN_ADVANCE_PENALTY_INTEREST_PRINCIPAL_FEE |
    And Admin successfully approves the loan on "20230101" with "1000" amount and expected disbursement date on "20230101"
    When Admin successfully disburse the loan on "20230101" with "1000" EUR transaction amount

    When Admin sets the business date to "20230110"
    When Admin adds "LOAN_SNOOZE_FEE" due date charge with "20230201" due date and 20 EUR transaction amount

    When Admin sets the business date to "20230125"
    And Customer makes "AUTOPAY" repayment on "20230125" with 1020 EUR transaction amount
    Then Loan status will be "CLOSED_OBLIGATIONS_MET"
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20230101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
      | 20230125  | Repayment        | 1020.0 | 1000.0    | 0.0      | 20.0 | 0.0       | 0.0          |
      | 20230125  | Accrual          | 20.0   | 0.0       | 0.0      | 20.0 | 0.0       | 0.0          |
    Then Loan Charges tab has the following data:
      | Name       | isPenalty | Payment due at     | Due as of        | Calculation type | Due  | Paid | Waived | Outstanding |
      | Snooze fee | false     | Specified due date | 20230201 | Flat             | 20.0 | 20.0 | 0.0    | 0.0         |
    Then Loan Repayment schedule has 1 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late | Outstanding |
      |    |      | 20230101  |                 | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0    |            |      |             |
      | 1  | 31   | 20230201 | 20230125 | 0.0             | 1000.0        | 0.0      | 20.0 | 0.0       | 1020.0 | 1020.0 | 1020.0     | 0.0  | 0.0         |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due  | Paid | In advance | Late | Outstanding |
      | 1000          | 0        | 20   | 0         | 1020 | 1020 | 1020       | 0    | 0           |

    When Admin sets the business date to "20230128"
    When Customer undo "1"th "Repayment" transaction made on "20230125"
    When Admin adds "LOAN_NSF_FEE" due date charge with "20230201" due date and 20 EUR transaction amount
    Then On Loan Transactions tab the "Repayment" Transaction with date "20230125" is reverted
    Then Loan status will be "ACTIVE"
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20230101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
      | 20230125  | Repayment        | 1020.0 | 1000.0    | 0.0      | 20.0 | 0.0       | 0.0          |
      | 20230125  | Accrual          | 20.0   | 0.0       | 0.0      | 20.0 | 0.0       | 0.0          |
    Then Loan Charges tab has the following data:
      | Name       | isPenalty | Payment due at     | Due as of        | Calculation type | Due  | Paid | Waived | Outstanding |
      | Snooze fee | false     | Specified due date | 20230201 | Flat             | 20.0 | 0.0  | 0.0    | 20.0        |
      | NSF fee    | true      | Specified due date | 20230201 | Flat             | 20.0 | 0.0  | 0.0    | 20.0        |

    When Admin sets the business date to "20230201"
    And Customer makes "AUTOPAY" repayment on "20230201" with 1040 EUR transaction amount
    Then On Loan Transactions tab the "Repayment" Transaction with date "20230125" is reverted
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20230101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
      | 20230125  | Repayment        | 1020.0 | 1000.0    | 0.0      | 20.0 | 0.0       | 0.0          |
      | 20230125  | Accrual          | 20.0   | 0.0       | 0.0      | 20.0 | 0.0       | 0.0          |
      | 20230201 | Repayment        | 1040.0 | 1000.0    | 0.0      | 20.0 | 20.0      | 0.0          |
      | 20230201 | Accrual          | 20.0   | 0.0       | 0.0      | 0.0  | 20.0      | 0.0          |
    Then Loan Charges tab has the following data:
      | Name       | isPenalty | Payment due at     | Due as of        | Calculation type | Due  | Paid | Waived | Outstanding |
      | Snooze fee | false     | Specified due date | 20230201 | Flat             | 20.0 | 20.0 | 0.0    | 0.0         |
      | NSF fee    | true      | Specified due date | 20230201 | Flat             | 20.0 | 20.0 | 0.0    | 0.0         |
    Then Loan Repayment schedule has 1 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late | Outstanding |
      |    |      | 20230101  |                  | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0    |            |      |             |
      | 1  | 31   | 20230201 | 20230201 | 0.0             | 1000.0        | 0.0      | 20.0 | 20.0      | 1040.0 | 1040.0 | 0.0        | 0.0  | 0.0         |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due  | Paid | In advance | Late | Outstanding |
      | 1000          | 0        | 20   | 20        | 1040 | 1040 | 0          | 0    | 0           |

  @TestRailId:C2698 @PaymentStrategyDueInAdvancePenaltyInterestPrincipalFee
  Scenario: Verify the due-penalty-interest-principal-fee-in-advance-penalty-interest-principal-fee-strategy payment strategy: UC5 - in advance principal, fee, reverted, multiple due penalty, principal
    When Admin sets the business date to "20230101"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                        | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy                                                             |
      | LP1_PAYMENT_STRATEGY_DUE_IN_ADVANCE_PENALTY_INTEREST_PRINCIPAL_FEE | 20230101   | 1000           | 0                      | DECLINING_BALANCE | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 1                 | MONTHS                | 1              | MONTHS                 | 1                  | 0                       | 0                      | 0                    | DUE_PENALTY_INTEREST_PRINCIPAL_FEE_IN_ADVANCE_PENALTY_INTEREST_PRINCIPAL_FEE |
    And Admin successfully approves the loan on "20230101" with "1000" amount and expected disbursement date on "20230101"
    When Admin successfully disburse the loan on "20230101" with "1000" EUR transaction amount

    When Admin sets the business date to "20230110"
    When Admin adds "LOAN_SNOOZE_FEE" due date charge with "20230201" due date and 20 EUR transaction amount

    When Admin sets the business date to "20230125"
    And Customer makes "AUTOPAY" repayment on "20230125" with 1020 EUR transaction amount
    Then Loan status will be "CLOSED_OBLIGATIONS_MET"
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20230101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
      | 20230125  | Repayment        | 1020.0 | 1000.0    | 0.0      | 20.0 | 0.0       | 0.0          |
      | 20230125  | Accrual          | 20.0   | 0.0       | 0.0      | 20.0 | 0.0       | 0.0          |
    Then Loan Charges tab has the following data:
      | Name       | isPenalty | Payment due at     | Due as of        | Calculation type | Due  | Paid | Waived | Outstanding |
      | Snooze fee | false     | Specified due date | 20230201 | Flat             | 20.0 | 20.0 | 0.0    | 0.0         |
    Then Loan Repayment schedule has 1 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late | Outstanding |
      |    |      | 20230101  |                 | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0    |            |      |             |
      | 1  | 31   | 20230201 | 20230125 | 0.0             | 1000.0        | 0.0      | 20.0 | 0.0       | 1020.0 | 1020.0 | 1020.0     | 0.0  | 0.0         |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due  | Paid | In advance | Late | Outstanding |
      | 1000          | 0        | 20   | 0         | 1020 | 1020 | 1020       | 0    | 0           |

    When Admin sets the business date to "20230128"
    When Customer undo "1"th "Repayment" transaction made on "20230125"
    When Admin adds "LOAN_NSF_FEE" due date charge with "20230201" due date and 20 EUR transaction amount
    Then On Loan Transactions tab the "Repayment" Transaction with date "20230125" is reverted
    Then Loan status will be "ACTIVE"
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20230101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
      | 20230125  | Repayment        | 1020.0 | 1000.0    | 0.0      | 20.0 | 0.0       | 0.0          |
      | 20230125  | Accrual          | 20.0   | 0.0       | 0.0      | 20.0 | 0.0       | 0.0          |
    Then Loan Charges tab has the following data:
      | Name       | isPenalty | Payment due at     | Due as of        | Calculation type | Due  | Paid | Waived | Outstanding |
      | Snooze fee | false     | Specified due date | 20230201 | Flat             | 20.0 | 0.0  | 0.0    | 20.0        |
      | NSF fee    | true      | Specified due date | 20230201 | Flat             | 20.0 | 0.0  | 0.0    | 20.0        |

    When Admin sets the business date to "20230201"
    And Customer makes "AUTOPAY" repayment on "20230201" with 1040 EUR transaction amount
    Then On Loan Transactions tab the "Repayment" Transaction with date "20230125" is reverted
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20230101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
      | 20230125  | Repayment        | 1020.0 | 1000.0    | 0.0      | 20.0 | 0.0       | 0.0          |
      | 20230125  | Accrual          | 20.0   | 0.0       | 0.0      | 20.0 | 0.0       | 0.0          |
      | 20230201 | Repayment        | 1040.0 | 1000.0    | 0.0      | 20.0 | 20.0      | 0.0          |
      | 20230201 | Accrual          | 20.0   | 0.0       | 0.0      | 0.0  | 20.0      | 0.0          |
    Then Loan Charges tab has the following data:
      | Name       | isPenalty | Payment due at     | Due as of        | Calculation type | Due  | Paid | Waived | Outstanding |
      | Snooze fee | false     | Specified due date | 20230201 | Flat             | 20.0 | 20.0 | 0.0    | 0.0         |
      | NSF fee    | true      | Specified due date | 20230201 | Flat             | 20.0 | 20.0 | 0.0    | 0.0         |
    Then Loan Repayment schedule has 1 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late | Outstanding |
      |    |      | 20230101  |                  | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0    |            |      |             |
      | 1  | 31   | 20230201 | 20230201 | 0.0             | 1000.0        | 0.0      | 20.0 | 20.0      | 1040.0 | 1040.0 | 0.0        | 0.0  | 0.0         |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due  | Paid | In advance | Late | Outstanding |
      | 1000          | 0        | 20   | 20        | 1040 | 1040 | 0          | 0    | 0           |

    When Admin sets the business date to "20230205"
    When Customer undo "1"th "Repayment" transaction made on "20230201"
    When Admin adds "LOAN_NSF_FEE" due date charge with "20230208" due date and 20 EUR transaction amount
    Then On Loan Transactions tab the "Repayment" Transaction with date "20230125" is reverted
    Then On Loan Transactions tab the "Repayment" Transaction with date "20230201" is reverted
    Then Loan status will be "ACTIVE"
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20230101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
      | 20230125  | Repayment        | 1020.0 | 1000.0    | 0.0      | 20.0 | 0.0       | 0.0          |
      | 20230125  | Accrual          | 20.0   | 0.0       | 0.0      | 20.0 | 0.0       | 0.0          |
      | 20230201 | Repayment        | 1040.0 | 1000.0    | 0.0      | 20.0 | 20.0      | 0.0          |
      | 20230201 | Accrual          | 20.0   | 0.0       | 0.0      | 0.0  | 20.0      | 0.0          |
    Then Loan Charges tab has the following data:
      | Name       | isPenalty | Payment due at     | Due as of        | Calculation type | Due  | Paid | Waived | Outstanding |
      | NSF fee    | true      | Specified due date | 20230208 | Flat             | 20.0 | 0.0  | 0.0    | 20.0        |
      | Snooze fee | false     | Specified due date | 20230201 | Flat             | 20.0 | 0.0  | 0.0    | 20.0        |
      | NSF fee    | true      | Specified due date | 20230201 | Flat             | 20.0 | 0.0  | 0.0    | 20.0        |

    When Admin sets the business date to "20230208"
    And Customer makes "AUTOPAY" repayment on "20230208" with 1060 EUR transaction amount
    Then On Loan Transactions tab the "Repayment" Transaction with date "20230201" is reverted
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20230101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
      | 20230125  | Repayment        | 1020.0 | 1000.0    | 0.0      | 20.0 | 0.0       | 0.0          |
      | 20230125  | Accrual          | 20.0   | 0.0       | 0.0      | 20.0 | 0.0       | 0.0          |
      | 20230201 | Repayment        | 1040.0 | 1000.0    | 0.0      | 20.0 | 20.0      | 0.0          |
      | 20230201 | Accrual          | 20.0   | 0.0       | 0.0      | 0.0  | 20.0      | 0.0          |
      | 20230208 | Repayment        | 1060.0 | 1000.0    | 0.0      | 20.0 | 40.0      | 0.0          |
      | 20230208 | Accrual          | 20.0   | 0.0       | 0.0      | 0.0  | 20.0      | 0.0          |
    Then Loan Charges tab has the following data:
      | Name       | isPenalty | Payment due at     | Due as of        | Calculation type | Due  | Paid | Waived | Outstanding |
      | NSF fee    | true      | Specified due date | 20230208 | Flat             | 20.0 | 20.0 | 0.0    | 0.0         |
      | Snooze fee | false     | Specified due date | 20230201 | Flat             | 20.0 | 20.0 | 0.0    | 0.0         |
      | NSF fee    | true      | Specified due date | 20230201 | Flat             | 20.0 | 20.0 | 0.0    | 0.0         |
    Then Loan Repayment schedule has 2 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late   | Outstanding |
      |    |      | 20230101  |                  | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0    |            |        |             |
      | 1  | 31   | 20230201 | 20230208 | 0.0             | 1000.0        | 0.0      | 20.0 | 20.0      | 1040.0 | 1040.0 | 0.0        | 1040.0 | 0.0         |
      | 2  | 7    | 20230208 | 20230208 | 0.0             | 0.0           | 0.0      | 0.0  | 20.0      | 20.0   | 20.0   | 0.0        | 0.0    | 0.0         |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due  | Paid | In advance | Late | Outstanding |
      | 1000          | 0        | 20   | 40        | 1060 | 1060 | 0          | 1040 | 0           |

  @TestRailId:C2699 @PaymentStrategyDueInAdvancePenaltyInterestPrincipalFee
  Scenario: Verify the due-penalty-interest-principal-fee-in-advance-penalty-interest-principal-fee-strategy payment strategy: UC6 - partial payment
    When Admin sets the business date to "20230101"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                        | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy                                                             |
      | LP1_PAYMENT_STRATEGY_DUE_IN_ADVANCE_PENALTY_INTEREST_PRINCIPAL_FEE | 20230101   | 1000           | 0                      | DECLINING_BALANCE | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 1                 | MONTHS                | 1              | MONTHS                 | 1                  | 0                       | 0                      | 0                    | DUE_PENALTY_INTEREST_PRINCIPAL_FEE_IN_ADVANCE_PENALTY_INTEREST_PRINCIPAL_FEE |
    And Admin successfully approves the loan on "20230101" with "1000" amount and expected disbursement date on "20230101"
    When Admin successfully disburse the loan on "20230101" with "1000" EUR transaction amount
    When Admin sets the business date to "20230125"
    And Customer makes "AUTOPAY" repayment on "20230125" with 500 EUR transaction amount
    When Admin sets the business date to "20230201"
    And Customer makes "AUTOPAY" repayment on "20230201" with 500 EUR transaction amount
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20230101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
      | 20230125  | Repayment        | 500.0  | 500.0     | 0.0      | 0.0  | 0.0       | 500.0        |
      | 20230201 | Repayment        | 500.0  | 500.0     | 0.0      | 0.0  | 0.0       | 0.0          |
    Then Loan Repayment schedule has 1 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late | Outstanding |
      |    |      | 20230101  |                  | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0    |            |      |             |
      | 1  | 31   | 20230201 | 20230201 | 0.0             | 1000.0        | 0.0      | 0.0  | 0.0       | 1000.0 | 1000.0 | 500.0      | 0.0  | 0.0         |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due  | Paid | In advance | Late | Outstanding |
      | 1000          | 0        | 0    | 0         | 1000 | 1000 | 500        | 0    | 0           |

  @TestRailId:C2700 @PaymentStrategyDueInAdvancePenaltyInterestPrincipalFee
  Scenario: Verify the due-penalty-interest-principal-fee-in-advance-penalty-interest-principal-fee-strategy payment strategy: UC7 - partial payment, in advance principal, due principal, fee
    When Admin sets the business date to "20230101"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                        | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy                                                             |
      | LP1_PAYMENT_STRATEGY_DUE_IN_ADVANCE_PENALTY_INTEREST_PRINCIPAL_FEE | 20230101   | 1000           | 0                      | DECLINING_BALANCE | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 1                 | MONTHS                | 1              | MONTHS                 | 1                  | 0                       | 0                      | 0                    | DUE_PENALTY_INTEREST_PRINCIPAL_FEE_IN_ADVANCE_PENALTY_INTEREST_PRINCIPAL_FEE |
    And Admin successfully approves the loan on "20230101" with "1000" amount and expected disbursement date on "20230101"
    When Admin successfully disburse the loan on "20230101" with "1000" EUR transaction amount

    When Admin sets the business date to "20230110"
    When Admin adds "LOAN_SNOOZE_FEE" due date charge with "20230201" due date and 20 EUR transaction amount

    When Admin sets the business date to "20230125"
    And Customer makes "AUTOPAY" repayment on "20230125" with 500 EUR transaction amount
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20230101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
      | 20230125  | Repayment        | 500.0  | 500.0     | 0.0      | 0.0  | 0.0       | 500.0        |
    Then Loan Repayment schedule has 1 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      |    |      | 20230101  |           | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0   |            |      |             |
      | 1  | 31   | 20230201 |           | 0.0             | 1000.0        | 0.0      | 20.0 | 0.0       | 1020.0 | 500.0 | 500.0      | 0.0  | 520.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due  | Paid | In advance | Late | Outstanding |
      | 1000          | 0        | 20   | 0         | 1020 | 500  | 500        | 0    | 520         |

    When Admin sets the business date to "20230201"
    And Customer makes "AUTOPAY" repayment on "20230201" with 520 EUR transaction amount
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20230101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
      | 20230125  | Repayment        | 500.0  | 500.0     | 0.0      | 0.0  | 0.0       | 500.0        |
      | 20230201 | Repayment        | 520.0  | 500.0     | 0.0      | 20.0 | 0.0       | 0.0          |
      | 20230201 | Accrual          | 20.0   | 0.0       | 0.0      | 20.0 | 0.0       | 0.0          |
    Then Loan Repayment schedule has 1 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late | Outstanding |
      |    |      | 20230101  |                  | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0    |            |      |             |
      | 1  | 31   | 20230201 | 20230201 | 0.0             | 1000.0        | 0.0      | 20.0 | 0.0       | 1020.0 | 1020.0 | 500.0      | 0.0  | 0.0         |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due  | Paid | In advance | Late | Outstanding |
      | 1000          | 0        | 20   | 0         | 1020 | 1020 | 500        | 0    | 0           |

  @TestRailId:C2701 @PaymentStrategyDueInAdvancePenaltyInterestPrincipalFee
  Scenario: Verify the due-penalty-interest-principal-fee-in-advance-penalty-interest-principal-fee-strategy payment strategy: UC8 - partial payment, in advance principal, due penalty, principal
    When Admin sets the business date to "20230101"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                        | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy                                                             |
      | LP1_PAYMENT_STRATEGY_DUE_IN_ADVANCE_PENALTY_INTEREST_PRINCIPAL_FEE | 20230101   | 1000           | 0                      | DECLINING_BALANCE | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 1                 | MONTHS                | 1              | MONTHS                 | 1                  | 0                       | 0                      | 0                    | DUE_PENALTY_INTEREST_PRINCIPAL_FEE_IN_ADVANCE_PENALTY_INTEREST_PRINCIPAL_FEE |
    And Admin successfully approves the loan on "20230101" with "1000" amount and expected disbursement date on "20230101"
    When Admin successfully disburse the loan on "20230101" with "1000" EUR transaction amount

    When Admin sets the business date to "20230110"
    And Customer makes "AUTOPAY" repayment on "20230110" with 1000 EUR transaction amount
    Then Loan status will be "CLOSED_OBLIGATIONS_MET"

    When Admin sets the business date to "20230125"
    When Customer undo "1"th "Repayment" transaction made on "20230110"
    When Admin adds "LOAN_NSF_FEE" due date charge with "20230201" due date and 20 EUR transaction amount
    Then Loan status will be "ACTIVE"
    Then On Loan Transactions tab the "Repayment" Transaction with date "20230110" is reverted
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20230101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
      | 20230110  | Repayment        | 1000.0 | 1000.0    | 0.0      | 0.0  | 0.0       | 0.0          |
    Then Loan Charges tab has the following data:
      | Name    | isPenalty | Payment due at     | Due as of        | Calculation type | Due  | Paid | Waived | Outstanding |
      | NSF fee | true      | Specified due date | 20230201 | Flat             | 20.0 | 0.0  | 0.0    | 20.0        |

    When Admin sets the business date to "20230128"
    And Customer makes "AUTOPAY" repayment on "20230128" with 520 EUR transaction amount
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20230101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
      | 20230110  | Repayment        | 1000.0 | 1000.0    | 0.0      | 0.0  | 0.0       | 0.0          |
      | 20230128  | Repayment        | 520.0  | 500.0     | 0.0      | 0.0  | 20.0      | 500.0        |
    Then Loan Charges tab has the following data:
      | Name    | isPenalty | Payment due at     | Due as of        | Calculation type | Due  | Paid | Waived | Outstanding |
      | NSF fee | true      | Specified due date | 20230201 | Flat             | 20.0 | 20.0 | 0.0    | 0.0         |
    Then Loan Repayment schedule has 1 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      |    |      | 20230101  |           | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0   |            |      |             |
      | 1  | 31   | 20230201 |           | 0.0             | 1000.0        | 0.0      | 0.0  | 20.0      | 1020.0 | 520.0 | 520.0      | 0.0  | 500.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due  | Paid | In advance | Late | Outstanding |
      | 1000          | 0        | 0    | 20        | 1020 | 520  | 520        | 0    | 500         |

    When Admin sets the business date to "20230201"
    And Customer makes "AUTOPAY" repayment on "20230201" with 500 EUR transaction amount
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20230101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
      | 20230110  | Repayment        | 1000.0 | 1000.0    | 0.0      | 0.0  | 0.0       | 0.0          |
      | 20230128  | Repayment        | 520.0  | 500.0     | 0.0      | 0.0  | 20.0      | 500.0        |
      | 20230201 | Repayment        | 500.0  | 500.0     | 0.0      | 0.0  | 0.0       | 0.0          |
      | 20230201 | Accrual          | 20.0   | 0.0       | 0.0      | 0.0  | 20.0      | 0.0          |
    Then Loan Charges tab has the following data:
      | Name    | isPenalty | Payment due at     | Due as of        | Calculation type | Due  | Paid | Waived | Outstanding |
      | NSF fee | true      | Specified due date | 20230201 | Flat             | 20.0 | 20.0 | 0.0    | 0.0         |
    Then Loan Repayment schedule has 1 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late | Outstanding |
      |    |      | 20230101  |                  | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0    |            |      |             |
      | 1  | 31   | 20230201 | 20230201 | 0.0             | 1000.0        | 0.0      | 0.0  | 20.0      | 1020.0 | 1020.0 | 520.0      | 0.0  | 0.0         |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due  | Paid | In advance | Late | Outstanding |
      | 1000          | 0        | 0    | 20        | 1020 | 1020 | 520        | 0    | 0           |

  @TestRailId:C2702 @PaymentStrategyDueInAdvancePenaltyInterestPrincipalFee
  Scenario: Verify the due-penalty-interest-principal-fee-in-advance-penalty-interest-principal-fee-strategy payment strategy: UC9 - partial payment, in advance principal, fee, due penalty, principal
    When Admin sets the business date to "20230101"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                        | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy                                                             |
      | LP1_PAYMENT_STRATEGY_DUE_IN_ADVANCE_PENALTY_INTEREST_PRINCIPAL_FEE | 20230101   | 1000           | 0                      | DECLINING_BALANCE | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 1                 | MONTHS                | 1              | MONTHS                 | 1                  | 0                       | 0                      | 0                    | DUE_PENALTY_INTEREST_PRINCIPAL_FEE_IN_ADVANCE_PENALTY_INTEREST_PRINCIPAL_FEE |
    And Admin successfully approves the loan on "20230101" with "1000" amount and expected disbursement date on "20230101"
    When Admin successfully disburse the loan on "20230101" with "1000" EUR transaction amount

    When Admin sets the business date to "20230110"
    When Admin adds "LOAN_SNOOZE_FEE" due date charge with "20230201" due date and 20 EUR transaction amount

    When Admin sets the business date to "20230110"
    And Customer makes "AUTOPAY" repayment on "20230110" with 1020 EUR transaction amount
    Then Loan status will be "CLOSED_OBLIGATIONS_MET"
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20230101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
      | 20230110  | Accrual          | 20.0   | 0.0       | 0.0      | 20.0 | 0.0       | 0.0          |
      | 20230110  | Repayment        | 1020.0 | 1000.0    | 0.0      | 20.0 | 0.0       | 0.0          |
    Then Loan Charges tab has the following data:
      | Name       | isPenalty | Payment due at     | Due as of        | Calculation type | Due  | Paid | Waived | Outstanding |
      | Snooze fee | false     | Specified due date | 20230201 | Flat             | 20.0 | 20.0 | 0.0    | 0.0         |
    Then Loan Repayment schedule has 1 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late | Outstanding |
      |    |      | 20230101  |                 | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0    |            |      |             |
      | 1  | 31   | 20230201 | 20230110 | 0.0             | 1000.0        | 0.0      | 20.0 | 0.0       | 1020.0 | 1020.0 | 1020.0     | 0.0  | 0.0         |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due  | Paid | In advance | Late | Outstanding |
      | 1000          | 0        | 20   | 0         | 1020 | 1020 | 1020       | 0    | 0           |

    When Admin sets the business date to "20230125"
    When Customer undo "1"th "Repayment" transaction made on "20230110"
    When Admin adds "LOAN_NSF_FEE" due date charge with "20230201" due date and 20 EUR transaction amount
    Then Loan status will be "ACTIVE"
    Then On Loan Transactions tab the "Repayment" Transaction with date "20230110" is reverted
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20230101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
      | 20230110  | Repayment        | 1020.0 | 1000.0    | 0.0      | 20.0 | 0.0       | 0.0          |
      | 20230110  | Accrual          | 20.0   | 0.0       | 0.0      | 20.0 | 0.0       | 0.0          |
    Then Loan Charges tab has the following data:
      | Name       | isPenalty | Payment due at     | Due as of        | Calculation type | Due  | Paid | Waived | Outstanding |
      | NSF fee    | true      | Specified due date | 20230201 | Flat             | 20.0 | 0.0  | 0.0    | 20.0        |
      | Snooze fee | false     | Specified due date | 20230201 | Flat             | 20.0 | 0.0  | 0.0    | 20.0        |

    When Admin sets the business date to "20230128"
    And Customer makes "AUTOPAY" repayment on "20230128" with 520 EUR transaction amount
    Then On Loan Transactions tab the "Repayment" Transaction with date "20230110" is reverted
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20230101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
      | 20230110  | Repayment        | 1020.0 | 1000.0    | 0.0      | 20.0 | 0.0       | 0.0          |
      | 20230110  | Accrual          | 20.0   | 0.0       | 0.0      | 20.0 | 0.0       | 0.0          |
      | 20230128  | Repayment        | 520.0  | 500.0     | 0.0      | 0.0  | 20.0      | 500.0        |
    Then Loan Charges tab has the following data:
      | Name       | isPenalty | Payment due at     | Due as of        | Calculation type | Due  | Paid | Waived | Outstanding |
      | Snooze fee | false     | Specified due date | 20230201 | Flat             | 20.0 | 0.0  | 0.0    | 20.0        |
      | NSF fee    | true      | Specified due date | 20230201 | Flat             | 20.0 | 20.0 | 0.0    | 0.0         |
    Then Loan Repayment schedule has 1 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      |    |      | 20230101  |           | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0   |            |      |             |
      | 1  | 31   | 20230201 |           | 0.0             | 1000.0        | 0.0      | 20.0 | 20.0      | 1040.0 | 520.0 | 520.0      | 0.0  | 520.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due  | Paid | In advance | Late | Outstanding |
      | 1000          | 0        | 20   | 20        | 1040 | 520  | 520        | 0    | 520         |

    When Admin sets the business date to "20230201"
    And Customer makes "AUTOPAY" repayment on "20230201" with 500 EUR transaction amount
    Then On Loan Transactions tab the "Repayment" Transaction with date "20230110" is reverted
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20230101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
      | 20230110  | Repayment        | 1020.0 | 1000.0    | 0.0      | 20.0 | 0.0       | 0.0          |
      | 20230110  | Accrual          | 20.0   | 0.0       | 0.0      | 20.0 | 0.0       | 0.0          |
      | 20230128  | Repayment        | 520.0  | 500.0     | 0.0      | 0.0  | 20.0      | 500.0        |
      | 20230201 | Repayment        | 500.0  | 500.0     | 0.0      | 0.0  | 0.0       | 0.0          |
    Then Loan Charges tab has the following data:
      | Name       | isPenalty | Payment due at     | Due as of        | Calculation type | Due  | Paid | Waived | Outstanding |
      | Snooze fee | false     | Specified due date | 20230201 | Flat             | 20.0 | 0.0  | 0.0    | 20.0        |
      | NSF fee    | true      | Specified due date | 20230201 | Flat             | 20.0 | 20.0 | 0.0    | 0.0         |
    Then Loan Repayment schedule has 1 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late | Outstanding |
      |    |      | 20230101  |           | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0    |            |      |             |
      | 1  | 31   | 20230201 |           | 0.0             | 1000.0        | 0.0      | 20.0 | 20.0      | 1040.0 | 1020.0 | 520.0      | 0.0  | 20.0        |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due  | Paid | In advance | Late | Outstanding |
      | 1000          | 0        | 20   | 20        | 1040 | 1020 | 520        | 0    | 20          |

    When Admin sets the business date to "20230205"
    And Customer makes "AUTOPAY" repayment on "20230205" with 20 EUR transaction amount
    Then On Loan Transactions tab the "Repayment" Transaction with date "20230110" is reverted
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20230101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
      | 20230110  | Repayment        | 1020.0 | 1000.0    | 0.0      | 20.0 | 0.0       | 0.0          |
      | 20230110  | Accrual          | 20.0   | 0.0       | 0.0      | 20.0 | 0.0       | 0.0          |
      | 20230128  | Repayment        | 520.0  | 500.0     | 0.0      | 0.0  | 20.0      | 500.0        |
      | 20230201 | Repayment        | 500.0  | 500.0     | 0.0      | 0.0  | 0.0       | 0.0          |
      | 20230205 | Repayment        | 20.0   | 0.0       | 0.0      | 20.0 | 0.0       | 0.0          |
      | 20230205 | Accrual          | 20.0   | 0.0       | 0.0      | 0.0  | 20.0      | 0.0          |
    Then Loan Charges tab has the following data:
      | Name       | isPenalty | Payment due at     | Due as of        | Calculation type | Due  | Paid | Waived | Outstanding |
      | Snooze fee | false     | Specified due date | 20230201 | Flat             | 20.0 | 20.0 | 0.0    | 0.0         |
      | NSF fee    | true      | Specified due date | 20230201 | Flat             | 20.0 | 20.0 | 0.0    | 0.0         |
    Then Loan Repayment schedule has 1 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late | Outstanding |
      |    |      | 20230101  |                  | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0    |            |      |             |
      | 1  | 31   | 20230201 | 20230205 | 0.0             | 1000.0        | 0.0      | 20.0 | 20.0      | 1040.0 | 1040.0 | 520.0      | 20.0 | 0.0         |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due  | Paid | In advance | Late | Outstanding |
      | 1000          | 0        | 20   | 20        | 1040 | 1040 | 520        | 20   | 0           |

  @TestRailId:C2703 @PaymentStrategyDueInAdvancePenaltyInterestPrincipalFee
  Scenario: Verify the due-penalty-interest-principal-fee-in-advance-penalty-interest-principal-fee-strategy payment strategy: UC10 - partial payment, in advance principal, fee, due penalty
    When Admin sets the business date to "20230101"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                        | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy                                                             |
      | LP1_PAYMENT_STRATEGY_DUE_IN_ADVANCE_PENALTY_INTEREST_PRINCIPAL_FEE | 20230101   | 1000           | 0                      | DECLINING_BALANCE | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 1                 | MONTHS                | 1              | MONTHS                 | 1                  | 0                       | 0                      | 0                    | DUE_PENALTY_INTEREST_PRINCIPAL_FEE_IN_ADVANCE_PENALTY_INTEREST_PRINCIPAL_FEE |
    And Admin successfully approves the loan on "20230101" with "1000" amount and expected disbursement date on "20230101"
    When Admin successfully disburse the loan on "20230101" with "1000" EUR transaction amount

    When Admin sets the business date to "20230110"
    When Admin adds "LOAN_SNOOZE_FEE" due date charge with "20230201" due date and 20 EUR transaction amount

    When Admin sets the business date to "20230110"
    And Customer makes "AUTOPAY" repayment on "20230110" with 1020 EUR transaction amount
    Then Loan status will be "CLOSED_OBLIGATIONS_MET"
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20230101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
      | 20230110  | Accrual          | 20.0   | 0.0       | 0.0      | 20.0 | 0.0       | 0.0          |
      | 20230110  | Repayment        | 1020.0 | 1000.0    | 0.0      | 20.0 | 0.0       | 0.0          |
    Then Loan Charges tab has the following data:
      | Name       | isPenalty | Payment due at     | Due as of        | Calculation type | Due  | Paid | Waived | Outstanding |
      | Snooze fee | false     | Specified due date | 20230201 | Flat             | 20.0 | 20.0 | 0.0    | 0.0         |
    Then Loan Repayment schedule has 1 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late | Outstanding |
      |    |      | 20230101  |                 | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0    |            |      |             |
      | 1  | 31   | 20230201 | 20230110 | 0.0             | 1000.0        | 0.0      | 20.0 | 0.0       | 1020.0 | 1020.0 | 1020.0     | 0.0  | 0.0         |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due  | Paid | In advance | Late | Outstanding |
      | 1000          | 0        | 20   | 0         | 1020 | 1020 | 1020       | 0    | 0           |

    When Admin sets the business date to "20230125"
    When Customer undo "1"th "Repayment" transaction made on "20230110"
    When Admin adds "LOAN_NSF_FEE" due date charge with "20230128" due date and 20 EUR transaction amount
    Then Loan status will be "ACTIVE"
    Then On Loan Transactions tab the "Repayment" Transaction with date "20230110" is reverted
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20230101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
      | 20230110  | Accrual          | 20.0   | 0.0       | 0.0      | 20.0 | 0.0       | 0.0          |
      | 20230110  | Repayment        | 1020.0 | 1000.0    | 0.0      | 20.0 | 0.0       | 0.0          |
    Then Loan Charges tab has the following data:
      | Name       | isPenalty | Payment due at     | Due as of        | Calculation type | Due  | Paid | Waived | Outstanding |
      | NSF fee    | true      | Specified due date | 20230128  | Flat             | 20.0 | 0.0  | 0.0    | 20.0        |
      | Snooze fee | false     | Specified due date | 20230201 | Flat             | 20.0 | 0.0  | 0.0    | 20.0        |

    When Admin sets the business date to "20230128"
    And Customer makes "AUTOPAY" repayment on "20230128" with 520 EUR transaction amount
    Then On Loan Transactions tab the "Repayment" Transaction with date "20230110" is reverted
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20230101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
      | 20230110  | Accrual          | 20.0   | 0.0       | 0.0      | 20.0 | 0.0       | 0.0          |
      | 20230110  | Repayment        | 1020.0 | 1000.0    | 0.0      | 20.0 | 0.0       | 0.0          |
      | 20230128  | Repayment        | 520.0  | 500.0     | 0.0      | 0.0  | 20.0      | 500.0        |
    Then Loan Charges tab has the following data:
      | Name       | isPenalty | Payment due at     | Due as of        | Calculation type | Due  | Paid | Waived | Outstanding |
      | Snooze fee | false     | Specified due date | 20230201 | Flat             | 20.0 | 0.0  | 0.0    | 20.0        |
      | NSF fee    | true      | Specified due date | 20230128  | Flat             | 20.0 | 20.0 | 0.0    | 0.0         |
    Then Loan Repayment schedule has 1 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      |    |      | 20230101  |           | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0   |            |      |             |
      | 1  | 31   | 20230201 |           | 0.0             | 1000.0        | 0.0      | 20.0 | 20.0      | 1040.0 | 520.0 | 520.0      | 0.0  | 520.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due  | Paid | In advance | Late | Outstanding |
      | 1000          | 0        | 20   | 20        | 1040 | 520  | 520        | 0    | 520         |

    When Admin sets the business date to "20230130"
    And Customer makes "AUTOPAY" repayment on "20230130" with 520 EUR transaction amount
    Then On Loan Transactions tab the "Repayment" Transaction with date "20230110" is reverted
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20230101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
      | 20230110  | Accrual          | 20.0   | 0.0       | 0.0      | 20.0 | 0.0       | 0.0          |
      | 20230110  | Repayment        | 1020.0 | 1000.0    | 0.0      | 20.0 | 0.0       | 0.0          |
      | 20230128  | Repayment        | 520.0  | 500.0     | 0.0      | 0.0  | 20.0      | 500.0        |
      | 20230130  | Repayment        | 520.0  | 500.0     | 0.0      | 20.0 | 0.0       | 0.0          |
      | 20230130  | Accrual          | 20.0   | 0.0       | 0.0      | 0.0  | 20.0      | 0.0          |
    Then Loan Charges tab has the following data:
      | Name       | isPenalty | Payment due at     | Due as of        | Calculation type | Due  | Paid | Waived | Outstanding |
      | Snooze fee | false     | Specified due date | 20230201 | Flat             | 20.0 | 20.0 | 0.0    | 0.0         |
      | NSF fee    | true      | Specified due date | 20230128  | Flat             | 20.0 | 20.0 | 0.0    | 0.0         |
    Then Loan Repayment schedule has 1 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late | Outstanding |
      |    |      | 20230101  |                 | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0    |            |      |             |
      | 1  | 31   | 20230201 | 20230130 | 0.0             | 1000.0        | 0.0      | 20.0 | 20.0      | 1040.0 | 1040.0 | 1040.0     | 0.0  | 0.0         |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due  | Paid | In advance | Late | Outstanding |
      | 1000          | 0        | 20   | 20        | 1040 | 1040 | 1040       | 0    | 0           |

  @TestRailId:C2704 @PaymentStrategyDueInAdvancePenaltyInterestPrincipalFee
  Scenario: Verify the due-penalty-interest-principal-fee-in-advance-penalty-interest-principal-fee-strategy payment strategy: UC11 - partial payment, in advance principal, fee, due penalty, principal, fee
    When Admin sets the business date to "20230101"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                        | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy                                                             |
      | LP1_PAYMENT_STRATEGY_DUE_IN_ADVANCE_PENALTY_INTEREST_PRINCIPAL_FEE | 20230101   | 1000           | 0                      | DECLINING_BALANCE | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 1                 | MONTHS                | 1              | MONTHS                 | 1                  | 0                       | 0                      | 0                    | DUE_PENALTY_INTEREST_PRINCIPAL_FEE_IN_ADVANCE_PENALTY_INTEREST_PRINCIPAL_FEE |
    And Admin successfully approves the loan on "20230101" with "1000" amount and expected disbursement date on "20230101"
    When Admin successfully disburse the loan on "20230101" with "1000" EUR transaction amount

    When Admin sets the business date to "20230105"
    When Admin adds "LOAN_SNOOZE_FEE" due date charge with "20230201" due date and 20 EUR transaction amount

    When Admin sets the business date to "20230110"
    And Customer makes "AUTOPAY" repayment on "20230110" with 1020 EUR transaction amount
    Then Loan status will be "CLOSED_OBLIGATIONS_MET"
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20230101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
      | 20230110  | Accrual          | 20.0   | 0.0       | 0.0      | 20.0 | 0.0       | 0.0          |
      | 20230110  | Repayment        | 1020.0 | 1000.0    | 0.0      | 20.0 | 0.0       | 0.0          |
    Then Loan Charges tab has the following data:
      | Name       | isPenalty | Payment due at     | Due as of        | Calculation type | Due  | Paid | Waived | Outstanding |
      | Snooze fee | false     | Specified due date | 20230201 | Flat             | 20.0 | 20.0 | 0.0    | 0.0         |
    Then Loan Repayment schedule has 1 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late | Outstanding |
      |    |      | 20230101  |                 | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0    |            |      |             |
      | 1  | 31   | 20230201 | 20230110 | 0.0             | 1000.0        | 0.0      | 20.0 | 0.0       | 1020.0 | 1020.0 | 1020.0     | 0.0  | 0.0         |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due  | Paid | In advance | Late | Outstanding |
      | 1000          | 0        | 20   | 0         | 1020 | 1020 | 1020       | 0    | 0           |

    When Admin sets the business date to "20230125"
    When Customer undo "1"th "Repayment" transaction made on "20230110"
    When Admin adds "LOAN_NSF_FEE" due date charge with "20230128" due date and 20 EUR transaction amount
    Then Loan status will be "ACTIVE"
    Then On Loan Transactions tab the "Repayment" Transaction with date "20230110" is reverted
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20230101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
      | 20230110  | Repayment        | 1020.0 | 1000.0    | 0.0      | 20.0 | 0.0       | 0.0          |
      | 20230110  | Accrual          | 20.0   | 0.0       | 0.0      | 20.0 | 0.0       | 0.0          |
    Then Loan Charges tab has the following data:
      | Name       | isPenalty | Payment due at     | Due as of        | Calculation type | Due  | Paid | Waived | Outstanding |
      | NSF fee    | true      | Specified due date | 20230128  | Flat             | 20.0 | 0.0  | 0.0    | 20.0        |
      | Snooze fee | false     | Specified due date | 20230201 | Flat             | 20.0 | 0.0  | 0.0    | 20.0        |

    When Admin sets the business date to "20230128"
    And Customer makes "AUTOPAY" repayment on "20230128" with 1040 EUR transaction amount
    Then Loan status will be "CLOSED_OBLIGATIONS_MET"
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20230101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
      | 20230110  | Repayment        | 1020.0 | 1000.0    | 0.0      | 20.0 | 0.0       | 0.0          |
      | 20230110  | Accrual          | 20.0   | 0.0       | 0.0      | 20.0 | 0.0       | 0.0          |
      | 20230128  | Repayment        | 1040.0 | 1000.0    | 0.0      | 20.0 | 20.0      | 0.0          |
      | 20230128  | Accrual          | 20.0   | 0.0       | 0.0      | 0.0  | 20.0      | 0.0          |
    Then Loan Charges tab has the following data:
      | Name       | isPenalty | Payment due at     | Due as of        | Calculation type | Due  | Paid | Waived | Outstanding |
      | NSF fee    | true      | Specified due date | 20230128  | Flat             | 20.0 | 20.0 | 0.0    | 0.0         |
      | Snooze fee | false     | Specified due date | 20230201 | Flat             | 20.0 | 20.0 | 0.0    | 0.0         |
    Then Loan Repayment schedule has 1 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late | Outstanding |
      |    |      | 20230101  |                 | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0    |            |      |             |
      | 1  | 31   | 20230201 | 20230128 | 0.0             | 1000.0        | 0.0      | 20.0 | 20.0      | 1040.0 | 1040.0 | 1040.0     | 0.0  | 0.0         |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due  | Paid | In advance | Late | Outstanding |
      | 1000          | 0        | 20   | 20        | 1040 | 1040 | 1040       | 0    | 0           |

    When Admin sets the business date to "20230130"
    When Customer undo "1"th "Repayment" transaction made on "20230128"
    When Admin adds "LOAN_NSF_FEE" due date charge with "20230201" due date and 20 EUR transaction amount
    Then Loan status will be "ACTIVE"
    Then On Loan Transactions tab the "Repayment" Transaction with date "20230110" is reverted
    Then On Loan Transactions tab the "Repayment" Transaction with date "20230128" is reverted
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20230101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
      | 20230110  | Accrual          | 20.0   | 0.0       | 0.0      | 20.0 | 0.0       | 0.0          |
      | 20230110  | Repayment        | 1020.0 | 1000.0    | 0.0      | 20.0 | 0.0       | 0.0          |
      | 20230128  | Accrual          | 20.0   | 0.0       | 0.0      | 0.0  | 20.0      | 0.0          |
      | 20230128  | Repayment        | 1040.0 | 1000.0    | 0.0      | 20.0 | 20.0      | 0.0          |
    Then Loan Charges tab has the following data:
      | Name       | isPenalty | Payment due at     | Due as of        | Calculation type | Due  | Paid | Waived | Outstanding |
      | NSF fee    | true      | Specified due date | 20230201 | Flat             | 20.0 | 0.0  | 0.0    | 20.0        |
      | NSF fee    | true      | Specified due date | 20230128  | Flat             | 20.0 | 0.0  | 0.0    | 20.0        |
      | Snooze fee | false     | Specified due date | 20230201 | Flat             | 20.0 | 0.0  | 0.0    | 20.0        |

    When Admin sets the business date to "20230201"
    And Customer makes "AUTOPAY" repayment on "20230201" with 20 EUR transaction amount
    Then Loan status will be "ACTIVE"
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20230101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
      | 20230110  | Repayment        | 1020.0 | 1000.0    | 0.0      | 20.0 | 0.0       | 0.0          |
      | 20230110  | Accrual          | 20.0   | 0.0       | 0.0      | 20.0 | 0.0       | 0.0          |
      | 20230128  | Repayment        | 1040.0 | 1000.0    | 0.0      | 20.0 | 20.0      | 0.0          |
      | 20230128  | Accrual          | 20.0   | 0.0       | 0.0      | 0.0  | 20.0      | 0.0          |
      | 20230201 | Repayment        | 20.0   | 0.0       | 0.0      | 0.0  | 20.0      | 1000.0       |
    Then Loan Charges tab has the following data:
      | Name       | isPenalty | Payment due at     | Due as of        | Calculation type | Due  | Paid | Waived | Outstanding |
      | NSF fee    | true      | Specified due date | 20230201 | Flat             | 20.0 | 0.0  | 0.0    | 20.0        |
      | NSF fee    | true      | Specified due date | 20230128  | Flat             | 20.0 | 20.0 | 0.0    | 0.0         |
      | Snooze fee | false     | Specified due date | 20230201 | Flat             | 20.0 | 0.0  | 0.0    | 20.0        |
    Then Loan Repayment schedule has 1 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      |    |      | 20230101  |           | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      | 1  | 31   | 20230201 |           | 0.0             | 1000.0        | 0.0      | 20.0 | 40.0      | 1060.0 | 20.0 | 0.0        | 0.0  | 1040.0      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due  | Paid | In advance | Late | Outstanding |
      | 1000          | 0        | 20   | 40        | 1060 | 20   | 0          | 0    | 1040        |

    When Admin sets the business date to "20230205"
    And Customer makes "AUTOPAY" repayment on "20230205" with 1040 EUR transaction amount
    Then Loan status will be "CLOSED_OBLIGATIONS_MET"
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20230101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
      | 20230110  | Repayment        | 1020.0 | 1000.0    | 0.0      | 20.0 | 0.0       | 0.0          |
      | 20230110  | Accrual          | 20.0   | 0.0       | 0.0      | 20.0 | 0.0       | 0.0          |
      | 20230128  | Repayment        | 1040.0 | 1000.0    | 0.0      | 20.0 | 20.0      | 0.0          |
      | 20230128  | Accrual          | 20.0   | 0.0       | 0.0      | 0.0  | 20.0      | 0.0          |
      | 20230201 | Repayment        | 20.0   | 0.0       | 0.0      | 0.0  | 20.0      | 1000.0       |
      | 20230205 | Repayment        | 1040.0 | 1000.0    | 0.0      | 20.0 | 20.0      | 0.0          |
      | 20230205 | Accrual          | 20.0   | 0.0       | 0.0      | 0.0  | 20.0      | 0.0          |
    Then Loan Charges tab has the following data:
      | Name       | isPenalty | Payment due at     | Due as of        | Calculation type | Due  | Paid | Waived | Outstanding |
      | NSF fee    | true      | Specified due date | 20230201 | Flat             | 20.0 | 20.0 | 0.0    | 0.0         |
      | NSF fee    | true      | Specified due date | 20230128  | Flat             | 20.0 | 20.0 | 0.0    | 0.0         |
      | Snooze fee | false     | Specified due date | 20230201 | Flat             | 20.0 | 20.0 | 0.0    | 0.0         |
    Then Loan Repayment schedule has 1 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late   | Outstanding |
      |    |      | 20230101  |                  | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0    |            |        |             |
      | 1  | 31   | 20230201 | 20230205 | 0.0             | 1000.0        | 0.0      | 20.0 | 40.0      | 1060.0 | 1060.0 | 0.0        | 1040.0 | 0.0         |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due  | Paid | In advance | Late | Outstanding |
      | 1000          | 0        | 20   | 40        | 1060 | 1060 | 0          | 1040 | 0           |

  @TestRailId:C2705 @PaymentStrategyDueInAdvancePenaltyInterestPrincipalFee
  Scenario: Verify the due-penalty-interest-principal-fee-in-advance-penalty-interest-principal-fee-strategy payment strategy: UC12 - partial payment, in advance penalty, interest, principal, fee due penalty, interest, principal, fee
    When Admin sets the business date to "20230101"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                      | submitted on date | with Principal | ANNUAL interest rate % | interest type | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy                                                             |
      | LP1_PAYMENT_STRATEGY_DUE_IN_ADVANCE_PENALTY_INTEREST_PRINCIPAL_FEE_INTEREST_FLAT | 20230101   | 1000           | 12                     | FLAT          | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 1                 | MONTHS                | 1              | MONTHS                 | 1                  | 0                       | 0                      | 0                    | DUE_PENALTY_INTEREST_PRINCIPAL_FEE_IN_ADVANCE_PENALTY_INTEREST_PRINCIPAL_FEE |
    And Admin successfully approves the loan on "20230101" with "1000" amount and expected disbursement date on "20230101"
    When Admin successfully disburse the loan on "20230101" with "1000" EUR transaction amount

    When Admin sets the business date to "20230105"
    When Admin adds "LOAN_SNOOZE_FEE" due date charge with "20230201" due date and 20 EUR transaction amount
    When Admin adds "LOAN_NSF_FEE" due date charge with "20230201" due date and 20 EUR transaction amount

    When Admin sets the business date to "20230110"
    And Customer makes "AUTOPAY" repayment on "20230110" with 20 EUR transaction amount
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20230101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
      | 20230110  | Repayment        | 20.0   | 0.0       | 0.0      | 0.0  | 20.0      | 1000.0       |
    Then Loan Charges tab has the following data:
      | Name       | isPenalty | Payment due at     | Due as of        | Calculation type | Due  | Paid | Waived | Outstanding |
      | NSF fee    | true      | Specified due date | 20230201 | Flat             | 20.0 | 20.0 | 0.0    | 0.0         |
      | Snooze fee | false     | Specified due date | 20230201 | Flat             | 20.0 | 0.0  | 0.0    | 20.0        |
    Then Loan Repayment schedule has 1 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      |    |      | 20230101  |           | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      | 1  | 31   | 20230201 |           | 0.0             | 1000.0        | 10.0     | 20.0 | 20.0      | 1050.0 | 20.0 | 20.0       | 0.0  | 1030.0      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due  | Paid | In advance | Late | Outstanding |
      | 1000          | 10       | 20   | 20        | 1050 | 20   | 20         | 0    | 1030        |

    When Admin sets the business date to "20230115"
    And Customer makes "AUTOPAY" repayment on "20230115" with 500 EUR transaction amount
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20230101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
      | 20230110  | Repayment        | 20.0   | 0.0       | 0.0      | 0.0  | 20.0      | 1000.0       |
      | 20230115  | Repayment        | 500.0  | 490.0     | 10.0     | 0.0  | 0.0       | 510.0        |
    Then Loan Charges tab has the following data:
      | Name       | isPenalty | Payment due at     | Due as of        | Calculation type | Due  | Paid | Waived | Outstanding |
      | NSF fee    | true      | Specified due date | 20230201 | Flat             | 20.0 | 20.0 | 0.0    | 0.0         |
      | Snooze fee | false     | Specified due date | 20230201 | Flat             | 20.0 | 0.0  | 0.0    | 20.0        |
    Then Loan Repayment schedule has 1 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      |    |      | 20230101  |           | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0   |            |      |             |
      | 1  | 31   | 20230201 |           | 0.0             | 1000.0        | 10.0     | 20.0 | 20.0      | 1050.0 | 520.0 | 520.0      | 0.0  | 530.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due  | Paid | In advance | Late | Outstanding |
      | 1000          | 10       | 20   | 20        | 1050 | 520  | 520        | 0    | 530         |

    When Admin sets the business date to "20230125"
    And Customer makes "AUTOPAY" repayment on "20230125" with 530 EUR transaction amount
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20230101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
      | 20230110  | Repayment        | 20.0   | 0.0       | 0.0      | 0.0  | 20.0      | 1000.0       |
      | 20230115  | Repayment        | 500.0  | 490.0     | 10.0     | 0.0  | 0.0       | 510.0        |
      | 20230125  | Repayment        | 530.0  | 510.0     | 0.0      | 20.0 | 0.0       | 0.0          |
      | 20230125  | Accrual          | 50.0   | 0.0       | 10.0     | 20.0 | 20.0      | 0.0          |
    Then Loan Charges tab has the following data:
      | Name       | isPenalty | Payment due at     | Due as of        | Calculation type | Due  | Paid | Waived | Outstanding |
      | NSF fee    | true      | Specified due date | 20230201 | Flat             | 20.0 | 20.0 | 0.0    | 0.0         |
      | Snooze fee | false     | Specified due date | 20230201 | Flat             | 20.0 | 20.0 | 0.0    | 0.0         |
    Then Loan Repayment schedule has 1 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late | Outstanding |
      |    |      | 20230101  |                 | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0    |            |      |             |
      | 1  | 31   | 20230201 | 20230125 | 0.0             | 1000.0        | 10.0     | 20.0 | 20.0      | 1050.0 | 1050.0 | 1050.0     | 0.0  | 0.0         |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due  | Paid | In advance | Late | Outstanding |
      | 1000          | 10       | 20   | 20        | 1050 | 1050 | 1050       | 0    | 0           |

    When Admin sets the business date to "20230130"
    When Customer undo "1"th "Repayment" transaction made on "20230110"
    When Customer undo "1"th "Repayment" transaction made on "20230115"
    When Customer undo "1"th "Repayment" transaction made on "20230125"
    Then Loan status will be "ACTIVE"
    Then On Loan Transactions tab the "Repayment" Transaction with date "20230110" is reverted
    Then On Loan Transactions tab the "Repayment" Transaction with date "20230115" is reverted
    Then On Loan Transactions tab the "Repayment" Transaction with date "20230125" is reverted

    When Admin sets the business date to "20230201"
    And Customer makes "AUTOPAY" repayment on "20230201" with 20 EUR transaction amount
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20230101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
      | 20230110  | Repayment        | 20.0   | 0.0       | 0.0      | 0.0  | 20.0      | 1000.0       |
      | 20230115  | Repayment        | 500.0  | 470.0     | 10.0     | 0.0  | 20.0      | 530.0        |
      | 20230125  | Accrual          | 50.0   | 0.0       | 10.0     | 20.0 | 20.0      | 0.0          |
      | 20230125  | Repayment        | 530.0  | 500.0     | 10.0     | 0.0  | 20.0      | 500.0        |
      | 20230201 | Repayment        | 20.0   | 0.0       | 0.0      | 0.0  | 20.0      | 1000.0       |
    Then Loan Charges tab has the following data:
      | Name       | isPenalty | Payment due at     | Due as of        | Calculation type | Due  | Paid | Waived | Outstanding |
      | NSF fee    | true      | Specified due date | 20230201 | Flat             | 20.0 | 20.0 | 0.0    | 0.0         |
      | Snooze fee | false     | Specified due date | 20230201 | Flat             | 20.0 | 0.0  | 0.0    | 20.0        |
    Then Loan Repayment schedule has 1 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      |    |      | 20230101  |           | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      | 1  | 31   | 20230201 |           | 0.0             | 1000.0        | 10.0     | 20.0 | 20.0      | 1050.0 | 20.0 | 0.0        | 0.0  | 1030.0      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due  | Paid | In advance | Late | Outstanding |
      | 1000          | 10       | 20   | 20        | 1050 | 20   | 0          | 0    | 1030        |
    And Customer makes "AUTOPAY" repayment on "20230201" with 10 EUR transaction amount
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20230101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
      | 20230110  | Repayment        | 20.0   | 0.0       | 0.0      | 0.0  | 20.0      | 1000.0       |
      | 20230115  | Repayment        | 500.0  | 470.0     | 10.0     | 0.0  | 20.0      | 530.0        |
      | 20230125  | Accrual          | 50.0   | 0.0       | 10.0     | 20.0 | 20.0      | 0.0          |
      | 20230125  | Repayment        | 530.0  | 500.0     | 10.0     | 0.0  | 20.0      | 500.0        |
      | 20230201 | Repayment        | 20.0   | 0.0       | 0.0      | 0.0  | 20.0      | 1000.0       |
      | 20230201 | Repayment        | 10.0   | 0.0       | 10.0     | 0.0  | 0.0       | 1000.0       |
    And Customer makes "AUTOPAY" repayment on "20230201" with 1000 EUR transaction amount
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20230101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
      | 20230110  | Repayment        | 20.0   | 0.0       | 0.0      | 0.0  | 20.0      | 1000.0       |
      | 20230115  | Repayment        | 500.0  | 470.0     | 10.0     | 0.0  | 20.0      | 530.0        |
      | 20230125  | Accrual          | 50.0   | 0.0       | 10.0     | 20.0 | 20.0      | 0.0          |
      | 20230125  | Repayment        | 530.0  | 500.0     | 10.0     | 0.0  | 20.0      | 500.0        |
      | 20230201 | Repayment        | 20.0   | 0.0       | 0.0      | 0.0  | 20.0      | 1000.0       |
      | 20230201 | Repayment        | 10.0   | 0.0       | 10.0     | 0.0  | 0.0       | 1000.0       |
      | 20230201 | Repayment        | 1000.0 | 1000.0    | 0.0      | 0.0  | 0.0       | 0.0          |
    And Customer makes "AUTOPAY" repayment on "20230201" with 20 EUR transaction amount
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20230101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
      | 20230110  | Repayment        | 20.0   | 0.0       | 0.0      | 0.0  | 20.0      | 1000.0       |
      | 20230115  | Repayment        | 500.0  | 470.0     | 10.0     | 0.0  | 20.0      | 530.0        |
      | 20230125  | Accrual          | 50.0   | 0.0       | 10.0     | 20.0 | 20.0      | 0.0          |
      | 20230125  | Repayment        | 530.0  | 500.0     | 10.0     | 0.0  | 20.0      | 500.0        |
      | 20230201 | Repayment        | 20.0   | 0.0       | 0.0      | 0.0  | 20.0      | 1000.0       |
      | 20230201 | Repayment        | 10.0   | 0.0       | 10.0     | 0.0  | 0.0       | 1000.0       |
      | 20230201 | Repayment        | 1000.0 | 1000.0    | 0.0      | 0.0  | 0.0       | 0.0          |
      | 20230201 | Repayment        | 20.0   | 0.0       | 0.0      | 20.0 | 0.0       | 0.0          |
    Then On Loan Transactions tab the "Repayment" Transaction with date "20230110" is reverted
    Then On Loan Transactions tab the "Repayment" Transaction with date "20230115" is reverted
    Then On Loan Transactions tab the "Repayment" Transaction with date "20230125" is reverted
    Then Loan Charges tab has the following data:
      | Name       | isPenalty | Payment due at     | Due as of        | Calculation type | Due  | Paid | Waived | Outstanding |
      | NSF fee    | true      | Specified due date | 20230201 | Flat             | 20.0 | 20.0 | 0.0    | 0.0         |
      | Snooze fee | false     | Specified due date | 20230201 | Flat             | 20.0 | 20.0 | 0.0    | 0.0         |
    Then Loan Repayment schedule has 1 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late | Outstanding |
      |    |      | 20230101  |                  | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0    |            |      |             |
      | 1  | 31   | 20230201 | 20230201 | 0.0             | 1000.0        | 10.0     | 20.0 | 20.0      | 1050.0 | 1050.0 | 0.0        | 0.0  | 0.0         |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due  | Paid | In advance | Late | Outstanding |
      | 1000          | 10       | 20   | 20        | 1050 | 1050 | 0          | 0    | 0           |

  @TestRailId:C2800 @PaymentStrategyDueInAdvancePenaltyInterestPrincipalFee
  Scenario: Verify the due-penalty-interest-principal-fee-in-advance-penalty-interest-principal-fee-strategy payment strategy: Same day transaction - UC2
    When Admin sets the business date to "20230101"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                      | submitted on date | with Principal | ANNUAL interest rate % | interest type | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy                                                             |
      | LP1_PAYMENT_STRATEGY_DUE_IN_ADVANCE_PENALTY_INTEREST_PRINCIPAL_FEE_INTEREST_FLAT | 20230101   | 1000           | 12                     | FLAT          | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 1                 | MONTHS                | 1              | MONTHS                 | 1                  | 0                       | 0                      | 0                    | DUE_PENALTY_INTEREST_PRINCIPAL_FEE_IN_ADVANCE_PENALTY_INTEREST_PRINCIPAL_FEE |
    And Admin successfully approves the loan on "20230101" with "1000" amount and expected disbursement date on "20230101"
    When Admin successfully disburse the loan on "20230101" with "1000" EUR transaction amount
    When Admin sets the business date to "20230104"
    And Customer makes "AUTOPAY" repayment on "20230104" with 200 EUR transaction amount
    When Admin sets the business date to "20230112"
    And Customer makes "AUTOPAY" repayment on "20230112" with 300 EUR transaction amount
    And Admin adds a 1 % Processing charge to the loan with "en" locale on date: "20230112"
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20230101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
      | 20230104  | Repayment        | 200.0  | 190.0     | 10.0     | 0.0  | 0.0       | 810.0        |
      | 20230112  | Repayment        | 300.0  | 289.9     | 0.0      | 10.1 | 0.0       | 520.1        |
    And Customer makes "AUTOPAY" repayment on "20230112" with 520.10 EUR transaction amount
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20230101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
      | 20230104  | Repayment        | 200.0  | 190.0     | 10.0     | 0.0  | 0.0       | 810.0        |
      | 20230112  | Repayment        | 300.0  | 289.9     | 0.0      | 10.1 | 0.0       | 520.1        |
      | 20230112  | Repayment        | 520.1  | 520.1     | 0.0      | 0.0  | 0.0       | 0.0          |
      | 20230112  | Accrual          | 20.1   | 0.0       | 10.0     | 10.1 | 0.0       | 0.0          |

  @TestRailId:C2810
  Scenario: As a user I would like to adjust an existing repayment and validate the event
    When Admin sets the business date to "20221101"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy                                                             |
      | LP1         | 20221101  | 1000           | 0                      | DECLINING_BALANCE | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 30                | DAYS                  | 30             | DAYS                   | 1                  | 0                       | 0                      | 0                    | DUE_PENALTY_FEE_INTEREST_PRINCIPAL_IN_ADVANCE_PRINCIPAL_PENALTY_FEE_INTEREST |
    And Admin successfully approves the loan on "20221101" with "1000" amount and expected disbursement date on "20221101"
    When Admin successfully disburse the loan on "20221101" with "1000" EUR transaction amount
    Then Loan has 1000 outstanding amount
    When Admin sets the business date to "20221102"
    And Customer makes "AUTOPAY" repayment on "20221102" with 9 EUR transaction amount
    Then Loan Transactions tab has a transaction with date: "20221102", and with the following data:
      | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | Repayment        | 9.0    | 9.0       | 0.0      | 0.0  | 0.0       | 991.0        |
    When Customer adjust "1"th repayment on "20221102" with amount "10"
    Then Loan Transactions tab has a transaction with date: "20221102", and with the following data:
      | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | Repayment        | 9.0    | 9.0       | 0.0      | 0.0  | 0.0       | 991.0        |
      | Repayment        | 10.0   | 0.0       | 0.0      | 0.0  | 0.0       | 990.0        |

  @TestRailId:C2898
  Scenario: Verify that in case of non/disbursed loan LoanRepaymentDueBusinessEvent is not sent - LP1 product
    When Admin sets the business date to "20231001"
    When Admin creates a client with random data
    When Admin creates a new default Loan with date: "20231001"
    And Admin successfully approves the loan on "20231001" with "1000" amount and expected disbursement date on "20231001"
    Then Loan Repayment schedule has 1 periods, with the following data for periods:
      | Nr | Days | Date            | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      |    |      | 20231001 |           | 1000.0          |               |          | 0.0  |           | 0.0    |      |            |      | 0.0         |
      | 1  | 30   | 20231031 |           | 0.0             | 1000.0        | 0.0      | 0.0  | 0.0       | 1000.0 | 0.0  | 0.0        | 0.0  | 1000.0      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due  | Paid | In advance | Late | Outstanding |
      | 1000          | 0        | 0    | 0         | 1000 | 0    | 0          | 0    | 1000        |
    When Admin sets the business date to "20231031"
    When Admin runs inline COB job for Loan
    Then No new event with type "LoanRepaymentDueEvent" has been raised for the loan
    Then No new event with type "LoanRepaymentOverdueEvent" has been raised for the loan

  @TestRailId:C2899
  Scenario: Verify that in case of non/disbursed loan LoanRepaymentDueBusinessEvent is not sent - LP2 auto payment enabled
    When Admin sets the business date to "20231001"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct          | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy                                                             |
      | LP2_DOWNPAYMENT_AUTO | 20231001   | 1000           | 0                      | DECLINING_BALANCE | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 45                | DAYS                  | 15             | DAYS                   | 3                  | 0                       | 0                      | 0                    | DUE_PENALTY_INTEREST_PRINCIPAL_FEE_IN_ADVANCE_PENALTY_INTEREST_PRINCIPAL_FEE |
    And Admin successfully approves the loan on "20231001" with "1000" amount and expected disbursement date on "20231001"
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20231001  |           | 1000.0          |               |          | 0.0  |           | 0.0   |      |            |      | 0.0         |
      | 1  | 0    | 20231001  |           | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0  | 0.0        | 0.0  | 250.0       |
      | 2  | 15   | 20231016  |           | 500.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0  | 0.0        | 0.0  | 250.0       |
      | 3  | 15   | 20231031  |           | 250.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0  | 0.0        | 0.0  | 250.0       |
      | 4  | 15   | 20231115 |           | 0.0             | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0  | 0.0        | 0.0  | 250.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 1000.0        | 0        | 0    | 0         | 1000.0 | 0.0  | 0          | 0    | 1000        |
    When Admin sets the business date to "20231016"
    When Admin runs inline COB job for Loan
    Then No new event with type "LoanRepaymentDueEvent" has been raised for the loan
    Then No new event with type "LoanRepaymentOverdueEvent" has been raised for the loan

  @TestRailId:C2900
  Scenario: Verify that in case of non/disbursed loan LoanRepaymentDueBusinessEvent is not sent - LP2 auto payment disabled
    When Admin sets the business date to "20231001"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct     | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy                                                             |
      | LP2_DOWNPAYMENT | 20231001   | 1000           | 0                      | DECLINING_BALANCE | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 45                | DAYS                  | 15             | DAYS                   | 3                  | 0                       | 0                      | 0                    | DUE_PENALTY_INTEREST_PRINCIPAL_FEE_IN_ADVANCE_PENALTY_INTEREST_PRINCIPAL_FEE |
    And Admin successfully approves the loan on "20231001" with "1000" amount and expected disbursement date on "20231001"
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20231001  |           | 1000.0          |               |          | 0.0  |           | 0.0   |      |            |      | 0.0         |
      | 1  | 0    | 20231001  |           | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0  | 0.0        | 0.0  | 250.0       |
      | 2  | 15   | 20231016  |           | 500.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0  | 0.0        | 0.0  | 250.0       |
      | 3  | 15   | 20231031  |           | 250.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0  | 0.0        | 0.0  | 250.0       |
      | 4  | 15   | 20231115 |           | 0.0             | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0  | 0.0        | 0.0  | 250.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 1000.0        | 0        | 0    | 0         | 1000.0 | 0.0  | 0          | 0    | 1000        |
    When Admin sets the business date to "20231016"
    When Admin runs inline COB job for Loan
    Then No new event with type "LoanRepaymentDueEvent" has been raised for the loan
    Then No new event with type "LoanRepaymentOverdueEvent" has been raised for the loan

  @TestRailId:C2901 @AdvancedPaymentAllocation
  Scenario: Verify that in case of non/disbursed loan LoanRepaymentDueBusinessEvent is not sent - LP2 advanced payment allocation product
    When Admin sets the business date to "20231001"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                      | submitted on date | with Principal | ANNUAL interest rate % | interest type | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_DOWNPAYMENT_AUTO_ADVANCED_PAYMENT_ALLOCATION | 20231001   | 1000           | 0                      | FLAT          | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 45                | DAYS                  | 15             | DAYS                   | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20231001" with "1000" amount and expected disbursement date on "20231001"
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20231001  |           | 1000.0          |               |          | 0.0  |           | 0.0   |      |            |      | 0.0         |
      | 1  | 0    | 20231001  |           | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0  | 0.0        | 0.0  | 250.0       |
      | 2  | 15   | 20231016  |           | 500.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0  | 0.0        | 0.0  | 250.0       |
      | 3  | 15   | 20231031  |           | 250.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0  | 0.0        | 0.0  | 250.0       |
      | 4  | 15   | 20231115 |           | 0.0             | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0  | 0.0        | 0.0  | 250.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 1000.0        | 0        | 0    | 0         | 1000.0 | 0.0  | 0          | 0    | 1000        |
    When Admin sets the business date to "20231016"
    When Admin runs inline COB job for Loan
    Then No new event with type "LoanRepaymentDueEvent" has been raised for the loan
    Then No new event with type "LoanRepaymentOverdueEvent" has been raised for the loan

  @TestRailId:C2902
  Scenario: Verify that in case of pre-payed installment LoanRepaymentDueBusinessEvent is not sent - LP1 product
    When Admin sets the business date to "20231001"
    When Admin creates a client with random data
    When Admin creates a new default Loan with date: "20231001"
    And Admin successfully approves the loan on "20231001" with "1000" amount and expected disbursement date on "20231001"
    When Admin successfully disburse the loan on "20231001" with "1000" EUR transaction amount
    When Customer makes "REPAYMENT" transaction with "AUTOPAY" payment type on "20231001" with 1000 EUR transaction amount and system-generated Idempotency key
    Then Loan Repayment schedule has 1 periods, with the following data for periods:
      | Nr | Days | Date            | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late | Outstanding |
      |    |      | 20231001 |                 | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0    |            |      |             |
      | 1  | 30   | 20231031 | 20231001 | 0.0             | 1000.0        | 0.0      | 0.0  | 0.0       | 1000.0 | 1000.0 | 1000.0     | 0.0  | 0.0         |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due  | Paid | In advance | Late | Outstanding |
      | 1000          | 0        | 0    | 0         | 1000 | 1000 | 1000       | 0    | 0           |
    Then Loan status will be "CLOSED_OBLIGATIONS_MET"
    Then Loan has 0 outstanding amount
    When Admin sets the business date to "20231031"
    When Admin runs inline COB job for Loan
    Then No new event with type "LoanRepaymentDueEvent" has been raised for the loan
    Then No new event with type "LoanRepaymentOverdueEvent" has been raised for the loan

  @TestRailId:C2903
  Scenario: Verify that in case of pre-payed installment LoanRepaymentDueBusinessEvent is not sent - LP2 auto payment enabled
    When Admin sets the business date to "20231001"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct          | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy                                                             |
      | LP2_DOWNPAYMENT_AUTO | 20231001   | 1000           | 0                      | DECLINING_BALANCE | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 45                | DAYS                  | 15             | DAYS                   | 3                  | 0                       | 0                      | 0                    | DUE_PENALTY_INTEREST_PRINCIPAL_FEE_IN_ADVANCE_PENALTY_INTEREST_PRINCIPAL_FEE |
    And Admin successfully approves the loan on "20231001" with "1000" amount and expected disbursement date on "20231001"
    When Admin successfully disburse the loan on "20231001" with "1000" EUR transaction amount
    When Customer makes "REPAYMENT" transaction with "AUTOPAY" payment type on "20231001" with 250 EUR transaction amount and system-generated Idempotency key
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20231001  |                 | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 0    | 20231001  | 20231001 | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0  | 0.0         |
      | 2  | 15   | 20231016  | 20231001 | 500.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 250.0      | 0.0  | 0.0         |
      | 3  | 15   | 20231031  |                 | 250.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0   | 0.0        | 0.0  | 250.0       |
      | 4  | 15   | 20231115 |                 | 0.0             | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0   | 0.0        | 0.0  | 250.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 1000.0        | 0        | 0    | 0         | 1000.0 | 500.0 | 250        | 0    | 500         |
    When Admin sets the business date to "20231016"
    When Admin runs inline COB job for Loan
    Then No new event with type "LoanRepaymentDueEvent" has been raised for the loan
    Then No new event with type "LoanRepaymentOverdueEvent" has been raised for the loan

  @TestRailId:C2904
  Scenario: Verify that in case of pre-payed installment LoanRepaymentDueBusinessEvent is not sent - LP2 auto payment disabled
    When Admin sets the business date to "20231001"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct     | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy                                                             |
      | LP2_DOWNPAYMENT | 20231001   | 1000           | 0                      | DECLINING_BALANCE | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 45                | DAYS                  | 15             | DAYS                   | 3                  | 0                       | 0                      | 0                    | DUE_PENALTY_INTEREST_PRINCIPAL_FEE_IN_ADVANCE_PENALTY_INTEREST_PRINCIPAL_FEE |
    And Admin successfully approves the loan on "20231001" with "1000" amount and expected disbursement date on "20231001"
    When Admin successfully disburse the loan on "20231001" with "1000" EUR transaction amount
    When Customer makes "REPAYMENT" transaction with "AUTOPAY" payment type on "20231001" with 500 EUR transaction amount and system-generated Idempotency key
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20231001  |                 | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 0    | 20231001  | 20231001 | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0  | 0.0         |
      | 2  | 15   | 20231016  | 20231001 | 500.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 250.0      | 0.0  | 0.0         |
      | 3  | 15   | 20231031  |                 | 250.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0   | 0.0        | 0.0  | 250.0       |
      | 4  | 15   | 20231115 |                 | 0.0             | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0   | 0.0        | 0.0  | 250.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 1000.0        | 0        | 0    | 0         | 1000.0 | 500.0 | 250        | 0    | 500         |
    When Admin sets the business date to "20231016"
    When Admin runs inline COB job for Loan
    Then No new event with type "LoanRepaymentDueEvent" has been raised for the loan
    Then No new event with type "LoanRepaymentOverdueEvent" has been raised for the loan

  @TestRailId:C2905 @AdvancedPaymentAllocation
  Scenario: Verify that in case of pre-payed installment LoanRepaymentDueBusinessEvent is not sent - LP2 advanced payment allocation product
    When Admin sets the business date to "20231001"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                      | submitted on date | with Principal | ANNUAL interest rate % | interest type | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_DOWNPAYMENT_AUTO_ADVANCED_PAYMENT_ALLOCATION | 20231001   | 1000           | 0                      | FLAT          | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 45                | DAYS                  | 15             | DAYS                   | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20231001" with "1000" amount and expected disbursement date on "20231001"
    When Admin successfully disburse the loan on "20231001" with "1000" EUR transaction amount
    When Customer makes "REPAYMENT" transaction with "AUTOPAY" payment type on "20231001" with 250 EUR transaction amount and system-generated Idempotency key
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20231001  |                 | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 0    | 20231001  | 20231001 | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0  | 0.0         |
      | 2  | 15   | 20231016  | 20231001 | 500.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 250.0      | 0.0  | 0.0         |
      | 3  | 15   | 20231031  |                 | 250.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0   | 0.0        | 0.0  | 250.0       |
      | 4  | 15   | 20231115 |                 | 0.0             | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0   | 0.0        | 0.0  | 250.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 1000.0        | 0        | 0    | 0         | 1000.0 | 500.0 | 250        | 0    | 500         |
    When Admin sets the business date to "20231016"
    When Admin runs inline COB job for Loan
    Then No new event with type "LoanRepaymentDueEvent" has been raised for the loan
    Then No new event with type "LoanRepaymentOverdueEvent" has been raised for the loan

  @TestRailId:C2906
  Scenario: Verify that in case of pre-payed installments for total amount (loan balance is 0) LoanRepaymentDueBusinessEvent is not sent - LP2 auto payment enabled
    When Admin sets the business date to "20231001"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct          | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy                                                             |
      | LP2_DOWNPAYMENT_AUTO | 20231001   | 1000           | 0                      | DECLINING_BALANCE | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 45                | DAYS                  | 15             | DAYS                   | 3                  | 0                       | 0                      | 0                    | DUE_PENALTY_INTEREST_PRINCIPAL_FEE_IN_ADVANCE_PENALTY_INTEREST_PRINCIPAL_FEE |
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

  @TestRailId:C2907
  Scenario: Verify that in case of pre-payed installments for total amount (loan balance is 0) LoanRepaymentDueBusinessEvent is not sent - LP2 auto payment disabled
    When Admin sets the business date to "20231001"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct     | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy                                                             |
      | LP2_DOWNPAYMENT | 20231001   | 1000           | 0                      | DECLINING_BALANCE | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 45                | DAYS                  | 15             | DAYS                   | 3                  | 0                       | 0                      | 0                    | DUE_PENALTY_INTEREST_PRINCIPAL_FEE_IN_ADVANCE_PENALTY_INTEREST_PRINCIPAL_FEE |
    And Admin successfully approves the loan on "20231001" with "1000" amount and expected disbursement date on "20231001"
    When Admin successfully disburse the loan on "20231001" with "1000" EUR transaction amount
    When Customer makes "REPAYMENT" transaction with "AUTOPAY" payment type on "20231001" with 1000 EUR transaction amount and system-generated Idempotency key
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

