@Emi
Feature: EMI calculation and repayment schedule checks for interest bearing loans - Part1

  @TestRailId:C3152
  Scenario: EMI calculation with Actual/Actual setup - integer
    When Admin sets the business date to "20231212"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                    | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_EMI_ACTUAL_ACTUAL | 20231212  | 10000          | 12                     | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 6                 | MONTHS                | 1              | MONTHS                 | 6                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20231212" with "10000" amount and expected disbursement date on "20231212"
    When Admin successfully disburse the loan on "20231212" with "10000" EUR transaction amount
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due     | Paid | In advance | Late | Outstanding |
      |    |      | 20231212 |           | 10000.0         |               |          | 0.0  |           | 0.0     | 0.0  |            |      |             |
      | 1  | 31   | 20240112  |           | 8376.25         | 1623.75       | 101.81   | 0.0  | 0.0       | 1725.56 | 0.0  | 0.0        | 0.0  | 1725.56     |
      | 2  | 31   | 20240212 |           | 6735.83         | 1640.42       | 85.14    | 0.0  | 0.0       | 1725.56 | 0.0  | 0.0        | 0.0  | 1725.56     |
      | 3  | 29   | 20240312    |           | 5074.32         | 1661.51       | 64.05    | 0.0  | 0.0       | 1725.56 | 0.0  | 0.0        | 0.0  | 1725.56     |
      | 4  | 31   | 20240412    |           | 3400.34         | 1673.98       | 51.58    | 0.0  | 0.0       | 1725.56 | 0.0  | 0.0        | 0.0  | 1725.56     |
      | 5  | 30   | 20240512      |           | 1708.23         | 1692.11       | 33.45    | 0.0  | 0.0       | 1725.56 | 0.0  | 0.0        | 0.0  | 1725.56     |
      | 6  | 31   | 20240612     |           | 0.0             | 1708.23       | 17.36    | 0.0  | 0.0       | 1725.59 | 0.0  | 0.0        | 0.0  | 1725.59     |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due      | Paid | In advance | Late | Outstanding |
      | 10000.0       | 353.39   | 0.0  | 0.0       | 10353.39 | 0.0  | 0.0        | 0.0  | 10353.39    |

  @TestRailId:C3153
  Scenario: EMI calculation with Actual/Actual setup - decimal
    When Admin sets the business date to "20231212"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                    | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_EMI_ACTUAL_ACTUAL | 20231212  | 10000          | 9.4822                 | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 6                 | MONTHS                | 1              | MONTHS                 | 6                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20231212" with "10000" amount and expected disbursement date on "20231212"
    When Admin successfully disburse the loan on "20231212" with "10000" EUR transaction amount
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due     | Paid | In advance | Late | Outstanding |
      |    |      | 20231212 |           | 10000.0         |               |          | 0.0  |           | 0.0     | 0.0  |            |      |             |
      | 1  | 31   | 20240112  |           | 8367.33         | 1632.67       | 80.45    | 0.0  | 0.0       | 1713.12 | 0.0  | 0.0        | 0.0  | 1713.12     |
      | 2  | 31   | 20240212 |           | 6721.41         | 1645.92       | 67.2     | 0.0  | 0.0       | 1713.12 | 0.0  | 0.0        | 0.0  | 1713.12     |
      | 3  | 29   | 20240312    |           | 5058.79         | 1662.62       | 50.5     | 0.0  | 0.0       | 1713.12 | 0.0  | 0.0        | 0.0  | 1713.12     |
      | 4  | 31   | 20240412    |           | 3386.3          | 1672.49       | 40.63    | 0.0  | 0.0       | 1713.12 | 0.0  | 0.0        | 0.0  | 1713.12     |
      | 5  | 30   | 20240512      |           | 1699.5          | 1686.8        | 26.32    | 0.0  | 0.0       | 1713.12 | 0.0  | 0.0        | 0.0  | 1713.12     |
      | 6  | 31   | 20240612     |           | 0.0             | 1699.5        | 13.65    | 0.0  | 0.0       | 1713.15 | 0.0  | 0.0        | 0.0  | 1713.15     |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due      | Paid | In advance | Late | Outstanding |
      | 10000.0       | 278.75   | 0.0  | 0.0       | 10278.75 | 0.0  | 0.0        | 0.0  | 10278.75    |

  @TestRailId:C3164 @ActualActualIterate @iterate
  Scenario: EMI calculation with Actual/Actual setup - decimal - iterate
    When Admin sets the business date to "20231212"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                    | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_EMI_ACTUAL_ACTUAL | 20231212  | 331.77         | 10.65                  | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 5                 | MONTHS                | 1              | MONTHS                 | 5                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20231212" with "331.77" amount and expected disbursement date on "20231212"
    When Admin successfully disburse the loan on "20231212" with "331.77" EUR transaction amount
    Then Loan Repayment schedule has 5 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20231212 |           | 331.77          |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 31   | 20240112  |           | 266.63          | 65.14         | 3.0      | 0.0  | 0.0       | 68.14 | 0.0  | 0.0        | 0.0  | 68.14       |
      | 2  | 31   | 20240212 |           | 200.9           | 65.73         | 2.41     | 0.0  | 0.0       | 68.14 | 0.0  | 0.0        | 0.0  | 68.14       |
      | 3  | 29   | 20240312    |           | 134.46          | 66.44         | 1.7      | 0.0  | 0.0       | 68.14 | 0.0  | 0.0        | 0.0  | 68.14       |
      | 4  | 31   | 20240412    |           | 67.53           | 66.93         | 1.21     | 0.0  | 0.0       | 68.14 | 0.0  | 0.0        | 0.0  | 68.14       |
      | 5  | 30   | 20240512      |           | 0.0             | 67.53         | 0.59     | 0.0  | 0.0       | 68.12 | 0.0  | 0.0        | 0.0  | 68.12       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 331.77        | 8.91     | 0.0  | 0.0       | 340.68 | 0.0  | 0.0        | 0.0  | 340.68      |

  @TestRailId:C3154
  Scenario: EMI calculation with 360/30 setup - integer
    When Admin sets the business date to "20240101"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                             | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_EMI_360_30 | 20240101    | 100            | 12                     | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 6                 | MONTHS                | 1              | MONTHS                 | 6                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240101" with "100" amount and expected disbursement date on "20240101"
    When Admin successfully disburse the loan on "20240101" with "100" EUR transaction amount
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20240101  |           | 100.0           |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 31   | 20240201 |           | 83.75           | 16.25         | 1.0      | 0.0  | 0.0       | 17.25 | 0.0  | 0.0        | 0.0  | 17.25       |
      | 2  | 29   | 20240301    |           | 67.34           | 16.41         | 0.84     | 0.0  | 0.0       | 17.25 | 0.0  | 0.0        | 0.0  | 17.25       |
      | 3  | 31   | 20240401    |           | 50.76           | 16.58         | 0.67     | 0.0  | 0.0       | 17.25 | 0.0  | 0.0        | 0.0  | 17.25       |
      | 4  | 30   | 20240501      |           | 34.02           | 16.74         | 0.51     | 0.0  | 0.0       | 17.25 | 0.0  | 0.0        | 0.0  | 17.25       |
      | 5  | 31   | 20240601     |           | 17.11           | 16.91         | 0.34     | 0.0  | 0.0       | 17.25 | 0.0  | 0.0        | 0.0  | 17.25       |
      | 6  | 30   | 20240701     |           | 0.0             | 17.11         | 0.17     | 0.0  | 0.0       | 17.28 | 0.0  | 0.0        | 0.0  | 17.28       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 100.0         | 3.53     | 0.0  | 0.0       | 103.53 | 0.0  | 0.0        | 0.0  | 103.53      |

  @TestRailId:C3155
  Scenario: EMI calculation with 360/30 setup - decimal
    When Admin sets the business date to "20240101"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                             | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_EMI_360_30 | 20240101    | 100            | 9.4822                 | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 6                 | MONTHS                | 1              | MONTHS                 | 6                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240101" with "100" amount and expected disbursement date on "20240101"
    When Admin successfully disburse the loan on "20240101" with "100" EUR transaction amount
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20240101  |           | 100.0           |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 31   | 20240201 |           | 83.66           | 16.34         | 0.79     | 0.0  | 0.0       | 17.13 | 0.0  | 0.0        | 0.0  | 17.13       |
      | 2  | 29   | 20240301    |           | 67.19           | 16.47         | 0.66     | 0.0  | 0.0       | 17.13 | 0.0  | 0.0        | 0.0  | 17.13       |
      | 3  | 31   | 20240401    |           | 50.59           | 16.6          | 0.53     | 0.0  | 0.0       | 17.13 | 0.0  | 0.0        | 0.0  | 17.13       |
      | 4  | 30   | 20240501      |           | 33.86           | 16.73         | 0.4      | 0.0  | 0.0       | 17.13 | 0.0  | 0.0        | 0.0  | 17.13       |
      | 5  | 31   | 20240601     |           | 17.0            | 16.86         | 0.27     | 0.0  | 0.0       | 17.13 | 0.0  | 0.0        | 0.0  | 17.13       |
      | 6  | 30   | 20240701     |           | 0.0             | 17.0          | 0.13     | 0.0  | 0.0       | 17.13 | 0.0  | 0.0        | 0.0  | 17.13       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 100.0         | 2.78     | 0.0  | 0.0       | 102.78 | 0.0  | 0.0        | 0.0  | 102.78      |

  @TestRailId:C3165 @36030Iterate @iterate
  Scenario: EMI calculation with 360/30 setup - decimal - iterate
    When Admin sets the business date to "20240101"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                             | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_EMI_360_30 | 20240101    | 75             | 12.3                   | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 5                 | MONTHS                | 1              | MONTHS                 | 5                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240101" with "75" amount and expected disbursement date on "20240101"
    When Admin successfully disburse the loan on "20240101" with "75" EUR transaction amount
    Then Loan Repayment schedule has 5 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20240101  |           | 75.0            |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 31   | 20240201 |           | 60.3            | 14.7          | 0.77     | 0.0  | 0.0       | 15.47 | 0.0  | 0.0        | 0.0  | 15.47       |
      | 2  | 29   | 20240301    |           | 45.45           | 14.85         | 0.62     | 0.0  | 0.0       | 15.47 | 0.0  | 0.0        | 0.0  | 15.47       |
      | 3  | 31   | 20240401    |           | 30.45           | 15.0          | 0.47     | 0.0  | 0.0       | 15.47 | 0.0  | 0.0        | 0.0  | 15.47       |
      | 4  | 30   | 20240501      |           | 15.29           | 15.16         | 0.31     | 0.0  | 0.0       | 15.47 | 0.0  | 0.0        | 0.0  | 15.47       |
      | 5  | 31   | 20240601     |           | 0.0             | 15.29         | 0.16     | 0.0  | 0.0       | 15.45 | 0.0  | 0.0        | 0.0  | 15.45       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      | 75.0          | 2.33     | 0.0  | 0.0       | 77.33 | 0.0  | 0.0        | 0.0  | 77.33       |

  @TestRailId:C3156
  Scenario: EMI calculation with 360/30 setup - decimal - reschedule
    When Admin sets the business date to "20240101"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                             | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_EMI_360_30 | 20240101    | 100            | 9.4822                 | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 6                 | MONTHS                | 1              | MONTHS                 | 6                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240101" with "100" amount and expected disbursement date on "20240101"
    When Admin successfully disburse the loan on "20240101" with "100" EUR transaction amount
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20240101  |           | 100.0           |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 31   | 20240201 |           | 83.66           | 16.34         | 0.79     | 0.0  | 0.0       | 17.13 | 0.0  | 0.0        | 0.0  | 17.13       |
      | 2  | 29   | 20240301    |           | 67.19           | 16.47         | 0.66     | 0.0  | 0.0       | 17.13 | 0.0  | 0.0        | 0.0  | 17.13       |
      | 3  | 31   | 20240401    |           | 50.59           | 16.6          | 0.53     | 0.0  | 0.0       | 17.13 | 0.0  | 0.0        | 0.0  | 17.13       |
      | 4  | 30   | 20240501      |           | 33.86           | 16.73         | 0.4      | 0.0  | 0.0       | 17.13 | 0.0  | 0.0        | 0.0  | 17.13       |
      | 5  | 31   | 20240601     |           | 17.0            | 16.86         | 0.27     | 0.0  | 0.0       | 17.13 | 0.0  | 0.0        | 0.0  | 17.13       |
      | 6  | 30   | 20240701     |           | 0.0             | 17.0          | 0.13     | 0.0  | 0.0       | 17.13 | 0.0  | 0.0        | 0.0  | 17.13       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 100.0         | 2.78     | 0.0  | 0.0       | 102.78 | 0.0  | 0.0        | 0.0  | 102.78      |
    When Admin sets the business date to "20240218"
    When Admin creates and approves Loan reschedule with the following data:
      | rescheduleFromDate | submittedOnDate  | adjustedDueDate  | graceOnPrincipal | graceOnInterest | extraTerms | newInterestRate |
      | 20240201   | 20240218 | 20240218 |                  |                 |            |                 |
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20240101  |           | 100.0           |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 48   | 20240218 |           | 84.12           | 15.88         | 1.25     | 0.0  | 0.0       | 17.13 | 0.0  | 0.0        | 0.0  | 17.13       |
      | 2  | 29   | 20240318    |           | 67.65           | 16.47         | 0.66     | 0.0  | 0.0       | 17.13 | 0.0  | 0.0        | 0.0  | 17.13       |
      | 3  | 31   | 20240418    |           | 51.05           | 16.6          | 0.53     | 0.0  | 0.0       | 17.13 | 0.0  | 0.0        | 0.0  | 17.13       |
      | 4  | 30   | 20240518      |           | 34.32           | 16.73         | 0.4      | 0.0  | 0.0       | 17.13 | 0.0  | 0.0        | 0.0  | 17.13       |
      | 5  | 31   | 20240618     |           | 17.46           | 16.86         | 0.27     | 0.0  | 0.0       | 17.13 | 0.0  | 0.0        | 0.0  | 17.13       |
      | 6  | 30   | 20240718     |           | 0.0             | 17.46         | 0.14     | 0.0  | 0.0       | 17.6  | 0.0  | 0.0        | 0.0  | 17.6        |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 100.0         | 3.25     | 0.0  | 0.0       | 103.25 | 0.0  | 0.0        | 0.0  | 103.25      |

  @TestRailId:C3157
  Scenario: EMI calculation with 360/30 setup - integer - repayment every 2 months
    When Admin sets the business date to "20240101"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                             | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_EMI_360_30 | 20240101    | 100            | 12                     | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 6                 | MONTHS                | 2              | MONTHS                 | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240101" with "100" amount and expected disbursement date on "20240101"
    When Admin successfully disburse the loan on "20240101" with "100" EUR transaction amount
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date            | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20240101 |           | 100.0           |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 60   | 20240301   |           | 67.32           | 32.68         | 2.0      | 0.0  | 0.0       | 34.68 | 0.0  | 0.0        | 0.0  | 34.68       |
      | 2  | 61   | 20240501     |           | 33.99           | 33.33         | 1.35     | 0.0  | 0.0       | 34.68 | 0.0  | 0.0        | 0.0  | 34.68       |
      | 3  | 61   | 20240701    |           | 0.0             | 33.99         | 0.68     | 0.0  | 0.0       | 34.67 | 0.0  | 0.0        | 0.0  | 34.67       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 100.0         | 4.03     | 0.0  | 0.0       | 104.03 | 0.0  | 0.0        | 0.0  | 104.03      |

  @TestRailId:C3158
  Scenario: EMI calculation with 360/30 setup - decimal - repayment every 2 weeks
    When Admin sets the business date to "20240101"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                             | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_EMI_360_30 | 20240101    | 100            | 9.4822                 | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 12                | WEEKS                 | 2              | WEEKS                  | 6                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240101" with "100" amount and expected disbursement date on "20240101"
    When Admin successfully disburse the loan on "20240101" with "100" EUR transaction amount
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20240101  |           | 100.0           |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 14   | 20240115  |           | 83.49           | 16.51         | 0.37     | 0.0  | 0.0       | 16.88 | 0.0  | 0.0        | 0.0  | 16.88       |
      | 2  | 14   | 20240129  |           | 66.92           | 16.57         | 0.31     | 0.0  | 0.0       | 16.88 | 0.0  | 0.0        | 0.0  | 16.88       |
      | 3  | 14   | 20240212 |           | 50.29           | 16.63         | 0.25     | 0.0  | 0.0       | 16.88 | 0.0  | 0.0        | 0.0  | 16.88       |
      | 4  | 14   | 20240226 |           | 33.6            | 16.69         | 0.19     | 0.0  | 0.0       | 16.88 | 0.0  | 0.0        | 0.0  | 16.88       |
      | 5  | 14   | 20240311    |           | 16.84           | 16.76         | 0.12     | 0.0  | 0.0       | 16.88 | 0.0  | 0.0        | 0.0  | 16.88       |
      | 6  | 14   | 20240325    |           | 0.0             | 16.84         | 0.06     | 0.0  | 0.0       | 16.9  | 0.0  | 0.0        | 0.0  | 16.9        |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      | 100.0         | 1.3      | 0.0  | 0.0       | 101.3 | 0.0  | 0.0        | 0.0  | 101.3       |

  @TestRailId:C3159
  Scenario: EMI calculation with 365/Actual setup - integer
    When Admin sets the business date to "20240101"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                 | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_EMI_365_ACTUAL | 20240101    | 100            | 12                     | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 6                 | MONTHS                | 1              | MONTHS                 | 6                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240101" with "100" amount and expected disbursement date on "20240101"
    When Admin successfully disburse the loan on "20240101" with "100" EUR transaction amount
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20240101  |           | 100.0           |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 31   | 20240201 |           | 83.77           | 16.23         | 1.02     | 0.0  | 0.0       | 17.25 | 0.0  | 0.0        | 0.0  | 17.25       |
      | 2  | 29   | 20240301    |           | 67.32           | 16.45         | 0.8      | 0.0  | 0.0       | 17.25 | 0.0  | 0.0        | 0.0  | 17.25       |
      | 3  | 31   | 20240401    |           | 50.76           | 16.56         | 0.69     | 0.0  | 0.0       | 17.25 | 0.0  | 0.0        | 0.0  | 17.25       |
      | 4  | 30   | 20240501      |           | 34.01           | 16.75         | 0.5      | 0.0  | 0.0       | 17.25 | 0.0  | 0.0        | 0.0  | 17.25       |
      | 5  | 31   | 20240601     |           | 17.11           | 16.9          | 0.35     | 0.0  | 0.0       | 17.25 | 0.0  | 0.0        | 0.0  | 17.25       |
      | 6  | 30   | 20240701     |           | 0.0             | 17.11         | 0.17     | 0.0  | 0.0       | 17.28 | 0.0  | 0.0        | 0.0  | 17.28       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 100.0         | 3.53     | 0.0  | 0.0       | 103.53 | 0.0  | 0.0        | 0.0  | 103.53      |

  @TestRailId:C3160
  Scenario: EMI calculation with 365/Actual setup - decimal
    When Admin sets the business date to "20240101"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                 | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_EMI_365_ACTUAL | 20240101    | 100            | 9.4822                 | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 6                 | MONTHS                | 1              | MONTHS                 | 6                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240101" with "100" amount and expected disbursement date on "20240101"
    When Admin successfully disburse the loan on "20240101" with "100" EUR transaction amount
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20240101  |           | 100.0           |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 31   | 20240201 |           | 83.68           | 16.32         | 0.81     | 0.0  | 0.0       | 17.13 | 0.0  | 0.0        | 0.0  | 17.13       |
      | 2  | 29   | 20240301    |           | 67.18           | 16.5          | 0.63     | 0.0  | 0.0       | 17.13 | 0.0  | 0.0        | 0.0  | 17.13       |
      | 3  | 31   | 20240401    |           | 50.59           | 16.59         | 0.54     | 0.0  | 0.0       | 17.13 | 0.0  | 0.0        | 0.0  | 17.13       |
      | 4  | 30   | 20240501      |           | 33.85           | 16.74         | 0.39     | 0.0  | 0.0       | 17.13 | 0.0  | 0.0        | 0.0  | 17.13       |
      | 5  | 31   | 20240601     |           | 16.99           | 16.86         | 0.27     | 0.0  | 0.0       | 17.13 | 0.0  | 0.0        | 0.0  | 17.13       |
      | 6  | 30   | 20240701     |           | 0.0             | 16.99         | 0.13     | 0.0  | 0.0       | 17.12 | 0.0  | 0.0        | 0.0  | 17.12       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 100.0         | 2.77     | 0.0  | 0.0       | 102.77 | 0.0  | 0.0        | 0.0  | 102.77      |

  @TestRailId:C3161
  Scenario: EMI calculation with 360/30 setup - integer - downpayment
    When Admin sets the business date to "20240101"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                         | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_EMI_360_30_DOWNPAYMENT | 20240101    | 100            | 5                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 5                 | MONTHS                | 1              | MONTHS                 | 5                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240101" with "100" amount and expected disbursement date on "20240101"
    When Admin successfully disburse the loan on "20240101" with "100" EUR transaction amount
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20240101  |           | 100.0           |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 0    | 20240101  |           | 75.0            | 25.0          | 0.0      | 0.0  | 0.0       | 25.0  | 0.0  | 0.0        | 0.0  | 25.0        |
      | 2  | 31   | 20240201 |           | 60.12           | 14.88         | 0.31     | 0.0  | 0.0       | 15.19 | 0.0  | 0.0        | 0.0  | 15.19       |
      | 3  | 29   | 20240301    |           | 45.18           | 14.94         | 0.25     | 0.0  | 0.0       | 15.19 | 0.0  | 0.0        | 0.0  | 15.19       |
      | 4  | 31   | 20240401    |           | 30.18           | 15.0          | 0.19     | 0.0  | 0.0       | 15.19 | 0.0  | 0.0        | 0.0  | 15.19       |
      | 5  | 30   | 20240501      |           | 15.12           | 15.06         | 0.13     | 0.0  | 0.0       | 15.19 | 0.0  | 0.0        | 0.0  | 15.19       |
      | 6  | 31   | 20240601     |           | 0.0             | 15.12         | 0.06     | 0.0  | 0.0       | 15.18 | 0.0  | 0.0        | 0.0  | 15.18       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 100.0         | 0.94     | 0.0  | 0.0       | 100.94 | 0.0  | 0.0        | 0.0  | 100.94      |

  @TestRailId:C3166 @iterate
  Scenario: EMI calculation with 365/Actual setup - decimal - iterate - repayment every 15 days
    When Admin sets the business date to "20240101"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                 | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_EMI_365_ACTUAL | 20240101    | 100            | 9.4822                 | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 90                | DAYS                  | 15             | DAYS                   | 6                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240101" with "100" amount and expected disbursement date on "20240101"
    When Admin successfully disburse the loan on "20240101" with "100" EUR transaction amount
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20240101  |           | 100.0           |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 15   | 20240116  |           | 83.49           | 16.51         | 0.39     | 0.0  | 0.0       | 16.9  | 0.0  | 0.0        | 0.0  | 16.9        |
      | 2  | 15   | 20240131  |           | 66.92           | 16.57         | 0.33     | 0.0  | 0.0       | 16.9  | 0.0  | 0.0        | 0.0  | 16.9        |
      | 3  | 15   | 20240215 |           | 50.28           | 16.64         | 0.26     | 0.0  | 0.0       | 16.9  | 0.0  | 0.0        | 0.0  | 16.9        |
      | 4  | 15   | 20240301    |           | 33.58           | 16.7          | 0.2      | 0.0  | 0.0       | 16.9  | 0.0  | 0.0        | 0.0  | 16.9        |
      | 5  | 15   | 20240316    |           | 16.81           | 16.77         | 0.13     | 0.0  | 0.0       | 16.9  | 0.0  | 0.0        | 0.0  | 16.9        |
      | 6  | 15   | 20240331    |           | 0.0             | 16.81         | 0.07     | 0.0  | 0.0       | 16.88 | 0.0  | 0.0        | 0.0  | 16.88       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 100.0         | 1.38     | 0.0  | 0.0       | 101.38 | 0.0  | 0.0        | 0.0  | 101.38      |

  @TestRailId:C3167 @365ActualIterate3 @iterate
  Scenario: EMI calculation with 365/Actual setup - decimal - iterate but outcome is false positive, go with original EMI
    When Admin sets the business date to "20240101"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                 | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_EMI_365_ACTUAL | 20240101    | 100            | 15.678                 | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 6                 | MONTHS                | 1              | MONTHS                 | 6                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240101" with "100" amount and expected disbursement date on "20240101"
    When Admin successfully disburse the loan on "20240101" with "100" EUR transaction amount
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20240101  |           | 100.0           |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 31   | 20240201 |           | 83.9            | 16.1          | 1.33     | 0.0  | 0.0       | 17.43 | 0.0  | 0.0        | 0.0  | 17.43       |
      | 2  | 29   | 20240301    |           | 67.52           | 16.38         | 1.05     | 0.0  | 0.0       | 17.43 | 0.0  | 0.0        | 0.0  | 17.43       |
      | 3  | 31   | 20240401    |           | 50.99           | 16.53         | 0.9      | 0.0  | 0.0       | 17.43 | 0.0  | 0.0        | 0.0  | 17.43       |
      | 4  | 30   | 20240501      |           | 34.22           | 16.77         | 0.66     | 0.0  | 0.0       | 17.43 | 0.0  | 0.0        | 0.0  | 17.43       |
      | 5  | 31   | 20240601     |           | 17.25           | 16.97         | 0.46     | 0.0  | 0.0       | 17.43 | 0.0  | 0.0        | 0.0  | 17.43       |
      | 6  | 30   | 20240701     |           | 0.0             | 17.25         | 0.22     | 0.0  | 0.0       | 17.47 | 0.0  | 0.0        | 0.0  | 17.47       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 100.0         | 4.62     | 0.0  | 0.0       | 104.62 | 0.0  | 0.0        | 0.0  | 104.62      |

  @TestRailId:C3194
  Scenario: EMI calculation with 365/30 multidisburse setup - UC1: 2nd disbursement in 1st installment period, no repayment
    When Admin sets the business date to "20240101"
    When Admin creates a client with random data
    When Admin set "LP2_ADV_PYMNT_INTEREST_DAILY_EMI_360_30_MULTIDISBURSE" loan product "DEFAULT" transaction type to "NEXT_INSTALLMENT" future installment allocation rule
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                           | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_EMI_360_30_MULTIDISBURSE | 20240101   | 300            | 9.4822                 | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 6                 | MONTHS                | 1              | MONTHS                 | 6                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240101" with "300" amount and expected disbursement date on "20240101"
    When Admin successfully disburse the loan on "20240101" with "100" EUR transaction amount
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20240101  |           | 100.0           |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 31   | 20240201 |           | 83.66           | 16.34         | 0.79     | 0.0  | 0.0       | 17.13 | 0.0  | 0.0        | 0.0  | 17.13       |
      | 2  | 29   | 20240301    |           | 67.19           | 16.47         | 0.66     | 0.0  | 0.0       | 17.13 | 0.0  | 0.0        | 0.0  | 17.13       |
      | 3  | 31   | 20240401    |           | 50.59           | 16.6          | 0.53     | 0.0  | 0.0       | 17.13 | 0.0  | 0.0        | 0.0  | 17.13       |
      | 4  | 30   | 20240501      |           | 33.86           | 16.73         | 0.4      | 0.0  | 0.0       | 17.13 | 0.0  | 0.0        | 0.0  | 17.13       |
      | 5  | 31   | 20240601     |           | 17.0            | 16.86         | 0.27     | 0.0  | 0.0       | 17.13 | 0.0  | 0.0        | 0.0  | 17.13       |
      | 6  | 30   | 20240701     |           | 0.0             | 17.0          | 0.13     | 0.0  | 0.0       | 17.13 | 0.0  | 0.0        | 0.0  | 17.13       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 100.0         | 2.78     | 0.0  | 0.0       | 102.78 | 0.0  | 0.0        | 0.0  | 102.78      |
    When Admin sets the business date to "20240108"
    When Admin successfully disburse the loan on "20240108" with "200" EUR transaction amount
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20240101  |           | 100.0           |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      |    |      | 20240108  |           | 200.0           |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 31   | 20240201 |           | 250.68          | 49.32         | 2.01     | 0.0  | 0.0       | 51.33 | 0.0  | 0.0        | 0.0  | 51.33       |
      | 2  | 29   | 20240301    |           | 201.33          | 49.35         | 1.98     | 0.0  | 0.0       | 51.33 | 0.0  | 0.0        | 0.0  | 51.33       |
      | 3  | 31   | 20240401    |           | 151.59          | 49.74         | 1.59     | 0.0  | 0.0       | 51.33 | 0.0  | 0.0        | 0.0  | 51.33       |
      | 4  | 30   | 20240501      |           | 101.46          | 50.13         | 1.2      | 0.0  | 0.0       | 51.33 | 0.0  | 0.0        | 0.0  | 51.33       |
      | 5  | 31   | 20240601     |           | 50.93           | 50.53         | 0.8      | 0.0  | 0.0       | 51.33 | 0.0  | 0.0        | 0.0  | 51.33       |
      | 6  | 30   | 20240701     |           | 0.0             | 50.93         | 0.4      | 0.0  | 0.0       | 51.33 | 0.0  | 0.0        | 0.0  | 51.33       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 300.0         | 7.98     | 0.0  | 0.0       | 307.98 | 0.0  | 0.0        | 0.0  | 307.98      |

  @TestRailId:C3195
  Scenario: EMI calculation with 365/30 multidisburse setup - UC2: 1st installment fully repaid early, then 2nd disbursement in 1std installment period, allocation rule: NEXT INSTALLMENT
    When Admin sets the business date to "20240101"
    When Admin creates a client with random data
    When Admin set "LP2_ADV_PYMNT_INTEREST_DAILY_EMI_360_30_MULTIDISBURSE" loan product "DEFAULT" transaction type to "NEXT_INSTALLMENT" future installment allocation rule
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                           | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_EMI_360_30_MULTIDISBURSE | 20240101   | 300            | 9.4822                 | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 6                 | MONTHS                | 1              | MONTHS                 | 6                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240101" with "300" amount and expected disbursement date on "20240101"
    When Admin successfully disburse the loan on "20240101" with "100" EUR transaction amount
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20240101  |           | 100.0           |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 31   | 20240201 |           | 83.66           | 16.34         | 0.79     | 0.0  | 0.0       | 17.13 | 0.0  | 0.0        | 0.0  | 17.13       |
      | 2  | 29   | 20240301    |           | 67.19           | 16.47         | 0.66     | 0.0  | 0.0       | 17.13 | 0.0  | 0.0        | 0.0  | 17.13       |
      | 3  | 31   | 20240401    |           | 50.59           | 16.6          | 0.53     | 0.0  | 0.0       | 17.13 | 0.0  | 0.0        | 0.0  | 17.13       |
      | 4  | 30   | 20240501      |           | 33.86           | 16.73         | 0.4      | 0.0  | 0.0       | 17.13 | 0.0  | 0.0        | 0.0  | 17.13       |
      | 5  | 31   | 20240601     |           | 17.0            | 16.86         | 0.27     | 0.0  | 0.0       | 17.13 | 0.0  | 0.0        | 0.0  | 17.13       |
      | 6  | 30   | 20240701     |           | 0.0             | 17.0          | 0.13     | 0.0  | 0.0       | 17.13 | 0.0  | 0.0        | 0.0  | 17.13       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 100.0         | 2.78     | 0.0  | 0.0       | 102.78 | 0.0  | 0.0        | 0.0  | 102.78      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        |
