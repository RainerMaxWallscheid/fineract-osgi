@LoanDelinquencyFeature
Feature: LoanDelinquency - Part1

  @TestRailId:C2963
  Scenario: Verify Loan delinquency pause API - PAUSE and RESUME by loanId
    When Admin sets the business date to "20231001"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                       | submitted on date | with Principal | ANNUAL interest rate % | interest type | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_DOWNPAYMENT_AUTO_ADVANCED_PAYMENT_ALLOCATION | 20231001   | 1000           | 0                      | FLAT          | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 45                | DAYS                  | 15             | DAYS                   | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20231001" with "1000" amount and expected disbursement date on "20231001"
    When Admin successfully disburse the loan on "20231001" with "1000" EUR transaction amount
    When Admin sets the business date to "20231016"
    When Admin initiate a DELINQUENCY PAUSE with startDate: "20231016" and endDate: "20231030"
    Then Delinquency-actions have the following data:
      | action | startDate       | endDate         |
      | PAUSE  | 20231016 | 20231030 |
    When Admin sets the business date to "20231020"
    When Admin initiate a DELINQUENCY RESUME with startDate: "20231020"
    Then Delinquency-actions have the following data:
      | action | startDate       | endDate         |
      | PAUSE  | 20231016 | 20231030 |
      | RESUME | 20231020 |                 |

  @TestRailId:C2964
  Scenario: Verify Loan delinquency pause API - PAUSE and RESUME by loanExternalId
    When Admin sets the business date to "20231001"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                       | submitted on date | with Principal | ANNUAL interest rate % | interest type | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_DOWNPAYMENT_AUTO_ADVANCED_PAYMENT_ALLOCATION | 20231001   | 1000           | 0                      | FLAT          | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 45                | DAYS                  | 15             | DAYS                   | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20231001" with "1000" amount and expected disbursement date on "20231001"
    When Admin successfully disburse the loan on "20231001" with "1000" EUR transaction amount
    When Admin sets the business date to "20231016"
    When Admin initiate a DELINQUENCY PAUSE by loanExternalId with startDate: "20231016" and endDate: "20231030"
    Then Delinquency-actions have the following data:
      | action | startDate       | endDate         |
      | PAUSE  | 20231016 | 20231030 |
    When Admin sets the business date to "20231020"
    When Admin initiate a DELINQUENCY RESUME by loanExternalId with startDate: "20231020"
    Then Delinquency-actions have the following data:
      | action | startDate       | endDate         |
      | PAUSE  | 20231016 | 20231030 |
      | RESUME | 20231020 |                 |

  @TestRailId:C2965
  Scenario: Verify Loan delinquency pause API - PAUSE and RESUME actions supported only
    When Admin sets the business date to "20231001"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                       | submitted on date | with Principal | ANNUAL interest rate % | interest type | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_DOWNPAYMENT_AUTO_ADVANCED_PAYMENT_ALLOCATION | 20231001   | 1000           | 0                      | FLAT          | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 45                | DAYS                  | 15             | DAYS                   | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20231001" with "1000" amount and expected disbursement date on "20231001"
    When Admin successfully disburse the loan on "20231001" with "1000" EUR transaction amount
    When Admin sets the business date to "20231016"
    Then Initiating a delinquency-action other than PAUSE or RESUME in action field results an error - startDate: "20231016", endDate: "20231030"
    When Admin initiate a DELINQUENCY PAUSE with startDate: "20231016" and endDate: "20231030"
    Then Delinquency-actions have the following data:
      | action | startDate       | endDate         |
      | PAUSE  | 20231016 | 20231030 |
    When Admin sets the business date to "20231020"
    When Admin initiate a DELINQUENCY RESUME by loanExternalId with startDate: "20231020"
    Then Delinquency-actions have the following data:
      | action | startDate       | endDate         |
      | PAUSE  | 20231016 | 20231030 |
      | RESUME | 20231020 |                 |

  @TestRailId:C2966
  Scenario: Verify Loan delinquency pause API - PAUSE with start date on actual business date
    When Admin sets the business date to "20231001"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                       | submitted on date | with Principal | ANNUAL interest rate % | interest type | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_DOWNPAYMENT_AUTO_ADVANCED_PAYMENT_ALLOCATION | 20231001   | 1000           | 0                      | FLAT          | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 45                | DAYS                  | 15             | DAYS                   | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20231001" with "1000" amount and expected disbursement date on "20231001"
    When Admin successfully disburse the loan on "20231001" with "1000" EUR transaction amount
    When Admin sets the business date to "20231016"
    When Admin initiate a DELINQUENCY PAUSE with startDate: "20231016" and endDate: "20231030"
    Then Delinquency-actions have the following data:
      | action | startDate       | endDate         |
      | PAUSE  | 20231016 | 20231030 |

  @TestRailId:C2967
  Scenario: Verify Loan delinquency pause API - PAUSE with start date later than actual business date
    When Admin sets the business date to "20231001"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                       | submitted on date | with Principal | ANNUAL interest rate % | interest type | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_DOWNPAYMENT_AUTO_ADVANCED_PAYMENT_ALLOCATION | 20231001   | 1000           | 0                      | FLAT          | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 45                | DAYS                  | 15             | DAYS                   | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20231001" with "1000" amount and expected disbursement date on "20231001"
    When Admin successfully disburse the loan on "20231001" with "1000" EUR transaction amount
    When Admin sets the business date to "20231016"
    When Admin initiate a DELINQUENCY PAUSE with startDate: "20231025" and endDate: "20231030"
    Then Delinquency-actions have the following data:
      | action | startDate       | endDate         |
      | PAUSE  | 20231025 | 20231030 |

  @TestRailId:C2968
  Scenario: Verify Loan delinquency pause API - PAUSE with start date before than actual business date is possible
    When Admin sets the business date to "20231001"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                       | submitted on date | with Principal | ANNUAL interest rate % | interest type | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_DOWNPAYMENT_AUTO_ADVANCED_PAYMENT_ALLOCATION | 20231001   | 1000           | 0                      | FLAT          | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 45                | DAYS                  | 15             | DAYS                   | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20231001" with "1000" amount and expected disbursement date on "20231001"
    When Admin successfully disburse the loan on "20231001" with "1000" EUR transaction amount
    When Admin sets the business date to "20231016"
    When Admin initiate a DELINQUENCY PAUSE with startDate: "20231014" and endDate: "20231030"
    Then Delinquency-actions have the following data:
      | action | startDate       | endDate         |
      | PAUSE  | 20231014 | 20231030 |

  @TestRailId:C2969
  Scenario: Verify Loan delinquency pause API - PAUSE action on non-active loan result an error
    When Admin sets the business date to "20231001"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                       | submitted on date | with Principal | ANNUAL interest rate % | interest type | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_DOWNPAYMENT_AUTO_ADVANCED_PAYMENT_ALLOCATION | 20231001   | 1000           | 0                      | FLAT          | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 45                | DAYS                  | 15             | DAYS                   | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
#    pending approval
    Then Loan status will be "SUBMITTED_AND_PENDING_APPROVAL"
    Then Initiating a DELINQUENCY PAUSE on a non-active loan results an error - startDate: "20231016", endDate: "20231030"
#    approved
    And Admin successfully approves the loan on "20231001" with "1000" amount and expected disbursement date on "20231001"
    Then Loan status will be "APPROVED"
    Then Initiating a DELINQUENCY PAUSE on a non-active loan results an error - startDate: "20231016", endDate: "20231030"
#    overpaid
    When Admin successfully disburse the loan on "20231001" with "1000" EUR transaction amount
    And Customer makes "AUTOPAY" repayment on "20231001" with 1000 EUR transaction amount
    Then Loan status will be "OVERPAID"
    Then Initiating a DELINQUENCY PAUSE on a non-active loan results an error - startDate: "20231016", endDate: "20231030"
#   closed
    And Admin makes Credit Balance Refund transaction on "20231001" with 250 EUR transaction amount
    Then Loan status will be "CLOSED_OBLIGATIONS_MET"
    When Admin sets the business date to "20231016"
    Then Initiating a DELINQUENCY PAUSE on a non-active loan results an error - startDate: "20231016", endDate: "20231030"

  @TestRailId:C2970
  Scenario: Verify Loan delinquency pause API - RESUME action on non-active loan result an error
    When Admin sets the business date to "20231001"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                       | submitted on date | with Principal | ANNUAL interest rate % | interest type | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_DOWNPAYMENT_AUTO_ADVANCED_PAYMENT_ALLOCATION | 20231001   | 1000           | 0                      | FLAT          | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 45                | DAYS                  | 15             | DAYS                   | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20231001" with "1000" amount and expected disbursement date on "20231001"
    When Admin successfully disburse the loan on "20231001" with "1000" EUR transaction amount
    When Admin initiate a DELINQUENCY PAUSE with startDate: "20231016" and endDate: "20231030"
    Then Delinquency-actions have the following data:
      | action | startDate       | endDate         |
      | PAUSE  | 20231016 | 20231030 |
#    overpaid
    When Admin sets the business date to "20231016"
    And Customer makes "AUTOPAY" repayment on "20231016" with 1000 EUR transaction amount
    Then Loan status will be "OVERPAID"
    Then Initiating a DELINQUENCY RESUME on a non-active loan results an error - startDate: "20231016"
