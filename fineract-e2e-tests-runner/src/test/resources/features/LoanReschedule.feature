@LoanRescheduleFeature
Feature: LoanReschedule

  @TestRailId:C2680
  Scenario: As a user I would like to see a loan changed event was triggered when the loan got rescheduled
    When Admin sets the business date to "20220701"
    When Admin creates a client with random data
    And Admin successfully creates a new customised Loan submitted on date: "20220701", with Principal: "5000", a loanTermFrequency: 1 months, and numberOfRepayments: 1
    And Admin successfully approves the loan on "20220701" with "5000" amount and expected disbursement date on "20220701"
    When Admin successfully disburse the loan on "20220701" with "5000" EUR transaction amount
    When Batch API call with steps: rescheduleLoan from "20220801" to "20220831" submitted on date: "20220701", approveReschedule on date: "20220701" runs with enclosingTransaction: "true"
    Then Loan Repayment schedule has 1 periods, with the following data for periods:
      | Nr | Days | Date           | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      |    |      | 20220701   |           | 5000.0          |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      | 1  | 61   | 20220831 |           | 0.0             | 5000.0        | 0.0      | 0.0  | 0.0       | 5000.0 | 0.0  | 0.0        | 0.0  | 5000.0      |

  @TestRailId:C2801
  Scenario: Verify that loan is rescheduled properly in case of: undo disbursement
    When Admin sets the business date to "20230701"
    When Admin creates a client with random data
    When Admin creates a new default Loan with date: "20230701"
    And Admin successfully approves the loan on "20230701" with "1000" amount and expected disbursement date on "20230701"
    And Admin successfully disburse the loan on "20230701" with "1000" EUR transaction amount
    Then Loan Repayment schedule has 1 periods, with the following data for periods:
      | Nr | Days | Date         | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      |    |      | 20230701 |           | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      | 1  | 30   | 20230731 |           | 0.0             | 1000.0        | 0.0      | 0.0  | 0.0       | 1000.0 | 0.0  | 0.0        | 0.0  | 1000.0      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due  | Paid | In advance | Late | Outstanding |
      | 1000          | 0        | 0    | 0         | 1000 | 0    | 0          | 0    | 1000        |
    When Admin sets the business date to "20230702"
    When Admin successfully undo disbursal
    Then Loan Repayment schedule has 1 periods, with the following data for periods:
      | Nr | Days | Date         | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      |    |      | 20230701 |           | 1000.0          |               |          | 0.0  |           | 0.0    |      |            |      | 0.0         |
      | 1  | 30   | 20230731 |           | 0.0             | 1000.0        | 0.0      | 0.0  | 0.0       | 1000.0 | 0.0  | 0.0        | 0.0  | 1000.0      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due  | Paid | In advance | Late | Outstanding |
      | 1000          | 0        | 0    | 0         | 1000 | 0    | 0          | 0    | 1000        |

  @TestRailId:C2802
  Scenario: Verify that loan is rescheduled properly in case of: multiple disbursement, second disbursement placed within payment period
    When Admin sets the business date to "20230701"
    When Admin creates a client with random data
    When Admin creates a new default Loan with date: "20230701"
    And Admin successfully approves the loan on "20230701" with "1000" amount and expected disbursement date on "20230701"
    And Admin successfully disburse the loan on "20230701" with "500" EUR transaction amount
    Then Loan Repayment schedule has 1 periods, with the following data for periods:
      | Nr | Days | Date         | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20230701 |           | 500.0           |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 30   | 20230731 |           | 0.0             | 500.0         | 0.0      | 0.0  | 0.0       | 500.0 | 0.0  | 0.0        | 0.0  | 500.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due | Paid | In advance | Late | Outstanding |
      | 500           | 0        | 0    | 0         | 500 | 0    | 0          | 0    | 500         |
    When Admin sets the business date to "20230710"
    And Admin successfully disburse the loan on "20230710" with "500" EUR transaction amount
    Then Loan Repayment schedule has 1 periods, with the following data for periods:
      | Nr | Days | Date         | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      |    |      | 20230701 |           | 500.0           |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      |    |      | 20230710 |           | 500.0           |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      | 1  | 30   | 20230731 |           | 0.0             | 1000.0        | 0.0      | 0.0  | 0.0       | 1000.0 | 0.0  | 0.0        | 0.0  | 1000.0      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due  | Paid | In advance | Late | Outstanding |
      | 1000          | 0        | 0    | 0         | 1000 | 0    | 0          | 0    | 1000        |

  @TestRailId:C2803
  Scenario: Verify that loan is rescheduled properly in case of: multiple disbursement, second disbursement placed after payment period
    When Admin sets the business date to "20230701"
    When Admin creates a client with random data
    When Admin creates a new default Loan with date: "20230701"
    And Admin successfully approves the loan on "20230701" with "1000" amount and expected disbursement date on "20230701"
    And Admin successfully disburse the loan on "20230701" with "500" EUR transaction amount
    Then Loan Repayment schedule has 1 periods, with the following data for periods:
      | Nr | Days | Date         | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20230701 |           | 500.0           |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 30   | 20230731 |           | 0.0             | 500.0         | 0.0      | 0.0  | 0.0       | 500.0 | 0.0  | 0.0        | 0.0  | 500.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due | Paid | In advance | Late | Outstanding |
      | 500           | 0        | 0    | 0         | 500 | 0    | 0          | 0    | 500         |
    When Admin sets the business date to "20230810"
    And Admin successfully disburse the loan on "20230810" with "500" EUR transaction amount
    Then Loan Repayment schedule has 2 periods, with the following data for periods:
      | Nr | Days | Date           | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20230701   |           | 500.0           |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 30   | 20230731   |           | 0.0             | 500.0         | 0.0      | 0.0  | 0.0       | 500.0 | 0.0  | 0.0        | 0.0  | 500.0       |
      |    |      | 20230810 |           | 500.0           |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 2  | 30   | 20230830 |           | 0.0             | 500.0         | 0.0      | 0.0  | 0.0       | 500.0 | 0.0  | 0.0        | 0.0  | 500.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due  | Paid | In advance | Late | Outstanding |
      | 1000          | 0        | 0    | 0         | 1000 | 0    | 0          | 0    | 1000        |
    When Admin successfully undo last disbursal
    Then Loan Repayment schedule has 1 periods, with the following data for periods:
      | Nr | Days | Date         | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20230701 |           | 500.0           |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 30   | 20230731 |           | 0.0             | 500.0         | 0.0      | 0.0  | 0.0       | 500.0 | 0.0  | 0.0        | 0.0  | 500.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due | Paid | In advance | Late | Outstanding |
      | 500           | 0        | 0    | 0         | 500 | 0    | 0          | 0    | 500         |

  @TestRailId:C2804
  Scenario: Verify that loan is rescheduled properly in case of: single installment, changing installment date
    When Admin sets the business date to "20230701"
    When Admin creates a client with random data
    When Admin creates a new default Loan with date: "20230701"
    And Admin successfully approves the loan on "20230701" with "1000" amount and expected disbursement date on "20230701"
    And Admin successfully disburse the loan on "20230701" with "1000" EUR transaction amount
    Then Loan Repayment schedule has 1 periods, with the following data for periods:
      | Nr | Days | Date         | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      |    |      | 20230701 |           | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      | 1  | 30   | 20230731 |           | 0.0             | 1000.0        | 0.0      | 0.0  | 0.0       | 1000.0 | 0.0  | 0.0        | 0.0  | 1000.0      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due  | Paid | In advance | Late | Outstanding |
      | 1000          | 0        | 0    | 0         | 1000 | 0    | 0          | 0    | 1000        |
    When Admin sets the business date to "20230705"
    When Admin creates and approves Loan reschedule with the following data:
      | rescheduleFromDate | submittedOnDate | adjustedDueDate | graceOnPrincipal | graceOnInterest | extraTerms | newInterestRate |
      | 20230731       | 20230705    | 20230831  |                  |                 |            |                 |
    Then Loan Repayment schedule has 1 periods, with the following data for periods:
      | Nr | Days | Date           | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      |    |      | 20230701   |           | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      | 1  | 61   | 20230831 |           | 0.0             | 1000.0        | 0.0      | 0.0  | 0.0       | 1000.0 | 0.0  | 0.0        | 0.0  | 1000.0      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due  | Paid | In advance | Late | Outstanding |
      | 1000          | 0        | 0    | 0         | 1000 | 0    | 0          | 0    | 1000        |

  @TestRailId:C2805
  Scenario: Verify that loan is rescheduled properly in case of: multiple installments, changing installment date
    When Admin sets the business date to "20230701"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy                        |
      | LP1         | 20230701      | 3000           | 0                      | DECLINING_BALANCE | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 3                 | MONTHS                | 1              | MONTHS                 | 3                  | 0                       | 0                      | 0                    | PENALTIES_FEES_INTEREST_PRINCIPAL_ORDER |
    And Admin successfully approves the loan on "20230701" with "3000" amount and expected disbursement date on "20230701"
    And Admin successfully disburse the loan on "20230701" with "3000" EUR transaction amount
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      |    |      | 20230701      |           | 3000.0          |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      | 1  | 31   | 20230801    |           | 2000.0          | 1000.0        | 0.0      | 0.0  | 0.0       | 1000.0 | 0.0  | 0.0        | 0.0  | 1000.0      |
      | 2  | 31   | 20230901 |           | 1000.0          | 1000.0        | 0.0      | 0.0  | 0.0       | 1000.0 | 0.0  | 0.0        | 0.0  | 1000.0      |
      | 3  | 30   | 20231001   |           | 0.0             | 1000.0        | 0.0      | 0.0  | 0.0       | 1000.0 | 0.0  | 0.0        | 0.0  | 1000.0      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due  | Paid | In advance | Late | Outstanding |
      | 3000          | 0        | 0    | 0         | 3000 | 0    | 0          | 0    | 3000        |
    When Admin sets the business date to "20230705"
    When Admin creates and approves Loan reschedule with the following data:
      | rescheduleFromDate | submittedOnDate | adjustedDueDate   | graceOnPrincipal | graceOnInterest | extraTerms | newInterestRate |
      | 20230901  | 20230705    | 20230915 |                  |                 |            |                 |
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      |    |      | 20230701      |           | 3000.0          |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      | 1  | 31   | 20230801    |           | 2000.0          | 1000.0        | 0.0      | 0.0  | 0.0       | 1000.0 | 0.0  | 0.0        | 0.0  | 1000.0      |
      | 2  | 45   | 20230915 |           | 1000.0          | 1000.0        | 0.0      | 0.0  | 0.0       | 1000.0 | 0.0  | 0.0        | 0.0  | 1000.0      |
      | 3  | 30   | 20231015   |           | 0.0             | 1000.0        | 0.0      | 0.0  | 0.0       | 1000.0 | 0.0  | 0.0        | 0.0  | 1000.0      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due  | Paid | In advance | Late | Outstanding |
      | 3000          | 0        | 0    | 0         | 3000 | 0    | 0          | 0    | 3000        |

  @TestRailId:C2806
  Scenario: Verify that loan is rescheduled properly in case of: multiple installments, extending repayment schedule
    When Admin sets the business date to "20230701"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy                        |
      | LP1         | 20230701      | 3000           | 0                      | DECLINING_BALANCE | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 3                 | MONTHS                | 1              | MONTHS                 | 3                  | 0                       | 0                      | 0                    | PENALTIES_FEES_INTEREST_PRINCIPAL_ORDER |
    And Admin successfully approves the loan on "20230701" with "3000" amount and expected disbursement date on "20230701"
    And Admin successfully disburse the loan on "20230701" with "3000" EUR transaction amount
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      |    |      | 20230701      |           | 3000.0          |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      | 1  | 31   | 20230801    |           | 2000.0          | 1000.0        | 0.0      | 0.0  | 0.0       | 1000.0 | 0.0  | 0.0        | 0.0  | 1000.0      |
      | 2  | 31   | 20230901 |           | 1000.0          | 1000.0        | 0.0      | 0.0  | 0.0       | 1000.0 | 0.0  | 0.0        | 0.0  | 1000.0      |
      | 3  | 30   | 20231001   |           | 0.0             | 1000.0        | 0.0      | 0.0  | 0.0       | 1000.0 | 0.0  | 0.0        | 0.0  | 1000.0      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due  | Paid | In advance | Late | Outstanding |
      | 3000          | 0        | 0    | 0         | 3000 | 0    | 0          | 0    | 3000        |
    When Admin sets the business date to "20230705"
    When Admin creates and approves Loan reschedule with the following data:
      | rescheduleFromDate | submittedOnDate | adjustedDueDate | graceOnPrincipal | graceOnInterest | extraTerms | newInterestRate |
      | 20230901  | 20230705    |                 |                  |                 | 2          |                 |
    Then Loan Repayment schedule has 5 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      |    |      | 20230701      |           | 3000.0          |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      | 1  | 31   | 20230801    |           | 2000.0          | 1000.0        | 0.0      | 0.0  | 0.0       | 1000.0 | 0.0  | 0.0        | 0.0  | 1000.0      |
      | 2  | 31   | 20230901 |           | 1500.0          | 500.0         | 0.0      | 0.0  | 0.0       | 500.0  | 0.0  | 0.0        | 0.0  | 500.0       |
      | 3  | 30   | 20231001   |           | 1000.0          | 500.0         | 0.0      | 0.0  | 0.0       | 500.0  | 0.0  | 0.0        | 0.0  | 500.0       |
      | 4  | 31   | 20231101  |           | 500.0           | 500.0         | 0.0      | 0.0  | 0.0       | 500.0  | 0.0  | 0.0        | 0.0  | 500.0       |
      | 5  | 30   | 20231201  |           | 0.0             | 500.0         | 0.0      | 0.0  | 0.0       | 500.0  | 0.0  | 0.0        | 0.0  | 500.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due  | Paid | In advance | Late | Outstanding |
      | 3000          | 0        | 0    | 0         | 3000 | 0    | 0          | 0    | 3000        |

  @TestRailId:C2807
  Scenario: Verify that loan is rescheduled properly in case of: multiple installments, mid-term grace period on principal
    When Admin sets the business date to "20230701"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy                        |
      | LP1         | 20230701      | 3000           | 0                      | DECLINING_BALANCE | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 3                 | MONTHS                | 1              | MONTHS                 | 3                  | 0                       | 0                      | 0                    | PENALTIES_FEES_INTEREST_PRINCIPAL_ORDER |
    And Admin successfully approves the loan on "20230701" with "3000" amount and expected disbursement date on "20230701"
    And Admin successfully disburse the loan on "20230701" with "3000" EUR transaction amount
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      |    |      | 20230701      |           | 3000.0          |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      | 1  | 31   | 20230801    |           | 2000.0          | 1000.0        | 0.0      | 0.0  | 0.0       | 1000.0 | 0.0  | 0.0        | 0.0  | 1000.0      |
      | 2  | 31   | 20230901 |           | 1000.0          | 1000.0        | 0.0      | 0.0  | 0.0       | 1000.0 | 0.0  | 0.0        | 0.0  | 1000.0      |
      | 3  | 30   | 20231001   |           | 0.0             | 1000.0        | 0.0      | 0.0  | 0.0       | 1000.0 | 0.0  | 0.0        | 0.0  | 1000.0      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due  | Paid | In advance | Late | Outstanding |
      | 3000          | 0        | 0    | 0         | 3000 | 0    | 0          | 0    | 3000        |
    When Admin sets the business date to "20230705"
    When Admin creates and approves Loan reschedule with the following data:
      | rescheduleFromDate | submittedOnDate | adjustedDueDate | graceOnPrincipal | graceOnInterest | extraTerms | newInterestRate |
      | 20230901  | 20230705    |                 | 1                |                 |            |                 |
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date    | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      |    |      | 20230701      |              | 3000.0          |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      | 1  | 31   | 20230801    |              | 2000.0          | 1000.0        | 0.0      | 0.0  | 0.0       | 1000.0 | 0.0  | 0.0        | 0.0  | 1000.0      |
      | 2  | 31   | 20230901 | 20230701 | 2000.0          | 0.0           | 0.0      | 0.0  | 0.0       | 0.0    | 0.0  | 0.0        | 0.0  | 0.0         |
      | 3  | 30   | 20231001   |              | 1000.0          | 1000.0        | 0.0      | 0.0  | 0.0       | 1000.0 | 0.0  | 0.0        | 0.0  | 1000.0      |
      | 4  | 31   | 20231101  |              | 0.0             | 1000.0        | 0.0      | 0.0  | 0.0       | 1000.0 | 0.0  | 0.0        | 0.0  | 1000.0      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due  | Paid | In advance | Late | Outstanding |
      | 3000          | 0        | 0    | 0         | 3000 | 0    | 0          | 0    | 3000        |

  @TestRailId:C2808
  Scenario: Verify that loan is rescheduled properly in case of: multiple installments, mid-term grace period on interest
    When Admin sets the business date to "20230701"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct       | submitted on date | with Principal | ANNUAL interest rate % | interest type | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy                        |
      | LP1_INTEREST_FLAT | 20230701      | 4000           | 12                     | FLAT          | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 4                 | MONTHS                | 1              | MONTHS                 | 4                  | 0                       | 0                      | 0                    | PENALTIES_FEES_INTEREST_PRINCIPAL_ORDER |
    And Admin successfully approves the loan on "20230701" with "4000" amount and expected disbursement date on "20230701"
    And Admin successfully disburse the loan on "20230701" with "4000" EUR transaction amount
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      |    |      | 20230701      |           | 4000.0          |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      | 1  | 31   | 20230801    |           | 3000.0          | 1000.0        | 40.0     | 0.0  | 0.0       | 1040.0 | 0.0  | 0.0        | 0.0  | 1040.0      |
      | 2  | 31   | 20230901 |           | 2000.0          | 1000.0        | 40.0     | 0.0  | 0.0       | 1040.0 | 0.0  | 0.0        | 0.0  | 1040.0      |
      | 3  | 30   | 20231001   |           | 1000.0          | 1000.0        | 40.0     | 0.0  | 0.0       | 1040.0 | 0.0  | 0.0        | 0.0  | 1040.0      |
      | 4  | 31   | 20231101  |           | 0.0             | 1000.0        | 40.0     | 0.0  | 0.0       | 1040.0 | 0.0  | 0.0        | 0.0  | 1040.0      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due  | Paid | In advance | Late | Outstanding |
      | 4000          | 160      | 0    | 0         | 4160 | 0    | 0          | 0    | 4160        |
    When Admin sets the business date to "20230705"
    When Admin creates and approves Loan reschedule with the following data:
      | rescheduleFromDate | submittedOnDate | adjustedDueDate | graceOnPrincipal | graceOnInterest | extraTerms | newInterestRate |
      | 20230901  | 20230705    |                 |                  | 2               |            |                 |
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      |    |      | 20230701      |           | 4000.0          |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      | 1  | 31   | 20230801    |           | 3000.0          | 1000.0        | 40.0     | 0.0  | 0.0       | 1040.0 | 0.0  | 0.0        | 0.0  | 1040.0      |
      | 2  | 31   | 20230901 |           | 2000.0          | 1000.0        | 0.0      | 0.0  | 0.0       | 1000.0 | 0.0  | 0.0        | 0.0  | 1000.0      |
      | 3  | 30   | 20231001   |           | 1000.0          | 1000.0        | 0.0      | 0.0  | 0.0       | 1000.0 | 0.0  | 0.0        | 0.0  | 1000.0      |
      | 4  | 31   | 20231101  |           | 0.0             | 1000.0        | 120.0    | 0.0  | 0.0       | 1120.0 | 0.0  | 0.0        | 0.0  | 1120.0      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due  | Paid | In advance | Late | Outstanding |
      | 4000          | 160      | 0    | 0         | 4160 | 0    | 0          | 0    | 4160        |

  @TestRailId:C2809
  Scenario: Verify that loan is rescheduled properly in case of: multiple installments, new interest rate
    When Admin sets the business date to "20230701"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct       | submitted on date | with Principal | ANNUAL interest rate % | interest type | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy                        |
      | LP1_INTEREST_FLAT | 20230701      | 3000           | 12                     | FLAT          | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 3                 | MONTHS                | 1              | MONTHS                 | 3                  | 0                       | 0                      | 0                    | PENALTIES_FEES_INTEREST_PRINCIPAL_ORDER |
    And Admin successfully approves the loan on "20230701" with "3000" amount and expected disbursement date on "20230701"
    And Admin successfully disburse the loan on "20230701" with "3000" EUR transaction amount
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      |    |      | 20230701      |           | 3000.0          |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      | 1  | 31   | 20230801    |           | 2000.0          | 1000.0        | 30.0     | 0.0  | 0.0       | 1030.0 | 0.0  | 0.0        | 0.0  | 1030.0      |
      | 2  | 31   | 20230901 |           | 1000.0          | 1000.0        | 30.0     | 0.0  | 0.0       | 1030.0 | 0.0  | 0.0        | 0.0  | 1030.0      |
      | 3  | 30   | 20231001   |           | 0.0             | 1000.0        | 30.0     | 0.0  | 0.0       | 1030.0 | 0.0  | 0.0        | 0.0  | 1030.0      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due  | Paid | In advance | Late | Outstanding |
      | 3000          | 90       | 0    | 0         | 3090 | 0    | 0          | 0    | 3090        |
    When Admin sets the business date to "20230705"
    When Admin creates and approves Loan reschedule with the following data:
      | rescheduleFromDate | submittedOnDate | adjustedDueDate | graceOnPrincipal | graceOnInterest | extraTerms | newInterestRate |
      | 20230901  | 20230705    |                 |                  |                 |            | 6               |
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      |    |      | 20230701      |           | 3000.0          |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      | 1  | 31   | 20230801    |           | 2000.0          | 1000.0        | 30.0     | 0.0  | 0.0       | 1030.0 | 0.0  | 0.0        | 0.0  | 1030.0      |
      | 2  | 31   | 20230901 |           | 1000.0          | 1000.0        | 15.0     | 0.0  | 0.0       | 1015.0 | 0.0  | 0.0        | 0.0  | 1015.0      |
      | 3  | 30   | 20231001   |           | 0.0             | 1000.0        | 15.0     | 0.0  | 0.0       | 1015.0 | 0.0  | 0.0        | 0.0  | 1015.0      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due  | Paid | In advance | Late | Outstanding |
      | 3000          | 60       | 0    | 0         | 3060 | 0    | 0          | 0    | 3060        |
    Then LoanRescheduledDueAdjustScheduleBusinessEvent is raised on "20230705"

  @TestRailId:C2996
  Scenario: Verify that reschedule: add extra terms working properly with auto downpayment
    When Admin sets the business date to "20231001"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct          | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy                                                             |
      | LP2_DOWNPAYMENT_AUTO | 20231001   | 1000           | 0                      | DECLINING_BALANCE | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 45                | DAYS                  | 15             | DAYS                   | 3                  | 0                       | 0                      | 0                    | DUE_PENALTY_INTEREST_PRINCIPAL_FEE_IN_ADVANCE_PENALTY_INTEREST_PRINCIPAL_FEE |
    And Admin successfully approves the loan on "20231001" with "1000" amount and expected disbursement date on "20231001"
    When Admin successfully disburse the loan on "20231001" with "1000" EUR transaction amount
    When Admin creates and approves Loan reschedule with the following data:
      | rescheduleFromDate | submittedOnDate | adjustedDueDate | graceOnPrincipal | graceOnInterest | extraTerms | newInterestRate |
      | 20231016    | 20231001 |                 |                  |                 | 2          |                 |
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20231001  |                 | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 0    | 20231001  | 20231001 | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0  | 0.0         |
      | 2  | 15   | 20231016  |                 | 600.0           | 150.0         | 0.0      | 0.0  | 0.0       | 150.0 | 0.0   | 0.0        | 0.0  | 150.0       |
      | 3  | 15   | 20231031  |                 | 450.0           | 150.0         | 0.0      | 0.0  | 0.0       | 150.0 | 0.0   | 0.0        | 0.0  | 150.0       |
      | 4  | 15   | 20231115 |                 | 300.0           | 150.0         | 0.0      | 0.0  | 0.0       | 150.0 | 0.0   | 0.0        | 0.0  | 150.0       |
      | 5  | 15   | 20231130 |                 | 150.0           | 150.0         | 0.0      | 0.0  | 0.0       | 150.0 | 0.0   | 0.0        | 0.0  | 150.0       |
      | 6  | 15   | 20231215 |                 | 0.0             | 150.0         | 0.0      | 0.0  | 0.0       | 150.0 | 0.0   | 0.0        | 0.0  | 150.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 1000.0        | 0.0      | 0.0  | 0.0       | 1000.0 | 250.0 | 0.0        | 0.0  | 750.0       |

  @TestRailId:C2997
  Scenario: Verify that reschedule: add extra terms working properly with auto downpayment and 2nd disbursement before reschedule
    When Admin sets the business date to "20231001"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct          | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy                                                             |
      | LP2_DOWNPAYMENT_AUTO | 20231001   | 1000           | 0                      | DECLINING_BALANCE | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 45                | DAYS                  | 15             | DAYS                   | 3                  | 0                       | 0                      | 0                    | DUE_PENALTY_INTEREST_PRINCIPAL_FEE_IN_ADVANCE_PENALTY_INTEREST_PRINCIPAL_FEE |
    And Admin successfully approves the loan on "20231001" with "1000" amount and expected disbursement date on "20231001"
    When Admin successfully disburse the loan on "20231001" with "1000" EUR transaction amount
    When Admin sets the business date to "20231010"
    When Admin successfully disburse the loan on "20231010" with "400" EUR transaction amount
    When Admin sets the business date to "20231011"
    When Admin creates and approves Loan reschedule with the following data:
      | rescheduleFromDate | submittedOnDate | adjustedDueDate | graceOnPrincipal | graceOnInterest | extraTerms | newInterestRate |
      | 20231016    | 20231001 |                 |                  |                 | 2          |                 |
    Then Loan Repayment schedule has 7 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20231001  |                 | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 0    | 20231001  | 20231001 | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0  | 0.0         |
      |    |      | 20231010  |                 | 400.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 2  | 0    | 20231010  | 20231010 | 1050.0          | 100.0         | 0.0      | 0.0  | 0.0       | 100.0 | 100.0 | 0.0        | 0.0  | 0.0         |
      | 3  | 15   | 20231016  |                 | 840.0           | 210.0         | 0.0      | 0.0  | 0.0       | 210.0 | 0.0   | 0.0        | 0.0  | 210.0       |
      | 4  | 15   | 20231031  |                 | 630.0           | 210.0         | 0.0      | 0.0  | 0.0       | 210.0 | 0.0   | 0.0        | 0.0  | 210.0       |
      | 5  | 15   | 20231115 |                 | 420.0           | 210.0         | 0.0      | 0.0  | 0.0       | 210.0 | 0.0   | 0.0        | 0.0  | 210.0       |
      | 6  | 15   | 20231130 |                 | 210.0           | 210.0         | 0.0      | 0.0  | 0.0       | 210.0 | 0.0   | 0.0        | 0.0  | 210.0       |
      | 7  | 15   | 20231215 |                 | 0.0             | 210.0         | 0.0      | 0.0  | 0.0       | 210.0 | 0.0   | 0.0        | 0.0  | 210.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 1400.0        | 0.0      | 0.0  | 0.0       | 1400.0 | 350.0 | 0.0        | 0.0  | 1050.0      |

  @TestRailId:C2998
  Scenario: Verify that reschedule: add extra terms working properly with auto downpayment and 2nd disbursement after reschedule and first installment
    When Admin sets the business date to "20231001"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct          | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy                                                             |
      | LP2_DOWNPAYMENT_AUTO | 20231001   | 1000           | 0                      | DECLINING_BALANCE | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 45                | DAYS                  | 15             | DAYS                   | 3                  | 0                       | 0                      | 0                    | DUE_PENALTY_INTEREST_PRINCIPAL_FEE_IN_ADVANCE_PENALTY_INTEREST_PRINCIPAL_FEE |
    And Admin successfully approves the loan on "20231001" with "1000" amount and expected disbursement date on "20231001"
    When Admin successfully disburse the loan on "20231001" with "1000" EUR transaction amount
    When Admin sets the business date to "20231011"
    When Admin creates and approves Loan reschedule with the following data:
      | rescheduleFromDate | submittedOnDate | adjustedDueDate | graceOnPrincipal | graceOnInterest | extraTerms | newInterestRate |
      | 20231016    | 20231001 |                 |                  |                 | 2          |                 |
    When Admin sets the business date to "20231020"
    When Admin successfully disburse the loan on "20231020" with "400" EUR transaction amount
    Then Loan Repayment schedule has 7 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late  | Outstanding |
      |    |      | 20231001  |                 | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |       |             |
      | 1  | 0    | 20231001  | 20231001 | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0   | 0.0         |
      | 2  | 15   | 20231016  |                 | 540.0           | 210.0         | 0.0      | 0.0  | 0.0       | 210.0 | 100.0 | 0.0        | 100.0 | 110.0       |
      |    |      | 20231020  |                 | 400.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |       |             |
      | 3  | 0    | 20231020  |                 | 840.0           | 100.0         | 0.0      | 0.0  | 0.0       | 100.0 | 0.0   | 0.0        | 0.0   | 100.0       |
      | 4  | 15   | 20231031  |                 | 630.0           | 210.0         | 0.0      | 0.0  | 0.0       | 210.0 | 0.0   | 0.0        | 0.0   | 210.0       |
      | 5  | 15   | 20231115 |                 | 420.0           | 210.0         | 0.0      | 0.0  | 0.0       | 210.0 | 0.0   | 0.0        | 0.0   | 210.0       |
      | 6  | 15   | 20231130 |                 | 210.0           | 210.0         | 0.0      | 0.0  | 0.0       | 210.0 | 0.0   | 0.0        | 0.0   | 210.0       |
      | 7  | 15   | 20231215 |                 | 0.0             | 210.0         | 0.0      | 0.0  | 0.0       | 210.0 | 0.0   | 0.0        | 0.0   | 210.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late  | Outstanding |
      | 1400.0        | 0.0      | 0.0  | 0.0       | 1400.0 | 350.0 | 0.0        | 100.0 | 1050.0      |

  @TestRailId:C3022
  Scenario: Verify that Payment Holiday (Reschedule with adjustedDueDate) works properly in case of loan schedule adjusted by 1 installment period after successful downpayment
    When Admin sets the business date to "20231001"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct          | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy                                                             |
      | LP2_DOWNPAYMENT_AUTO | 20231001   | 1000           | 0                      | DECLINING_BALANCE | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 45                | DAYS                  | 15             | DAYS                   | 3                  | 0                       | 0                      | 0                    | DUE_PENALTY_INTEREST_PRINCIPAL_FEE_IN_ADVANCE_PENALTY_INTEREST_PRINCIPAL_FEE |
    And Admin successfully approves the loan on "20231001" with "1000" amount and expected disbursement date on "20231001"
    When Admin successfully disburse the loan on "20231001" with "1000" EUR transaction amount
    When Admin sets the business date to "20231005"
    When Admin creates and approves Loan reschedule with the following data:
      | rescheduleFromDate | submittedOnDate | adjustedDueDate | graceOnPrincipal | graceOnInterest | extraTerms | newInterestRate |
      | 20231016    | 20231005 | 20231031 |                  |                 |            |                 |
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20231001  |                 | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 0    | 20231001  | 20231001 | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0  | 0.0         |
      | 2  | 30   | 20231031  |                 | 500.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0   | 0.0        | 0.0  | 250.0       |
      | 3  | 15   | 20231115 |                 | 250.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0   | 0.0        | 0.0  | 250.0       |
      | 4  | 15   | 20231130 |                 | 0.0             | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0   | 0.0        | 0.0  | 250.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 1000.0        | 0.0      | 0.0  | 0.0       | 1000.0 | 250.0 | 0.0        | 0.0  | 750.0       |

  @TestRailId:C3023
  Scenario: Verify that Payment Holiday (Reschedule with adjustedDueDate) works properly in case of loan schedule adjusted by 2 installment period after successful downpayment
    When Admin sets the business date to "20231001"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct          | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy                                                             |
      | LP2_DOWNPAYMENT_AUTO | 20231001   | 1000           | 0                      | DECLINING_BALANCE | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 45                | DAYS                  | 15             | DAYS                   | 3                  | 0                       | 0                      | 0                    | DUE_PENALTY_INTEREST_PRINCIPAL_FEE_IN_ADVANCE_PENALTY_INTEREST_PRINCIPAL_FEE |
    And Admin successfully approves the loan on "20231001" with "1000" amount and expected disbursement date on "20231001"
    When Admin successfully disburse the loan on "20231001" with "1000" EUR transaction amount
    When Admin sets the business date to "20231005"
    When Admin creates and approves Loan reschedule with the following data:
      | rescheduleFromDate | submittedOnDate | adjustedDueDate  | graceOnPrincipal | graceOnInterest | extraTerms | newInterestRate |
      | 20231016    | 20231005 | 20231115 |                  |                 |            |                 |
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20231001  |                 | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 0    | 20231001  | 20231001 | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0  | 0.0         |
      | 2  | 45   | 20231115 |                 | 500.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0   | 0.0        | 0.0  | 250.0       |
      | 3  | 15   | 20231130 |                 | 250.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0   | 0.0        | 0.0  | 250.0       |
      | 4  | 15   | 20231215 |                 | 0.0             | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0   | 0.0        | 0.0  | 250.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 1000.0        | 0.0      | 0.0  | 0.0       | 1000.0 | 250.0 | 0.0        | 0.0  | 750.0       |

  @TestRailId:C3024
  Scenario: Verify that Payment Holiday (Reschedule with adjustedDueDate) works properly in case of loan schedule adjusted by 2 installment period while downpayment is still due
    When Admin sets the business date to "20231001"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct     | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy                                                             |
      | LP2_DOWNPAYMENT | 20231001   | 1000           | 0                      | DECLINING_BALANCE | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 45                | DAYS                  | 15             | DAYS                   | 3                  | 0                       | 0                      | 0                    | DUE_PENALTY_INTEREST_PRINCIPAL_FEE_IN_ADVANCE_PENALTY_INTEREST_PRINCIPAL_FEE |
    And Admin successfully approves the loan on "20231001" with "1000" amount and expected disbursement date on "20231001"
    When Admin successfully disburse the loan on "20231001" with "1000" EUR transaction amount
    When Admin sets the business date to "20231005"
    When Admin creates and approves Loan reschedule with the following data:
      | rescheduleFromDate | submittedOnDate | adjustedDueDate  | graceOnPrincipal | graceOnInterest | extraTerms | newInterestRate |
      | 20231016    | 20231005 | 20231115 |                  |                 |            |                 |
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20231001  |           | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 0    | 20231001  |           | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0  | 0.0        | 0.0  | 250.0       |
      | 2  | 45   | 20231115 |           | 500.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0  | 0.0        | 0.0  | 250.0       |
      | 3  | 15   | 20231130 |           | 250.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0  | 0.0        | 0.0  | 250.0       |
      | 4  | 15   | 20231215 |           | 0.0             | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0  | 0.0        | 0.0  | 250.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 1000.0        | 0.0      | 0.0  | 0.0       | 1000.0 | 0.0  | 0.0        | 0.0  | 1000.0      |

  @TestRailId:C3025
  Scenario: Verify that Payment Holiday (Reschedule with adjustedDueDate) works properly in case of loan schedule adjusted by 1 installment period after downpayment was reverted, fee added and downpayment paid by autopayment
    When Admin sets the business date to "20231001"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct     | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy                                                             |
      | LP2_DOWNPAYMENT | 20231001   | 1000           | 0                      | DECLINING_BALANCE | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 45                | DAYS                  | 15             | DAYS                   | 3                  | 0                       | 0                      | 0                    | DUE_PENALTY_INTEREST_PRINCIPAL_FEE_IN_ADVANCE_PENALTY_INTEREST_PRINCIPAL_FEE |
    And Admin successfully approves the loan on "20231001" with "1000" amount and expected disbursement date on "20231001"
    When Admin successfully disburse the loan on "20231001" with "1000" EUR transaction amount
    And Customer makes "AUTOPAY" repayment on "20231001" with 250 EUR transaction amount
    When Admin sets the business date to "20231002"
    When Customer undo "1"th repayment on "20231001"
    When Admin adds "LOAN_NSF_FEE" due date charge with "20231016" due date and 15 EUR transaction amount
    When Admin sets the business date to "20231003"
    And Customer makes "AUTOPAY" repayment on "20231003" with 250 EUR transaction amount
    When Admin sets the business date to "20231005"
    When Admin creates and approves Loan reschedule with the following data:
      | rescheduleFromDate | submittedOnDate | adjustedDueDate | graceOnPrincipal | graceOnInterest | extraTerms | newInterestRate |
      | 20231016    | 20231005 | 20231031 |                  |                 |            |                 |
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late  | Outstanding |
      |    |      | 20231001  |                 | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |       |             |
      | 1  | 0    | 20231001  | 20231003 | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 250.0 | 0.0         |
      | 2  | 30   | 20231031  |                 | 500.0           | 250.0         | 0.0      | 0.0  | 15.0      | 265.0 | 0.0   | 0.0        | 0.0   | 265.0       |
      | 3  | 15   | 20231115 |                 | 250.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0   | 0.0        | 0.0   | 250.0       |
      | 4  | 15   | 20231130 |                 | 0.0             | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0   | 0.0        | 0.0   | 250.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late  | Outstanding |
      | 1000.0        | 0.0      | 0.0  | 15.0      | 1015.0 | 250.0 | 0.0        | 250.0 | 765.0       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20231001  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       | false    |
      | 20231001  | Repayment        | 250.0  | 250.0     | 0.0      | 0.0  | 0.0       | 750.0        | true     |
      | 20231003  | Repayment        | 250.0  | 250.0     | 0.0      | 0.0  | 0.0       | 750.0        | false    |

  @TestRailId:C3026
  Scenario: Verify that Payment Holiday (Reschedule with adjustedDueDate) works properly in case of auto downpayment
    When Admin sets the business date to "20231001"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct          | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy                                                             |
      | LP2_DOWNPAYMENT_AUTO | 20231001   | 1000           | 0                      | DECLINING_BALANCE | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 45                | DAYS                  | 15             | DAYS                   | 3                  | 0                       | 0                      | 0                    | DUE_PENALTY_INTEREST_PRINCIPAL_FEE_IN_ADVANCE_PENALTY_INTEREST_PRINCIPAL_FEE |
    And Admin successfully approves the loan on "20231001" with "1000" amount and expected disbursement date on "20231001"
    When Admin successfully disburse the loan on "20231001" with "1000" EUR transaction amount
    When Admin creates and approves Loan reschedule with the following data:
      | rescheduleFromDate | submittedOnDate | adjustedDueDate | graceOnPrincipal | graceOnInterest | extraTerms | newInterestRate |
      | 20231016    | 20231001 | 20231031 |                  |                 |            |                 |
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20231001  |                 | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 0    | 20231001  | 20231001 | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0  | 0.0         |
      | 2  | 30   | 20231031  |                 | 500.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0   | 0.0        | 0.0  | 250.0       |
      | 3  | 15   | 20231115 |                 | 250.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0   | 0.0        | 0.0  | 250.0       |
      | 4  | 15   | 20231130 |                 | 0.0             | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0   | 0.0        | 0.0  | 250.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 1000.0        | 0.0      | 0.0  | 0.0       | 1000.0 | 250.0 | 0.0        | 0.0  | 750.0       |

  @TestRailId:C3027
  Scenario: Verify that Payment Holiday (Reschedule with adjustedDueDate) works properly in case of auto downpayment and 2nd disbursement before reschedule
    When Admin sets the business date to "20231001"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct          | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy                                                             |
      | LP2_DOWNPAYMENT_AUTO | 20231001   | 1000           | 0                      | DECLINING_BALANCE | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 45                | DAYS                  | 15             | DAYS                   | 3                  | 0                       | 0                      | 0                    | DUE_PENALTY_INTEREST_PRINCIPAL_FEE_IN_ADVANCE_PENALTY_INTEREST_PRINCIPAL_FEE |
    And Admin successfully approves the loan on "20231001" with "1000" amount and expected disbursement date on "20231001"
    When Admin successfully disburse the loan on "20231001" with "1000" EUR transaction amount
    When Admin sets the business date to "20231010"
    When Admin successfully disburse the loan on "20231010" with "400" EUR transaction amount
    When Admin sets the business date to "20231011"
    When Admin creates and approves Loan reschedule with the following data:
      | rescheduleFromDate | submittedOnDate | adjustedDueDate | graceOnPrincipal | graceOnInterest | extraTerms | newInterestRate |
      | 20231016    | 20231001 | 20231031 |                  |                 |            |                 |
    Then Loan Repayment schedule has 5 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20231001  |                 | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 0    | 20231001  | 20231001 | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0  | 0.0         |
      |    |      | 20231010  |                 | 400.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 2  | 0    | 20231010  | 20231010 | 1050.0          | 100.0         | 0.0      | 0.0  | 0.0       | 100.0 | 100.0 | 0.0        | 0.0  | 0.0         |
      | 3  | 30   | 20231031  |                 | 700.0           | 350.0         | 0.0      | 0.0  | 0.0       | 350.0 | 0.0   | 0.0        | 0.0  | 350.0       |
      | 4  | 15   | 20231115 |                 | 350.0           | 350.0         | 0.0      | 0.0  | 0.0       | 350.0 | 0.0   | 0.0        | 0.0  | 350.0       |
      | 5  | 15   | 20231130 |                 | 0.0             | 350.0         | 0.0      | 0.0  | 0.0       | 350.0 | 0.0   | 0.0        | 0.0  | 350.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 1400.0        | 0.0      | 0.0  | 0.0       | 1400.0 | 350.0 | 0.0        | 0.0  | 1050.0      |

  @TestRailId:C3028
  Scenario: Verify that Payment Holiday (Reschedule with adjustedDueDate) works properly in case of loan schedule adjusted by 1 installment period and 2 extra terms
    When Admin sets the business date to "20231001"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct          | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy                                                             |
      | LP2_DOWNPAYMENT_AUTO | 20231001   | 1000           | 0                      | DECLINING_BALANCE | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 45                | DAYS                  | 15             | DAYS                   | 3                  | 0                       | 0                      | 0                    | DUE_PENALTY_INTEREST_PRINCIPAL_FEE_IN_ADVANCE_PENALTY_INTEREST_PRINCIPAL_FEE |
    And Admin successfully approves the loan on "20231001" with "1000" amount and expected disbursement date on "20231001"
    When Admin successfully disburse the loan on "20231001" with "1000" EUR transaction amount
    When Admin sets the business date to "20231005"
    When Admin creates and approves Loan reschedule with the following data:
      | rescheduleFromDate | submittedOnDate | adjustedDueDate | graceOnPrincipal | graceOnInterest | extraTerms | newInterestRate |
      | 20231016    | 20231005 | 20231031 |                  |                 | 2          |                 |
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20231001  |                 | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 0    | 20231001  | 20231001 | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0  | 0.0         |
      | 2  | 30   | 20231031  |                 | 600.0           | 150.0         | 0.0      | 0.0  | 0.0       | 150.0 | 0.0   | 0.0        | 0.0  | 150.0       |
      | 3  | 15   | 20231115 |                 | 450.0           | 150.0         | 0.0      | 0.0  | 0.0       | 150.0 | 0.0   | 0.0        | 0.0  | 150.0       |
      | 4  | 15   | 20231130 |                 | 300.0           | 150.0         | 0.0      | 0.0  | 0.0       | 150.0 | 0.0   | 0.0        | 0.0  | 150.0       |
      | 5  | 15   | 20231215 |                 | 150.0           | 150.0         | 0.0      | 0.0  | 0.0       | 150.0 | 0.0   | 0.0        | 0.0  | 150.0       |
      | 6  | 15   | 20231230 |                 | 0.0             | 150.0         | 0.0      | 0.0  | 0.0       | 150.0 | 0.0   | 0.0        | 0.0  | 150.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 1000.0        | 0.0      | 0.0  | 0.0       | 1000.0 | 250.0 | 0.0        | 0.0  | 750.0       |

  @TestRailId:C3029
  Scenario: Verify that Payment Holiday (Reschedule with adjustedDueDate) works properly in case of loan schedule adjusted by 1 installment period and 1 grace on principal
    When Admin sets the business date to "20231001"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct          | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy                                                             |
      | LP2_DOWNPAYMENT_AUTO | 20231001   | 1000           | 0                      | DECLINING_BALANCE | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 45                | DAYS                  | 15             | DAYS                   | 3                  | 0                       | 0                      | 0                    | DUE_PENALTY_INTEREST_PRINCIPAL_FEE_IN_ADVANCE_PENALTY_INTEREST_PRINCIPAL_FEE |
    And Admin successfully approves the loan on "20231001" with "1000" amount and expected disbursement date on "20231001"
    When Admin successfully disburse the loan on "20231001" with "1000" EUR transaction amount
    When Admin sets the business date to "20231005"
    When Admin creates and approves Loan reschedule with the following data:
      | rescheduleFromDate | submittedOnDate | adjustedDueDate | graceOnPrincipal | graceOnInterest | extraTerms | newInterestRate |
      | 20231016    | 20231005 | 20231031 | 1                |                 |            |                 |
    Then Loan Repayment schedule has 5 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20231001  |                 | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 0    | 20231001  | 20231001 | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0  | 0.0         |
      | 2  | 30   | 20231031  | 20231001 | 750.0           | 0.0           | 0.0      | 0.0  | 0.0       | 0.0   | 0.0   | 0.0        | 0.0  | 0.0         |
      | 3  | 15   | 20231115 |                 | 500.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0   | 0.0        | 0.0  | 250.0       |
      | 4  | 15   | 20231130 |                 | 250.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0   | 0.0        | 0.0  | 250.0       |
      | 5  | 15   | 20231215 |                 | 0.0             | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0   | 0.0        | 0.0  | 250.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 1000.0        | 0.0      | 0.0  | 0.0       | 1000.0 | 250.0 | 0.0        | 0.0  | 750.0       |

  @TestRailId:C3030
  Scenario: Verify that Payment Holiday (Reschedule with adjustedDueDate) gives error in case of charged-off loan
    When Admin sets the business date to "20231001"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct          | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy                                                             |
      | LP2_DOWNPAYMENT_AUTO | 20231001   | 1000           | 0                      | DECLINING_BALANCE | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 45                | DAYS                  | 15             | DAYS                   | 3                  | 0                       | 0                      | 0                    | DUE_PENALTY_INTEREST_PRINCIPAL_FEE_IN_ADVANCE_PENALTY_INTEREST_PRINCIPAL_FEE |
    And Admin successfully approves the loan on "20231001" with "1000" amount and expected disbursement date on "20231001"
    When Admin successfully disburse the loan on "20231001" with "1000" EUR transaction amount
    When Admin sets the business date to "20231003"
    And Admin does charge-off the loan on "20231003"
    When Admin sets the business date to "20231005"
    Then Loan reschedule with the following data results a 403 error and "LOAN_CHARGED_OFF" error message
      | rescheduleFromDate | submittedOnDate | adjustedDueDate | graceOnPrincipal | graceOnInterest | extraTerms | newInterestRate |
      | 20231016    | 20231005 | 20231031 | 0                | 0               | 0          | 0               |

  @TestRailId:C3033
  Scenario: Verify that reschedule keeps the N+1 installment
    When Admin sets the business date to "20231001"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct     | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy                                                             |
      | LP2_DOWNPAYMENT | 20231001   | 1000           | 0                      | DECLINING_BALANCE | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 45                | DAYS                  | 15             | DAYS                   | 3                  | 0                       | 0                      | 0                    | DUE_PENALTY_INTEREST_PRINCIPAL_FEE_IN_ADVANCE_PENALTY_INTEREST_PRINCIPAL_FEE |
    And Admin successfully approves the loan on "20231001" with "1000" amount and expected disbursement date on "20231001"
    When Admin successfully disburse the loan on "20231001" with "1000" EUR transaction amount
    When Admin adds "LOAN_NSF_FEE" due date charge with "20231217" due date and 20 EUR transaction amount
    Then Loan Repayment schedule has 5 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20231001  |           | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 0    | 20231001  |           | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0  | 0.0        | 0.0  | 250.0       |
      | 2  | 15   | 20231016  |           | 500.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0  | 0.0        | 0.0  | 250.0       |
      | 3  | 15   | 20231031  |           | 250.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0  | 0.0        | 0.0  | 250.0       |
      | 4  | 15   | 20231115 |           | 0.0             | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0  | 0.0        | 0.0  | 250.0       |
      | 5  | 32   | 20231217 |           | 0.0             | 0.0           | 0.0      | 0.0  | 20.0      | 20.0  | 0.0  | 0.0        | 0.0  | 20.0        |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 1000.0        | 0.0      | 0.0  | 20.0      | 1020.0 | 0.0  | 0.0        | 0.0  | 1020.0      |
    When Admin sets the business date to "20231005"
    When Admin creates and approves Loan reschedule with the following data:
      | rescheduleFromDate | submittedOnDate | adjustedDueDate | graceOnPrincipal | graceOnInterest | extraTerms | newInterestRate |
      | 20231016    | 20231005 | 20231031 |                  |                 |            |                 |
    Then Loan Repayment schedule has 5 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20231001  |           | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 0    | 20231001  |           | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0  | 0.0        | 0.0  | 250.0       |
      | 2  | 30   | 20231031  |           | 500.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0  | 0.0        | 0.0  | 250.0       |
      | 3  | 15   | 20231115 |           | 250.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0  | 0.0        | 0.0  | 250.0       |
      | 4  | 15   | 20231130 |           | 0.0             | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0  | 0.0        | 0.0  | 250.0       |
      | 5  | 17   | 20231217 |           | 0.0             | 0.0           | 0.0      | 0.0  | 20.0      | 20.0  | 0.0  | 0.0        | 0.0  | 20.0        |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 1000.0        | 0.0      | 0.0  | 20.0      | 1020.0 | 0.0  | 0.0        | 0.0  | 1020.0      |

  @TestRailId:C3045 @AdvancedPaymentAllocation
  Scenario: Verify that inline COB execution is taking place in case of a BatchAPI request of Loan reschedule creation and approval
    When Admin sets the business date to "20240101"
    When Admin creates a client with random data
    When Admin set "LP2_DOWNPAYMENT_AUTO_ADVANCED_PAYMENT_ALLOCATION" loan product "DEFAULT" transaction type to "NEXT_INSTALLMENT" future installment allocation rule
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                      | submitted on date | with Principal | ANNUAL interest rate % | interest type | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_DOWNPAYMENT_AUTO_ADVANCED_PAYMENT_ALLOCATION | 20240101   | 1000           | 0                      | FLAT          | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 45                | DAYS                  | 15             | DAYS                   | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240101" with "1000" amount and expected disbursement date on "20240101"
    When Admin successfully disburse the loan on "20240101" with "1000" EUR transaction amount
    When Admin sets the business date to "20240102"
    When Admin runs inline COB job for Loan
    When Admin creates new user with "NO_BYPASS_AUTOTEST" username, "NO_BYPASS_AUTOTEST_ROLE" role name and given permissions:
      | APPROVE_RESCHEDULELOAN |
      | CREATE_RESCHEDULELOAN  |
      | READ_RESCHEDULELOAN    |
      | REJECT_RESCHEDULELOAN  |
    When Admin sets the business date to "20240110"
    When Batch API call with created user and with steps: rescheduleLoan from "20240116" to "20240131" submitted on date: "20240110", approveReschedule on date: "20240110" runs with enclosingTransaction: "true"
    Then Admin checks that last closed business date of loan is "20240109"

  @TestRailId:C3048 @AdvancedPaymentAllocation
  Scenario: Verify that in case of Loan is hard locked for COB execution WITH error message, BatchAPI request of Loan reschedule creation and approval can be done
    When Admin sets the business date to "20240101"
    When Admin creates a client with random data
    When Admin set "LP2_DOWNPAYMENT_AUTO_ADVANCED_PAYMENT_ALLOCATION" loan product "DEFAULT" transaction type to "NEXT_INSTALLMENT" future installment allocation rule
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                      | submitted on date | with Principal | ANNUAL interest rate % | interest type | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_DOWNPAYMENT_AUTO_ADVANCED_PAYMENT_ALLOCATION | 20240101   | 1000           | 0                      | FLAT          | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 45                | DAYS                  | 15             | DAYS                   | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240101" with "1000" amount and expected disbursement date on "20240101"
    When Admin successfully disburse the loan on "20240101" with "1000" EUR transaction amount
    When Admin sets the business date to "20240102"
    When Admin runs inline COB job for Loan
    When Admin sets the business date to "20240110"
    When Admin places a lock on loan account with an error message
    When Admin creates new user with "NO_BYPASS_AUTOTEST" username, "NO_BYPASS_AUTOTEST_ROLE" role name and given permissions:
      | APPROVE_RESCHEDULELOAN |
      | CREATE_RESCHEDULELOAN  |
      | READ_RESCHEDULELOAN    |
      | REJECT_RESCHEDULELOAN  |
    When Batch API call with created user and with steps: rescheduleLoan from "20240116" to "20240131" submitted on date: "20240110", approveReschedule on date: "20240110" runs with enclosingTransaction: "true"

  @TestRailId:C3049 @AdvancedPaymentAllocation
  Scenario: Verify that in case of Loan is hard locked for COB execution with error message, BatchAPI request of Loan reschedule creation and approval will result a 200 statuscode without error message
    When Admin sets the business date to "20240101"
    When Admin creates a client with random data
    When Admin set "LP2_DOWNPAYMENT_AUTO_ADVANCED_PAYMENT_ALLOCATION" loan product "DEFAULT" transaction type to "NEXT_INSTALLMENT" future installment allocation rule
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                      | submitted on date | with Principal | ANNUAL interest rate % | interest type | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_DOWNPAYMENT_AUTO_ADVANCED_PAYMENT_ALLOCATION | 20240101   | 1000           | 0                      | FLAT          | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 45                | DAYS                  | 15             | DAYS                   | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240101" with "1000" amount and expected disbursement date on "20240101"
    When Admin successfully disburse the loan on "20240101" with "1000" EUR transaction amount
    When Admin sets the business date to "20240102"
    When Admin runs inline COB job for Loan
    When Admin sets the business date to "20240110"
    When Admin places a lock on loan account with an error message
    When Admin creates new user with "NO_BYPASS_AUTOTEST" username, "NO_BYPASS_AUTOTEST_ROLE" role name and given permissions:
      | APPROVE_RESCHEDULELOAN |
      | CREATE_RESCHEDULELOAN  |
      | READ_RESCHEDULELOAN    |
      | REJECT_RESCHEDULELOAN  |
    When Batch API call with created user and the following data results a 200 statuscode WITHOUT error message:
      | rescheduleFromDate | submittedOnDate | adjustedDueDate | approvedOnDate  | enclosingTransaction |
      | 20240116    | 20240110 | 20240131 | 20240110 | true                 |

  @TestRailId:C3318 @AdvancedPaymentAllocation
  Scenario: Verify that in case of Loan is hard locked for COB execution WITHOUT error message, BatchAPI request of Loan reschedule creation and approval will result a 409 error and a LOAN_LOCKED_BY_COB error message
    When Admin sets the business date to "20240101"
    When Admin creates a client with random data
    When Admin set "LP2_DOWNPAYMENT_AUTO_ADVANCED_PAYMENT_ALLOCATION" loan product "DEFAULT" transaction type to "NEXT_INSTALLMENT" future installment allocation rule
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                      | submitted on date | with Principal | ANNUAL interest rate % | interest type | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_DOWNPAYMENT_AUTO_ADVANCED_PAYMENT_ALLOCATION | 20240101   | 1000           | 0                      | FLAT          | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 45                | DAYS                  | 15             | DAYS                   | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240101" with "1000" amount and expected disbursement date on "20240101"
    When Admin successfully disburse the loan on "20240101" with "1000" EUR transaction amount
    When Admin sets the business date to "20240102"
    When Admin runs inline COB job for Loan
    When Admin sets the business date to "20240110"
    When Admin places a lock on loan account WITHOUT an error message
    When Admin creates new user with "NO_BYPASS_AUTOTEST" username, "NO_BYPASS_AUTOTEST_ROLE" role name and given permissions:
      | APPROVE_RESCHEDULELOAN |
      | CREATE_RESCHEDULELOAN  |
      | READ_RESCHEDULELOAN    |
      | REJECT_RESCHEDULELOAN  |
    When Batch API call with created user and the following data results a 409 error and a "LOAN_LOCKED_BY_COB" error message:
      | rescheduleFromDate | submittedOnDate | adjustedDueDate | approvedOnDate  | enclosingTransaction |
      | 20240116    | 20240110 | 20240131 | 20240110 | true                 |

  @TestRailId:C3388
  Scenario: Verify that interest recalculation working in case one due date reschedule
    When Admin sets the business date to "20240101"
    And Admin creates a client with random data
    And Admin set "LP2_ADV_PYMNT_INTEREST_DAILY_EMI_360_30_INTEREST_RECALCULATION_DAILY_TILL_PRECLOSE" loan product "DEFAULT" transaction type to "NEXT_INSTALLMENT" future installment allocation rule
    And Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                        | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_EMI_360_30_INTEREST_RECALCULATION_DAILY_TILL_PRECLOSE | 20240101   | 100            | 7                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 6                 | MONTHS                | 1              | MONTHS                 | 6                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
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
    When Admin creates and approves Loan reschedule with the following data:
      | rescheduleFromDate | submittedOnDate | adjustedDueDate | graceOnPrincipal | graceOnInterest | extraTerms | newInterestRate |
      | 20240201   | 20240101 | 20240301   |                  |                 |            |                 |
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date            | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20240101 |           | 100.0           |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 60   | 20240301   |           | 84.16           | 15.84         | 1.17     | 0.0  | 0.0       | 17.01 | 0.0  | 0.0        | 0.0  | 17.01       |
      | 2  | 31   | 20240401   |           | 67.64           | 16.52         | 0.49     | 0.0  | 0.0       | 17.01 | 0.0  | 0.0        | 0.0  | 17.01       |
      | 3  | 30   | 20240501     |           | 51.02           | 16.62         | 0.39     | 0.0  | 0.0       | 17.01 | 0.0  | 0.0        | 0.0  | 17.01       |
      | 4  | 31   | 20240601    |           | 34.31           | 16.71         | 0.3      | 0.0  | 0.0       | 17.01 | 0.0  | 0.0        | 0.0  | 17.01       |
      | 5  | 30   | 20240701    |           | 17.5            | 16.81         | 0.2      | 0.0  | 0.0       | 17.01 | 0.0  | 0.0        | 0.0  | 17.01       |
      | 6  | 31   | 20240801  |           | 0.0             | 17.5          | 0.1      | 0.0  | 0.0       | 17.6  | 0.0  | 0.0        | 0.0  | 17.6        |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 100.0         | 2.65     | 0.0  | 0.0       | 102.65 | 0.0  | 0.0        | 0.0  | 102.65      |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |

  @TestRailId:C3389
  Scenario: Verify that interest recalculation working in case two due date reschedules
    When Admin sets the business date to "20240101"
    And Admin creates a client with random data
    And Admin set "LP2_ADV_PYMNT_INTEREST_DAILY_EMI_360_30_INTEREST_RECALCULATION_DAILY_TILL_PRECLOSE" loan product "DEFAULT" transaction type to "NEXT_INSTALLMENT" future installment allocation rule
    And Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                        | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_EMI_360_30_INTEREST_RECALCULATION_DAILY_TILL_PRECLOSE | 20240101   | 100            | 7                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 6                 | MONTHS                | 1              | MONTHS                 | 6                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
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
    When Admin creates and approves Loan reschedule with the following data:
      | rescheduleFromDate | submittedOnDate | adjustedDueDate | graceOnPrincipal | graceOnInterest | extraTerms | newInterestRate |
      | 20240201   | 20240101 | 20240301   |                  |                 |            |                 |
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date            | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20240101 |           | 100.0           |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 60   | 20240301   |           | 84.16           | 15.84         | 1.17     | 0.0  | 0.0       | 17.01 | 0.0  | 0.0        | 0.0  | 17.01       |
      | 2  | 31   | 20240401   |           | 67.64           | 16.52         | 0.49     | 0.0  | 0.0       | 17.01 | 0.0  | 0.0        | 0.0  | 17.01       |
      | 3  | 30   | 20240501     |           | 51.02           | 16.62         | 0.39     | 0.0  | 0.0       | 17.01 | 0.0  | 0.0        | 0.0  | 17.01       |
      | 4  | 31   | 20240601    |           | 34.31           | 16.71         | 0.3      | 0.0  | 0.0       | 17.01 | 0.0  | 0.0        | 0.0  | 17.01       |
      | 5  | 30   | 20240701    |           | 17.5            | 16.81         | 0.2      | 0.0  | 0.0       | 17.01 | 0.0  | 0.0        | 0.0  | 17.01       |
      | 6  | 31   | 20240801  |           | 0.0             | 17.5          | 0.1      | 0.0  | 0.0       | 17.6  | 0.0  | 0.0        | 0.0  | 17.6        |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 100.0         | 2.65     | 0.0  | 0.0       | 102.65 | 0.0  | 0.0        | 0.0  | 102.65      |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
    When Admin creates and approves Loan reschedule with the following data:
      | rescheduleFromDate | submittedOnDate | adjustedDueDate | graceOnPrincipal | graceOnInterest | extraTerms | newInterestRate |
      | 20240501        | 20240415   | 20240601    |                  |                 |            |                 |
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20240101   |           | 100.0           |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 60   | 20240301     |           | 84.16           | 15.84         | 1.17     | 0.0  | 0.0       | 17.01 | 0.0  | 0.0        | 0.0  | 17.01       |
      | 2  | 31   | 20240401     |           | 67.64           | 16.52         | 0.49     | 0.0  | 0.0       | 17.01 | 0.0  | 0.0        | 0.0  | 17.01       |
      | 3  | 61   | 20240601      |           | 51.42           | 16.22         | 0.79     | 0.0  | 0.0       | 17.01 | 0.0  | 0.0        | 0.0  | 17.01       |
      | 4  | 30   | 20240701      |           | 34.71           | 16.71         | 0.3      | 0.0  | 0.0       | 17.01 | 0.0  | 0.0        | 0.0  | 17.01       |
      | 5  | 31   | 20240801    |           | 17.9            | 16.81         | 0.2      | 0.0  | 0.0       | 17.01 | 0.0  | 0.0        | 0.0  | 17.01       |
      | 6  | 31   | 20240901 |           | 0.0             | 17.9          | 0.1      | 0.0  | 0.0       | 18.0  | 0.0  | 0.0        | 0.0  | 18.0        |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 100.0         | 3.05     | 0.0  | 0.0       | 103.05 | 0.0  | 0.0        | 0.0  | 103.05      |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |

  @TestRailId:C3390
  Scenario: Verify that interest recalculation working in case off due date reschedule
    When Admin sets the business date to "20240101"
    And Admin creates a client with random data
    And Admin set "LP2_ADV_PYMNT_INTEREST_DAILY_EMI_360_30_INTEREST_RECALCULATION_DAILY_TILL_PRECLOSE" loan product "DEFAULT" transaction type to "NEXT_INSTALLMENT" future installment allocation rule
    And Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                        | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_EMI_360_30_INTEREST_RECALCULATION_DAILY_TILL_PRECLOSE | 20240101   | 100            | 7                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 6                 | MONTHS                | 1              | MONTHS                 | 6                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
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
    When Admin creates and approves Loan reschedule with the following data:
      | rescheduleFromDate | submittedOnDate  | adjustedDueDate | graceOnPrincipal | graceOnInterest | extraTerms | newInterestRate |
      | 20240301      | 20240215 | 20240415   |                  |                 |            |                 |
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20240101  |           | 100.0           |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 31   | 20240201 |           | 83.57           | 16.43         | 0.58     | 0.0  | 0.0       | 17.01 | 0.0  | 0.0        | 0.0  | 17.01       |
      | 2  | 74   | 20240415    |           | 67.76           | 15.81         | 1.2      | 0.0  | 0.0       | 17.01 | 0.0  | 0.0        | 0.0  | 17.01       |
      | 3  | 30   | 20240515      |           | 51.15           | 16.61         | 0.4      | 0.0  | 0.0       | 17.01 | 0.0  | 0.0        | 0.0  | 17.01       |
      | 4  | 31   | 20240615     |           | 34.44           | 16.71         | 0.3      | 0.0  | 0.0       | 17.01 | 0.0  | 0.0        | 0.0  | 17.01       |
      | 5  | 30   | 20240715     |           | 17.63           | 16.81         | 0.2      | 0.0  | 0.0       | 17.01 | 0.0  | 0.0        | 0.0  | 17.01       |
      | 6  | 31   | 20240815   |           | 0.0             | 17.63         | 0.1      | 0.0  | 0.0       | 17.73 | 0.0  | 0.0        | 0.0  | 17.73       |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 100.0         | 2.78     | 0.0  | 0.0       | 102.78 | 0.0  | 0.0        | 0.0  | 102.78      |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |

  @TestRailId:C3426
  Scenario: Verify that interest recalculation working in case off due date reschedule, with dates for February
    When Admin sets the business date to "20240101"
    And Admin creates a client with random data
    And Admin set "LP2_ADV_PYMNT_INTEREST_DAILY_EMI_360_30_INTEREST_RECALCULATION_DAILY_TILL_PRECLOSE" loan product "DEFAULT" transaction type to "NEXT_INSTALLMENT" future installment allocation rule
    And Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                        | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_EMI_360_30_INTEREST_RECALCULATION_DAILY_TILL_PRECLOSE | 20240101   | 100            | 7                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 6                 | MONTHS                | 1              | MONTHS                 | 6                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
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
    When Admin creates and approves Loan reschedule with the following data:
      | rescheduleFromDate | submittedOnDate | adjustedDueDate | graceOnPrincipal | graceOnInterest | extraTerms | newInterestRate |
      | 20240201   | 20240101 | 20240301   |                  |                 |            |                 |
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date            | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20240101 |           | 100.0           |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 60   | 20240301   |           | 84.16           | 15.84         | 1.17     | 0.0  | 0.0       | 17.01 | 0.0  | 0.0        | 0.0  | 17.01       |
      | 2  | 31   | 20240401   |           | 67.64           | 16.52         | 0.49     | 0.0  | 0.0       | 17.01 | 0.0  | 0.0        | 0.0  | 17.01       |
      | 3  | 30   | 20240501     |           | 51.02           | 16.62         | 0.39     | 0.0  | 0.0       | 17.01 | 0.0  | 0.0        | 0.0  | 17.01       |
      | 4  | 31   | 20240601    |           | 34.31           | 16.71         | 0.3      | 0.0  | 0.0       | 17.01 | 0.0  | 0.0        | 0.0  | 17.01       |
      | 5  | 30   | 20240701    |           | 17.5            | 16.81         | 0.2      | 0.0  | 0.0       | 17.01 | 0.0  | 0.0        | 0.0  | 17.01       |
      | 6  | 31   | 20240801  |           | 0.0             | 17.5          | 0.1      | 0.0  | 0.0       | 17.6  | 0.0  | 0.0        | 0.0  | 17.6        |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 100.0         | 2.65     | 0.0  | 0.0       | 102.65 | 0.0  | 0.0        | 0.0  | 102.65      |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |

  @TestRailId:C3882
  Scenario: Reschedule progressive loan to 0 percent interest then back to 10 percent
    When Admin sets the business date to "20240101"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                             | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_EMI_360_30 | 20240101    | 100            | 10                     | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 6                 | MONTHS                | 1              | MONTHS                 | 6                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240101" with "100" amount and expected disbursement date on "20240101"
    When Admin successfully disburse the loan on "20240101" with "100" EUR transaction amount
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20240101  |           | 100.0           |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 31   | 20240201 |           | 83.67           | 16.33         | 0.83     | 0.0  | 0.0       | 17.16 | 0.0  | 0.0        | 0.0  | 17.16       |
      | 2  | 29   | 20240301    |           | 67.21           | 16.46         | 0.7      | 0.0  | 0.0       | 17.16 | 0.0  | 0.0        | 0.0  | 17.16       |
      | 3  | 31   | 20240401    |           | 50.61           | 16.6          | 0.56     | 0.0  | 0.0       | 17.16 | 0.0  | 0.0        | 0.0  | 17.16       |
      | 4  | 30   | 20240501      |           | 33.87           | 16.74         | 0.42     | 0.0  | 0.0       | 17.16 | 0.0  | 0.0        | 0.0  | 17.16       |
      | 5  | 31   | 20240601     |           | 16.99           | 16.88         | 0.28     | 0.0  | 0.0       | 17.16 | 0.0  | 0.0        | 0.0  | 17.16       |
      | 6  | 30   | 20240701     |           | 0.0             | 16.99         | 0.14     | 0.0  | 0.0       | 17.13 | 0.0  | 0.0        | 0.0  | 17.13       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 100.0         | 2.93     | 0.0  | 0.0       | 102.93 | 0.0  | 0.0        | 0.0  | 102.93      |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
    When Admin creates and approves Loan reschedule with the following data:
      | rescheduleFromDate | submittedOnDate | adjustedDueDate | graceOnPrincipal | graceOnInterest | extraTerms | newInterestRate |
      | 20240102    | 20240101 |                 |                  |                 |            | 0               |
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20240101  |           | 100.0           |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 31   | 20240201 |           | 83.33           | 16.67         | 0.0      | 0.0  | 0.0       | 16.67 | 0.0  | 0.0        | 0.0  | 16.67       |
      | 2  | 29   | 20240301    |           | 66.66           | 16.67         | 0.0      | 0.0  | 0.0       | 16.67 | 0.0  | 0.0        | 0.0  | 16.67       |
      | 3  | 31   | 20240401    |           | 49.99           | 16.67         | 0.0      | 0.0  | 0.0       | 16.67 | 0.0  | 0.0        | 0.0  | 16.67       |
      | 4  | 30   | 20240501      |           | 33.32           | 16.67         | 0.0      | 0.0  | 0.0       | 16.67 | 0.0  | 0.0        | 0.0  | 16.67       |
      | 5  | 31   | 20240601     |           | 16.65           | 16.67         | 0.0      | 0.0  | 0.0       | 16.67 | 0.0  | 0.0        | 0.0  | 16.67       |
      | 6  | 30   | 20240701     |           | 0.0             | 16.65         | 0.0      | 0.0  | 0.0       | 16.65 | 0.0  | 0.0        | 0.0  | 16.65       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      | 100.0         | 0.0      | 0.0  | 0.0       | 100.0 | 0.0  | 0.0        | 0.0  | 100.0       |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
    When Admin creates and approves Loan reschedule with the following data:
      | rescheduleFromDate | submittedOnDate | adjustedDueDate | graceOnPrincipal | graceOnInterest | extraTerms | newInterestRate |
      | 20240103    | 20240101 |                 |                  |                 |            | 10              |
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20240101  |           | 100.0           |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 31   | 20240201 |           | 83.66           | 16.34         | 0.81     | 0.0  | 0.0       | 17.15 | 0.0  | 0.0        | 0.0  | 17.15       |
      | 2  | 29   | 20240301    |           | 67.21           | 16.45         | 0.7      | 0.0  | 0.0       | 17.15 | 0.0  | 0.0        | 0.0  | 17.15       |
      | 3  | 31   | 20240401    |           | 50.62           | 16.59         | 0.56     | 0.0  | 0.0       | 17.15 | 0.0  | 0.0        | 0.0  | 17.15       |
      | 4  | 30   | 20240501      |           | 33.89           | 16.73         | 0.42     | 0.0  | 0.0       | 17.15 | 0.0  | 0.0        | 0.0  | 17.15       |
      | 5  | 31   | 20240601     |           | 17.02           | 16.87         | 0.28     | 0.0  | 0.0       | 17.15 | 0.0  | 0.0        | 0.0  | 17.15       |
      | 6  | 30   | 20240701     |           | 0.0             | 17.02         | 0.14     | 0.0  | 0.0       | 17.16 | 0.0  | 0.0        | 0.0  | 17.16       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 100.0         | 2.91     | 0.0  | 0.0       | 102.91 | 0.0  | 0.0        | 0.0  | 102.91      |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |

  @TestRailId:C3883
  Scenario: Create progressive loan with 0 percent interest then to 10 percent after first period
    When Admin sets the business date to "20240101"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                             | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_EMI_360_30 | 20240101    | 100            | 0                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 6                 | MONTHS                | 1              | MONTHS                 | 6                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240101" with "100" amount and expected disbursement date on "20240101"
    When Admin successfully disburse the loan on "20240101" with "100" EUR transaction amount
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20240101  |           | 100.0           |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 31   | 20240201 |           | 83.33           | 16.67         | 0.0      | 0.0  | 0.0       | 16.67 | 0.0  | 0.0        | 0.0  | 16.67       |
      | 2  | 29   | 20240301    |           | 66.66           | 16.67         | 0.0      | 0.0  | 0.0       | 16.67 | 0.0  | 0.0        | 0.0  | 16.67       |
      | 3  | 31   | 20240401    |           | 49.99           | 16.67         | 0.0      | 0.0  | 0.0       | 16.67 | 0.0  | 0.0        | 0.0  | 16.67       |
      | 4  | 30   | 20240501      |           | 33.32           | 16.67         | 0.0      | 0.0  | 0.0       | 16.67 | 0.0  | 0.0        | 0.0  | 16.67       |
      | 5  | 31   | 20240601     |           | 16.65           | 16.67         | 0.0      | 0.0  | 0.0       | 16.67 | 0.0  | 0.0        | 0.0  | 16.67       |
      | 6  | 30   | 20240701     |           | 0.0             | 16.65         | 0.0      | 0.0  | 0.0       | 16.65 | 0.0  | 0.0        | 0.0  | 16.65       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      | 100.0         | 0.0      | 0.0  | 0.0       | 100.0 | 0.0  | 0.0        | 0.0  | 100.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      | 100.0         | 0.0      | 0.0  | 0.0       | 100.0 | 0.0  | 0.0        | 0.0  | 100.0       |
    When Admin creates and approves Loan reschedule with the following data:
      | rescheduleFromDate | submittedOnDate | adjustedDueDate | graceOnPrincipal | graceOnInterest | extraTerms | newInterestRate |
      | 20240202   | 20240101 |                 |                  |                 |            | 10              |
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20240101  |           | 100.0           |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 31   | 20240201 |           | 83.33           | 16.67         | 0.0      | 0.0  | 0.0       | 16.67 | 0.0  | 0.0        | 0.0  | 16.67       |
      | 2  | 29   | 20240301    |           | 66.94           | 16.39         | 0.69     | 0.0  | 0.0       | 17.08 | 0.0  | 0.0        | 0.0  | 17.08       |
      | 3  | 31   | 20240401    |           | 50.42           | 16.52         | 0.56     | 0.0  | 0.0       | 17.08 | 0.0  | 0.0        | 0.0  | 17.08       |
      | 4  | 30   | 20240501      |           | 33.76           | 16.66         | 0.42     | 0.0  | 0.0       | 17.08 | 0.0  | 0.0        | 0.0  | 17.08       |
      | 5  | 31   | 20240601     |           | 16.96           | 16.8          | 0.28     | 0.0  | 0.0       | 17.08 | 0.0  | 0.0        | 0.0  | 17.08       |
      | 6  | 30   | 20240701     |           | 0.0             | 16.96         | 0.14     | 0.0  | 0.0       | 17.1  | 0.0  | 0.0        | 0.0  | 17.1        |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 100.0         | 2.09     | 0.0  | 0.0       | 102.09 | 0.0  | 0.0        | 0.0  | 102.09      |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |

  @TestRailId:C3885
  Scenario: Verify reschedule progressive loan interest rate to 0 after partial repayments
    When Admin sets the business date to "20240101"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                             | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_EMI_360_30 | 20240101    | 100            | 10                     | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 6                 | MONTHS                | 1              | MONTHS                 | 6                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240101" with "100" amount and expected disbursement date on "20240101"
    When Admin successfully disburse the loan on "20240101" with "100" EUR transaction amount
    When Admin sets the business date to "20240201"
    And Customer makes "AUTOPAY" repayment on "20240201" with 17.16 EUR transaction amount
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101  |                  | 100.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 31   | 20240201 | 20240201 | 83.67           | 16.33         | 0.83     | 0.0  | 0.0       | 17.16 | 17.16 | 0.0        | 0.0  | 0.0         |
      | 2  | 29   | 20240301    |                  | 67.21           | 16.46         | 0.7      | 0.0  | 0.0       | 17.16 | 0.0   | 0.0        | 0.0  | 17.16       |
      | 3  | 31   | 20240401    |                  | 50.61           | 16.6          | 0.56     | 0.0  | 0.0       | 17.16 | 0.0   | 0.0        | 0.0  | 17.16       |
      | 4  | 30   | 20240501      |                  | 33.87           | 16.74         | 0.42     | 0.0  | 0.0       | 17.16 | 0.0   | 0.0        | 0.0  | 17.16       |
      | 5  | 31   | 20240601     |                  | 16.99           | 16.88         | 0.28     | 0.0  | 0.0       | 17.16 | 0.0   | 0.0        | 0.0  | 17.16       |
      | 6  | 30   | 20240701     |                  | 0.0             | 16.99         | 0.14     | 0.0  | 0.0       | 17.13 | 0.0   | 0.0        | 0.0  | 17.13       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 100.0         | 2.93     | 0.0  | 0.0       | 102.93 | 17.16 | 0.0        | 0.0  | 85.77       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240201 | Repayment        | 17.16  | 16.33     | 0.83     | 0.0  | 0.0       | 83.67        | false    | false    |
    When Admin sets the business date to "20240215"
    And Customer makes "AUTOPAY" repayment on "20240215" with 8.58 EUR transaction amount
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101  |                  | 100.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 31   | 20240201 | 20240201 | 83.67           | 16.33         | 0.83     | 0.0  | 0.0       | 17.16 | 17.16 | 0.0        | 0.0  | 0.0         |
      | 2  | 29   | 20240301    |                  | 67.21           | 16.46         | 0.7      | 0.0  | 0.0       | 17.16 | 8.58  | 8.58       | 0.0  | 8.58        |
      | 3  | 31   | 20240401    |                  | 50.61           | 16.6          | 0.56     | 0.0  | 0.0       | 17.16 | 0.0   | 0.0        | 0.0  | 17.16       |
      | 4  | 30   | 20240501      |                  | 33.87           | 16.74         | 0.42     | 0.0  | 0.0       | 17.16 | 0.0   | 0.0        | 0.0  | 17.16       |
      | 5  | 31   | 20240601     |                  | 16.99           | 16.88         | 0.28     | 0.0  | 0.0       | 17.16 | 0.0   | 0.0        | 0.0  | 17.16       |
      | 6  | 30   | 20240701     |                  | 0.0             | 16.99         | 0.14     | 0.0  | 0.0       | 17.13 | 0.0   | 0.0        | 0.0  | 17.13       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 100.0         | 2.93     | 0.0  | 0.0       | 102.93 | 25.74 | 8.58       | 0.0  | 77.19       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240201 | Repayment        | 17.16  | 16.33     | 0.83     | 0.0  | 0.0       | 83.67        | false    | false    |
      | 20240215 | Repayment        | 8.58   | 8.58      | 0.0      | 0.0  | 0.0       | 75.09        | false    | false    |
    When Admin creates and approves Loan reschedule with the following data:
      | rescheduleFromDate | submittedOnDate  | adjustedDueDate | graceOnPrincipal | graceOnInterest | extraTerms | newInterestRate |
      | 20240216   | 20240215 |                 |                  |                 |            | 0               |
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101  |                  | 100.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 31   | 20240201 | 20240201 | 83.67           | 16.33         | 0.83     | 0.0  | 0.0       | 17.16 | 17.16 | 0.0        | 0.0  | 0.0         |
      | 2  | 29   | 20240301    |                  | 67.21           | 16.46         | 0.34     | 0.0  | 0.0       | 16.8  | 8.58  | 8.58       | 0.0  | 8.22        |
      | 3  | 31   | 20240401    |                  | 50.41           | 16.8          | 0.0      | 0.0  | 0.0       | 16.8  | 0.0   | 0.0        | 0.0  | 16.8        |
      | 4  | 30   | 20240501      |                  | 33.61           | 16.8          | 0.0      | 0.0  | 0.0       | 16.8  | 0.0   | 0.0        | 0.0  | 16.8        |
      | 5  | 31   | 20240601     |                  | 16.81           | 16.8          | 0.0      | 0.0  | 0.0       | 16.8  | 0.0   | 0.0        | 0.0  | 16.8        |
      | 6  | 30   | 20240701     |                  | 0.0             | 16.81         | 0.0      | 0.0  | 0.0       | 16.81 | 0.0   | 0.0        | 0.0  | 16.81       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 100.0         | 1.17     | 0.0  | 0.0       | 101.17 | 25.74 | 8.58       | 0.0  | 75.43       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240201 | Repayment        | 17.16  | 16.33     | 0.83     | 0.0  | 0.0       | 83.67        | false    | false    |
      | 20240215 | Repayment        | 8.58   | 8.58      | 0.0      | 0.0  | 0.0       | 75.09        | false    | false    |

  @TestRailId:C4126
  Scenario: Verify rescheduling of progressive loan is allowed on the first day of 1st repayment schedule
    When Admin sets the business date to "20250724"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                             | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_EMI_360_30 | 20250724      | 500            | 35                     | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 6                 | MONTHS                | 1              | MONTHS                 | 6                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20250724" with "500" amount and expected disbursement date on "20250724"
    When Admin successfully disburse the loan on "20250724" with "500" EUR transaction amount
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20250724      |           | 500.0           |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 31   | 20250824    |           | 422.54          | 77.46         | 14.58    | 0.0  | 0.0       | 92.04 | 0.0  | 0.0        | 0.0  | 92.04       |
      | 2  | 31   | 20250924 |           | 342.82          | 79.72         | 12.32    | 0.0  | 0.0       | 92.04 | 0.0  | 0.0        | 0.0  | 92.04       |
      | 3  | 30   | 20251024   |           | 260.78          | 82.04         | 10.0     | 0.0  | 0.0       | 92.04 | 0.0  | 0.0        | 0.0  | 92.04       |
      | 4  | 31   | 20251124  |           | 176.35          | 84.43         | 7.61     | 0.0  | 0.0       | 92.04 | 0.0  | 0.0        | 0.0  | 92.04       |
      | 5  | 30   | 20251224  |           | 89.45           | 86.9          | 5.14     | 0.0  | 0.0       | 92.04 | 0.0  | 0.0        | 0.0  | 92.04       |
      | 6  | 31   | 20260124   |           | 0.0             | 89.45         | 2.61     | 0.0  | 0.0       | 92.06 | 0.0  | 0.0        | 0.0  | 92.06       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 500.0         | 52.26    | 0.0  | 0.0       | 552.26 | 0.0  | 0.0        | 0.0  | 552.26      |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20250724     | Disbursement     | 500.0  | 0.0       | 0.0      | 0.0  | 0.0       | 500.0        | false    | false    |
    When Admin creates and approves Loan reschedule with the following data:
      | rescheduleFromDate | submittedOnDate | adjustedDueDate | graceOnPrincipal | graceOnInterest | extraTerms | newInterestRate |
      | 20250724       | 20250724    |                 |                  |                 |            | 5               |
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20250724      |           | 500.0           |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 31   | 20250824    |           | 417.53          | 82.47         | 2.08     | 0.0  | 0.0       | 84.55 | 0.0  | 0.0        | 0.0  | 84.55       |
      | 2  | 31   | 20250924 |           | 334.72          | 82.81         | 1.74     | 0.0  | 0.0       | 84.55 | 0.0  | 0.0        | 0.0  | 84.55       |
      | 3  | 30   | 20251024   |           | 251.56          | 83.16         | 1.39     | 0.0  | 0.0       | 84.55 | 0.0  | 0.0        | 0.0  | 84.55       |
      | 4  | 31   | 20251124  |           | 168.06          | 83.5          | 1.05     | 0.0  | 0.0       | 84.55 | 0.0  | 0.0        | 0.0  | 84.55       |
      | 5  | 30   | 20251224  |           | 84.21           | 83.85         | 0.7      | 0.0  | 0.0       | 84.55 | 0.0  | 0.0        | 0.0  | 84.55       |
      | 6  | 31   | 20260124   |           | 0.0             | 84.21         | 0.35     | 0.0  | 0.0       | 84.56 | 0.0  | 0.0        | 0.0  | 84.56       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 500.0         | 7.31     | 0.0  | 0.0       | 507.31 | 0.0  | 0.0        | 0.0  | 507.31      |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20250724     | Disbursement     | 500.0  | 0.0       | 0.0      | 0.0  | 0.0       | 500.0        | false    | false    |
    Then LoanRescheduledDueAdjustScheduleBusinessEvent is raised on "20250724"

  @TestRailId:C4225
  Scenario: Verify after backdated repayment, the last Accrual Activity transaction is reversed-replayed only once
    When Admin sets the business date to "20250905"
    And Admin creates a client with random data
    And Admin creates a fully customized loan with the following data:
      | LoanProduct                                                     | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_EMI_ACTUAL_ACTUAL_ACCRUAL_ACTIVITY | 20241231  | 1111           | 24.99                  | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 24                | MONTHS                | 1              | MONTHS                 | 24                 | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20241231" with "1111" amount and expected disbursement date on "20241231"
    And Admin successfully disburse the loan on "20241231" with "1111" EUR transaction amount
    And Customer makes "AUTOPAY" repayment on "20250131" with 59.26 EUR transaction amount
    And Customer makes "AUTOPAY" repayment on "20250228" with 59.26 EUR transaction amount
    And Customer makes "AUTOPAY" repayment on "20250331" with 59.26 EUR transaction amount
    And Customer makes "AUTOPAY" repayment on "20250430" with 59.26 EUR transaction amount
    And Customer makes "AUTOPAY" repayment on "20250530" with 59.26 EUR transaction amount
    And Customer makes "AUTOPAY" repayment on "20250629" with 59.26 EUR transaction amount
    And Customer makes "AUTOPAY" repayment on "20250731" with 59.26 EUR transaction amount
    And Customer makes "AUTOPAY" repayment on "20250831" with 59.26 EUR transaction amount
    When Admin sets the business date to "20250906"
    When Admin runs inline COB job for Loan
    When Admin sets the business date to "20250911"
    When Customer undo "1"th "Repayment" transaction made on "20250831"
    When Admin sets the business date to "20250930"
    And Customer makes "AUTOPAY" repayment on "20250930" with 59.26 EUR transaction amount
    And Customer makes "AUTOPAY" repayment on "20250930" with 59.26 EUR transaction amount
    When Admin runs inline COB job for Loan
    When Admin sets the business date to "20251010"
    When Customer undo "1"th "Repayment" transaction made on "20250930"
    When Customer undo "2"th "Repayment" transaction made on "20250930"
    When Admin sets the business date to "20251016"
    And Customer makes "AUTOPAY" repayment on "20251016" with 60 EUR transaction amount
    When Admin sets the business date to "20251031"
    And Customer makes "AUTOPAY" repayment on "20251031" with 59.26 EUR transaction amount
    And Customer makes "AUTOPAY" repayment on "20251031" with 58.52 EUR transaction amount
    When Admin runs inline COB job for Loan
    When Admin sets the business date to "20251110"
    When Admin runs inline COB job for Loan
    And Customer makes "AUTOPAY" repayment on "20250629" with 60 EUR transaction amount
    Then In Loan Transactions the "1"th Transaction of "Accrual Activity" on "20251031" has "1" relationship with type="REPLAYED"

  @TestRailId:C4391
  Scenario: Verify progressive loan due date reschedule maintains EMI
    When Admin sets the business date to "20250905"
    And Admin creates a client with random data
    And Admin creates a fully customized loan with the following data:
      | LoanProduct                                                     | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_EMI_ACTUAL_ACTUAL_ACCRUAL_ACTIVITY | 20241231  | 1111           | 24.99                  | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 24                | MONTHS                | 1              | MONTHS                 | 24                 | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20241231" with "1111" amount and expected disbursement date on "20241231"
    And Admin successfully disburse the loan on "20241231" with "1111" EUR transaction amount
    And Customer makes "AUTOPAY" repayment on "20250131" with 59.26 EUR transaction amount
    And Customer makes "AUTOPAY" repayment on "20250228" with 59.26 EUR transaction amount
    And Customer makes "AUTOPAY" repayment on "20250331" with 59.26 EUR transaction amount
    And Customer makes "AUTOPAY" repayment on "20250430" with 59.26 EUR transaction amount
    And Customer makes "AUTOPAY" repayment on "20250530" with 59.26 EUR transaction amount
    And Customer makes "AUTOPAY" repayment on "20250629" with 59.26 EUR transaction amount
    And Customer makes "AUTOPAY" repayment on "20250731" with 59.26 EUR transaction amount
    And Customer makes "AUTOPAY" repayment on "20250831" with 59.26 EUR transaction amount
    When Admin sets the business date to "20250906"
    When Admin runs inline COB job for Loan
    When Admin sets the business date to "20250911"
    When Customer undo "1"th "Repayment" transaction made on "20250831"
    When Admin sets the business date to "20250930"
    And Customer makes "AUTOPAY" repayment on "20250930" with 59.26 EUR transaction amount
    And Customer makes "AUTOPAY" repayment on "20250930" with 59.26 EUR transaction amount
    When Admin runs inline COB job for Loan
    When Admin sets the business date to "20251010"
    When Customer undo "1"th "Repayment" transaction made on "20250930"
    When Customer undo "2"th "Repayment" transaction made on "20250930"
    When Admin sets the business date to "20251016"
    And Customer makes "AUTOPAY" repayment on "20251016" with 60 EUR transaction amount
    When Admin sets the business date to "20251031"
    And Customer makes "AUTOPAY" repayment on "20251031" with 59.26 EUR transaction amount
    And Customer makes "AUTOPAY" repayment on "20251031" with 58.52 EUR transaction amount
    When Admin runs inline COB job for Loan
    When Admin sets the business date to "20251110"
    Then Loan Repayment schedule has 24 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late  | Outstanding |
      |    |      | 20241231  |                  | 1111.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |       |             |
      | 1  | 31   | 20250131   | 20250131  | 1075.32         | 35.68         | 23.58    | 0.0  | 0.0       | 59.26 | 59.26 | 0.0        | 0.0   | 0.0         |
      | 2  | 28   | 20250228  | 20250228 | 1036.67         | 38.65         | 20.61    | 0.0  | 0.0       | 59.26 | 59.26 | 0.0        | 0.0   | 0.0         |
      | 3  | 31   | 20250331     | 20250331    | 999.41          | 37.26         | 22.0     | 0.0  | 0.0       | 59.26 | 59.26 | 0.0        | 0.0   | 0.0         |
      | 4  | 30   | 20250430     | 20250430    | 960.68          | 38.73         | 20.53    | 0.0  | 0.0       | 59.26 | 59.26 | 0.0        | 0.0   | 0.0         |
      | 5  | 31   | 20250531       | 20250530      | 921.81          | 38.87         | 20.39    | 0.0  | 0.0       | 59.26 | 59.26 | 59.26      | 0.0   | 0.0         |
      | 6  | 30   | 20250630      | 20250629     | 881.48          | 40.33         | 18.93    | 0.0  | 0.0       | 59.26 | 59.26 | 59.26      | 0.0   | 0.0         |
      | 7  | 31   | 20250731      | 20250731     | 840.93          | 40.55         | 18.71    | 0.0  | 0.0       | 59.26 | 59.26 | 0.0        | 0.0   | 0.0         |
      | 8  | 31   | 20250831    | 20251016  | 799.52          | 41.41         | 17.85    | 0.0  | 0.0       | 59.26 | 59.26 | 0.0        | 59.26 | 0.0         |
      | 9  | 30   | 20250930 | 20251031  | 756.68          | 42.84         | 16.42    | 0.0  | 0.0       | 59.26 | 59.26 | 0.0        | 59.26 | 0.0         |
      | 10 | 31   | 20251031   | 20251031  | 713.48          | 43.2          | 16.06    | 0.0  | 0.0       | 59.26 | 59.26 | 0.0        | 0.0   | 0.0         |
      | 11 | 30   | 20251130  |                  | 668.87          | 44.61         | 14.65    | 0.0  | 0.0       | 59.26 | 0.0   | 0.0        | 0.0   | 59.26       |
      | 12 | 31   | 20251231  |                  | 623.81          | 45.06         | 14.2     | 0.0  | 0.0       | 59.26 | 0.0   | 0.0        | 0.0   | 59.26       |
      | 13 | 31   | 20260131   |                  | 577.79          | 46.02         | 13.24    | 0.0  | 0.0       | 59.26 | 0.0   | 0.0        | 0.0   | 59.26       |
      | 14 | 28   | 20260228  |                  | 529.61          | 48.18         | 11.08    | 0.0  | 0.0       | 59.26 | 0.0   | 0.0        | 0.0   | 59.26       |
      | 15 | 31   | 20260331     |                  | 481.59          | 48.02         | 11.24    | 0.0  | 0.0       | 59.26 | 0.0   | 0.0        | 0.0   | 59.26       |
      | 16 | 30   | 20260430     |                  | 432.22          | 49.37         | 9.89     | 0.0  | 0.0       | 59.26 | 0.0   | 0.0        | 0.0   | 59.26       |
      | 17 | 31   | 20260531       |                  | 382.13          | 50.09         | 9.17     | 0.0  | 0.0       | 59.26 | 0.0   | 0.0        | 0.0   | 59.26       |
      | 18 | 30   | 20260630      |                  | 330.72          | 51.41         | 7.85     | 0.0  | 0.0       | 59.26 | 0.0   | 0.0        | 0.0   | 59.26       |
      | 19 | 31   | 20260731      |                  | 278.48          | 52.24         | 7.02     | 0.0  | 0.0       | 59.26 | 0.0   | 0.0        | 0.0   | 59.26       |
      | 20 | 31   | 20260831    |                  | 225.13          | 53.35         | 5.91     | 0.0  | 0.0       | 59.26 | 0.0   | 0.0        | 0.0   | 59.26       |
      | 21 | 30   | 20260930 |                  | 170.49          | 54.64         | 4.62     | 0.0  | 0.0       | 59.26 | 0.0   | 0.0        | 0.0   | 59.26       |
      | 22 | 31   | 20261031   |                  | 114.85          | 55.64         | 3.62     | 0.0  | 0.0       | 59.26 | 0.0   | 0.0        | 0.0   | 59.26       |
      | 23 | 30   | 20261130  |                  | 57.95           | 56.9          | 2.36     | 0.0  | 0.0       | 59.26 | 0.0   | 0.0        | 0.0   | 59.26       |
      | 24 | 31   | 20261231  |                  | 0.0             | 57.95         | 1.23     | 0.0  | 0.0       | 59.18 | 0.0   | 0.0        | 0.0   | 59.18       |
    When Admin creates and approves Loan reschedule with the following data:
      | rescheduleFromDate | submittedOnDate  | adjustedDueDate | graceOnPrincipal | graceOnInterest | extraTerms | newInterestRate |
      | 20251130   | 20251110 | 20260131 |                  |                 |            |                 |
    Then Loan Repayment schedule has 24 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late  | Outstanding |
      |    |      | 20241231  |                  | 1111.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |       |             |
      | 1  | 31   | 20250131   | 20250131  | 1075.32         | 35.68         | 23.58    | 0.0  | 0.0       | 59.26 | 59.26 | 0.0        | 0.0   | 0.0         |
      | 2  | 28   | 20250228  | 20250228 | 1036.67         | 38.65         | 20.61    | 0.0  | 0.0       | 59.26 | 59.26 | 0.0        | 0.0   | 0.0         |
      | 3  | 31   | 20250331     | 20250331    | 999.41          | 37.26         | 22.0     | 0.0  | 0.0       | 59.26 | 59.26 | 0.0        | 0.0   | 0.0         |
      | 4  | 30   | 20250430     | 20250430    | 960.68          | 38.73         | 20.53    | 0.0  | 0.0       | 59.26 | 59.26 | 0.0        | 0.0   | 0.0         |
      | 5  | 31   | 20250531       | 20250530      | 921.81          | 38.87         | 20.39    | 0.0  | 0.0       | 59.26 | 59.26 | 59.26      | 0.0   | 0.0         |
      | 6  | 30   | 20250630      | 20250629     | 881.48          | 40.33         | 18.93    | 0.0  | 0.0       | 59.26 | 59.26 | 59.26      | 0.0   | 0.0         |
      | 7  | 31   | 20250731      | 20250731     | 840.93          | 40.55         | 18.71    | 0.0  | 0.0       | 59.26 | 59.26 | 0.0        | 0.0   | 0.0         |
      | 8  | 31   | 20250831    | 20251016  | 799.52          | 41.41         | 17.85    | 0.0  | 0.0       | 59.26 | 59.26 | 0.0        | 59.26 | 0.0         |
      | 9  | 30   | 20250930 | 20251031  | 756.68          | 42.84         | 16.42    | 0.0  | 0.0       | 59.26 | 59.26 | 0.0        | 59.26 | 0.0         |
      | 10 | 31   | 20251031   | 20251031  | 713.48          | 43.2          | 16.06    | 0.0  | 0.0       | 59.26 | 59.26 | 0.0        | 0.0   | 0.0         |
      | 11 | 92   | 20260131   |                  | 699.16          | 14.32         | 44.94    | 0.0  | 0.0       | 59.26 | 0.0   | 0.0        | 0.0   | 59.26       |
      | 12 | 28   | 20260228  |                  | 653.3           | 45.86         | 13.4     | 0.0  | 0.0       | 59.26 | 0.0   | 0.0        | 0.0   | 59.26       |
      | 13 | 31   | 20260331     |                  | 607.91          | 45.39         | 13.87    | 0.0  | 0.0       | 59.26 | 0.0   | 0.0        | 0.0   | 59.26       |
      | 14 | 30   | 20260430     |                  | 561.14          | 46.77         | 12.49    | 0.0  | 0.0       | 59.26 | 0.0   | 0.0        | 0.0   | 59.26       |
      | 15 | 31   | 20260531       |                  | 513.79          | 47.35         | 11.91    | 0.0  | 0.0       | 59.26 | 0.0   | 0.0        | 0.0   | 59.26       |
      | 16 | 30   | 20260630      |                  | 465.08          | 48.71         | 10.55    | 0.0  | 0.0       | 59.26 | 0.0   | 0.0        | 0.0   | 59.26       |
      | 17 | 31   | 20260731      |                  | 415.69          | 49.39         | 9.87     | 0.0  | 0.0       | 59.26 | 0.0   | 0.0        | 0.0   | 59.26       |
      | 18 | 31   | 20260831    |                  | 365.25          | 50.44         | 8.82     | 0.0  | 0.0       | 59.26 | 0.0   | 0.0        | 0.0   | 59.26       |
      | 19 | 30   | 20260930 |                  | 313.49          | 51.76         | 7.5      | 0.0  | 0.0       | 59.26 | 0.0   | 0.0        | 0.0   | 59.26       |
      | 20 | 31   | 20261031   |                  | 260.88          | 52.61         | 6.65     | 0.0  | 0.0       | 59.26 | 0.0   | 0.0        | 0.0   | 59.26       |
      | 21 | 30   | 20261130  |                  | 206.98          | 53.9          | 5.36     | 0.0  | 0.0       | 59.26 | 0.0   | 0.0        | 0.0   | 59.26       |
      | 22 | 31   | 20261231  |                  | 152.11          | 54.87         | 4.39     | 0.0  | 0.0       | 59.26 | 0.0   | 0.0        | 0.0   | 59.26       |
      | 23 | 31   | 20270131   |                  | 96.08           | 56.03         | 3.23     | 0.0  | 0.0       | 59.26 | 0.0   | 0.0        | 0.0   | 59.26       |
      | 24 | 28   | 20270228  |                  | 0.0             | 96.08         | 1.84     | 0.0  | 0.0       | 97.92 | 0.0   | 0.0        | 0.0   | 97.92       |

  @TestRailId:C4392
  Scenario: Verify basic loan rescheduling
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
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
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
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240201 | Repayment        | 17.13  | 16.34     | 0.79     | 0.0  | 0.0       | 83.66        | false    | false    |
    When Admin sets the business date to "20240301"
    When Admin creates and approves Loan reschedule with the following data:
      | rescheduleFromDate | submittedOnDate | adjustedDueDate | graceOnPrincipal | graceOnInterest | extraTerms | newInterestRate |
      | 20240301       | 20240301    | 20240315   |                  |                 |            |                 |
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101  |                  | 100.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 31   | 20240201 | 20240201 | 83.66           | 16.34         | 0.79     | 0.0  | 0.0       | 17.13 | 17.13 | 0.0        | 0.0  | 0.0         |
      | 2  | 43   | 20240315    |                  | 67.49           | 16.17         | 0.96     | 0.0  | 0.0       | 17.13 | 0.0   | 0.0        | 0.0  | 17.13       |
      | 3  | 31   | 20240415    |                  | 50.89           | 16.6          | 0.53     | 0.0  | 0.0       | 17.13 | 0.0   | 0.0        | 0.0  | 17.13       |
      | 4  | 30   | 20240515      |                  | 34.16           | 16.73         | 0.4      | 0.0  | 0.0       | 17.13 | 0.0   | 0.0        | 0.0  | 17.13       |
      | 5  | 31   | 20240615     |                  | 17.3            | 16.86         | 0.27     | 0.0  | 0.0       | 17.13 | 0.0   | 0.0        | 0.0  | 17.13       |
      | 6  | 30   | 20240715     |                  | 0.0             | 17.3          | 0.14     | 0.0  | 0.0       | 17.44 | 0.0   | 0.0        | 0.0  | 17.44       |

  @TestRailId:C4393
  Scenario: Verify loan rescheduling with N+1 period
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
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
    When Admin sets the business date to "20240201"
    And Customer makes "AUTOPAY" repayment on "20240201" with 17.13 EUR transaction amount
    When Admin sets the business date to "20240715"
    And Admin adds "LOAN_SNOOZE_FEE" due date charge with "20240715" due date and 10 EUR transaction amount
    Then Loan Repayment schedule has 7 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101  |                  | 100.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 31   | 20240201 | 20240201 | 83.66           | 16.34         | 0.79     | 0.0  | 0.0       | 17.13 | 17.13 | 0.0        | 0.0  | 0.0         |
      | 2  | 29   | 20240301    |                  | 67.19           | 16.47         | 0.66     | 0.0  | 0.0       | 17.13 | 0.0   | 0.0        | 0.0  | 17.13       |
      | 3  | 31   | 20240401    |                  | 50.59           | 16.6          | 0.53     | 0.0  | 0.0       | 17.13 | 0.0   | 0.0        | 0.0  | 17.13       |
      | 4  | 30   | 20240501      |                  | 33.86           | 16.73         | 0.4      | 0.0  | 0.0       | 17.13 | 0.0   | 0.0        | 0.0  | 17.13       |
      | 5  | 31   | 20240601     |                  | 17.0            | 16.86         | 0.27     | 0.0  | 0.0       | 17.13 | 0.0   | 0.0        | 0.0  | 17.13       |
      | 6  | 30   | 20240701     |                  | 0.0             | 17.0          | 0.13     | 0.0  | 0.0       | 17.13 | 0.0   | 0.0        | 0.0  | 17.13       |
      | 7  | 14   | 20240715     |                  | 0.0             | 0.0           | 0.0      | 10.0 | 0.0       | 10.0  | 0.0   | 0.0        | 0.0  | 10.0        |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 100.0         | 2.78     | 10.0 | 0.0       | 112.78 | 17.13 | 0.0        | 0.0  | 95.65       |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240201 | Repayment        | 17.13  | 16.34     | 0.79     | 0.0  | 0.0       | 83.66        | false    | false    |
    When Admin sets the business date to "20240301"
    When Admin creates and approves Loan reschedule with the following data:
      | rescheduleFromDate | submittedOnDate | adjustedDueDate | graceOnPrincipal | graceOnInterest | extraTerms | newInterestRate |
      | 20240301       | 20240301    | 20240330   |                  |                 |            |                 |
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101  |                  | 100.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 31   | 20240201 | 20240201 | 83.66           | 16.34         | 0.79     | 0.0  | 0.0       | 17.13 | 17.13 | 0.0        | 0.0  | 0.0         |
      | 2  | 58   | 20240330    |                  | 67.81           | 15.85         | 1.28     | 0.0  | 0.0       | 17.13 | 0.0   | 0.0        | 0.0  | 17.13       |
      | 3  | 31   | 20240430    |                  | 51.22           | 16.59         | 0.54     | 0.0  | 0.0       | 17.13 | 0.0   | 0.0        | 0.0  | 17.13       |
      | 4  | 30   | 20240530      |                  | 34.49           | 16.73         | 0.4      | 0.0  | 0.0       | 17.13 | 0.0   | 0.0        | 0.0  | 17.13       |
      | 5  | 31   | 20240630     |                  | 17.63           | 16.86         | 0.27     | 0.0  | 0.0       | 17.13 | 0.0   | 0.0        | 0.0  | 17.13       |
      | 6  | 30   | 20240730     |                  | 0.0             | 17.63         | 0.14     | 10.0 | 0.0       | 27.77 | 0.0   | 0.0        | 0.0  | 27.77       |

  @TestRailId:C4394
  Scenario: Verify loan rescheduling with automatic down payment
    When Admin sets the business date to "20240101"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                          | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_RECALCULATION_DAILY_EMI_360_30_MULTIDISBURSE_AUTO_DOWNPAYMENT | 20240101    | 100            | 9.4822                 | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 5                 | MONTHS                | 1              | MONTHS                 | 5                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240101" with "100" amount and expected disbursement date on "20240101"
    When Admin successfully disburse the loan on "20240101" with "100" EUR transaction amount
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20240101  |                 | 100.0           |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 0    | 20240101  | 20240101 | 75.0            | 25.0          | 0.0      | 0.0  | 0.0       | 25.0  | 25.0 | 0.0        | 0.0  | 0.0         |
      | 2  | 31   | 20240201 |                 | 60.23           | 14.77         | 0.59     | 0.0  | 0.0       | 15.36 | 0.0  | 0.0        | 0.0  | 15.36       |
      | 3  | 29   | 20240301    |                 | 45.35           | 14.88         | 0.48     | 0.0  | 0.0       | 15.36 | 0.0  | 0.0        | 0.0  | 15.36       |
      | 4  | 31   | 20240401    |                 | 30.35           | 15.0          | 0.36     | 0.0  | 0.0       | 15.36 | 0.0  | 0.0        | 0.0  | 15.36       |
      | 5  | 30   | 20240501      |                 | 15.23           | 15.12         | 0.24     | 0.0  | 0.0       | 15.36 | 0.0  | 0.0        | 0.0  | 15.36       |
      | 6  | 31   | 20240601     |                 | 0.0             | 15.23         | 0.12     | 0.0  | 0.0       | 15.35 | 0.0  | 0.0        | 0.0  | 15.35       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 100.0         | 1.79     | 0.0  | 0.0       | 101.79 | 25.0 | 0.0        | 0.0  | 76.79       |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240101  | Down Payment     | 25.0   | 25.0      | 0.0      | 0.0  | 0.0       | 75.0         | false    | false    |
    And Admin sets the business date to "20240201"
    And Customer makes "AUTOPAY" repayment on "20240201" with 15.36 EUR transaction amount
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101  |                  | 100.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 0    | 20240101  | 20240101  | 75.0            | 25.0          | 0.0      | 0.0  | 0.0       | 25.0  | 25.0  | 0.0        | 0.0  | 0.0         |
      | 2  | 31   | 20240201 | 20240201 | 60.23           | 14.77         | 0.59     | 0.0  | 0.0       | 15.36 | 15.36 | 0.0        | 0.0  | 0.0         |
      | 3  | 29   | 20240301    |                  | 45.35           | 14.88         | 0.48     | 0.0  | 0.0       | 15.36 | 0.0   | 0.0        | 0.0  | 15.36       |
      | 4  | 31   | 20240401    |                  | 30.35           | 15.0          | 0.36     | 0.0  | 0.0       | 15.36 | 0.0   | 0.0        | 0.0  | 15.36       |
      | 5  | 30   | 20240501      |                  | 15.23           | 15.12         | 0.24     | 0.0  | 0.0       | 15.36 | 0.0   | 0.0        | 0.0  | 15.36       |
      | 6  | 31   | 20240601     |                  | 0.0             | 15.23         | 0.12     | 0.0  | 0.0       | 15.35 | 0.0   | 0.0        | 0.0  | 15.35       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 100.0         | 1.79     | 0.0  | 0.0       | 101.79 | 40.36 | 0.0        | 0.0  | 61.43       |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20240101  | Down Payment     | 25.0   | 25.0      | 0.0      | 0.0  | 0.0       | 75.0         | false    | false    |
      | 20240201 | Repayment        | 15.36  | 14.77     | 0.59     | 0.0  | 0.0       | 60.23        | false    | false    |
    When Admin sets the business date to "20240301"
    When Admin creates and approves Loan reschedule with the following data:
      | rescheduleFromDate | submittedOnDate | adjustedDueDate | graceOnPrincipal | graceOnInterest | extraTerms | newInterestRate |
      | 20240301       | 20240301    | 20240315   |                  |                 |            |                 |
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101  |                  | 100.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 0    | 20240101  | 20240101  | 75.0            | 25.0          | 0.0      | 0.0  | 0.0       | 25.0  | 25.0  | 0.0        | 0.0  | 0.0         |
      | 2  | 31   | 20240201 | 20240201 | 60.23           | 14.77         | 0.59     | 0.0  | 0.0       | 15.36 | 15.36 | 0.0        | 0.0  | 0.0         |
      | 3  | 43   | 20240315    |                  | 45.56           | 14.67         | 0.69     | 0.0  | 0.0       | 15.36 | 0.0   | 0.0        | 0.0  | 15.36       |
      | 4  | 31   | 20240415    |                  | 30.56           | 15.0          | 0.36     | 0.0  | 0.0       | 15.36 | 0.0   | 0.0        | 0.0  | 15.36       |
      | 5  | 30   | 20240515      |                  | 15.44           | 15.12         | 0.24     | 0.0  | 0.0       | 15.36 | 0.0   | 0.0        | 0.0  | 15.36       |
      | 6  | 31   | 20240615     |                  | 0.0             | 15.44         | 0.12     | 0.0  | 0.0       | 15.56 | 0.0   | 0.0        | 0.0  | 15.56       |

  @TestRailId:C4395
  Scenario: Verify Progressive Loan reschedule with non-existing installment due date results in validation error
    When Admin sets the business date to "20240101"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
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
    When Admin sets the business date to "20240402"
    Then Loan reschedule with the following data results a 400 error and "LOAN_RESCHEDULE_FROM_DATE_INSTALLMENT_NOT_FOUND" error message
      | rescheduleFromDate | submittedOnDate | adjustedDueDate | graceOnPrincipal | graceOnInterest | extraTerms | newInterestRate |
      | 20240801     | 20240402   |                 |                  |                 | 2          |                 |

  @TestRailId:C4574
  Scenario: Verify multiple interest rate changes on same day, UC1: on due date
    When Admin sets the business date to "20250101"
    And Admin creates a client with random data
    And Admin creates a fully customized loan with the following data:
      | LoanProduct                             | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_EMI_360_30 | 20250101    | 100            | 10                     | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 6                 | MONTHS                | 1              | MONTHS                 | 6                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20250101" with "100" amount and expected disbursement date on "20250101"
    And Admin successfully disburse the loan on "20250101" with "100" EUR transaction amount
    And Admin sets the business date to "20250201"
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20250101  |           | 100.0           |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 31   | 20250201 |           | 83.67           | 16.33         | 0.83     | 0.0  | 0.0       | 17.16 | 0.0  | 0.0        | 0.0  | 17.16       |
      | 2  | 28   | 20250301    |           | 67.21           | 16.46         | 0.7      | 0.0  | 0.0       | 17.16 | 0.0  | 0.0        | 0.0  | 17.16       |
      | 3  | 31   | 20250401    |           | 50.61           | 16.6          | 0.56     | 0.0  | 0.0       | 17.16 | 0.0  | 0.0        | 0.0  | 17.16       |
      | 4  | 30   | 20250501      |           | 33.87           | 16.74         | 0.42     | 0.0  | 0.0       | 17.16 | 0.0  | 0.0        | 0.0  | 17.16       |
      | 5  | 31   | 20250601     |           | 16.99           | 16.88         | 0.28     | 0.0  | 0.0       | 17.16 | 0.0  | 0.0        | 0.0  | 17.16       |
      | 6  | 30   | 20250701     |           | 0.0             | 16.99         | 0.14     | 0.0  | 0.0       | 17.13 | 0.0  | 0.0        | 0.0  | 17.13       |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 100.0         | 2.93     | 0.0  | 0.0       | 102.93 | 0.0  | 0.0        | 0.0  | 102.93      |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20250101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