#    --- Early full repayment of 1st installment ---
    When Admin sets the business date to "20240105"
    And Customer makes "AUTOPAY" repayment on "20240105" with 17.13 EUR transaction amount
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101  |                 | 100.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 31   | 20240201 | 20240105 | 83.66           | 16.34         | 0.79     | 0.0  | 0.0       | 17.13 | 17.13 | 17.13      | 0.0  | 0.0         |
      | 2  | 29   | 20240301    |                 | 67.19           | 16.47         | 0.66     | 0.0  | 0.0       | 17.13 | 0.0   | 0.0        | 0.0  | 17.13       |
      | 3  | 31   | 20240401    |                 | 50.59           | 16.6          | 0.53     | 0.0  | 0.0       | 17.13 | 0.0   | 0.0        | 0.0  | 17.13       |
      | 4  | 30   | 20240501      |                 | 33.86           | 16.73         | 0.4      | 0.0  | 0.0       | 17.13 | 0.0   | 0.0        | 0.0  | 17.13       |
      | 5  | 31   | 20240601     |                 | 17.0            | 16.86         | 0.27     | 0.0  | 0.0       | 17.13 | 0.0   | 0.0        | 0.0  | 17.13       |
      | 6  | 30   | 20240701     |                 | 0.0             | 17.0          | 0.13     | 0.0  | 0.0       | 17.13 | 0.0   | 0.0        | 0.0  | 17.13       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 100.0         | 2.78     | 0.0  | 0.0       | 102.78 | 17.13 | 17.13      | 0.0  | 85.65       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        |
      | 20240105  | Repayment        | 17.13  | 16.34     | 0.79     | 0.0  | 0.0       | 83.66        |
#   --- 2nd disbursement in first period ---
    When Admin sets the business date to "20240108"
    When Admin successfully disburse the loan on "20240108" with "200" EUR transaction amount
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101  |           | 100.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      |    |      | 20240108  |           | 200.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 31   | 20240201 |           | 250.68          | 49.32         | 2.01     | 0.0  | 0.0       | 51.33 | 17.13 | 17.13      | 0.0  | 34.2        |
      | 2  | 29   | 20240301    |           | 201.33          | 49.35         | 1.98     | 0.0  | 0.0       | 51.33 | 0.0   | 0.0        | 0.0  | 51.33       |
      | 3  | 31   | 20240401    |           | 151.59          | 49.74         | 1.59     | 0.0  | 0.0       | 51.33 | 0.0   | 0.0        | 0.0  | 51.33       |
      | 4  | 30   | 20240501      |           | 101.46          | 50.13         | 1.2      | 0.0  | 0.0       | 51.33 | 0.0   | 0.0        | 0.0  | 51.33       |
      | 5  | 31   | 20240601     |           | 50.93           | 50.53         | 0.8      | 0.0  | 0.0       | 51.33 | 0.0   | 0.0        | 0.0  | 51.33       |
      | 6  | 30   | 20240701     |           | 0.0             | 50.93         | 0.4      | 0.0  | 0.0       | 51.33 | 0.0   | 0.0        | 0.0  | 51.33       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 300.0         | 7.98     | 0.0  | 0.0       | 307.98 | 17.13 | 17.13      | 0.0  | 290.85      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        |
      | 20240105  | Repayment        | 17.13  | 16.34     | 0.79     | 0.0  | 0.0       | 83.66        |
      | 20240108  | Disbursement     | 200.0  | 0.0       | 0.0      | 0.0  | 0.0       | 283.66       |

  @TestRailId:C3196
  Scenario: EMI calculation with 365/30 multidisburse setup - UC3: 1st installment fully repaid early, then 2nd disbursement in 1std installment period, allocation rule: LAST INSTALLMENT
    When Admin sets the business date to "20240101"
    When Admin creates a client with random data
    When Admin set "LP2_ADV_PYMNT_INTEREST_DAILY_EMI_360_30_MULTIDISBURSE" loan product "DEFAULT" transaction type to "LAST_INSTALLMENT" future installment allocation rule
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                           | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_EMI_360_30_MULTIDISBURSE | 20240101   | 300            | 9.4822                 | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 6                 | MONTHS                | 1              | MONTHS                 | 6                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240101" with "300" amount and expected disbursement date on "20240101"
    When Admin successfully disburse the loan on "20240101" with "100" EUR transaction amount
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20240101  |           | 100.0           |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 31   | 20240201 |           | 83.66           | 16.34         | 0.79     | 0.0  | 0.0       | 17.13 | 0.0  | 0.0        | 0.0  | 17.13       |
      | 2  | 29   | 20240301    |           | 67.19           | 16.47         | 0.66     | 0.0  | 0.0       | 17.13 | 0.0  | 0.0        | 0.0  | 17.13       |
      | 3  | 31   | 20240401    |           | 50.59           | 16.6          | 0.53     | 0.0  | 0.0       | 17.13 | 0.0  | 0.0        | 0.0  | 17.13       |
      | 4  | 30   | 20240501      |           | 33.86           | 16.73         | 0.4      | 0.0  | 0.0       | 17.13 | 0.0  | 0.0        | 0.0  | 17.13       |
      | 5  | 31   | 20240601     |           | 17.0            | 16.86         | 0.27     | 0.0  | 0.0       | 17.13 | 0.0  | 0.0        | 0.0  | 17.13       |
      | 6  | 30   | 20240701     |           | 0.0             | 17.0          | 0.13     | 0.0  | 0.0       | 17.13 | 0.0  | 0.0        | 0.0  | 17.13       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 100.0         | 2.78     | 0.0  | 0.0       | 102.78 | 0.0  | 0.0        | 0.0  | 102.78      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        |
#    --- Early full repayment of 1st installment ---
    When Admin sets the business date to "20240105"
    And Customer makes "AUTOPAY" repayment on "20240105" with 17.13 EUR transaction amount
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101  |                 | 100.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 31   | 20240201 |                 | 83.66           | 16.34         | 0.79     | 0.0  | 0.0       | 17.13 | 0.0   | 0.0        | 0.0  | 17.13       |
      | 2  | 29   | 20240301    |                 | 67.19           | 16.47         | 0.66     | 0.0  | 0.0       | 17.13 | 0.0   | 0.0        | 0.0  | 17.13       |
      | 3  | 31   | 20240401    |                 | 50.59           | 16.6          | 0.53     | 0.0  | 0.0       | 17.13 | 0.0   | 0.0        | 0.0  | 17.13       |
      | 4  | 30   | 20240501      |                 | 33.86           | 16.73         | 0.4      | 0.0  | 0.0       | 17.13 | 0.0   | 0.0        | 0.0  | 17.13       |
      | 5  | 31   | 20240601     |                 | 17.0            | 16.86         | 0.27     | 0.0  | 0.0       | 17.13 | 0.0   | 0.0        | 0.0  | 17.13       |
      | 6  | 30   | 20240701     | 20240105 | 0.0             | 17.0          | 0.13     | 0.0  | 0.0       | 17.13 | 17.13 | 17.13      | 0.0  | 0.0         |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 100.0         | 2.78     | 0.0  | 0.0       | 102.78 | 17.13 | 17.13      | 0.0  | 85.65       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        |
      | 20240105  | Repayment        | 17.13  | 17.0      | 0.13     | 0.0  | 0.0       | 83.0         |