#   closed
    And Admin makes Credit Balance Refund transaction on "20231016" with 250 EUR transaction amount
    Then Loan status will be "CLOSED_OBLIGATIONS_MET"
    Then Initiating a DELINQUENCY RESUME on a non-active loan results an error - startDate: "20231016"

  @TestRailId:C2971
  Scenario: Verify Loan delinquency pause API - Overlapping PAUSE periods result an error
    When Admin sets the business date to "20231001"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                       | submitted on date | with Principal | ANNUAL interest rate % | interest type | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_DOWNPAYMENT_AUTO_ADVANCED_PAYMENT_ALLOCATION | 20231001   | 1000           | 0                      | FLAT          | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 45                | DAYS                  | 15             | DAYS                   | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20231001" with "1000" amount and expected disbursement date on "20231001"
    When Admin successfully disburse the loan on "20231001" with "1000" EUR transaction amount
    When Admin sets the business date to "20231016"
    When Admin initiate a DELINQUENCY PAUSE with startDate: "20231016" and endDate: "20231030"
    Then Delinquency-actions have the following data:
      | action | startDate       | endDate         |
      | PAUSE  | 20231016 | 20231030 |
    When Admin sets the business date to "20231020"
    Then Overlapping PAUSE periods result an error - startDate: "20231020", endDate: "20231030"

  @TestRailId:C2972
  Scenario: Verify Loan delinquency pause API - RESUME without an active PAUSE period results an error
    When Admin sets the business date to "20231001"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                       | submitted on date | with Principal | ANNUAL interest rate % | interest type | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_DOWNPAYMENT_AUTO_ADVANCED_PAYMENT_ALLOCATION | 20231001   | 1000           | 0                      | FLAT          | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 45                | DAYS                  | 15             | DAYS                   | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20231001" with "1000" amount and expected disbursement date on "20231001"
    When Admin successfully disburse the loan on "20231001" with "1000" EUR transaction amount
    Then Initiating a DELINQUENCY RESUME without an active PAUSE period results an error - startDate: "20231001"

  @TestRailId:C2973
  Scenario: Verify Loan delinquency pause API - RESUME with start date before than actual business date results an error
    When Admin sets the business date to "20231001"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                       | submitted on date | with Principal | ANNUAL interest rate % | interest type | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_DOWNPAYMENT_AUTO_ADVANCED_PAYMENT_ALLOCATION | 20231001   | 1000           | 0                      | FLAT          | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 45                | DAYS                  | 15             | DAYS                   | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20231001" with "1000" amount and expected disbursement date on "20231001"
    When Admin successfully disburse the loan on "20231001" with "1000" EUR transaction amount
    When Admin sets the business date to "20231016"
    When Admin initiate a DELINQUENCY PAUSE with startDate: "20231016" and endDate: "20231030"
    Then Delinquency-actions have the following data:
      | action | startDate       | endDate         |
      | PAUSE  | 20231016 | 20231030 |
    When Admin sets the business date to "20231020"
    Then Initiating a DELINQUENCY RESUME with start date other than actual business date results an error - startDate: "20231001"

  @TestRailId:C2974
  Scenario: Verify Loan delinquency pause API - RESUME with start date later than actual business date results an error
    When Admin sets the business date to "20231001"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                       | submitted on date | with Principal | ANNUAL interest rate % | interest type | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_DOWNPAYMENT_AUTO_ADVANCED_PAYMENT_ALLOCATION | 20231001   | 1000           | 0                      | FLAT          | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 45                | DAYS                  | 15             | DAYS                   | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20231001" with "1000" amount and expected disbursement date on "20231001"
    When Admin successfully disburse the loan on "20231001" with "1000" EUR transaction amount
    When Admin sets the business date to "20231016"
    When Admin initiate a DELINQUENCY PAUSE with startDate: "20231016" and endDate: "20231030"
    Then Delinquency-actions have the following data:
      | action | startDate       | endDate         |
      | PAUSE  | 20231016 | 20231030 |
    When Admin sets the business date to "20231020"
    Then Initiating a DELINQUENCY RESUME with start date other than actual business date results an error - startDate: "20231021"

  @TestRailId:C2975
  Scenario: Verify Loan delinquency pause API - RESUME with end date results an error
    When Admin sets the business date to "20231001"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                       | submitted on date | with Principal | ANNUAL interest rate % | interest type | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_DOWNPAYMENT_AUTO_ADVANCED_PAYMENT_ALLOCATION | 20231001   | 1000           | 0                      | FLAT          | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 45                | DAYS                  | 15             | DAYS                   | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20231001" with "1000" amount and expected disbursement date on "20231001"
    When Admin successfully disburse the loan on "20231001" with "1000" EUR transaction amount
    When Admin sets the business date to "20231016"
    When Admin initiate a DELINQUENCY PAUSE with startDate: "20231016" and endDate: "20231030"
    Then Delinquency-actions have the following data:
      | action | startDate       | endDate         |
      | PAUSE  | 20231016 | 20231030 |
    When Admin sets the business date to "20231020"
    Then Initiating a DELINQUENCY RESUME with an endDate results an error - startDate: "20231020", endDate: "20231030"

  @TestRailId:C2992
  Scenario: Verify Loan level loan delinquency - loan goes into delinquency pause then will be resumed
    When Admin sets the business date to "20231001"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                                       | submitted on date | with Principal | ANNUAL interest rate % | interest type | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_DOWNPAYMENT_ADV_PMT_ALLOC_PROGRESSIVE_LOAN_SCHEDULE_HORIZONTAL_INSTALLMENT_LEVEL_DELINQUENCY | 20231001   | 1000           | 0                      | FLAT          | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 45                | DAYS                  | 15             | DAYS                   | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20231001" with "1000" amount and expected disbursement date on "20231001"
    When Admin successfully disburse the loan on "20231001" with "1000" EUR transaction amount
    When Admin sets the business date to "20231005"
    When Admin runs inline COB job for Loan
    Then Admin checks that delinquency range is: "RANGE_1" and has delinquentDate "2023-10-04"
    When Admin sets the business date to "20231117"
    When Admin initiate a DELINQUENCY PAUSE with startDate: "20231117" and endDate: "20231230"
    Then Delinquency-actions have the following data:
      | action | startDate        | endDate          |
      | PAUSE  | 20231117 | 20231230 |
    When Admin runs inline COB job for Loan
    Then Admin checks that delinquency range is: "RANGE_30" and has delinquentDate "2023-10-04"
    When Admin sets the business date to "20231201"
    When Admin initiate a DELINQUENCY RESUME with startDate: "20231201"
    Then Delinquency-actions have the following data:
      | action | startDate        | endDate          |
      | PAUSE  | 20231117 | 20231230 |
      | RESUME | 20231201 |                  |
    When Admin runs inline COB job for Loan
    Then Admin checks that delinquency range is: "RANGE_30" and has delinquentDate "2023-10-04"

  @TestRailId:C2979
  Scenario: Verify Installment level loan delinquency - loan goes into delinquency bucket
    When Admin sets the business date to "20231001"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                                       | submitted on date | with Principal | ANNUAL interest rate % | interest type | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_DOWNPAYMENT_ADV_PMT_ALLOC_PROGRESSIVE_LOAN_SCHEDULE_HORIZONTAL_INSTALLMENT_LEVEL_DELINQUENCY | 20231001   | 1000           | 0                      | FLAT          | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 45                | DAYS                  | 15             | DAYS                   | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20231001" with "1000" amount and expected disbursement date on "20231001"
    When Admin successfully disburse the loan on "20231001" with "1000" EUR transaction amount
    When Admin sets the business date to "20231216"
    When Admin runs inline COB job for Loan
    Then Loan has the following INSTALLMENT level delinquency data:
      | Range    | Amount |
      | RANGE_30 | 500.00 |
      | RANGE_60 | 500.00 |
    Then Installment level delinquency event has correct data

  @TestRailId:C2980
  Scenario: Verify Installment level loan delinquency - loan goes from one delinquency bucket to an other
    When Admin sets the business date to "20231001"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                                       | submitted on date | with Principal | ANNUAL interest rate % | interest type | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_DOWNPAYMENT_ADV_PMT_ALLOC_PROGRESSIVE_LOAN_SCHEDULE_HORIZONTAL_INSTALLMENT_LEVEL_DELINQUENCY | 20231001   | 1000           | 0                      | FLAT          | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 45                | DAYS                  | 15             | DAYS                   | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20231001" with "1000" amount and expected disbursement date on "20231001"
    When Admin successfully disburse the loan on "20231001" with "1000" EUR transaction amount
    When Admin sets the business date to "20231116"
    When Admin runs inline COB job for Loan
    Then Loan has the following INSTALLMENT level delinquency data:
      | Range    | Amount |
      | RANGE_1  | 250.00 |
      | RANGE_3  | 250.00 |
      | RANGE_30 | 500.00 |
    Then Installment level delinquency event has correct data
    When Admin sets the business date to "20231216"
    When Admin runs inline COB job for Loan
    Then Loan has the following INSTALLMENT level delinquency data:
      | Range    | Amount |
      | RANGE_30 | 500.00 |
      | RANGE_60 | 500.00 |
    Then Installment level delinquency event has correct data

  @TestRailId:C2981
  Scenario: Verify Installment level loan delinquency - loan goes out from delinquency by late repayment
    When Admin sets the business date to "20231001"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                                       | submitted on date | with Principal | ANNUAL interest rate % | interest type | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_DOWNPAYMENT_ADV_PMT_ALLOC_PROGRESSIVE_LOAN_SCHEDULE_HORIZONTAL_INSTALLMENT_LEVEL_DELINQUENCY | 20231001   | 1000           | 0                      | FLAT          | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 45                | DAYS                  | 15             | DAYS                   | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20231001" with "1000" amount and expected disbursement date on "20231001"
    When Admin successfully disburse the loan on "20231001" with "1000" EUR transaction amount
    When Admin sets the business date to "20231216"
    When Admin runs inline COB job for Loan
    Then Loan has the following INSTALLMENT level delinquency data:
      | Range    | Amount |
      | RANGE_30 | 500.00 |
      | RANGE_60 | 500.00 |
    Then Installment level delinquency event has correct data
    When Admin sets the business date to "20231217"
    And Customer makes "AUTOPAY" repayment on "20231217" with 1000 EUR transaction amount
    Then Installment level delinquency event has correct data
    Then INSTALLMENT level delinquency is null

  @TestRailId:C2982
  Scenario: Verify Installment level loan delinquency - some of the installments go out from delinquency by late repayment
    When Admin sets the business date to "20231001"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                                       | submitted on date | with Principal | ANNUAL interest rate % | interest type | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_DOWNPAYMENT_ADV_PMT_ALLOC_PROGRESSIVE_LOAN_SCHEDULE_HORIZONTAL_INSTALLMENT_LEVEL_DELINQUENCY | 20231001   | 1000           | 0                      | FLAT          | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 45                | DAYS                  | 15             | DAYS                   | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20231001" with "1000" amount and expected disbursement date on "20231001"
    When Admin successfully disburse the loan on "20231001" with "1000" EUR transaction amount
    When Admin sets the business date to "20231025"
    When Admin runs inline COB job for Loan
    Then Installment level delinquency event has correct data
    Then Loan has the following INSTALLMENT level delinquency data:
      | Range   | Amount |
      | RANGE_3 | 500.00 |
    When Admin sets the business date to "20231026"
    And Customer makes "AUTOPAY" repayment on "20231026" with 250 EUR transaction amount
    Then Installment level delinquency event has correct data
    Then Loan has the following INSTALLMENT level delinquency data:
      | Range   | Amount |
      | RANGE_3 | 250.00 |

  @TestRailId:C2983
  Scenario: Verify Installment level loan delinquency - loan goes out from delinquency by Goodwill credit transaction
    When Admin sets the business date to "20231001"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                                       | submitted on date | with Principal | ANNUAL interest rate % | interest type | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_DOWNPAYMENT_ADV_PMT_ALLOC_PROGRESSIVE_LOAN_SCHEDULE_HORIZONTAL_INSTALLMENT_LEVEL_DELINQUENCY | 20231001   | 1000           | 0                      | FLAT          | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 45                | DAYS                  | 15             | DAYS                   | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20231001" with "1000" amount and expected disbursement date on "20231001"
    When Admin successfully disburse the loan on "20231001" with "1000" EUR transaction amount
    When Admin sets the business date to "20231216"
    When Admin runs inline COB job for Loan
    Then Loan has the following INSTALLMENT level delinquency data:
      | Range    | Amount |
      | RANGE_30 | 500.00 |
      | RANGE_60 | 500.00 |
    Then Installment level delinquency event has correct data
    When Admin sets the business date to "20231217"
    When Customer makes "GOODWILL_CREDIT" transaction with "AUTOPAY" payment type on "20231217" with 1000 EUR transaction amount and system-generated Idempotency key
    Then Installment level delinquency event has correct data
    Then INSTALLMENT level delinquency is null

  @TestRailId:C2984
  Scenario: Verify Installment level loan delinquency - some of the installments go out from delinquency by Goodwill credit transaction
    When Admin sets the business date to "20231001"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                                       | submitted on date | with Principal | ANNUAL interest rate % | interest type | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_DOWNPAYMENT_ADV_PMT_ALLOC_PROGRESSIVE_LOAN_SCHEDULE_HORIZONTAL_INSTALLMENT_LEVEL_DELINQUENCY | 20231001   | 1000           | 0                      | FLAT          | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 45                | DAYS                  | 15             | DAYS                   | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20231001" with "1000" amount and expected disbursement date on "20231001"
    When Admin successfully disburse the loan on "20231001" with "1000" EUR transaction amount
    When Admin sets the business date to "20231025"
    When Admin runs inline COB job for Loan
    Then Installment level delinquency event has correct data
    Then Loan has the following INSTALLMENT level delinquency data:
      | Range   | Amount |
      | RANGE_3 | 500.00 |
    When Admin sets the business date to "20231026"
    When Customer makes "GOODWILL_CREDIT" transaction with "AUTOPAY" payment type on "20231026" with 250 EUR transaction amount and system-generated Idempotency key
    Then Installment level delinquency event has correct data
    Then Loan has the following INSTALLMENT level delinquency data:
      | Range   | Amount |
      | RANGE_3 | 250.00 |

  @TestRailId:C2985
  Scenario: Verify Installment level loan delinquency - loan with charges goes into delinquency bucket
    When Admin sets the business date to "20231001"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                                       | submitted on date | with Principal | ANNUAL interest rate % | interest type | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_DOWNPAYMENT_ADV_PMT_ALLOC_PROGRESSIVE_LOAN_SCHEDULE_HORIZONTAL_INSTALLMENT_LEVEL_DELINQUENCY | 20231001   | 1000           | 0                      | FLAT          | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 45                | DAYS                  | 15             | DAYS                   | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20231001" with "1000" amount and expected disbursement date on "20231001"
    When Admin successfully disburse the loan on "20231001" with "1000" EUR transaction amount
    When Admin adds "LOAN_NSF_FEE" due date charge with "20231005" due date and 20 EUR transaction amount
    When Admin sets the business date to "20231020"
    When Admin adds "LOAN_SNOOZE_FEE" due date charge with "20231020" due date and 20 EUR transaction amount
    When Admin sets the business date to "20231216"
    When Admin runs inline COB job for Loan
    Then Loan has the following INSTALLMENT level delinquency data:
      | Range    | Amount |
      | RANGE_30 | 520.00 |
      | RANGE_60 | 520.00 |
    Then Installment level delinquency event has correct data

  @TestRailId:C2987
  Scenario: Verify Installment level loan delinquency - loan goes into delinquency pause
    When Admin sets the business date to "20231001"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                                       | submitted on date | with Principal | ANNUAL interest rate % | interest type | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_DOWNPAYMENT_ADV_PMT_ALLOC_PROGRESSIVE_LOAN_SCHEDULE_HORIZONTAL_INSTALLMENT_LEVEL_DELINQUENCY | 20231001   | 1000           | 0                      | FLAT          | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 45                | DAYS                  | 15             | DAYS                   | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20231001" with "1000" amount and expected disbursement date on "20231001"
    When Admin successfully disburse the loan on "20231001" with "1000" EUR transaction amount
    When Admin runs inline COB job for Loan
    When Admin sets the business date to "20231030"
    When Admin runs inline COB job for Loan
    When Admin sets the business date to "20231116"
    When Admin runs inline COB job for Loan
    Then Loan has the following INSTALLMENT level delinquency data:
      | Range    | Amount |
      | RANGE_1  | 250.00 |
      | RANGE_3  | 250.00 |
      | RANGE_30 | 500.00 |
    Then Installment level delinquency event has correct data
    When Admin sets the business date to "20231117"
    When Admin initiate a DELINQUENCY PAUSE with startDate: "20231117" and endDate: "20231130"
    Then Delinquency-actions have the following data:
      | action | startDate        | endDate          |
      | PAUSE  | 20231117 | 20231130 |
    When Admin runs inline COB job for Loan
    Then Installment level delinquency event has correct data
    Then Loan has the following INSTALLMENT level delinquency data:
      | Range    | Amount |
      | RANGE_1  | 250.00 |
      | RANGE_3  | 250.00 |
      | RANGE_30 | 500.00 |
    When Admin sets the business date to "20231130"
    When Admin runs inline COB job for Loan
    Then Installment level delinquency event has correct data
    Then Loan has the following INSTALLMENT level delinquency data:
      | Range    | Amount |
      | RANGE_1  | 250.00 |
      | RANGE_3  | 250.00 |
      | RANGE_30 | 500.00 |
    When Admin sets the business date to "20231220"
    When Admin runs inline COB job for Loan
    When Admin sets the business date to "20240101"
    When Admin runs inline COB job for Loan
    Then Installment level delinquency event has correct data
    Then Loan has the following INSTALLMENT level delinquency data:
      | Range    | Amount |
      | RANGE_30 | 500.00 |
      | RANGE_60 | 500.00 |

  @TestRailId:C2988
  Scenario: Verify Installment level loan delinquency - loan goes into delinquency pause then will be resumed
    When Admin sets the business date to "20231001"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                                       | submitted on date | with Principal | ANNUAL interest rate % | interest type | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_DOWNPAYMENT_ADV_PMT_ALLOC_PROGRESSIVE_LOAN_SCHEDULE_HORIZONTAL_INSTALLMENT_LEVEL_DELINQUENCY | 20231001   | 1000           | 0                      | FLAT          | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 45                | DAYS                  | 15             | DAYS                   | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20231001" with "1000" amount and expected disbursement date on "20231001"
    When Admin successfully disburse the loan on "20231001" with "1000" EUR transaction amount
    When Admin runs inline COB job for Loan
    When Admin sets the business date to "20231030"
    When Admin runs inline COB job for Loan
    When Admin sets the business date to "20231116"
    When Admin runs inline COB job for Loan
    Then Loan has the following INSTALLMENT level delinquency data:
      | Range    | Amount |
      | RANGE_1  | 250.00 |
      | RANGE_3  | 250.00 |
      | RANGE_30 | 500.00 |
    Then Installment level delinquency event has correct data
    When Admin sets the business date to "20231117"
    When Admin initiate a DELINQUENCY PAUSE with startDate: "20231117" and endDate: "20231230"
    Then Delinquency-actions have the following data:
      | action | startDate        | endDate          |
      | PAUSE  | 20231117 | 20231230 |
    When Admin runs inline COB job for Loan
    Then Installment level delinquency event has correct data
    Then Loan has the following INSTALLMENT level delinquency data:
      | Range    | Amount |
      | RANGE_1  | 250.00 |
      | RANGE_3  | 250.00 |
      | RANGE_30 | 500.00 |
    When Admin sets the business date to "20231201"
    When Admin initiate a DELINQUENCY RESUME with startDate: "20231201"
    Then Delinquency-actions have the following data:
      | action | startDate        | endDate          |
      | PAUSE  | 20231117 | 20231230 |
      | RESUME | 20231201 |                  |
    When Admin runs inline COB job for Loan
    Then Installment level delinquency event has correct data
    Then Loan has the following INSTALLMENT level delinquency data:
      | Range    | Amount |
      | RANGE_1  | 250.00 |
      | RANGE_3  | 250.00 |
      | RANGE_30 | 500.00 |

  @TestRailId:C2990
  Scenario: Verify that a non-super user with CREATE_DELINQUENCY_ACTION permission can initiate a DELINQUENCY PAUSE
    When Admin sets the business date to "20231001"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                       | submitted on date | with Principal | ANNUAL interest rate % | interest type | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_DOWNPAYMENT_AUTO_ADVANCED_PAYMENT_ALLOCATION | 20231001   | 1000           | 0                      | FLAT          | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 45                | DAYS                  | 15             | DAYS                   | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20231001" with "1000" amount and expected disbursement date on "20231001"
    When Admin successfully disburse the loan on "20231001" with "1000" EUR transaction amount
    When Admin sets the business date to "20231016"
    When Admin creates new user with "CREATE_DELINQUENCY_ACTION_USER" username, "CREATE_DELINQUENCY_ACTION_ROLE" role name and given permissions:
      | CREATE_DELINQUENCY_ACTION |
      | REPAYMENT_LOAN            |
    When Created user with CREATE_DELINQUENCY_ACTION permission initiate a DELINQUENCY PAUSE with startDate: "20231016" and endDate: "20231030"
    Then Delinquency-actions have the following data:
      | action | startDate       | endDate         |
      | PAUSE  | 20231016 | 20231030 |

  @TestRailId:C2991
  Scenario: Verify that a non-super user with no CREATE_DELINQUENCY_ACTION permission gets an error when initiate a DELINQUENCY PAUSE
    When Admin sets the business date to "20231001"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                       | submitted on date | with Principal | ANNUAL interest rate % | interest type | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_DOWNPAYMENT_AUTO_ADVANCED_PAYMENT_ALLOCATION | 20231001   | 1000           | 0                      | FLAT          | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 45                | DAYS                  | 15             | DAYS                   | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20231001" with "1000" amount and expected disbursement date on "20231001"
    When Admin successfully disburse the loan on "20231001" with "1000" EUR transaction amount
    When Admin sets the business date to "20231016"
    When Admin creates new user with "NO_CREATE_DELINQUENCY_ACTION_USER" username, "NO_CREATE_DELINQUENCY_ACTION_ROLE" role name and given permissions:
      | REPAYMENT_LOAN |
    Then Created user with no CREATE_DELINQUENCY_ACTION permission gets an error when initiate a DELINQUENCY PAUSE with startDate: "20231016" and endDate: "20231030"

  @TestRailId:C2999
  Scenario: Verify Loan delinquency pause E2E - full PAUSE period
    When Admin sets the business date to "20231001"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                                       | submitted on date | with Principal | ANNUAL interest rate % | interest type | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_DOWNPAYMENT_ADV_PMT_ALLOC_PROGRESSIVE_LOAN_SCHEDULE_HORIZONTAL_INSTALLMENT_LEVEL_DELINQUENCY | 20231001   | 1000           | 0                      | FLAT          | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 45                | DAYS                  | 15             | DAYS                   | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20231001" with "1000" amount and expected disbursement date on "20231001"
    When Admin successfully disburse the loan on "20231001" with "1000" EUR transaction amount
    When Admin sets the business date to "20231002"
    When Admin runs inline COB job for Loan
    Then Loan has the following LOAN level delinquency data:
      | classification | delinquentAmount | delinquentDate  | delinquentDays | pastDueDays |
      | NO_DELINQUENCY | 250.0            | 20231004 | 0              | 1           |
    Then INSTALLMENT level delinquency is null
    When Admin sets the business date to "20231004"
    When Admin runs inline COB job for Loan
    Then Loan has the following LOAN level delinquency data:
      | classification | delinquentAmount | delinquentDate  | delinquentDays | pastDueDays |
      | NO_DELINQUENCY | 250.0            | 20231004 | 0              | 3           |
    Then INSTALLMENT level delinquency is null
    When Admin sets the business date to "20231005"
    When Admin runs inline COB job for Loan
    Then Loan has the following LOAN level delinquency data:
      | classification | delinquentAmount | delinquentDate  | delinquentDays | pastDueDays |
      | RANGE_1        | 250.0            | 20231004 | 1              | 4           |