#    --- first interest rate change ---
    When Admin creates and approves Loan reschedule with the following data:
      | rescheduleFromDate | submittedOnDate  | adjustedDueDate | graceOnPrincipal | graceOnInterest | extraTerms | newInterestRate |
      | 20250201   | 20250201 |                 |                  |                 |            | 5               |
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20250101  |           | 100.0           |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 31   | 20250201 |           | 83.84           | 16.16         | 0.82     | 0.0  | 0.0       | 16.98 | 0.0  | 0.0        | 0.0  | 16.98       |
      | 2  | 28   | 20250301    |           | 67.21           | 16.63         | 0.35     | 0.0  | 0.0       | 16.98 | 0.0  | 0.0        | 0.0  | 16.98       |
      | 3  | 31   | 20250401    |           | 50.51           | 16.7          | 0.28     | 0.0  | 0.0       | 16.98 | 0.0  | 0.0        | 0.0  | 16.98       |
      | 4  | 30   | 20250501      |           | 33.74           | 16.77         | 0.21     | 0.0  | 0.0       | 16.98 | 0.0  | 0.0        | 0.0  | 16.98       |
      | 5  | 31   | 20250601     |           | 16.9            | 16.84         | 0.14     | 0.0  | 0.0       | 16.98 | 0.0  | 0.0        | 0.0  | 16.98       |
      | 6  | 30   | 20250701     |           | 0.0             | 16.9          | 0.07     | 0.0  | 0.0       | 16.97 | 0.0  | 0.0        | 0.0  | 16.97       |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 100.0         | 1.87     | 0.0  | 0.0       | 101.87 | 0.0  | 0.0        | 0.0  | 101.87      |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20250101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
    And Loan Reschedule tab has the following data:
      | From Date        | Reason | Status   |
      | 20250201 | Test   | Approved |
  #    --- second interest rate change ---
    When Admin creates and approves Loan reschedule with the following data:
      | rescheduleFromDate | submittedOnDate  | adjustedDueDate | graceOnPrincipal | graceOnInterest | extraTerms | newInterestRate |
      | 20250201   | 20250201 |                 |                  |                 |            | 0               |
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20250101  |           | 100.0           |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 31   | 20250201 |           | 84.01           | 15.99         | 0.81     | 0.0  | 0.0       | 16.8  | 0.0  | 0.0        | 0.0  | 16.8        |
      | 2  | 28   | 20250301    |           | 67.21           | 16.8          | 0.0      | 0.0  | 0.0       | 16.8  | 0.0  | 0.0        | 0.0  | 16.8        |
      | 3  | 31   | 20250401    |           | 50.41           | 16.8          | 0.0      | 0.0  | 0.0       | 16.8  | 0.0  | 0.0        | 0.0  | 16.8        |
      | 4  | 30   | 20250501      |           | 33.61           | 16.8          | 0.0      | 0.0  | 0.0       | 16.8  | 0.0  | 0.0        | 0.0  | 16.8        |
      | 5  | 31   | 20250601     |           | 16.81           | 16.8          | 0.0      | 0.0  | 0.0       | 16.8  | 0.0  | 0.0        | 0.0  | 16.8        |
      | 6  | 30   | 20250701     |           | 0.0             | 16.81         | 0.0      | 0.0  | 0.0       | 16.81 | 0.0  | 0.0        | 0.0  | 16.81       |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 100.0         | 0.81     | 0.0  | 0.0       | 100.81 | 0.0  | 0.0        | 0.0  | 100.81      |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20250101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
    And Loan Reschedule tab has the following data:
      | From Date        | Reason | Status   |
      | 20250201 | Test   | Approved |
      | 20250201 | Test   | Approved |

  @TestRailId:C4575
  Scenario: Verify multiple interest rate changes on same day, UC2: on due date after repayment
    When Admin sets the business date to "20250101"
    And Admin creates a client with random data
    And Admin creates a fully customized loan with the following data:
      | LoanProduct                             | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_EMI_360_30 | 20250101    | 100            | 10                     | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 6                 | MONTHS                | 1              | MONTHS                 | 6                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20250101" with "100" amount and expected disbursement date on "20250101"
    And Admin successfully disburse the loan on "20250101" with "100" EUR transaction amount
    And Admin sets the business date to "20250201"
    And Customer makes "AUTOPAY" repayment on "20250201" with 17.16 EUR transaction amount
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20250101  |                  | 100.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 31   | 20250201 | 20250201 | 83.67           | 16.33         | 0.83     | 0.0  | 0.0       | 17.16 | 17.16 | 0.0        | 0.0  | 0.0         |
      | 2  | 28   | 20250301    |                  | 67.21           | 16.46         | 0.7      | 0.0  | 0.0       | 17.16 | 0.0   | 0.0        | 0.0  | 17.16       |
      | 3  | 31   | 20250401    |                  | 50.61           | 16.6          | 0.56     | 0.0  | 0.0       | 17.16 | 0.0   | 0.0        | 0.0  | 17.16       |
      | 4  | 30   | 20250501      |                  | 33.87           | 16.74         | 0.42     | 0.0  | 0.0       | 17.16 | 0.0   | 0.0        | 0.0  | 17.16       |
      | 5  | 31   | 20250601     |                  | 16.99           | 16.88         | 0.28     | 0.0  | 0.0       | 17.16 | 0.0   | 0.0        | 0.0  | 17.16       |
      | 6  | 30   | 20250701     |                  | 0.0             | 16.99         | 0.14     | 0.0  | 0.0       | 17.13 | 0.0   | 0.0        | 0.0  | 17.13       |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 100.0         | 2.93     | 0.0  | 0.0       | 102.93 | 17.16 | 0.0        | 0.0  | 85.77       |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20250101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20250201 | Repayment        | 17.16  | 16.33     | 0.83     | 0.0  | 0.0       | 83.67        | false    | false    |