#   --- 2nd disbursement in first period ---
    When Admin sets the business date to "20240108"
    When Admin successfully disburse the loan on "20240108" with "200" EUR transaction amount
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101  |           | 100.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      |    |      | 20240108  |           | 200.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 31   | 20240201 |           | 250.68          | 49.32         | 2.01     | 0.0  | 0.0       | 51.33 | 0.0   | 0.0        | 0.0  | 51.33       |
      | 2  | 29   | 20240301    |           | 201.33          | 49.35         | 1.98     | 0.0  | 0.0       | 51.33 | 0.0   | 0.0        | 0.0  | 51.33       |
      | 3  | 31   | 20240401    |           | 151.59          | 49.74         | 1.59     | 0.0  | 0.0       | 51.33 | 0.0   | 0.0        | 0.0  | 51.33       |
      | 4  | 30   | 20240501      |           | 101.46          | 50.13         | 1.2      | 0.0  | 0.0       | 51.33 | 0.0   | 0.0        | 0.0  | 51.33       |
      | 5  | 31   | 20240601     |           | 50.93           | 50.53         | 0.8      | 0.0  | 0.0       | 51.33 | 0.0   | 0.0        | 0.0  | 51.33       |
      | 6  | 30   | 20240701     |           | 0.0             | 50.93         | 0.4      | 0.0  | 0.0       | 51.33 | 17.13 | 17.13      | 0.0  | 34.2        |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 300.0         | 7.98     | 0.0  | 0.0       | 307.98 | 17.13 | 17.13      | 0.0  | 290.85      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        |
      | 20240105  | Repayment        | 17.13  | 17.0      | 0.13     | 0.0  | 0.0       | 83.0         |
      | 20240108  | Disbursement     | 200.0  | 0.0       | 0.0      | 0.0  | 0.0       | 283.0        |
    When Admin set "LP2_ADV_PYMNT_INTEREST_DAILY_EMI_360_30_MULTIDISBURSE" loan product "DEFAULT" transaction type to "NEXT_INSTALLMENT" future installment allocation rule

  @TestRailId:C3197
  Scenario: EMI calculation with 365/30 multidisburse setup - UC4: 1st installment fully repaid on due date, 2nd disbursement in middle of 2nd installment period
    When Admin sets the business date to "20240101"
    When Admin creates a client with random data
    When Admin set "LP2_ADV_PYMNT_INTEREST_DAILY_EMI_360_30_MULTIDISBURSE" loan product "DEFAULT" transaction type to "NEXT_INSTALLMENT" future installment allocation rule
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                           | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_EMI_360_30_MULTIDISBURSE | 20240101   | 300            | 9.4822                 | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 6                 | MONTHS                | 1              | MONTHS                 | 6                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240101" with "300" amount and expected disbursement date on "20240101"
    When Admin successfully disburse the loan on "20240101" with "100" EUR transaction amount
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20240101  |           | 100.0           |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 31   | 20240201 |           | 83.66           | 16.34         | 0.79     | 0.0  | 0.0       | 17.13 | 0.0  | 0.0        | 0.0  | 17.13       |
      | 2  | 29   | 20240301    |           | 67.19           | 16.47         | 0.66     | 0.0  | 0.0       | 17.13 | 0.0  | 0.0        | 0.0  | 17.13       |
      | 3  | 31   | 20240401    |           | 50.59           | 16.6          | 0.53     | 0.0  | 0.0       | 17.13 | 0.0  | 0.0        | 0.0  | 17.13       |
      | 4  | 30   | 20240501      |           | 33.86           | 16.73         | 0.4      | 0.0  | 0.0       | 17.13 | 0.0  | 0.0        | 0.0  | 17.13       |
      | 5  | 31   | 20240601     |           | 17.0            | 16.86         | 0.27     | 0.0  | 0.0       | 17.13 | 0.0  | 0.0        | 0.0  | 17.13       |
      | 6  | 30   | 20240701     |           | 0.0             | 17.0          | 0.13     | 0.0  | 0.0       | 17.13 | 0.0  | 0.0        | 0.0  | 17.13       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 100.0         | 2.78     | 0.0  | 0.0       | 102.78 | 0.0  | 0.0        | 0.0  | 102.78      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        |
#    --- Repayment of 1st installment on due date ---
    When Admin sets the business date to "20240201"
    And Customer makes "AUTOPAY" repayment on "20240201" with 17.13 EUR transaction amount
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101  |                  | 100.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 31   | 20240201 | 20240201 | 83.66           | 16.34         | 0.79     | 0.0  | 0.0       | 17.13 | 17.13 | 0.0        | 0.0  | 0.0         |
      | 2  | 29   | 20240301    |                  | 67.19           | 16.47         | 0.66     | 0.0  | 0.0       | 17.13 | 0.0   | 0.0        | 0.0  | 17.13       |
      | 3  | 31   | 20240401    |                  | 50.59           | 16.6          | 0.53     | 0.0  | 0.0       | 17.13 | 0.0   | 0.0        | 0.0  | 17.13       |
      | 4  | 30   | 20240501      |                  | 33.86           | 16.73         | 0.4      | 0.0  | 0.0       | 17.13 | 0.0   | 0.0        | 0.0  | 17.13       |
      | 5  | 31   | 20240601     |                  | 17.0            | 16.86         | 0.27     | 0.0  | 0.0       | 17.13 | 0.0   | 0.0        | 0.0  | 17.13       |
      | 6  | 30   | 20240701     |                  | 0.0             | 17.0          | 0.13     | 0.0  | 0.0       | 17.13 | 0.0   | 0.0        | 0.0  | 17.13       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 100.0         | 2.78     | 0.0  | 0.0       | 102.78 | 17.13 | 0.0        | 0.0  | 85.65       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        |
      | 20240201 | Repayment        | 17.13  | 16.34     | 0.79     | 0.0  | 0.0       | 83.66        |
#    --- 2nd disbursement in the middle of 2nd installment period ---
    When Admin sets the business date to "20240215"
    When Admin successfully disburse the loan on "20240215" with "200" EUR transaction amount
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101  |                  | 100.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 31   | 20240201 | 20240201 | 83.66           | 16.34         | 0.79     | 0.0  | 0.0       | 17.13 | 17.13 | 0.0        | 0.0  | 0.0         |
      |    |      | 20240215 |                  | 200.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 2  | 29   | 20240301    |                  | 227.21          | 56.45         | 1.48     | 0.0  | 0.0       | 57.93 | 0.0   | 0.0        | 0.0  | 57.93       |
      | 3  | 31   | 20240401    |                  | 171.08          | 56.13         | 1.8      | 0.0  | 0.0       | 57.93 | 0.0   | 0.0        | 0.0  | 57.93       |
      | 4  | 30   | 20240501      |                  | 114.5           | 56.58         | 1.35     | 0.0  | 0.0       | 57.93 | 0.0   | 0.0        | 0.0  | 57.93       |
      | 5  | 31   | 20240601     |                  | 57.47           | 57.03         | 0.9      | 0.0  | 0.0       | 57.93 | 0.0   | 0.0        | 0.0  | 57.93       |
      | 6  | 30   | 20240701     |                  | 0.0             | 57.47         | 0.45     | 0.0  | 0.0       | 57.92 | 0.0   | 0.0        | 0.0  | 57.92       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 300.0         | 6.77     | 0.0  | 0.0       | 306.77 | 17.13 | 0.0        | 0.0  | 289.64      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        |
      | 20240201 | Repayment        | 17.13  | 16.34     | 0.79     | 0.0  | 0.0       | 83.66        |
      | 20240215 | Disbursement     | 200.0  | 0.0       | 0.0      | 0.0  | 0.0       | 283.66       |

  @TestRailId:C3198
  Scenario: EMI calculation with 365/30 multidisburse setup - UC5: 1st installment fully repaid on due date, 2nd disbursement at the end of 2nd installment period
    When Admin sets the business date to "20240101"
    When Admin creates a client with random data
    When Admin set "LP2_ADV_PYMNT_INTEREST_DAILY_EMI_360_30_MULTIDISBURSE" loan product "DEFAULT" transaction type to "NEXT_INSTALLMENT" future installment allocation rule
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                           | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_EMI_360_30_MULTIDISBURSE | 20240101   | 300            | 9.4822                 | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 6                 | MONTHS                | 1              | MONTHS                 | 6                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240101" with "300" amount and expected disbursement date on "20240101"
    When Admin successfully disburse the loan on "20240101" with "100" EUR transaction amount
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20240101  |           | 100.0           |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 31   | 20240201 |           | 83.66           | 16.34         | 0.79     | 0.0  | 0.0       | 17.13 | 0.0  | 0.0        | 0.0  | 17.13       |
      | 2  | 29   | 20240301    |           | 67.19           | 16.47         | 0.66     | 0.0  | 0.0       | 17.13 | 0.0  | 0.0        | 0.0  | 17.13       |
      | 3  | 31   | 20240401    |           | 50.59           | 16.6          | 0.53     | 0.0  | 0.0       | 17.13 | 0.0  | 0.0        | 0.0  | 17.13       |
      | 4  | 30   | 20240501      |           | 33.86           | 16.73         | 0.4      | 0.0  | 0.0       | 17.13 | 0.0  | 0.0        | 0.0  | 17.13       |
      | 5  | 31   | 20240601     |           | 17.0            | 16.86         | 0.27     | 0.0  | 0.0       | 17.13 | 0.0  | 0.0        | 0.0  | 17.13       |
      | 6  | 30   | 20240701     |           | 0.0             | 17.0          | 0.13     | 0.0  | 0.0       | 17.13 | 0.0  | 0.0        | 0.0  | 17.13       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 100.0         | 2.78     | 0.0  | 0.0       | 102.78 | 0.0  | 0.0        | 0.0  | 102.78      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        |
#    --- Repayment of 1st installment on due date ---
    When Admin sets the business date to "20240201"
    And Customer makes "AUTOPAY" repayment on "20240201" with 17.13 EUR transaction amount
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101  |                  | 100.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 31   | 20240201 | 20240201 | 83.66           | 16.34         | 0.79     | 0.0  | 0.0       | 17.13 | 17.13 | 0.0        | 0.0  | 0.0         |
      | 2  | 29   | 20240301    |                  | 67.19           | 16.47         | 0.66     | 0.0  | 0.0       | 17.13 | 0.0   | 0.0        | 0.0  | 17.13       |
      | 3  | 31   | 20240401    |                  | 50.59           | 16.6          | 0.53     | 0.0  | 0.0       | 17.13 | 0.0   | 0.0        | 0.0  | 17.13       |
      | 4  | 30   | 20240501      |                  | 33.86           | 16.73         | 0.4      | 0.0  | 0.0       | 17.13 | 0.0   | 0.0        | 0.0  | 17.13       |
      | 5  | 31   | 20240601     |                  | 17.0            | 16.86         | 0.27     | 0.0  | 0.0       | 17.13 | 0.0   | 0.0        | 0.0  | 17.13       |
      | 6  | 30   | 20240701     |                  | 0.0             | 17.0          | 0.13     | 0.0  | 0.0       | 17.13 | 0.0   | 0.0        | 0.0  | 17.13       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 100.0         | 2.78     | 0.0  | 0.0       | 102.78 | 17.13 | 0.0        | 0.0  | 85.65       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        |
      | 20240201 | Repayment        | 17.13  | 16.34     | 0.79     | 0.0  | 0.0       | 83.66        |
#    --- 2nd disbursement at the end of 2nd installment period ---
    When Admin sets the business date to "20240225"
    When Admin successfully disburse the loan on "20240225" with "200" EUR transaction amount
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101  |                  | 100.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 31   | 20240201 | 20240201 | 83.66           | 16.34         | 0.79     | 0.0  | 0.0       | 17.13 | 17.13 | 0.0        | 0.0  | 0.0         |
      |    |      | 20240225 |                  | 200.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 2  | 29   | 20240301    |                  | 226.77          | 56.89         | 0.93     | 0.0  | 0.0       | 57.82 | 0.0   | 0.0        | 0.0  | 57.82       |
      | 3  | 31   | 20240401    |                  | 170.74          | 56.03         | 1.79     | 0.0  | 0.0       | 57.82 | 0.0   | 0.0        | 0.0  | 57.82       |
      | 4  | 30   | 20240501      |                  | 114.27          | 56.47         | 1.35     | 0.0  | 0.0       | 57.82 | 0.0   | 0.0        | 0.0  | 57.82       |
      | 5  | 31   | 20240601     |                  | 57.35           | 56.92         | 0.9      | 0.0  | 0.0       | 57.82 | 0.0   | 0.0        | 0.0  | 57.82       |
      | 6  | 30   | 20240701     |                  | 0.0             | 57.35         | 0.45     | 0.0  | 0.0       | 57.8  | 0.0   | 0.0        | 0.0  | 57.8        |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 300.0         | 6.21     | 0.0  | 0.0       | 306.21 | 17.13 | 0.0        | 0.0  | 289.08      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        |
      | 20240201 | Repayment        | 17.13  | 16.34     | 0.79     | 0.0  | 0.0       | 83.66        |
      | 20240225 | Disbursement     | 200.0  | 0.0       | 0.0      | 0.0  | 0.0       | 283.66       |

  @TestRailId:C3199
  Scenario: EMI calculation with 365/30 multidisburse setup - UC6: no repayment, 2nd disbursement at the due date of 2nd installment period
    When Admin sets the business date to "20240101"
    When Admin creates a client with random data
    When Admin set "LP2_ADV_PYMNT_INTEREST_DAILY_EMI_360_30_MULTIDISBURSE" loan product "DEFAULT" transaction type to "NEXT_INSTALLMENT" future installment allocation rule
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                           | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_EMI_360_30_MULTIDISBURSE | 20240101   | 300            | 9.4822                 | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 6                 | MONTHS                | 1              | MONTHS                 | 6                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240101" with "300" amount and expected disbursement date on "20240101"
    When Admin successfully disburse the loan on "20240101" with "100" EUR transaction amount
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20240101  |           | 100.0           |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 31   | 20240201 |           | 83.66           | 16.34         | 0.79     | 0.0  | 0.0       | 17.13 | 0.0  | 0.0        | 0.0  | 17.13       |
      | 2  | 29   | 20240301    |           | 67.19           | 16.47         | 0.66     | 0.0  | 0.0       | 17.13 | 0.0  | 0.0        | 0.0  | 17.13       |
      | 3  | 31   | 20240401    |           | 50.59           | 16.6          | 0.53     | 0.0  | 0.0       | 17.13 | 0.0  | 0.0        | 0.0  | 17.13       |
      | 4  | 30   | 20240501      |           | 33.86           | 16.73         | 0.4      | 0.0  | 0.0       | 17.13 | 0.0  | 0.0        | 0.0  | 17.13       |
      | 5  | 31   | 20240601     |           | 17.0            | 16.86         | 0.27     | 0.0  | 0.0       | 17.13 | 0.0  | 0.0        | 0.0  | 17.13       |
      | 6  | 30   | 20240701     |           | 0.0             | 17.0          | 0.13     | 0.0  | 0.0       | 17.13 | 0.0  | 0.0        | 0.0  | 17.13       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 100.0         | 2.78     | 0.0  | 0.0       | 102.78 | 0.0  | 0.0        | 0.0  | 102.78      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        |
#    --- 2nd disbursement at the due date of 2nd installment period ---
    When Admin sets the business date to "20240301"
    When Admin successfully disburse the loan on "20240301" with "100" EUR transaction amount
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20240101  |           | 100.0           |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 31   | 20240201 |           | 83.66           | 16.34         | 0.79     | 0.0  | 0.0       | 17.13 | 0.0  | 0.0        | 0.0  | 17.13       |
      | 2  | 29   | 20240301    |           | 67.19           | 16.47         | 0.66     | 0.0  | 0.0       | 17.13 | 0.0  | 0.0        | 0.0  | 17.13       |
      |    |      | 20240301    |           | 100.0           |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 3  | 31   | 20240401    |           | 125.88          | 41.31         | 1.32     | 0.0  | 0.0       | 42.63 | 0.0  | 0.0        | 0.0  | 42.63       |
      | 4  | 30   | 20240501      |           | 84.24           | 41.64         | 0.99     | 0.0  | 0.0       | 42.63 | 0.0  | 0.0        | 0.0  | 42.63       |
      | 5  | 31   | 20240601     |           | 42.28           | 41.96         | 0.67     | 0.0  | 0.0       | 42.63 | 0.0  | 0.0        | 0.0  | 42.63       |
      | 6  | 30   | 20240701     |           | 0.0             | 42.28         | 0.33     | 0.0  | 0.0       | 42.61 | 0.0  | 0.0        | 0.0  | 42.61       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 200.0         | 4.76     | 0.0  | 0.0       | 204.76 | 0.0  | 0.0        | 0.0  | 204.76      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        |
      | 20240301    | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 200.0        |

  @TestRailId:C3200
  Scenario: EMI calculation with 365/30 downpayment setup - UC1: happy path - monthly repayment
    When Admin sets the business date to "20240101"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                         | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_EMI_360_30_DOWNPAYMENT | 20240101   | 100            | 5                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 5                 | MONTHS                | 1              | MONTHS                 | 5                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240101" with "100" amount and expected disbursement date on "20240101"
    When Admin successfully disburse the loan on "20240101" with "100" EUR transaction amount
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20240101  |           | 100.0           |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 0    | 20240101  |           | 75.0            | 25.0          | 0.0      | 0.0  | 0.0       | 25.0  | 0.0  | 0.0        | 0.0  | 25.0        |
      | 2  | 31   | 20240201 |           | 60.12           | 14.88         | 0.31     | 0.0  | 0.0       | 15.19 | 0.0  | 0.0        | 0.0  | 15.19       |
      | 3  | 29   | 20240301    |           | 45.18           | 14.94         | 0.25     | 0.0  | 0.0       | 15.19 | 0.0  | 0.0        | 0.0  | 15.19       |
      | 4  | 31   | 20240401    |           | 30.18           | 15.0          | 0.19     | 0.0  | 0.0       | 15.19 | 0.0  | 0.0        | 0.0  | 15.19       |
      | 5  | 30   | 20240501      |           | 15.12           | 15.06         | 0.13     | 0.0  | 0.0       | 15.19 | 0.0  | 0.0        | 0.0  | 15.19       |
      | 6  | 31   | 20240601     |           | 0.0             | 15.12         | 0.06     | 0.0  | 0.0       | 15.18 | 0.0  | 0.0        | 0.0  | 15.18       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 100.0         | 0.94     | 0.0  | 0.0       | 100.94 | 0.0  | 0.0        | 0.0  | 100.94      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        |

  @TestRailId:C3201
  Scenario: EMI calculation with 365/30 multidisburse, downpayment setup - UC1: no repayment, 2nd disbursement in the middle of 1st period
    When Admin sets the business date to "20240101"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                       | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_EMI_360_30_MULTIDISBURSE_DOWNPAYMENT | 20240101   | 200            | 9.4822                 | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 5                 | MONTHS                | 1              | MONTHS                 | 5                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240101" with "200" amount and expected disbursement date on "20240101"
    When Admin successfully disburse the loan on "20240101" with "100" EUR transaction amount
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20240101  |           | 100.0           |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 0    | 20240101  |           | 75.0            | 25.0          | 0.0      | 0.0  | 0.0       | 25.0  | 0.0  | 0.0        | 0.0  | 25.0        |
      | 2  | 31   | 20240201 |           | 60.23           | 14.77         | 0.59     | 0.0  | 0.0       | 15.36 | 0.0  | 0.0        | 0.0  | 15.36       |
      | 3  | 29   | 20240301    |           | 45.35           | 14.88         | 0.48     | 0.0  | 0.0       | 15.36 | 0.0  | 0.0        | 0.0  | 15.36       |
      | 4  | 31   | 20240401    |           | 30.35           | 15.0          | 0.36     | 0.0  | 0.0       | 15.36 | 0.0  | 0.0        | 0.0  | 15.36       |
      | 5  | 30   | 20240501      |           | 15.23           | 15.12         | 0.24     | 0.0  | 0.0       | 15.36 | 0.0  | 0.0        | 0.0  | 15.36       |
      | 6  | 31   | 20240601     |           | 0.0             | 15.23         | 0.12     | 0.0  | 0.0       | 15.35 | 0.0  | 0.0        | 0.0  | 15.35       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 100.0         | 1.79     | 0.0  | 0.0       | 101.79 | 0.0  | 0.0        | 0.0  | 101.79      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        |