#   --- Grace period applied only on Loan level, not on installment level ---
    Then Loan has the following INSTALLMENT level delinquency data:
      | Range   | Amount |
      | RANGE_3 | 250.00 |
    When Admin sets the business date to "20231006"
    When Admin initiate a DELINQUENCY PAUSE with startDate: "20231006" and endDate: "20231030"
    Then Loan Delinquency pause periods has the following data:
      | active | pausePeriodStart | pausePeriodEnd  |
      | true   | 20231006  | 20231030 |
    Then Delinquency-actions have the following data:
      | action | startDate       | endDate         |
      | PAUSE  | 20231006 | 20231030 |
    When Admin runs inline COB job for Loan
    Then Loan has the following LOAN level delinquency data:
      | classification | delinquentAmount | delinquentDate  | delinquentDays | pastDueDays |
      | RANGE_1        | 250.0            | 20231004 | 2              | 5           |
#    --- Grace period applied only on Loan level, not on installment level ---
    Then Loan has the following INSTALLMENT level delinquency data:
      | Range   | Amount |
      | RANGE_3 | 250.00 |
    When Admin sets the business date to "20231030"
    When Admin runs inline COB job for Loan
    Then Loan has the following LOAN level delinquency data:
      | classification | delinquentAmount | delinquentDate  | delinquentDays | pastDueDays |
      | RANGE_1        | 500.0            | 20231004 | 2              | 29          |
    Then Loan Delinquency pause periods has the following data:
      | active | pausePeriodStart | pausePeriodEnd  |
      | true   | 20231006  | 20231030 |
#    --- Grace period applied only on Loan level, not on installment level ---
    Then Loan has the following INSTALLMENT level delinquency data:
      | Range   | Amount |
      | RANGE_3 | 250.00 |
    When Admin sets the business date to "20231031"
    When Admin runs inline COB job for Loan
    Then Loan has the following LOAN level delinquency data:
      | classification | delinquentAmount | delinquentDate  | delinquentDays | pastDueDays |
      | RANGE_1        | 500.0            | 20231004 | 3              | 30          |
    Then Loan Delinquency pause periods has the following data:
      | active | pausePeriodStart | pausePeriodEnd  |
      | false  | 20231006  | 20231030 |
#    --- Grace period applied only on Loan level, not on installment level ---
    Then Loan has the following INSTALLMENT level delinquency data:
      | Range   | Amount |
      | RANGE_1 | 250.00 |
      | RANGE_3 | 250.00 |

  @TestRailId:C3000
  Scenario: Verify Loan delinquency pause E2E - PAUSE period with RESUME
    When Admin sets the business date to "20231001"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                                       | submitted on date | with Principal | ANNUAL interest rate % | interest type | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_DOWNPAYMENT_ADV_PMT_ALLOC_PROGRESSIVE_LOAN_SCHEDULE_HORIZONTAL_INSTALLMENT_LEVEL_DELINQUENCY | 20231001   | 1000           | 0                      | FLAT          | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 45                | DAYS                  | 15             | DAYS                   | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20231001" with "1000" amount and expected disbursement date on "20231001"
    When Admin successfully disburse the loan on "20231001" with "1000" EUR transaction amount
    When Admin runs inline COB job for Loan
#    --- Delinquency pause ---
    When Admin sets the business date to "20231015"
    When Admin initiate a DELINQUENCY PAUSE with startDate: "20231015" and endDate: "20231030"
    When Admin runs inline COB job for Loan
    Then Loan Delinquency pause periods has the following data:
      | active | pausePeriodStart | pausePeriodEnd  |
      | true   | 20231015  | 20231030 |
    Then Delinquency-actions have the following data:
      | action | startDate       | endDate         |
      | PAUSE  | 20231015 | 20231030 |
    Then Loan has the following LOAN level delinquency data:
      | classification | delinquentAmount | delinquentDate  | delinquentDays | pastDueDays |
      | RANGE_3        | 250.0            | 20231004 | 11             | 14          |
    Then Loan has the following INSTALLMENT level delinquency data:
      | Range   | Amount |
      | RANGE_3 | 250.00 |
    Then Installment level delinquency event has correct data
#    --- Delinquency resume ---
    When Admin sets the business date to "20231025"
    When Admin initiate a DELINQUENCY RESUME with startDate: "20231025"
    When Admin runs inline COB job for Loan
    Then Loan Delinquency pause periods has the following data:
      | active | pausePeriodStart | pausePeriodEnd  |
      | true   | 20231015  | 20231025 |
    When Admin sets the business date to "20231026"
    Then Loan Delinquency pause periods has the following data:
      | active | pausePeriodStart | pausePeriodEnd  |
      | false  | 20231015  | 20231025 |
    Then Delinquency-actions have the following data:
      | action | startDate       | endDate         |
      | PAUSE  | 20231015 | 20231030 |
      | RESUME | 20231025 |                 |
    Then Loan has the following LOAN level delinquency data:
      | classification | delinquentAmount | delinquentDate  | delinquentDays | pastDueDays |
      | RANGE_3        | 500.0            | 20231004 | 12             | 25          |
    Then Loan has the following INSTALLMENT level delinquency data:
      | Range   | Amount |
      | RANGE_3 | 250.00 |
    Then Installment level delinquency event has correct data

  @TestRailId:C3001
  Scenario: Verify Loan delinquency pause E2E - PAUSE period with RESUME and second PAUSE
    When Admin sets the business date to "20231001"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                                       | submitted on date | with Principal | ANNUAL interest rate % | interest type | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_DOWNPAYMENT_ADV_PMT_ALLOC_PROGRESSIVE_LOAN_SCHEDULE_HORIZONTAL_INSTALLMENT_LEVEL_DELINQUENCY | 20231001   | 1000           | 0                      | FLAT          | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 45                | DAYS                  | 15             | DAYS                   | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20231001" with "1000" amount and expected disbursement date on "20231001"
    When Admin successfully disburse the loan on "20231001" with "1000" EUR transaction amount
    When Admin runs inline COB job for Loan