#    --- first interest rate change ---
    When Admin creates and approves Loan reschedule with the following data:
      | rescheduleFromDate | submittedOnDate  | adjustedDueDate | graceOnPrincipal | graceOnInterest | extraTerms | newInterestRate |
      | 20250201   | 20250201 |                 |                  |                 |            | 5               |
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20250101  |                  | 100.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 31   | 20250201 | 20250201 | 83.84           | 16.16         | 0.82     | 0.0  | 0.0       | 16.98 | 16.98 | 0.0        | 0.0  | 0.0         |
      | 2  | 28   | 20250301    |                  | 67.21           | 16.63         | 0.35     | 0.0  | 0.0       | 16.98 | 0.18  | 0.18       | 0.0  | 16.8        |
      | 3  | 31   | 20250401    |                  | 50.51           | 16.7          | 0.28     | 0.0  | 0.0       | 16.98 | 0.0   | 0.0        | 0.0  | 16.98       |
      | 4  | 30   | 20250501      |                  | 33.74           | 16.77         | 0.21     | 0.0  | 0.0       | 16.98 | 0.0   | 0.0        | 0.0  | 16.98       |
      | 5  | 31   | 20250601     |                  | 16.9            | 16.84         | 0.14     | 0.0  | 0.0       | 16.98 | 0.0   | 0.0        | 0.0  | 16.98       |
      | 6  | 30   | 20250701     |                  | 0.0             | 16.9          | 0.07     | 0.0  | 0.0       | 16.97 | 0.0   | 0.0        | 0.0  | 16.97       |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 100.0         | 1.87     | 0.0  | 0.0       | 101.87 | 17.16 | 0.18       | 0.0  | 84.71       |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20250101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20250201 | Repayment        | 17.16  | 16.34     | 0.82     | 0.0  | 0.0       | 83.66        | false    | true     |
    And Loan Reschedule tab has the following data:
      | From Date        | Reason | Status   |
      | 20250201 | Test   | Approved |
  #    --- second interest rate change ---
    When Admin creates and approves Loan reschedule with the following data:
      | rescheduleFromDate | submittedOnDate  | adjustedDueDate | graceOnPrincipal | graceOnInterest | extraTerms | newInterestRate |
      | 20250201   | 20250201 |                 |                  |                 |            | 0               |
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20250101  |                  | 100.0           |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 31   | 20250201 | 20250201 | 84.01           | 15.99         | 0.81     | 0.0  | 0.0       | 16.8  | 16.8 | 0.0        | 0.0  | 0.0         |
      | 2  | 28   | 20250301    |                  | 67.21           | 16.8          | 0.0      | 0.0  | 0.0       | 16.8  | 0.36 | 0.36       | 0.0  | 16.44       |
      | 3  | 31   | 20250401    |                  | 50.41           | 16.8          | 0.0      | 0.0  | 0.0       | 16.8  | 0.0  | 0.0        | 0.0  | 16.8        |
      | 4  | 30   | 20250501      |                  | 33.61           | 16.8          | 0.0      | 0.0  | 0.0       | 16.8  | 0.0  | 0.0        | 0.0  | 16.8        |
      | 5  | 31   | 20250601     |                  | 16.81           | 16.8          | 0.0      | 0.0  | 0.0       | 16.8  | 0.0  | 0.0        | 0.0  | 16.8        |
      | 6  | 30   | 20250701     |                  | 0.0             | 16.81         | 0.0      | 0.0  | 0.0       | 16.81 | 0.0  | 0.0        | 0.0  | 16.81       |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 100.0         | 0.81     | 0.0  | 0.0       | 100.81 | 17.16 | 0.36       | 0.0  | 83.65       |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20250101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20250201 | Repayment        | 17.16  | 16.35     | 0.81     | 0.0  | 0.0       | 83.65        | false    | true     |
    And Loan Reschedule tab has the following data:
      | From Date        | Reason | Status   |
      | 20250201 | Test   | Approved |
      | 20250201 | Test   | Approved |

  @TestRailId:C4576
  Scenario: Verify multiple interest rate changes on same day, UC3: on midterm date
    When Admin sets the business date to "20250101"
    And Admin creates a client with random data
    And Admin creates a fully customized loan with the following data:
      | LoanProduct                             | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_EMI_360_30 | 20250101    | 100            | 10                     | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 6                 | MONTHS                | 1              | MONTHS                 | 6                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20250101" with "100" amount and expected disbursement date on "20250101"
    And Admin successfully disburse the loan on "20250101" with "100" EUR transaction amount
    And Admin sets the business date to "20250115"
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20250101  |           | 100.0           |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 31   | 20250201 |           | 83.67           | 16.33         | 0.83     | 0.0  | 0.0       | 17.16 | 0.0  | 0.0        | 0.0  | 17.16       |
      | 2  | 28   | 20250301    |           | 67.21           | 16.46         | 0.7      | 0.0  | 0.0       | 17.16 | 0.0  | 0.0        | 0.0  | 17.16       |
      | 3  | 31   | 20250401    |           | 50.61           | 16.6          | 0.56     | 0.0  | 0.0       | 17.16 | 0.0  | 0.0        | 0.0  | 17.16       |
      | 4  | 30   | 20250501      |           | 33.87           | 16.74         | 0.42     | 0.0  | 0.0       | 17.16 | 0.0  | 0.0        | 0.0  | 17.16       |
      | 5  | 31   | 20250601     |           | 16.99           | 16.88         | 0.28     | 0.0  | 0.0       | 17.16 | 0.0  | 0.0        | 0.0  | 17.16       |
      | 6  | 30   | 20250701     |           | 0.0             | 16.99         | 0.14     | 0.0  | 0.0       | 17.13 | 0.0  | 0.0        | 0.0  | 17.13       |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 100.0         | 2.93     | 0.0  | 0.0       | 102.93 | 0.0  | 0.0        | 0.0  | 102.93      |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20250101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