#    --- 2nd disbursement in the middle of 1st period ---
    When Admin sets the business date to "20240115"
    When Admin successfully disburse the loan on "20240115" with "100" EUR transaction amount
    Then Loan Repayment schedule has 7 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20240101  |           | 100.0           |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 0    | 20240101  |           | 75.0            | 25.0          | 0.0      | 0.0  | 0.0       | 25.0  | 0.0  | 0.0        | 0.0  | 25.0        |
      |    |      | 20240115  |           | 100.0           |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 2  | 0    | 20240115  |           | 150.0           | 25.0          | 0.0      | 0.0  | 0.0       | 25.0  | 0.0  | 0.0        | 0.0  | 25.0        |
      | 3  | 31   | 20240201 |           | 120.26          | 29.74         | 0.92     | 0.0  | 0.0       | 30.66 | 0.0  | 0.0        | 0.0  | 30.66       |
      | 4  | 29   | 20240301    |           | 90.55           | 29.71         | 0.95     | 0.0  | 0.0       | 30.66 | 0.0  | 0.0        | 0.0  | 30.66       |
      | 5  | 31   | 20240401    |           | 60.61           | 29.94         | 0.72     | 0.0  | 0.0       | 30.66 | 0.0  | 0.0        | 0.0  | 30.66       |
      | 6  | 30   | 20240501      |           | 30.43           | 30.18         | 0.48     | 0.0  | 0.0       | 30.66 | 0.0  | 0.0        | 0.0  | 30.66       |
      | 7  | 31   | 20240601     |           | 0.0             | 30.43         | 0.24     | 0.0  | 0.0       | 30.67 | 0.0  | 0.0        | 0.0  | 30.67       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 200.0         | 3.31     | 0.0  | 0.0       | 203.31 | 0.0  | 0.0        | 0.0  | 203.31      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        |
      | 20240115  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 200.0        |

  @TestRailId:C3204
  Scenario: EMI calculation with 365/30 downpayment setup - UC2: happy path - 2 weeks repayment
    When Admin sets the business date to "20240101"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                         | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_EMI_360_30_DOWNPAYMENT | 20240101   | 100            | 9.4822                 | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 10                | WEEKS                 | 2              | WEEKS                  | 5                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240101" with "100" amount and expected disbursement date on "20240101"
    When Admin successfully disburse the loan on "20240101" with "100" EUR transaction amount
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20240101  |           | 100.0           |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 0    | 20240101  |           | 75.0            | 25.0          | 0.0      | 0.0  | 0.0       | 25.0  | 0.0  | 0.0        | 0.0  | 25.0        |
      | 2  | 14   | 20240115  |           | 60.11           | 14.89         | 0.28     | 0.0  | 0.0       | 15.17 | 0.0  | 0.0        | 0.0  | 15.17       |
      | 3  | 14   | 20240129  |           | 45.16           | 14.95         | 0.22     | 0.0  | 0.0       | 15.17 | 0.0  | 0.0        | 0.0  | 15.17       |
      | 4  | 14   | 20240212 |           | 30.16           | 15.0          | 0.17     | 0.0  | 0.0       | 15.17 | 0.0  | 0.0        | 0.0  | 15.17       |
      | 5  | 14   | 20240226 |           | 15.1            | 15.06         | 0.11     | 0.0  | 0.0       | 15.17 | 0.0  | 0.0        | 0.0  | 15.17       |
      | 6  | 14   | 20240311    |           | 0.0             | 15.1          | 0.06     | 0.0  | 0.0       | 15.16 | 0.0  | 0.0        | 0.0  | 15.16       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 100.0         | 0.84     | 0.0  | 0.0       | 100.84 | 0.0  | 0.0        | 0.0  | 100.84      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        |

  @TestRailId:C3205
  Scenario: EMI calculation with 365/30 downpayment setup - UC3: happy path - 30 days repayment
    When Admin sets the business date to "20240101"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                         | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_EMI_360_30_DOWNPAYMENT | 20240101   | 100            | 9.4822                 | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 150               | DAYS                  | 30             | DAYS                   | 5                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240101" with "100" amount and expected disbursement date on "20240101"
    When Admin successfully disburse the loan on "20240101" with "100" EUR transaction amount
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date            | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20240101 |           | 100.0           |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 0    | 20240101 |           | 75.0            | 25.0          | 0.0      | 0.0  | 0.0       | 25.0  | 0.0  | 0.0        | 0.0  | 25.0        |
      | 2  | 30   | 20240131 |           | 60.23           | 14.77         | 0.59     | 0.0  | 0.0       | 15.36 | 0.0  | 0.0        | 0.0  | 15.36       |
      | 3  | 30   | 20240301   |           | 45.35           | 14.88         | 0.48     | 0.0  | 0.0       | 15.36 | 0.0  | 0.0        | 0.0  | 15.36       |
      | 4  | 30   | 20240331   |           | 30.35           | 15.0          | 0.36     | 0.0  | 0.0       | 15.36 | 0.0  | 0.0        | 0.0  | 15.36       |
      | 5  | 30   | 20240430   |           | 15.23           | 15.12         | 0.24     | 0.0  | 0.0       | 15.36 | 0.0  | 0.0        | 0.0  | 15.36       |
      | 6  | 30   | 20240530     |           | 0.0             | 15.23         | 0.12     | 0.0  | 0.0       | 15.35 | 0.0  | 0.0        | 0.0  | 15.35       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 100.0         | 1.79     | 0.0  | 0.0       | 101.79 | 0.0  | 0.0        | 0.0  | 101.79      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        |

  @TestRailId:C3206
  Scenario: EMI calculation with 365/30 downpayment setup - UC4: happy path - 15 days repayment
    When Admin sets the business date to "20240101"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                         | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_EMI_360_30_DOWNPAYMENT | 20240101   | 100            | 9.4822                 | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 75                | DAYS                  | 15             | DAYS                   | 5                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240101" with "100" amount and expected disbursement date on "20240101"
    When Admin successfully disburse the loan on "20240101" with "100" EUR transaction amount
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20240101  |           | 100.0           |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 0    | 20240101  |           | 75.0            | 25.0          | 0.0      | 0.0  | 0.0       | 25.0  | 0.0  | 0.0        | 0.0  | 25.0        |
      | 2  | 15   | 20240116  |           | 60.12           | 14.88         | 0.3      | 0.0  | 0.0       | 15.18 | 0.0  | 0.0        | 0.0  | 15.18       |
      | 3  | 15   | 20240131  |           | 45.18           | 14.94         | 0.24     | 0.0  | 0.0       | 15.18 | 0.0  | 0.0        | 0.0  | 15.18       |
      | 4  | 15   | 20240215 |           | 30.18           | 15.0          | 0.18     | 0.0  | 0.0       | 15.18 | 0.0  | 0.0        | 0.0  | 15.18       |
      | 5  | 15   | 20240301    |           | 15.12           | 15.06         | 0.12     | 0.0  | 0.0       | 15.18 | 0.0  | 0.0        | 0.0  | 15.18       |
      | 6  | 15   | 20240316    |           | 0.0             | 15.12         | 0.06     | 0.0  | 0.0       | 15.18 | 0.0  | 0.0        | 0.0  | 15.18       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      | 100.0         | 0.9      | 0.0  | 0.0       | 100.9 | 0.0  | 0.0        | 0.0  | 100.9       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        |

  @TestRailId:C3207
  Scenario: EMI calculation with 365/30 downpayment setup - UC5: monthly repayment, partial repayment on 1st installment due date, backdated partial repayment on 1st installment due date (fully paid), 1st repayment undo
    When Admin sets the business date to "20240101"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                         | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_EMI_360_30_DOWNPAYMENT | 20240101   | 100            | 5                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 5                 | MONTHS                | 1              | MONTHS                 | 5                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240101" with "100" amount and expected disbursement date on "20240101"
    When Admin successfully disburse the loan on "20240101" with "100" EUR transaction amount
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20240101  |           | 100.0           |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 0    | 20240101  |           | 75.0            | 25.0          | 0.0      | 0.0  | 0.0       | 25.0  | 0.0  | 0.0        | 0.0  | 25.0        |
      | 2  | 31   | 20240201 |           | 60.12           | 14.88         | 0.31     | 0.0  | 0.0       | 15.19 | 0.0  | 0.0        | 0.0  | 15.19       |
      | 3  | 29   | 20240301    |           | 45.18           | 14.94         | 0.25     | 0.0  | 0.0       | 15.19 | 0.0  | 0.0        | 0.0  | 15.19       |
      | 4  | 31   | 20240401    |           | 30.18           | 15.0          | 0.19     | 0.0  | 0.0       | 15.19 | 0.0  | 0.0        | 0.0  | 15.19       |
      | 5  | 30   | 20240501      |           | 15.12           | 15.06         | 0.13     | 0.0  | 0.0       | 15.19 | 0.0  | 0.0        | 0.0  | 15.19       |
      | 6  | 31   | 20240601     |           | 0.0             | 15.12         | 0.06     | 0.0  | 0.0       | 15.18 | 0.0  | 0.0        | 0.0  | 15.18       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 100.0         | 0.94     | 0.0  | 0.0       | 100.94 | 0.0  | 0.0        | 0.0  | 100.94      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        |
#    --- Downpayment paid on due date ---
    And Customer makes "AUTOPAY" repayment on "20240101" with 25 EUR transaction amount
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20240101  |                 | 100.0           |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 0    | 20240101  | 20240101 | 75.0            | 25.0          | 0.0      | 0.0  | 0.0       | 25.0  | 25.0 | 0.0        | 0.0  | 0.0         |
      | 2  | 31   | 20240201 |                 | 60.12           | 14.88         | 0.31     | 0.0  | 0.0       | 15.19 | 0.0  | 0.0        | 0.0  | 15.19       |
      | 3  | 29   | 20240301    |                 | 45.18           | 14.94         | 0.25     | 0.0  | 0.0       | 15.19 | 0.0  | 0.0        | 0.0  | 15.19       |
      | 4  | 31   | 20240401    |                 | 30.18           | 15.0          | 0.19     | 0.0  | 0.0       | 15.19 | 0.0  | 0.0        | 0.0  | 15.19       |
      | 5  | 30   | 20240501      |                 | 15.12           | 15.06         | 0.13     | 0.0  | 0.0       | 15.19 | 0.0  | 0.0        | 0.0  | 15.19       |
      | 6  | 31   | 20240601     |                 | 0.0             | 15.12         | 0.06     | 0.0  | 0.0       | 15.18 | 0.0  | 0.0        | 0.0  | 15.18       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 100.0         | 0.94     | 0.0  | 0.0       | 100.94 | 25.0 | 0.0        | 0.0  | 75.94       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        |
      | 20240101  | Repayment        | 25.0   | 25.0      | 0.0      | 0.0  | 0.0       | 75.0         |
#   --- 1st installment partially paid on due date ---
    When Admin sets the business date to "20240201"
    And Customer makes "AUTOPAY" repayment on "20240201" with 10 EUR transaction amount
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20240101  |                 | 100.0           |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 0    | 20240101  | 20240101 | 75.0            | 25.0          | 0.0      | 0.0  | 0.0       | 25.0  | 25.0 | 0.0        | 0.0  | 0.0         |
      | 2  | 31   | 20240201 |                 | 60.12           | 14.88         | 0.31     | 0.0  | 0.0       | 15.19 | 10.0 | 0.0        | 0.0  | 5.19        |
      | 3  | 29   | 20240301    |                 | 45.18           | 14.94         | 0.25     | 0.0  | 0.0       | 15.19 | 0.0  | 0.0        | 0.0  | 15.19       |
      | 4  | 31   | 20240401    |                 | 30.18           | 15.0          | 0.19     | 0.0  | 0.0       | 15.19 | 0.0  | 0.0        | 0.0  | 15.19       |
      | 5  | 30   | 20240501      |                 | 15.12           | 15.06         | 0.13     | 0.0  | 0.0       | 15.19 | 0.0  | 0.0        | 0.0  | 15.19       |
      | 6  | 31   | 20240601     |                 | 0.0             | 15.12         | 0.06     | 0.0  | 0.0       | 15.18 | 0.0  | 0.0        | 0.0  | 15.18       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 100.0         | 0.94     | 0.0  | 0.0       | 100.94 | 35.0 | 0.0        | 0.0  | 65.94       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        |
      | 20240101  | Repayment        | 25.0   | 25.0      | 0.0      | 0.0  | 0.0       | 75.0         |
      | 20240201 | Repayment        | 10.0   | 10.0      | 0.0      | 0.0  | 0.0       | 65.0         |
#    --- 1st installment fully paid by  payment backdated to due date ---
    When Admin sets the business date to "20240215"
    And Customer makes "AUTOPAY" repayment on "20240201" with 5.19 EUR transaction amount
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101  |                  | 100.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 0    | 20240101  | 20240101  | 75.0            | 25.0          | 0.0      | 0.0  | 0.0       | 25.0  | 25.0  | 0.0        | 0.0  | 0.0         |
      | 2  | 31   | 20240201 | 20240201 | 60.12           | 14.88         | 0.31     | 0.0  | 0.0       | 15.19 | 15.19 | 0.0        | 0.0  | 0.0         |
      | 3  | 29   | 20240301    |                  | 45.18           | 14.94         | 0.25     | 0.0  | 0.0       | 15.19 | 0.0   | 0.0        | 0.0  | 15.19       |
      | 4  | 31   | 20240401    |                  | 30.18           | 15.0          | 0.19     | 0.0  | 0.0       | 15.19 | 0.0   | 0.0        | 0.0  | 15.19       |
      | 5  | 30   | 20240501      |                  | 15.12           | 15.06         | 0.13     | 0.0  | 0.0       | 15.19 | 0.0   | 0.0        | 0.0  | 15.19       |
      | 6  | 31   | 20240601     |                  | 0.0             | 15.12         | 0.06     | 0.0  | 0.0       | 15.18 | 0.0   | 0.0        | 0.0  | 15.18       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 100.0         | 0.94     | 0.0  | 0.0       | 100.94 | 40.19 | 0.0        | 0.0  | 60.75       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        |
      | 20240101  | Repayment        | 25.0   | 25.0      | 0.0      | 0.0  | 0.0       | 75.0         |
      | 20240201 | Repayment        | 10.0   | 10.0      | 0.0      | 0.0  | 0.0       | 65.0         |
      | 20240201 | Repayment        | 5.19   | 4.88      | 0.31     | 0.0  | 0.0       | 60.12        |
#    --- First repayment reversed ---
    When Admin sets the business date to "20240216"
    When Customer undo "1"th "Repayment" transaction made on "20240201"
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20240101  |                 | 100.0           |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 0    | 20240101  | 20240101 | 75.0            | 25.0          | 0.0      | 0.0  | 0.0       | 25.0  | 25.0 | 0.0        | 0.0  | 0.0         |
      | 2  | 31   | 20240201 |                 | 60.12           | 14.88         | 0.31     | 0.0  | 0.0       | 15.19 | 5.19 | 0.0        | 0.0  | 10.0        |
      | 3  | 29   | 20240301    |                 | 45.18           | 14.94         | 0.25     | 0.0  | 0.0       | 15.19 | 0.0  | 0.0        | 0.0  | 15.19       |
      | 4  | 31   | 20240401    |                 | 30.18           | 15.0          | 0.19     | 0.0  | 0.0       | 15.19 | 0.0  | 0.0        | 0.0  | 15.19       |
      | 5  | 30   | 20240501      |                 | 15.12           | 15.06         | 0.13     | 0.0  | 0.0       | 15.19 | 0.0  | 0.0        | 0.0  | 15.19       |
      | 6  | 31   | 20240601     |                 | 0.0             | 15.12         | 0.06     | 0.0  | 0.0       | 15.18 | 0.0  | 0.0        | 0.0  | 15.18       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 100.0         | 0.94     | 0.0  | 0.0       | 100.94 | 30.19 | 0.0        | 0.0  | 70.75       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240101  | Repayment        | 25.0   | 25.0      | 0.0      | 0.0  | 0.0       | 75.0         | false    | false    |
      | 20240201 | Repayment        | 10.0   | 10.0      | 0.0      | 0.0  | 0.0       | 65.0         | true     | false    |
      | 20240201 | Repayment        | 5.19   | 5.19      | 0.0      | 0.0  | 0.0       | 69.81        | false    | true     |

  @TestRailId:C3208
  Scenario: EMI calculation with 365/30 downpayment setup - UC6: 2 weeks repayment, partial repayment on 1st installment due date, backdated partial repayment on 1st installment due date (fully paid), 1st repayment undo
    When Admin sets the business date to "20240101"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                         | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_EMI_360_30_DOWNPAYMENT | 20240101   | 100            | 9.4822                 | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 10                | WEEKS                 | 2              | WEEKS                  | 5                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240101" with "100" amount and expected disbursement date on "20240101"
    When Admin successfully disburse the loan on "20240101" with "100" EUR transaction amount
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20240101  |           | 100.0           |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 0    | 20240101  |           | 75.0            | 25.0          | 0.0      | 0.0  | 0.0       | 25.0  | 0.0  | 0.0        | 0.0  | 25.0        |
      | 2  | 14   | 20240115  |           | 60.11           | 14.89         | 0.28     | 0.0  | 0.0       | 15.17 | 0.0  | 0.0        | 0.0  | 15.17       |
      | 3  | 14   | 20240129  |           | 45.16           | 14.95         | 0.22     | 0.0  | 0.0       | 15.17 | 0.0  | 0.0        | 0.0  | 15.17       |
      | 4  | 14   | 20240212 |           | 30.16           | 15.0          | 0.17     | 0.0  | 0.0       | 15.17 | 0.0  | 0.0        | 0.0  | 15.17       |
      | 5  | 14   | 20240226 |           | 15.1            | 15.06         | 0.11     | 0.0  | 0.0       | 15.17 | 0.0  | 0.0        | 0.0  | 15.17       |
      | 6  | 14   | 20240311    |           | 0.0             | 15.1          | 0.06     | 0.0  | 0.0       | 15.16 | 0.0  | 0.0        | 0.0  | 15.16       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 100.0         | 0.84     | 0.0  | 0.0       | 100.84 | 0.0  | 0.0        | 0.0  | 100.84      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        |
    #    --- Downpayment paid on due date ---
    And Customer makes "AUTOPAY" repayment on "20240101" with 25 EUR transaction amount
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20240101  |                 | 100.0           |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 0    | 20240101  | 20240101 | 75.0            | 25.0          | 0.0      | 0.0  | 0.0       | 25.0  | 25.0 | 0.0        | 0.0  | 0.0         |
      | 2  | 14   | 20240115  |                 | 60.11           | 14.89         | 0.28     | 0.0  | 0.0       | 15.17 | 0.0  | 0.0        | 0.0  | 15.17       |
      | 3  | 14   | 20240129  |                 | 45.16           | 14.95         | 0.22     | 0.0  | 0.0       | 15.17 | 0.0  | 0.0        | 0.0  | 15.17       |
      | 4  | 14   | 20240212 |                 | 30.16           | 15.0          | 0.17     | 0.0  | 0.0       | 15.17 | 0.0  | 0.0        | 0.0  | 15.17       |
      | 5  | 14   | 20240226 |                 | 15.1            | 15.06         | 0.11     | 0.0  | 0.0       | 15.17 | 0.0  | 0.0        | 0.0  | 15.17       |
      | 6  | 14   | 20240311    |                 | 0.0             | 15.1          | 0.06     | 0.0  | 0.0       | 15.16 | 0.0  | 0.0        | 0.0  | 15.16       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 100.0         | 0.84     | 0.0  | 0.0       | 100.84 | 25.0 | 0.0        | 0.0  | 75.84       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        |
      | 20240101  | Repayment        | 25.0   | 25.0      | 0.0      | 0.0  | 0.0       | 75.0         |
#   --- 1st installment partially paid on due date ---
    When Admin sets the business date to "20240115"
    And Customer makes "AUTOPAY" repayment on "20240115" with 10 EUR transaction amount
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20240101  |                 | 100.0           |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 0    | 20240101  | 20240101 | 75.0            | 25.0          | 0.0      | 0.0  | 0.0       | 25.0  | 25.0 | 0.0        | 0.0  | 0.0         |
      | 2  | 14   | 20240115  |                 | 60.11           | 14.89         | 0.28     | 0.0  | 0.0       | 15.17 | 10.0 | 0.0        | 0.0  | 5.17        |
      | 3  | 14   | 20240129  |                 | 45.16           | 14.95         | 0.22     | 0.0  | 0.0       | 15.17 | 0.0  | 0.0        | 0.0  | 15.17       |
      | 4  | 14   | 20240212 |                 | 30.16           | 15.0          | 0.17     | 0.0  | 0.0       | 15.17 | 0.0  | 0.0        | 0.0  | 15.17       |
      | 5  | 14   | 20240226 |                 | 15.1            | 15.06         | 0.11     | 0.0  | 0.0       | 15.17 | 0.0  | 0.0        | 0.0  | 15.17       |
      | 6  | 14   | 20240311    |                 | 0.0             | 15.1          | 0.06     | 0.0  | 0.0       | 15.16 | 0.0  | 0.0        | 0.0  | 15.16       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 100.0         | 0.84     | 0.0  | 0.0       | 100.84 | 35.0 | 0.0        | 0.0  | 65.84       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        |
      | 20240101  | Repayment        | 25.0   | 25.0      | 0.0      | 0.0  | 0.0       | 75.0         |
      | 20240115  | Repayment        | 10.0   | 10.0      | 0.0      | 0.0  | 0.0       | 65.0         |