#    --- Delinquency pause ---
    When Admin sets the business date to "20231015"
    When Admin initiate a DELINQUENCY PAUSE with startDate: "20231015" and endDate: "20231030"
    When Admin runs inline COB job for Loan
    Then Loan Delinquency pause periods has the following data:
      | active | pausePeriodStart | pausePeriodEnd  |
      | true   | 20231015  | 20231030 |
    Then Delinquency-actions have the following data:
      | action | startDate       | endDate         |
      | PAUSE  | 20231015 | 20231030 |
    When Admin sets the business date to "20231016"
    When Admin runs inline COB job for Loan
    Then Loan has the following LOAN level delinquency data:
      | classification | delinquentAmount | delinquentDate  | delinquentDays | pastDueDays |
      | RANGE_3        | 250.0            | 20231004 | 11             | 15          |
    Then Loan has the following INSTALLMENT level delinquency data:
      | Range   | Amount |
      | RANGE_3 | 250.00 |
    Then Installment level delinquency event has correct data
#    --- Delinquency resume ---
    When Admin sets the business date to "20231025"
    When Admin initiate a DELINQUENCY RESUME with startDate: "20231025"
    When Admin runs inline COB job for Loan
    Then Loan Delinquency pause periods has the following data:
      | active | pausePeriodStart | pausePeriodEnd  |
      | true   | 20231015  | 20231025 |
    When Admin sets the business date to "20231026"
    Then Loan Delinquency pause periods has the following data:
      | active | pausePeriodStart | pausePeriodEnd  |
      | false  | 20231015  | 20231025 |
    Then Delinquency-actions have the following data:
      | action | startDate       | endDate         |
      | PAUSE  | 20231015 | 20231030 |
      | RESUME | 20231025 |                 |
    Then Loan has the following LOAN level delinquency data:
      | classification | delinquentAmount | delinquentDate  | delinquentDays | pastDueDays |
      | RANGE_3        | 500.0            | 20231004 | 12             | 25          |
    Then Loan has the following INSTALLMENT level delinquency data:
      | Range   | Amount |
      | RANGE_3 | 250.00 |
    Then Installment level delinquency event has correct data
#   --- Delinquency runs ---
    When Admin sets the business date to "20231113"
    When Admin runs inline COB job for Loan
    Then Loan Delinquency pause periods has the following data:
      | active | pausePeriodStart | pausePeriodEnd  |
      | false  | 20231015  | 20231025 |
    Then Delinquency-actions have the following data:
      | action | startDate       | endDate         |
      | PAUSE  | 20231015 | 20231030 |
      | RESUME | 20231025 |                 |
    Then Loan has the following LOAN level delinquency data:
      | classification | delinquentAmount | delinquentDate  | delinquentDays | pastDueDays |
      | RANGE_3        | 750.0            | 20231004 | 30             | 43          |
    Then Loan has the following INSTALLMENT level delinquency data:
      | Range    | Amount |
      | RANGE_3  | 500.00 |
      | RANGE_30 | 250.00 |
#    --- Second delinquency pause ---
    When Admin sets the business date to "20231114"
    When Admin initiate a DELINQUENCY PAUSE with startDate: "20231114" and endDate: "20231130"
    When Admin runs inline COB job for Loan
    Then Loan Delinquency pause periods has the following data:
      | active | pausePeriodStart | pausePeriodEnd   |
      | false  | 20231015  | 20231025  |
      | true   | 20231114 | 20231130 |
    Then Delinquency-actions have the following data:
      | action | startDate        | endDate          |
      | PAUSE  | 20231015  | 20231030  |
      | RESUME | 20231025  |                  |
      | PAUSE  | 20231114 | 20231130 |
    Then Loan has the following LOAN level delinquency data:
      | classification | delinquentAmount | delinquentDate  | delinquentDays | pastDueDays |
      | RANGE_3        | 750.0            | 20231004 | 31             | 44          |
    Then Loan has the following INSTALLMENT level delinquency data:
      | Range    | Amount |
      | RANGE_3  | 500.00 |
      | RANGE_30 | 250.00 |
    Then Installment level delinquency event has correct data
#    --- Second delinquency ends ---
    When Admin sets the business date to "20231130"
    When Admin runs inline COB job for Loan
    Then Loan Delinquency pause periods has the following data:
      | active | pausePeriodStart | pausePeriodEnd   |
      | false  | 20231015  | 20231025  |
      | true   | 20231114 | 20231130 |
    Then Delinquency-actions have the following data:
      | action | startDate        | endDate          |
      | PAUSE  | 20231015  | 20231030  |
      | RESUME | 20231025  |                  |
      | PAUSE  | 20231114 | 20231130 |
    Then Loan has the following LOAN level delinquency data:
      | classification | delinquentAmount | delinquentDate  | delinquentDays | pastDueDays |
      | RANGE_3       | 1000.0           | 20231004 | 31             | 60          |
    Then Loan has the following INSTALLMENT level delinquency data:
      | Range    | Amount |
      | RANGE_3  | 500.00 |
      | RANGE_30 | 250.00 |
#    --- Delinquency runs again ---
    When Admin sets the business date to "20231201"
    When Admin runs inline COB job for Loan
    Then Loan Delinquency pause periods has the following data:
      | active | pausePeriodStart | pausePeriodEnd   |
      | false  | 20231015  | 20231025  |
      | false  | 20231114 | 20231130 |
    Then Delinquency-actions have the following data:
      | action | startDate        | endDate          |
      | PAUSE  | 20231015  | 20231030  |
      | RESUME | 20231025  |                  |
      | PAUSE  | 20231114 | 20231130 |
    Then Loan has the following LOAN level delinquency data:
      | classification | delinquentAmount | delinquentDate  | delinquentDays | pastDueDays |
      | RANGE_30       | 1000.0           | 20231004 | 32             | 61          |
    Then Loan has the following INSTALLMENT level delinquency data:
      | Range    | Amount |
      | RANGE_1  | 250.00 |
      | RANGE_3  | 500.00 |
      | RANGE_30 | 250.00 |
    Then Installment level delinquency event has correct data

  @TestRailId:C3002
  Scenario: Verify Loan delinquency pause E2E - full repayment (late/due date) during PAUSE period
    When Admin sets the business date to "20231001"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                                       | submitted on date | with Principal | ANNUAL interest rate % | interest type | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_DOWNPAYMENT_ADV_PMT_ALLOC_PROGRESSIVE_LOAN_SCHEDULE_HORIZONTAL_INSTALLMENT_LEVEL_DELINQUENCY | 20231001   | 1000           | 0                      | FLAT          | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 45                | DAYS                  | 15             | DAYS                   | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20231001" with "1000" amount and expected disbursement date on "20231001"
    When Admin successfully disburse the loan on "20231001" with "1000" EUR transaction amount
    When Admin runs inline COB job for Loan
#    --- Delinquency pause ---
    When Admin sets the business date to "20231006"
    When Admin initiate a DELINQUENCY PAUSE with startDate: "20231006" and endDate: "20231030"
    When Admin runs inline COB job for Loan
    Then Loan Delinquency pause periods has the following data:
      | active | pausePeriodStart | pausePeriodEnd  |
      | true   | 20231006  | 20231030 |
    Then Delinquency-actions have the following data:
      | action | startDate       | endDate         |
      | PAUSE  | 20231006 | 20231030 |
    Then Loan has the following LOAN level delinquency data:
      | classification | delinquentAmount | delinquentDate  | delinquentDays | pastDueDays |
      | RANGE_1        | 250.0            | 20231004 | 2              | 5           |
#    --- Grace period applied only on Loan level, not on installment level ---
    Then Loan has the following INSTALLMENT level delinquency data:
      | Range   | Amount |
      | RANGE_3 | 250.00 |
    Then Installment level delinquency event has correct data
#    --- Full repayment for late/due date installments ---
    When Admin sets the business date to "20231016"
    Then Loan Delinquency pause periods has the following data:
      | active | pausePeriodStart | pausePeriodEnd  |
      | true   | 20231006  | 20231030 |
    Then Delinquency-actions have the following data:
      | action | startDate       | endDate         |
      | PAUSE  | 20231006 | 20231030 |
    Then Loan has the following LOAN level delinquency data:
      | classification | delinquentAmount | delinquentDate  | delinquentDays | pastDueDays |
      | RANGE_1        | 250.0            | 20231004 | 2              | 15          |
#    --- Grace period applied only on Loan level, not on installment level ---
    Then Loan has the following INSTALLMENT level delinquency data:
      | Range   | Amount |
      | RANGE_3 | 250.00 |
    And Customer makes "AUTOPAY" repayment on "20231016" with 500 EUR transaction amount
    When Admin runs inline COB job for Loan
    Then Loan Delinquency pause periods has the following data:
      | active | pausePeriodStart | pausePeriodEnd  |
      | true   | 20231006  | 20231030 |
    Then Delinquency-actions have the following data:
      | action | startDate       | endDate         |
      | PAUSE  | 20231006 | 20231030 |
    Then Loan has the following LOAN level delinquency data:
      | classification | delinquentAmount | delinquentDate | delinquentDays | pastDueDays |
      | NO_DELINQUENCY | 0.0              | null           | 0              | 0           |
    Then INSTALLMENT level delinquency is null

  @TestRailId:C3003
  Scenario: Verify Loan delinquency pause E2E - partial repayment during PAUSE period
    When Admin sets the business date to "20231001"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                                       | submitted on date | with Principal | ANNUAL interest rate % | interest type | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_DOWNPAYMENT_ADV_PMT_ALLOC_PROGRESSIVE_LOAN_SCHEDULE_HORIZONTAL_INSTALLMENT_LEVEL_DELINQUENCY | 20231001   | 1000           | 0                      | FLAT          | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 45                | DAYS                  | 15             | DAYS                   | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20231001" with "1000" amount and expected disbursement date on "20231001"
    When Admin successfully disburse the loan on "20231001" with "1000" EUR transaction amount
    When Admin runs inline COB job for Loan
#    --- Delinquency pause ---
    When Admin sets the business date to "20231006"
    When Admin initiate a DELINQUENCY PAUSE with startDate: "20231006" and endDate: "20231030"
    When Admin runs inline COB job for Loan
    Then Loan Delinquency pause periods has the following data:
      | active | pausePeriodStart | pausePeriodEnd  |
      | true   | 20231006  | 20231030 |
    Then Delinquency-actions have the following data:
      | action | startDate       | endDate         |
      | PAUSE  | 20231006 | 20231030 |
    Then Loan has the following LOAN level delinquency data:
      | classification | delinquentAmount | delinquentDate  | delinquentDays | pastDueDays |
      | RANGE_1        | 250.0            | 20231004 | 2              | 5           |
#    --- Grace period applied only on Loan level, not on installment level ---
    Then Loan has the following INSTALLMENT level delinquency data:
      | Range   | Amount |
      | RANGE_3 | 250.00 |
    Then Installment level delinquency event has correct data
#    --- Full repayment for late/due date installments ---
    When Admin sets the business date to "20231016"
    Then Loan Delinquency pause periods has the following data:
      | active | pausePeriodStart | pausePeriodEnd  |
      | true   | 20231006  | 20231030 |
    Then Delinquency-actions have the following data:
      | action | startDate       | endDate         |
      | PAUSE  | 20231006 | 20231030 |
    Then Loan has the following LOAN level delinquency data:
      | classification | delinquentAmount | delinquentDate  | delinquentDays | pastDueDays |
      | RANGE_1        | 250.0            | 20231004 | 2              | 15          |
#    --- Grace period applied only on Loan level, not on installment level ---
    Then Loan has the following INSTALLMENT level delinquency data:
      | Range   | Amount |
      | RANGE_3 | 250.00 |
    And Customer makes "AUTOPAY" repayment on "20231016" with 150 EUR transaction amount
    When Admin runs inline COB job for Loan
    Then Loan Delinquency pause periods has the following data:
      | active | pausePeriodStart | pausePeriodEnd  |
      | true   | 20231006  | 20231030 |
    Then Delinquency-actions have the following data:
      | action | startDate       | endDate         |
      | PAUSE  | 20231006 | 20231030 |
    Then Loan has the following LOAN level delinquency data:
      | classification | delinquentAmount | delinquentDate  | delinquentDays | pastDueDays |
      | RANGE_1        | 100.0            | 20231004 | 2              | 15          |