#    --- first interest rate change ---
    When Admin creates and approves Loan reschedule with the following data:
      | rescheduleFromDate | submittedOnDate | adjustedDueDate | graceOnPrincipal | graceOnInterest | extraTerms | newInterestRate |
      | 20250115    | 20250115 |                 |                  |                 |            | 5               |
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20250101  |           | 100.0           |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 31   | 20250201 |           | 83.65           | 16.35         | 0.59     | 0.0  | 0.0       | 16.94 | 0.0  | 0.0        | 0.0  | 16.94       |
      | 2  | 28   | 20250301    |           | 67.06           | 16.59         | 0.35     | 0.0  | 0.0       | 16.94 | 0.0  | 0.0        | 0.0  | 16.94       |
      | 3  | 31   | 20250401    |           | 50.4            | 16.66         | 0.28     | 0.0  | 0.0       | 16.94 | 0.0  | 0.0        | 0.0  | 16.94       |
      | 4  | 30   | 20250501      |           | 33.67           | 16.73         | 0.21     | 0.0  | 0.0       | 16.94 | 0.0  | 0.0        | 0.0  | 16.94       |
      | 5  | 31   | 20250601     |           | 16.87           | 16.8          | 0.14     | 0.0  | 0.0       | 16.94 | 0.0  | 0.0        | 0.0  | 16.94       |
      | 6  | 30   | 20250701     |           | 0.0             | 16.87         | 0.07     | 0.0  | 0.0       | 16.94 | 0.0  | 0.0        | 0.0  | 16.94       |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 100.0         | 1.64     | 0.0  | 0.0       | 101.64 | 0.0  | 0.0        | 0.0  | 101.64      |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20250101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
    And Loan Reschedule tab has the following data:
      | From Date       | Reason | Status   |
      | 20250115 | Test   | Approved |
  #    --- second interest rate change ---
    When Admin creates and approves Loan reschedule with the following data:
      | rescheduleFromDate | submittedOnDate | adjustedDueDate | graceOnPrincipal | graceOnInterest | extraTerms | newInterestRate |
      | 20250115    | 20250115 |                 |                  |                 |            | 0               |
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20250101  |           | 100.0           |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 31   | 20250201 |           | 83.63           | 16.37         | 0.35     | 0.0  | 0.0       | 16.72 | 0.0  | 0.0        | 0.0  | 16.72       |
      | 2  | 28   | 20250301    |           | 66.91           | 16.72         | 0.0      | 0.0  | 0.0       | 16.72 | 0.0  | 0.0        | 0.0  | 16.72       |
      | 3  | 31   | 20250401    |           | 50.19           | 16.72         | 0.0      | 0.0  | 0.0       | 16.72 | 0.0  | 0.0        | 0.0  | 16.72       |
      | 4  | 30   | 20250501      |           | 33.47           | 16.72         | 0.0      | 0.0  | 0.0       | 16.72 | 0.0  | 0.0        | 0.0  | 16.72       |
      | 5  | 31   | 20250601     |           | 16.75           | 16.72         | 0.0      | 0.0  | 0.0       | 16.72 | 0.0  | 0.0        | 0.0  | 16.72       |
      | 6  | 30   | 20250701     |           | 0.0             | 16.75         | 0.0      | 0.0  | 0.0       | 16.75 | 0.0  | 0.0        | 0.0  | 16.75       |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 100.0         | 0.35     | 0.0  | 0.0       | 100.35 | 0.0  | 0.0        | 0.0  | 100.35      |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20250101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
    And Loan Reschedule tab has the following data:
      | From Date       | Reason | Status   |
      | 20250115 | Test   | Approved |
      | 20250115 | Test   | Approved |

  @TestRailId:C4577
  Scenario: Verify multiple interest rate changes on same day, UC4: on due date with third change
    When Admin sets the business date to "20250101"
    And Admin creates a client with random data
    And Admin creates a fully customized loan with the following data:
      | LoanProduct                             | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_EMI_360_30 | 20250101    | 100            | 10                     | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 6                 | MONTHS                | 1              | MONTHS                 | 6                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20250101" with "100" amount and expected disbursement date on "20250101"
    And Admin successfully disburse the loan on "20250101" with "100" EUR transaction amount
    And Admin sets the business date to "20250201"
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20250101  |           | 100.0           |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 31   | 20250201 |           | 83.67           | 16.33         | 0.83     | 0.0  | 0.0       | 17.16 | 0.0  | 0.0        | 0.0  | 17.16       |
      | 2  | 28   | 20250301    |           | 67.21           | 16.46         | 0.7      | 0.0  | 0.0       | 17.16 | 0.0  | 0.0        | 0.0  | 17.16       |
      | 3  | 31   | 20250401    |           | 50.61           | 16.6          | 0.56     | 0.0  | 0.0       | 17.16 | 0.0  | 0.0        | 0.0  | 17.16       |
      | 4  | 30   | 20250501      |           | 33.87           | 16.74         | 0.42     | 0.0  | 0.0       | 17.16 | 0.0  | 0.0        | 0.0  | 17.16       |
      | 5  | 31   | 20250601     |           | 16.99           | 16.88         | 0.28     | 0.0  | 0.0       | 17.16 | 0.0  | 0.0        | 0.0  | 17.16       |
      | 6  | 30   | 20250701     |           | 0.0             | 16.99         | 0.14     | 0.0  | 0.0       | 17.13 | 0.0  | 0.0        | 0.0  | 17.13       |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 100.0         | 2.93     | 0.0  | 0.0       | 102.93 | 0.0  | 0.0        | 0.0  | 102.93      |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20250101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