#    --- 1st installment fully paid by  payment backdated to due date ---
    When Admin sets the business date to "20240120"
    And Customer makes "AUTOPAY" repayment on "20240115" with 5.17 EUR transaction amount
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101  |                 | 100.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 0    | 20240101  | 20240101 | 75.0            | 25.0          | 0.0      | 0.0  | 0.0       | 25.0  | 25.0  | 0.0        | 0.0  | 0.0         |
      | 2  | 14   | 20240115  | 20240115 | 60.11           | 14.89         | 0.28     | 0.0  | 0.0       | 15.17 | 15.17 | 0.0        | 0.0  | 0.0         |
      | 3  | 14   | 20240129  |                 | 45.16           | 14.95         | 0.22     | 0.0  | 0.0       | 15.17 | 0.0   | 0.0        | 0.0  | 15.17       |
      | 4  | 14   | 20240212 |                 | 30.16           | 15.0          | 0.17     | 0.0  | 0.0       | 15.17 | 0.0   | 0.0        | 0.0  | 15.17       |
      | 5  | 14   | 20240226 |                 | 15.1            | 15.06         | 0.11     | 0.0  | 0.0       | 15.17 | 0.0   | 0.0        | 0.0  | 15.17       |
      | 6  | 14   | 20240311    |                 | 0.0             | 15.1          | 0.06     | 0.0  | 0.0       | 15.16 | 0.0   | 0.0        | 0.0  | 15.16       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 100.0         | 0.84     | 0.0  | 0.0       | 100.84 | 40.17 | 0.0        | 0.0  | 60.67       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        |
      | 20240101  | Repayment        | 25.0   | 25.0      | 0.0      | 0.0  | 0.0       | 75.0         |
      | 20240115  | Repayment        | 10.0   | 10.0      | 0.0      | 0.0  | 0.0       | 65.0         |
      | 20240115  | Repayment        | 5.17   | 4.89      | 0.28     | 0.0  | 0.0       | 60.11        |
#    --- First repayment reversed ---
    When Admin sets the business date to "20240121"
    When Customer undo "1"th "Repayment" transaction made on "20240115"
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20240101  |                 | 100.0           |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 0    | 20240101  | 20240101 | 75.0            | 25.0          | 0.0      | 0.0  | 0.0       | 25.0  | 25.0 | 0.0        | 0.0  | 0.0         |
      | 2  | 14   | 20240115  |                 | 60.11           | 14.89         | 0.28     | 0.0  | 0.0       | 15.17 | 5.17 | 0.0        | 0.0  | 10.0        |
      | 3  | 14   | 20240129  |                 | 45.16           | 14.95         | 0.22     | 0.0  | 0.0       | 15.17 | 0.0  | 0.0        | 0.0  | 15.17       |
      | 4  | 14   | 20240212 |                 | 30.16           | 15.0          | 0.17     | 0.0  | 0.0       | 15.17 | 0.0  | 0.0        | 0.0  | 15.17       |
      | 5  | 14   | 20240226 |                 | 15.1            | 15.06         | 0.11     | 0.0  | 0.0       | 15.17 | 0.0  | 0.0        | 0.0  | 15.17       |
      | 6  | 14   | 20240311    |                 | 0.0             | 15.1          | 0.06     | 0.0  | 0.0       | 15.16 | 0.0  | 0.0        | 0.0  | 15.16       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 100.0         | 0.84     | 0.0  | 0.0       | 100.84 | 30.17 | 0.0        | 0.0  | 70.67       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240101  | Repayment        | 25.0   | 25.0      | 0.0      | 0.0  | 0.0       | 75.0         | false    | false    |
      | 20240115  | Repayment        | 10.0   | 10.0      | 0.0      | 0.0  | 0.0       | 65.0         | true     | false    |
      | 20240115  | Repayment        | 5.17   | 5.17      | 0.0      | 0.0  | 0.0       | 69.83        | false    | true     |

  @TestRailId:C3209
  Scenario: EMI calculation with 365/30 downpayment setup - UC7: 30 days repayment, partial repayment on 1st installment due date, backdated partial repayment on 1st installment due date (fully paid), 1st repayment undo
    When Admin sets the business date to "20240101"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                         | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_EMI_360_30_DOWNPAYMENT | 20240101   | 100            | 9.4822                 | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 150               | DAYS                  | 30             | DAYS                   | 5                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240101" with "100" amount and expected disbursement date on "20240101"
    When Admin successfully disburse the loan on "20240101" with "100" EUR transaction amount
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date            | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20240101 |           | 100.0           |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 0    | 20240101 |           | 75.0            | 25.0          | 0.0      | 0.0  | 0.0       | 25.0  | 0.0  | 0.0        | 0.0  | 25.0        |
      | 2  | 30   | 20240131 |           | 60.23           | 14.77         | 0.59     | 0.0  | 0.0       | 15.36 | 0.0  | 0.0        | 0.0  | 15.36       |
      | 3  | 30   | 20240301   |           | 45.35           | 14.88         | 0.48     | 0.0  | 0.0       | 15.36 | 0.0  | 0.0        | 0.0  | 15.36       |
      | 4  | 30   | 20240331   |           | 30.35           | 15.0          | 0.36     | 0.0  | 0.0       | 15.36 | 0.0  | 0.0        | 0.0  | 15.36       |
      | 5  | 30   | 20240430   |           | 15.23           | 15.12         | 0.24     | 0.0  | 0.0       | 15.36 | 0.0  | 0.0        | 0.0  | 15.36       |
      | 6  | 30   | 20240530     |           | 0.0             | 15.23         | 0.12     | 0.0  | 0.0       | 15.35 | 0.0  | 0.0        | 0.0  | 15.35       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 100.0         | 1.79     | 0.0  | 0.0       | 101.79 | 0.0  | 0.0        | 0.0  | 101.79      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        |
     #    --- Downpayment paid on due date ---
    And Customer makes "AUTOPAY" repayment on "20240101" with 25 EUR transaction amount
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date            | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20240101 |                 | 100.0           |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 0    | 20240101 | 20240101 | 75.0            | 25.0          | 0.0      | 0.0  | 0.0       | 25.0  | 25.0 | 0.0        | 0.0  | 0.0         |
      | 2  | 30   | 20240131 |                 | 60.23           | 14.77         | 0.59     | 0.0  | 0.0       | 15.36 | 0.0  | 0.0        | 0.0  | 15.36       |
      | 3  | 30   | 20240301   |                 | 45.35           | 14.88         | 0.48     | 0.0  | 0.0       | 15.36 | 0.0  | 0.0        | 0.0  | 15.36       |
      | 4  | 30   | 20240331   |                 | 30.35           | 15.0          | 0.36     | 0.0  | 0.0       | 15.36 | 0.0  | 0.0        | 0.0  | 15.36       |
      | 5  | 30   | 20240430   |                 | 15.23           | 15.12         | 0.24     | 0.0  | 0.0       | 15.36 | 0.0  | 0.0        | 0.0  | 15.36       |
      | 6  | 30   | 20240530     |                 | 0.0             | 15.23         | 0.12     | 0.0  | 0.0       | 15.35 | 0.0  | 0.0        | 0.0  | 15.35       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 100.0         | 1.79     | 0.0  | 0.0       | 101.79 | 25.0 | 0.0        | 0.0  | 76.79       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        |
      | 20240101  | Repayment        | 25.0   | 25.0      | 0.0      | 0.0  | 0.0       | 75.0         |
#   --- 1st installment partially paid on due date ---
    When Admin sets the business date to "20240131"
    And Customer makes "AUTOPAY" repayment on "20240131" with 10 EUR transaction amount
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date            | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20240101 |                 | 100.0           |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 0    | 20240101 | 20240101 | 75.0            | 25.0          | 0.0      | 0.0  | 0.0       | 25.0  | 25.0 | 0.0        | 0.0  | 0.0         |
      | 2  | 30   | 20240131 |                 | 60.23           | 14.77         | 0.59     | 0.0  | 0.0       | 15.36 | 10.0 | 0.0        | 0.0  | 5.36        |
      | 3  | 30   | 20240301   |                 | 45.35           | 14.88         | 0.48     | 0.0  | 0.0       | 15.36 | 0.0  | 0.0        | 0.0  | 15.36       |
      | 4  | 30   | 20240331   |                 | 30.35           | 15.0          | 0.36     | 0.0  | 0.0       | 15.36 | 0.0  | 0.0        | 0.0  | 15.36       |
      | 5  | 30   | 20240430   |                 | 15.23           | 15.12         | 0.24     | 0.0  | 0.0       | 15.36 | 0.0  | 0.0        | 0.0  | 15.36       |
      | 6  | 30   | 20240530     |                 | 0.0             | 15.23         | 0.12     | 0.0  | 0.0       | 15.35 | 0.0  | 0.0        | 0.0  | 15.35       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 100.0         | 1.79     | 0.0  | 0.0       | 101.79 | 35.0 | 0.0        | 0.0  | 66.79       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        |
      | 20240101  | Repayment        | 25.0   | 25.0      | 0.0      | 0.0  | 0.0       | 75.0         |
      | 20240131  | Repayment        | 10.0   | 10.0      | 0.0      | 0.0  | 0.0       | 65.0         |
#    --- 1st installment fully paid by  payment backdated to due date ---
    When Admin sets the business date to "20240210"
    And Customer makes "AUTOPAY" repayment on "20240131" with 5.36 EUR transaction amount
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date            | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101 |                 | 100.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 0    | 20240101 | 20240101 | 75.0            | 25.0          | 0.0      | 0.0  | 0.0       | 25.0  | 25.0  | 0.0        | 0.0  | 0.0         |
      | 2  | 30   | 20240131 | 20240131 | 60.23           | 14.77         | 0.59     | 0.0  | 0.0       | 15.36 | 15.36 | 0.0        | 0.0  | 0.0         |
      | 3  | 30   | 20240301   |                 | 45.35           | 14.88         | 0.48     | 0.0  | 0.0       | 15.36 | 0.0   | 0.0        | 0.0  | 15.36       |
      | 4  | 30   | 20240331   |                 | 30.35           | 15.0          | 0.36     | 0.0  | 0.0       | 15.36 | 0.0   | 0.0        | 0.0  | 15.36       |
      | 5  | 30   | 20240430   |                 | 15.23           | 15.12         | 0.24     | 0.0  | 0.0       | 15.36 | 0.0   | 0.0        | 0.0  | 15.36       |
      | 6  | 30   | 20240530     |                 | 0.0             | 15.23         | 0.12     | 0.0  | 0.0       | 15.35 | 0.0   | 0.0        | 0.0  | 15.35       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 100.0         | 1.79     | 0.0  | 0.0       | 101.79 | 40.36 | 0.0        | 0.0  | 61.43       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        |
      | 20240101  | Repayment        | 25.0   | 25.0      | 0.0      | 0.0  | 0.0       | 75.0         |
      | 20240131  | Repayment        | 10.0   | 10.0      | 0.0      | 0.0  | 0.0       | 65.0         |
      | 20240131  | Repayment        | 5.36   | 4.77      | 0.59     | 0.0  | 0.0       | 60.23        |
#    --- First repayment reversed ---
    When Admin sets the business date to "20240211"
    When Customer undo "1"th "Repayment" transaction made on "20240131"
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date            | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20240101 |                 | 100.0           |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 0    | 20240101 | 20240101 | 75.0            | 25.0          | 0.0      | 0.0  | 0.0       | 25.0  | 25.0 | 0.0        | 0.0  | 0.0         |
      | 2  | 30   | 20240131 |                 | 60.23           | 14.77         | 0.59     | 0.0  | 0.0       | 15.36 | 5.36 | 0.0        | 0.0  | 10.0        |
      | 3  | 30   | 20240301   |                 | 45.35           | 14.88         | 0.48     | 0.0  | 0.0       | 15.36 | 0.0  | 0.0        | 0.0  | 15.36       |
      | 4  | 30   | 20240331   |                 | 30.35           | 15.0          | 0.36     | 0.0  | 0.0       | 15.36 | 0.0  | 0.0        | 0.0  | 15.36       |
      | 5  | 30   | 20240430   |                 | 15.23           | 15.12         | 0.24     | 0.0  | 0.0       | 15.36 | 0.0  | 0.0        | 0.0  | 15.36       |
      | 6  | 30   | 20240530     |                 | 0.0             | 15.23         | 0.12     | 0.0  | 0.0       | 15.35 | 0.0  | 0.0        | 0.0  | 15.35       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 100.0         | 1.79     | 0.0  | 0.0       | 101.79 | 30.36 | 0.0        | 0.0  | 71.43       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240101  | Repayment        | 25.0   | 25.0      | 0.0      | 0.0  | 0.0       | 75.0         | false    | false    |
      | 20240131  | Repayment        | 10.0   | 10.0      | 0.0      | 0.0  | 0.0       | 65.0         | true     | false    |
      | 20240131  | Repayment        | 5.36   | 5.36      | 0.0      | 0.0  | 0.0       | 69.64        | false    | true     |

  @TestRailId:C3210
  Scenario: EMI calculation with 365/30 downpayment setup - UC8: 15 days repayment, partial repayment on 1st installment due date, backdated partial repayment on 1st installment due date (fully paid), 1st repayment undo
    When Admin sets the business date to "20240101"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                         | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_EMI_360_30_DOWNPAYMENT | 20240101   | 100            | 9.4822                 | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 75                | DAYS                  | 15             | DAYS                   | 5                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240101" with "100" amount and expected disbursement date on "20240101"
    When Admin successfully disburse the loan on "20240101" with "100" EUR transaction amount
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20240101  |           | 100.0           |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 0    | 20240101  |           | 75.0            | 25.0          | 0.0      | 0.0  | 0.0       | 25.0  | 0.0  | 0.0        | 0.0  | 25.0        |
      | 2  | 15   | 20240116  |           | 60.12           | 14.88         | 0.3      | 0.0  | 0.0       | 15.18 | 0.0  | 0.0        | 0.0  | 15.18       |
      | 3  | 15   | 20240131  |           | 45.18           | 14.94         | 0.24     | 0.0  | 0.0       | 15.18 | 0.0  | 0.0        | 0.0  | 15.18       |
      | 4  | 15   | 20240215 |           | 30.18           | 15.0          | 0.18     | 0.0  | 0.0       | 15.18 | 0.0  | 0.0        | 0.0  | 15.18       |
      | 5  | 15   | 20240301    |           | 15.12           | 15.06         | 0.12     | 0.0  | 0.0       | 15.18 | 0.0  | 0.0        | 0.0  | 15.18       |
      | 6  | 15   | 20240316    |           | 0.0             | 15.12         | 0.06     | 0.0  | 0.0       | 15.18 | 0.0  | 0.0        | 0.0  | 15.18       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      | 100.0         | 0.9      | 0.0  | 0.0       | 100.9 | 0.0  | 0.0        | 0.0  | 100.9       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        |
      #    --- Downpayment paid on due date ---
    And Customer makes "AUTOPAY" repayment on "20240101" with 25 EUR transaction amount
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20240101  |                 | 100.0           |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 0    | 20240101  | 20240101 | 75.0            | 25.0          | 0.0      | 0.0  | 0.0       | 25.0  | 25.0 | 0.0        | 0.0  | 0.0         |
      | 2  | 15   | 20240116  |                 | 60.12           | 14.88         | 0.3      | 0.0  | 0.0       | 15.18 | 0.0  | 0.0        | 0.0  | 15.18       |
      | 3  | 15   | 20240131  |                 | 45.18           | 14.94         | 0.24     | 0.0  | 0.0       | 15.18 | 0.0  | 0.0        | 0.0  | 15.18       |
      | 4  | 15   | 20240215 |                 | 30.18           | 15.0          | 0.18     | 0.0  | 0.0       | 15.18 | 0.0  | 0.0        | 0.0  | 15.18       |
      | 5  | 15   | 20240301    |                 | 15.12           | 15.06         | 0.12     | 0.0  | 0.0       | 15.18 | 0.0  | 0.0        | 0.0  | 15.18       |
      | 6  | 15   | 20240316    |                 | 0.0             | 15.12         | 0.06     | 0.0  | 0.0       | 15.18 | 0.0  | 0.0        | 0.0  | 15.18       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      | 100.0         | 0.9      | 0.0  | 0.0       | 100.9 | 25.0 | 0.0        | 0.0  | 75.9        |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        |
      | 20240101  | Repayment        | 25.0   | 25.0      | 0.0      | 0.0  | 0.0       | 75.0         |
#   --- 1st installment partially paid on due date ---
    When Admin sets the business date to "20240116"
    And Customer makes "AUTOPAY" repayment on "20240116" with 10 EUR transaction amount
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20240101  |                 | 100.0           |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 0    | 20240101  | 20240101 | 75.0            | 25.0          | 0.0      | 0.0  | 0.0       | 25.0  | 25.0 | 0.0        | 0.0  | 0.0         |
      | 2  | 15   | 20240116  |                 | 60.12           | 14.88         | 0.3      | 0.0  | 0.0       | 15.18 | 10.0 | 0.0        | 0.0  | 5.18        |
      | 3  | 15   | 20240131  |                 | 45.18           | 14.94         | 0.24     | 0.0  | 0.0       | 15.18 | 0.0  | 0.0        | 0.0  | 15.18       |
      | 4  | 15   | 20240215 |                 | 30.18           | 15.0          | 0.18     | 0.0  | 0.0       | 15.18 | 0.0  | 0.0        | 0.0  | 15.18       |
      | 5  | 15   | 20240301    |                 | 15.12           | 15.06         | 0.12     | 0.0  | 0.0       | 15.18 | 0.0  | 0.0        | 0.0  | 15.18       |
      | 6  | 15   | 20240316    |                 | 0.0             | 15.12         | 0.06     | 0.0  | 0.0       | 15.18 | 0.0  | 0.0        | 0.0  | 15.18       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      | 100.0         | 0.9      | 0.0  | 0.0       | 100.9 | 35.0 | 0.0        | 0.0  | 65.9        |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        |
      | 20240101  | Repayment        | 25.0   | 25.0      | 0.0      | 0.0  | 0.0       | 75.0         |
      | 20240116  | Repayment        | 10.0   | 10.0      | 0.0      | 0.0  | 0.0       | 65.0         |
#    --- 1st installment fully paid by  payment backdated to due date ---
    When Admin sets the business date to "20240120"
    And Customer makes "AUTOPAY" repayment on "20240116" with 5.18 EUR transaction amount
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101  |                 | 100.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 0    | 20240101  | 20240101 | 75.0            | 25.0          | 0.0      | 0.0  | 0.0       | 25.0  | 25.0  | 0.0        | 0.0  | 0.0         |
      | 2  | 15   | 20240116  | 20240116 | 60.12           | 14.88         | 0.3      | 0.0  | 0.0       | 15.18 | 15.18 | 0.0        | 0.0  | 0.0         |
      | 3  | 15   | 20240131  |                 | 45.18           | 14.94         | 0.24     | 0.0  | 0.0       | 15.18 | 0.0   | 0.0        | 0.0  | 15.18       |
      | 4  | 15   | 20240215 |                 | 30.18           | 15.0          | 0.18     | 0.0  | 0.0       | 15.18 | 0.0   | 0.0        | 0.0  | 15.18       |
      | 5  | 15   | 20240301    |                 | 15.12           | 15.06         | 0.12     | 0.0  | 0.0       | 15.18 | 0.0   | 0.0        | 0.0  | 15.18       |
      | 6  | 15   | 20240316    |                 | 0.0             | 15.12         | 0.06     | 0.0  | 0.0       | 15.18 | 0.0   | 0.0        | 0.0  | 15.18       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      | 100.0         | 0.9      | 0.0  | 0.0       | 100.9 | 40.18 | 0.0        | 0.0  | 60.72       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        |
      | 20240101  | Repayment        | 25.0   | 25.0      | 0.0      | 0.0  | 0.0       | 75.0         |
      | 20240116  | Repayment        | 10.0   | 10.0      | 0.0      | 0.0  | 0.0       | 65.0         |
      | 20240116  | Repayment        | 5.18   | 4.88      | 0.3      | 0.0  | 0.0       | 60.12        |