#    --- Grace period applied only on Loan level, not on installment level ---
    Then Loan has the following INSTALLMENT level delinquency data:
      | Range   | Amount |
      | RANGE_3 | 100.00 |

  @TestRailId:C3004
  Scenario: Verify Loan delinquency pause E2E - full repayment (only late) during PAUSE period then RESUME
    When Admin sets the business date to "20231001"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                                       | submitted on date | with Principal | ANNUAL interest rate % | interest type | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_DOWNPAYMENT_ADV_PMT_ALLOC_PROGRESSIVE_LOAN_SCHEDULE_HORIZONTAL_INSTALLMENT_LEVEL_DELINQUENCY | 20231001   | 1000           | 0                      | FLAT          | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 45                | DAYS                  | 15             | DAYS                   | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20231001" with "1000" amount and expected disbursement date on "20231001"
    When Admin successfully disburse the loan on "20231001" with "1000" EUR transaction amount
    When Admin runs inline COB job for Loan
#    --- Delinquency pause ---
    When Admin sets the business date to "20231006"
    When Admin initiate a DELINQUENCY PAUSE with startDate: "20231006" and endDate: "20231030"
    When Admin runs inline COB job for Loan
    Then Loan Delinquency pause periods has the following data:
      | active | pausePeriodStart | pausePeriodEnd  |
      | true   | 20231006  | 20231030 |
    Then Delinquency-actions have the following data:
      | action | startDate       | endDate         |
      | PAUSE  | 20231006 | 20231030 |
    Then Loan has the following LOAN level delinquency data:
      | classification | delinquentAmount | delinquentDate  | delinquentDays | pastDueDays |
      | RANGE_1        | 250.0            | 20231004 | 2              | 5           |
#    --- Grace period applied only on Loan level, not on installment level ---
    Then Loan has the following INSTALLMENT level delinquency data:
      | Range   | Amount |
      | RANGE_3 | 250.00 |
    Then Installment level delinquency event has correct data
#    --- Full repayment for late/due date installments ---
    When Admin sets the business date to "20231016"
    Then Loan Delinquency pause periods has the following data:
      | active | pausePeriodStart | pausePeriodEnd  |
      | true   | 20231006  | 20231030 |
    Then Delinquency-actions have the following data:
      | action | startDate       | endDate         |
      | PAUSE  | 20231006 | 20231030 |
    Then Loan has the following LOAN level delinquency data:
      | classification | delinquentAmount | delinquentDate  | delinquentDays | pastDueDays |
      | RANGE_1        | 250.0            | 20231004 | 2              | 15          |
#    --- Grace period applied only on Loan level, not on installment level ---
    Then Loan has the following INSTALLMENT level delinquency data:
      | Range   | Amount |
      | RANGE_3 | 250.00 |
    And Customer makes "AUTOPAY" repayment on "20231016" with 250 EUR transaction amount
    When Admin runs inline COB job for Loan
    Then Loan Delinquency pause periods has the following data:
      | active | pausePeriodStart | pausePeriodEnd  |
      | true   | 20231006  | 20231030 |
    Then Delinquency-actions have the following data:
      | action | startDate       | endDate         |
      | PAUSE  | 20231006 | 20231030 |
    Then Loan has the following LOAN level delinquency data:
      | classification | delinquentAmount | delinquentDate | delinquentDays | pastDueDays |
      | NO_DELINQUENCY | 0.0              | null           | 0              | 0           |
    Then INSTALLMENT level delinquency is null
#   --- Delinquency resume ---
    When Admin sets the business date to "20231025"
    When Admin initiate a DELINQUENCY RESUME with startDate: "20231025"
    When Admin runs inline COB job for Loan
    Then Loan Delinquency pause periods has the following data:
      | active | pausePeriodStart | pausePeriodEnd  |
      | true   | 20231006  | 20231025 |
    When Admin sets the business date to "20231026"
    Then Loan Delinquency pause periods has the following data:
      | active | pausePeriodStart | pausePeriodEnd  |
      | false  | 20231006  | 20231025 |
    Then Delinquency-actions have the following data:
      | action | startDate       | endDate         |
      | PAUSE  | 20231006 | 20231030 |
      | RESUME | 20231025 |                 |
    Then Loan has the following LOAN level delinquency data:
      | classification | delinquentAmount | delinquentDate  | delinquentDays | pastDueDays |
      | NO_DELINQUENCY | 250.0            | 20231019 | 0              | 10          |
    Then INSTALLMENT level delinquency is null
#   --- Delinquency runs ---
    When Admin sets the business date to "20231115"
    When Admin runs inline COB job for Loan
    Then Loan Delinquency pause periods has the following data:
      | active | pausePeriodStart | pausePeriodEnd  |
      | false  | 20231006  | 20231025 |
    Then Delinquency-actions have the following data:
      | action | startDate       | endDate         |
      | PAUSE  | 20231006 | 20231030 |
      | RESUME | 20231025 |                 |
    Then Loan has the following LOAN level delinquency data:
      | classification | delinquentAmount | delinquentDate  | delinquentDays | pastDueDays |
      | RANGE_3        | 500.0            | 20231019 | 18             | 30          |
#    --- Grace period applied only on Loan level, not on installment level ---
    Then Loan has the following INSTALLMENT level delinquency data:
      | Range   | Amount |
      | RANGE_3 | 500.00 |
    Then Installment level delinquency event has correct data

  @TestRailId:C3013
  Scenario: Verify that in case of resume on end/start date of continous pause periods first period ends automatically, second period ended by resume
    When Admin sets the business date to "20231001"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                                       | submitted on date | with Principal | ANNUAL interest rate % | interest type | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_DOWNPAYMENT_ADV_PMT_ALLOC_PROGRESSIVE_LOAN_SCHEDULE_HORIZONTAL_INSTALLMENT_LEVEL_DELINQUENCY | 20231001   | 1000           | 0                      | FLAT          | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 45                | DAYS                  | 15             | DAYS                   | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20231001" with "1000" amount and expected disbursement date on "20231001"
    When Admin successfully disburse the loan on "20231001" with "1000" EUR transaction amount
    When Admin runs inline COB job for Loan
    When Admin sets the business date to "20231025"
    When Admin initiate a DELINQUENCY PAUSE with startDate: "20231025" and endDate: "20231030"
    Then Delinquency-actions have the following data:
      | action | startDate       | endDate         |
      | PAUSE  | 20231025 | 20231030 |
    Then Loan Delinquency pause periods has the following data:
      | active | pausePeriodStart | pausePeriodEnd  |
      | true   | 20231025  | 20231030 |
    When Admin sets the business date to "20231030"
    When Admin initiate a DELINQUENCY PAUSE with startDate: "20231030" and endDate: "20231115"
    Then Delinquency-actions have the following data:
      | action | startDate       | endDate          |
      | PAUSE  | 20231025 | 20231030  |
      | PAUSE  | 20231030 | 20231115 |
    Then Loan Delinquency pause periods has the following data:
      | active | pausePeriodStart | pausePeriodEnd   |
      | true   | 20231025  | 20231030  |
      | true   | 20231030  | 20231115 |
    Then Loan has the following LOAN level delinquency data:
      | classification | delinquentAmount | delinquentDate  | delinquentDays | pastDueDays |
      | NO_DELINQUENCY | 500.0            | 20231004 | 21             | 29          |
    Then INSTALLMENT level delinquency is null
    When Admin initiate a DELINQUENCY RESUME with startDate: "20231030"
    Then Loan has the following LOAN level delinquency data:
      | classification | delinquentAmount | delinquentDate  | delinquentDays | pastDueDays |
      | NO_DELINQUENCY | 500.0            | 20231004 | 21             | 29          |
    Then INSTALLMENT level delinquency is null
    When Admin runs inline COB job for Loan
    Then Delinquency-actions have the following data:
      | action | startDate       | endDate          |
      | PAUSE  | 20231025 | 20231030  |
      | PAUSE  | 20231030 | 20231115 |
      | RESUME | 20231030 |                  |
    Then Loan Delinquency pause periods has the following data:
      | active | pausePeriodStart | pausePeriodEnd  |
      | true   | 20231025  | 20231030 |
      | true   | 20231030  | 20231030 |
    Then Loan has the following LOAN level delinquency data:
      | classification | delinquentAmount | delinquentDate  | delinquentDays | pastDueDays |
      | RANGE_3        | 500.0            | 20231004 | 21             | 29          |
    Then Loan has the following INSTALLMENT level delinquency data:
      | Range   | Amount |
      | RANGE_3 | 500.00 |
    When Admin sets the business date to "20231031"
    Then Loan Delinquency pause periods has the following data:
      | active | pausePeriodStart | pausePeriodEnd  |
      | false  | 20231025  | 20231030 |
      | false  | 20231030  | 20231030 |
    Then Loan has the following LOAN level delinquency data:
      | classification | delinquentAmount | delinquentDate  | delinquentDays | pastDueDays |
      | RANGE_3        | 500.0            | 20231004 | 22             | 30          |
    Then Loan has the following INSTALLMENT level delinquency data:
      | Range   | Amount |
      | RANGE_3 | 500.00 |

  @TestRailId:C3014
  Scenario: Verify that creating a loan with Advanced payment allocation with product no Advanced payment allocation set results an error
    When Admin sets the business date to "20231001"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with Advanced payment allocation and with product no Advanced payment allocation set results an error:
      | LoanProduct | submitted on date | with Principal | ANNUAL interest rate % | interest type | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP1       | 20231001   | 1000           | 0                      | FLAT          | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 45                | DAYS                  | 15             | DAYS                   | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |

  @TestRailId:C3015
  Scenario: Verify Backdated Pause Delinquency - Event Trigger: LoanDelinquencyRangeChangeBusinessEvent, LoanAccountDelinquencyPauseChangedBusinessEvent check
    When Admin sets the business date to "20231001"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                                       | submitted on date | with Principal | ANNUAL interest rate % | interest type | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_DOWNPAYMENT_ADV_PMT_ALLOC_PROGRESSIVE_LOAN_SCHEDULE_HORIZONTAL_INSTALLMENT_LEVEL_DELINQUENCY | 20231001   | 1000           | 0                      | FLAT          | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 45                | DAYS                  | 15             | DAYS                   | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20231001" with "1000" amount and expected disbursement date on "20231001"
    When Admin successfully disburse the loan on "20231001" with "1000" EUR transaction amount
    When Admin sets the business date to "20231025"
    When Admin runs inline COB job for Loan
    Then Loan has the following LOAN level delinquency data:
      | classification | delinquentAmount | delinquentDate  | delinquentDays | pastDueDays |
      | RANGE_3        | 500.0            | 20231004 | 21             | 24          |
    Then Loan has the following INSTALLMENT level delinquency data:
      | Range   | Amount |
      | RANGE_3 | 500.00 |
    When Admin sets the business date to "20231027"
#    event checks included in next steps
    When Admin initiate a DELINQUENCY PAUSE with startDate: "20231025" and endDate: "20231115"
    Then Admin checks that delinquency range is: "RANGE_3" and has delinquentDate "2023-10-04"
    Then Installment level delinquency event has correct data
    Then Delinquency-actions have the following data:
      | action | startDate       | endDate          |
      | PAUSE  | 20231025 | 20231115 |
    Then Loan Delinquency pause periods has the following data:
      | active | pausePeriodStart | pausePeriodEnd   |
      | true   | 20231025  | 20231115 |
    Then Loan has the following LOAN level delinquency data:
      | classification | delinquentAmount | delinquentDate  | delinquentDays | pastDueDays |
      | RANGE_3        | 500.0            | 20231004 | 21             | 26          |
    Then Loan has the following INSTALLMENT level delinquency data:
      | Range   | Amount |
      | RANGE_3 | 500.00 |

  @TestRailId:C3016
  Scenario: Verify that for pause period calculations business date is being used instead of COB date
    When Admin sets the business date to "20231001"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                                       | submitted on date | with Principal | ANNUAL interest rate % | interest type | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_DOWNPAYMENT_ADV_PMT_ALLOC_PROGRESSIVE_LOAN_SCHEDULE_HORIZONTAL_INSTALLMENT_LEVEL_DELINQUENCY | 20231001   | 1000           | 0                      | FLAT          | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 45                | DAYS                  | 15             | DAYS                   | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20231001" with "1000" amount and expected disbursement date on "20231001"
    When Admin successfully disburse the loan on "20231001" with "1000" EUR transaction amount
    And Customer makes "AUTOPAY" repayment on "20231001" with 250 EUR transaction amount
#    --- Delinquency pause ---
    When Admin sets the business date to "20231005"
    When Admin initiate a DELINQUENCY PAUSE with startDate: "20231016" and endDate: "20231025"
    When Admin runs inline COB job for Loan
    When Admin sets the business date to "20231025"
    When Admin runs inline COB job for Loan
#    --- Because of grace period 3 days delinguency won't start ---
    When Admin sets the business date to "20231026"
    When Admin runs inline COB job for Loan
    Then Loan has the following LOAN level delinquency data:
      | classification | delinquentAmount | delinquentDate  | delinquentDays | pastDueDays |
      | NO_DELINQUENCY | 250.0            | 20231019 | 0              | 10          |
    Then INSTALLMENT level delinquency is null