#    --- first interest rate change ---
    When Admin creates and approves Loan reschedule with the following data:
      | rescheduleFromDate | submittedOnDate  | adjustedDueDate | graceOnPrincipal | graceOnInterest | extraTerms | newInterestRate |
      | 20250201   | 20250201 |                 |                  |                 |            | 5               |
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20250101  |           | 100.0           |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 31   | 20250201 |           | 83.84           | 16.16         | 0.82     | 0.0  | 0.0       | 16.98 | 0.0  | 0.0        | 0.0  | 16.98       |
      | 2  | 28   | 20250301    |           | 67.21           | 16.63         | 0.35     | 0.0  | 0.0       | 16.98 | 0.0  | 0.0        | 0.0  | 16.98       |
      | 3  | 31   | 20250401    |           | 50.51           | 16.7          | 0.28     | 0.0  | 0.0       | 16.98 | 0.0  | 0.0        | 0.0  | 16.98       |
      | 4  | 30   | 20250501      |           | 33.74           | 16.77         | 0.21     | 0.0  | 0.0       | 16.98 | 0.0  | 0.0        | 0.0  | 16.98       |
      | 5  | 31   | 20250601     |           | 16.9            | 16.84         | 0.14     | 0.0  | 0.0       | 16.98 | 0.0  | 0.0        | 0.0  | 16.98       |
      | 6  | 30   | 20250701     |           | 0.0             | 16.9          | 0.07     | 0.0  | 0.0       | 16.97 | 0.0  | 0.0        | 0.0  | 16.97       |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 100.0         | 1.87     | 0.0  | 0.0       | 101.87 | 0.0  | 0.0        | 0.0  | 101.87      |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20250101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
    And Loan Reschedule tab has the following data:
      | From Date        | Reason | Status   |
      | 20250201 | Test   | Approved |
#    --- second interest rate change ---
    When Admin creates and approves Loan reschedule with the following data:
      | rescheduleFromDate | submittedOnDate  | adjustedDueDate | graceOnPrincipal | graceOnInterest | extraTerms | newInterestRate |
      | 20250201   | 20250201 |                 |                  |                 |            | 0               |
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20250101  |           | 100.0           |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 31   | 20250201 |           | 84.01           | 15.99         | 0.81     | 0.0  | 0.0       | 16.8  | 0.0  | 0.0        | 0.0  | 16.8        |
      | 2  | 28   | 20250301    |           | 67.21           | 16.8          | 0.0      | 0.0  | 0.0       | 16.8  | 0.0  | 0.0        | 0.0  | 16.8        |
      | 3  | 31   | 20250401    |           | 50.41           | 16.8          | 0.0      | 0.0  | 0.0       | 16.8  | 0.0  | 0.0        | 0.0  | 16.8        |
      | 4  | 30   | 20250501      |           | 33.61           | 16.8          | 0.0      | 0.0  | 0.0       | 16.8  | 0.0  | 0.0        | 0.0  | 16.8        |
      | 5  | 31   | 20250601     |           | 16.81           | 16.8          | 0.0      | 0.0  | 0.0       | 16.8  | 0.0  | 0.0        | 0.0  | 16.8        |
      | 6  | 30   | 20250701     |           | 0.0             | 16.81         | 0.0      | 0.0  | 0.0       | 16.81 | 0.0  | 0.0        | 0.0  | 16.81       |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 100.0         | 0.81     | 0.0  | 0.0       | 100.81 | 0.0  | 0.0        | 0.0  | 100.81      |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20250101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
    And Loan Reschedule tab has the following data:
      | From Date        | Reason | Status   |
      | 20250201 | Test   | Approved |
      | 20250201 | Test   | Approved |
#    --- third interest rate change ---
    When Admin creates and approves Loan reschedule with the following data:
      | rescheduleFromDate | submittedOnDate  | adjustedDueDate | graceOnPrincipal | graceOnInterest | extraTerms | newInterestRate |
      | 20250201   | 20250201 |                 |                  |                 |            | 5               |
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20250101  |           | 100.0           |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 31   | 20250201 |           | 83.84           | 16.16         | 0.82     | 0.0  | 0.0       | 16.98 | 0.0  | 0.0        | 0.0  | 16.98       |
      | 2  | 28   | 20250301    |           | 67.21           | 16.63         | 0.35     | 0.0  | 0.0       | 16.98 | 0.0  | 0.0        | 0.0  | 16.98       |
      | 3  | 31   | 20250401    |           | 50.51           | 16.7          | 0.28     | 0.0  | 0.0       | 16.98 | 0.0  | 0.0        | 0.0  | 16.98       |
      | 4  | 30   | 20250501      |           | 33.74           | 16.77         | 0.21     | 0.0  | 0.0       | 16.98 | 0.0  | 0.0        | 0.0  | 16.98       |
      | 5  | 31   | 20250601     |           | 16.9            | 16.84         | 0.14     | 0.0  | 0.0       | 16.98 | 0.0  | 0.0        | 0.0  | 16.98       |
      | 6  | 30   | 20250701     |           | 0.0             | 16.9          | 0.07     | 0.0  | 0.0       | 16.97 | 0.0  | 0.0        | 0.0  | 16.97       |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 100.0         | 1.87     | 0.0  | 0.0       | 101.87 | 0.0  | 0.0        | 0.0  | 101.87      |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20250101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
    And Loan Reschedule tab has the following data:
      | From Date        | Reason | Status   |
      | 20250201 | Test   | Approved |
      | 20250201 | Test   | Approved |
      | 20250201 | Test   | Approved |

  @TestRailId:C78849
  Scenario: Verify that reschedule after ReAge produces correct schedule and balance for downpayment product
    When Admin sets the business date to "20260121"
    When Admin creates a client with random data
    When Admin set "LP2_DOWNPAYMENT_AUTO_ADVANCED_PAYMENT_ALLOCATION" loan product "DEFAULT" transaction type to "NEXT_INSTALLMENT" future installment allocation rule
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                      | submitted on date | with Principal | ANNUAL interest rate % | interest type | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_DOWNPAYMENT_AUTO_ADVANCED_PAYMENT_ALLOCATION | 20260121   | 480            | 0                      | FLAT          | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 3                 | MONTHS                | 1              | MONTHS                 | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20260121" with "480" amount and expected disbursement date on "20260121"
    When Admin successfully disburse the loan on "20260121" with "480" EUR transaction amount
    Then Loan has 360.0 outstanding amount
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20260121  |                 | 480.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 0    | 20260121  | 20260121 | 360.0           | 120.0         | 0.0      | 0.0  | 0.0       | 120.0 | 120.0 | 0.0        | 0.0  | 0.0         |
      | 2  | 31   | 20260221 |                 | 240.0           | 120.0         | 0.0      | 0.0  | 0.0       | 120.0 | 0.0   | 0.0        | 0.0  | 120.0       |
      | 3  | 28   | 20260321    |                 | 120.0           | 120.0         | 0.0      | 0.0  | 0.0       | 120.0 | 0.0   | 0.0        | 0.0  | 120.0       |
      | 4  | 31   | 20260421    |                 | 0.0             | 120.0         | 0.0      | 0.0  | 0.0       | 120.0 | 0.0   | 0.0        | 0.0  | 120.0       |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      | 480.0         | 0.0      | 0.0  | 0.0       | 480.0 | 120.0 | 0.0        | 0.0  | 360.0       |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20260121  | Disbursement     | 480.0  | 0.0       | 0.0      | 0.0  | 0.0       | 480.0        | false    |
      | 20260121  | Down Payment     | 120.0  | 120.0     | 0.0      | 0.0  | 0.0       | 360.0        | false    |
    # --- Step 1: Reschedule (1 month payment holiday: push 21 Feb installment to 21 Mar) ---
    When Admin sets the business date to "20260123"
    When Admin creates and approves Loan reschedule with the following data:
      | rescheduleFromDate | submittedOnDate | adjustedDueDate | graceOnPrincipal | graceOnInterest | extraTerms | newInterestRate |
      | 20260221   | 20260123 | 20260321   |                  |                 |            |                 |
    Then Loan has 360.0 outstanding amount
    And Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date            | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20260121 |                 | 480.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 0    | 20260121 | 20260121 | 360.0           | 120.0         | 0.0      | 0.0  | 0.0       | 120.0 | 120.0 | 0.0        | 0.0  | 0.0         |
      | 2  | 59   | 20260321   |                 | 240.0           | 120.0         | 0.0      | 0.0  | 0.0       | 120.0 | 0.0   | 0.0        | 0.0  | 120.0       |
      | 3  | 31   | 20260421   |                 | 120.0           | 120.0         | 0.0      | 0.0  | 0.0       | 120.0 | 0.0   | 0.0        | 0.0  | 120.0       |
      | 4  | 30   | 20260521     |                 | 0.0             | 120.0         | 0.0      | 0.0  | 0.0       | 120.0 | 0.0   | 0.0        | 0.0  | 120.0       |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      | 480.0         | 0.0      | 0.0  | 0.0       | 480.0 | 120.0 | 0.0        | 0.0  | 360.0       |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20260121  | Disbursement     | 480.0  | 0.0       | 0.0      | 0.0  | 0.0       | 480.0        | false    |
      | 20260121  | Down Payment     | 120.0  | 120.0     | 0.0      | 0.0  | 0.0       | 360.0        | false    |
    # --- Step 2: ReAge for 15 monthly installments starting 20260321 ---
    When Admin creates a Loan re-aging transaction with the following data:
      | frequencyNumber | frequencyType | startDate     | numberOfInstallments | reAgeInterestHandling |
      | 1               | MONTHS        | 20260321 | 15                   | DEFAULT               |
    Then Loan has 360.0 outstanding amount
    And Loan Repayment schedule has 17 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20260121   |                 | 480.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 0    | 20260121   | 20260121 | 360.0           | 120.0         | 0.0      | 0.0  | 0.0       | 120.0 | 120.0 | 0.0        | 0.0  | 0.0         |
      | 2  | 2    | 20260123   | 20260123 | 360.0           | 0.0           | 0.0      | 0.0  | 0.0       | 0.0   | 0.0   | 0.0        | 0.0  | 0.0         |
      | 3  | 57   | 20260321     |                 | 336.0           | 24.0          | 0.0      | 0.0  | 0.0       | 24.0  | 0.0   | 0.0        | 0.0  | 24.0        |
      | 4  | 31   | 20260421     |                 | 312.0           | 24.0          | 0.0      | 0.0  | 0.0       | 24.0  | 0.0   | 0.0        | 0.0  | 24.0        |
      | 5  | 30   | 20260521       |                 | 288.0           | 24.0          | 0.0      | 0.0  | 0.0       | 24.0  | 0.0   | 0.0        | 0.0  | 24.0        |
      | 6  | 31   | 20260621      |                 | 264.0           | 24.0          | 0.0      | 0.0  | 0.0       | 24.0  | 0.0   | 0.0        | 0.0  | 24.0        |
      | 7  | 30   | 20260721      |                 | 240.0           | 24.0          | 0.0      | 0.0  | 0.0       | 24.0  | 0.0   | 0.0        | 0.0  | 24.0        |
      | 8  | 31   | 20260821    |                 | 216.0           | 24.0          | 0.0      | 0.0  | 0.0       | 24.0  | 0.0   | 0.0        | 0.0  | 24.0        |
      | 9  | 31   | 20260921 |                 | 192.0           | 24.0          | 0.0      | 0.0  | 0.0       | 24.0  | 0.0   | 0.0        | 0.0  | 24.0        |
      | 10 | 30   | 20261021   |                 | 168.0           | 24.0          | 0.0      | 0.0  | 0.0       | 24.0  | 0.0   | 0.0        | 0.0  | 24.0        |
      | 11 | 31   | 20261121  |                 | 144.0           | 24.0          | 0.0      | 0.0  | 0.0       | 24.0  | 0.0   | 0.0        | 0.0  | 24.0        |
      | 12 | 30   | 20261221  |                 | 120.0           | 24.0          | 0.0      | 0.0  | 0.0       | 24.0  | 0.0   | 0.0        | 0.0  | 24.0        |
      | 13 | 31   | 20270121   |                 | 96.0            | 24.0          | 0.0      | 0.0  | 0.0       | 24.0  | 0.0   | 0.0        | 0.0  | 24.0        |
      | 14 | 31   | 20270221  |                 | 72.0            | 24.0          | 0.0      | 0.0  | 0.0       | 24.0  | 0.0   | 0.0        | 0.0  | 24.0        |
      | 15 | 28   | 20270321     |                 | 48.0            | 24.0          | 0.0      | 0.0  | 0.0       | 24.0  | 0.0   | 0.0        | 0.0  | 24.0        |
      | 16 | 31   | 20270421     |                 | 24.0            | 24.0          | 0.0      | 0.0  | 0.0       | 24.0  | 0.0   | 0.0        | 0.0  | 24.0        |
      | 17 | 30   | 20270521       |                 | 0.0             | 24.0          | 0.0      | 0.0  | 0.0       | 24.0  | 0.0   | 0.0        | 0.0  | 24.0        |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      | 480.0         | 0.0      | 0.0  | 0.0       | 480.0 | 120.0 | 0.0        | 0.0  | 360.0       |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20260121  | Disbursement     | 480.0  | 0.0       | 0.0      | 0.0  | 0.0       | 480.0        | false    |
      | 20260121  | Down Payment     | 120.0  | 120.0     | 0.0      | 0.0  | 0.0       | 360.0        | false    |
      | 20260123  | Re-age           | 360.0  | 360.0     | 0.0      | 0.0  | 0.0       | 0.0          | false    |
    # --- Step 3: BUG TRIGGER: Reschedule again (push schedule 2 more months) ---
    When Admin sets the business date to "20260128"
    When Admin creates and approves Loan reschedule with the following data:
      | rescheduleFromDate | submittedOnDate | adjustedDueDate | graceOnPrincipal | graceOnInterest | extraTerms | newInterestRate |
      | 20260321      | 20260128 | 20260521     |                  |                 |            |                 |
    # After reschedule 2 the 15 ReAge installments must cascade by 2 months: first reAge installment
    # moves from 20260321 to 20260521 and the last one moves from 20270521 to 20270721.
    # The bug : the second reschedule silently leaves the schedule unchanged - i.e. 20270721
    # does not exist in the schedule.
    Then Loan has 360.0 outstanding amount
    Then Loan Repayment schedule has 17 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20260121   |                 | 480.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 0    | 20260121   | 20260121 | 360.0           | 120.0         | 0.0      | 0.0  | 0.0       | 120.0 | 120.0 | 0.0        | 0.0  | 0.0         |
      | 2  | 2    | 20260123   | 20260123 | 360.0           | 0.0           | 0.0      | 0.0  | 0.0       | 0.0   | 0.0   | 0.0        | 0.0  | 0.0         |
      | 3  | 118  | 20260521       |                 | 336.0           | 24.0          | 0.0      | 0.0  | 0.0       | 24.0  | 0.0   | 0.0        | 0.0  | 24.0        |
      | 4  | 31   | 20260621      |                 | 312.0           | 24.0          | 0.0      | 0.0  | 0.0       | 24.0  | 0.0   | 0.0        | 0.0  | 24.0        |
      | 5  | 30   | 20260721      |                 | 288.0           | 24.0          | 0.0      | 0.0  | 0.0       | 24.0  | 0.0   | 0.0        | 0.0  | 24.0        |
      | 6  | 31   | 20260821    |                 | 264.0           | 24.0          | 0.0      | 0.0  | 0.0       | 24.0  | 0.0   | 0.0        | 0.0  | 24.0        |
      | 7  | 31   | 20260921 |                 | 240.0           | 24.0          | 0.0      | 0.0  | 0.0       | 24.0  | 0.0   | 0.0        | 0.0  | 24.0        |
      | 8  | 30   | 20261021   |                 | 216.0           | 24.0          | 0.0      | 0.0  | 0.0       | 24.0  | 0.0   | 0.0        | 0.0  | 24.0        |
      | 9  | 31   | 20261121  |                 | 192.0           | 24.0          | 0.0      | 0.0  | 0.0       | 24.0  | 0.0   | 0.0        | 0.0  | 24.0        |
      | 10 | 30   | 20261221  |                 | 168.0           | 24.0          | 0.0      | 0.0  | 0.0       | 24.0  | 0.0   | 0.0        | 0.0  | 24.0        |
      | 11 | 31   | 20270121   |                 | 144.0           | 24.0          | 0.0      | 0.0  | 0.0       | 24.0  | 0.0   | 0.0        | 0.0  | 24.0        |
      | 12 | 31   | 20270221  |                 | 120.0           | 24.0          | 0.0      | 0.0  | 0.0       | 24.0  | 0.0   | 0.0        | 0.0  | 24.0        |
      | 13 | 28   | 20270321     |                 | 96.0            | 24.0          | 0.0      | 0.0  | 0.0       | 24.0  | 0.0   | 0.0        | 0.0  | 24.0        |
      | 14 | 31   | 20270421     |                 | 72.0            | 24.0          | 0.0      | 0.0  | 0.0       | 24.0  | 0.0   | 0.0        | 0.0  | 24.0        |
      | 15 | 30   | 20270521       |                 | 48.0            | 24.0          | 0.0      | 0.0  | 0.0       | 24.0  | 0.0   | 0.0        | 0.0  | 24.0        |
      | 16 | 31   | 20270621      |                 | 24.0            | 24.0          | 0.0      | 0.0  | 0.0       | 24.0  | 0.0   | 0.0        | 0.0  | 24.0        |
      | 17 | 30   | 20270721      |                 | 0.0             | 24.0          | 0.0      | 0.0  | 0.0       | 24.0  | 0.0   | 0.0        | 0.0  | 24.0        |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      | 480.0         | 0.0      | 0.0  | 0.0       | 480.0 | 120.0 | 0.0        | 0.0  | 360.0       |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20260121  | Disbursement     | 480.0  | 0.0       | 0.0      | 0.0  | 0.0       | 480.0        | false    |
      | 20260121  | Down Payment     | 120.0  | 120.0     | 0.0      | 0.0  | 0.0       | 360.0        | false    |
      | 20260123  | Re-age           | 360.0  | 360.0     | 0.0      | 0.0  | 0.0       | 0.0          | false    |

  @TestRailId:C78850
  Scenario: Verify that reschedule after ReAge produces correct schedule and balance for non-interest bearing single-installment product - UC1
    When Admin sets the business date to "20260121"
    When Admin creates a client with random data
    When Admin set "LP1_ADV_PMT_ALLOC_PROGRESSIVE_LOAN_SCHEDULE_HORIZONTAL" loan product "DEFAULT" transaction type to "NEXT_INSTALLMENT" future installment allocation rule
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                            | submitted on date | with Principal | ANNUAL interest rate % | interest type | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP1_ADV_PMT_ALLOC_PROGRESSIVE_LOAN_SCHEDULE_HORIZONTAL | 20260121   | 150            | 0                      | FLAT          | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 30                | DAYS                  | 30             | DAYS                   | 1                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20260121" with "150" amount and expected disbursement date on "20260121"
    When Admin successfully disburse the loan on "20260121" with "150" EUR transaction amount
    Then Loan has 150.0 outstanding amount
    Then Loan Repayment schedule has 1 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20260121  |           | 150.0           |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 30   | 20260220 |           | 0.0             | 150.0         | 0.0      | 0.0  | 0.0       | 150.0 | 0.0  | 0.0        | 0.0  | 150.0       |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      | 150.0         | 0.0      | 0.0  | 0.0       | 150.0 | 0.0  | 0.0        | 0.0  | 150.0       |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20260121  | Disbursement     | 150.0  | 0.0       | 0.0      | 0.0  | 0.0       | 150.0        | false    |
    # --- Step 1: Reschedule (push 20 Feb installment to 22 Mar) ---
    When Admin sets the business date to "20260123"
    When Admin creates and approves Loan reschedule with the following data:
      | rescheduleFromDate | submittedOnDate | adjustedDueDate | graceOnPrincipal | graceOnInterest | extraTerms | newInterestRate |
      | 20260220   | 20260123 | 20260322   |                  |                 |            |                 |
    Then Loan has 150.0 outstanding amount
    And Loan Repayment schedule has 1 periods, with the following data for periods:
      | Nr | Days | Date            | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20260121 |           | 150.0           |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 60   | 20260322   |           | 0.0             | 150.0         | 0.0      | 0.0  | 0.0       | 150.0 | 0.0  | 0.0        | 0.0  | 150.0       |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      | 150.0         | 0.0      | 0.0  | 0.0       | 150.0 | 0.0  | 0.0        | 0.0  | 150.0       |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20260121  | Disbursement     | 150.0  | 0.0       | 0.0      | 0.0  | 0.0       | 150.0        | false    |
    # --- Step 2: ReAge for 15 monthly installments starting 20260322 ---
    When Admin creates a Loan re-aging transaction with the following data:
      | frequencyNumber | frequencyType | startDate     | numberOfInstallments | reAgeInterestHandling |
      | 1               | MONTHS        | 20260322 | 15                   | DEFAULT               |
    Then Loan has 150.0 outstanding amount
    And Loan Repayment schedule has 16 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due  | Paid | In advance | Late | Outstanding |
      |    |      | 20260121   |                 | 150.0           |               |          | 0.0  |           | 0.0  | 0.0  |            |      |             |
      | 1  | 2    | 20260123   | 20260123 | 150.0           | 0.0           | 0.0      | 0.0  | 0.0       | 0.0  | 0.0  | 0.0        | 0.0  | 0.0         |
      | 2  | 58   | 20260322     |                 | 140.0           | 10.0          | 0.0      | 0.0  | 0.0       | 10.0 | 0.0  | 0.0        | 0.0  | 10.0        |
      | 3  | 31   | 20260422     |                 | 130.0           | 10.0          | 0.0      | 0.0  | 0.0       | 10.0 | 0.0  | 0.0        | 0.0  | 10.0        |
      | 4  | 30   | 20260522       |                 | 120.0           | 10.0          | 0.0      | 0.0  | 0.0       | 10.0 | 0.0  | 0.0        | 0.0  | 10.0        |
      | 5  | 31   | 20260622      |                 | 110.0           | 10.0          | 0.0      | 0.0  | 0.0       | 10.0 | 0.0  | 0.0        | 0.0  | 10.0        |
      | 6  | 30   | 20260722      |                 | 100.0           | 10.0          | 0.0      | 0.0  | 0.0       | 10.0 | 0.0  | 0.0        | 0.0  | 10.0        |
      | 7  | 31   | 20260822    |                 | 90.0            | 10.0          | 0.0      | 0.0  | 0.0       | 10.0 | 0.0  | 0.0        | 0.0  | 10.0        |
      | 8  | 31   | 20260922 |                 | 80.0            | 10.0          | 0.0      | 0.0  | 0.0       | 10.0 | 0.0  | 0.0        | 0.0  | 10.0        |
      | 9  | 30   | 20261022   |                 | 70.0            | 10.0          | 0.0      | 0.0  | 0.0       | 10.0 | 0.0  | 0.0        | 0.0  | 10.0        |
      | 10 | 31   | 20261122  |                 | 60.0            | 10.0          | 0.0      | 0.0  | 0.0       | 10.0 | 0.0  | 0.0        | 0.0  | 10.0        |
      | 11 | 30   | 20261222  |                 | 50.0            | 10.0          | 0.0      | 0.0  | 0.0       | 10.0 | 0.0  | 0.0        | 0.0  | 10.0        |
      | 12 | 31   | 20270122   |                 | 40.0            | 10.0          | 0.0      | 0.0  | 0.0       | 10.0 | 0.0  | 0.0        | 0.0  | 10.0        |
      | 13 | 31   | 20270222  |                 | 30.0            | 10.0          | 0.0      | 0.0  | 0.0       | 10.0 | 0.0  | 0.0        | 0.0  | 10.0        |
      | 14 | 28   | 20270322     |                 | 20.0            | 10.0          | 0.0      | 0.0  | 0.0       | 10.0 | 0.0  | 0.0        | 0.0  | 10.0        |
      | 15 | 31   | 20270422     |                 | 10.0            | 10.0          | 0.0      | 0.0  | 0.0       | 10.0 | 0.0  | 0.0        | 0.0  | 10.0        |
      | 16 | 30   | 20270522       |                 | 0.0             | 10.0          | 0.0      | 0.0  | 0.0       | 10.0 | 0.0  | 0.0        | 0.0  | 10.0        |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      | 150.0         | 0.0      | 0.0  | 0.0       | 150.0 | 0.0  | 0.0        | 0.0  | 150.0       |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20260121  | Disbursement     | 150.0  | 0.0       | 0.0      | 0.0  | 0.0       | 150.0        | false    |
      | 20260123  | Re-age           | 150.0  | 150.0     | 0.0      | 0.0  | 0.0       | 0.0          | false    |
    # --- Step 3: BUG TRIGGER: Reschedule again (push schedule 2 more months: 22 Mar -> 22 May) ---
    When Admin sets the business date to "20260128"
    When Admin creates and approves Loan reschedule with the following data:
      | rescheduleFromDate | submittedOnDate | adjustedDueDate | graceOnPrincipal | graceOnInterest | extraTerms | newInterestRate |
      | 20260322      | 20260128 | 20260522     |                  |                 |            |                 |