#    --- First repayment reversed ---
    When Admin sets the business date to "20240121"
    When Customer undo "1"th "Repayment" transaction made on "20240116"
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20240101  |                 | 100.0           |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 0    | 20240101  | 20240101 | 75.0            | 25.0          | 0.0      | 0.0  | 0.0       | 25.0  | 25.0 | 0.0        | 0.0  | 0.0         |
      | 2  | 15   | 20240116  |                 | 60.12           | 14.88         | 0.3      | 0.0  | 0.0       | 15.18 | 5.18 | 0.0        | 0.0  | 10.0        |
      | 3  | 15   | 20240131  |                 | 45.18           | 14.94         | 0.24     | 0.0  | 0.0       | 15.18 | 0.0  | 0.0        | 0.0  | 15.18       |
      | 4  | 15   | 20240215 |                 | 30.18           | 15.0          | 0.18     | 0.0  | 0.0       | 15.18 | 0.0  | 0.0        | 0.0  | 15.18       |
      | 5  | 15   | 20240301    |                 | 15.12           | 15.06         | 0.12     | 0.0  | 0.0       | 15.18 | 0.0  | 0.0        | 0.0  | 15.18       |
      | 6  | 15   | 20240316    |                 | 0.0             | 15.12         | 0.06     | 0.0  | 0.0       | 15.18 | 0.0  | 0.0        | 0.0  | 15.18       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      | 100.0         | 0.9      | 0.0  | 0.0       | 100.9 | 30.18 | 0.0        | 0.0  | 70.72       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240101  | Repayment        | 25.0   | 25.0      | 0.0      | 0.0  | 0.0       | 75.0         | false    | false    |
      | 20240116  | Repayment        | 10.0   | 10.0      | 0.0      | 0.0  | 0.0       | 65.0         | true     | false    |
      | 20240116  | Repayment        | 5.18   | 5.18      | 0.0      | 0.0  | 0.0       | 69.82        | false    | true     |

  @TestRailId:C3211
  Scenario: Verify the Pay-off transaction - UC1: 360/30, regular payment, preClosureInterestCalculationStrategy = till pre-close date
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
#    --- 1st installment paid on due date ---
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
#    --- Pay-off between 1st and 2nd installment ---
    When Admin sets the business date to "20240215"
    When Loan Pay-off is made on "20240215"
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101  |                  | 100.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 31   | 20240201 | 20240201 | 83.57           | 16.43         | 0.58     | 0.0  | 0.0       | 17.01 | 17.01 | 0.0        | 0.0  | 0.0         |
      | 2  | 29   | 20240301    | 20240215 | 66.8            | 16.77         | 0.24     | 0.0  | 0.0       | 17.01 | 17.01 | 17.01      | 0.0  | 0.0         |
      | 3  | 31   | 20240401    | 20240215 | 49.79           | 17.01         | 0.0      | 0.0  | 0.0       | 17.01 | 17.01 | 17.01      | 0.0  | 0.0         |
      | 4  | 30   | 20240501      | 20240215 | 32.78           | 17.01         | 0.0      | 0.0  | 0.0       | 17.01 | 17.01 | 17.01      | 0.0  | 0.0         |
      | 5  | 31   | 20240601     | 20240215 | 15.77           | 17.01         | 0.0      | 0.0  | 0.0       | 17.01 | 17.01 | 17.01      | 0.0  | 0.0         |
      | 6  | 30   | 20240701     | 20240215 | 0.0             | 15.77         | 0.0      | 0.0  | 0.0       | 15.77 | 15.77 | 15.77      | 0.0  | 0.0         |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late | Outstanding |
      | 100.0         | 0.82     | 0.0  | 0.0       | 100.82 | 100.82 | 83.81      | 0.0  | 0.0         |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240201 | Repayment        | 17.01  | 16.43     | 0.58     | 0.0  | 0.0       | 83.57        | false    | false    |
      | 20240215 | Repayment        | 83.81  | 83.57     | 0.24     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240215 | Accrual          | 0.82   | 0.0       | 0.82     | 0.0  | 0.0       | 0.0          | false    | false    |
    Then Loan's all installments have obligations met

  @TestRailId:C3212
  Scenario: Verify the Pay-off transaction - UC2: 360/30, regular payment, preClosureInterestCalculationStrategy = till rest frequency date
    When Admin sets the business date to "20240101"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                                   | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_EMI_360_30_INTEREST_RECALCULATION_DAILY_TILL_REST_FREQUENCY_DATE | 20240101   | 100            | 7                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 6                 | MONTHS                | 1              | MONTHS                 | 6                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
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
#    --- 1st installment paid on due date ---
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
#    --- Pay-off between 1st and 2nd installment ---
    When Admin sets the business date to "20240215"
    When Loan Pay-off is made on "20240215"
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101  |                  | 100.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 31   | 20240201 | 20240201 | 83.57           | 16.43         | 0.58     | 0.0  | 0.0       | 17.01 | 17.01 | 0.0        | 0.0  | 0.0         |
      | 2  | 29   | 20240301    | 20240215 | 67.05           | 16.52         | 0.49     | 0.0  | 0.0       | 17.01 | 17.01 | 17.01      | 0.0  | 0.0         |
      | 3  | 31   | 20240401    | 20240215 | 50.04           | 17.01         | 0.0      | 0.0  | 0.0       | 17.01 | 17.01 | 17.01      | 0.0  | 0.0         |
      | 4  | 30   | 20240501      | 20240215 | 33.03           | 17.01         | 0.0      | 0.0  | 0.0       | 17.01 | 17.01 | 17.01      | 0.0  | 0.0         |
      | 5  | 31   | 20240601     | 20240215 | 16.02           | 17.01         | 0.0      | 0.0  | 0.0       | 17.01 | 17.01 | 17.01      | 0.0  | 0.0         |
      | 6  | 30   | 20240701     | 20240215 | 0.0             | 16.02         | 0.0      | 0.0  | 0.0       | 16.02 | 16.02 | 16.02      | 0.0  | 0.0         |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late | Outstanding |
      | 100.0         | 1.07     | 0.0  | 0.0       | 101.07 | 101.07 | 84.06      | 0.0  | 0.0         |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240201 | Repayment        | 17.01  | 16.43     | 0.58     | 0.0  | 0.0       | 83.57        | false    | false    |
      | 20240215 | Repayment        | 84.06  | 83.57     | 0.49     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240215 | Accrual          | 1.07   | 0.0       | 1.07     | 0.0  | 0.0       | 0.0          | false    | false    |
    Then Loan's all installments have obligations met

  @TestRailId:C3213
  Scenario: Verify the Pay-off transaction - UC3: 360/30, pre-close on overdue loan, preClosureInterestCalculationStrategy = till pre-close date
    When Admin sets the business date to "20240101"
    When Admin creates a client with random data
    When Admin set "LP2_ADV_PYMNT_INTEREST_DAILY_EMI_360_30_INTEREST_RECALCULATION_DAILY_TILL_PRECLOSE" loan product "DEFAULT" transaction type to "NEXT_INSTALLMENT" future installment allocation rule
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
#    --- Pay-off between 1st and 2nd installment, 1st installment is overdue ---
    When Admin sets the business date to "20240215"
    When Loan Pay-off is made on "20240215"
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late  | Outstanding |
      |    |      | 20240101  |                  | 100.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |       |             |
      | 1  | 31   | 20240201 | 20240215 | 83.57           | 16.43         | 0.58     | 0.0  | 0.0       | 17.01 | 17.01 | 0.0        | 17.01 | 0.0         |
      | 2  | 29   | 20240301    | 20240215 | 66.84           | 16.73         | 0.28     | 0.0  | 0.0       | 17.01 | 17.01 | 17.01      | 0.0   | 0.0         |
      | 3  | 31   | 20240401    | 20240215 | 49.83           | 17.01         | 0.0      | 0.0  | 0.0       | 17.01 | 17.01 | 17.01      | 0.0   | 0.0         |
      | 4  | 30   | 20240501      | 20240215 | 32.82           | 17.01         | 0.0      | 0.0  | 0.0       | 17.01 | 17.01 | 17.01      | 0.0   | 0.0         |
      | 5  | 31   | 20240601     | 20240215 | 15.81           | 17.01         | 0.0      | 0.0  | 0.0       | 17.01 | 17.01 | 17.01      | 0.0   | 0.0         |
      | 6  | 30   | 20240701     | 20240215 | 0.0             | 15.81         | 0.0      | 0.0  | 0.0       | 15.81 | 15.81 | 15.81      | 0.0   | 0.0         |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late  | Outstanding |
      | 100.0         | 0.86     | 0.0  | 0.0       | 100.86 | 100.86 | 83.85      | 17.01 | 0.0         |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240215 | Repayment        | 100.86 | 100.0     | 0.86     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240215 | Accrual          | 0.86   | 0.0       | 0.86     | 0.0  | 0.0       | 0.0          | false    | false    |
    Then Loan's all installments have obligations met

  @TestRailId:C3214
  Scenario: Verify the Pay-off transaction - UC2: 360/30, pre-close on overdue loan, preClosureInterestCalculationStrategy = till rest frequency date
    When Admin sets the business date to "20240101"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                                   | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_EMI_360_30_INTEREST_RECALCULATION_DAILY_TILL_REST_FREQUENCY_DATE | 20240101   | 100            | 7                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 6                 | MONTHS                | 1              | MONTHS                 | 6                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
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
#    --- Pay-off between 1st and 2nd installment, 1st installment is overdue ---
    When Admin sets the business date to "20240215"
    And Customer makes "AUTOPAY" repayment on "20240215" with 101.16 EUR transaction amount
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late  | Outstanding |
      |    |      | 20240101  |                  | 100.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |       |             |
      | 1  | 31   | 20240201 | 20240215 | 83.57           | 16.43         | 0.58     | 0.0  | 0.0       | 17.01 | 17.01 | 0.0        | 17.01 | 0.0         |
      | 2  | 29   | 20240301    | 20240215 | 67.14           | 16.43         | 0.58     | 0.0  | 0.0       | 17.01 | 17.01 | 17.01      | 0.0   | 0.0         |
      | 3  | 31   | 20240401    | 20240215 | 50.13           | 17.01         | 0.0      | 0.0  | 0.0       | 17.01 | 17.01 | 17.01      | 0.0   | 0.0         |
      | 4  | 30   | 20240501      | 20240215 | 33.12           | 17.01         | 0.0      | 0.0  | 0.0       | 17.01 | 17.01 | 17.01      | 0.0   | 0.0         |
      | 5  | 31   | 20240601     | 20240215 | 16.11           | 17.01         | 0.0      | 0.0  | 0.0       | 17.01 | 17.01 | 17.01      | 0.0   | 0.0         |
      | 6  | 30   | 20240701     | 20240215 | 0.0             | 16.11         | 0.0      | 0.0  | 0.0       | 16.11 | 16.11 | 16.11      | 0.0   | 0.0         |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late  | Outstanding |
      | 100.0         | 1.16     | 0.0  | 0.0       | 101.16 | 101.16 | 84.15      | 17.01 | 0.0         |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240215 | Repayment        | 101.16 | 100.0     | 1.16     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240215 | Accrual          | 1.16   | 0.0       | 1.16     | 0.0  | 0.0       | 0.0          | false    | false    |
    Then Loan's all installments have obligations met

  @TestRailId:C3215
  Scenario: Verify the Loan reschedule - Interest modification - UC1: Interest modification on 1st installment due date (installment paid), effective from next day
    When Admin sets the business date to "20240101"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                             | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_EMI_360_30 | 20240101   | 100            | 7                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 6                 | MONTHS                | 1              | MONTHS                 | 6                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
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
    #    --- 1st installment paid on due date ---
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
#   --- Loan reschedule: Interest rate modification effective from next day ---
    When Admin creates and approves Loan reschedule with the following data:
      | rescheduleFromDate | submittedOnDate  | adjustedDueDate | graceOnPrincipal | graceOnInterest | extraTerms | newInterestRate |
      | 20240202   | 20240201 |                 |                  |                 |            | 4               |
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101  |                  | 100.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 31   | 20240201 | 20240201 | 83.57           | 16.43         | 0.58     | 0.0  | 0.0       | 17.01 | 17.01 | 0.0        | 0.0  | 0.0         |
      | 2  | 29   | 20240301    |                  | 66.97           | 16.6          | 0.28     | 0.0  | 0.0       | 16.88 | 0.0   | 0.0        | 0.0  | 16.88       |
      | 3  | 31   | 20240401    |                  | 50.31           | 16.66         | 0.22     | 0.0  | 0.0       | 16.88 | 0.0   | 0.0        | 0.0  | 16.88       |
      | 4  | 30   | 20240501      |                  | 33.6            | 16.71         | 0.17     | 0.0  | 0.0       | 16.88 | 0.0   | 0.0        | 0.0  | 16.88       |
      | 5  | 31   | 20240601     |                  | 16.83           | 16.77         | 0.11     | 0.0  | 0.0       | 16.88 | 0.0   | 0.0        | 0.0  | 16.88       |
      | 6  | 30   | 20240701     |                  | 0.0             | 16.83         | 0.06     | 0.0  | 0.0       | 16.89 | 0.0   | 0.0        | 0.0  | 16.89       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 100.0         | 1.42     | 0.0  | 0.0       | 101.42 | 17.01 | 0.0        | 0.0  | 84.41       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240201 | Repayment        | 17.01  | 16.43     | 0.58     | 0.0  | 0.0       | 83.57        | false    | false    |

  @TestRailId:C3216
  Scenario: Verify the Loan reschedule - Interest modification - UC2: Interest modification between 1st and 2nd installment due date (1st installment paid)
    When Admin sets the business date to "20240101"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                             | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_EMI_360_30 | 20240101   | 100            | 7                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 6                 | MONTHS                | 1              | MONTHS                 | 6                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
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
    #    --- 1st installment paid on due date ---
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
#   --- Loan reschedule: Interest rate modification between two installments ---
    When Admin sets the business date to "20240214"
    When Admin creates and approves Loan reschedule with the following data:
      | rescheduleFromDate | submittedOnDate  | adjustedDueDate | graceOnPrincipal | graceOnInterest | extraTerms | newInterestRate |
      | 20240215   | 20240214 |                 |                  |                 |            | 4               |
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101  |                  | 100.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 31   | 20240201 | 20240201 | 83.57           | 16.43         | 0.58     | 0.0  | 0.0       | 17.01 | 17.01 | 0.0        | 0.0  | 0.0         |
      | 2  | 29   | 20240301    |                  | 67.04           | 16.53         | 0.37     | 0.0  | 0.0       | 16.9  | 0.0   | 0.0        | 0.0  | 16.9        |
      | 3  | 31   | 20240401    |                  | 50.36           | 16.68         | 0.22     | 0.0  | 0.0       | 16.9  | 0.0   | 0.0        | 0.0  | 16.9        |
      | 4  | 30   | 20240501      |                  | 33.63           | 16.73         | 0.17     | 0.0  | 0.0       | 16.9  | 0.0   | 0.0        | 0.0  | 16.9        |
      | 5  | 31   | 20240601     |                  | 16.84           | 16.79         | 0.11     | 0.0  | 0.0       | 16.9  | 0.0   | 0.0        | 0.0  | 16.9        |
      | 6  | 30   | 20240701     |                  | 0.0             | 16.84         | 0.06     | 0.0  | 0.0       | 16.9  | 0.0   | 0.0        | 0.0  | 16.9        |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 100.0         | 1.51     | 0.0  | 0.0       | 101.51 | 17.01 | 0.0        | 0.0  | 84.5        |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240201 | Repayment        | 17.01  | 16.43     | 0.58     | 0.0  | 0.0       | 83.57        | false    | false    |

  @TestRailId:C3219
  Scenario: Verify Repayment schedule in case of 2nd disbursement (created on business date before 1st installment) is backdated to before 1st disbursement
    When Admin sets the business date to "20240101"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                       | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_EMI_360_30_MULTIDISBURSE_DOWNPAYMENT | 20240101   | 1000           | 12                     | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 6                 | MONTHS                | 1              | MONTHS                 | 6                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240101" with "1000" amount and expected disbursement date on "20240101"
    When Admin sets the business date to "20240105"
    When Admin successfully disburse the loan on "20240105" with "200" EUR transaction amount
    Then Loan Repayment schedule has 7 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20240105  |           | 200.0           |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 0    | 20240105  |           | 150.0           | 50.0          | 0.0      | 0.0  | 0.0       | 50.0  | 0.0  | 0.0        | 0.0  | 50.0        |
      | 2  | 31   | 20240205 |           | 125.62          | 24.38         | 1.5      | 0.0  | 0.0       | 25.88 | 0.0  | 0.0        | 0.0  | 25.88       |
      | 3  | 29   | 20240305    |           | 101.0           | 24.62         | 1.26     | 0.0  | 0.0       | 25.88 | 0.0  | 0.0        | 0.0  | 25.88       |
      | 4  | 31   | 20240405    |           | 76.13           | 24.87         | 1.01     | 0.0  | 0.0       | 25.88 | 0.0  | 0.0        | 0.0  | 25.88       |
      | 5  | 30   | 20240505      |           | 51.01           | 25.12         | 0.76     | 0.0  | 0.0       | 25.88 | 0.0  | 0.0        | 0.0  | 25.88       |
      | 6  | 31   | 20240605     |           | 25.64           | 25.37         | 0.51     | 0.0  | 0.0       | 25.88 | 0.0  | 0.0        | 0.0  | 25.88       |
      | 7  | 30   | 20240705     |           | 0.0             | 25.64         | 0.26     | 0.0  | 0.0       | 25.9  | 0.0  | 0.0        | 0.0  | 25.9        |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      | 200.0         | 5.3      | 0.0  | 0.0       | 205.3 | 0.0  | 0.0        | 0.0  | 205.3       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240105  | Disbursement     | 200.0  | 0.0       | 0.0      | 0.0  | 0.0       | 200.0        | false    | false    |
    When Admin sets the business date to "20240108"
    When Admin successfully disburse the loan on "20240103" with "350" EUR transaction amount
    Then Loan Repayment schedule has 8 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20240103  |           | 350.0           |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 0    | 20240103  |           | 262.5           | 87.5          | 0.0      | 0.0  | 0.0       | 87.5  | 0.0  | 0.0        | 0.0  | 87.5        |
      |    |      | 20240105  |           | 200.0           |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 2  | 0    | 20240105  |           | 412.5           | 50.0          | 0.0      | 0.0  | 0.0       | 50.0  | 0.0  | 0.0        | 0.0  | 50.0        |
      | 3  | 31   | 20240203 |           | 345.37          | 67.13         | 4.03     | 0.0  | 0.0       | 71.16 | 0.0  | 0.0        | 0.0  | 71.16       |
      | 4  | 29   | 20240303    |           | 277.66          | 67.71         | 3.45     | 0.0  | 0.0       | 71.16 | 0.0  | 0.0        | 0.0  | 71.16       |
      | 5  | 31   | 20240403    |           | 209.28          | 68.38         | 2.78     | 0.0  | 0.0       | 71.16 | 0.0  | 0.0        | 0.0  | 71.16       |
      | 6  | 30   | 20240503      |           | 140.21          | 69.07         | 2.09     | 0.0  | 0.0       | 71.16 | 0.0  | 0.0        | 0.0  | 71.16       |
      | 7  | 31   | 20240603     |           | 70.45           | 69.76         | 1.4      | 0.0  | 0.0       | 71.16 | 0.0  | 0.0        | 0.0  | 71.16       |
      | 8  | 30   | 20240703     |           | 0.0             | 70.45         | 0.7      | 0.0  | 0.0       | 71.15 | 0.0  | 0.0        | 0.0  | 71.15       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 550.0         | 14.45    | 0.0  | 0.0       | 564.45 | 0.0  | 0.0        | 0.0  | 564.45      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240103  | Disbursement     | 350.0  | 0.0       | 0.0      | 0.0  | 0.0       | 350.0        | false    | false    |
      | 20240105  | Disbursement     | 200.0  | 0.0       | 0.0      | 0.0  | 0.0       | 550.0        | false    | false    |

  @TestRailId:C3220
  Scenario: Verify Repayment schedule in case of 2nd disbursement (created on business date after unpaid 1st installment) is backdated to before 1st disbursement
    When Admin sets the business date to "20240101"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                       | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_EMI_360_30_MULTIDISBURSE_DOWNPAYMENT | 20240101   | 1000           | 12                     | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 6                 | MONTHS                | 1              | MONTHS                 | 6                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240101" with "1000" amount and expected disbursement date on "20240101"
    When Admin sets the business date to "20240105"
    When Admin successfully disburse the loan on "20240105" with "200" EUR transaction amount
    Then Loan Repayment schedule has 7 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20240105  |           | 200.0           |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 0    | 20240105  |           | 150.0           | 50.0          | 0.0      | 0.0  | 0.0       | 50.0  | 0.0  | 0.0        | 0.0  | 50.0        |
      | 2  | 31   | 20240205 |           | 125.62          | 24.38         | 1.5      | 0.0  | 0.0       | 25.88 | 0.0  | 0.0        | 0.0  | 25.88       |
      | 3  | 29   | 20240305    |           | 101.0           | 24.62         | 1.26     | 0.0  | 0.0       | 25.88 | 0.0  | 0.0        | 0.0  | 25.88       |
      | 4  | 31   | 20240405    |           | 76.13           | 24.87         | 1.01     | 0.0  | 0.0       | 25.88 | 0.0  | 0.0        | 0.0  | 25.88       |
      | 5  | 30   | 20240505      |           | 51.01           | 25.12         | 0.76     | 0.0  | 0.0       | 25.88 | 0.0  | 0.0        | 0.0  | 25.88       |
      | 6  | 31   | 20240605     |           | 25.64           | 25.37         | 0.51     | 0.0  | 0.0       | 25.88 | 0.0  | 0.0        | 0.0  | 25.88       |
      | 7  | 30   | 20240705     |           | 0.0             | 25.64         | 0.26     | 0.0  | 0.0       | 25.9  | 0.0  | 0.0        | 0.0  | 25.9        |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      | 200.0         | 5.3      | 0.0  | 0.0       | 205.3 | 0.0  | 0.0        | 0.0  | 205.3       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240105  | Disbursement     | 200.0  | 0.0       | 0.0      | 0.0  | 0.0       | 200.0        | false    | false    |
    When Admin sets the business date to "20240208"
    When Admin successfully disburse the loan on "20240103" with "350" EUR transaction amount
    Then Loan Repayment schedule has 8 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20240103  |           | 350.0           |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 0    | 20240103  |           | 262.5           | 87.5          | 0.0      | 0.0  | 0.0       | 87.5  | 0.0  | 0.0        | 0.0  | 87.5        |
      |    |      | 20240105  |           | 200.0           |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 2  | 0    | 20240105  |           | 412.5           | 50.0          | 0.0      | 0.0  | 0.0       | 50.0  | 0.0  | 0.0        | 0.0  | 50.0        |
      | 3  | 31   | 20240203 |           | 345.37          | 67.13         | 4.03     | 0.0  | 0.0       | 71.16 | 0.0  | 0.0        | 0.0  | 71.16       |
      | 4  | 29   | 20240303    |           | 277.66          | 67.71         | 3.45     | 0.0  | 0.0       | 71.16 | 0.0  | 0.0        | 0.0  | 71.16       |
      | 5  | 31   | 20240403    |           | 209.28          | 68.38         | 2.78     | 0.0  | 0.0       | 71.16 | 0.0  | 0.0        | 0.0  | 71.16       |
      | 6  | 30   | 20240503      |           | 140.21          | 69.07         | 2.09     | 0.0  | 0.0       | 71.16 | 0.0  | 0.0        | 0.0  | 71.16       |
      | 7  | 31   | 20240603     |           | 70.45           | 69.76         | 1.4      | 0.0  | 0.0       | 71.16 | 0.0  | 0.0        | 0.0  | 71.16       |
      | 8  | 30   | 20240703     |           | 0.0             | 70.45         | 0.7      | 0.0  | 0.0       | 71.15 | 0.0  | 0.0        | 0.0  | 71.15       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 550.0         | 14.45    | 0.0  | 0.0       | 564.45 | 0.0  | 0.0        | 0.0  | 564.45      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240103  | Disbursement     | 350.0  | 0.0       | 0.0      | 0.0  | 0.0       | 350.0        | false    | false    |
      | 20240105  | Disbursement     | 200.0  | 0.0       | 0.0      | 0.0  | 0.0       | 550.0        | false    | false    |

  @TestRailId:C3221
  Scenario: Verify Repayment schedule in case of 2nd disbursement (created on business date after unpaid 1st installment) is backdated to before 1st disbursement - downpayment paid
    When Admin sets the business date to "20240101"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                       | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_EMI_360_30_MULTIDISBURSE_DOWNPAYMENT | 20240101   | 1000           | 12                     | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 6                 | MONTHS                | 1              | MONTHS                 | 6                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240101" with "1000" amount and expected disbursement date on "20240101"
    When Admin sets the business date to "20240105"
    When Admin successfully disburse the loan on "20240105" with "200" EUR transaction amount
    And Customer makes "AUTOPAY" repayment on "20240105" with 50 EUR transaction amount
    Then Loan Repayment schedule has 7 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20240105  |                 | 200.0           |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 0    | 20240105  | 20240105 | 150.0           | 50.0          | 0.0      | 0.0  | 0.0       | 50.0  | 50.0 | 0.0        | 0.0  | 0.0         |
      | 2  | 31   | 20240205 |                 | 125.62          | 24.38         | 1.5      | 0.0  | 0.0       | 25.88 | 0.0  | 0.0        | 0.0  | 25.88       |
      | 3  | 29   | 20240305    |                 | 101.0           | 24.62         | 1.26     | 0.0  | 0.0       | 25.88 | 0.0  | 0.0        | 0.0  | 25.88       |
      | 4  | 31   | 20240405    |                 | 76.13           | 24.87         | 1.01     | 0.0  | 0.0       | 25.88 | 0.0  | 0.0        | 0.0  | 25.88       |
      | 5  | 30   | 20240505      |                 | 51.01           | 25.12         | 0.76     | 0.0  | 0.0       | 25.88 | 0.0  | 0.0        | 0.0  | 25.88       |
      | 6  | 31   | 20240605     |                 | 25.64           | 25.37         | 0.51     | 0.0  | 0.0       | 25.88 | 0.0  | 0.0        | 0.0  | 25.88       |
      | 7  | 30   | 20240705     |                 | 0.0             | 25.64         | 0.26     | 0.0  | 0.0       | 25.9  | 0.0  | 0.0        | 0.0  | 25.9        |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      | 200.0         | 5.3      | 0.0  | 0.0       | 205.3 | 50.0 | 0.0        | 0.0  | 155.3       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240105  | Disbursement     | 200.0  | 0.0       | 0.0      | 0.0  | 0.0       | 200.0        | false    | false    |
      | 20240105  | Repayment        | 50.0   | 50.0      | 0.0      | 0.0  | 0.0       | 150.0        | false    | false    |
    When Admin sets the business date to "20240208"
    When Admin successfully disburse the loan on "20240103" with "350" EUR transaction amount
    Then Loan Repayment schedule has 8 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20240103  |           | 350.0           |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 0    | 20240103  |           | 262.5           | 87.5          | 0.0      | 0.0  | 0.0       | 87.5  | 50.0 | 0.0        | 50.0 | 37.5        |
      |    |      | 20240105  |           | 200.0           |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 2  | 0    | 20240105  |           | 412.5           | 50.0          | 0.0      | 0.0  | 0.0       | 50.0  | 0.0  | 0.0        | 0.0  | 50.0        |
      | 3  | 31   | 20240203 |           | 345.37          | 67.13         | 4.03     | 0.0  | 0.0       | 71.16 | 0.0  | 0.0        | 0.0  | 71.16       |
      | 4  | 29   | 20240303    |           | 277.66          | 67.71         | 3.45     | 0.0  | 0.0       | 71.16 | 0.0  | 0.0        | 0.0  | 71.16       |
      | 5  | 31   | 20240403    |           | 209.28          | 68.38         | 2.78     | 0.0  | 0.0       | 71.16 | 0.0  | 0.0        | 0.0  | 71.16       |
      | 6  | 30   | 20240503      |           | 140.21          | 69.07         | 2.09     | 0.0  | 0.0       | 71.16 | 0.0  | 0.0        | 0.0  | 71.16       |
      | 7  | 31   | 20240603     |           | 70.45           | 69.76         | 1.4      | 0.0  | 0.0       | 71.16 | 0.0  | 0.0        | 0.0  | 71.16       |
      | 8  | 30   | 20240703     |           | 0.0             | 70.45         | 0.7      | 0.0  | 0.0       | 71.15 | 0.0  | 0.0        | 0.0  | 71.15       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 550.0         | 14.45    | 0.0  | 0.0       | 564.45 | 50.0 | 0.0        | 50.0 | 514.45      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240103  | Disbursement     | 350.0  | 0.0       | 0.0      | 0.0  | 0.0       | 350.0        | false    | false    |
      | 20240105  | Disbursement     | 200.0  | 0.0       | 0.0      | 0.0  | 0.0       | 550.0        | false    | false    |
      | 20240105  | Repayment        | 50.0   | 50.0      | 0.0      | 0.0  | 0.0       | 500.0        | false    | false    |

  @TestRailId:C3222
  Scenario: Verify Repayment schedule in case of 2nd disbursement (created on business date after paid 1st installment) is backdated to before 1st disbursement - downpayment paid
    When Admin sets the business date to "20240101"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                       | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_EMI_360_30_MULTIDISBURSE_DOWNPAYMENT | 20240101   | 1000           | 12                     | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 6                 | MONTHS                | 1              | MONTHS                 | 6                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240101" with "1000" amount and expected disbursement date on "20240101"