#    -----------
    When Admin sets the business date to "20231027"
    When Admin runs inline COB job for Loan
    Then Loan has the following LOAN level delinquency data:
      | classification | delinquentAmount | delinquentDate  | delinquentDays | pastDueDays |
      | NO_DELINQUENCY | 250.0            | 20231019 | 0              | 11          |
    Then INSTALLMENT level delinquency is null
#    -----------
    When Admin sets the business date to "20231028"
    When Admin runs inline COB job for Loan
    Then Loan has the following LOAN level delinquency data:
      | classification | delinquentAmount | delinquentDate  | delinquentDays | pastDueDays |
      | NO_DELINQUENCY | 250.0            | 20231019 | 0              | 12          |
    Then INSTALLMENT level delinquency is null
#    --- After grace period ends delinquency starts ---
    When Admin sets the business date to "20231029"
    When Admin runs inline COB job for Loan
    Then Loan has the following LOAN level delinquency data:
      | classification | delinquentAmount | delinquentDate  | delinquentDays | pastDueDays |
      | RANGE_1        | 250.0            | 20231019 | 1              | 13          |
#    --- Grace period applied only on Loan level, not on installment level ---
    Then Loan has the following INSTALLMENT level delinquency data:
      | Range   | Amount |
      | RANGE_3 | 250.00 |
    Then Installment level delinquency event has correct data
    Then Loan Delinquency pause periods has the following data:
      | active | pausePeriodStart | pausePeriodEnd  |
      | false  | 20231016  | 20231025 |
    Then Delinquency-actions have the following data:
      | action | startDate       | endDate         |
      | PAUSE  | 20231016 | 20231025 |

  @TestRailId:C3018
  Scenario: Verify that if Global configuration: next-payment-due-date is set to: earliest-unpaid-date then in Loan details delinquent.nextPaymentDueDate will be the first unpaid installment date
    When Global config "next-payment-due-date" value set to "earliest-unpaid-date"
    When Admin sets the business date to "20231001"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                                       | submitted on date | with Principal | ANNUAL interest rate % | interest type | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_DOWNPAYMENT_ADV_PMT_ALLOC_PROGRESSIVE_LOAN_SCHEDULE_HORIZONTAL_INSTALLMENT_LEVEL_DELINQUENCY | 20231001   | 1000           | 0                      | FLAT          | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 45                | DAYS                  | 15             | DAYS                   | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20231001" with "1000" amount and expected disbursement date on "20231001"
    When Admin successfully disburse the loan on "20231001" with "1000" EUR transaction amount
    When Admin sets the business date to "20231011"
    Then Loan details delinquent.nextPaymentDueDate will be "20231001"
    When Admin sets the business date to "20231021"
    Then Loan details delinquent.nextPaymentDueDate will be "20231001"
    When Global config "next-payment-due-date" value set to "earliest-unpaid-date"

  @TestRailId:C3019
  Scenario: Verify that if Global configuration: next-payment-due-date is set to: next-unpaid-due-date then in Loan details delinquent.nextPaymentDueDate will be the next unpaid installment date regardless of the status of previous installments
    When Global config "next-payment-due-date" value set to "next-unpaid-due-date"
    When Admin sets the business date to "20231001"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                                       | submitted on date | with Principal | ANNUAL interest rate % | interest type | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_DOWNPAYMENT_ADV_PMT_ALLOC_PROGRESSIVE_LOAN_SCHEDULE_HORIZONTAL_INSTALLMENT_LEVEL_DELINQUENCY | 20231001   | 1000           | 0                      | FLAT          | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 45                | DAYS                  | 15             | DAYS                   | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20231001" with "1000" amount and expected disbursement date on "20231001"
    When Admin successfully disburse the loan on "20231001" with "1000" EUR transaction amount
    When Admin sets the business date to "20231011"
    Then Loan details delinquent.nextPaymentDueDate will be "20231016"
    When Admin sets the business date to "20231021"
    Then Loan details delinquent.nextPaymentDueDate will be "20231031"
    When Global config "next-payment-due-date" value set to "earliest-unpaid-date"

  @TestRailId:C3032
  Scenario: Verify that delinquencyRange field in LoanAccountDelinquencyRangeDataV1 is not null in case of delinquent Loan
    When Admin sets the business date to "20231001"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                                       | submitted on date | with Principal | ANNUAL interest rate % | interest type | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_DOWNPAYMENT_ADV_PMT_ALLOC_PROGRESSIVE_LOAN_SCHEDULE_HORIZONTAL_INSTALLMENT_LEVEL_DELINQUENCY | 20231001   | 1000           | 0                      | FLAT          | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 45                | DAYS                  | 15             | DAYS                   | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20231001" with "1000" amount and expected disbursement date on "20231001"
    When Admin successfully disburse the loan on "20231001" with "1000" EUR transaction amount
    When Admin sets the business date to "20231201"
    When Admin runs inline COB job for Loan
    Then LoanAccountDelinquencyRangeDataV1 has delinquencyRange field with value "RANGE_30"
    Then Loan has the following LOAN level delinquency data:
      | classification | delinquentAmount | delinquentDate  | delinquentDays | pastDueDays |
      | RANGE_30       | 1000.0           | 20231004 | 58             | 61          |

  @TestRailId:C3035
  Scenario: Verify that delinquency is NOT applied after loan submitted and approved
    When Admin sets the business date to "20231030"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                                       | submitted on date | with Principal | ANNUAL interest rate % | interest type | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_DOWNPAYMENT_ADV_PMT_ALLOC_PROGRESSIVE_LOAN_SCHEDULE_HORIZONTAL_INSTALLMENT_LEVEL_DELINQUENCY | 20231001   | 1000           | 0                      | FLAT          | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 45                | DAYS                  | 15             | DAYS                   | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    Then Loan has the following LOAN level delinquency data:
      | classification | delinquentAmount | delinquentDate | delinquentDays | pastDueDays |
      | NO_DELINQUENCY | 0.0              | null           | 0              | 0           |
    And Admin successfully approves the loan on "20231001" with "1000" amount and expected disbursement date on "20231001"
    Then Loan has the following LOAN level delinquency data:
      | classification | delinquentAmount | delinquentDate | delinquentDays | pastDueDays |
      | NO_DELINQUENCY | 0.0              | null           | 0              | 0           |

  @TestRailId:C3047
  Scenario: Verify that delinquent.lastRepaymentAmount is calculated correctly in case of auto downpayment
    When Admin sets the business date to "20240201"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                       | submitted on date | with Principal | ANNUAL interest rate % | interest type | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_DOWNPAYMENT_AUTO_ADVANCED_PAYMENT_ALLOCATION | 20240201  | 1000           | 0                      | FLAT          | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 45                | DAYS                  | 15             | DAYS                   | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240201" with "1000" amount and expected disbursement date on "20240201"
    When Admin successfully disburse the loan on "20240201" with "1000" EUR transaction amount
    When Admin sets the business date to "20240401"
    Then In Loan details delinquent.lastRepaymentAmount is 250 EUR with lastRepaymentDate "20240201"

  @TestRailId:C3066 @AdvancedPaymentAllocation
  Scenario: Verify that on Loans in SUBMITTED_AND_PENDING_APPROVAL or APPROVED status delinquency is not applied
    When Admin sets the business date to "20240201"
    When Admin creates a client with random data
    When Admin set "LP2_DOWNPAYMENT_AUTO_ADVANCED_PAYMENT_ALLOCATION" loan product "DEFAULT" transaction type to "NEXT_INSTALLMENT" future installment allocation rule
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                       | submitted on date | with Principal | ANNUAL interest rate % | interest type | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_DOWNPAYMENT_AUTO_ADVANCED_PAYMENT_ALLOCATION | 20240201  | 1000           | 0                      | FLAT          | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 45                | DAYS                  | 15             | DAYS                   | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    When Admin sets the business date to "20240301"
    When Admin runs inline COB job for Loan
    Then Admin checks that delinquency range is: "NO_DELINQUENCY" and has delinquentDate ""
    And Admin successfully approves the loan on "20240301" with "1000" amount and expected disbursement date on "20240301"
    Then Admin checks that delinquency range is: "NO_DELINQUENCY" and has delinquentDate ""

  @TestRailId:C3135
  Scenario: Verify that the delinquency is not applied on Loan with Rejected status
    When Admin sets the business date to "20240201"
    When Admin creates a client with random data
    When Admin set "LP2_DOWNPAYMENT_AUTO_ADVANCED_PAYMENT_ALLOCATION" loan product "DEFAULT" transaction type to "NEXT_INSTALLMENT" future installment allocation rule
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                       | submitted on date | with Principal | ANNUAL interest rate % | interest type | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_DOWNPAYMENT_AUTO_ADVANCED_PAYMENT_ALLOCATION | 20240201  | 1000           | 0                      | FLAT          | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 45                | DAYS                  | 15             | DAYS                   | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    When Admin sets the business date to "20240301"
    When Admin runs inline COB job for Loan
    Then Loan has the following LOAN level delinquency data:
      | classification | delinquentAmount | delinquentDate | delinquentDays | pastDueDays |
      | NO_DELINQUENCY | 0.0              | null           | 0              | 0           |
    And Admin successfully approves the loan on "20240301" with "1000" amount and expected disbursement date on "20240301"
    Then Loan has the following LOAN level delinquency data:
      | classification | delinquentAmount | delinquentDate | delinquentDays | pastDueDays |
      | NO_DELINQUENCY | 0.0              | null           | 0              | 0           |
    When Admin sets the business date to "20240325"
    And Admin can successfully undone the loan approval
    And Admin successfully rejects the loan on "20240325"
    Then Loan status will be "REJECTED"
    Then Loan has the following LOAN level delinquency data:
      | classification | delinquentAmount | delinquentDate | delinquentDays | pastDueDays |
      | NO_DELINQUENCY | 0.0              | null           | 0              | 0           |

  @TestRailId:C3136
  Scenario: Verify that the delinquency is not applied on Loan with Withdrawn status
    When Admin sets the business date to "20240201"
    When Admin creates a client with random data
    When Admin set "LP2_DOWNPAYMENT_AUTO_ADVANCED_PAYMENT_ALLOCATION" loan product "DEFAULT" transaction type to "NEXT_INSTALLMENT" future installment allocation rule
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                       | submitted on date | with Principal | ANNUAL interest rate % | interest type | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_DOWNPAYMENT_AUTO_ADVANCED_PAYMENT_ALLOCATION | 20240201  | 1000           | 0                      | FLAT          | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 45                | DAYS                  | 15             | DAYS                   | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    When Admin sets the business date to "20240301"
    When Admin runs inline COB job for Loan
    Then Loan has the following LOAN level delinquency data:
      | classification | delinquentAmount | delinquentDate | delinquentDays | pastDueDays |
      | NO_DELINQUENCY | 0.0              | null           | 0              | 0           |
    And Admin successfully approves the loan on "20240301" with "1000" amount and expected disbursement date on "20240301"
    Then Loan has the following LOAN level delinquency data:
      | classification | delinquentAmount | delinquentDate | delinquentDays | pastDueDays |
      | NO_DELINQUENCY | 0.0              | null           | 0              | 0           |
    When Admin sets the business date to "20240325"
    And Admin can successfully undone the loan approval
    And Admin successfully withdrawn the loan on "20240325"
    Then Loan status will be "WITHDRAWN"
    Then Loan has the following LOAN level delinquency data:
      | classification | delinquentAmount | delinquentDate | delinquentDays | pastDueDays |
      | NO_DELINQUENCY | 0.0              | null           | 0              | 0           |

  @TestRailId:C3137
  Scenario: Verify Installment level loan delinquency can be applied on loan account level in case of non-installment level delinquency loan product
    When Admin sets the business date to "20231001"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with installment level delinquency and with the following data:
      | LoanProduct                                                         | submitted on date | with Principal | ANNUAL interest rate % | interest type | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_DOWNPAYMENT_ADV_PMT_ALLOC_PROGRESSIVE_LOAN_SCHEDULE_HORIZONTAL | 20231001   | 1000           | 0                      | FLAT          | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 45                | DAYS                  | 15             | DAYS                   | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20231001" with "1000" amount and expected disbursement date on "20231001"
    When Admin successfully disburse the loan on "20231001" with "1000" EUR transaction amount
    When Admin sets the business date to "20231216"
    When Admin runs inline COB job for Loan
    Then Loan has the following INSTALLMENT level delinquency data:
      | Range    | Amount |
      | RANGE_30 | 500.00 |
      | RANGE_60 | 500.00 |
    Then Installment level delinquency event has correct data

  @TestRailId:C3930
  Scenario: Verify nextPaymentAmount value with repayment on first installment - progressive loan, no interest recalculation, zero interest rate - UC1
    When Admin sets the business date to "20240601"
    And Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                             | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_EMI_360_30 | 20240601       | 1000             | 0                    | DECLINING_BALANCE | DAILY                   | EQUAL_INSTALLMENTS | 4                 | MONTHS                | 1              | MONTHS                 | 4                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240601" with "1000" amount and expected disbursement date on "20240601"
    And Admin successfully disburse the loan on "20240601" with "1000" EUR transaction amount
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20240601      |           | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 30   | 20240701      |           | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0  | 0.0        | 0.0  | 250.0       |
      | 2  | 31   | 20240801    |           | 500.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0  | 0.0        | 0.0  | 250.0       |
      | 3  | 31   | 20240901 |           | 250.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0  | 0.0        | 0.0  | 250.0       |
      | 4  | 30   | 20241001   |           | 0.0             | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0  | 0.0        | 0.0  | 250.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 1000          | 0.0      | 0.0  | 0.0       | 1000.0 | 0.0  | 0.0        | 0.0  | 1000.0      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type        | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20240601     | Disbursement            | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
    Then Loan has the following LOAN level next payment due data:
      | classification | nextPaymentDueDate | nextPaymentAmount |
      | NO_DELINQUENCY | 20240701       | 250.0             |

    When Admin sets the business date to "20240615"
    When Admin runs inline COB job for Loan
    And Customer makes "AUTOPAY" repayment on "20240615" with 50 EUR transaction amount
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20240601      |           | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 30   | 20240701      |           | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 50.0 | 50.0       | 0.0  | 200.0       |
      | 2  | 31   | 20240801    |           | 500.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0  | 0.0        | 0.0  | 250.0       |
      | 3  | 31   | 20240901 |           | 250.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0  | 0.0        | 0.0  | 250.0       |
      | 4  | 30   | 20241001   |           | 0.0             | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0  | 0.0        | 0.0  | 250.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 1000          | 0.0      | 0.0  | 0.0       | 1000.0 | 50.0 | 50.0       | 0.0  | 950.0       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type        | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20240601     | Disbursement            | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
      | 20240615     | Repayment               | 50.0   | 50.0      | 0.0      | 0.0  | 0.0       | 950.0        |
    Then Loan has the following LOAN level next payment due data:
      | classification | nextPaymentDueDate | nextPaymentAmount |
      | NO_DELINQUENCY | 20240701       | 200.0             |

    When Admin sets the business date to "20240801"
    When Admin runs inline COB job for Loan
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20240601      |           | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 30   | 20240701      |           | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 50.0 | 50.0       | 0.0  | 200.0       |
      | 2  | 31   | 20240801    |           | 500.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0  | 0.0        | 0.0  | 250.0       |
      | 3  | 31   | 20240901 |           | 250.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0  | 0.0        | 0.0  | 250.0       |
      | 4  | 30   | 20241001   |           | 0.0             | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0  | 0.0        | 0.0  | 250.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 1000          | 0.0      | 0.0  | 0.0       | 1000.0 | 50.0 | 50.0       | 0.0  | 950.0       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type        | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20240601     | Disbursement            | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
      | 20240615     | Repayment               | 50.0   | 50.0      | 0.0      | 0.0  | 0.0       | 950.0        |
    Then Loan has the following LOAN level next payment due data:
      | classification | nextPaymentDueDate | nextPaymentAmount |
      | RANGE_3        | 20240701       | 200.0             |

    When Loan Pay-off is made on "20240801"
    Then Loan's all installments have obligations met

  @TestRailId:C3931
  Scenario: Verify nextPaymentAmount value with penalty on first installment - progressive loan, no interest recalculation, non-zero interest rate - UC2
    When Admin sets the business date to "20240601"
    And Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                              | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
       | LP2_ADV_PYMNT_INTEREST_DAILY_EMI_360_30 | 20240601       | 1000           | 12                     | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 4                 | MONTHS                | 1              | MONTHS                 | 4                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240601" with "1000" amount and expected disbursement date on "20240601"
    And Admin successfully disburse the loan on "20240601" with "1000" EUR transaction amount
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      |    |      | 20240601      |           | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      | 1  | 30   | 20240701      |           | 753.72          | 246.28        | 10.0     | 0.0  | 0.0       | 256.28 | 0.0  | 0.0        | 0.0  | 256.28      |
      | 2  | 31   | 20240801    |           | 504.98          | 248.74        | 7.54     | 0.0  | 0.0       | 256.28 | 0.0  | 0.0        | 0.0  | 256.28      |
      | 3  | 31   | 20240901 |           | 253.75          | 251.23        | 5.05     | 0.0  | 0.0       | 256.28 | 0.0  | 0.0        | 0.0  | 256.28      |
      | 4  | 30   | 20241001   |           | 0.0             | 253.75        | 2.54     | 0.0  | 0.0       | 256.29 | 0.0  | 0.0        | 0.0  | 256.29      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid | In advance | Late | Outstanding |
      | 1000          | 25.13    | 0.0  | 0.0       | 1025.13 | 0.0  | 0.0        | 0.0  | 1025.13     |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type        | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20240601     | Disbursement            | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
    Then Loan has the following LOAN level next payment due data:
      | classification | nextPaymentDueDate | nextPaymentAmount |
      | NO_DELINQUENCY | 20240701       | 256.28             |

    When Admin sets the business date to "20240620"
    When Admin runs inline COB job for Loan
    And Admin adds "LOAN_NSF_FEE" due date charge with "20240620" due date and 20 EUR transaction amount
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      |    |      | 20240601      |           | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      | 1  | 30   | 20240701      |           | 753.72          | 246.28        | 10.0     | 0.0  | 20.0      | 276.28 | 0.0  | 0.0        | 0.0  | 276.28      |
      | 2  | 31   | 20240801    |           | 504.98          | 248.74        | 7.54     | 0.0  | 0.0       | 256.28 | 0.0  | 0.0        | 0.0  | 256.28      |
      | 3  | 31   | 20240901 |           | 253.75          | 251.23        | 5.05     | 0.0  | 0.0       | 256.28 | 0.0  | 0.0        | 0.0  | 256.28      |
      | 4  | 30   | 20241001   |           | 0.0             | 253.75        | 2.54     | 0.0  | 0.0       | 256.29 | 0.0  | 0.0        | 0.0  | 256.29      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid | In advance | Late | Outstanding |
      | 1000          | 25.13    | 0.0  | 20.0      | 1045.13 | 0.0  | 0.0        | 0.0  | 1045.13     |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type        | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20240601     | Disbursement            | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
      | 20240619     | Accrual                 | 6.0    | 0.0       | 6.0      | 0.0  | 0.0       | 0.0          |
    Then Loan has the following LOAN level next payment due data:
      | classification | nextPaymentDueDate | nextPaymentAmount |
      | NO_DELINQUENCY | 20240701       | 276.28            |

    When Admin sets the business date to "20240801"
    When Admin runs inline COB job for Loan
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      |    |      | 20240601      |           | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      | 1  | 30   | 20240701      |           | 753.72          | 246.28        | 10.0     | 0.0  | 20.0      | 276.28 | 0.0  | 0.0        | 0.0  | 276.28      |
      | 2  | 31   | 20240801    |           | 504.98          | 248.74        | 7.54     | 0.0  | 0.0       | 256.28 | 0.0  | 0.0        | 0.0  | 256.28      |
      | 3  | 31   | 20240901 |           | 253.75          | 251.23        | 5.05     | 0.0  | 0.0       | 256.28 | 0.0  | 0.0        | 0.0  | 256.28      |
      | 4  | 30   | 20241001   |           | 0.0             | 253.75        | 2.54     | 0.0  | 0.0       | 256.29 | 0.0  | 0.0        | 0.0  | 256.29      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid | In advance | Late | Outstanding |
      | 1000          | 25.13    | 0.0  | 20.0      | 1045.13 | 0.0  | 0.0        | 0.0  | 1045.13     |
    Then Loan has the following LOAN level next payment due data:
      | classification | nextPaymentDueDate | nextPaymentAmount |
      | RANGE_3        | 20240701       | 276.28            |

    When Loan Pay-off is made on "20240801"
    Then Loan's all installments have obligations met

  @TestRailId:C3932
  Scenario: Verify nextPaymentAmount value with repayment at 2nd installment - progressive loan, no interest recalculation, the same as repayment period - UC3
    When Admin sets the business date to "20240601"
    And Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                   | submitted on date | with Principal | ANNUAL interest rate % | interest type | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_INTEREST_FLAT_ADV_PMT_ALLOC_MULTIDISBURSE | 20240601      | 1000           | 12                     | FLAT          | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 3                 | MONTHS                | 1              | MONTHS                 | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240601" with "1000" amount and expected disbursement date on "20240601"
    And Admin successfully disburse the loan on "20240601" with "1000" EUR transaction amount
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      |    |      | 20240601      |           | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      | 1  | 30   | 20240701      |           | 666.67          | 333.33        | 10.0     | 0.0  | 0.0       | 343.33 | 0.0  | 0.0        | 0.0  | 343.33      |
      | 2  | 31   | 20240801    |           | 333.34          | 333.33        | 10.0     | 0.0  | 0.0       | 343.33 | 0.0  | 0.0        | 0.0  | 343.33      |
      | 3  | 31   | 20240901 |           | 0.0             | 333.34        | 10.0     | 0.0  | 0.0       | 343.34 | 0.0  | 0.0        | 0.0  | 343.34      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 1000          | 30.0     | 0.0  | 0.0       | 1030.0 | 0.0  | 0.0        | 0.0  | 1030.0      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type        | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20240601     | Disbursement            | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
    Then Loan has the following LOAN level next payment due data:
      | classification | nextPaymentDueDate | nextPaymentAmount |
      | NO_DELINQUENCY | 20240701       | 343.33            |

    When Admin sets the business date to "20240715"
    When Admin runs inline COB job for Loan
    And Customer makes "AUTOPAY" repayment on "20240715" with 343.33 EUR transaction amount
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date    | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late   | Outstanding |
      |    |      | 20240601      |              | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0    |            |        |             |
      | 1  | 30   | 20240701      | 20240715 | 666.67          | 333.33        | 10.0     | 0.0  | 0.0       | 343.33 | 343.33 | 0.0        | 343.33 | 0.0         |
      | 2  | 31   | 20240801    |              | 333.34          | 333.33        | 10.0     | 0.0  | 0.0       | 343.33 | 0.0    | 0.0        | 0.0    | 343.33      |
      | 3  | 31   | 20240901 |              | 0.0             | 333.34        | 10.0     | 0.0  | 0.0       | 343.34 | 0.0    | 0.0        | 0.0    | 343.34      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late   | Outstanding |
      | 1000          | 30.0     | 0.0  | 0.0       | 1030.0 | 343.33 | 0.0        | 343.33 | 686.67      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type        | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20240601     | Disbursement            | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
      | 20240714     | Accrual                 | 14.19  | 0.0       | 14.19    | 0.0  | 0.0       | 0.0          |
      | 20240715     | Repayment               | 343.33 | 333.33    | 10.0     | 0.0  | 0.0       | 666.67       |
    Then Loan has the following LOAN level next payment due data:
      | classification | nextPaymentDueDate | nextPaymentAmount |
      | NO_DELINQUENCY | 20240801     | 343.33            |

    When Admin sets the business date to "20240801"
    When Admin runs inline COB job for Loan
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date    | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late   | Outstanding |
      |    |      | 20240601      |              | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0    |            |        |             |
      | 1  | 30   | 20240701      | 20240715 | 666.67          | 333.33        | 10.0     | 0.0  | 0.0       | 343.33 | 343.33 | 0.0        | 343.33 | 0.0         |
      | 2  | 31   | 20240801    |              | 333.34          | 333.33        | 10.0     | 0.0  | 0.0       | 343.33 | 0.0    | 0.0        | 0.0    | 343.33      |
      | 3  | 31   | 20240901 |              | 0.0             | 333.34        | 10.0     | 0.0  | 0.0       | 343.34 | 0.0    | 0.0        | 0.0    | 343.34      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late   | Outstanding |
      | 1000          | 30.0     | 0.0  | 0.0       | 1030.0 | 343.33 | 0.0        | 343.33 | 686.67      |
    Then Loan has the following LOAN level next payment due data:
      | classification | nextPaymentDueDate | nextPaymentAmount |
      | NO_DELINQUENCY | 20240801     | 343.33            |

    When Loan Pay-off is made on "20240801"
    Then Loan's all installments have obligations met

  @TestRailId:C3933
  Scenario: Verify nextPaymentAmount value - progressive loan, interest recalculation daily - UC4
    When Admin sets the business date to "20240601"
    And Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                        | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_EMI_360_30_INTEREST_RECALCULATION_DAILY_TILL_PRECLOSE | 20240601      | 1000           | 7                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 3                 | MONTHS                | 1              | MONTHS                 | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240601" with "1000" amount and expected disbursement date on "20240601"
    And Admin successfully disburse the loan on "20240601" with "1000" EUR transaction amount
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      |    |      | 20240601      |           | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      | 1  | 30   | 20240701      |           | 668.6           | 331.4         | 5.83     | 0.0  | 0.0       | 337.23 | 0.0  | 0.0        | 0.0  | 337.23      |
      | 2  | 31   | 20240801    |           | 335.27          | 333.33        | 3.9      | 0.0  | 0.0       | 337.23 | 0.0  | 0.0        | 0.0  | 337.23      |
      | 3  | 31   | 20240901 |           | 0.0             | 335.27        | 1.96     | 0.0  | 0.0       | 337.23 | 0.0  | 0.0        | 0.0  | 337.23      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid | In advance | Late | Outstanding |
      | 1000          | 11.69    | 0.0  | 0.0       | 1011.69 | 0.0  | 0.0        | 0.0  | 1011.69     |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type        | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20240601     | Disbursement            | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
    Then Loan has the following LOAN level next payment due data:
      | classification | nextPaymentDueDate | nextPaymentAmount |
      | NO_DELINQUENCY | 20240701       | 337.23            |

    When Admin sets the business date to "20240801"
    When Admin runs inline COB job for Loan
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      |    |      | 20240601      |           | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      | 1  | 30   | 20240701      |           | 668.6           | 331.4         | 5.83     | 0.0  | 0.0       | 337.23 | 0.0  | 0.0        | 0.0  | 337.23      |
      | 2  | 31   | 20240801    |           | 337.2           | 331.4         | 5.83     | 0.0  | 0.0       | 337.23 | 0.0  | 0.0        | 0.0  | 337.23      |
      | 3  | 31   | 20240901 |           | 0.0             | 337.2         | 1.97     | 0.0  | 0.0       | 339.17 | 0.0  | 0.0        | 0.0  | 339.17      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid | In advance | Late | Outstanding |
      | 1000          | 13.63    | 0.0  | 0.0       | 1013.63 | 0.0  | 0.0        | 0.0  | 1013.63     |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type        | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20240601     | Disbursement            | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
      | 20240731     | Accrual                 | 11.48  | 0.0       | 11.48    | 0.0  | 0.0       | 0.0          |
    Then Loan has the following LOAN level next payment due data:
      | classification | nextPaymentDueDate | nextPaymentAmount |
      | RANGE_3        | 20240701       | 337.23            |

    When Admin sets the business date to "20240805"
    When Admin runs inline COB job for Loan
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      |    |      | 20240601      |           | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      | 1  | 30   | 20240701      |           | 668.6           | 331.4         | 5.83     | 0.0  | 0.0       | 337.23 | 0.0  | 0.0        | 0.0  | 337.23      |
      | 2  | 31   | 20240801    |           | 337.2           | 331.4         | 5.83     | 0.0  | 0.0       | 337.23 | 0.0  | 0.0        | 0.0  | 337.23      |
      | 3  | 31   | 20240901 |           | 0.0             | 337.2         | 2.47     | 0.0  | 0.0       | 339.67 | 0.0  | 0.0        | 0.0  | 339.67      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid | In advance | Late | Outstanding |
      | 1000          | 14.13    | 0.0  | 0.0       | 1014.13 | 0.0  | 0.0        | 0.0  | 1014.13     |
    Then Loan has the following LOAN level next payment due data:
      | classification | nextPaymentDueDate | nextPaymentAmount |
      | RANGE_30       | 20240701       | 337.23            |

    When Loan Pay-off is made on "20240805"
    Then Loan's all installments have obligations met

  @TestRailId:C3934
  Scenario: Verify nextPaymentAmount value with chargeback - progressive loan, interest recalculation daily - UC5
    When Admin sets the business date to "20240601"
    And Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                        | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_EMI_360_30_INTEREST_RECALCULATION_DAILY_TILL_PRECLOSE | 20240601      | 1000           | 7                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 3                 | MONTHS                | 1              | MONTHS                 | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240601" with "1000" amount and expected disbursement date on "20240601"
    And Admin successfully disburse the loan on "20240601" with "1000" EUR transaction amount
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      |    |      | 20240601      |           | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      | 1  | 30   | 20240701      |           | 668.6           | 331.4         | 5.83     | 0.0  | 0.0       | 337.23 | 0.0  | 0.0        | 0.0  | 337.23      |
      | 2  | 31   | 20240801    |           | 335.27          | 333.33        | 3.9      | 0.0  | 0.0       | 337.23 | 0.0  | 0.0        | 0.0  | 337.23      |
      | 3  | 31   | 20240901 |           | 0.0             | 335.27        | 1.96     | 0.0  | 0.0       | 337.23 | 0.0  | 0.0        | 0.0  | 337.23      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid | In advance | Late | Outstanding |
      | 1000          | 11.69    | 0.0  | 0.0       | 1011.69 | 0.0  | 0.0        | 0.0  | 1011.69     |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type        | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20240601     | Disbursement            | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
    Then Loan has the following LOAN level next payment due data:
      | classification | nextPaymentDueDate | nextPaymentAmount |
      | NO_DELINQUENCY | 20240701       | 337.23            |

    When Admin sets the business date to "20240625"
    When Admin runs inline COB job for Loan
    And Customer makes "AUTOPAY" repayment on "20240625" with 55 EUR transaction amount
    And Admin makes "REPAYMENT_ADJUSTMENT_CHARGEBACK" chargeback with 12 EUR transaction amount for Payment nr. 1
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      |    |      | 20240601      |           | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      | 1  | 30   | 20240701      |           | 668.55          | 343.45        | 5.78     | 0.0  | 0.0       | 349.23 | 55.0 | 55.0       | 0.0  | 294.23      |
      | 2  | 31   | 20240801    |           | 335.22          | 333.33        | 3.9      | 0.0  | 0.0       | 337.23 | 0.0  | 0.0        | 0.0  | 337.23      |
      | 3  | 31   | 20240901 |           | 0.0             | 335.22        | 1.96     | 0.0  | 0.0       | 337.18 | 0.0  | 0.0        | 0.0  | 337.18      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid | In advance | Late | Outstanding |
      | 1012.0        | 11.64    | 0.0  | 0.0       | 1023.64 | 55.0 | 55.0       | 0.0  | 968.64      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type        | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20240601     | Disbursement            | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
      | 20240624     | Accrual                 | 4.47   | 0.0       | 4.47     | 0.0  | 0.0       | 0.0          |
      | 20240625     | Repayment               | 55.0   | 55.0      | 0.0      | 0.0  | 0.0       | 945.0        |
      | 20240625     | Chargeback              | 12.0   | 12.0      | 0.0      | 0.0  | 0.0       | 957.0        |
    Then Loan has the following LOAN level next payment due data:
      | classification | nextPaymentDueDate | nextPaymentAmount |
      | NO_DELINQUENCY | 20240701       | 294.23            |

    When Admin sets the business date to "20240801"
    When Admin runs inline COB job for Loan
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      |    |      | 20240601      |           | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      | 1  | 30   | 20240701      |           | 668.55          | 343.45        | 5.78     | 0.0  | 0.0       | 349.23 | 55.0 | 55.0       | 0.0  | 294.23      |
      | 2  | 31   | 20240801    |           | 336.9           | 331.65        | 5.58     | 0.0  | 0.0       | 337.23 | 0.0  | 0.0        | 0.0  | 337.23      |
      | 3  | 31   | 20240901 |           | 0.0             | 336.9         | 1.97     | 0.0  | 0.0       | 338.87 | 0.0  | 0.0        | 0.0  | 338.87      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid | In advance | Late | Outstanding |
      | 1012.0        | 13.33    | 0.0  | 0.0       | 1025.33 | 55.0 | 55.0       | 0.0  | 970.33     |
    Then Loan has the following LOAN level next payment due data:
      | classification | nextPaymentDueDate | nextPaymentAmount |
      | RANGE_3        | 20240701       | 294.23            |

    When Admin sets the business date to "20240805"
    When Admin runs inline COB job for Loan
    Then Loan has the following LOAN level next payment due data:
      | classification | nextPaymentDueDate | nextPaymentAmount |
      | RANGE_30       | 20240701       | 294.23            |

    When Loan Pay-off is made on "20240805"
    Then Loan's all installments have obligations met

  @TestRailId:C3935
  Scenario: Verify nextPaymentAmount value with full repayment on first installment - progressive loan, interest recalculation daily - UC6
    When Admin sets the business date to "20240601"
    And Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                        | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_EMI_360_30_INTEREST_RECALCULATION_DAILY_TILL_PRECLOSE | 20240601      | 1000           | 7                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 3                 | MONTHS                | 1              | MONTHS                 | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240601" with "1000" amount and expected disbursement date on "20240601"
    And Admin successfully disburse the loan on "20240601" with "1000" EUR transaction amount
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      |    |      | 20240601      |           | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      | 1  | 30   | 20240701      |           | 668.6           | 331.4         | 5.83     | 0.0  | 0.0       | 337.23 | 0.0  | 0.0        | 0.0  | 337.23      |
      | 2  | 31   | 20240801    |           | 335.27          | 333.33        | 3.9      | 0.0  | 0.0       | 337.23 | 0.0  | 0.0        | 0.0  | 337.23      |
      | 3  | 31   | 20240901 |           | 0.0             | 335.27        | 1.96     | 0.0  | 0.0       | 337.23 | 0.0  | 0.0        | 0.0  | 337.23      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid | In advance | Late | Outstanding |
      | 1000          | 11.69    | 0.0  | 0.0       | 1011.69 | 0.0  | 0.0        | 0.0  | 1011.69     |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type        | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20240601     | Disbursement            | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
    Then Loan has the following LOAN level next payment due data:
      | classification | nextPaymentDueDate | nextPaymentAmount |
      | NO_DELINQUENCY | 20240701       | 337.23            |

    When Admin sets the business date to "20240625"
    When Admin runs inline COB job for Loan
    And Customer makes "AUTOPAY" repayment on "20240625" with 337.23 EUR transaction amount
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date    | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late | Outstanding |
      |    |      | 20240601      |              | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0    |            |      |             |
      | 1  | 30   | 20240701      | 20240625 | 667.44          | 332.56        | 4.67     | 0.0  | 0.0       | 337.23 | 337.23 | 337.23     | 0.0  | 0.0         |
      | 2  | 31   | 20240801    |              | 334.88          | 332.56        | 4.67     | 0.0  | 0.0       | 337.23 | 0.0    | 0.0        | 0.0  | 337.23      |
      | 3  | 31   | 20240901 |              | 0.0             | 334.88        | 1.95     | 0.0  | 0.0       | 336.83 | 0.0    | 0.0        | 0.0  | 336.83      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid   | In advance | Late | Outstanding |
      | 1000          | 11.29    | 0.0  | 0.0       | 1011.29 | 337.23 | 337.23     | 0.0  | 674.06      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type        | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20240601     | Disbursement            | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
      | 20240624     | Accrual                 | 4.47   | 0.0       | 4.47     | 0.0  | 0.0       | 0.0          |
      | 20240625     | Repayment               | 337.23 | 332.56    | 4.67     | 0.0  | 0.0       | 667.44       |
    Then Loan has the following LOAN level next payment due data:
      | classification | nextPaymentDueDate | nextPaymentAmount |
      | NO_DELINQUENCY | 20240801       | 337.23            |

    When Admin sets the business date to "20240701"
    When Admin runs inline COB job for Loan
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date    | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late | Outstanding |
      |    |      | 20240601      |              | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0    |            |      |             |
      | 1  | 30   | 20240701      | 20240625 | 667.44          | 332.56        | 4.67     | 0.0  | 0.0       | 337.23 | 337.23 | 337.23     | 0.0  | 0.0         |
      | 2  | 31   | 20240801    |              | 334.88          | 332.56        | 4.67     | 0.0  | 0.0       | 337.23 | 0.0    | 0.0        | 0.0  | 337.23      |
      | 3  | 31   | 20240901 |              | 0.0             | 334.88        | 1.95     | 0.0  | 0.0       | 336.83 | 0.0    | 0.0        | 0.0  | 336.83      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid   | In advance | Late | Outstanding |
      | 1000          | 11.29    | 0.0  | 0.0       | 1011.29 | 337.23 | 337.23     | 0.0  | 674.06      |
    Then Loan has the following LOAN level next payment due data:
      | classification | nextPaymentDueDate | nextPaymentAmount |
      | NO_DELINQUENCY | 20240801     | 337.23            |

    When Admin sets the business date to "20240703"
    When Admin runs inline COB job for Loan
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date    | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late | Outstanding |
      |    |      | 20240601      |              | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0    |            |      |             |
      | 1  | 30   | 20240701      | 20240625 | 667.44          | 332.56        | 4.67     | 0.0  | 0.0       | 337.23 | 337.23 | 337.23     | 0.0  | 0.0         |
      | 2  | 31   | 20240801    |              | 334.88          | 332.56        | 4.67     | 0.0  | 0.0       | 337.23 | 0.0    | 0.0        | 0.0  | 337.23      |
      | 3  | 31   | 20240901 |              | 0.0             | 334.88        | 1.95     | 0.0  | 0.0       | 336.83 | 0.0    | 0.0        | 0.0  | 336.83      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid   | In advance | Late | Outstanding |
      | 1000          | 11.29    | 0.0  | 0.0       | 1011.29 | 337.23 | 337.23     | 0.0  | 674.06      |
    Then Loan has the following LOAN level next payment due data:
      | classification | nextPaymentDueDate | nextPaymentAmount |
      | NO_DELINQUENCY | 20240801     | 337.23            |

    When Loan Pay-off is made on "20240701"
    Then Loan's all installments have obligations met