#    --- After 2nd reschedule Repayment schedule should reflect the last reAge data (eg: frequencyType and numberOfInstallments) ---
    Then Loan has 150.0 outstanding amount
    Then Loan Repayment schedule has 16 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due  | Paid | In advance | Late | Outstanding |
      |    |      | 20260121   |                 | 150.0           |               |          | 0.0  |           | 0.0  | 0.0  |            |      |             |
      | 1  | 2    | 20260123   | 20260123 | 150.0           | 0.0           | 0.0      | 0.0  | 0.0       | 0.0  | 0.0  | 0.0        | 0.0  | 0.0         |
      | 2  | 119  | 20260522       |                 | 140.0           | 10.0          | 0.0      | 0.0  | 0.0       | 10.0 | 0.0  | 0.0        | 0.0  | 10.0        |
      | 3  | 31   | 20260622      |                 | 130.0           | 10.0          | 0.0      | 0.0  | 0.0       | 10.0 | 0.0  | 0.0        | 0.0  | 10.0        |
      | 4  | 30   | 20260722      |                 | 120.0           | 10.0          | 0.0      | 0.0  | 0.0       | 10.0 | 0.0  | 0.0        | 0.0  | 10.0        |
      | 5  | 31   | 20260822    |                 | 110.0           | 10.0          | 0.0      | 0.0  | 0.0       | 10.0 | 0.0  | 0.0        | 0.0  | 10.0        |
      | 6  | 31   | 20260922 |                 | 100.0           | 10.0          | 0.0      | 0.0  | 0.0       | 10.0 | 0.0  | 0.0        | 0.0  | 10.0        |
      | 7  | 30   | 20261022   |                 | 90.0            | 10.0          | 0.0      | 0.0  | 0.0       | 10.0 | 0.0  | 0.0        | 0.0  | 10.0        |
      | 8  | 31   | 20261122  |                 | 80.0            | 10.0          | 0.0      | 0.0  | 0.0       | 10.0 | 0.0  | 0.0        | 0.0  | 10.0        |
      | 9  | 30   | 20261222  |                 | 70.0            | 10.0          | 0.0      | 0.0  | 0.0       | 10.0 | 0.0  | 0.0        | 0.0  | 10.0        |
      | 10 | 31   | 20270122   |                 | 60.0            | 10.0          | 0.0      | 0.0  | 0.0       | 10.0 | 0.0  | 0.0        | 0.0  | 10.0        |
      | 11 | 31   | 20270222  |                 | 50.0            | 10.0          | 0.0      | 0.0  | 0.0       | 10.0 | 0.0  | 0.0        | 0.0  | 10.0        |
      | 12 | 28   | 20270322     |                 | 40.0            | 10.0          | 0.0      | 0.0  | 0.0       | 10.0 | 0.0  | 0.0        | 0.0  | 10.0        |
      | 13 | 31   | 20270422     |                 | 30.0            | 10.0          | 0.0      | 0.0  | 0.0       | 10.0 | 0.0  | 0.0        | 0.0  | 10.0        |
      | 14 | 30   | 20270522       |                 | 20.0            | 10.0          | 0.0      | 0.0  | 0.0       | 10.0 | 0.0  | 0.0        | 0.0  | 10.0        |
      | 15 | 31   | 20270622      |                 | 10.0            | 10.0          | 0.0      | 0.0  | 0.0       | 10.0 | 0.0  | 0.0        | 0.0  | 10.0        |
      | 16 | 30   | 20270722      |                 | 0.0             | 10.0          | 0.0      | 0.0  | 0.0       | 10.0 | 0.0  | 0.0        | 0.0  | 10.0        |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      | 150.0         | 0.0      | 0.0  | 0.0       | 150.0 | 0.0  | 0.0        | 0.0  | 150.0       |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20260121  | Disbursement     | 150.0  | 0.0       | 0.0      | 0.0  | 0.0       | 150.0        | false    |
      | 20260123  | Re-age           | 150.0  | 150.0     | 0.0      | 0.0  | 0.0       | 0.0          | false    |
#    --- Extra step: reschedule again after business date change ---
    When Admin sets the business date to "20260428"
    When Admin creates and approves Loan reschedule with the following data:
      | rescheduleFromDate | submittedOnDate | adjustedDueDate | graceOnPrincipal | graceOnInterest | extraTerms | newInterestRate |
      | 20260522        | 20260428   | 20260611    |                  |                 |            |                 |
    Then Loan has 150.0 outstanding amount
    Then Loan Repayment schedule has 16 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due  | Paid | In advance | Late | Outstanding |
      |    |      | 20260121   |                 | 150.0           |               |          | 0.0  |           | 0.0  | 0.0  |            |      |             |
      | 1  | 2    | 20260123   | 20260123 | 150.0           | 0.0           | 0.0      | 0.0  | 0.0       | 0.0  | 0.0  | 0.0        | 0.0  | 0.0         |
      | 2  | 139  | 20260611      |                 | 140.0           | 10.0          | 0.0      | 0.0  | 0.0       | 10.0 | 0.0  | 0.0        | 0.0  | 10.0        |
      | 3  | 30   | 20260711      |                 | 130.0           | 10.0          | 0.0      | 0.0  | 0.0       | 10.0 | 0.0  | 0.0        | 0.0  | 10.0        |
      | 4  | 31   | 20260811    |                 | 120.0           | 10.0          | 0.0      | 0.0  | 0.0       | 10.0 | 0.0  | 0.0        | 0.0  | 10.0        |
      | 5  | 31   | 20260911 |                 | 110.0           | 10.0          | 0.0      | 0.0  | 0.0       | 10.0 | 0.0  | 0.0        | 0.0  | 10.0        |
      | 6  | 30   | 20261011   |                 | 100.0           | 10.0          | 0.0      | 0.0  | 0.0       | 10.0 | 0.0  | 0.0        | 0.0  | 10.0        |
      | 7  | 31   | 20261111  |                 | 90.0            | 10.0          | 0.0      | 0.0  | 0.0       | 10.0 | 0.0  | 0.0        | 0.0  | 10.0        |
      | 8  | 30   | 20261211  |                 | 80.0            | 10.0          | 0.0      | 0.0  | 0.0       | 10.0 | 0.0  | 0.0        | 0.0  | 10.0        |
      | 9  | 31   | 20270111   |                 | 70.0            | 10.0          | 0.0      | 0.0  | 0.0       | 10.0 | 0.0  | 0.0        | 0.0  | 10.0        |
      | 10 | 31   | 20270211  |                 | 60.0            | 10.0          | 0.0      | 0.0  | 0.0       | 10.0 | 0.0  | 0.0        | 0.0  | 10.0        |
      | 11 | 28   | 20270311     |                 | 50.0            | 10.0          | 0.0      | 0.0  | 0.0       | 10.0 | 0.0  | 0.0        | 0.0  | 10.0        |
      | 12 | 31   | 20270411     |                 | 40.0            | 10.0          | 0.0      | 0.0  | 0.0       | 10.0 | 0.0  | 0.0        | 0.0  | 10.0        |
      | 13 | 30   | 20270511       |                 | 30.0            | 10.0          | 0.0      | 0.0  | 0.0       | 10.0 | 0.0  | 0.0        | 0.0  | 10.0        |
      | 14 | 31   | 20270611      |                 | 20.0            | 10.0          | 0.0      | 0.0  | 0.0       | 10.0 | 0.0  | 0.0        | 0.0  | 10.0        |
      | 15 | 30   | 20270711      |                 | 10.0            | 10.0          | 0.0      | 0.0  | 0.0       | 10.0 | 0.0  | 0.0        | 0.0  | 10.0        |
      | 16 | 31   | 20270811    |                 | 0.0             | 10.0          | 0.0      | 0.0  | 0.0       | 10.0 | 0.0  | 0.0        | 0.0  | 10.0        |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      | 150.0         | 0.0      | 0.0  | 0.0       | 150.0 | 0.0  | 0.0        | 0.0  | 150.0       |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20260121  | Disbursement     | 150.0  | 0.0       | 0.0      | 0.0  | 0.0       | 150.0        | false    |
      | 20260123  | Re-age           | 150.0  | 150.0     | 0.0      | 0.0  | 0.0       | 0.0          | false    |

  @TestRailId:C85190
  Scenario: Verify that reschedule after ReAge produces correct schedule and balance for non-interest bearing single-installment product - UC2: business date change before 2nd reschedule
    When Admin sets the business date to "20260121"
    When Admin creates a client with random data
    When Admin set "LP1_ADV_PMT_ALLOC_PROGRESSIVE_LOAN_SCHEDULE_HORIZONTAL" loan product "DEFAULT" transaction type to "NEXT_INSTALLMENT" future installment allocation rule
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                            | submitted on date | with Principal | ANNUAL interest rate % | interest type | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP1_ADV_PMT_ALLOC_PROGRESSIVE_LOAN_SCHEDULE_HORIZONTAL | 20260121   | 150            | 0                      | FLAT          | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 30                | DAYS                  | 30             | DAYS                   | 1                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20260121" with "150" amount and expected disbursement date on "20260121"
    When Admin successfully disburse the loan on "20260121" with "150" EUR transaction amount
    Then Loan has 150.0 outstanding amount
    Then Loan Repayment schedule has 1 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20260121  |           | 150.0           |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 30   | 20260220 |           | 0.0             | 150.0         | 0.0      | 0.0  | 0.0       | 150.0 | 0.0  | 0.0        | 0.0  | 150.0       |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      | 150.0         | 0.0      | 0.0  | 0.0       | 150.0 | 0.0  | 0.0        | 0.0  | 150.0       |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20260121  | Disbursement     | 150.0  | 0.0       | 0.0      | 0.0  | 0.0       | 150.0        | false    |
    # --- Step 1: Reschedule (push 20 Feb installment to 22 Mar) ---
    When Admin sets the business date to "20260123"
    When Admin creates and approves Loan reschedule with the following data:
      | rescheduleFromDate | submittedOnDate | adjustedDueDate | graceOnPrincipal | graceOnInterest | extraTerms | newInterestRate |
      | 20260220   | 20260123 | 20260322   |                  |                 |            |                 |
    Then Loan has 150.0 outstanding amount
    And Loan Repayment schedule has 1 periods, with the following data for periods:
      | Nr | Days | Date            | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20260121 |           | 150.0           |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 60   | 20260322   |           | 0.0             | 150.0         | 0.0      | 0.0  | 0.0       | 150.0 | 0.0  | 0.0        | 0.0  | 150.0       |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      | 150.0         | 0.0      | 0.0  | 0.0       | 150.0 | 0.0  | 0.0        | 0.0  | 150.0       |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20260121  | Disbursement     | 150.0  | 0.0       | 0.0      | 0.0  | 0.0       | 150.0        | false    |
    # --- Step 2: ReAge for 15 monthly installments starting 20260322 ---
    When Admin creates a Loan re-aging transaction with the following data:
      | frequencyNumber | frequencyType | startDate     | numberOfInstallments | reAgeInterestHandling |
      | 1               | MONTHS        | 20260322 | 15                   | DEFAULT               |
    Then Loan has 150.0 outstanding amount
    And Loan Repayment schedule has 16 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due  | Paid | In advance | Late | Outstanding |
      |    |      | 20260121   |                 | 150.0           |               |          | 0.0  |           | 0.0  | 0.0  |            |      |             |
      | 1  | 2    | 20260123   | 20260123 | 150.0           | 0.0           | 0.0      | 0.0  | 0.0       | 0.0  | 0.0  | 0.0        | 0.0  | 0.0         |
      | 2  | 58   | 20260322     |                 | 140.0           | 10.0          | 0.0      | 0.0  | 0.0       | 10.0 | 0.0  | 0.0        | 0.0  | 10.0        |
      | 3  | 31   | 20260422     |                 | 130.0           | 10.0          | 0.0      | 0.0  | 0.0       | 10.0 | 0.0  | 0.0        | 0.0  | 10.0        |
      | 4  | 30   | 20260522       |                 | 120.0           | 10.0          | 0.0      | 0.0  | 0.0       | 10.0 | 0.0  | 0.0        | 0.0  | 10.0        |
      | 5  | 31   | 20260622      |                 | 110.0           | 10.0          | 0.0      | 0.0  | 0.0       | 10.0 | 0.0  | 0.0        | 0.0  | 10.0        |
      | 6  | 30   | 20260722      |                 | 100.0           | 10.0          | 0.0      | 0.0  | 0.0       | 10.0 | 0.0  | 0.0        | 0.0  | 10.0        |
      | 7  | 31   | 20260822    |                 | 90.0            | 10.0          | 0.0      | 0.0  | 0.0       | 10.0 | 0.0  | 0.0        | 0.0  | 10.0        |
      | 8  | 31   | 20260922 |                 | 80.0            | 10.0          | 0.0      | 0.0  | 0.0       | 10.0 | 0.0  | 0.0        | 0.0  | 10.0        |
      | 9  | 30   | 20261022   |                 | 70.0            | 10.0          | 0.0      | 0.0  | 0.0       | 10.0 | 0.0  | 0.0        | 0.0  | 10.0        |
      | 10 | 31   | 20261122  |                 | 60.0            | 10.0          | 0.0      | 0.0  | 0.0       | 10.0 | 0.0  | 0.0        | 0.0  | 10.0        |
      | 11 | 30   | 20261222  |                 | 50.0            | 10.0          | 0.0      | 0.0  | 0.0       | 10.0 | 0.0  | 0.0        | 0.0  | 10.0        |
      | 12 | 31   | 20270122   |                 | 40.0            | 10.0          | 0.0      | 0.0  | 0.0       | 10.0 | 0.0  | 0.0        | 0.0  | 10.0        |
      | 13 | 31   | 20270222  |                 | 30.0            | 10.0          | 0.0      | 0.0  | 0.0       | 10.0 | 0.0  | 0.0        | 0.0  | 10.0        |
      | 14 | 28   | 20270322     |                 | 20.0            | 10.0          | 0.0      | 0.0  | 0.0       | 10.0 | 0.0  | 0.0        | 0.0  | 10.0        |
      | 15 | 31   | 20270422     |                 | 10.0            | 10.0          | 0.0      | 0.0  | 0.0       | 10.0 | 0.0  | 0.0        | 0.0  | 10.0        |
      | 16 | 30   | 20270522       |                 | 0.0             | 10.0          | 0.0      | 0.0  | 0.0       | 10.0 | 0.0  | 0.0        | 0.0  | 10.0        |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      | 150.0         | 0.0      | 0.0  | 0.0       | 150.0 | 0.0  | 0.0        | 0.0  | 150.0       |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20260121  | Disbursement     | 150.0  | 0.0       | 0.0      | 0.0  | 0.0       | 150.0        | false    |
      | 20260123  | Re-age           | 150.0  | 150.0     | 0.0      | 0.0  | 0.0       | 0.0          | false    |
    # --- Step 3: BUG TRIGGER: Reschedule again (push schedule 2 more months: 22 Mar -> 11 June) ---
    When Admin sets the business date to "20260428"
    When Admin creates and approves Loan reschedule with the following data:
      | rescheduleFromDate | submittedOnDate | adjustedDueDate | graceOnPrincipal | graceOnInterest | extraTerms | newInterestRate |
      | 20260522        | 20260428   | 20260611    |                  |                 |            |                 |
    Then Loan has 150.0 outstanding amount
    Then Loan Repayment schedule has 16 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due  | Paid | In advance | Late | Outstanding |
      |    |      | 20260121   |                 | 150.0           |               |          | 0.0  |           | 0.0  | 0.0  |            |      |             |
      | 1  | 2    | 20260123   | 20260123 | 150.0           | 0.0           | 0.0      | 0.0  | 0.0       | 0.0  | 0.0  | 0.0        | 0.0  | 0.0         |
      | 2  | 58   | 20260322     |                 | 140.0           | 10.0          | 0.0      | 0.0  | 0.0       | 10.0 | 0.0  | 0.0        | 0.0  | 10.0        |
      | 3  | 31   | 20260422     |                 | 130.0           | 10.0          | 0.0      | 0.0  | 0.0       | 10.0 | 0.0  | 0.0        | 0.0  | 10.0        |
      | 4  | 50   | 20260611      |                 | 120.0           | 10.0          | 0.0      | 0.0  | 0.0       | 10.0 | 0.0  | 0.0        | 0.0  | 10.0        |
      | 5  | 30   | 20260711      |                 | 110.0           | 10.0          | 0.0      | 0.0  | 0.0       | 10.0 | 0.0  | 0.0        | 0.0  | 10.0        |
      | 6  | 31   | 20260811    |                 | 100.0           | 10.0          | 0.0      | 0.0  | 0.0       | 10.0 | 0.0  | 0.0        | 0.0  | 10.0        |
      | 7  | 31   | 20260911 |                 | 90.0            | 10.0          | 0.0      | 0.0  | 0.0       | 10.0 | 0.0  | 0.0        | 0.0  | 10.0        |
      | 8  | 30   | 20261011   |                 | 80.0            | 10.0          | 0.0      | 0.0  | 0.0       | 10.0 | 0.0  | 0.0        | 0.0  | 10.0        |
      | 9  | 31   | 20261111  |                 | 70.0            | 10.0          | 0.0      | 0.0  | 0.0       | 10.0 | 0.0  | 0.0        | 0.0  | 10.0        |
      | 10 | 30   | 20261211  |                 | 60.0            | 10.0          | 0.0      | 0.0  | 0.0       | 10.0 | 0.0  | 0.0        | 0.0  | 10.0        |
      | 11 | 31   | 20270111   |                 | 50.0            | 10.0          | 0.0      | 0.0  | 0.0       | 10.0 | 0.0  | 0.0        | 0.0  | 10.0        |
      | 12 | 31   | 20270211  |                 | 40.0            | 10.0          | 0.0      | 0.0  | 0.0       | 10.0 | 0.0  | 0.0        | 0.0  | 10.0        |
      | 13 | 28   | 20270311     |                 | 30.0            | 10.0          | 0.0      | 0.0  | 0.0       | 10.0 | 0.0  | 0.0        | 0.0  | 10.0        |
      | 14 | 31   | 20270411     |                 | 20.0            | 10.0          | 0.0      | 0.0  | 0.0       | 10.0 | 0.0  | 0.0        | 0.0  | 10.0        |
      | 15 | 30   | 20270511       |                 | 10.0            | 10.0          | 0.0      | 0.0  | 0.0       | 10.0 | 0.0  | 0.0        | 0.0  | 10.0        |
      | 16 | 31   | 20270611      |                 | 0.0             | 10.0          | 0.0      | 0.0  | 0.0       | 10.0 | 0.0  | 0.0        | 0.0  | 10.0        |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      | 150.0         | 0.0      | 0.0  | 0.0       | 150.0 | 0.0  | 0.0        | 0.0  | 150.0       |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20260121  | Disbursement     | 150.0  | 0.0       | 0.0      | 0.0  | 0.0       | 150.0        | false    |
      | 20260123  | Re-age           | 150.0  | 150.0     | 0.0      | 0.0  | 0.0       | 0.0          | false    |

  @TestRailId:C85191
  Scenario: Verify that reschedule after ReAge produces correct schedule and balance for non-interest bearing single-installment product - UC3: 2nd reAge + 3rd reSchedule added
    When Admin sets the business date to "20260121"
    When Admin creates a client with random data
    When Admin set "LP1_ADV_PMT_ALLOC_PROGRESSIVE_LOAN_SCHEDULE_HORIZONTAL" loan product "DEFAULT" transaction type to "NEXT_INSTALLMENT" future installment allocation rule
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                            | submitted on date | with Principal | ANNUAL interest rate % | interest type | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP1_ADV_PMT_ALLOC_PROGRESSIVE_LOAN_SCHEDULE_HORIZONTAL | 20260121   | 150            | 0                      | FLAT          | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 30                | DAYS                  | 30             | DAYS                   | 1                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20260121" with "150" amount and expected disbursement date on "20260121"
    When Admin successfully disburse the loan on "20260121" with "150" EUR transaction amount
    Then Loan has 150.0 outstanding amount
    Then Loan Repayment schedule has 1 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20260121  |           | 150.0           |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 30   | 20260220 |           | 0.0             | 150.0         | 0.0      | 0.0  | 0.0       | 150.0 | 0.0  | 0.0        | 0.0  | 150.0       |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      | 150.0         | 0.0      | 0.0  | 0.0       | 150.0 | 0.0  | 0.0        | 0.0  | 150.0       |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20260121  | Disbursement     | 150.0  | 0.0       | 0.0      | 0.0  | 0.0       | 150.0        | false    |
    # --- Step 1: Reschedule (push 20 Feb installment to 22 Mar) ---
    When Admin sets the business date to "20260123"
    When Admin creates and approves Loan reschedule with the following data:
      | rescheduleFromDate | submittedOnDate | adjustedDueDate | graceOnPrincipal | graceOnInterest | extraTerms | newInterestRate |
      | 20260220   | 20260123 | 20260322   |                  |                 |            |                 |
    Then Loan has 150.0 outstanding amount
    And Loan Repayment schedule has 1 periods, with the following data for periods:
      | Nr | Days | Date            | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20260121 |           | 150.0           |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 60   | 20260322   |           | 0.0             | 150.0         | 0.0      | 0.0  | 0.0       | 150.0 | 0.0  | 0.0        | 0.0  | 150.0       |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      | 150.0         | 0.0      | 0.0  | 0.0       | 150.0 | 0.0  | 0.0        | 0.0  | 150.0       |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20260121  | Disbursement     | 150.0  | 0.0       | 0.0      | 0.0  | 0.0       | 150.0        | false    |
    # --- Step 2: ReAge for 15 monthly installments starting 20260322 ---
    When Admin creates a Loan re-aging transaction with the following data:
      | frequencyNumber | frequencyType | startDate     | numberOfInstallments | reAgeInterestHandling |
      | 1               | MONTHS        | 20260322 | 15                   | DEFAULT               |
    Then Loan has 150.0 outstanding amount
    And Loan Repayment schedule has 16 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due  | Paid | In advance | Late | Outstanding |
      |    |      | 20260121   |                 | 150.0           |               |          | 0.0  |           | 0.0  | 0.0  |            |      |             |
      | 1  | 2    | 20260123   | 20260123 | 150.0           | 0.0           | 0.0      | 0.0  | 0.0       | 0.0  | 0.0  | 0.0        | 0.0  | 0.0         |
      | 2  | 58   | 20260322     |                 | 140.0           | 10.0          | 0.0      | 0.0  | 0.0       | 10.0 | 0.0  | 0.0        | 0.0  | 10.0        |
      | 3  | 31   | 20260422     |                 | 130.0           | 10.0          | 0.0      | 0.0  | 0.0       | 10.0 | 0.0  | 0.0        | 0.0  | 10.0        |
      | 4  | 30   | 20260522       |                 | 120.0           | 10.0          | 0.0      | 0.0  | 0.0       | 10.0 | 0.0  | 0.0        | 0.0  | 10.0        |
      | 5  | 31   | 20260622      |                 | 110.0           | 10.0          | 0.0      | 0.0  | 0.0       | 10.0 | 0.0  | 0.0        | 0.0  | 10.0        |
      | 6  | 30   | 20260722      |                 | 100.0           | 10.0          | 0.0      | 0.0  | 0.0       | 10.0 | 0.0  | 0.0        | 0.0  | 10.0        |
      | 7  | 31   | 20260822    |                 | 90.0            | 10.0          | 0.0      | 0.0  | 0.0       | 10.0 | 0.0  | 0.0        | 0.0  | 10.0        |
      | 8  | 31   | 20260922 |                 | 80.0            | 10.0          | 0.0      | 0.0  | 0.0       | 10.0 | 0.0  | 0.0        | 0.0  | 10.0        |
      | 9  | 30   | 20261022   |                 | 70.0            | 10.0          | 0.0      | 0.0  | 0.0       | 10.0 | 0.0  | 0.0        | 0.0  | 10.0        |
      | 10 | 31   | 20261122  |                 | 60.0            | 10.0          | 0.0      | 0.0  | 0.0       | 10.0 | 0.0  | 0.0        | 0.0  | 10.0        |
      | 11 | 30   | 20261222  |                 | 50.0            | 10.0          | 0.0      | 0.0  | 0.0       | 10.0 | 0.0  | 0.0        | 0.0  | 10.0        |
      | 12 | 31   | 20270122   |                 | 40.0            | 10.0          | 0.0      | 0.0  | 0.0       | 10.0 | 0.0  | 0.0        | 0.0  | 10.0        |
      | 13 | 31   | 20270222  |                 | 30.0            | 10.0          | 0.0      | 0.0  | 0.0       | 10.0 | 0.0  | 0.0        | 0.0  | 10.0        |
      | 14 | 28   | 20270322     |                 | 20.0            | 10.0          | 0.0      | 0.0  | 0.0       | 10.0 | 0.0  | 0.0        | 0.0  | 10.0        |
      | 15 | 31   | 20270422     |                 | 10.0            | 10.0          | 0.0      | 0.0  | 0.0       | 10.0 | 0.0  | 0.0        | 0.0  | 10.0        |
      | 16 | 30   | 20270522       |                 | 0.0             | 10.0          | 0.0      | 0.0  | 0.0       | 10.0 | 0.0  | 0.0        | 0.0  | 10.0        |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      | 150.0         | 0.0      | 0.0  | 0.0       | 150.0 | 0.0  | 0.0        | 0.0  | 150.0       |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20260121  | Disbursement     | 150.0  | 0.0       | 0.0      | 0.0  | 0.0       | 150.0        | false    |
      | 20260123  | Re-age           | 150.0  | 150.0     | 0.0      | 0.0  | 0.0       | 0.0          | false    |
    # --- Step 3: BUG TRIGGER: Reschedule again (push schedule 2 more months: 22 Mar -> 11 June) ---
    When Admin creates and approves Loan reschedule with the following data:
      | rescheduleFromDate | submittedOnDate | adjustedDueDate | graceOnPrincipal | graceOnInterest | extraTerms | newInterestRate |
      | 20260322      | 20260123 | 20260611    |                  |                 |            |                 |
    Then Loan has 150.0 outstanding amount
    Then Loan Repayment schedule has 16 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due  | Paid | In advance | Late | Outstanding |
      |    |      | 20260121   |                 | 150.0           |               |          | 0.0  |           | 0.0  | 0.0  |            |      |             |
      | 1  | 2    | 20260123   | 20260123 | 150.0           | 0.0           | 0.0      | 0.0  | 0.0       | 0.0  | 0.0  | 0.0        | 0.0  | 0.0         |
      | 2  | 139  | 20260611      |                 | 140.0           | 10.0          | 0.0      | 0.0  | 0.0       | 10.0 | 0.0  | 0.0        | 0.0  | 10.0        |
      | 3  | 30   | 20260711      |                 | 130.0           | 10.0          | 0.0      | 0.0  | 0.0       | 10.0 | 0.0  | 0.0        | 0.0  | 10.0        |
      | 4  | 31   | 20260811    |                 | 120.0           | 10.0          | 0.0      | 0.0  | 0.0       | 10.0 | 0.0  | 0.0        | 0.0  | 10.0        |
      | 5  | 31   | 20260911 |                 | 110.0           | 10.0          | 0.0      | 0.0  | 0.0       | 10.0 | 0.0  | 0.0        | 0.0  | 10.0        |
      | 6  | 30   | 20261011   |                 | 100.0           | 10.0          | 0.0      | 0.0  | 0.0       | 10.0 | 0.0  | 0.0        | 0.0  | 10.0        |
      | 7  | 31   | 20261111  |                 | 90.0            | 10.0          | 0.0      | 0.0  | 0.0       | 10.0 | 0.0  | 0.0        | 0.0  | 10.0        |
      | 8  | 30   | 20261211  |                 | 80.0            | 10.0          | 0.0      | 0.0  | 0.0       | 10.0 | 0.0  | 0.0        | 0.0  | 10.0        |
      | 9  | 31   | 20270111   |                 | 70.0            | 10.0          | 0.0      | 0.0  | 0.0       | 10.0 | 0.0  | 0.0        | 0.0  | 10.0        |
      | 10 | 31   | 20270211  |                 | 60.0            | 10.0          | 0.0      | 0.0  | 0.0       | 10.0 | 0.0  | 0.0        | 0.0  | 10.0        |
      | 11 | 28   | 20270311     |                 | 50.0            | 10.0          | 0.0      | 0.0  | 0.0       | 10.0 | 0.0  | 0.0        | 0.0  | 10.0        |
      | 12 | 31   | 20270411     |                 | 40.0            | 10.0          | 0.0      | 0.0  | 0.0       | 10.0 | 0.0  | 0.0        | 0.0  | 10.0        |
      | 13 | 30   | 20270511       |                 | 30.0            | 10.0          | 0.0      | 0.0  | 0.0       | 10.0 | 0.0  | 0.0        | 0.0  | 10.0        |
      | 14 | 31   | 20270611      |                 | 20.0            | 10.0          | 0.0      | 0.0  | 0.0       | 10.0 | 0.0  | 0.0        | 0.0  | 10.0        |
      | 15 | 30   | 20270711      |                 | 10.0            | 10.0          | 0.0      | 0.0  | 0.0       | 10.0 | 0.0  | 0.0        | 0.0  | 10.0        |
      | 16 | 31   | 20270811    |                 | 0.0             | 10.0          | 0.0      | 0.0  | 0.0       | 10.0 | 0.0  | 0.0        | 0.0  | 10.0        |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      | 150.0         | 0.0      | 0.0  | 0.0       | 150.0 | 0.0  | 0.0        | 0.0  | 150.0       |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20260121  | Disbursement     | 150.0  | 0.0       | 0.0      | 0.0  | 0.0       | 150.0        | false    |
      | 20260123  | Re-age           | 150.0  | 150.0     | 0.0      | 0.0  | 0.0       | 0.0          | false    |