#    --- 1st disbursement ---
    When Admin sets the business date to "20240105"
    When Admin successfully disburse the loan on "20240105" with "200" EUR transaction amount
#    --- 1st disbursement downpayment paid ---
    And Customer makes "AUTOPAY" repayment on "20240105" with 50 EUR transaction amount
    Then Loan Repayment schedule has 7 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20240105  |                 | 200.0           |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 0    | 20240105  | 20240105 | 150.0           | 50.0          | 0.0      | 0.0  | 0.0       | 50.0  | 50.0 | 0.0        | 0.0  | 0.0         |
      | 2  | 31   | 20240205 |                 | 125.62          | 24.38         | 1.5      | 0.0  | 0.0       | 25.88 | 0.0  | 0.0        | 0.0  | 25.88       |
      | 3  | 29   | 20240305    |                 | 101.0           | 24.62         | 1.26     | 0.0  | 0.0       | 25.88 | 0.0  | 0.0        | 0.0  | 25.88       |
      | 4  | 31   | 20240405    |                 | 76.13           | 24.87         | 1.01     | 0.0  | 0.0       | 25.88 | 0.0  | 0.0        | 0.0  | 25.88       |
      | 5  | 30   | 20240505      |                 | 51.01           | 25.12         | 0.76     | 0.0  | 0.0       | 25.88 | 0.0  | 0.0        | 0.0  | 25.88       |
      | 6  | 31   | 20240605     |                 | 25.64           | 25.37         | 0.51     | 0.0  | 0.0       | 25.88 | 0.0  | 0.0        | 0.0  | 25.88       |
      | 7  | 30   | 20240705     |                 | 0.0             | 25.64         | 0.26     | 0.0  | 0.0       | 25.9  | 0.0  | 0.0        | 0.0  | 25.9        |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      | 200.0         | 5.3      | 0.0  | 0.0       | 205.3 | 50.0 | 0.0        | 0.0  | 155.3       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240105  | Disbursement     | 200.0  | 0.0       | 0.0      | 0.0  | 0.0       | 200.0        | false    | false    |
      | 20240105  | Repayment        | 50.0   | 50.0      | 0.0      | 0.0  | 0.0       | 150.0        | false    | false    |
#   --- 1st installment paid ---
    When Admin sets the business date to "20240205"
    And Customer makes "AUTOPAY" repayment on "20240205" with 25.88 EUR transaction amount
    Then Loan Repayment schedule has 7 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240105  |                  | 200.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 0    | 20240105  | 20240105  | 150.0           | 50.0          | 0.0      | 0.0  | 0.0       | 50.0  | 50.0  | 0.0        | 0.0  | 0.0         |
      | 2  | 31   | 20240205 | 20240205 | 125.62          | 24.38         | 1.5      | 0.0  | 0.0       | 25.88 | 25.88 | 0.0        | 0.0  | 0.0         |
      | 3  | 29   | 20240305    |                  | 101.0           | 24.62         | 1.26     | 0.0  | 0.0       | 25.88 | 0.0   | 0.0        | 0.0  | 25.88       |
      | 4  | 31   | 20240405    |                  | 76.13           | 24.87         | 1.01     | 0.0  | 0.0       | 25.88 | 0.0   | 0.0        | 0.0  | 25.88       |
      | 5  | 30   | 20240505      |                  | 51.01           | 25.12         | 0.76     | 0.0  | 0.0       | 25.88 | 0.0   | 0.0        | 0.0  | 25.88       |
      | 6  | 31   | 20240605     |                  | 25.64           | 25.37         | 0.51     | 0.0  | 0.0       | 25.88 | 0.0   | 0.0        | 0.0  | 25.88       |
      | 7  | 30   | 20240705     |                  | 0.0             | 25.64         | 0.26     | 0.0  | 0.0       | 25.9  | 0.0   | 0.0        | 0.0  | 25.9        |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      | 200.0         | 5.3      | 0.0  | 0.0       | 205.3 | 75.88 | 0.0        | 0.0  | 129.42      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240105  | Disbursement     | 200.0  | 0.0       | 0.0      | 0.0  | 0.0       | 200.0        | false    | false    |
      | 20240105  | Repayment        | 50.0   | 50.0      | 0.0      | 0.0  | 0.0       | 150.0        | false    | false    |
      | 20240205 | Repayment        | 25.88  | 24.38     | 1.5      | 0.0  | 0.0       | 125.62       | false    | false    |