#   --- After 2nd reAge + 3rd reSchedule added Repayment Schedule should follow the last reAge data (eg: frequencyType and numberOfInstallments) ---
    When Admin sets the business date to "20260124"
    When Admin creates a Loan re-aging transaction with the following data:
      | frequencyNumber | frequencyType | startDate    | numberOfInstallments | reAgeInterestHandling |
      | 1               | WEEKS         | 20260611 | 10                   | DEFAULT               |
    Then Loan Repayment schedule has 11 periods, with the following data for periods:
      | Nr | Days | Date            | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due  | Paid | In advance | Late | Outstanding |
      |    |      | 20260121 |                 | 150.0           |               |          | 0.0  |           | 0.0  | 0.0  |            |      |             |
      | 1  | 3    | 20260124 | 20260124 | 150.0           | 0.0           | 0.0      | 0.0  | 0.0       | 0.0  | 0.0  | 0.0        | 0.0  | 0.0         |
      | 2  | 138  | 20260611    |                 | 135.0           | 15.0          | 0.0      | 0.0  | 0.0       | 15.0 | 0.0  | 0.0        | 0.0  | 15.0        |
      | 3  | 7    | 20260618    |                 | 120.0           | 15.0          | 0.0      | 0.0  | 0.0       | 15.0 | 0.0  | 0.0        | 0.0  | 15.0        |
      | 4  | 7    | 20260625    |                 | 105.0           | 15.0          | 0.0      | 0.0  | 0.0       | 15.0 | 0.0  | 0.0        | 0.0  | 15.0        |
      | 5  | 7    | 20260702    |                 | 90.0            | 15.0          | 0.0      | 0.0  | 0.0       | 15.0 | 0.0  | 0.0        | 0.0  | 15.0        |
      | 6  | 7    | 20260709    |                 | 75.0            | 15.0          | 0.0      | 0.0  | 0.0       | 15.0 | 0.0  | 0.0        | 0.0  | 15.0        |
      | 7  | 7    | 20260716    |                 | 60.0            | 15.0          | 0.0      | 0.0  | 0.0       | 15.0 | 0.0  | 0.0        | 0.0  | 15.0        |
      | 8  | 7    | 20260723    |                 | 45.0            | 15.0          | 0.0      | 0.0  | 0.0       | 15.0 | 0.0  | 0.0        | 0.0  | 15.0        |
      | 9  | 7    | 20260730    |                 | 30.0            | 15.0          | 0.0      | 0.0  | 0.0       | 15.0 | 0.0  | 0.0        | 0.0  | 15.0        |
      | 10 | 7    | 20260806  |                 | 15.0            | 15.0          | 0.0      | 0.0  | 0.0       | 15.0 | 0.0  | 0.0        | 0.0  | 15.0        |
      | 11 | 7    | 20260813  |                 | 0.0             | 15.0          | 0.0      | 0.0  | 0.0       | 15.0 | 0.0  | 0.0        | 0.0  | 15.0        |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      | 150.0         | 0.0      | 0.0  | 0.0       | 150.0 | 0.0  | 0.0        | 0.0  | 150.0       |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20260121  | Disbursement     | 150.0  | 0.0       | 0.0      | 0.0  | 0.0       | 150.0        | false    |
      | 20260123  | Re-age           | 150.0  | 150.0     | 0.0      | 0.0  | 0.0       | 0.0          | false    |
      | 20260124  | Re-age           | 150.0  | 150.0     | 0.0      | 0.0  | 0.0       | 0.0          | false    |
    When Admin creates and approves Loan reschedule with the following data:
      | rescheduleFromDate | submittedOnDate | adjustedDueDate | graceOnPrincipal | graceOnInterest | extraTerms | newInterestRate |
      | 20260611       | 20260124 | 20260613    |                  |                 |            |                 |
    Then Loan Repayment schedule has 11 periods, with the following data for periods:
      | Nr | Days | Date            | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due  | Paid | In advance | Late | Outstanding |
      |    |      | 20260121 |                 | 150.0           |               |          | 0.0  |           | 0.0  | 0.0  |            |      |             |
      | 1  | 3    | 20260124 | 20260124 | 150.0           | 0.0           | 0.0      | 0.0  | 0.0       | 0.0  | 0.0  | 0.0        | 0.0  | 0.0         |
      | 2  | 140  | 20260613    |                 | 135.0           | 15.0          | 0.0      | 0.0  | 0.0       | 15.0 | 0.0  | 0.0        | 0.0  | 15.0        |
      | 3  | 7    | 20260620    |                 | 120.0           | 15.0          | 0.0      | 0.0  | 0.0       | 15.0 | 0.0  | 0.0        | 0.0  | 15.0        |
      | 4  | 7    | 20260627    |                 | 105.0           | 15.0          | 0.0      | 0.0  | 0.0       | 15.0 | 0.0  | 0.0        | 0.0  | 15.0        |
      | 5  | 7    | 20260704    |                 | 90.0            | 15.0          | 0.0      | 0.0  | 0.0       | 15.0 | 0.0  | 0.0        | 0.0  | 15.0        |
      | 6  | 7    | 20260711    |                 | 75.0            | 15.0          | 0.0      | 0.0  | 0.0       | 15.0 | 0.0  | 0.0        | 0.0  | 15.0        |
      | 7  | 7    | 20260718    |                 | 60.0            | 15.0          | 0.0      | 0.0  | 0.0       | 15.0 | 0.0  | 0.0        | 0.0  | 15.0        |
      | 8  | 7    | 20260725    |                 | 45.0            | 15.0          | 0.0      | 0.0  | 0.0       | 15.0 | 0.0  | 0.0        | 0.0  | 15.0        |
      | 9  | 7    | 20260801  |                 | 30.0            | 15.0          | 0.0      | 0.0  | 0.0       | 15.0 | 0.0  | 0.0        | 0.0  | 15.0        |
      | 10 | 7    | 20260808  |                 | 15.0            | 15.0          | 0.0      | 0.0  | 0.0       | 15.0 | 0.0  | 0.0        | 0.0  | 15.0        |
      | 11 | 7    | 20260815  |                 | 0.0             | 15.0          | 0.0      | 0.0  | 0.0       | 15.0 | 0.0  | 0.0        | 0.0  | 15.0        |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      | 150.0         | 0.0      | 0.0  | 0.0       | 150.0 | 0.0  | 0.0        | 0.0  | 150.0       |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20260121  | Disbursement     | 150.0  | 0.0       | 0.0      | 0.0  | 0.0       | 150.0        | false    |
      | 20260123  | Re-age           | 150.0  | 150.0     | 0.0      | 0.0  | 0.0       | 0.0          | false    |
      | 20260124  | Re-age           | 150.0  | 150.0     | 0.0      | 0.0  | 0.0       | 0.0          | false    |

  @TestRailId:C85192
  Scenario: Verify that reschedule after ReAge produces correct schedule and balance for INTEREST bearing progressive loan product
    When Admin sets the business date to "20260121"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                        | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_EMI_360_30_INTEREST_RECALCULATION_DAILY_TILL_PRECLOSE | 20260121   | 150            | 12                     | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 30                | DAYS                  | 30             | DAYS                   | 1                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20260121" with "150" amount and expected disbursement date on "20260121"
    When Admin successfully disburse the loan on "20260121" with "150" EUR transaction amount
    Then Loan has 151.5 outstanding amount
    Then Loan Repayment schedule has 1 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20260121  |           | 150.0           |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 30   | 20260220 |           | 0.0             | 150.0         | 1.5      | 0.0  | 0.0       | 151.5 | 0.0  | 0.0        | 0.0  | 151.5       |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      | 150.0         | 1.5      | 0.0  | 0.0       | 151.5 | 0.0  | 0.0        | 0.0  | 151.5       |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20260121  | Disbursement     | 150.0  | 0.0       | 0.0      | 0.0  | 0.0       | 150.0        | false    |
    # --- Step 1: Reschedule (push 20 Feb installment to 22 Mar) ---
    When Admin sets the business date to "20260123"
    When Admin creates and approves Loan reschedule with the following data:
      | rescheduleFromDate | submittedOnDate | adjustedDueDate | graceOnPrincipal | graceOnInterest | extraTerms | newInterestRate |
      | 20260220   | 20260123 | 20260322   |                  |                 |            |                 |
    Then Loan has 153.0 outstanding amount
    And Loan Repayment schedule has 1 periods, with the following data for periods:
      | Nr | Days | Date            | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20260121 |           | 150.0           |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 60   | 20260322   |           | 0.0             | 150.0         | 3.0      | 0.0  | 0.0       | 153.0 | 0.0  | 0.0        | 0.0  | 153.0       |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      | 150.0         | 3.0      | 0.0  | 0.0       | 153.0 | 0.0  | 0.0        | 0.0  | 153.0       |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20260121  | Disbursement     | 150.0  | 0.0       | 0.0      | 0.0  | 0.0       | 150.0        | false    |
    # --- Step 2: ReAge for 15 monthly installments starting 20260322 ---
    When Admin creates a Loan re-aging transaction with the following data:
      | frequencyNumber | frequencyType | startDate     | numberOfInstallments | reAgeInterestHandling |
      | 1               | MONTHS        | 20260322 | 15                   | DEFAULT               |
    Then Loan has 164.09 outstanding amount
    And Loan Repayment schedule has 16 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20260121   |                 | 150.0           |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 2    | 20260123   | 20260123 | 150.0           | 0.0           | 0.0      | 0.0  | 0.0       | 0.0   | 0.0  | 0.0        | 0.0  | 0.0         |
      | 2  | 58   | 20260322     |                 | 142.06          | 7.94          | 3.0      | 0.0  | 0.0       | 10.94 | 0.0  | 0.0        | 0.0  | 10.94       |
      | 3  | 31   | 20260422     |                 | 132.59          | 9.47          | 1.47     | 0.0  | 0.0       | 10.94 | 0.0  | 0.0        | 0.0  | 10.94       |
      | 4  | 30   | 20260522       |                 | 122.98          | 9.61          | 1.33     | 0.0  | 0.0       | 10.94 | 0.0  | 0.0        | 0.0  | 10.94       |
      | 5  | 31   | 20260622      |                 | 113.31          | 9.67          | 1.27     | 0.0  | 0.0       | 10.94 | 0.0  | 0.0        | 0.0  | 10.94       |
      | 6  | 30   | 20260722      |                 | 103.5           | 9.81          | 1.13     | 0.0  | 0.0       | 10.94 | 0.0  | 0.0        | 0.0  | 10.94       |
      | 7  | 31   | 20260822    |                 | 93.63           | 9.87          | 1.07     | 0.0  | 0.0       | 10.94 | 0.0  | 0.0        | 0.0  | 10.94       |
      | 8  | 31   | 20260922 |                 | 83.66           | 9.97          | 0.97     | 0.0  | 0.0       | 10.94 | 0.0  | 0.0        | 0.0  | 10.94       |
      | 9  | 30   | 20261022   |                 | 73.56           | 10.1          | 0.84     | 0.0  | 0.0       | 10.94 | 0.0  | 0.0        | 0.0  | 10.94       |
      | 10 | 31   | 20261122  |                 | 63.38           | 10.18         | 0.76     | 0.0  | 0.0       | 10.94 | 0.0  | 0.0        | 0.0  | 10.94       |
      | 11 | 30   | 20261222  |                 | 53.07           | 10.31         | 0.63     | 0.0  | 0.0       | 10.94 | 0.0  | 0.0        | 0.0  | 10.94       |
      | 12 | 31   | 20270122   |                 | 42.68           | 10.39         | 0.55     | 0.0  | 0.0       | 10.94 | 0.0  | 0.0        | 0.0  | 10.94       |
      | 13 | 31   | 20270222  |                 | 32.18           | 10.5          | 0.44     | 0.0  | 0.0       | 10.94 | 0.0  | 0.0        | 0.0  | 10.94       |
      | 14 | 28   | 20270322     |                 | 21.54           | 10.64         | 0.3      | 0.0  | 0.0       | 10.94 | 0.0  | 0.0        | 0.0  | 10.94       |
      | 15 | 31   | 20270422     |                 | 10.82           | 10.72         | 0.22     | 0.0  | 0.0       | 10.94 | 0.0  | 0.0        | 0.0  | 10.94       |
      | 16 | 30   | 20270522       |                 | 0.0             | 10.82         | 0.11     | 0.0  | 0.0       | 10.93 | 0.0  | 0.0        | 0.0  | 10.93       |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 150.0         | 14.09    | 0.0  | 0.0       | 164.09 | 0.0  | 0.0        | 0.0  | 164.09      |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20260121  | Disbursement     | 150.0  | 0.0       | 0.0      | 0.0  | 0.0       | 150.0        | false    |
      | 20260123  | Re-age           | 150.1  | 150.0     | 0.1      | 0.0  | 0.0       | 0.0          | false    |
    # --- Step 3: BUG TRIGGER: Reschedule again (push schedule 2 more months: 22 Mar -> 11 June) ---
    When Admin creates and approves Loan reschedule with the following data:
      | rescheduleFromDate | submittedOnDate | adjustedDueDate | graceOnPrincipal | graceOnInterest | extraTerms | newInterestRate |
      | 20260322      | 20260123 | 20260611    |                  |                 |            |                 |
    Then Loan has 168.69 outstanding amount
    Then Loan Repayment schedule has 16 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20260121   |                 | 150.0           |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 2    | 20260123   | 20260123 | 150.0           | 0.0           | 0.0      | 0.0  | 0.0       | 0.0   | 0.0  | 0.0        | 0.0  | 0.0         |
      | 2  | 139  | 20260611      |                 | 146.11          | 3.89          | 7.05     | 0.0  | 0.0       | 10.94 | 0.0  | 0.0        | 0.0  | 10.94       |
      | 3  | 30   | 20260711      |                 | 136.63          | 9.48          | 1.46     | 0.0  | 0.0       | 10.94 | 0.0  | 0.0        | 0.0  | 10.94       |
      | 4  | 31   | 20260811    |                 | 127.1           | 9.53          | 1.41     | 0.0  | 0.0       | 10.94 | 0.0  | 0.0        | 0.0  | 10.94       |
      | 5  | 31   | 20260911 |                 | 117.47          | 9.63          | 1.31     | 0.0  | 0.0       | 10.94 | 0.0  | 0.0        | 0.0  | 10.94       |
      | 6  | 30   | 20261011   |                 | 107.7           | 9.77          | 1.17     | 0.0  | 0.0       | 10.94 | 0.0  | 0.0        | 0.0  | 10.94       |
      | 7  | 31   | 20261111  |                 | 97.87           | 9.83          | 1.11     | 0.0  | 0.0       | 10.94 | 0.0  | 0.0        | 0.0  | 10.94       |
      | 8  | 30   | 20261211  |                 | 87.91           | 9.96          | 0.98     | 0.0  | 0.0       | 10.94 | 0.0  | 0.0        | 0.0  | 10.94       |
      | 9  | 31   | 20270111   |                 | 77.88           | 10.03         | 0.91     | 0.0  | 0.0       | 10.94 | 0.0  | 0.0        | 0.0  | 10.94       |
      | 10 | 31   | 20270211  |                 | 67.74           | 10.14         | 0.8      | 0.0  | 0.0       | 10.94 | 0.0  | 0.0        | 0.0  | 10.94       |
      | 11 | 28   | 20270311     |                 | 57.43           | 10.31         | 0.63     | 0.0  | 0.0       | 10.94 | 0.0  | 0.0        | 0.0  | 10.94       |
      | 12 | 31   | 20270411     |                 | 47.08           | 10.35         | 0.59     | 0.0  | 0.0       | 10.94 | 0.0  | 0.0        | 0.0  | 10.94       |
      | 13 | 30   | 20270511       |                 | 36.61           | 10.47         | 0.47     | 0.0  | 0.0       | 10.94 | 0.0  | 0.0        | 0.0  | 10.94       |
      | 14 | 31   | 20270611      |                 | 26.05           | 10.56         | 0.38     | 0.0  | 0.0       | 10.94 | 0.0  | 0.0        | 0.0  | 10.94       |
      | 15 | 30   | 20270711      |                 | 15.37           | 10.68         | 0.26     | 0.0  | 0.0       | 10.94 | 0.0  | 0.0        | 0.0  | 10.94       |
      | 16 | 31   | 20270811    |                 | 0.0             | 15.37         | 0.16     | 0.0  | 0.0       | 15.53 | 0.0  | 0.0        | 0.0  | 15.53       |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 150.0         | 18.69    | 0.0  | 0.0       | 168.69 | 0.0  | 0.0        | 0.0  | 168.69      |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20260121  | Disbursement     | 150.0  | 0.0       | 0.0      | 0.0  | 0.0       | 150.0        | false    |
      | 20260123  | Re-age           | 150.1  | 150.0     | 0.1      | 0.0  | 0.0       | 0.0          | false    |

  @TestRailId:C85269
  Scenario: Verify that reschedule after ReAge produces correct schedule and balance for non-interest bearing single-installment product - UC4: 2nd reAge DEFAULT
    When Admin sets the business date to "20260610"
    When Admin creates a client with random data
    When Admin set "LP1_ADV_PMT_ALLOC_PROGRESSIVE_LOAN_SCHEDULE_HORIZONTAL" loan product "DEFAULT" transaction type to "NEXT_INSTALLMENT" future installment allocation rule
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                            | submitted on date | with Principal | ANNUAL interest rate % | interest type | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP1_ADV_PMT_ALLOC_PROGRESSIVE_LOAN_SCHEDULE_HORIZONTAL | 20260531       | 150            | 0                      | FLAT          | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 30                | DAYS                  | 30             | DAYS                   | 1                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20260531" with "150" amount and expected disbursement date on "20260531"
    When Admin successfully disburse the loan on "20260531" with "150" EUR transaction amount
    Then Loan has 150.0 outstanding amount
    Then Loan Repayment schedule has 1 periods, with the following data for periods:
      | Nr | Days | Date         | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20260531  |           | 150.0           |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 30   | 20260630 |           | 0.0             | 150.0         | 0.0      | 0.0  | 0.0       | 150.0 | 0.0  | 0.0        | 0.0  | 150.0       |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      | 150.0         | 0.0      | 0.0  | 0.0       | 150.0 | 0.0  | 0.0        | 0.0  | 150.0       |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20260531      | Disbursement     | 150.0  | 0.0       | 0.0      | 0.0  | 0.0       | 150.0        | false    |
    # --- Step 1: Reschedule #1 date  : 2026-06-30  (from: 2026-06-30 → adjusted: 2026-09-30) ---
    When Admin creates and approves Loan reschedule with the following data:
      | rescheduleFromDate | submittedOnDate | adjustedDueDate   | graceOnPrincipal | graceOnInterest | extraTerms | newInterestRate |
      | 20260630       | 20260610    | 20260930 |                  |                 |            |                 |
    Then Loan has 150.0 outstanding amount
    Then Loan Repayment schedule has 1 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20260531       |           | 150.0           |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 122  | 20260930 |           | 0.0             | 150.0         | 0.0      | 0.0  | 0.0       | 150.0 | 0.0  | 0.0        | 0.0  | 150.0       |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      | 150.0         | 0.0      | 0.0  | 0.0       | 150.0 | 0.0  | 0.0        | 0.0  | 150.0       |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20260531      | Disbursement     | 150.0  | 0.0       | 0.0      | 0.0  | 0.0       | 150.0        | false    |
    # --- Step 2: ReAge for 15 monthly installments starting 20260322 ---
    When Admin creates a Loan re-aging transaction with the following data:
      | frequencyNumber | frequencyType | startDate    | numberOfInstallments | reAgeInterestHandling |
      | 1               | MONTHS        | 20260612 | 15                   | DEFAULT               |
    Then Loan has 150.0 outstanding amount
    And Loan Repayment schedule has 16 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date    | Balance of loan | Principal due | Interest | Fees | Penalties | Due  | Paid | In advance | Late | Outstanding |
      |    |      | 20260531       |              | 150.0           |               |          | 0.0  |           | 0.0  | 0.0  |            |      |             |
      | 1  | 10   | 20260610      | 20260610 | 150.0           | 0.0           | 0.0      | 0.0  | 0.0       | 0.0  | 0.0  | 0.0        | 0.0  | 0.0         |
      | 2  | 2    | 20260612      |              | 140.0           | 10.0          | 0.0      | 0.0  | 0.0       | 10.0 | 0.0  | 0.0        | 0.0  | 10.0        |
      | 3  | 30   | 20260712      |              | 130.0           | 10.0          | 0.0      | 0.0  | 0.0       | 10.0 | 0.0  | 0.0        | 0.0  | 10.0        |
      | 4  | 31   | 20260812    |              | 120.0           | 10.0          | 0.0      | 0.0  | 0.0       | 10.0 | 0.0  | 0.0        | 0.0  | 10.0        |
      | 5  | 31   | 20260912 |              | 110.0           | 10.0          | 0.0      | 0.0  | 0.0       | 10.0 | 0.0  | 0.0        | 0.0  | 10.0        |
      | 6  | 30   | 20261012   |              | 100.0           | 10.0          | 0.0      | 0.0  | 0.0       | 10.0 | 0.0  | 0.0        | 0.0  | 10.0        |
      | 7  | 31   | 20261112  |              | 90.0            | 10.0          | 0.0      | 0.0  | 0.0       | 10.0 | 0.0  | 0.0        | 0.0  | 10.0        |
      | 8  | 30   | 20261212  |              | 80.0            | 10.0          | 0.0      | 0.0  | 0.0       | 10.0 | 0.0  | 0.0        | 0.0  | 10.0        |
      | 9  | 31   | 20270112   |              | 70.0            | 10.0          | 0.0      | 0.0  | 0.0       | 10.0 | 0.0  | 0.0        | 0.0  | 10.0        |
      | 10 | 31   | 20270212  |              | 60.0            | 10.0          | 0.0      | 0.0  | 0.0       | 10.0 | 0.0  | 0.0        | 0.0  | 10.0        |
      | 11 | 28   | 20270312     |              | 50.0            | 10.0          | 0.0      | 0.0  | 0.0       | 10.0 | 0.0  | 0.0        | 0.0  | 10.0        |
      | 12 | 31   | 20270412     |              | 40.0            | 10.0          | 0.0      | 0.0  | 0.0       | 10.0 | 0.0  | 0.0        | 0.0  | 10.0        |
      | 13 | 30   | 20270512       |              | 30.0            | 10.0          | 0.0      | 0.0  | 0.0       | 10.0 | 0.0  | 0.0        | 0.0  | 10.0        |
      | 14 | 31   | 20270612      |              | 20.0            | 10.0          | 0.0      | 0.0  | 0.0       | 10.0 | 0.0  | 0.0        | 0.0  | 10.0        |
      | 15 | 30   | 20270712      |              | 10.0            | 10.0          | 0.0      | 0.0  | 0.0       | 10.0 | 0.0  | 0.0        | 0.0  | 10.0        |
      | 16 | 31   | 20270812    |              | 0.0             | 10.0          | 0.0      | 0.0  | 0.0       | 10.0 | 0.0  | 0.0        | 0.0  | 10.0        |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      | 150.0         | 0.0      | 0.0  | 0.0       | 150.0 | 0.0  | 0.0        | 0.0  | 150.0       |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20260531      | Disbursement     | 150.0  | 0.0       | 0.0      | 0.0  | 0.0       | 150.0        | false    |
      | 20260610     | Re-age           | 150.0  | 150.0     | 0.0      | 0.0  | 0.0       | 0.0          | false    |
    # --- Step 3: Reschedule again (push schedule 2 more months: 12 June -> 23 June) ---
    When Admin creates and approves Loan reschedule with the following data:
      | rescheduleFromDate | submittedOnDate | adjustedDueDate | graceOnPrincipal | graceOnInterest | extraTerms | newInterestRate |
      | 20260612       | 20260610    | 20260623    |                  |                 |            |                 |
    Then Loan Repayment schedule has 16 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date    | Balance of loan | Principal due | Interest | Fees | Penalties | Due  | Paid | In advance | Late | Outstanding |
      |    |      | 20260531       |              | 150.0           |               |          | 0.0  |           | 0.0  | 0.0  |            |      |             |
      | 1  | 10   | 20260610      | 20260610 | 150.0           | 0.0           | 0.0      | 0.0  | 0.0       | 0.0  | 0.0  | 0.0        | 0.0  | 0.0         |
      | 2  | 13   | 20260623      |              | 140.0           | 10.0          | 0.0      | 0.0  | 0.0       | 10.0 | 0.0  | 0.0        | 0.0  | 10.0        |
      | 3  | 30   | 20260723      |              | 130.0           | 10.0          | 0.0      | 0.0  | 0.0       | 10.0 | 0.0  | 0.0        | 0.0  | 10.0        |
      | 4  | 31   | 20260823    |              | 120.0           | 10.0          | 0.0      | 0.0  | 0.0       | 10.0 | 0.0  | 0.0        | 0.0  | 10.0        |
      | 5  | 31   | 20260923 |              | 110.0           | 10.0          | 0.0      | 0.0  | 0.0       | 10.0 | 0.0  | 0.0        | 0.0  | 10.0        |
      | 6  | 30   | 20261023   |              | 100.0           | 10.0          | 0.0      | 0.0  | 0.0       | 10.0 | 0.0  | 0.0        | 0.0  | 10.0        |
      | 7  | 31   | 20261123  |              | 90.0            | 10.0          | 0.0      | 0.0  | 0.0       | 10.0 | 0.0  | 0.0        | 0.0  | 10.0        |
      | 8  | 30   | 20261223  |              | 80.0            | 10.0          | 0.0      | 0.0  | 0.0       | 10.0 | 0.0  | 0.0        | 0.0  | 10.0        |
      | 9  | 31   | 20270123   |              | 70.0            | 10.0          | 0.0      | 0.0  | 0.0       | 10.0 | 0.0  | 0.0        | 0.0  | 10.0        |
      | 10 | 31   | 20270223  |              | 60.0            | 10.0          | 0.0      | 0.0  | 0.0       | 10.0 | 0.0  | 0.0        | 0.0  | 10.0        |
      | 11 | 28   | 20270323     |              | 50.0            | 10.0          | 0.0      | 0.0  | 0.0       | 10.0 | 0.0  | 0.0        | 0.0  | 10.0        |
      | 12 | 31   | 20270423     |              | 40.0            | 10.0          | 0.0      | 0.0  | 0.0       | 10.0 | 0.0  | 0.0        | 0.0  | 10.0        |
      | 13 | 30   | 20270523       |              | 30.0            | 10.0          | 0.0      | 0.0  | 0.0       | 10.0 | 0.0  | 0.0        | 0.0  | 10.0        |
      | 14 | 31   | 20270623      |              | 20.0            | 10.0          | 0.0      | 0.0  | 0.0       | 10.0 | 0.0  | 0.0        | 0.0  | 10.0        |
      | 15 | 30   | 20270723      |              | 10.0            | 10.0          | 0.0      | 0.0  | 0.0       | 10.0 | 0.0  | 0.0        | 0.0  | 10.0        |
      | 16 | 31   | 20270823    |              | 0.0             | 10.0          | 0.0      | 0.0  | 0.0       | 10.0 | 0.0  | 0.0        | 0.0  | 10.0        |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      | 150.0         | 0.0      | 0.0  | 0.0       | 150.0 | 0.0  | 0.0        | 0.0  | 150.0       |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20260531      | Disbursement     | 150.0  | 0.0       | 0.0      | 0.0  | 0.0       | 150.0        | false    |
      | 20260610     | Re-age           | 150.0  | 150.0     | 0.0      | 0.0  | 0.0       | 0.0          | false    |

  @TestRailId:C85270
  Scenario: Verify that reschedule after ReAge produces correct schedule and balance for non-interest bearing single-installment product - UC5: 2nd reAge EQUAL_AMORTIZATION_PAYABLE_INTEREST
    When Admin sets the business date to "20260610"
    When Admin creates a client with random data
    When Admin set "LP1_ADV_PMT_ALLOC_PROGRESSIVE_LOAN_SCHEDULE_HORIZONTAL" loan product "DEFAULT" transaction type to "NEXT_INSTALLMENT" future installment allocation rule
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                            | submitted on date | with Principal | ANNUAL interest rate % | interest type | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP1_ADV_PMT_ALLOC_PROGRESSIVE_LOAN_SCHEDULE_HORIZONTAL | 20260531       | 150            | 0                      | FLAT          | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 30                | DAYS                  | 30             | DAYS                   | 1                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20260531" with "150" amount and expected disbursement date on "20260531"
    When Admin successfully disburse the loan on "20260531" with "150" EUR transaction amount
    Then Loan has 150.0 outstanding amount
    Then Loan Repayment schedule has 1 periods, with the following data for periods:
      | Nr | Days | Date         | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20260531  |           | 150.0           |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 30   | 20260630 |           | 0.0             | 150.0         | 0.0      | 0.0  | 0.0       | 150.0 | 0.0  | 0.0        | 0.0  | 150.0       |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      | 150.0         | 0.0      | 0.0  | 0.0       | 150.0 | 0.0  | 0.0        | 0.0  | 150.0       |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20260531      | Disbursement     | 150.0  | 0.0       | 0.0      | 0.0  | 0.0       | 150.0        | false    |
    # --- Step 1: Reschedule #1 date  : 2026-06-30  (from: 2026-06-30 → adjusted: 2026-09-30) ---
    When Admin creates and approves Loan reschedule with the following data:
      | rescheduleFromDate | submittedOnDate | adjustedDueDate   | graceOnPrincipal | graceOnInterest | extraTerms | newInterestRate |
      | 20260630       | 20260610    | 20260930 |                  |                 |            |                 |
    Then Loan has 150.0 outstanding amount
    Then Loan Repayment schedule has 1 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20260531       |           | 150.0           |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 122  | 20260930 |           | 0.0             | 150.0         | 0.0      | 0.0  | 0.0       | 150.0 | 0.0  | 0.0        | 0.0  | 150.0       |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      | 150.0         | 0.0      | 0.0  | 0.0       | 150.0 | 0.0  | 0.0        | 0.0  | 150.0       |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20260531      | Disbursement     | 150.0  | 0.0       | 0.0      | 0.0  | 0.0       | 150.0        | false    |
    # --- Step 2: ReAge for 15 monthly installments starting 20260612 ---
    When Admin creates a Loan re-aging transaction with the following data:
      | frequencyNumber | frequencyType | startDate    | numberOfInstallments | reAgeInterestHandling               |
      | 1               | MONTHS        | 20260612 | 15                   | EQUAL_AMORTIZATION_PAYABLE_INTEREST |
    Then Loan has 150.0 outstanding amount
    And Loan Repayment schedule has 16 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date    | Balance of loan | Principal due | Interest | Fees | Penalties | Due  | Paid | In advance | Late | Outstanding |
      |    |      | 20260531       |              | 150.0           |               |          | 0.0  |           | 0.0  | 0.0  |            |      |             |
      | 1  | 10   | 20260610      | 20260610 | 150.0           | 0.0           | 0.0      | 0.0  | 0.0       | 0.0  | 0.0  | 0.0        | 0.0  | 0.0         |
      | 2  | 2    | 20260612      |              | 140.0           | 10.0          | 0.0      | 0.0  | 0.0       | 10.0 | 0.0  | 0.0        | 0.0  | 10.0        |
      | 3  | 30   | 20260712      |              | 130.0           | 10.0          | 0.0      | 0.0  | 0.0       | 10.0 | 0.0  | 0.0        | 0.0  | 10.0        |
      | 4  | 31   | 20260812    |              | 120.0           | 10.0          | 0.0      | 0.0  | 0.0       | 10.0 | 0.0  | 0.0        | 0.0  | 10.0        |
      | 5  | 31   | 20260912 |              | 110.0           | 10.0          | 0.0      | 0.0  | 0.0       | 10.0 | 0.0  | 0.0        | 0.0  | 10.0        |
      | 6  | 30   | 20261012   |              | 100.0           | 10.0          | 0.0      | 0.0  | 0.0       | 10.0 | 0.0  | 0.0        | 0.0  | 10.0        |
      | 7  | 31   | 20261112  |              | 90.0            | 10.0          | 0.0      | 0.0  | 0.0       | 10.0 | 0.0  | 0.0        | 0.0  | 10.0        |
      | 8  | 30   | 20261212  |              | 80.0            | 10.0          | 0.0      | 0.0  | 0.0       | 10.0 | 0.0  | 0.0        | 0.0  | 10.0        |
      | 9  | 31   | 20270112   |              | 70.0            | 10.0          | 0.0      | 0.0  | 0.0       | 10.0 | 0.0  | 0.0        | 0.0  | 10.0        |
      | 10 | 31   | 20270212  |              | 60.0            | 10.0          | 0.0      | 0.0  | 0.0       | 10.0 | 0.0  | 0.0        | 0.0  | 10.0        |
      | 11 | 28   | 20270312     |              | 50.0            | 10.0          | 0.0      | 0.0  | 0.0       | 10.0 | 0.0  | 0.0        | 0.0  | 10.0        |
      | 12 | 31   | 20270412     |              | 40.0            | 10.0          | 0.0      | 0.0  | 0.0       | 10.0 | 0.0  | 0.0        | 0.0  | 10.0        |
      | 13 | 30   | 20270512       |              | 30.0            | 10.0          | 0.0      | 0.0  | 0.0       | 10.0 | 0.0  | 0.0        | 0.0  | 10.0        |
      | 14 | 31   | 20270612      |              | 20.0            | 10.0          | 0.0      | 0.0  | 0.0       | 10.0 | 0.0  | 0.0        | 0.0  | 10.0        |
      | 15 | 30   | 20270712      |              | 10.0            | 10.0          | 0.0      | 0.0  | 0.0       | 10.0 | 0.0  | 0.0        | 0.0  | 10.0        |
      | 16 | 31   | 20270812    |              | 0.0             | 10.0          | 0.0      | 0.0  | 0.0       | 10.0 | 0.0  | 0.0        | 0.0  | 10.0        |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      | 150.0         | 0.0      | 0.0  | 0.0       | 150.0 | 0.0  | 0.0        | 0.0  | 150.0       |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20260531      | Disbursement     | 150.0  | 0.0       | 0.0      | 0.0  | 0.0       | 150.0        | false    |
      | 20260610     | Re-age           | 150.0  | 150.0     | 0.0      | 0.0  | 0.0       | 0.0          | false    |