#   --- Backdated second disbursement ---
    When Admin sets the business date to "20240208"
    When Admin successfully disburse the loan on "20240103" with "350" EUR transaction amount
    Then Loan Repayment schedule has 8 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late  | Outstanding |
      |    |      | 20240103  |           | 350.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |       |             |
      | 1  | 0    | 20240103  |           | 262.5           | 87.5          | 0.0      | 0.0  | 0.0       | 87.5  | 75.88 | 0.0        | 75.88 | 11.62       |
      |    |      | 20240105  |           | 200.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |       |             |
      | 2  | 0    | 20240105  |           | 412.5           | 50.0          | 0.0      | 0.0  | 0.0       | 50.0  | 0.0   | 0.0        | 0.0   | 50.0        |
      | 3  | 31   | 20240203 |           | 345.37          | 67.13         | 4.03     | 0.0  | 0.0       | 71.16 | 0.0   | 0.0        | 0.0   | 71.16       |
      | 4  | 29   | 20240303    |           | 277.66          | 67.71         | 3.45     | 0.0  | 0.0       | 71.16 | 0.0   | 0.0        | 0.0   | 71.16       |
      | 5  | 31   | 20240403    |           | 209.28          | 68.38         | 2.78     | 0.0  | 0.0       | 71.16 | 0.0   | 0.0        | 0.0   | 71.16       |
      | 6  | 30   | 20240503      |           | 140.21          | 69.07         | 2.09     | 0.0  | 0.0       | 71.16 | 0.0   | 0.0        | 0.0   | 71.16       |
      | 7  | 31   | 20240603     |           | 70.45           | 69.76         | 1.4      | 0.0  | 0.0       | 71.16 | 0.0   | 0.0        | 0.0   | 71.16       |
      | 8  | 30   | 20240703     |           | 0.0             | 70.45         | 0.7      | 0.0  | 0.0       | 71.15 | 0.0   | 0.0        | 0.0   | 71.15       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late  | Outstanding |
      | 550.0         | 14.45    | 0.0  | 0.0       | 564.45 | 75.88 | 0.0        | 75.88 | 488.57      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240103  | Disbursement     | 350.0  | 0.0       | 0.0      | 0.0  | 0.0       | 350.0        | false    | false    |
      | 20240105  | Disbursement     | 200.0  | 0.0       | 0.0      | 0.0  | 0.0       | 550.0        | false    | false    |
      | 20240105  | Repayment        | 50.0   | 50.0      | 0.0      | 0.0  | 0.0       | 500.0        | false    | false    |
      | 20240205 | Repayment        | 25.88  | 25.88     | 0.0      | 0.0  | 0.0       | 474.12       | false    | true     |

  @TestRailId:C3226
  Scenario: Verify interest recalculation in case of overdue installments: UC1 - 1st installment overdue, interest recalculation: daily, till preclose
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
#    --- 1st installment overdue ---
    When Admin sets the business date to "20240215"
    When Admin runs inline COB job for Loan
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20240101  |           | 100.0           |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 31   | 20240201 |           | 83.57           | 16.43         | 0.58     | 0.0  | 0.0       | 17.01 | 0.0  | 0.0        | 0.0  | 17.01       |
      | 2  | 29   | 20240301    |           | 67.09           | 16.48         | 0.53     | 0.0  | 0.0       | 17.01 | 0.0  | 0.0        | 0.0  | 17.01       |
      | 3  | 31   | 20240401    |           | 50.47           | 16.62         | 0.39     | 0.0  | 0.0       | 17.01 | 0.0  | 0.0        | 0.0  | 17.01       |
      | 4  | 30   | 20240501      |           | 33.75           | 16.72         | 0.29     | 0.0  | 0.0       | 17.01 | 0.0  | 0.0        | 0.0  | 17.01       |
      | 5  | 31   | 20240601     |           | 16.94           | 16.81         | 0.2      | 0.0  | 0.0       | 17.01 | 0.0  | 0.0        | 0.0  | 17.01       |
      | 6  | 30   | 20240701     |           | 0.0             | 16.94         | 0.1      | 0.0  | 0.0       | 17.04 | 0.0  | 0.0        | 0.0  | 17.04       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 100.0         | 2.09     | 0.0  | 0.0       | 102.09 | 0.0  | 0.0        | 0.0  | 102.09      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240214 | Accrual          | 0.84   | 0.0       | 0.84     | 0.0  | 0.0       | 0.0          | false    | false    |

  @TestRailId:C3227
  Scenario: Verify interest recalculation in case of overdue installments: UC2 - 1st installment overdue, interest recalculation: daily, till rest frequency date
    When Admin sets the business date to "20240101"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                                   | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_EMI_360_30_INTEREST_RECALCULATION_DAILY_TILL_REST_FREQUENCY_DATE | 20240101   | 100            | 7                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 6                 | MONTHS                | 1              | MONTHS                 | 6                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
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
#    --- 1st installment overdue ---
    When Admin sets the business date to "20240215"
    When Admin runs inline COB job for Loan
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20240101  |           | 100.0           |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 31   | 20240201 |           | 83.57           | 16.43         | 0.58     | 0.0  | 0.0       | 17.01 | 0.0  | 0.0        | 0.0  | 17.01       |
      | 2  | 29   | 20240301    |           | 67.09           | 16.48         | 0.53     | 0.0  | 0.0       | 17.01 | 0.0  | 0.0        | 0.0  | 17.01       |
      | 3  | 31   | 20240401    |           | 50.47           | 16.62         | 0.39     | 0.0  | 0.0       | 17.01 | 0.0  | 0.0        | 0.0  | 17.01       |
      | 4  | 30   | 20240501      |           | 33.75           | 16.72         | 0.29     | 0.0  | 0.0       | 17.01 | 0.0  | 0.0        | 0.0  | 17.01       |
      | 5  | 31   | 20240601     |           | 16.94           | 16.81         | 0.2      | 0.0  | 0.0       | 17.01 | 0.0  | 0.0        | 0.0  | 17.01       |
      | 6  | 30   | 20240701     |           | 0.0             | 16.94         | 0.1      | 0.0  | 0.0       | 17.04 | 0.0  | 0.0        | 0.0  | 17.04       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 100.0         | 2.09     | 0.0  | 0.0       | 102.09 | 0.0  | 0.0        | 0.0  | 102.09      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240214 | Accrual          | 0.84   | 0.0       | 0.84     | 0.0  | 0.0       | 0.0          | false    | false    |

  @TestRailId:C3228
  Scenario: Verify interest recalculation in case of overdue installments: UC3 - 1st installment overdue, interest recalculation: same as repayment period, till preclose
    When Admin sets the business date to "20240101"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                       | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_EMI_360_30_INTEREST_RECALCULATION_SARP_TILL_PRECLOSE | 20240101   | 100            | 7                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 6                 | MONTHS                | 1              | MONTHS                 | 6                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
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
#    --- 1st installment overdue ---
    When Admin sets the business date to "20240215"
    When Admin runs inline COB job for Loan
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20240101  |           | 100.0           |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 31   | 20240201 |           | 83.57           | 16.43         | 0.58     | 0.0  | 0.0       | 17.01 | 0.0  | 0.0        | 0.0  | 17.01       |
      | 2  | 29   | 20240301    |           | 67.09           | 16.48         | 0.53     | 0.0  | 0.0       | 17.01 | 0.0  | 0.0        | 0.0  | 17.01       |
      | 3  | 31   | 20240401    |           | 50.47           | 16.62         | 0.39     | 0.0  | 0.0       | 17.01 | 0.0  | 0.0        | 0.0  | 17.01       |
      | 4  | 30   | 20240501      |           | 33.75           | 16.72         | 0.29     | 0.0  | 0.0       | 17.01 | 0.0  | 0.0        | 0.0  | 17.01       |
      | 5  | 31   | 20240601     |           | 16.94           | 16.81         | 0.2      | 0.0  | 0.0       | 17.01 | 0.0  | 0.0        | 0.0  | 17.01       |
      | 6  | 30   | 20240701     |           | 0.0             | 16.94         | 0.1      | 0.0  | 0.0       | 17.04 | 0.0  | 0.0        | 0.0  | 17.04       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 100.0         | 2.09     | 0.0  | 0.0       | 102.09 | 0.0  | 0.0        | 0.0  | 102.09      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240214 | Accrual          | 0.84   | 0.0       | 0.84     | 0.0  | 0.0       | 0.0          | false    | false    |

  @TestRailId:C3229
  Scenario: Verify interest recalculation in case of overdue installments: UC4 - 1st installment overdue, interest recalculation: same as repayment period, till rest frequency date
    When Admin sets the business date to "20240101"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                                  | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_EMI_360_30_INTEREST_RECALCULATION_SARP_TILL_REST_FREQUENCY_DATE | 20240101   | 100            | 7                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 6                 | MONTHS                | 1              | MONTHS                 | 6                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
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
#    --- 1st installment overdue ---
    When Admin sets the business date to "20240215"
    When Admin runs inline COB job for Loan
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20240101  |           | 100.0           |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 31   | 20240201 |           | 83.57           | 16.43         | 0.58     | 0.0  | 0.0       | 17.01 | 0.0  | 0.0        | 0.0  | 17.01       |
      | 2  | 29   | 20240301    |           | 67.14           | 16.43         | 0.58     | 0.0  | 0.0       | 17.01 | 0.0  | 0.0        | 0.0  | 17.01       |
      | 3  | 31   | 20240401    |           | 50.52           | 16.62         | 0.39     | 0.0  | 0.0       | 17.01 | 0.0  | 0.0        | 0.0  | 17.01       |
      | 4  | 30   | 20240501      |           | 33.8            | 16.72         | 0.29     | 0.0  | 0.0       | 17.01 | 0.0  | 0.0        | 0.0  | 17.01       |
      | 5  | 31   | 20240601     |           | 16.99           | 16.81         | 0.2      | 0.0  | 0.0       | 17.01 | 0.0  | 0.0        | 0.0  | 17.01       |
      | 6  | 30   | 20240701     |           | 0.0             | 16.99         | 0.1      | 0.0  | 0.0       | 17.09 | 0.0  | 0.0        | 0.0  | 17.09       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 100.0         | 2.14     | 0.0  | 0.0       | 102.14 | 0.0  | 0.0        | 0.0  | 102.14      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240214 | Accrual          | 0.84   | 0.0       | 0.84     | 0.0  | 0.0       | 0.0          | false    | false    |

  @TestRailId:C3230
  Scenario: Verify interest recalculation in case of overdue installments: UC5 - 1st and 2nd installment overdue, interest recalculation: daily, till preclose
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
#    --- 1st and 2nd installment overdue ---
    When Admin sets the business date to "20240201"
    When Admin runs inline COB job for Loan
    When Admin sets the business date to "20240310"
    When Admin runs inline COB job for Loan
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20240101  |           | 100.0           |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 31   | 20240201 |           | 83.57           | 16.43         | 0.58     | 0.0  | 0.0       | 17.01 | 0.0  | 0.0        | 0.0  | 17.01       |
      | 2  | 29   | 20240301    |           | 67.14           | 16.43         | 0.58     | 0.0  | 0.0       | 17.01 | 0.0  | 0.0        | 0.0  | 17.01       |
      | 3  | 31   | 20240401    |           | 50.58           | 16.56         | 0.45     | 0.0  | 0.0       | 17.01 | 0.0  | 0.0        | 0.0  | 17.01       |
      | 4  | 30   | 20240501      |           | 33.87           | 16.71         | 0.3      | 0.0  | 0.0       | 17.01 | 0.0  | 0.0        | 0.0  | 17.01       |
      | 5  | 31   | 20240601     |           | 17.06           | 16.81         | 0.2      | 0.0  | 0.0       | 17.01 | 0.0  | 0.0        | 0.0  | 17.01       |
      | 6  | 30   | 20240701     |           | 0.0             | 17.06         | 0.1      | 0.0  | 0.0       | 17.16 | 0.0  | 0.0        | 0.0  | 17.16       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 100.0         | 2.21     | 0.0  | 0.0       | 102.21 | 0.0  | 0.0        | 0.0  | 102.21      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240131  | Accrual          | 0.56   | 0.0       | 0.56     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240201 | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240202 | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240203 | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240204 | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240205 | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240206 | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240207 | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240208 | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240209 | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240210 | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240211 | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240212 | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240213 | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240214 | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240215 | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240216 | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240217 | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240218 | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240219 | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240220 | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240221 | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240222 | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240223 | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240224 | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240225 | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240226 | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240227 | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240228 | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240229 | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240301    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240302    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240303    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240304    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240305    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240306    | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240307    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240308    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240309    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |

  @TestRailId:C3231
  Scenario: Verify interest recalculation in case of overdue installments: UC6 - 1st and 2nd installment overdue, interest recalculation: daily, till rest frequency date
    When Admin sets the business date to "20240101"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                                   | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_EMI_360_30_INTEREST_RECALCULATION_DAILY_TILL_REST_FREQUENCY_DATE | 20240101   | 100            | 7                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 6                 | MONTHS                | 1              | MONTHS                 | 6                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
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
#    --- 1st and 2nd installment overdue ---
    When Admin sets the business date to "20240201"
    When Admin runs inline COB job for Loan
    When Admin sets the business date to "20240310"
    When Admin runs inline COB job for Loan
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20240101  |           | 100.0           |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 31   | 20240201 |           | 83.57           | 16.43         | 0.58     | 0.0  | 0.0       | 17.01 | 0.0  | 0.0        | 0.0  | 17.01       |
      | 2  | 29   | 20240301    |           | 67.14           | 16.43         | 0.58     | 0.0  | 0.0       | 17.01 | 0.0  | 0.0        | 0.0  | 17.01       |
      | 3  | 31   | 20240401    |           | 50.58           | 16.56         | 0.45     | 0.0  | 0.0       | 17.01 | 0.0  | 0.0        | 0.0  | 17.01       |
      | 4  | 30   | 20240501      |           | 33.87           | 16.71         | 0.3      | 0.0  | 0.0       | 17.01 | 0.0  | 0.0        | 0.0  | 17.01       |
      | 5  | 31   | 20240601     |           | 17.06           | 16.81         | 0.2      | 0.0  | 0.0       | 17.01 | 0.0  | 0.0        | 0.0  | 17.01       |
      | 6  | 30   | 20240701     |           | 0.0             | 17.06         | 0.1      | 0.0  | 0.0       | 17.16 | 0.0  | 0.0        | 0.0  | 17.16       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 100.0         | 2.21     | 0.0  | 0.0       | 102.21 | 0.0  | 0.0        | 0.0  | 102.21      |
    Then Loan has 102.21 outstanding amount
    Then Loan has 2.21 interest outstanding amount
    Then Loan has 34.02 total overdue amount
    Then Loan has 1.16 total interest overdue amount
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240131  | Accrual          | 0.56   | 0.0       | 0.56     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240201 | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240202 | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240203 | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240204 | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240205 | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240206 | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240207 | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240208 | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240209 | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240210 | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240211 | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240212 | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240213 | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240214 | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240215 | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240216 | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240217 | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240218 | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240219 | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240220 | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240221 | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240222 | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240223 | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240224 | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240225 | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240226 | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240227 | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240228 | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240229 | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240301    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240302    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240303    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240304    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240305    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240306    | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240307    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240308    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240309    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |

  @TestRailId:C3232
  Scenario: Verify interest recalculation in case of overdue installments: UC7 - 1st and 2nd installment overdue, interest recalculation: same as repayment period, till preclose
    When Admin sets the business date to "20240101"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                       | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_EMI_360_30_INTEREST_RECALCULATION_SARP_TILL_PRECLOSE | 20240101   | 100            | 7                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 6                 | MONTHS                | 1              | MONTHS                 | 6                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
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
#    --- 1st and 2nd installment overdue ---
    When Admin sets the business date to "20240201"
    When Admin runs inline COB job for Loan
    When Admin sets the business date to "20240310"
    When Admin runs inline COB job for Loan
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20240101  |           | 100.0           |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 31   | 20240201 |           | 83.57           | 16.43         | 0.58     | 0.0  | 0.0       | 17.01 | 0.0  | 0.0        | 0.0  | 17.01       |
      | 2  | 29   | 20240301    |           | 67.14           | 16.43         | 0.58     | 0.0  | 0.0       | 17.01 | 0.0  | 0.0        | 0.0  | 17.01       |
      | 3  | 31   | 20240401    |           | 50.58           | 16.56         | 0.45     | 0.0  | 0.0       | 17.01 | 0.0  | 0.0        | 0.0  | 17.01       |
      | 4  | 30   | 20240501      |           | 33.87           | 16.71         | 0.3      | 0.0  | 0.0       | 17.01 | 0.0  | 0.0        | 0.0  | 17.01       |
      | 5  | 31   | 20240601     |           | 17.06           | 16.81         | 0.2      | 0.0  | 0.0       | 17.01 | 0.0  | 0.0        | 0.0  | 17.01       |
      | 6  | 30   | 20240701     |           | 0.0             | 17.06         | 0.1      | 0.0  | 0.0       | 17.16 | 0.0  | 0.0        | 0.0  | 17.16       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 100.0         | 2.21     | 0.0  | 0.0       | 102.21 | 0.0  | 0.0        | 0.0  | 102.21      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240131  | Accrual          | 0.56   | 0.0       | 0.56     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240201 | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240202 | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240203 | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240204 | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240205 | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240206 | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240207 | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240208 | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240209 | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240210 | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240211 | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240212 | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240213 | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240214 | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240215 | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240216 | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240217 | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240218 | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240219 | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240220 | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240221 | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240222 | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240223 | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240224 | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240225 | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240226 | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240227 | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240228 | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240229 | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240301    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240302    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240303    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240304    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240305    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240306    | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240307    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240308    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240309    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |

  @TestRailId:C3233
  Scenario: Verify interest recalculation in case of overdue installments: UC8 - 1st and 2nd installment overdue, interest recalculation: same as repayment period, till rest frequency date
    When Admin sets the business date to "20240101"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                                  | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_EMI_360_30_INTEREST_RECALCULATION_SARP_TILL_REST_FREQUENCY_DATE | 20240101   | 100            | 7                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 6                 | MONTHS                | 1              | MONTHS                 | 6                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
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
#    --- 1st and 2nd installment overdue ---
    When Admin sets the business date to "20240201"
    When Admin runs inline COB job for Loan
    When Admin sets the business date to "20240310"
    When Admin runs inline COB job for Loan
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20240101  |           | 100.0           |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 31   | 20240201 |           | 83.57           | 16.43         | 0.58     | 0.0  | 0.0       | 17.01 | 0.0  | 0.0        | 0.0  | 17.01       |
      | 2  | 29   | 20240301    |           | 67.14           | 16.43         | 0.58     | 0.0  | 0.0       | 17.01 | 0.0  | 0.0        | 0.0  | 17.01       |
      | 3  | 31   | 20240401    |           | 50.71           | 16.43         | 0.58     | 0.0  | 0.0       | 17.01 | 0.0  | 0.0        | 0.0  | 17.01       |
      | 4  | 30   | 20240501      |           | 34.0            | 16.71         | 0.3      | 0.0  | 0.0       | 17.01 | 0.0  | 0.0        | 0.0  | 17.01       |
      | 5  | 31   | 20240601     |           | 17.19           | 16.81         | 0.2      | 0.0  | 0.0       | 17.01 | 0.0  | 0.0        | 0.0  | 17.01       |
      | 6  | 30   | 20240701     |           | 0.0             | 17.19         | 0.1      | 0.0  | 0.0       | 17.29 | 0.0  | 0.0        | 0.0  | 17.29       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 100.0         | 2.34     | 0.0  | 0.0       | 102.34 | 0.0  | 0.0        | 0.0  | 102.34      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240131  | Accrual          | 0.56   | 0.0       | 0.56     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240201 | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240202 | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240203 | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240204 | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240205 | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240206 | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240207 | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240208 | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240209 | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240210 | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240211 | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240212 | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240213 | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240214 | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240215 | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240216 | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240217 | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240218 | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240219 | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240220 | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240221 | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240222 | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240223 | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240224 | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240225 | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240226 | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240227 | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240228 | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240229 | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240301    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240302    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240303    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240304    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240305    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240306    | Accrual          | 0.01   | 0.0       | 0.01     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240307    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240308    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240309    | Accrual          | 0.02   | 0.0       | 0.02     | 0.0  | 0.0       | 0.0          | false    | false    |

  @TestRailId:C3234
  Scenario: Verify interest recalculation in case of overdue installments: UC9 - 1st installment paid on due date, 2nd installment overdue, interest recalculation: daily, till preclose
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
#    --- 1st installment paid on due date ---
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
#  --- 2nd installment overdue ---
    When Admin sets the business date to "20240310"
    When Admin runs inline COB job for Loan
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101  |                  | 100.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 31   | 20240201 | 20240201 | 83.57           | 16.43         | 0.58     | 0.0  | 0.0       | 17.01 | 17.01 | 0.0        | 0.0  | 0.0         |
      | 2  | 29   | 20240301    |                  | 67.05           | 16.52         | 0.49     | 0.0  | 0.0       | 17.01 | 0.0   | 0.0        | 0.0  | 17.01       |
      | 3  | 31   | 20240401    |                  | 50.46           | 16.59         | 0.42     | 0.0  | 0.0       | 17.01 | 0.0   | 0.0        | 0.0  | 17.01       |
      | 4  | 30   | 20240501      |                  | 33.74           | 16.72         | 0.29     | 0.0  | 0.0       | 17.01 | 0.0   | 0.0        | 0.0  | 17.01       |
      | 5  | 31   | 20240601     |                  | 16.93           | 16.81         | 0.2      | 0.0  | 0.0       | 17.01 | 0.0   | 0.0        | 0.0  | 17.01       |
      | 6  | 30   | 20240701     |                  | 0.0             | 16.93         | 0.1      | 0.0  | 0.0       | 17.03 | 0.0   | 0.0        | 0.0  | 17.03       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 100.0         | 2.08     | 0.0  | 0.0       | 102.08 | 17.01 | 0.0        | 0.0  | 85.07       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240201 | Repayment        | 17.01  | 16.43     | 0.58     | 0.0  | 0.0       | 83.57        | false    | false    |
      | 20240309    | Accrual          | 1.2    | 0.0       | 1.2      | 0.0  | 0.0       | 0.0          | false    | false    |

  @TestRailId:C3235
  Scenario: Verify interest recalculation in case of overdue installments: UC10 - 1st installment paid on due date, 2nd installment overdue, interest recalculation: daily, till rest frequency date
    When Admin sets the business date to "20240101"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                                   | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_EMI_360_30_INTEREST_RECALCULATION_DAILY_TILL_REST_FREQUENCY_DATE | 20240101   | 100            | 7                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 6                 | MONTHS                | 1              | MONTHS                 | 6                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
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
#    --- 1st installment paid on due date ---
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
#  --- 2nd installment overdue ---
    When Admin sets the business date to "20240310"
    When Admin runs inline COB job for Loan
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101  |                  | 100.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 31   | 20240201 | 20240201 | 83.57           | 16.43         | 0.58     | 0.0  | 0.0       | 17.01 | 17.01 | 0.0        | 0.0  | 0.0         |
      | 2  | 29   | 20240301    |                  | 67.05           | 16.52         | 0.49     | 0.0  | 0.0       | 17.01 | 0.0   | 0.0        | 0.0  | 17.01       |
      | 3  | 31   | 20240401    |                  | 50.46           | 16.59         | 0.42     | 0.0  | 0.0       | 17.01 | 0.0   | 0.0        | 0.0  | 17.01       |
      | 4  | 30   | 20240501      |                  | 33.74           | 16.72         | 0.29     | 0.0  | 0.0       | 17.01 | 0.0   | 0.0        | 0.0  | 17.01       |
      | 5  | 31   | 20240601     |                  | 16.93           | 16.81         | 0.2      | 0.0  | 0.0       | 17.01 | 0.0   | 0.0        | 0.0  | 17.01       |
      | 6  | 30   | 20240701     |                  | 0.0             | 16.93         | 0.1      | 0.0  | 0.0       | 17.03 | 0.0   | 0.0        | 0.0  | 17.03       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 100.0         | 2.08     | 0.0  | 0.0       | 102.08 | 17.01 | 0.0        | 0.0  | 85.07       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240201 | Repayment        | 17.01  | 16.43     | 0.58     | 0.0  | 0.0       | 83.57        | false    | false    |
      | 20240309    | Accrual          | 1.2    | 0.0       | 1.2      | 0.0  | 0.0       | 0.0          | false    | false    |

  @TestRailId:C3236
  Scenario: Verify interest recalculation in case of overdue installments: UC11 - 1st installment paid on due date, 2nd installment overdue, interest recalculation: same as repayment period, till preclose
    When Admin sets the business date to "20240101"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                       | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_EMI_360_30_INTEREST_RECALCULATION_SARP_TILL_PRECLOSE | 20240101   | 100            | 7                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 6                 | MONTHS                | 1              | MONTHS                 | 6                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
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
#    --- 1st installment paid on due date ---
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
#  --- 2nd installment overdue ---
    When Admin sets the business date to "20240310"
    When Admin runs inline COB job for Loan
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101  |                  | 100.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 31   | 20240201 | 20240201 | 83.57           | 16.43         | 0.58     | 0.0  | 0.0       | 17.01 | 17.01 | 0.0        | 0.0  | 0.0         |
      | 2  | 29   | 20240301    |                  | 67.05           | 16.52         | 0.49     | 0.0  | 0.0       | 17.01 | 0.0   | 0.0        | 0.0  | 17.01       |
      | 3  | 31   | 20240401    |                  | 50.46           | 16.59         | 0.42     | 0.0  | 0.0       | 17.01 | 0.0   | 0.0        | 0.0  | 17.01       |
      | 4  | 30   | 20240501      |                  | 33.74           | 16.72         | 0.29     | 0.0  | 0.0       | 17.01 | 0.0   | 0.0        | 0.0  | 17.01       |
      | 5  | 31   | 20240601     |                  | 16.93           | 16.81         | 0.2      | 0.0  | 0.0       | 17.01 | 0.0   | 0.0        | 0.0  | 17.01       |
      | 6  | 30   | 20240701     |                  | 0.0             | 16.93         | 0.1      | 0.0  | 0.0       | 17.03 | 0.0   | 0.0        | 0.0  | 17.03       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 100.0         | 2.08     | 0.0  | 0.0       | 102.08 | 17.01 | 0.0        | 0.0  | 85.07       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240201 | Repayment        | 17.01  | 16.43     | 0.58     | 0.0  | 0.0       | 83.57        | false    | false    |
      | 20240309    | Accrual          | 1.2    | 0.0       | 1.2      | 0.0  | 0.0       | 0.0          | false    | false    |