# --- Step 3: Reschedule again (push schedule 2 more months: 12 June -> 23 June) ---
    When Admin creates and approves Loan reschedule with the following data:
      | rescheduleFromDate | submittedOnDate | adjustedDueDate | graceOnPrincipal | graceOnInterest | extraTerms | newInterestRate |
      | 20260612       | 20260610    | 20260623    |                  |                 |            |                 |
    Then Loan Repayment schedule has 16 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date    | Balance of loan | Principal due | Interest | Fees | Penalties | Due  | Paid | In advance | Late | Outstanding |
      |    |      | 20260531       |              | 150.0           |               |          | 0.0  |           | 0.0  | 0.0  |            |      |             |
      | 1  | 10   | 20260610      | 20260610 | 150.0           | 0.0           | 0.0      | 0.0  | 0.0       | 0.0  | 0.0  | 0.0        | 0.0  | 0.0         |
      | 2  | 13   | 20260623      |              | 140.0           | 10.0          | 0.0      | 0.0  | 0.0       | 10.0 | 0.0  | 0.0        | 0.0  | 10.0        |
      | 3  | 30   | 20260723      |              | 130.0           | 10.0          | 0.0      | 0.0  | 0.0       | 10.0 | 0.0  | 0.0        | 0.0  | 10.0        |
      | 4  | 31   | 20260823    |              | 120.0           | 10.0          | 0.0      | 0.0  | 0.0       | 10.0 | 0.0  | 0.0        | 0.0  | 10.0        |
      | 5  | 31   | 20260923 |              | 110.0           | 10.0          | 0.0      | 0.0  | 0.0       | 10.0 | 0.0  | 0.0        | 0.0  | 10.0        |
      | 6  | 30   | 20261023   |              | 100.0           | 10.0          | 0.0      | 0.0  | 0.0       | 10.0 | 0.0  | 0.0        | 0.0  | 10.0        |
      | 7  | 31   | 20261123  |              | 90.0            | 10.0          | 0.0      | 0.0  | 0.0       | 10.0 | 0.0  | 0.0        | 0.0  | 10.0        |
      | 8  | 30   | 20261223  |              | 80.0            | 10.0          | 0.0      | 0.0  | 0.0       | 10.0 | 0.0  | 0.0        | 0.0  | 10.0        |
      | 9  | 31   | 20270123   |              | 70.0            | 10.0          | 0.0      | 0.0  | 0.0       | 10.0 | 0.0  | 0.0        | 0.0  | 10.0        |
      | 10 | 31   | 20270223  |              | 60.0            | 10.0          | 0.0      | 0.0  | 0.0       | 10.0 | 0.0  | 0.0        | 0.0  | 10.0        |
      | 11 | 28   | 20270323     |              | 50.0            | 10.0          | 0.0      | 0.0  | 0.0       | 10.0 | 0.0  | 0.0        | 0.0  | 10.0        |
      | 12 | 31   | 20270423     |              | 40.0            | 10.0          | 0.0      | 0.0  | 0.0       | 10.0 | 0.0  | 0.0        | 0.0  | 10.0        |
      | 13 | 30   | 20270523       |              | 30.0            | 10.0          | 0.0      | 0.0  | 0.0       | 10.0 | 0.0  | 0.0        | 0.0  | 10.0        |
      | 14 | 31   | 20270623      |              | 20.0            | 10.0          | 0.0      | 0.0  | 0.0       | 10.0 | 0.0  | 0.0        | 0.0  | 10.0        |
      | 15 | 30   | 20270723      |              | 10.0            | 10.0          | 0.0      | 0.0  | 0.0       | 10.0 | 0.0  | 0.0        | 0.0  | 10.0        |
      | 16 | 31   | 20270823    |              | 0.0             | 10.0          | 0.0      | 0.0  | 0.0       | 10.0 | 0.0  | 0.0        | 0.0  | 10.0        |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      | 150.0         | 0.0      | 0.0  | 0.0       | 150.0 | 0.0  | 0.0        | 0.0  | 150.0       |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20260531      | Disbursement     | 150.0  | 0.0       | 0.0      | 0.0  | 0.0       | 150.0        | false    |
      | 20260610     | Re-age           | 150.0  | 150.0     | 0.0      | 0.0  | 0.0       | 0.0          | false    |

  @TestRailId:C85271
  Scenario: Verify that reschedule after ReAge produces correct schedule and balance for non-interest bearing single-installment product - UC5: 2nd reAge DEFAULT end of month
    When Admin sets the business date to "20260610"
    When Admin creates a client with random data
    When Admin set "LP1_ADV_PMT_ALLOC_PROGRESSIVE_LOAN_SCHEDULE_HORIZONTAL" loan product "DEFAULT" transaction type to "NEXT_INSTALLMENT" future installment allocation rule
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                            | submitted on date | with Principal | ANNUAL interest rate % | interest type | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP1_ADV_PMT_ALLOC_PROGRESSIVE_LOAN_SCHEDULE_HORIZONTAL | 20260531       | 150            | 0                      | FLAT          | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 30                | DAYS                  | 30             | DAYS                   | 1                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20260531" with "150" amount and expected disbursement date on "20260531"
    When Admin successfully disburse the loan on "20260531" with "150" EUR transaction amount
    Then Loan has 150.0 outstanding amount
    Then Loan Repayment schedule has 1 periods, with the following data for periods:
      | Nr | Days | Date         | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20260531  |           | 150.0           |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 30   | 20260630 |           | 0.0             | 150.0         | 0.0      | 0.0  | 0.0       | 150.0 | 0.0  | 0.0        | 0.0  | 150.0       |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      | 150.0         | 0.0      | 0.0  | 0.0       | 150.0 | 0.0  | 0.0        | 0.0  | 150.0       |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20260531      | Disbursement     | 150.0  | 0.0       | 0.0      | 0.0  | 0.0       | 150.0        | false    |
    # --- Step 1: Reschedule #1 date  : 2026-06-30  (from: 2026-06-30 → adjusted: 2026-09-30) ---
    When Admin creates and approves Loan reschedule with the following data:
      | rescheduleFromDate | submittedOnDate | adjustedDueDate   | graceOnPrincipal | graceOnInterest | extraTerms | newInterestRate |
      | 20260630       | 20260610    | 20260930 |                  |                 |            |                 |
    Then Loan has 150.0 outstanding amount
    Then Loan Repayment schedule has 1 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20260531       |           | 150.0           |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 122  | 20260930 |           | 0.0             | 150.0         | 0.0      | 0.0  | 0.0       | 150.0 | 0.0  | 0.0        | 0.0  | 150.0       |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      | 150.0         | 0.0      | 0.0  | 0.0       | 150.0 | 0.0  | 0.0        | 0.0  | 150.0       |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20260531      | Disbursement     | 150.0  | 0.0       | 0.0      | 0.0  | 0.0       | 150.0        | false    |
    # --- Step 2: ReAge for 15 monthly installments starting 20260712 ---
    When Admin creates a Loan re-aging transaction with the following data:
      | frequencyNumber | frequencyType | startDate    | numberOfInstallments | reAgeInterestHandling |
      | 1               | MONTHS        | 20260712 | 15                   | DEFAULT               |
    Then Loan has 150.0 outstanding amount
    And Loan Repayment schedule has 16 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date    | Balance of loan | Principal due | Interest | Fees | Penalties | Due  | Paid | In advance | Late | Outstanding |
      |    |      | 20260531       |              | 150.0           |               |          | 0.0  |           | 0.0  | 0.0  |            |      |             |
      | 1  | 10   | 20260610      | 20260610 | 150.0           | 0.0           | 0.0      | 0.0  | 0.0       | 0.0  | 0.0  | 0.0        | 0.0  | 0.0         |
      | 2  | 32   | 20260712      |              | 140.0           | 10.0          | 0.0      | 0.0  | 0.0       | 10.0 | 0.0  | 0.0        | 0.0  | 10.0        |
      | 3  | 31   | 20260812    |              | 130.0           | 10.0          | 0.0      | 0.0  | 0.0       | 10.0 | 0.0  | 0.0        | 0.0  | 10.0        |
      | 4  | 31   | 20260912 |              | 120.0           | 10.0          | 0.0      | 0.0  | 0.0       | 10.0 | 0.0  | 0.0        | 0.0  | 10.0        |
      | 5  | 30   | 20261012   |              | 110.0           | 10.0          | 0.0      | 0.0  | 0.0       | 10.0 | 0.0  | 0.0        | 0.0  | 10.0        |
      | 6  | 31   | 20261112  |              | 100.0           | 10.0          | 0.0      | 0.0  | 0.0       | 10.0 | 0.0  | 0.0        | 0.0  | 10.0        |
      | 7  | 30   | 20261212  |              | 90.0            | 10.0          | 0.0      | 0.0  | 0.0       | 10.0 | 0.0  | 0.0        | 0.0  | 10.0        |
      | 8  | 31   | 20270112   |              | 80.0            | 10.0          | 0.0      | 0.0  | 0.0       | 10.0 | 0.0  | 0.0        | 0.0  | 10.0        |
      | 9  | 31   | 20270212  |              | 70.0            | 10.0          | 0.0      | 0.0  | 0.0       | 10.0 | 0.0  | 0.0        | 0.0  | 10.0        |
      | 10 | 28   | 20270312     |              | 60.0            | 10.0          | 0.0      | 0.0  | 0.0       | 10.0 | 0.0  | 0.0        | 0.0  | 10.0        |
      | 11 | 31   | 20270412     |              | 50.0            | 10.0          | 0.0      | 0.0  | 0.0       | 10.0 | 0.0  | 0.0        | 0.0  | 10.0        |
      | 12 | 30   | 20270512       |              | 40.0            | 10.0          | 0.0      | 0.0  | 0.0       | 10.0 | 0.0  | 0.0        | 0.0  | 10.0        |
      | 13 | 31   | 20270612      |              | 30.0            | 10.0          | 0.0      | 0.0  | 0.0       | 10.0 | 0.0  | 0.0        | 0.0  | 10.0        |
      | 14 | 30   | 20270712      |              | 20.0            | 10.0          | 0.0      | 0.0  | 0.0       | 10.0 | 0.0  | 0.0        | 0.0  | 10.0        |
      | 15 | 31   | 20270812    |              | 10.0            | 10.0          | 0.0      | 0.0  | 0.0       | 10.0 | 0.0  | 0.0        | 0.0  | 10.0        |
      | 16 | 31   | 20270912 |              | 0.0             | 10.0          | 0.0      | 0.0  | 0.0       | 10.0 | 0.0  | 0.0        | 0.0  | 10.0        |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      | 150.0         | 0.0      | 0.0  | 0.0       | 150.0 | 0.0  | 0.0        | 0.0  | 150.0       |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20260531      | Disbursement     | 150.0  | 0.0       | 0.0      | 0.0  | 0.0       | 150.0        | false    |
      | 20260610     | Re-age           | 150.0  | 150.0     | 0.0      | 0.0  | 0.0       | 0.0          | false    |
    # --- Step 3: Reschedule again (push schedule 2 more months: 12 July -> 12 December) ---
    When Admin creates and approves Loan reschedule with the following data:
      | rescheduleFromDate | submittedOnDate | adjustedDueDate  | graceOnPrincipal | graceOnInterest | extraTerms | newInterestRate |
      | 20260712       | 20260610    | 20261212 |                  |                 |            |                 |
    Then Loan Repayment schedule has 16 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date    | Balance of loan | Principal due | Interest | Fees | Penalties | Due  | Paid | In advance | Late | Outstanding |
      |    |      | 20260531       |              | 150.0           |               |          | 0.0  |           | 0.0  | 0.0  |            |      |             |
      | 1  | 10   | 20260610      | 20260610 | 150.0           | 0.0           | 0.0      | 0.0  | 0.0       | 0.0  | 0.0  | 0.0        | 0.0  | 0.0         |
      | 2  | 185  | 20261212  |              | 140.0           | 10.0          | 0.0      | 0.0  | 0.0       | 10.0 | 0.0  | 0.0        | 0.0  | 10.0        |
      | 3  | 31   | 20270112   |              | 130.0           | 10.0          | 0.0      | 0.0  | 0.0       | 10.0 | 0.0  | 0.0        | 0.0  | 10.0        |
      | 4  | 31   | 20270212  |              | 120.0           | 10.0          | 0.0      | 0.0  | 0.0       | 10.0 | 0.0  | 0.0        | 0.0  | 10.0        |
      | 5  | 28   | 20270312     |              | 110.0           | 10.0          | 0.0      | 0.0  | 0.0       | 10.0 | 0.0  | 0.0        | 0.0  | 10.0        |
      | 6  | 31   | 20270412     |              | 100.0           | 10.0          | 0.0      | 0.0  | 0.0       | 10.0 | 0.0  | 0.0        | 0.0  | 10.0        |
      | 7  | 30   | 20270512       |              | 90.0            | 10.0          | 0.0      | 0.0  | 0.0       | 10.0 | 0.0  | 0.0        | 0.0  | 10.0        |
      | 8  | 31   | 20270612      |              | 80.0            | 10.0          | 0.0      | 0.0  | 0.0       | 10.0 | 0.0  | 0.0        | 0.0  | 10.0        |
      | 9  | 30   | 20270712      |              | 70.0            | 10.0          | 0.0      | 0.0  | 0.0       | 10.0 | 0.0  | 0.0        | 0.0  | 10.0        |
      | 10 | 31   | 20270812    |              | 60.0            | 10.0          | 0.0      | 0.0  | 0.0       | 10.0 | 0.0  | 0.0        | 0.0  | 10.0        |
      | 11 | 31   | 20270912 |              | 50.0            | 10.0          | 0.0      | 0.0  | 0.0       | 10.0 | 0.0  | 0.0        | 0.0  | 10.0        |
      | 12 | 30   | 20271012   |              | 40.0            | 10.0          | 0.0      | 0.0  | 0.0       | 10.0 | 0.0  | 0.0        | 0.0  | 10.0        |
      | 13 | 31   | 20271112  |              | 30.0            | 10.0          | 0.0      | 0.0  | 0.0       | 10.0 | 0.0  | 0.0        | 0.0  | 10.0        |
      | 14 | 30   | 20271212  |              | 20.0            | 10.0          | 0.0      | 0.0  | 0.0       | 10.0 | 0.0  | 0.0        | 0.0  | 10.0        |
      | 15 | 31   | 20280112   |              | 10.0            | 10.0          | 0.0      | 0.0  | 0.0       | 10.0 | 0.0  | 0.0        | 0.0  | 10.0        |
      | 16 | 31   | 20280212  |              | 0.0             | 10.0          | 0.0      | 0.0  | 0.0       | 10.0 | 0.0  | 0.0        | 0.0  | 10.0        |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      | 150.0         | 0.0      | 0.0  | 0.0       | 150.0 | 0.0  | 0.0        | 0.0  | 150.0       |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20260531      | Disbursement     | 150.0  | 0.0       | 0.0      | 0.0  | 0.0       | 150.0        | false    |
      | 20260610     | Re-age           | 150.0  | 150.0     | 0.0      | 0.0  | 0.0       | 0.0          | false    |