@LoanFeature
Feature: Loan - Part2

  @TestRailId:C2540
  Scenario: Verify that loan overdue calculation is updated upon Payout refund transaction
    When Admin sets the business date to "20230101"
    When Admin creates a client with random data
    When Admin creates a new default Loan with date: "20230101"
    And Admin successfully approves the loan on "20230101" with "1000" amount and expected disbursement date on "20230101"
    When Admin successfully disburse the loan on "20230101" with "1000" EUR transaction amount
    When Admin sets the business date to "20230301"
    When Admin runs inline COB job for Loan
    Then Admin checks that delinquency range is: "RANGE_3" and has delinquentDate "2023-02-03"
    Then Loan status will be "ACTIVE"
    Then Loan has 1000 outstanding amount
    When Customer makes "PAYOUT_REFUND" transaction with "AUTOPAY" payment type on "20230301" with 1000 EUR transaction amount and system-generated Idempotency key
    Then Admin checks that delinquency range is: "NO_DELINQUENCY" and has delinquentDate ""
    Then Loan status will be "CLOSED_OBLIGATIONS_MET"
    Then Loan has 0 outstanding amount

  @TestRailId:C2541
  Scenario: Verify that loan overdue calculation is updated upon Merchant issued refund transaction
    When Admin sets the business date to "20230101"
    When Admin creates a client with random data
    When Admin creates a new default Loan with date: "20230101"
    And Admin successfully approves the loan on "20230101" with "1000" amount and expected disbursement date on "20230101"
    When Admin successfully disburse the loan on "20230101" with "1000" EUR transaction amount
    When Admin sets the business date to "20230301"
    When Admin runs inline COB job for Loan
    Then Admin checks that delinquency range is: "RANGE_3" and has delinquentDate "2023-02-03"
    Then Loan status will be "ACTIVE"
    Then Loan has 1000 outstanding amount
    When Customer makes "MERCHANT_ISSUED_REFUND" transaction with "AUTOPAY" payment type on "20230301" with 1000 EUR transaction amount and system-generated Idempotency key
    Then Admin checks that delinquency range is: "NO_DELINQUENCY" and has delinquentDate ""
    Then Loan status will be "CLOSED_OBLIGATIONS_MET"
    Then Loan has 0 outstanding amount

  @TestRailId:C2552
  Scenario: Verify that delinquency event contains the correct delinquentDate in case of one repayment is overdue
    When Admin sets the business date to "20230101"
    When Admin creates a client with random data
    When Admin creates a new default Loan with date: "20230101"
    And Admin successfully approves the loan on "20230101" with "1000" amount and expected disbursement date on "20230101"
    When Admin successfully disburse the loan on "20230101" with "1000" EUR transaction amount
    When Admin sets the business date to "20230305"
    When Admin runs inline COB job for Loan
    Then Admin checks that delinquency range is: "RANGE_3" and has delinquentDate "2023-02-03"

  @TestRailId:C2553
  Scenario: Verify that delinquency event contains the correct delinquentDate in case of multiple repayments are overdue
    When Admin sets the business date to "20230101"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy                        |
      | LP1         | 20230101    | 1000           | 0                      | DECLINING_BALANCE | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 3                 | MONTHS                | 1              | MONTHS                 | 3                  | 0                       | 0                      | 0                    | PENALTIES_FEES_INTEREST_PRINCIPAL_ORDER |
    And Admin successfully approves the loan on "20230101" with "1000" amount and expected disbursement date on "20230101"
    When Admin successfully disburse the loan on "20230101" with "1000" EUR transaction amount
    When Admin sets the business date to "20230405"
    When Admin runs inline COB job for Loan
    Then Admin checks that delinquency range is: "RANGE_30" and has delinquentDate "2023-02-04"

  @TestRailId:C2583
  Scenario: Verify last payment related fields when retrieving loan details with 1 repayment
    When Admin sets the business date to "20230101"
    When Admin creates a client with random data
    When Admin creates a new default Loan with date: "20230101"
    And Admin successfully approves the loan on "20230101" with "1000" amount and expected disbursement date on "20230101"
    When Admin successfully disburse the loan on "20230101" with "1000" EUR transaction amount
    When Admin sets the business date to "20230103"
    And Customer makes "AUTOPAY" repayment on "20230103" with 200 EUR transaction amount
    Then Loan details has the following last payment related data:
      | lastPaymentAmount | lastPaymentDate | lastRepaymentAmount | lastRepaymentDate |
      | 200.0             | 20230103 | 200.0               | 20230103   |

  @TestRailId:C2586
  Scenario: Verify last payment related fields when retrieving loan details with 2 repayments on different day
    When Admin sets the business date to "20230101"
    When Admin creates a client with random data
    When Admin creates a new default Loan with date: "20230101"
    And Admin successfully approves the loan on "20230101" with "1000" amount and expected disbursement date on "20230101"
    When Admin successfully disburse the loan on "20230101" with "1000" EUR transaction amount
    When Admin sets the business date to "20230103"
    And Customer makes "AUTOPAY" repayment on "20230103" with 200 EUR transaction amount
    When Admin sets the business date to "20230105"
    And Customer makes "AUTOPAY" repayment on "20230105" with 300 EUR transaction amount
    Then Loan details has the following last payment related data:
      | lastPaymentAmount | lastPaymentDate | lastRepaymentAmount | lastRepaymentDate |
      | 300.0             | 20230105 | 300.0               | 20230105   |

  @TestRailId:C2587
  Scenario: Verify last payment related fields when retrieving loan details with 2 repayments on the same day
    When Admin sets the business date to "20230101"
    When Admin creates a client with random data
    When Admin creates a new default Loan with date: "20230101"
    And Admin successfully approves the loan on "20230101" with "1000" amount and expected disbursement date on "20230101"
    When Admin successfully disburse the loan on "20230101" with "1000" EUR transaction amount
    When Admin sets the business date to "20230103"
    And Customer makes "AUTOPAY" repayment on "20230103" with 200 EUR transaction amount
    And Customer makes "AUTOPAY" repayment on "20230103" with 300 EUR transaction amount
    Then Loan details has the following last payment related data:
      | lastPaymentAmount | lastPaymentDate | lastRepaymentAmount | lastRepaymentDate |
      | 300.0             | 20230103 | 300.0               | 20230103   |

  @TestRailId:C2588
  Scenario: Verify last payment related fields when retrieving loan details with 2 repayments on different day then the second repayment reversed
    When Admin sets the business date to "20230101"
    When Admin creates a client with random data
    When Admin creates a new default Loan with date: "20230101"
    And Admin successfully approves the loan on "20230101" with "1000" amount and expected disbursement date on "20230101"
    When Admin successfully disburse the loan on "20230101" with "1000" EUR transaction amount
    When Admin sets the business date to "20230103"
    And Customer makes "AUTOPAY" repayment on "20230103" with 200 EUR transaction amount
    When Admin sets the business date to "20230105"
    And Customer makes "AUTOPAY" repayment on "20230105" with 300 EUR transaction amount
    Then Loan details has the following last payment related data:
      | lastPaymentAmount | lastPaymentDate | lastRepaymentAmount | lastRepaymentDate |
      | 300.0             | 20230105 | 300.0               | 20230105   |
    When Customer undo "1"th transaction made on "20230105"
    Then Loan details has the following last payment related data:
      | lastPaymentAmount | lastPaymentDate | lastRepaymentAmount | lastRepaymentDate |
      | 200.0             | 20230103 | 200.0               | 20230103   |

  @TestRailId:C2589
  Scenario: Verify last payment related fields when retrieving loan details with 1 repayment and 1 goodwill credit transaction
    When Admin sets the business date to "20230101"
    When Admin creates a client with random data
    When Admin creates a new default Loan with date: "20230101"
    And Admin successfully approves the loan on "20230101" with "1000" amount and expected disbursement date on "20230101"
    When Admin successfully disburse the loan on "20230101" with "1000" EUR transaction amount
    When Admin sets the business date to "20230103"
    And Customer makes "AUTOPAY" repayment on "20230103" with 200 EUR transaction amount
    When Admin sets the business date to "20230105"
    When Customer makes "GOODWILL_CREDIT" transaction with "AUTOPAY" payment type on "20230105" with 400 EUR transaction amount and system-generated Idempotency key
    Then Loan details has the following last payment related data:
      | lastPaymentAmount | lastPaymentDate | lastRepaymentAmount | lastRepaymentDate |
      | 400.0             | 20230105 | 200.0               | 20230103   |

  @TestRailId:C2590
  Scenario: Verify last payment related fields when retrieving loan details with 1 repayment, 1 goodwill credit transaction and 1 more repayment then the second repayment reversed
    When Admin sets the business date to "20230101"
    When Admin creates a client with random data
    When Admin creates a new default Loan with date: "20230101"
    And Admin successfully approves the loan on "20230101" with "1000" amount and expected disbursement date on "20230101"
    When Admin successfully disburse the loan on "20230101" with "1000" EUR transaction amount
    When Admin sets the business date to "20230103"
    And Customer makes "AUTOPAY" repayment on "20230103" with 200 EUR transaction amount
    When Admin sets the business date to "20230105"
    When Customer makes "GOODWILL_CREDIT" transaction with "AUTOPAY" payment type on "20230105" with 400 EUR transaction amount and system-generated Idempotency key
    When Admin sets the business date to "20230107"
    And Customer makes "AUTOPAY" repayment on "20230107" with 300 EUR transaction amount
    Then Loan details has the following last payment related data:
      | lastPaymentAmount | lastPaymentDate | lastRepaymentAmount | lastRepaymentDate |
      | 300.0             | 20230107 | 300.0               | 20230107   |
    When Customer undo "1"th transaction made on "20230107"
    Then Loan details has the following last payment related data:
      | lastPaymentAmount | lastPaymentDate | lastRepaymentAmount | lastRepaymentDate |
      | 400.0             | 20230105 | 200.0               | 20230103   |

  @TestRailId:C2678
  Scenario: Verify that after loan is closed loan details and event has last repayment date and amount
    When Admin sets the business date to "20230101"
    When Admin creates a client with random data
    When Admin creates a new default Loan with date: "20230101"
    And Admin successfully approves the loan on "20230101" with "1000" amount and expected disbursement date on "20230101"
    Then Loan status has changed to "Approved"
    When Admin successfully disburse the loan on "20230101" with "1000" EUR transaction amount
    Then Loan status has changed to "Active"
    When Admin sets the business date to "20230102"
    And Customer makes "AUTOPAY" repayment on "20230102" with 1000 EUR transaction amount
    Then Loan status will be "CLOSED_OBLIGATIONS_MET"
    Then Loan details and event has the following last repayment related data:
      | lastPaymentAmount | lastPaymentDate | lastRepaymentAmount | lastRepaymentDate |
      | 1000.0            | 20230102 | 1000.0              | 20230102   |

  @TestRailId:C2679
  Scenario: Verify that after loan is overpaid loan details and event has last repayment date and amount
    When Admin sets the business date to "20230101"
    When Admin creates a client with random data
    When Admin creates a new default Loan with date: "20230101"
    And Admin successfully approves the loan on "20230101" with "1000" amount and expected disbursement date on "20230101"
    Then Loan status has changed to "Approved"
    When Admin successfully disburse the loan on "20230101" with "1000" EUR transaction amount
    Then Loan status has changed to "Active"
    When Admin sets the business date to "20230102"
    And Customer makes "AUTOPAY" repayment on "20230102" with 1100 EUR transaction amount
    Then Loan status will be "OVERPAID"
    Then Loan details and event has the following last repayment related data:
      | lastPaymentAmount | lastPaymentDate | lastRepaymentAmount | lastRepaymentDate |
      | 1100.0            | 20230102 | 1100.0              | 20230102   |

  @TestRailId:C2687 @fraud
  Scenario: Verify that closed loan can be marked as Fraud
    When Admin sets the business date to "20230101"
    When Admin creates a client with random data
    When Admin creates a new default Loan with date: "20230101"
    And Admin successfully approves the loan on "20230101" with "1000" amount and expected disbursement date on "20230101"
    When Admin successfully disburse the loan on "20230101" with "1000" EUR transaction amount
    When Admin sets the business date to "20230115"
    And Customer makes "AUTOPAY" repayment on "20230115" with 1000 EUR transaction amount
    Then Loan status will be "CLOSED_OBLIGATIONS_MET"
    Then Admin can successfully set Fraud flag to the loan

  @TestRailId:C2688 @fraud
  Scenario: Verify that overpaid loan can be marked as Fraud
    When Admin sets the business date to "20230101"
    When Admin creates a client with random data
    When Admin creates a new default Loan with date: "20230101"
    And Admin successfully approves the loan on "20230101" with "1000" amount and expected disbursement date on "20230101"
    When Admin successfully disburse the loan on "20230101" with "1000" EUR transaction amount
    When Admin sets the business date to "20230115"
    And Customer makes "AUTOPAY" repayment on "20230115" with 1100 EUR transaction amount
    Then Loan status will be "OVERPAID"
    Then Admin can successfully set Fraud flag to the loan

  @TestRailId:C2690
  Scenario: Verify that the repayment schedule is correct when the loan has a fee and multi disbursement happens
    When Admin sets the business date to "20230501"
    When Admin creates a client with random data
    And Admin successfully creates a new customised Loan submitted on date: "20230501", with Principal: "1000", a loanTermFrequency: 1 months, and numberOfRepayments: 1
    And Admin successfully approves the loan on "20230501" with "1000" amount and expected disbursement date on "20230501"
    And Admin successfully disburse the loan on "20230501" with "750" EUR transaction amount
    Then Loan has 750 outstanding amount
    When Admin adds "LOAN_SNOOZE_FEE" due date charge with "20230501" due date and 8 EUR transaction amount
    Then Loan Repayment schedule has 1 periods, with the following data for periods:
      | Nr | Days | Date         | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20230501  |           | 750.0           |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 31   | 20230601 |           | 0.0             | 750.0         | 0.0      | 8.0  | 0.0       | 758.0 | 0.0  | 0.0        | 0.0  | 758.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due | Paid | In advance | Late | Outstanding |
      | 750           | 0        | 8    | 0         | 758 | 0    | 0          | 0    | 758         |
    And Admin successfully disburse the loan on "20230501" with "750" EUR transaction amount
    Then Loan Repayment schedule has 1 periods, with the following data for periods:
      | Nr | Days | Date         | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      |    |      | 20230501  |           | 750.0           |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      |    |      | 20230501  |           | 750.0           |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      | 1  | 31   | 20230601 |           | 0.0             | 1500.0        | 0.0      | 8.0  | 0.0       | 1508.0 | 0.0  | 0.0        | 0.0  | 1508.0      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due  | Paid | In advance | Late | Outstanding |
      | 1500          | 0        | 8    | 0         | 1508 | 0    | 0          | 0    | 1508        |

  @TestRailId:C2691
  Scenario: As an admin I would like to do a chargeback for Goodwill Credit
    When Admin sets the business date to "20230508"
    And Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy                        |
      | LP1         | 20230508        | 1000           | 0                      | DECLINING_BALANCE | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 3                 | MONTHS                | 1              | MONTHS                 | 3                  | 0                       | 0                      | 0                    | PENALTIES_FEES_INTEREST_PRINCIPAL_ORDER |
    And Admin successfully approves the loan on "20230508" with "1000" amount and expected disbursement date on "20230508"
    And Admin successfully disburse the loan on "20230508" with "1000" EUR transaction amount
    When Admin sets the business date to "20230509"
    When Customer makes "GOODWILL_CREDIT" transaction with "AUTOPAY" payment type on "20230509" with 300 EUR transaction amount and system-generated Idempotency key
    When Admin sets the business date to "20230510"
    And Admin makes "REPAYMENT_ADJUSTMENT_CHARGEBACK" chargeback with 300 EUR transaction amount
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date           | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20230508    |           | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 31   | 20230608   |           | 667.0           | 633.0         | 0.0      | 0.0  | 0.0       | 633.0 | 300.0 | 300.0      | 0.0  | 333.0       |
      | 2  | 30   | 20230708   |           | 334.0           | 333.0         | 0.0      | 0.0  | 0.0       | 333.0 | 0.0   | 0.0        | 0.0  | 333.0       |
      | 3  | 31   | 20230808 |           | 0.0             | 334.0         | 0.0      | 0.0  | 0.0       | 334.0 | 0.0   | 0.0        | 0.0  | 334.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due  | Paid | In advance | Late | Outstanding |
      | 1300          | 0        | 0    | 0         | 1300 | 300  | 300        | 0    | 1000        |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20230508      | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
      | 20230509      | Goodwill Credit  | 300.0  | 300.0     | 0.0      | 0.0  | 0.0       | 700.0        |
      | 20230510      | Chargeback       | 300.0  | 300.0     | 0.0      | 0.0  | 0.0       | 1000.0       |

  @TestRailId:C2692
  Scenario: As an admin I would like to do a chargeback for Payout Refund
    When Admin sets the business date to "20230508"
    And Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy                        |
      | LP1         | 20230508        | 1000           | 0                      | DECLINING_BALANCE | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 3                 | MONTHS                | 1              | MONTHS                 | 3                  | 0                       | 0                      | 0                    | PENALTIES_FEES_INTEREST_PRINCIPAL_ORDER |
    And Admin successfully approves the loan on "20230508" with "1000" amount and expected disbursement date on "20230508"
    And Admin successfully disburse the loan on "20230508" with "1000" EUR transaction amount
    When Admin sets the business date to "20230509"
    When Customer makes "PAYOUT_REFUND" transaction with "AUTOPAY" payment type on "20230509" with 300 EUR transaction amount and system-generated Idempotency key
    When Admin sets the business date to "20230510"
    And Admin makes "REPAYMENT_ADJUSTMENT_CHARGEBACK" chargeback with 300 EUR transaction amount
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date           | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20230508    |           | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 31   | 20230608   |           | 667.0           | 633.0         | 0.0      | 0.0  | 0.0       | 633.0 | 300.0 | 300.0      | 0.0  | 333.0       |
      | 2  | 30   | 20230708   |           | 334.0           | 333.0         | 0.0      | 0.0  | 0.0       | 333.0 | 0.0   | 0.0        | 0.0  | 333.0       |
      | 3  | 31   | 20230808 |           | 0.0             | 334.0         | 0.0      | 0.0  | 0.0       | 334.0 | 0.0   | 0.0        | 0.0  | 334.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due  | Paid | In advance | Late | Outstanding |
      | 1300          | 0        | 0    | 0         | 1300 | 300  | 300        | 0    | 1000        |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20230508      | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
      | 20230509      | Payout Refund    | 300.0  | 300.0     | 0.0      | 0.0  | 0.0       | 700.0        |
      | 20230510      | Chargeback       | 300.0  | 300.0     | 0.0      | 0.0  | 0.0       | 1000.0       |

  @TestRailId:C2693
  Scenario: As an admin I would like to do a chargeback for Merchant Issued Refund
    When Admin sets the business date to "20230508"
    And Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy                        |
      | LP1         | 20230508        | 1000           | 0                      | DECLINING_BALANCE | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 3                 | MONTHS                | 1              | MONTHS                 | 3                  | 0                       | 0                      | 0                    | PENALTIES_FEES_INTEREST_PRINCIPAL_ORDER |
    And Admin successfully approves the loan on "20230508" with "1000" amount and expected disbursement date on "20230508"
    And Admin successfully disburse the loan on "20230508" with "1000" EUR transaction amount
    When Admin sets the business date to "20230509"
    When Customer makes "MERCHANT_ISSUED_REFUND" transaction with "AUTOPAY" payment type on "20230509" with 300 EUR transaction amount and system-generated Idempotency key
    When Admin sets the business date to "20230510"
    And Admin makes "REPAYMENT_ADJUSTMENT_CHARGEBACK" chargeback with 300 EUR transaction amount
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date           | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20230508    |           | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 31   | 20230608   |           | 667.0           | 633.0         | 0.0      | 0.0  | 0.0       | 633.0 | 300.0 | 300.0      | 0.0  | 333.0       |
      | 2  | 30   | 20230708   |           | 334.0           | 333.0         | 0.0      | 0.0  | 0.0       | 333.0 | 0.0   | 0.0        | 0.0  | 333.0       |
      | 3  | 31   | 20230808 |           | 0.0             | 334.0         | 0.0      | 0.0  | 0.0       | 334.0 | 0.0   | 0.0        | 0.0  | 334.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due  | Paid | In advance | Late | Outstanding |
      | 1300          | 0        | 0    | 0         | 1300 | 300  | 300        | 0    | 1000        |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type       | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20230508      | Disbursement           | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
      | 20230509      | Merchant Issued Refund | 300.0  | 300.0     | 0.0      | 0.0  | 0.0       | 700.0        |
      | 20230510      | Chargeback             | 300.0  | 300.0     | 0.0      | 0.0  | 0.0       | 1000.0       |

  @TestRailId:C2770
  Scenario: As an admin I would like to do two merchant issued refund and charge adjustment to close the loan
    When Global config "charge-accrual-date" value set to "submitted-date"
    When Admin sets the business date to "20230514"
    And Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy                                                             |
      | LP1         | 20230514       | 1000           | 0                      | DECLINING_BALANCE | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 30                | DAYS                  | 30             | DAYS                   | 1                  | 0                       | 0                      | 0                    | DUE_PENALTY_FEE_INTEREST_PRINCIPAL_IN_ADVANCE_PRINCIPAL_PENALTY_FEE_INTEREST |
    And Admin successfully approves the loan on "20230514" with "127.95" amount and expected disbursement date on "20230514"
    And Admin successfully disburse the loan on "20230514" with "127.95" EUR transaction amount
    When Admin sets the business date to "20230611"
    When Batch API call with steps: rescheduleLoan from "20230613" to "20230713" submitted on date: "20230611", approveReschedule on date: "20230611" runs with enclosingTransaction: "true"
    When Admin adds "LOAN_SNOOZE_FEE" due date charge with "20230713" due date and 3.65 EUR transaction amount
    When Admin sets the business date to "20230612"
    When Admin runs inline COB job for Loan
    Then Loan Repayment schedule has 1 periods, with the following data for periods:
      | Nr | Days | Date         | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20230514  |           | 127.95          |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 60   | 20230713 |           | 0.0             | 127.95        | 0.0      | 3.65 | 0.0       | 131.6 | 0.0  | 0.0        | 0.0  | 131.6       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 127.95        | 0        | 3.65 | 0         | 131.60 | 0    | 0          | 0    | 131.60      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20230514      | Disbursement     | 127.95 | 0.0       | 0.0      | 0.0  | 0.0       | 127.95       |
      | 20230611     | Accrual          | 3.65   | 0.0       | 0.0      | 3.65 | 0.0       | 0.0          |
    When Admin sets the business date to "20230617"
    When Customer makes "MERCHANT_ISSUED_REFUND" transaction with "AUTOPAY" payment type on "20230617" with 125 EUR transaction amount and system-generated Idempotency key
    Then Loan Repayment schedule has 1 periods, with the following data for periods:
      | Nr | Days | Date         | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20230514  |           | 127.95          |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 60   | 20230713 |           | 0.0             | 127.95        | 0.0      | 3.65 | 0.0       | 131.6 | 125.0 | 125.0      | 0.0  | 6.6         |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      | 127.95        | 0        | 3.65 | 0         | 131.6 | 125.0 | 125.0      | 0    | 6.60        |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type       | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20230514      | Disbursement           | 127.95 | 0.0       | 0.0      | 0.0  | 0.0       | 127.95       |
      | 20230611     | Accrual                | 3.65   | 0.0       | 0.0      | 3.65 | 0.0       | 0.0          |
      | 20230617     | Merchant Issued Refund | 125.0  | 125.0     | 0.0      | 0.0  | 0.0       | 2.95         |
    When Admin makes a charge adjustment for the last "LOAN_SNOOZE_FEE" type charge which is due on "20230713" with 3.65 EUR transaction amount and externalId ""
    Then Loan Repayment schedule has 1 periods, with the following data for periods:
      | Nr | Days | Date         | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid   | In advance | Late | Outstanding |
      |    |      | 20230514  |           | 127.95          |               |          | 0.0  |           | 0.0   | 0.0    |            |      |             |
      | 1  | 60   | 20230713 |           | 0.0             | 127.95        | 0.0      | 3.65 | 0.0       | 131.6 | 128.65 | 128.65     | 0.0  | 2.95        |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due   | Paid   | In advance | Late | Outstanding |
      | 127.95        | 0        | 3.65 | 0         | 131.6 | 128.65 | 128.65     | 0    | 2.95        |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type       | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20230514      | Disbursement           | 127.95 | 0.0       | 0.0      | 0.0  | 0.0       | 127.95       |
      | 20230611     | Accrual                | 3.65   | 0.0       | 0.0      | 3.65 | 0.0       | 0.0          |
      | 20230617     | Merchant Issued Refund | 125.0  | 125.0     | 0.0      | 0.0  | 0.0       | 2.95         |
      | 20230617     | Charge Adjustment      | 3.65   | 2.95      | 0.0      | 0.7  | 0.0       | 0.0          |
    When Customer makes "MERCHANT_ISSUED_REFUND" transaction with "AUTOPAY" payment type on "20230617" with 2.95 EUR transaction amount and system-generated Idempotency key
    Then Loan Repayment schedule has 1 periods, with the following data for periods:
      | Nr | Days | Date         | Paid date    | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20230514  |              | 127.95          |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 60   | 20230713 | 20230617 | 0.0             | 127.95        | 0.0      | 3.65 | 0.0       | 131.6 | 131.6 | 131.6      | 0.0  | 0.0         |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      | 127.95        | 0        | 3.65 | 0         | 131.6 | 131.6 | 131.6      | 0    | 0           |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type       | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20230514      | Disbursement           | 127.95 | 0.0       | 0.0      | 0.0  | 0.0       | 127.95       |
      | 20230611     | Accrual                | 3.65   | 0.0       | 0.0      | 3.65 | 0.0       | 0.0          |
      | 20230617     | Merchant Issued Refund | 125.0  | 125.0     | 0.0      | 0.0  | 0.0       | 2.95         |
      | 20230617     | Charge Adjustment      | 3.65   | 2.95      | 0.0      | 0.7  | 0.0       | 0.0          |
      | 20230617     | Merchant Issued Refund | 2.95   | 0.0       | 0.0      | 2.95 | 0.0       | 0.0          |
    When Global config "charge-accrual-date" value set to "due-date"

  @TestRailId:C2776
  Scenario: Verify that maturity date is updated on repayment reversal
    When Admin sets the business date to "20230601"
    When Admin creates a client with random data
    When Admin creates a new default Loan with date: "20230601"
    And Admin successfully approves the loan on "20230601" with "1000" amount and expected disbursement date on "20230601"
    When Admin successfully disburse the loan on "20230601" with "1000" EUR transaction amount
    Then Loan status will be "ACTIVE"
    Then Loan has the following maturity data:
      | actualMaturityDate | expectedMaturityDate |
      | 20230701       | 20230701         |
    When Admin sets the business date to "20230620"
    And Customer makes "AUTOPAY" repayment on "20230620" with 1000 EUR transaction amount
    Then Loan status will be "CLOSED_OBLIGATIONS_MET"
    Then Loan has the following maturity data:
      | actualMaturityDate | expectedMaturityDate |
      | 20230620       | 20230701         |
    When Admin sets the business date to "20230620"
    When Customer undo "1"th "Repayment" transaction made on "20230620"
    Then Loan status will be "ACTIVE"
    Then Loan has the following maturity data:
      | actualMaturityDate | expectedMaturityDate |
      | 20230701       | 20230701         |

  @TestRailId:C3202
  Scenario: Verify that closed date is updated on repayment reversal
    When Admin sets the business date to "20240601"
    When Admin creates a client with random data
    When Admin creates a new default Loan with date: "20240601"
    And Admin successfully approves the loan on "20240601" with "1000" amount and expected disbursement date on "20240601"
    When Admin successfully disburse the loan on "20240601" with "1000" EUR transaction amount
    Then Loan status will be "ACTIVE"
    When Admin sets the business date to "20240620"
    And Customer makes "AUTOPAY" repayment on "20240620" with 1000 EUR transaction amount
    Then Loan status will be "CLOSED_OBLIGATIONS_MET"
    Then Loan closedon_date is "20240620"
    When Admin sets the business date to "20240621"
    When Customer undo "1"th "Repayment" transaction made on "20240620"
    Then Loan status will be "ACTIVE"
    Then Loan closedon_date is "null"

  @TestRailId:C2777
  Scenario: As an admin I would like to delete a loan using external id
    When Admin sets the business date to the actual date
    And Admin creates a client with random data
    When Admin creates a new Loan
    Then Admin successfully deletes the loan with external id

  @TestRailId:C2778
  Scenario: As an admin I would like to verify that deleting loan using incorrect external id gives error
    When Admin sets the business date to the actual date
    And Admin creates a client with random data
    When Admin creates a new Loan
    Then Admin fails to delete the loan with incorrect external id

  @TestRailId:C2784
  Scenario: As a user I would like to do multiple repayment after reverse transactions and check the order of transactions
    When Admin sets the business date to "20221101"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy                                                             |
      | LP1         | 20221101  | 1000           | 0                      | DECLINING_BALANCE | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 30                | DAYS                  | 30             | DAYS                   | 1                  | 0                       | 0                      | 0                    | DUE_PENALTY_FEE_INTEREST_PRINCIPAL_IN_ADVANCE_PRINCIPAL_PENALTY_FEE_INTEREST |
    And Admin successfully approves the loan on "20221101" with "1000" amount and expected disbursement date on "20221101"
    When Admin successfully disburse the loan on "20221101" with "1000" EUR transaction amount
    Then Loan has 1000 outstanding amount
    When Admin adds "LOAN_NSF_FEE" due date charge with "20221102" due date and 10 EUR transaction amount
    When Admin sets the business date to "20221102"
    And Customer makes "AUTOPAY" repayment on "20221102" with 9 EUR transaction amount
    And Customer makes "AUTOPAY" repayment on "20221102" with 8 EUR transaction amount
    And Customer makes "AUTOPAY" repayment on "20221102" with 7 EUR transaction amount
    Then Loan Transactions tab has a transaction with date: "20221102", and with the following data:
      | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | Repayment        | 9.0    | 0.0       | 0.0      | 0.0  | 9.0       | 1000.0       |
      | Repayment        | 8.0    | 7.0       | 0.0      | 0.0  | 1.0       | 993.0        |
      | Repayment        | 7.0    | 7.0       | 0.0      | 0.0  | 0.0       | 986.0        |
    When Customer undo "1"th repayment on "20221102"
    Then Loan Transactions tab has a transaction with date: "20221102", and with the following data:
      | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | Repayment        | 9.0    | 0.0       | 0.0      | 0.0  | 9.0       | 1000.0       |
      | Repayment        | 8.0    | 0.0       | 0.0      | 0.0  | 8.0       | 1000.0       |
      | Repayment        | 7.0    | 5.0       | 0.0      | 0.0  | 2.0       | 993.0        |
    When Customer undo "2"th repayment on "20221102"
    Then Loan Transactions tab has a transaction with date: "20221102", and with the following data:
      | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | Repayment        | 9.0    | 0.0       | 0.0      | 0.0  | 9.0       | 1000.0       |
      | Repayment        | 8.0    | 0.0       | 0.0      | 0.0  | 8.0       | 1000.0       |
      | Repayment        | 7.0    | 0.0       | 0.0      | 0.0  | 7.0       | 1000.0       |

  @TestRailId:C2783
  Scenario: As an admin I would like to verify that only one active repayment schedule exits for loan multiple disbursement
    When Admin sets the business date to "20230707"
    And Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy                        |
      | LP1         | 20230707      | 1000           | 0                      | DECLINING_BALANCE | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 30                | DAYS                  | 30             | DAYS                   | 1                  | 0                       | 0                      | 0                    | PENALTIES_FEES_INTEREST_PRINCIPAL_ORDER |
    And Admin successfully approves the loan on "20230707" with "1000" amount and expected disbursement date on "20230707"
    And Admin successfully disburse the loan on "20230707" with "370.55" EUR transaction amount
    When Admin sets the business date to "20230712"
    When Admin adds "LOAN_SNOOZE_FEE" due date charge with "20230711" due date and 5.15 EUR transaction amount
    When Admin runs inline COB job for Loan
    Then Loan Repayment schedule has 1 periods, with the following data for periods:
      | Nr | Days | Date           | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20230707   |           | 370.55          |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 30   | 20230806 |           | 0.0             | 370.55        | 0.0      | 5.15 | 0.0       | 375.7 | 0.0  | 0.0        | 0.0  | 375.7       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 370.55        | 0        | 5.15 | 0         | 375.70 | 0    | 0          | 0    | 375.70      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20230707     | Disbursement     | 370.55 | 0.0       | 0.0      | 0.0  | 0.0       | 370.55       |
      | 20230711     | Accrual          | 5.15   | 0.0       | 0.0      | 5.15 | 0.0       | 0.0          |
    When Admin sets the business date to "20230721"
    When Customer makes "MERCHANT_ISSUED_REFUND" transaction with "AUTOPAY" payment type on "20230721" with 167.4 EUR transaction amount and system-generated Idempotency key
    Then Loan Repayment schedule has 1 periods, with the following data for periods:
      | Nr | Days | Date           | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20230707   |           | 370.55          |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 30   | 20230806 |           | 0.0             | 370.55        | 0.0      | 5.15 | 0.0       | 375.7 | 167.4 | 167.4      | 0.0  | 208.3       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      | 370.55        | 0        | 5.15 | 0         | 375.7 | 167.4 | 167.4      | 0    | 208.3       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type       | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20230707     | Disbursement           | 370.55 | 0.0       | 0.0      | 0.0  | 0.0       | 370.55       |
      | 20230711     | Accrual                | 5.15   | 0.0       | 0.0      | 5.15 | 0.0       | 0.0          |
      | 20230721     | Merchant Issued Refund | 167.4  | 162.25    | 0.0      | 5.15 | 0.0       | 208.3        |
    When Admin runs inline COB job for Loan
    When Admin sets the business date to "20230724"
    And Admin successfully disburse the loan on "20230724" with "18" EUR transaction amount
    Then Loan Repayment schedule has 1 periods, with the following data for periods:
      | Nr | Days | Date           | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20230707   |           | 370.55          |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      |    |      | 20230724   |           | 18.0            |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 30   | 20230806 |           | 0.0             | 388.55        | 0.0      | 5.15 | 0.0       | 393.7 | 167.4 | 167.4      | 0.0  | 226.3       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      | 388.55        | 0        | 5.15 | 0         | 393.7 | 167.4 | 167.4      | 0    | 226.3       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type       | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20230707     | Disbursement           | 370.55 | 0.0       | 0.0      | 0.0  | 0.0       | 370.55       |
      | 20230711     | Accrual                | 5.15   | 0.0       | 0.0      | 5.15 | 0.0       | 0.0          |
      | 20230721     | Merchant Issued Refund | 167.4  | 162.25    | 0.0      | 5.15 | 0.0       | 208.3        |
      | 20230724     | Disbursement           | 18.0   | 0.0       | 0.0      | 0.0  | 0.0       | 226.3        |

  @TestRailId:C2842 @AdvancedPaymentAllocation
  Scenario: As an admin I would like to verify that simple payments are working with advanced payment allocation (UC1)
    When Admin set "LP2_DOWNPAYMENT_AUTO_ADVANCED_PAYMENT_ALLOCATION" loan product "DEFAULT" transaction type to "NEXT_INSTALLMENT" future installment allocation rule
    When Admin sets the business date to "20230101"
    And Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                      | submitted on date | with Principal | ANNUAL interest rate % | interest type | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_DOWNPAYMENT_AUTO_ADVANCED_PAYMENT_ALLOCATION | 20230101   | 500            | 0                      | FLAT          | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 45                | DAYS                  | 15             | DAYS                   | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20230101" with "500" amount and expected disbursement date on "20230101"
    Then Loan status has changed to "Approved"
    And Admin successfully disburse the loan on "20230101" with "500" EUR transaction amount
    Then Loan status has changed to "Active"
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20230101  |                 | 500.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 0    | 20230101  | 20230101 | 375.0           | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 125.0 | 0.0        | 0.0  | 0.0         |
      | 2  | 15   | 20230116  |                 | 250.0           | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 0.0   | 0.0        | 0.0  | 125.0       |
      | 3  | 15   | 20230131  |                 | 125.0           | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 0.0   | 0.0        | 0.0  | 125.0       |
      | 4  | 15   | 20230215 |                 | 0.0             | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 0.0   | 0.0        | 0.0  | 125.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      | 500.0         | 0        | 0.0  | 0         | 500.0 | 125.0 | 0          | 0    | 375.0       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20230101  | Disbursement     | 500.0  | 0.0       | 0.0      | 0.0  | 0.0       | 500.0        |
      | 20230101  | Down Payment     | 125.0  | 125.0     | 0.0      | 0.0  | 0.0       | 375.0        |
    When Admin sets the business date to "20230116"
    And Customer makes "AUTOPAY" repayment on "20230116" with 125 EUR transaction amount
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20230101  |                 | 500.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 0    | 20230101  | 20230101 | 375.0           | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 125.0 | 0.0        | 0.0  | 0.0         |
      | 2  | 15   | 20230116  | 20230116 | 250.0           | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 125.0 | 0.0        | 0.0  | 0.0         |
      | 3  | 15   | 20230131  |                 | 125.0           | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 0.0   | 0.0        | 0.0  | 125.0       |
      | 4  | 15   | 20230215 |                 | 0.0             | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 0.0   | 0.0        | 0.0  | 125.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      | 500.0         | 0        | 0.0  | 0         | 500.0 | 250.0 | 0          | 0    | 250.0       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20230101  | Disbursement     | 500.0  | 0.0       | 0.0      | 0.0  | 0.0       | 500.0        |
      | 20230101  | Down Payment     | 125.0  | 125.0     | 0.0      | 0.0  | 0.0       | 375.0        |
      | 20230116  | Repayment        | 125.0  | 125.0     | 0.0      | 0.0  | 0.0       | 250.0        |
    When Admin sets the business date to "20230131"
    And Customer makes "AUTOPAY" repayment on "20230131" with 125 EUR transaction amount
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20230101  |                 | 500.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 0    | 20230101  | 20230101 | 375.0           | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 125.0 | 0.0        | 0.0  | 0.0         |
      | 2  | 15   | 20230116  | 20230116 | 250.0           | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 125.0 | 0.0        | 0.0  | 0.0         |
      | 3  | 15   | 20230131  | 20230131 | 125.0           | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 125.0 | 0.0        | 0.0  | 0.0         |
      | 4  | 15   | 20230215 |                 | 0.0             | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 0.0   | 0.0        | 0.0  | 125.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      | 500.0         | 0        | 0.0  | 0         | 500.0 | 375.0 | 0          | 0    | 125.0       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20230101  | Disbursement     | 500.0  | 0.0       | 0.0      | 0.0  | 0.0       | 500.0        |
      | 20230101  | Down Payment     | 125.0  | 125.0     | 0.0      | 0.0  | 0.0       | 375.0        |
      | 20230116  | Repayment        | 125.0  | 125.0     | 0.0      | 0.0  | 0.0       | 250.0        |
      | 20230131  | Repayment        | 125.0  | 125.0     | 0.0      | 0.0  | 0.0       | 125.0        |
    When Admin sets the business date to "20230215"
    And Customer makes "AUTOPAY" repayment on "20230215" with 125 EUR transaction amount
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20230101  |                  | 500.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 0    | 20230101  | 20230101  | 375.0           | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 125.0 | 0.0        | 0.0  | 0.0         |
      | 2  | 15   | 20230116  | 20230116  | 250.0           | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 125.0 | 0.0        | 0.0  | 0.0         |
      | 3  | 15   | 20230131  | 20230131  | 125.0           | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 125.0 | 0.0        | 0.0  | 0.0         |
      | 4  | 15   | 20230215 | 20230215 | 0.0             | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 125.0 | 0.0        | 0.0  | 0.0         |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      | 500.0         | 0        | 0.0  | 0         | 500.0 | 500.0 | 0          | 0    | 0.0         |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20230101  | Disbursement     | 500.0  | 0.0       | 0.0      | 0.0  | 0.0       | 500.0        |
      | 20230101  | Down Payment     | 125.0  | 125.0     | 0.0      | 0.0  | 0.0       | 375.0        |
      | 20230116  | Repayment        | 125.0  | 125.0     | 0.0      | 0.0  | 0.0       | 250.0        |
      | 20230131  | Repayment        | 125.0  | 125.0     | 0.0      | 0.0  | 0.0       | 125.0        |
      | 20230215 | Repayment        | 125.0  | 125.0     | 0.0      | 0.0  | 0.0       | 0.0          |
    Then Loan status has changed to "Closed (obligations met)"

  @TestRailId:C2843 @AdvancedPaymentAllocation
  Scenario: As an admin I would like to verify that simple payments and overpayment of the installment (goes to next installment) are working with advanced payment allocation (UC2)
    When Admin set "LP2_DOWNPAYMENT_AUTO_ADVANCED_PAYMENT_ALLOCATION" loan product "DEFAULT" transaction type to "NEXT_INSTALLMENT" future installment allocation rule
    When Admin sets the business date to "20230101"
    And Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                      | submitted on date | with Principal | ANNUAL interest rate % | interest type | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_DOWNPAYMENT_AUTO_ADVANCED_PAYMENT_ALLOCATION | 20230101   | 500            | 0                      | FLAT          | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 45                | DAYS                  | 15             | DAYS                   | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20230101" with "500" amount and expected disbursement date on "20230101"
    Then Loan status has changed to "Approved"
    And Admin successfully disburse the loan on "20230101" with "500" EUR transaction amount
    Then Loan status has changed to "Active"
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20230101  |                 | 500.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 0    | 20230101  | 20230101 | 375.0           | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 125.0 | 0.0        | 0.0  | 0.0         |
      | 2  | 15   | 20230116  |                 | 250.0           | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 0.0   | 0.0        | 0.0  | 125.0       |
      | 3  | 15   | 20230131  |                 | 125.0           | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 0.0   | 0.0        | 0.0  | 125.0       |
      | 4  | 15   | 20230215 |                 | 0.0             | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 0.0   | 0.0        | 0.0  | 125.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      | 500.0         | 0        | 0.0  | 0         | 500.0 | 125.0 | 0          | 0    | 375.0       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20230101  | Disbursement     | 500.0  | 0.0       | 0.0      | 0.0  | 0.0       | 500.0        |
      | 20230101  | Down Payment     | 125.0  | 125.0     | 0.0      | 0.0  | 0.0       | 375.0        |
    When Admin sets the business date to "20230116"
    And Customer makes "AUTOPAY" repayment on "20230116" with 150 EUR transaction amount
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20230101  |                 | 500.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 0    | 20230101  | 20230101 | 375.0           | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 125.0 | 0.0        | 0.0  | 0.0         |
      | 2  | 15   | 20230116  | 20230116 | 250.0           | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 125.0 | 0.0        | 0.0  | 0.0         |
      | 3  | 15   | 20230131  |                 | 125.0           | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 25.0  | 25.0       | 0.0  | 100.0       |
      | 4  | 15   | 20230215 |                 | 0.0             | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 0.0   | 0.0        | 0.0  | 125.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      | 500.0         | 0        | 0.0  | 0         | 500.0 | 275.0 | 25.0       | 0    | 225.0       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20230101  | Disbursement     | 500.0  | 0.0       | 0.0      | 0.0  | 0.0       | 500.0        |
      | 20230101  | Down Payment     | 125.0  | 125.0     | 0.0      | 0.0  | 0.0       | 375.0        |
      | 20230116  | Repayment        | 150.0  | 150.0     | 0.0      | 0.0  | 0.0       | 225.0        |
    When Admin sets the business date to "20230131"
    And Customer makes "AUTOPAY" repayment on "20230131" with 125 EUR transaction amount
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20230101  |                 | 500.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 0    | 20230101  | 20230101 | 375.0           | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 125.0 | 0.0        | 0.0  | 0.0         |
      | 2  | 15   | 20230116  | 20230116 | 250.0           | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 125.0 | 0.0        | 0.0  | 0.0         |
      | 3  | 15   | 20230131  | 20230131 | 125.0           | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 125.0 | 25.0       | 0.0  | 0.0         |
      | 4  | 15   | 20230215 |                 | 0.0             | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 25.0  | 25.0       | 0.0  | 100.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      | 500.0         | 0        | 0.0  | 0         | 500.0 | 400.0 | 50.0       | 0    | 100.0       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20230101  | Disbursement     | 500.0  | 0.0       | 0.0      | 0.0  | 0.0       | 500.0        |
      | 20230101  | Down Payment     | 125.0  | 125.0     | 0.0      | 0.0  | 0.0       | 375.0        |
      | 20230116  | Repayment        | 150.0  | 150.0     | 0.0      | 0.0  | 0.0       | 225.0        |
      | 20230131  | Repayment        | 125.0  | 125.0     | 0.0      | 0.0  | 0.0       | 100.0        |
    When Admin sets the business date to "20230215"
    And Customer makes "AUTOPAY" repayment on "20230215" with 100 EUR transaction amount
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20230101  |                  | 500.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 0    | 20230101  | 20230101  | 375.0           | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 125.0 | 0.0        | 0.0  | 0.0         |
      | 2  | 15   | 20230116  | 20230116  | 250.0           | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 125.0 | 0.0        | 0.0  | 0.0         |
      | 3  | 15   | 20230131  | 20230131  | 125.0           | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 125.0 | 25.0       | 0.0  | 0.0         |
      | 4  | 15   | 20230215 | 20230215 | 0.0             | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 125.0 | 25.0       | 0.0  | 0.0         |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      | 500.0         | 0        | 0.0  | 0         | 500.0 | 500.0 | 50.0       | 0    | 0.0         |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20230101  | Disbursement     | 500.0  | 0.0       | 0.0      | 0.0  | 0.0       | 500.0        |
      | 20230101  | Down Payment     | 125.0  | 125.0     | 0.0      | 0.0  | 0.0       | 375.0        |
      | 20230116  | Repayment        | 150.0  | 150.0     | 0.0      | 0.0  | 0.0       | 225.0        |
      | 20230131  | Repayment        | 125.0  | 125.0     | 0.0      | 0.0  | 0.0       | 100.0        |
      | 20230215 | Repayment        | 100.0  | 100.0     | 0.0      | 0.0  | 0.0       | 0.0          |
    Then Loan status has changed to "Closed (obligations met)"

  @TestRailId:C2844 @AdvancedPaymentAllocation
  Scenario: As an admin I would like to verify that simple payments and overpayment of the installment (goes to last installment) are working with advanced payment allocation (UC3)
    When Admin set "LP2_DOWNPAYMENT_AUTO_ADVANCED_PAYMENT_ALLOCATION" loan product "DEFAULT" transaction type to "NEXT_INSTALLMENT" future installment allocation rule
    When Admin sets the business date to "20230101"
    And Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                      | submitted on date | with Principal | ANNUAL interest rate % | interest type | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_DOWNPAYMENT_AUTO_ADVANCED_PAYMENT_ALLOCATION | 20230101   | 500            | 0                      | FLAT          | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 45                | DAYS                  | 15             | DAYS                   | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20230101" with "500" amount and expected disbursement date on "20230101"
    Then Loan status has changed to "Approved"
    And Admin successfully disburse the loan on "20230101" with "500" EUR transaction amount
    Then Loan status has changed to "Active"
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20230101  |                 | 500.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 0    | 20230101  | 20230101 | 375.0           | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 125.0 | 0.0        | 0.0  | 0.0         |
      | 2  | 15   | 20230116  |                 | 250.0           | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 0.0   | 0.0        | 0.0  | 125.0       |
      | 3  | 15   | 20230131  |                 | 125.0           | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 0.0   | 0.0        | 0.0  | 125.0       |
      | 4  | 15   | 20230215 |                 | 0.0             | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 0.0   | 0.0        | 0.0  | 125.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      | 500.0         | 0        | 0.0  | 0         | 500.0 | 125.0 | 0          | 0    | 375.0       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20230101  | Disbursement     | 500.0  | 0.0       | 0.0      | 0.0  | 0.0       | 500.0        |
      | 20230101  | Down Payment     | 125.0  | 125.0     | 0.0      | 0.0  | 0.0       | 375.0        |
    When Admin sets the business date to "20230116"
    And Customer makes "GOODWILL_CREDIT" transaction with "AUTOPAY" payment type on "20230116" with 150 EUR transaction amount and self-generated Idempotency key
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20230101  |                 | 500.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 0    | 20230101  | 20230101 | 375.0           | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 125.0 | 0.0        | 0.0  | 0.0         |
      | 2  | 15   | 20230116  | 20230116 | 250.0           | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 125.0 | 0.0        | 0.0  | 0.0         |
      | 3  | 15   | 20230131  |                 | 125.0           | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 0.0   | 0.0        | 0.0  | 125.0       |
      | 4  | 15   | 20230215 |                 | 0.0             | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 25.0  | 25.0       | 0.0  | 100.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      | 500.0         | 0        | 0.0  | 0         | 500.0 | 275.0 | 25.0       | 0    | 225.0       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20230101  | Disbursement     | 500.0  | 0.0       | 0.0      | 0.0  | 0.0       | 500.0        |
      | 20230101  | Down Payment     | 125.0  | 125.0     | 0.0      | 0.0  | 0.0       | 375.0        |
      | 20230116  | Goodwill Credit  | 150.0  | 150.0     | 0.0      | 0.0  | 0.0       | 225.0        |
    When Admin sets the business date to "20230131"
    And Customer makes "GOODWILL_CREDIT" transaction with "AUTOPAY" payment type on "20230131" with 125 EUR transaction amount and self-generated Idempotency key
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20230101  |                 | 500.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 0    | 20230101  | 20230101 | 375.0           | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 125.0 | 0.0        | 0.0  | 0.0         |
      | 2  | 15   | 20230116  | 20230116 | 250.0           | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 125.0 | 0.0        | 0.0  | 0.0         |
      | 3  | 15   | 20230131  | 20230131 | 125.0           | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 125.0 | 0.0        | 0.0  | 0.0         |
      | 4  | 15   | 20230215 |                 | 0.0             | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 25.0  | 25.0       | 0.0  | 100.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      | 500.0         | 0        | 0.0  | 0         | 500.0 | 400.0 | 25.0       | 0    | 100.0       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20230101  | Disbursement     | 500.0  | 0.0       | 0.0      | 0.0  | 0.0       | 500.0        |
      | 20230101  | Down Payment     | 125.0  | 125.0     | 0.0      | 0.0  | 0.0       | 375.0        |
      | 20230116  | Goodwill Credit  | 150.0  | 150.0     | 0.0      | 0.0  | 0.0       | 225.0        |
      | 20230131  | Goodwill Credit  | 125.0  | 125.0     | 0.0      | 0.0  | 0.0       | 100.0        |
    When Admin sets the business date to "20230215"
    And Customer makes "GOODWILL_CREDIT" transaction with "AUTOPAY" payment type on "20230215" with 100 EUR transaction amount and self-generated Idempotency key
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20230101  |                  | 500.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 0    | 20230101  | 20230101  | 375.0           | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 125.0 | 0.0        | 0.0  | 0.0         |
      | 2  | 15   | 20230116  | 20230116  | 250.0           | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 125.0 | 0.0        | 0.0  | 0.0         |
      | 3  | 15   | 20230131  | 20230131  | 125.0           | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 125.0 | 0.0        | 0.0  | 0.0         |
      | 4  | 15   | 20230215 | 20230215 | 0.0             | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 125.0 | 25.0       | 0.0  | 0.0         |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      | 500.0         | 0        | 0.0  | 0         | 500.0 | 500.0 | 25.0       | 0    | 0.0         |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20230101  | Disbursement     | 500.0  | 0.0       | 0.0      | 0.0  | 0.0       | 500.0        |
      | 20230101  | Down Payment     | 125.0  | 125.0     | 0.0      | 0.0  | 0.0       | 375.0        |
      | 20230116  | Goodwill Credit  | 150.0  | 150.0     | 0.0      | 0.0  | 0.0       | 225.0        |
      | 20230131  | Goodwill Credit  | 125.0  | 125.0     | 0.0      | 0.0  | 0.0       | 100.0        |
      | 20230215 | Goodwill Credit  | 100.0  | 100.0     | 0.0      | 0.0  | 0.0       | 0.0          |
    Then Loan status has changed to "Closed (obligations met)"

  @TestRailId:C2845 @AdvancedPaymentAllocation
  Scenario: As an admin I would like to verify that simple payments are working after some of them failed with advanced payment allocation (UC4)
    When Admin set "LP2_DOWNPAYMENT_AUTO_ADVANCED_PAYMENT_ALLOCATION" loan product "DEFAULT" transaction type to "NEXT_INSTALLMENT" future installment allocation rule
    When Admin sets the business date to "20230101"
    And Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                      | submitted on date | with Principal | ANNUAL interest rate % | interest type | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_DOWNPAYMENT_AUTO_ADVANCED_PAYMENT_ALLOCATION | 20230101   | 500            | 0                      | FLAT          | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 45                | DAYS                  | 15             | DAYS                   | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20230101" with "500" amount and expected disbursement date on "20230101"
    Then Loan status has changed to "Approved"
    And Admin successfully disburse the loan on "20230101" with "500" EUR transaction amount
    Then Loan status has changed to "Active"
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20230101  |                 | 500.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 0    | 20230101  | 20230101 | 375.0           | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 125.0 | 0.0        | 0.0  | 0.0         |
      | 2  | 15   | 20230116  |                 | 250.0           | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 0.0   | 0.0        | 0.0  | 125.0       |
      | 3  | 15   | 20230131  |                 | 125.0           | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 0.0   | 0.0        | 0.0  | 125.0       |
      | 4  | 15   | 20230215 |                 | 0.0             | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 0.0   | 0.0        | 0.0  | 125.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      | 500.0         | 0        | 0.0  | 0         | 500.0 | 125.0 | 0          | 0    | 375.0       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20230101  | Disbursement     | 500.0  | 0.0       | 0.0      | 0.0  | 0.0       | 500.0        |
      | 20230101  | Down Payment     | 125.0  | 125.0     | 0.0      | 0.0  | 0.0       | 375.0        |
    When Customer undo "2"th transaction made on "20230101"
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20230101  |           | 500.0           |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 0    | 20230101  |           | 375.0           | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 0.0  | 0.0        | 0.0  | 125.0       |
      | 2  | 15   | 20230116  |           | 250.0           | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 0.0  | 0.0        | 0.0  | 125.0       |
      | 3  | 15   | 20230131  |           | 125.0           | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 0.0  | 0.0        | 0.0  | 125.0       |
      | 4  | 15   | 20230215 |           | 0.0             | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 0.0  | 0.0        | 0.0  | 125.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      | 500.0         | 0        | 0.0  | 0         | 500.0 | 0.0  | 0          | 0    | 500.0       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20230101  | Disbursement     | 500.0  | 0.0       | 0.0      | 0.0  | 0.0       | 500.0        | false    |
      | 20230101  | Down Payment     | 125.0  | 125.0     | 0.0      | 0.0  | 0.0       | 375.0        | true     |
    When Admin sets the business date to "20230116"
    And Customer makes "AUTOPAY" repayment on "20230116" with 125 EUR transaction amount
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late  | Outstanding |
      |    |      | 20230101  |                 | 500.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |       |             |
      | 1  | 0    | 20230101  | 20230116 | 375.0           | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 125.0 | 0.0        | 125.0 | 0.0         |
      | 2  | 15   | 20230116  |                 | 250.0           | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 0.0   | 0.0        | 0.0   | 125.0       |
      | 3  | 15   | 20230131  |                 | 125.0           | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 0.0   | 0.0        | 0.0   | 125.0       |
      | 4  | 15   | 20230215 |                 | 0.0             | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 0.0   | 0.0        | 0.0   | 125.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late  | Outstanding |
      | 500.0         | 0        | 0.0  | 0         | 500.0 | 125.0 | 0          | 125.0 | 375.0       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20230101  | Disbursement     | 500.0  | 0.0       | 0.0      | 0.0  | 0.0       | 500.0        | false    |
      | 20230101  | Down Payment     | 125.0  | 125.0     | 0.0      | 0.0  | 0.0       | 375.0        | true     |
      | 20230116  | Repayment        | 125.0  | 125.0     | 0.0      | 0.0  | 0.0       | 375.0        | false    |
    When Customer undo "1"th transaction made on "20230116"
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20230101  |           | 500.0           |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 0    | 20230101  |           | 375.0           | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 0.0  | 0.0        | 0.0  | 125.0       |
      | 2  | 15   | 20230116  |           | 250.0           | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 0.0  | 0.0        | 0.0  | 125.0       |
      | 3  | 15   | 20230131  |           | 125.0           | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 0.0  | 0.0        | 0.0  | 125.0       |
      | 4  | 15   | 20230215 |           | 0.0             | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 0.0  | 0.0        | 0.0  | 125.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      | 500.0         | 0        | 0.0  | 0         | 500.0 | 0.0  | 0          | 0    | 500.0       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20230101  | Disbursement     | 500.0  | 0.0       | 0.0      | 0.0  | 0.0       | 500.0        | false    |
      | 20230101  | Down Payment     | 125.0  | 125.0     | 0.0      | 0.0  | 0.0       | 375.0        | true     |
      | 20230116  | Repayment        | 125.0  | 125.0     | 0.0      | 0.0  | 0.0       | 375.0        | true     |
    When Admin sets the business date to "20230120"
    And Customer makes "AUTOPAY" repayment on "20230120" with 100 EUR transaction amount
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late  | Outstanding |
      |    |      | 20230101  |           | 500.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |       |             |
      | 1  | 0    | 20230101  |           | 375.0           | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 100.0 | 0.0        | 100.0 | 25.0        |
      | 2  | 15   | 20230116  |           | 250.0           | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 0.0   | 0.0        | 0.0   | 125.0       |
      | 3  | 15   | 20230131  |           | 125.0           | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 0.0   | 0.0        | 0.0   | 125.0       |
      | 4  | 15   | 20230215 |           | 0.0             | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 0.0   | 0.0        | 0.0   | 125.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late  | Outstanding |
      | 500.0         | 0        | 0.0  | 0         | 500.0 | 100.0 | 0          | 100.0 | 400.0       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20230101  | Disbursement     | 500.0  | 0.0       | 0.0      | 0.0  | 0.0       | 500.0        | false    |
      | 20230101  | Down Payment     | 125.0  | 125.0     | 0.0      | 0.0  | 0.0       | 375.0        | true     |
      | 20230116  | Repayment        | 125.0  | 125.0     | 0.0      | 0.0  | 0.0       | 375.0        | true     |
      | 20230120  | Repayment        | 100.0  | 100.0     | 0.0      | 0.0  | 0.0       | 400.0        | false    |
    When Admin sets the business date to "20230131"
    And Customer makes "AUTOPAY" repayment on "20230131" with 40 EUR transaction amount
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late  | Outstanding |
      |    |      | 20230101  |                 | 500.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |       |             |
      | 1  | 0    | 20230101  | 20230131 | 375.0           | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 125.0 | 0.0        | 125.0 | 0.0         |
      | 2  | 15   | 20230116  |                 | 250.0           | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 15.0  | 0.0        | 15.0  | 110.0       |
      | 3  | 15   | 20230131  |                 | 125.0           | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 0.0   | 0.0        | 0.0   | 125.0       |
      | 4  | 15   | 20230215 |                 | 0.0             | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 0.0   | 0.0        | 0.0   | 125.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late  | Outstanding |
      | 500.0         | 0        | 0.0  | 0         | 500.0 | 140.0 | 0          | 140.0 | 360.0       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20230101  | Disbursement     | 500.0  | 0.0       | 0.0      | 0.0  | 0.0       | 500.0        | false    |
      | 20230101  | Down Payment     | 125.0  | 125.0     | 0.0      | 0.0  | 0.0       | 375.0        | true     |
      | 20230116  | Repayment        | 125.0  | 125.0     | 0.0      | 0.0  | 0.0       | 375.0        | true     |
      | 20230120  | Repayment        | 100.0  | 100.0     | 0.0      | 0.0  | 0.0       | 400.0        | false    |
      | 20230131  | Repayment        | 40.0   | 40.0      | 0.0      | 0.0  | 0.0       | 360.0        | false    |
    When Admin sets the business date to "20230215"
    And Customer makes "AUTOPAY" repayment on "20230215" with 360 EUR transaction amount
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late  | Outstanding |
      |    |      | 20230101  |                  | 500.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |       |             |
      | 1  | 0    | 20230101  | 20230131  | 375.0           | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 125.0 | 0.0        | 125.0 | 0.0         |
      | 2  | 15   | 20230116  | 20230215 | 250.0           | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 125.0 | 0.0        | 125.0 | 0.0         |
      | 3  | 15   | 20230131  | 20230215 | 125.0           | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 125.0 | 0.0        | 125.0 | 0.0         |
      | 4  | 15   | 20230215 | 20230215 | 0.0             | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 125.0 | 0.0        | 0.0   | 0.0         |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late  | Outstanding |
      | 500.0         | 0        | 0.0  | 0         | 500.0 | 500.0 | 0          | 375.0 | 0.0         |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20230101  | Disbursement     | 500.0  | 0.0       | 0.0      | 0.0  | 0.0       | 500.0        | false    |
      | 20230101  | Down Payment     | 125.0  | 125.0     | 0.0      | 0.0  | 0.0       | 375.0        | true     |
      | 20230116  | Repayment        | 125.0  | 125.0     | 0.0      | 0.0  | 0.0       | 375.0        | true     |
      | 20230120  | Repayment        | 100.0  | 100.0     | 0.0      | 0.0  | 0.0       | 400.0        | false    |
      | 20230131  | Repayment        | 40.0   | 40.0      | 0.0      | 0.0  | 0.0       | 360.0        | false    |
      | 20230215 | Repayment        | 360.0  | 360.0     | 0.0      | 0.0  | 0.0       | 0.0          | false    |
    Then Loan status has changed to "Closed (obligations met)"

  @TestRailId:C2846 @AdvancedPaymentAllocation
  Scenario: As an admin I would like to verify that Merchant issued refund with reamortization works with advanced payment allocation (UC05)
    When Admin set "LP2_DOWNPAYMENT_AUTO_ADVANCED_PAYMENT_ALLOCATION" loan product "DEFAULT" transaction type to "NEXT_INSTALLMENT" future installment allocation rule
    When Admin sets the business date to "20230101"
    And Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                      | submitted on date | with Principal | ANNUAL interest rate % | interest type | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_DOWNPAYMENT_AUTO_ADVANCED_PAYMENT_ALLOCATION | 20230101   | 500            | 0                      | FLAT          | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 45                | DAYS                  | 15             | DAYS                   | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20230101" with "500" amount and expected disbursement date on "20230101"
    Then Loan status has changed to "Approved"
    And Admin successfully disburse the loan on "20230101" with "500" EUR transaction amount
    Then Loan status has changed to "Active"
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20230101  |                 | 500.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 0    | 20230101  | 20230101 | 375.0           | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 125.0 | 0.0        | 0.0  | 0.0         |
      | 2  | 15   | 20230116  |                 | 250.0           | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 0.0   | 0.0        | 0.0  | 125.0       |
      | 3  | 15   | 20230131  |                 | 125.0           | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 0.0   | 0.0        | 0.0  | 125.0       |
      | 4  | 15   | 20230215 |                 | 0.0             | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 0.0   | 0.0        | 0.0  | 125.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      | 500.0         | 0        | 0.0  | 0         | 500.0 | 125.0 | 0          | 0    | 375.0       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20230101  | Disbursement     | 500.0  | 0.0       | 0.0      | 0.0  | 0.0       | 500.0        |
      | 20230101  | Down Payment     | 125.0  | 125.0     | 0.0      | 0.0  | 0.0       | 375.0        |
    When Customer undo "2"th transaction made on "20230101"
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20230101  |           | 500.0           |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 0    | 20230101  |           | 375.0           | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 0.0  | 0.0        | 0.0  | 125.0       |
      | 2  | 15   | 20230116  |           | 250.0           | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 0.0  | 0.0        | 0.0  | 125.0       |
      | 3  | 15   | 20230131  |           | 125.0           | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 0.0  | 0.0        | 0.0  | 125.0       |
      | 4  | 15   | 20230215 |           | 0.0             | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 0.0  | 0.0        | 0.0  | 125.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      | 500.0         | 0        | 0.0  | 0         | 500.0 | 0.0  | 0          | 0    | 500.0       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20230101  | Disbursement     | 500.0  | 0.0       | 0.0      | 0.0  | 0.0       | 500.0        | false    |
      | 20230101  | Down Payment     | 125.0  | 125.0     | 0.0      | 0.0  | 0.0       | 375.0        | true     |
    When Admin sets the business date to "20230108"
    When Customer makes "MERCHANT_ISSUED_REFUND" transaction with "AUTOPAY" payment type on "20230108" with 300 EUR transaction amount and self-generated Idempotency key
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late  | Outstanding |
      |    |      | 20230101  |                 | 500.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |       |             |
      | 1  | 0    | 20230101  | 20230108 | 375.0           | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 125.0 | 0.0        | 125.0 | 0.0         |
      | 2  | 15   | 20230116  |                 | 250.0           | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 58.33 | 58.33      | 0.0   | 66.67       |
      | 3  | 15   | 20230131  |                 | 125.0           | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 58.33 | 58.33      | 0.0   | 66.67       |
      | 4  | 15   | 20230215 |                 | 0.0             | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 58.34 | 58.34      | 0.0   | 66.66       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late  | Outstanding |
      | 500.0         | 0        | 0.0  | 0         | 500.0 | 300.0 | 175.0      | 125.0 | 200.0       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type       | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20230101  | Disbursement           | 500.0  | 0.0       | 0.0      | 0.0  | 0.0       | 500.0        | false    |
      | 20230101  | Down Payment           | 125.0  | 125.0     | 0.0      | 0.0  | 0.0       | 375.0        | true     |
      | 20230108  | Merchant Issued Refund | 300.0  | 300.0     | 0.0      | 0.0  | 0.0       | 200.0        | false    |
    When Admin sets the business date to "20230116"
    And Customer makes "AUTOPAY" repayment on "20230116" with 201 EUR transaction amount
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late  | Outstanding |
      |    |      | 20230101  |                 | 500.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |       |             |
      | 1  | 0    | 20230101  | 20230108 | 375.0           | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 125.0 | 0.0        | 125.0 | 0.0         |
      | 2  | 15   | 20230116  | 20230116 | 250.0           | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 125.0 | 58.33      | 0.0   | 0.0         |
      | 3  | 15   | 20230131  | 20230116 | 125.0           | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 125.0 | 125.0      | 0.0   | 0.0         |
      | 4  | 15   | 20230215 | 20230116 | 0.0             | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 125.0 | 125.0      | 0.0   | 0.0         |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late  | Outstanding |
      | 500.0         | 0        | 0.0  | 0         | 500.0 | 500.0 | 308.33     | 125.0 | 0.0         |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type       | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Overpayment |
      | 20230101  | Disbursement           | 500.0  | 0.0       | 0.0      | 0.0  | 0.0       | 500.0        | false    | 0.0         |
      | 20230101  | Down Payment           | 125.0  | 125.0     | 0.0      | 0.0  | 0.0       | 375.0        | true     | 0.0         |
      | 20230108  | Merchant Issued Refund | 300.0  | 300.0     | 0.0      | 0.0  | 0.0       | 200.0        | false    | 0.0         |
      | 20230116  | Repayment              | 201.0  | 200.0     | 0.0      | 0.0  | 0.0       | 0.0          | false    | 1.0         |
    Then Loan status has changed to "Overpaid"

  @TestRailId:C2847 @AdvancedPaymentAllocation
  Scenario: As an admin I would like to verify that Merchant issued refund with reamortization on due date works with advanced payment allocation (UC07)
    When Admin set "LP2_DOWNPAYMENT_AUTO_ADVANCED_PAYMENT_ALLOCATION" loan product "DEFAULT" transaction type to "NEXT_INSTALLMENT" future installment allocation rule
    When Admin sets the business date to "20230101"
    And Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                      | submitted on date | with Principal | ANNUAL interest rate % | interest type | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_DOWNPAYMENT_AUTO_ADVANCED_PAYMENT_ALLOCATION | 20230101   | 500            | 0                      | FLAT          | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 45                | DAYS                  | 15             | DAYS                   | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20230101" with "500" amount and expected disbursement date on "20230101"
    Then Loan status has changed to "Approved"
    And Admin successfully disburse the loan on "20230101" with "500" EUR transaction amount
    Then Loan status has changed to "Active"
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20230101  |                 | 500.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 0    | 20230101  | 20230101 | 375.0           | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 125.0 | 0.0        | 0.0  | 0.0         |
      | 2  | 15   | 20230116  |                 | 250.0           | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 0.0   | 0.0        | 0.0  | 125.0       |
      | 3  | 15   | 20230131  |                 | 125.0           | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 0.0   | 0.0        | 0.0  | 125.0       |
      | 4  | 15   | 20230215 |                 | 0.0             | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 0.0   | 0.0        | 0.0  | 125.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      | 500.0         | 0        | 0.0  | 0         | 500.0 | 125.0 | 0          | 0    | 375.0       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20230101  | Disbursement     | 500.0  | 0.0       | 0.0      | 0.0  | 0.0       | 500.0        |
      | 20230101  | Down Payment     | 125.0  | 125.0     | 0.0      | 0.0  | 0.0       | 375.0        |
    When Admin sets the business date to "20230116"
    And Customer makes "AUTOPAY" repayment on "20230116" with 125 EUR transaction amount
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20230101  |                 | 500.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 0    | 20230101  | 20230101 | 375.0           | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 125.0 | 0.0        | 0.0  | 0.0         |
      | 2  | 15   | 20230116  | 20230116 | 250.0           | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 125.0 | 0.0        | 0.0  | 0.0         |
      | 3  | 15   | 20230131  |                 | 125.0           | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 0.0   | 0.0        | 0.0  | 125.0       |
      | 4  | 15   | 20230215 |                 | 0.0             | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 0.0   | 0.0        | 0.0  | 125.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      | 500.0         | 0        | 0.0  | 0         | 500.0 | 250.0 | 0.0        | 0.0  | 250.0       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20230101  | Disbursement     | 500.0  | 0.0       | 0.0      | 0.0  | 0.0       | 500.0        |
      | 20230101  | Down Payment     | 125.0  | 125.0     | 0.0      | 0.0  | 0.0       | 375.0        |
      | 20230116  | Repayment        | 125.0  | 125.0     | 0.0      | 0.0  | 0.0       | 250.0        |
    When Admin sets the business date to "20230116"
    When Customer makes "MERCHANT_ISSUED_REFUND" transaction with "AUTOPAY" payment type on "20230116" with 200 EUR transaction amount and self-generated Idempotency key
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20230101  |                 | 500.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 0    | 20230101  | 20230101 | 375.0           | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 125.0 | 0.0        | 0.0  | 0.0         |
      | 2  | 15   | 20230116  | 20230116 | 250.0           | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 125.0 | 0.0        | 0.0  | 0.0         |
      | 3  | 15   | 20230131  |                 | 125.0           | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 100.0 | 100.0      | 0.0  | 25.0        |
      | 4  | 15   | 20230215 |                 | 0.0             | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 100.0 | 100.0      | 0.0  | 25.0        |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      | 500.0         | 0        | 0.0  | 0         | 500.0 | 450.0 | 200.0      | 0.0  | 50.0        |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type       | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20230101  | Disbursement           | 500.0  | 0.0       | 0.0      | 0.0  | 0.0       | 500.0        |
      | 20230101  | Down Payment           | 125.0  | 125.0     | 0.0      | 0.0  | 0.0       | 375.0        |
      | 20230116  | Repayment              | 125.0  | 125.0     | 0.0      | 0.0  | 0.0       | 250.0        |
      | 20230116  | Merchant Issued Refund | 200.0  | 200.0     | 0.0      | 0.0  | 0.0       | 50.0         |
    When Admin sets the business date to "20230131"
    And Customer makes "AUTOPAY" repayment on "20230131" with 25 EUR transaction amount
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20230101  |                 | 500.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 0    | 20230101  | 20230101 | 375.0           | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 125.0 | 0.0        | 0.0  | 0.0         |
      | 2  | 15   | 20230116  | 20230116 | 250.0           | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 125.0 | 0.0        | 0.0  | 0.0         |
      | 3  | 15   | 20230131  | 20230131 | 125.0           | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 125.0 | 100.0      | 0.0  | 0.0         |
      | 4  | 15   | 20230215 |                 | 0.0             | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 100.0 | 100.0      | 0.0  | 25.0        |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      | 500.0         | 0        | 0.0  | 0         | 500.0 | 475.0 | 200.0      | 0.0  | 25.0        |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type       | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20230101  | Disbursement           | 500.0  | 0.0       | 0.0      | 0.0  | 0.0       | 500.0        |
      | 20230101  | Down Payment           | 125.0  | 125.0     | 0.0      | 0.0  | 0.0       | 375.0        |
      | 20230116  | Repayment              | 125.0  | 125.0     | 0.0      | 0.0  | 0.0       | 250.0        |
      | 20230116  | Merchant Issued Refund | 200.0  | 200.0     | 0.0      | 0.0  | 0.0       | 50.0         |
      | 20230131  | Repayment              | 25.0   | 25.0      | 0.0      | 0.0  | 0.0       | 25.0         |
    When Admin sets the business date to "20230215"
    And Customer makes "AUTOPAY" repayment on "20230215" with 25 EUR transaction amount
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20230101  |                  | 500.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 0    | 20230101  | 20230101  | 375.0           | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 125.0 | 0.0        | 0.0  | 0.0         |
      | 2  | 15   | 20230116  | 20230116  | 250.0           | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 125.0 | 0.0        | 0.0  | 0.0         |
      | 3  | 15   | 20230131  | 20230131  | 125.0           | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 125.0 | 100.0      | 0.0  | 0.0         |
      | 4  | 15   | 20230215 | 20230215 | 0.0             | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 125.0 | 100.0      | 0.0  | 0.0         |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      | 500.0         | 0        | 0.0  | 0         | 500.0 | 500.0 | 200.0      | 0.0  | 0.0         |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type       | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20230101  | Disbursement           | 500.0  | 0.0       | 0.0      | 0.0  | 0.0       | 500.0        |
      | 20230101  | Down Payment           | 125.0  | 125.0     | 0.0      | 0.0  | 0.0       | 375.0        |
      | 20230116  | Repayment              | 125.0  | 125.0     | 0.0      | 0.0  | 0.0       | 250.0        |
      | 20230116  | Merchant Issued Refund | 200.0  | 200.0     | 0.0      | 0.0  | 0.0       | 50.0         |
      | 20230131  | Repayment              | 25.0   | 25.0      | 0.0      | 0.0  | 0.0       | 25.0         |
      | 20230215 | Repayment              | 25.0   | 25.0      | 0.0      | 0.0  | 0.0       | 0.0          |
    Then Loan status has changed to "Closed (obligations met)"

  @TestRailId:C2848 @AdvancedPaymentAllocation
  Scenario: As an admin I would like to verify that Merchant issued refund with reamortization past due date works with advanced payment allocation (UC08)
    When Admin set "LP2_DOWNPAYMENT_AUTO_ADVANCED_PAYMENT_ALLOCATION" loan product "DEFAULT" transaction type to "NEXT_INSTALLMENT" future installment allocation rule
    When Admin sets the business date to "20230101"
    And Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                      | submitted on date | with Principal | ANNUAL interest rate % | interest type | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_DOWNPAYMENT_AUTO_ADVANCED_PAYMENT_ALLOCATION | 20230101   | 500            | 0                      | FLAT          | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 45                | DAYS                  | 15             | DAYS                   | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20230101" with "500" amount and expected disbursement date on "20230101"
    Then Loan status has changed to "Approved"
    And Admin successfully disburse the loan on "20230101" with "500" EUR transaction amount
    Then Loan status has changed to "Active"
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20230101  |                 | 500.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 0    | 20230101  | 20230101 | 375.0           | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 125.0 | 0.0        | 0.0  | 0.0         |
      | 2  | 15   | 20230116  |                 | 250.0           | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 0.0   | 0.0        | 0.0  | 125.0       |
      | 3  | 15   | 20230131  |                 | 125.0           | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 0.0   | 0.0        | 0.0  | 125.0       |
      | 4  | 15   | 20230215 |                 | 0.0             | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 0.0   | 0.0        | 0.0  | 125.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      | 500.0         | 0        | 0.0  | 0         | 500.0 | 125.0 | 0          | 0    | 375.0       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20230101  | Disbursement     | 500.0  | 0.0       | 0.0      | 0.0  | 0.0       | 500.0        |
      | 20230101  | Down Payment     | 125.0  | 125.0     | 0.0      | 0.0  | 0.0       | 375.0        |
    When Customer undo "2"th transaction made on "20230101"
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20230101  |           | 500.0           |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 0    | 20230101  |           | 375.0           | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 0.0  | 0.0        | 0.0  | 125.0       |
      | 2  | 15   | 20230116  |           | 250.0           | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 0.0  | 0.0        | 0.0  | 125.0       |
      | 3  | 15   | 20230131  |           | 125.0           | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 0.0  | 0.0        | 0.0  | 125.0       |
      | 4  | 15   | 20230215 |           | 0.0             | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 0.0  | 0.0        | 0.0  | 125.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      | 500.0         | 0        | 0.0  | 0         | 500.0 | 0.0  | 0          | 0    | 500.0       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20230101  | Disbursement     | 500.0  | 0.0       | 0.0      | 0.0  | 0.0       | 500.0        | false    |
      | 20230101  | Down Payment     | 125.0  | 125.0     | 0.0      | 0.0  | 0.0       | 375.0        | true     |
    When Admin sets the business date to "20230116"
    And Customer makes "AUTOPAY" repayment on "20230116" with 125 EUR transaction amount
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late  | Outstanding |
      |    |      | 20230101  |                 | 500.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |       |             |
      | 1  | 0    | 20230101  | 20230116 | 375.0           | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 125.0 | 0.0        | 125.0 | 0.0         |
      | 2  | 15   | 20230116  |                 | 250.0           | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 0.0   | 0.0        | 0.0   | 125.0       |
      | 3  | 15   | 20230131  |                 | 125.0           | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 0.0   | 0.0        | 0.0   | 125.0       |
      | 4  | 15   | 20230215 |                 | 0.0             | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 0.0   | 0.0        | 0.0   | 125.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late  | Outstanding |
      | 500.0         | 0        | 0.0  | 0         | 500.0 | 125.0 | 0          | 125.0 | 375.0       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20230101  | Disbursement     | 500.0  | 0.0       | 0.0      | 0.0  | 0.0       | 500.0        | false    |
      | 20230101  | Down Payment     | 125.0  | 125.0     | 0.0      | 0.0  | 0.0       | 375.0        | true     |
      | 20230116  | Repayment        | 125.0  | 125.0     | 0.0      | 0.0  | 0.0       | 375.0        | false    |
    When Customer undo "1"th transaction made on "20230116"
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20230101  |           | 500.0           |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 0    | 20230101  |           | 375.0           | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 0.0  | 0.0        | 0.0  | 125.0       |
      | 2  | 15   | 20230116  |           | 250.0           | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 0.0  | 0.0        | 0.0  | 125.0       |
      | 3  | 15   | 20230131  |           | 125.0           | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 0.0  | 0.0        | 0.0  | 125.0       |
      | 4  | 15   | 20230215 |           | 0.0             | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 0.0  | 0.0        | 0.0  | 125.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      | 500.0         | 0        | 0.0  | 0         | 500.0 | 0.0  | 0          | 0    | 500.0       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20230101  | Disbursement     | 500.0  | 0.0       | 0.0      | 0.0  | 0.0       | 500.0        | false    |
      | 20230101  | Down Payment     | 125.0  | 125.0     | 0.0      | 0.0  | 0.0       | 375.0        | true     |
      | 20230116  | Repayment        | 125.0  | 125.0     | 0.0      | 0.0  | 0.0       | 375.0        | true     |
    When Admin sets the business date to "20230117"
    When Customer makes "MERCHANT_ISSUED_REFUND" transaction with "AUTOPAY" payment type on "20230117" with 300 EUR transaction amount and self-generated Idempotency key
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late  | Outstanding |
      |    |      | 20230101  |                 | 500.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |       |             |
      | 1  | 0    | 20230101  | 20230117 | 375.0           | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 125.0 | 0.0        | 125.0 | 0.0         |
      | 2  | 15   | 20230116  | 20230117 | 250.0           | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 125.0 | 0.0        | 125.0 | 0.0         |
      | 3  | 15   | 20230131  |                 | 125.0           | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 25.0  | 25.0       | 0.0   | 100.0       |
      | 4  | 15   | 20230215 |                 | 0.0             | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 25.0  | 25.0       | 0.0   | 100.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late  | Outstanding |
      | 500.0         | 0        | 0.0  | 0         | 500.0 | 300.0 | 50.0       | 250.0 | 200.0       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type       | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20230101  | Disbursement           | 500.0  | 0.0       | 0.0      | 0.0  | 0.0       | 500.0        | false    |
      | 20230101  | Down Payment           | 125.0  | 125.0     | 0.0      | 0.0  | 0.0       | 375.0        | true     |
      | 20230116  | Repayment              | 125.0  | 125.0     | 0.0      | 0.0  | 0.0       | 375.0        | true     |
      | 20230117  | Merchant Issued Refund | 300.0  | 300.0     | 0.0      | 0.0  | 0.0       | 200.0        | false    |
    When Admin sets the business date to "20230131"
    And Customer makes "AUTOPAY" repayment on "20230131" with 100 EUR transaction amount
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late  | Outstanding |
      |    |      | 20230101  |                 | 500.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |       |             |
      | 1  | 0    | 20230101  | 20230117 | 375.0           | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 125.0 | 0.0        | 125.0 | 0.0         |
      | 2  | 15   | 20230116  | 20230117 | 250.0           | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 125.0 | 0.0        | 125.0 | 0.0         |
      | 3  | 15   | 20230131  | 20230131 | 125.0           | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 125.0 | 25.0       | 0.0   | 0.0         |
      | 4  | 15   | 20230215 |                 | 0.0             | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 25.0  | 25.0       | 0.0   | 100.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late  | Outstanding |
      | 500.0         | 0        | 0.0  | 0         | 500.0 | 400.0 | 50.0       | 250.0 | 100.0       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type       | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20230101  | Disbursement           | 500.0  | 0.0       | 0.0      | 0.0  | 0.0       | 500.0        | false    |
      | 20230101  | Down Payment           | 125.0  | 125.0     | 0.0      | 0.0  | 0.0       | 375.0        | true     |
      | 20230116  | Repayment              | 125.0  | 125.0     | 0.0      | 0.0  | 0.0       | 375.0        | true     |
      | 20230117  | Merchant Issued Refund | 300.0  | 300.0     | 0.0      | 0.0  | 0.0       | 200.0        | false    |
      | 20230131  | Repayment              | 100.0  | 100.0     | 0.0      | 0.0  | 0.0       | 100.0        | false    |
    When Admin sets the business date to "20230215"
    And Customer makes "AUTOPAY" repayment on "20230215" with 100 EUR transaction amount
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late  | Outstanding |
      |    |      | 20230101  |                  | 500.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |       |             |
      | 1  | 0    | 20230101  | 20230117  | 375.0           | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 125.0 | 0.0        | 125.0 | 0.0         |
      | 2  | 15   | 20230116  | 20230117  | 250.0           | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 125.0 | 0.0        | 125.0 | 0.0         |
      | 3  | 15   | 20230131  | 20230131  | 125.0           | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 125.0 | 25.0       | 0.0   | 0.0         |
      | 4  | 15   | 20230215 | 20230215 | 0.0             | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 125.0 | 25.0       | 0.0   | 0.0         |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late  | Outstanding |
      | 500.0         | 0        | 0.0  | 0         | 500.0 | 500.0 | 50.0       | 250.0 | 0.0         |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type       | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20230101  | Disbursement           | 500.0  | 0.0       | 0.0      | 0.0  | 0.0       | 500.0        | false    |
      | 20230101  | Down Payment           | 125.0  | 125.0     | 0.0      | 0.0  | 0.0       | 375.0        | true     |
      | 20230116  | Repayment              | 125.0  | 125.0     | 0.0      | 0.0  | 0.0       | 375.0        | true     |
      | 20230117  | Merchant Issued Refund | 300.0  | 300.0     | 0.0      | 0.0  | 0.0       | 200.0        | false    |
      | 20230131  | Repayment              | 100.0  | 100.0     | 0.0      | 0.0  | 0.0       | 100.0        | false    |
      | 20230215 | Repayment              | 100.0  | 100.0     | 0.0      | 0.0  | 0.0       | 0.0          | false    |
    Then Loan status has changed to "Closed (obligations met)"

  @TestRailId:C2849 @AdvancedPaymentAllocation
  Scenario: As an admin I would like to verify that full refund with CBR (UC17)
    When Admin set "LP2_DOWNPAYMENT_AUTO_ADVANCED_PAYMENT_ALLOCATION" loan product "DEFAULT" transaction type to "NEXT_INSTALLMENT" future installment allocation rule
    When Admin sets the business date to "20230101"
    And Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                      | submitted on date | with Principal | ANNUAL interest rate % | interest type | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_DOWNPAYMENT_AUTO_ADVANCED_PAYMENT_ALLOCATION | 20230101   | 500            | 0                      | FLAT          | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 45                | DAYS                  | 15             | DAYS                   | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20230101" with "500" amount and expected disbursement date on "20230101"
    Then Loan status has changed to "Approved"
    And Admin successfully disburse the loan on "20230101" with "500" EUR transaction amount
    Then Loan status has changed to "Active"
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20230101  |                 | 500.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 0    | 20230101  | 20230101 | 375.0           | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 125.0 | 0.0        | 0.0  | 0.0         |
      | 2  | 15   | 20230116  |                 | 250.0           | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 0.0   | 0.0        | 0.0  | 125.0       |
      | 3  | 15   | 20230131  |                 | 125.0           | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 0.0   | 0.0        | 0.0  | 125.0       |
      | 4  | 15   | 20230215 |                 | 0.0             | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 0.0   | 0.0        | 0.0  | 125.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      | 500.0         | 0        | 0.0  | 0         | 500.0 | 125.0 | 0          | 0    | 375.0       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20230101  | Disbursement     | 500.0  | 0.0       | 0.0      | 0.0  | 0.0       | 500.0        |
      | 20230101  | Down Payment     | 125.0  | 125.0     | 0.0      | 0.0  | 0.0       | 375.0        |
    When Admin sets the business date to "20230108"
    When Customer makes "MERCHANT_ISSUED_REFUND" transaction with "AUTOPAY" payment type on "20230108" with 500 EUR transaction amount and self-generated Idempotency key
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20230101  |                 | 500.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 0    | 20230101  | 20230101 | 375.0           | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 125.0 | 0.0        | 0.0  | 0.0         |
      | 2  | 15   | 20230116  | 20230108 | 250.0           | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 125.0 | 125.0      | 0.0  | 0.0         |
      | 3  | 15   | 20230131  | 20230108 | 125.0           | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 125.0 | 125.0      | 0.0  | 0.0         |
      | 4  | 15   | 20230215 | 20230108 | 0.0             | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 125.0 | 125.0      | 0.0  | 0.0         |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      | 500.0         | 0        | 0.0  | 0         | 500.0 | 500.0 | 375.0      | 0    | 0.0         |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type       | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Overpayment |
      | 20230101  | Disbursement           | 500.0  | 0.0       | 0.0      | 0.0  | 0.0       | 500.0        | 0.0         |
      | 20230101  | Down Payment           | 125.0  | 125.0     | 0.0      | 0.0  | 0.0       | 375.0        | 0.0         |
      | 20230108  | Merchant Issued Refund | 500.0  | 375.0     | 0.0      | 0.0  | 0.0       | 0.0          | 125.0       |
    Then Loan status has changed to "Overpaid"
    When Admin sets the business date to "20230109"
    When Admin makes Credit Balance Refund transaction on "20230109" with 125 EUR transaction amount
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20230101  |                 | 500.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 0    | 20230101  | 20230101 | 375.0           | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 125.0 | 0.0        | 0.0  | 0.0         |
      | 2  | 15   | 20230116  | 20230108 | 250.0           | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 125.0 | 125.0      | 0.0  | 0.0         |
      | 3  | 15   | 20230131  | 20230108 | 125.0           | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 125.0 | 125.0      | 0.0  | 0.0         |
      | 4  | 15   | 20230215 | 20230108 | 0.0             | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 125.0 | 125.0      | 0.0  | 0.0         |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      | 500.0         | 0        | 0.0  | 0         | 500.0 | 500.0 | 375.0      | 0    | 0.0         |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type       | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20230101  | Disbursement           | 500.0  | 0.0       | 0.0      | 0.0  | 0.0       | 500.0        |
      | 20230101  | Down Payment           | 125.0  | 125.0     | 0.0      | 0.0  | 0.0       | 375.0        |
      | 20230108  | Merchant Issued Refund | 500.0  | 375.0     | 0.0      | 0.0  | 0.0       | 0.0          |
      | 20230109  | Credit Balance Refund  | 125.0  | 0.0       | 0.0      | 0.0  | 0.0       | 0.0          |
    Then Loan status has changed to "Closed (obligations met)"

  @TestRailId:C2850 @AdvancedPaymentAllocation
  Scenario: As an admin I would like to verify that reverse-replay works with advanced payment allocation(UC24)
    When Admin set "LP2_DOWNPAYMENT_AUTO_ADVANCED_PAYMENT_ALLOCATION" loan product "DEFAULT" transaction type to "NEXT_INSTALLMENT" future installment allocation rule
    When Admin sets the business date to "20230101"
    And Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                      | submitted on date | with Principal | ANNUAL interest rate % | interest type | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_DOWNPAYMENT_AUTO_ADVANCED_PAYMENT_ALLOCATION | 20230101   | 500            | 0                      | FLAT          | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 45                | DAYS                  | 15             | DAYS                   | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20230101" with "500" amount and expected disbursement date on "20230101"
    Then Loan status has changed to "Approved"
    And Admin successfully disburse the loan on "20230101" with "500" EUR transaction amount
    Then Loan status has changed to "Active"
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20230101  |                 | 500.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 0    | 20230101  | 20230101 | 375.0           | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 125.0 | 0.0        | 0.0  | 0.0         |
      | 2  | 15   | 20230116  |                 | 250.0           | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 0.0   | 0.0        | 0.0  | 125.0       |
      | 3  | 15   | 20230131  |                 | 125.0           | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 0.0   | 0.0        | 0.0  | 125.0       |
      | 4  | 15   | 20230215 |                 | 0.0             | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 0.0   | 0.0        | 0.0  | 125.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      | 500.0         | 0        | 0.0  | 0         | 500.0 | 125.0 | 0          | 0    | 375.0       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20230101  | Disbursement     | 500.0  | 0.0       | 0.0      | 0.0  | 0.0       | 500.0        |
      | 20230101  | Down Payment     | 125.0  | 125.0     | 0.0      | 0.0  | 0.0       | 375.0        |
    When Customer undo "2"th transaction made on "20230101"
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20230101  |           | 500.0           |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 0    | 20230101  |           | 375.0           | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 0.0  | 0.0        | 0.0  | 125.0       |
      | 2  | 15   | 20230116  |           | 250.0           | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 0.0  | 0.0        | 0.0  | 125.0       |
      | 3  | 15   | 20230131  |           | 125.0           | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 0.0  | 0.0        | 0.0  | 125.0       |
      | 4  | 15   | 20230215 |           | 0.0             | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 0.0  | 0.0        | 0.0  | 125.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      | 500.0         | 0        | 0.0  | 0         | 500.0 | 0.0  | 0          | 0    | 500.0       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20230101  | Disbursement     | 500.0  | 0.0       | 0.0      | 0.0  | 0.0       | 500.0        | false    |
      | 20230101  | Down Payment     | 125.0  | 125.0     | 0.0      | 0.0  | 0.0       | 375.0        | true     |
    When Admin sets the business date to "20230102"
    When Customer makes "MERCHANT_ISSUED_REFUND" transaction with "AUTOPAY" payment type on "20230102" with 400 EUR transaction amount and self-generated Idempotency key
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late  | Outstanding |
      |    |      | 20230101  |                 | 500.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |       |             |
      | 1  | 0    | 20230101  | 20230102 | 375.0           | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 125.0 | 0.0        | 125.0 | 0.0         |
      | 2  | 15   | 20230116  |                 | 250.0           | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 91.67 | 91.67      | 0.0   | 33.33       |
      | 3  | 15   | 20230131  |                 | 125.0           | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 91.67 | 91.67      | 0.0   | 33.33       |
      | 4  | 15   | 20230215 |                 | 0.0             | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 91.66 | 91.66      | 0.0   | 33.34       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late  | Outstanding |
      | 500.0         | 0        | 0.0  | 0         | 500.0 | 400.0 | 275.0      | 125.0 | 100.0       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type       | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20230101  | Disbursement           | 500.0  | 0.0       | 0.0      | 0.0  | 0.0       | 500.0        |
      | 20230101  | Down Payment           | 125.0  | 125.0     | 0.0      | 0.0  | 0.0       | 375.0        |
      | 20230102  | Merchant Issued Refund | 400.0  | 400.0     | 0.0      | 0.0  | 0.0       | 100.0        |
    When Admin sets the business date to "20230104"
    And Customer makes "AUTOPAY" repayment on "20230104" with 50 EUR transaction amount
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid   | In advance | Late  | Outstanding |
      |    |      | 20230101  |                 | 500.0           |               |          | 0.0  |           | 0.0   | 0.0    |            |       |             |
      | 1  | 0    | 20230101  | 20230102 | 375.0           | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 125.0  | 0.0        | 125.0 | 0.0         |
      | 2  | 15   | 20230116  | 20230104 | 250.0           | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 125.0  | 125.0      | 0.0   | 0.0         |
      | 3  | 15   | 20230131  |                 | 125.0           | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 108.34 | 108.34     | 0.0   | 16.66       |
      | 4  | 15   | 20230215 |                 | 0.0             | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 91.66  | 91.66      | 0.0   | 33.34       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late  | Outstanding |
      | 500.0         | 0        | 0.0  | 0         | 500.0 | 450.0 | 325.0      | 125.0 | 50.0        |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type       | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20230101  | Disbursement           | 500.0  | 0.0       | 0.0      | 0.0  | 0.0       | 500.0        |
      | 20230101  | Down Payment           | 125.0  | 125.0     | 0.0      | 0.0  | 0.0       | 375.0        |
      | 20230102  | Merchant Issued Refund | 400.0  | 400.0     | 0.0      | 0.0  | 0.0       | 100.0        |
      | 20230104  | Repayment              | 50.0   | 50.0      | 0.0      | 0.0  | 0.0       | 50.0         |
    When Admin sets the business date to "20230116"
    And Customer makes "AUTOPAY" repayment on "20230116" with 125 EUR transaction amount
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late  | Outstanding |
      |    |      | 20230101  |                 | 500.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |       |             |
      | 1  | 0    | 20230101  | 20230102 | 375.0           | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 125.0 | 0.0        | 125.0 | 0.0         |
      | 2  | 15   | 20230116  | 20230104 | 250.0           | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 125.0 | 125.0      | 0.0   | 0.0         |
      | 3  | 15   | 20230131  | 20230116 | 125.0           | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 125.0 | 125.0      | 0.0   | 0.0         |
      | 4  | 15   | 20230215 | 20230116 | 0.0             | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 125.0 | 125.0      | 0.0   | 0.0         |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late  | Outstanding |
      | 500.0         | 0        | 0.0  | 0         | 500.0 | 500.0 | 375.0      | 125.0 | 0.0         |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type       | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Overpayment | Reverted |
      | 20230101  | Disbursement           | 500.0  | 0.0       | 0.0      | 0.0  | 0.0       | 500.0        | 0.0         | false    |
      | 20230101  | Down Payment           | 125.0  | 125.0     | 0.0      | 0.0  | 0.0       | 375.0        | 0.0         | true     |
      | 20230102  | Merchant Issued Refund | 400.0  | 400.0     | 0.0      | 0.0  | 0.0       | 100.0        | 0.0         | false    |
      | 20230104  | Repayment              | 50.0   | 50.0      | 0.0      | 0.0  | 0.0       | 50.0         | 0.0         | false    |
      | 20230116  | Repayment              | 125.0  | 50.0      | 0.0      | 0.0  | 0.0       | 0.0          | 75.0        | false    |
    Then Loan status has changed to "Overpaid"
    When Admin sets the business date to "20230118"
    When Admin makes Credit Balance Refund transaction on "20230118" with 75 EUR transaction amount
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late  | Outstanding |
      |    |      | 20230101  |                 | 500.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |       |             |
      | 1  | 0    | 20230101  | 20230102 | 375.0           | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 125.0 | 0.0        | 125.0 | 0.0         |
      | 2  | 15   | 20230116  | 20230104 | 250.0           | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 125.0 | 125.0      | 0.0   | 0.0         |
      | 3  | 15   | 20230131  | 20230116 | 125.0           | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 125.0 | 125.0      | 0.0   | 0.0         |
      | 4  | 15   | 20230215 | 20230116 | 0.0             | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 125.0 | 125.0      | 0.0   | 0.0         |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late  | Outstanding |
      | 500.0         | 0        | 0.0  | 0         | 500.0 | 500.0 | 375.0      | 125.0 | 0.0         |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type       | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Overpayment | Reverted |
      | 20230101  | Disbursement           | 500.0  | 0.0       | 0.0      | 0.0  | 0.0       | 500.0        | 0.0         | false    |
      | 20230101  | Down Payment           | 125.0  | 125.0     | 0.0      | 0.0  | 0.0       | 375.0        | 0.0         | true     |
      | 20230102  | Merchant Issued Refund | 400.0  | 400.0     | 0.0      | 0.0  | 0.0       | 100.0        | 0.0         | false    |
      | 20230104  | Repayment              | 50.0   | 50.0      | 0.0      | 0.0  | 0.0       | 50.0         | 0.0         | false    |
      | 20230116  | Repayment              | 125.0  | 50.0      | 0.0      | 0.0  | 0.0       | 0.0          | 75.0        | false    |
      | 20230118  | Credit Balance Refund  | 75.0   | 0.0       | 0.0      | 0.0  | 0.0       | 0.0          | 75.0        | false    |
    Then Loan status has changed to "Closed (obligations met)"
    When Admin sets the business date to "20230120"
    When Customer undo "1"th transaction made on "20230102"
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late  | Outstanding |
      |    |      | 20230101  |                 | 500.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |       |             |
      | 1  | 0    | 20230101  | 20230116 | 375.0           | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 125.0 | 0.0        | 125.0 | 0.0         |
      | 2  | 15   | 20230116  |                 | 250.0           | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 50.0  | 0.0        | 0.0   | 75.0        |
      | 3  | 15   | 20230131  |                 | 125.0           | 200.0         | 0.0      | 0.0  | 0.0       | 200.0 | 0.0   | 0.0        | 0.0   | 200.0       |
      | 4  | 15   | 20230215 |                 | 0.0             | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 0.0   | 0.0        | 0.0   | 125.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late  | Outstanding |
      | 575.0         | 0        | 0.0  | 0         | 575.0 | 175.0 | 0.0        | 125.0 | 400.0       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type       | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Overpayment | Reverted |
      | 20230101  | Disbursement           | 500.0  | 0.0       | 0.0      | 0.0  | 0.0       | 500.0        | 0.0         | false    |
      | 20230101  | Down Payment           | 125.0  | 125.0     | 0.0      | 0.0  | 0.0       | 375.0        | 0.0         | true     |
      | 20230102  | Merchant Issued Refund | 400.0  | 400.0     | 0.0      | 0.0  | 0.0       | 100.0        | 0.0         | true     |
      | 20230104  | Repayment              | 50.0   | 50.0      | 0.0      | 0.0  | 0.0       | 450.0        | 0.0         | false    |
      | 20230116  | Repayment              | 125.0  | 125.0     | 0.0      | 0.0  | 0.0       | 325.0        | 0.0         | false    |
      | 20230118  | Credit Balance Refund  | 75.0   | 75.0      | 0.0      | 0.0  | 0.0       | 400.0        | 0.0         | false    |
    Then Loan status has changed to "Active"
    When Admin sets the business date to "20230131"
    And Customer makes "AUTOPAY" repayment on "20230131" with 275 EUR transaction amount
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late  | Outstanding |
      |    |      | 20230101  |                 | 500.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |       |             |
      | 1  | 0    | 20230101  | 20230116 | 375.0           | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 125.0 | 0.0        | 125.0 | 0.0         |
      | 2  | 15   | 20230116  | 20230131 | 250.0           | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 125.0 | 0.0        | 75.0  | 0.0         |
      | 3  | 15   | 20230131  | 20230131 | 125.0           | 200.0         | 0.0      | 0.0  | 0.0       | 200.0 | 200.0 | 0.0        | 0.0   | 0.0         |
      | 4  | 15   | 20230215 |                 | 0.0             | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 0.0   | 0.0        | 0.0   | 125.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late  | Outstanding |
      | 575.0         | 0        | 0.0  | 0         | 575.0 | 450.0 | 0.0        | 200.0 | 125.0       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type       | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Overpayment | Reverted |
      | 20230101  | Disbursement           | 500.0  | 0.0       | 0.0      | 0.0  | 0.0       | 500.0        | 0.0         | false    |
      | 20230101  | Down Payment           | 125.0  | 125.0     | 0.0      | 0.0  | 0.0       | 375.0        | 0.0         | true     |
      | 20230102  | Merchant Issued Refund | 400.0  | 400.0     | 0.0      | 0.0  | 0.0       | 100.0        | 0.0         | true     |
      | 20230104  | Repayment              | 50.0   | 50.0      | 0.0      | 0.0  | 0.0       | 450.0        | 0.0         | false    |
      | 20230116  | Repayment              | 125.0  | 125.0     | 0.0      | 0.0  | 0.0       | 325.0        | 0.0         | false    |
      | 20230118  | Credit Balance Refund  | 75.0   | 75.0      | 0.0      | 0.0  | 0.0       | 400.0        | 0.0         | false    |
      | 20230131  | Repayment              | 275.0  | 275.0     | 0.0      | 0.0  | 0.0       | 125.0        | 0.0         | false    |
    When Admin sets the business date to "20230215"
    And Customer makes "AUTOPAY" repayment on "20230215" with 125 EUR transaction amount
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late  | Outstanding |
      |    |      | 20230101  |                  | 500.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |       |             |
      | 1  | 0    | 20230101  | 20230116  | 375.0           | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 125.0 | 0.0        | 125.0 | 0.0         |
      | 2  | 15   | 20230116  | 20230131  | 250.0           | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 125.0 | 0.0        | 75.0  | 0.0         |
      | 3  | 15   | 20230131  | 20230131  | 125.0           | 200.0         | 0.0      | 0.0  | 0.0       | 200.0 | 200.0 | 0.0        | 0.0   | 0.0         |
      | 4  | 15   | 20230215 | 20230215 | 0.0             | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 125.0 | 0.0        | 0.0   | 0.0         |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late  | Outstanding |
      | 575.0         | 0        | 0.0  | 0         | 575.0 | 575.0 | 0.0        | 200.0 | 0.0         |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type       | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Overpayment | Reverted |
      | 20230101  | Disbursement           | 500.0  | 0.0       | 0.0      | 0.0  | 0.0       | 500.0        | 0.0         | false    |
      | 20230101  | Down Payment           | 125.0  | 125.0     | 0.0      | 0.0  | 0.0       | 375.0        | 0.0         | true     |
      | 20230102  | Merchant Issued Refund | 400.0  | 400.0     | 0.0      | 0.0  | 0.0       | 100.0        | 0.0         | true     |
      | 20230104  | Repayment              | 50.0   | 50.0      | 0.0      | 0.0  | 0.0       | 450.0        | 0.0         | false    |
      | 20230116  | Repayment              | 125.0  | 125.0     | 0.0      | 0.0  | 0.0       | 325.0        | 0.0         | false    |
      | 20230118  | Credit Balance Refund  | 75.0   | 75.0      | 0.0      | 0.0  | 0.0       | 400.0        | 0.0         | false    |
      | 20230131  | Repayment              | 275.0  | 275.0     | 0.0      | 0.0  | 0.0       | 125.0        | 0.0         | false    |
      | 20230215 | Repayment              | 125.0  | 125.0     | 0.0      | 0.0  | 0.0       | 0.0          | 0.0         | false    |
    Then Loan status has changed to "Closed (obligations met)"

  @TestRailId:C2851 @AdvancedPaymentAllocation
  Scenario: As an admin I would like to verify that reamortization works with uneven balances with advanced payment allocation(UC25)
    When Admin set "LP2_DOWNPAYMENT_AUTO_ADVANCED_PAYMENT_ALLOCATION" loan product "DEFAULT" transaction type to "NEXT_INSTALLMENT" future installment allocation rule
    When Admin sets the business date to "20230101"
    And Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                      | submitted on date | with Principal | ANNUAL interest rate % | interest type | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_DOWNPAYMENT_AUTO_ADVANCED_PAYMENT_ALLOCATION | 20230101   | 500            | 0                      | FLAT          | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 45                | DAYS                  | 15             | DAYS                   | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20230101" with "500" amount and expected disbursement date on "20230101"
    Then Loan status has changed to "Approved"
    And Admin successfully disburse the loan on "20230101" with "500" EUR transaction amount
    Then Loan status has changed to "Active"
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20230101  |                 | 500.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 0    | 20230101  | 20230101 | 375.0           | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 125.0 | 0.0        | 0.0  | 0.0         |
      | 2  | 15   | 20230116  |                 | 250.0           | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 0.0   | 0.0        | 0.0  | 125.0       |
      | 3  | 15   | 20230131  |                 | 125.0           | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 0.0   | 0.0        | 0.0  | 125.0       |
      | 4  | 15   | 20230215 |                 | 0.0             | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 0.0   | 0.0        | 0.0  | 125.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      | 500.0         | 0        | 0.0  | 0         | 500.0 | 125.0 | 0          | 0    | 375.0       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20230101  | Disbursement     | 500.0  | 0.0       | 0.0      | 0.0  | 0.0       | 500.0        |
      | 20230101  | Down Payment     | 125.0  | 125.0     | 0.0      | 0.0  | 0.0       | 375.0        |
    When Customer undo "2"th transaction made on "20230101"
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20230101  |           | 500.0           |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 0    | 20230101  |           | 375.0           | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 0.0  | 0.0        | 0.0  | 125.0       |
      | 2  | 15   | 20230116  |           | 250.0           | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 0.0  | 0.0        | 0.0  | 125.0       |
      | 3  | 15   | 20230131  |           | 125.0           | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 0.0  | 0.0        | 0.0  | 125.0       |
      | 4  | 15   | 20230215 |           | 0.0             | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 0.0  | 0.0        | 0.0  | 125.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      | 500.0         | 0        | 0.0  | 0         | 500.0 | 0.0  | 0          | 0    | 500.0       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20230101  | Disbursement     | 500.0  | 0.0       | 0.0      | 0.0  | 0.0       | 500.0        | false    |
      | 20230101  | Down Payment     | 125.0  | 125.0     | 0.0      | 0.0  | 0.0       | 375.0        | true     |
    When Admin sets the business date to "20230102"
    When Customer makes "MERCHANT_ISSUED_REFUND" transaction with "AUTOPAY" payment type on "20230102" with 400 EUR transaction amount and self-generated Idempotency key
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late  | Outstanding |
      |    |      | 20230101  |                 | 500.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |       |             |
      | 1  | 0    | 20230101  | 20230102 | 375.0           | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 125.0 | 0.0        | 125.0 | 0.0         |
      | 2  | 15   | 20230116  |                 | 250.0           | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 91.67 | 91.67      | 0.0   | 33.33       |
      | 3  | 15   | 20230131  |                 | 125.0           | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 91.67 | 91.67      | 0.0   | 33.33       |
      | 4  | 15   | 20230215 |                 | 0.0             | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 91.66 | 91.66      | 0.0   | 33.34       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late  | Outstanding |
      | 500.0         | 0        | 0.0  | 0         | 500.0 | 400.0 | 275.0      | 125.0 | 100.0       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type       | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20230101  | Disbursement           | 500.0  | 0.0       | 0.0      | 0.0  | 0.0       | 500.0        | false    |
      | 20230101  | Down Payment           | 125.0  | 125.0     | 0.0      | 0.0  | 0.0       | 375.0        | true     |
      | 20230102  | Merchant Issued Refund | 400.0  | 400.0     | 0.0      | 0.0  | 0.0       | 100.0        | false    |
    When Admin sets the business date to "20230104"
    And Customer makes "AUTOPAY" repayment on "20230104" with 50 EUR transaction amount
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid   | In advance | Late  | Outstanding |
      |    |      | 20230101  |                 | 500.0           |               |          | 0.0  |           | 0.0   | 0.0    |            |       |             |
      | 1  | 0    | 20230101  | 20230102 | 375.0           | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 125.0  | 0.0        | 125.0 | 0.0         |
      | 2  | 15   | 20230116  | 20230104 | 250.0           | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 125.0  | 125.0      | 0.0   | 0.0         |
      | 3  | 15   | 20230131  |                 | 125.0           | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 108.34 | 108.34     | 0.0   | 16.66       |
      | 4  | 15   | 20230215 |                 | 0.0             | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 91.66  | 91.66      | 0.0   | 33.34       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late  | Outstanding |
      | 500.0         | 0        | 0.0  | 0         | 500.0 | 450.0 | 325.0      | 125.0 | 50.0        |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type       | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20230101  | Disbursement           | 500.0  | 0.0       | 0.0      | 0.0  | 0.0       | 500.0        | false    |
      | 20230101  | Down Payment           | 125.0  | 125.0     | 0.0      | 0.0  | 0.0       | 375.0        | true     |
      | 20230102  | Merchant Issued Refund | 400.0  | 400.0     | 0.0      | 0.0  | 0.0       | 100.0        | false    |
      | 20230104  | Repayment              | 50.0   | 50.0      | 0.0      | 0.0  | 0.0       | 50.0         | false    |
    When Admin sets the business date to "20230106"
    When Customer makes "MERCHANT_ISSUED_REFUND" transaction with "AUTOPAY" payment type on "20230106" with 40 EUR transaction amount and self-generated Idempotency key
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late  | Outstanding |
      |    |      | 20230101  |                 | 500.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |       |             |
      | 1  | 0    | 20230101  | 20230102 | 375.0           | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 125.0 | 0.0        | 125.0 | 0.0         |
      | 2  | 15   | 20230116  | 20230104 | 250.0           | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 125.0 | 125.0      | 0.0   | 0.0         |
      | 3  | 15   | 20230131  | 20230106 | 125.0           | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 125.0 | 125.0      | 0.0   | 0.0         |
      | 4  | 15   | 20230215 |                 | 0.0             | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 115.0 | 115.0      | 0.0   | 10.0        |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late  | Outstanding |
      | 500.0         | 0        | 0.0  | 0         | 500.0 | 490.0 | 365.0      | 125.0 | 10.0        |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type       | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20230101  | Disbursement           | 500.0  | 0.0       | 0.0      | 0.0  | 0.0       | 500.0        | false    |
      | 20230101  | Down Payment           | 125.0  | 125.0     | 0.0      | 0.0  | 0.0       | 375.0        | true     |
      | 20230102  | Merchant Issued Refund | 400.0  | 400.0     | 0.0      | 0.0  | 0.0       | 100.0        | false    |
      | 20230104  | Repayment              | 50.0   | 50.0      | 0.0      | 0.0  | 0.0       | 50.0         | false    |
      | 20230106  | Merchant Issued Refund | 40.0   | 40.0      | 0.0      | 0.0  | 0.0       | 10.0         | false    |

  @TestRailId:C2860 @AdvancedPaymentAllocation
  Scenario: Verify advanced payment allocation - future installments: NEXT_INSTALLMENT
    When Admin sets the business date to "20230901"
    And Admin creates a client with random data
    When Admin set "LP2_DOWNPAYMENT_AUTO_ADVANCED_PAYMENT_ALLOCATION" loan product "DEFAULT" transaction type to "NEXT_INSTALLMENT" future installment allocation rule
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                      | submitted on date | with Principal | ANNUAL interest rate % | interest type | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_DOWNPAYMENT_AUTO_ADVANCED_PAYMENT_ALLOCATION | 20230901 | 400            | 0                      | FLAT          | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 45                | DAYS                  | 15             | DAYS                   | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20230901" with "400" amount and expected disbursement date on "20230901"
    And Admin successfully disburse the loan on "20230901" with "400" EUR transaction amount
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date         | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20230901 |                   | 400.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 0    | 20230901 | 20230901 | 300.0           | 100.0         | 0.0      | 0.0  | 0.0       | 100.0 | 100.0 | 0.0        | 0.0  | 0.0         |
      | 2  | 15   | 20230916 |                   | 200.0           | 100.0         | 0.0      | 0.0  | 0.0       | 100.0 | 0.0   | 0.0        | 0.0  | 100.0       |
      | 3  | 15   | 20231001   |                   | 100.0           | 100.0         | 0.0      | 0.0  | 0.0       | 100.0 | 0.0   | 0.0        | 0.0  | 100.0       |
      | 4  | 15   | 20231016   |                   | 0.0             | 100.0         | 0.0      | 0.0  | 0.0       | 100.0 | 0.0   | 0.0        | 0.0  | 100.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      | 400.0         | 0        | 0.0  | 0         | 400.0 | 100.0 | 0.0        | 0.0  | 300.0       |
    Then Loan Transactions tab has the following data:
      | Transaction date  | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20230901 | Disbursement     | 400.0  | 0.0       | 0.0      | 0.0  | 0.0       | 400.0        |
      | 20230901 | Down Payment     | 100.0  | 100.0     | 0.0      | 0.0  | 0.0       | 300.0        |
    When Admin sets the business date to "20230916"
    And Customer makes "AUTOPAY" repayment on "20230916" with 150 EUR transaction amount
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date         | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20230901 |                   | 400.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 0    | 20230901 | 20230901 | 300.0           | 100.0         | 0.0      | 0.0  | 0.0       | 100.0 | 100.0 | 0.0        | 0.0  | 0.0         |
      | 2  | 15   | 20230916 | 20230916 | 200.0           | 100.0         | 0.0      | 0.0  | 0.0       | 100.0 | 100.0 | 0.0        | 0.0  | 0.0         |
      | 3  | 15   | 20231001   |                   | 100.0           | 100.0         | 0.0      | 0.0  | 0.0       | 100.0 | 50.0  | 50.0       | 0.0  | 50.0        |
      | 4  | 15   | 20231016   |                   | 0.0             | 100.0         | 0.0      | 0.0  | 0.0       | 100.0 | 0.0   | 0.0        | 0.0  | 100.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      | 400.0         | 0        | 0.0  | 0         | 400.0 | 250.0 | 50.0       | 0.0  | 150.0       |
    Then Loan Transactions tab has the following data:
      | Transaction date  | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20230901 | Disbursement     | 400.0  | 0.0       | 0.0      | 0.0  | 0.0       | 400.0        |
      | 20230901 | Down Payment     | 100.0  | 100.0     | 0.0      | 0.0  | 0.0       | 300.0        |
      | 20230916 | Repayment        | 150.0  | 150.0     | 0.0      | 0.0  | 0.0       | 150.0        |
    When Admin set "LP2_DOWNPAYMENT_AUTO_ADVANCED_PAYMENT_ALLOCATION" loan product "DEFAULT" transaction type to "NEXT_INSTALLMENT" future installment allocation rule

  @TestRailId:C2861 @AdvancedPaymentAllocation
  Scenario: Verify advanced payment allocation - future installments: LAST_INSTALLMENT, payment on due date
    When Admin sets the business date to "20230901"
    And Admin creates a client with random data
    When Admin set "LP2_DOWNPAYMENT_AUTO_ADVANCED_PAYMENT_ALLOCATION" loan product "DEFAULT" transaction type to "LAST_INSTALLMENT" future installment allocation rule
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                      | submitted on date | with Principal | ANNUAL interest rate % | interest type | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_DOWNPAYMENT_AUTO_ADVANCED_PAYMENT_ALLOCATION | 20230901 | 400            | 0                      | FLAT          | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 45                | DAYS                  | 15             | DAYS                   | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20230901" with "400" amount and expected disbursement date on "20230901"
    And Admin successfully disburse the loan on "20230901" with "400" EUR transaction amount
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date         | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20230901 |                   | 400.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 0    | 20230901 | 20230901 | 300.0           | 100.0         | 0.0      | 0.0  | 0.0       | 100.0 | 100.0 | 0.0        | 0.0  | 0.0         |
      | 2  | 15   | 20230916 |                   | 200.0           | 100.0         | 0.0      | 0.0  | 0.0       | 100.0 | 0.0   | 0.0        | 0.0  | 100.0       |
      | 3  | 15   | 20231001   |                   | 100.0           | 100.0         | 0.0      | 0.0  | 0.0       | 100.0 | 0.0   | 0.0        | 0.0  | 100.0       |
      | 4  | 15   | 20231016   |                   | 0.0             | 100.0         | 0.0      | 0.0  | 0.0       | 100.0 | 0.0   | 0.0        | 0.0  | 100.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      | 400.0         | 0        | 0.0  | 0         | 400.0 | 100.0 | 0.0        | 0.0  | 300.0       |
    Then Loan Transactions tab has the following data:
      | Transaction date  | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20230901 | Disbursement     | 400.0  | 0.0       | 0.0      | 0.0  | 0.0       | 400.0        |
      | 20230901 | Down Payment     | 100.0  | 100.0     | 0.0      | 0.0  | 0.0       | 300.0        |
    When Admin sets the business date to "20230916"
    And Customer makes "AUTOPAY" repayment on "20230916" with 150 EUR transaction amount
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date         | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20230901 |                   | 400.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 0    | 20230901 | 20230901 | 300.0           | 100.0         | 0.0      | 0.0  | 0.0       | 100.0 | 100.0 | 0.0        | 0.0  | 0.0         |
      | 2  | 15   | 20230916 | 20230916 | 200.0           | 100.0         | 0.0      | 0.0  | 0.0       | 100.0 | 100.0 | 0.0        | 0.0  | 0.0         |
      | 3  | 15   | 20231001   |                   | 100.0           | 100.0         | 0.0      | 0.0  | 0.0       | 100.0 | 0.0   | 0.0        | 0.0  | 100.0       |
      | 4  | 15   | 20231016   |                   | 0.0             | 100.0         | 0.0      | 0.0  | 0.0       | 100.0 | 50.0  | 50.0       | 0.0  | 50.0        |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      | 400.0         | 0        | 0.0  | 0         | 400.0 | 250.0 | 50.0       | 0.0  | 150.0       |
    Then Loan Transactions tab has the following data:
      | Transaction date  | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20230901 | Disbursement     | 400.0  | 0.0       | 0.0      | 0.0  | 0.0       | 400.0        |
      | 20230901 | Down Payment     | 100.0  | 100.0     | 0.0      | 0.0  | 0.0       | 300.0        |
      | 20230916 | Repayment        | 150.0  | 150.0     | 0.0      | 0.0  | 0.0       | 150.0        |
    When Admin set "LP2_DOWNPAYMENT_AUTO_ADVANCED_PAYMENT_ALLOCATION" loan product "DEFAULT" transaction type to "NEXT_INSTALLMENT" future installment allocation rule

  @TestRailId:C2862 @AdvancedPaymentAllocation
  Scenario: Verify advanced payment allocation - future installments: LAST_INSTALLMENT, payment before due date
    When Admin sets the business date to "20230901"
    And Admin creates a client with random data
    When Admin set "LP2_DOWNPAYMENT_AUTO_ADVANCED_PAYMENT_ALLOCATION" loan product "DEFAULT" transaction type to "LAST_INSTALLMENT" future installment allocation rule
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                      | submitted on date | with Principal | ANNUAL interest rate % | interest type | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_DOWNPAYMENT_AUTO_ADVANCED_PAYMENT_ALLOCATION | 20230901 | 400            | 0                      | FLAT          | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 45                | DAYS                  | 15             | DAYS                   | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20230901" with "400" amount and expected disbursement date on "20230901"
    And Admin successfully disburse the loan on "20230901" with "400" EUR transaction amount
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date         | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20230901 |                   | 400.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 0    | 20230901 | 20230901 | 300.0           | 100.0         | 0.0      | 0.0  | 0.0       | 100.0 | 100.0 | 0.0        | 0.0  | 0.0         |
      | 2  | 15   | 20230916 |                   | 200.0           | 100.0         | 0.0      | 0.0  | 0.0       | 100.0 | 0.0   | 0.0        | 0.0  | 100.0       |
      | 3  | 15   | 20231001   |                   | 100.0           | 100.0         | 0.0      | 0.0  | 0.0       | 100.0 | 0.0   | 0.0        | 0.0  | 100.0       |
      | 4  | 15   | 20231016   |                   | 0.0             | 100.0         | 0.0      | 0.0  | 0.0       | 100.0 | 0.0   | 0.0        | 0.0  | 100.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      | 400.0         | 0        | 0.0  | 0         | 400.0 | 100.0 | 0.0        | 0.0  | 300.0       |
    Then Loan Transactions tab has the following data:
      | Transaction date  | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20230901 | Disbursement     | 400.0  | 0.0       | 0.0      | 0.0  | 0.0       | 400.0        |
      | 20230901 | Down Payment     | 100.0  | 100.0     | 0.0      | 0.0  | 0.0       | 300.0        |
    When Admin sets the business date to "20230910"
    And Customer makes "AUTOPAY" repayment on "20230910" with 150 EUR transaction amount
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date         | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20230901 |                   | 400.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 0    | 20230901 | 20230901 | 300.0           | 100.0         | 0.0      | 0.0  | 0.0       | 100.0 | 100.0 | 0.0        | 0.0  | 0.0         |
      | 2  | 15   | 20230916 |                   | 200.0           | 100.0         | 0.0      | 0.0  | 0.0       | 100.0 | 0.0   | 0.0        | 0.0  | 100.0       |
      | 3  | 15   | 20231001   |                   | 100.0           | 100.0         | 0.0      | 0.0  | 0.0       | 100.0 | 50.0  | 50.0       | 0.0  | 50.0        |
      | 4  | 15   | 20231016   | 20230910 | 0.0             | 100.0         | 0.0      | 0.0  | 0.0       | 100.0 | 100.0 | 100.0      | 0.0  | 0.0         |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      | 400.0         | 0        | 0.0  | 0         | 400.0 | 250.0 | 150.0      | 0.0  | 150.0       |
    Then Loan Transactions tab has the following data:
      | Transaction date  | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20230901 | Disbursement     | 400.0  | 0.0       | 0.0      | 0.0  | 0.0       | 400.0        |
      | 20230901 | Down Payment     | 100.0  | 100.0     | 0.0      | 0.0  | 0.0       | 300.0        |
      | 20230910 | Repayment        | 150.0  | 150.0     | 0.0      | 0.0  | 0.0       | 150.0        |
    When Admin set "LP2_DOWNPAYMENT_AUTO_ADVANCED_PAYMENT_ALLOCATION" loan product "DEFAULT" transaction type to "NEXT_INSTALLMENT" future installment allocation rule

  @TestRailId:C2863 @AdvancedPaymentAllocation
  Scenario: Verify advanced payment allocation - future installments: REAMORTIZATION, payment on due date
    When Admin sets the business date to "20230901"
    And Admin creates a client with random data
    When Admin set "LP2_DOWNPAYMENT_AUTO_ADVANCED_PAYMENT_ALLOCATION" loan product "DEFAULT" transaction type to "REAMORTIZATION" future installment allocation rule
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                      | submitted on date | with Principal | ANNUAL interest rate % | interest type | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_DOWNPAYMENT_AUTO_ADVANCED_PAYMENT_ALLOCATION | 20230901 | 400            | 0                      | FLAT          | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 45                | DAYS                  | 15             | DAYS                   | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20230901" with "400" amount and expected disbursement date on "20230901"
    And Admin successfully disburse the loan on "20230901" with "400" EUR transaction amount
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date         | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20230901 |                   | 400.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 0    | 20230901 | 20230901 | 300.0           | 100.0         | 0.0      | 0.0  | 0.0       | 100.0 | 100.0 | 0.0        | 0.0  | 0.0         |
      | 2  | 15   | 20230916 |                   | 200.0           | 100.0         | 0.0      | 0.0  | 0.0       | 100.0 | 0.0   | 0.0        | 0.0  | 100.0       |
      | 3  | 15   | 20231001   |                   | 100.0           | 100.0         | 0.0      | 0.0  | 0.0       | 100.0 | 0.0   | 0.0        | 0.0  | 100.0       |
      | 4  | 15   | 20231016   |                   | 0.0             | 100.0         | 0.0      | 0.0  | 0.0       | 100.0 | 0.0   | 0.0        | 0.0  | 100.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      | 400.0         | 0        | 0.0  | 0         | 400.0 | 100.0 | 0.0        | 0.0  | 300.0       |
    Then Loan Transactions tab has the following data:
      | Transaction date  | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20230901 | Disbursement     | 400.0  | 0.0       | 0.0      | 0.0  | 0.0       | 400.0        |
      | 20230901 | Down Payment     | 100.0  | 100.0     | 0.0      | 0.0  | 0.0       | 300.0        |
    When Admin sets the business date to "20230916"
    And Customer makes "AUTOPAY" repayment on "20230916" with 150 EUR transaction amount
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date         | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20230901 |                   | 400.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 0    | 20230901 | 20230901 | 300.0           | 100.0         | 0.0      | 0.0  | 0.0       | 100.0 | 100.0 | 0.0        | 0.0  | 0.0         |
      | 2  | 15   | 20230916 | 20230916 | 200.0           | 100.0         | 0.0      | 0.0  | 0.0       | 100.0 | 100.0 | 0.0        | 0.0  | 0.0         |
      | 3  | 15   | 20231001   |                   | 100.0           | 100.0         | 0.0      | 0.0  | 0.0       | 100.0 | 25.0  | 25.0       | 0.0  | 75.0        |
      | 4  | 15   | 20231016   |                   | 0.0             | 100.0         | 0.0      | 0.0  | 0.0       | 100.0 | 25.0  | 25.0       | 0.0  | 75.0        |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      | 400.0         | 0        | 0.0  | 0         | 400.0 | 250.0 | 50.0       | 0.0  | 150.0       |
    Then Loan Transactions tab has the following data:
      | Transaction date  | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20230901 | Disbursement     | 400.0  | 0.0       | 0.0      | 0.0  | 0.0       | 400.0        |
      | 20230901 | Down Payment     | 100.0  | 100.0     | 0.0      | 0.0  | 0.0       | 300.0        |
      | 20230916 | Repayment        | 150.0  | 150.0     | 0.0      | 0.0  | 0.0       | 150.0        |
    When Admin set "LP2_DOWNPAYMENT_AUTO_ADVANCED_PAYMENT_ALLOCATION" loan product "DEFAULT" transaction type to "NEXT_INSTALLMENT" future installment allocation rule

  @TestRailId:C2864 @AdvancedPaymentAllocation
  Scenario: Verify advanced payment allocation - future installments: REAMORTIZATION, payment before due date
    When Admin sets the business date to "20230901"
    And Admin creates a client with random data
    When Admin set "LP2_DOWNPAYMENT_AUTO_ADVANCED_PAYMENT_ALLOCATION" loan product "DEFAULT" transaction type to "REAMORTIZATION" future installment allocation rule
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                      | submitted on date | with Principal | ANNUAL interest rate % | interest type | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_DOWNPAYMENT_AUTO_ADVANCED_PAYMENT_ALLOCATION | 20230901 | 400            | 0                      | FLAT          | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 45                | DAYS                  | 15             | DAYS                   | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20230901" with "400" amount and expected disbursement date on "20230901"
    And Admin successfully disburse the loan on "20230901" with "400" EUR transaction amount
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date         | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20230901 |                   | 400.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 0    | 20230901 | 20230901 | 300.0           | 100.0         | 0.0      | 0.0  | 0.0       | 100.0 | 100.0 | 0.0        | 0.0  | 0.0         |
      | 2  | 15   | 20230916 |                   | 200.0           | 100.0         | 0.0      | 0.0  | 0.0       | 100.0 | 0.0   | 0.0        | 0.0  | 100.0       |
      | 3  | 15   | 20231001   |                   | 100.0           | 100.0         | 0.0      | 0.0  | 0.0       | 100.0 | 0.0   | 0.0        | 0.0  | 100.0       |
      | 4  | 15   | 20231016   |                   | 0.0             | 100.0         | 0.0      | 0.0  | 0.0       | 100.0 | 0.0   | 0.0        | 0.0  | 100.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      | 400.0         | 0        | 0.0  | 0         | 400.0 | 100.0 | 0.0        | 0.0  | 300.0       |
    Then Loan Transactions tab has the following data:
      | Transaction date  | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20230901 | Disbursement     | 400.0  | 0.0       | 0.0      | 0.0  | 0.0       | 400.0        |
      | 20230901 | Down Payment     | 100.0  | 100.0     | 0.0      | 0.0  | 0.0       | 300.0        |
    When Admin sets the business date to "20230910"
    And Customer makes "AUTOPAY" repayment on "20230910" with 150 EUR transaction amount
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date         | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20230901 |                   | 400.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 0    | 20230901 | 20230901 | 300.0           | 100.0         | 0.0      | 0.0  | 0.0       | 100.0 | 100.0 | 0.0        | 0.0  | 0.0         |
      | 2  | 15   | 20230916 |                   | 200.0           | 100.0         | 0.0      | 0.0  | 0.0       | 100.0 | 50.0  | 50.0       | 0.0  | 50.0        |
      | 3  | 15   | 20231001   |                   | 100.0           | 100.0         | 0.0      | 0.0  | 0.0       | 100.0 | 50.0  | 50.0       | 0.0  | 50.0        |
      | 4  | 15   | 20231016   |                   | 0.0             | 100.0         | 0.0      | 0.0  | 0.0       | 100.0 | 50.0  | 50.0       | 0.0  | 50.0        |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      | 400.0         | 0        | 0.0  | 0         | 400.0 | 250.0 | 150.0      | 0.0  | 150.0       |
    Then Loan Transactions tab has the following data:
      | Transaction date  | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20230901 | Disbursement     | 400.0  | 0.0       | 0.0      | 0.0  | 0.0       | 400.0        |
      | 20230901 | Down Payment     | 100.0  | 100.0     | 0.0      | 0.0  | 0.0       | 300.0        |
      | 20230910 | Repayment        | 150.0  | 150.0     | 0.0      | 0.0  | 0.0       | 150.0        |
    When Admin set "LP2_DOWNPAYMENT_AUTO_ADVANCED_PAYMENT_ALLOCATION" loan product "DEFAULT" transaction type to "NEXT_INSTALLMENT" future installment allocation rule

  @TestRailId:C2865 @AdvancedPaymentAllocation
  Scenario: Verify advanced payment allocation - future installments: REAMORTIZATION, partial payment due date, payment before next due date
    When Admin sets the business date to "20230901"
    And Admin creates a client with random data
    When Admin set "LP2_DOWNPAYMENT_AUTO_ADVANCED_PAYMENT_ALLOCATION" loan product "DEFAULT" transaction type to "REAMORTIZATION" future installment allocation rule
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                      | submitted on date | with Principal | ANNUAL interest rate % | interest type | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_DOWNPAYMENT_AUTO_ADVANCED_PAYMENT_ALLOCATION | 20230901 | 400            | 0                      | FLAT          | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 45                | DAYS                  | 15             | DAYS                   | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20230901" with "400" amount and expected disbursement date on "20230901"
    And Admin successfully disburse the loan on "20230901" with "400" EUR transaction amount
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date         | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20230901 |                   | 400.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 0    | 20230901 | 20230901 | 300.0           | 100.0         | 0.0      | 0.0  | 0.0       | 100.0 | 100.0 | 0.0        | 0.0  | 0.0         |
      | 2  | 15   | 20230916 |                   | 200.0           | 100.0         | 0.0      | 0.0  | 0.0       | 100.0 | 0.0   | 0.0        | 0.0  | 100.0       |
      | 3  | 15   | 20231001   |                   | 100.0           | 100.0         | 0.0      | 0.0  | 0.0       | 100.0 | 0.0   | 0.0        | 0.0  | 100.0       |
      | 4  | 15   | 20231016   |                   | 0.0             | 100.0         | 0.0      | 0.0  | 0.0       | 100.0 | 0.0   | 0.0        | 0.0  | 100.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      | 400.0         | 0        | 0.0  | 0         | 400.0 | 100.0 | 0.0        | 0.0  | 300.0       |
    Then Loan Transactions tab has the following data:
      | Transaction date  | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20230901 | Disbursement     | 400.0  | 0.0       | 0.0      | 0.0  | 0.0       | 400.0        |
      | 20230901 | Down Payment     | 100.0  | 100.0     | 0.0      | 0.0  | 0.0       | 300.0        |
    When Admin sets the business date to "20230916"
    And Customer makes "AUTOPAY" repayment on "20230916" with 80 EUR transaction amount
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date         | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20230901 |                   | 400.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 0    | 20230901 | 20230901 | 300.0           | 100.0         | 0.0      | 0.0  | 0.0       | 100.0 | 100.0 | 0.0        | 0.0  | 0.0         |
      | 2  | 15   | 20230916 |                   | 200.0           | 100.0         | 0.0      | 0.0  | 0.0       | 100.0 | 80.0  | 0.0        | 0.0  | 20.0        |
      | 3  | 15   | 20231001   |                   | 100.0           | 100.0         | 0.0      | 0.0  | 0.0       | 100.0 | 0.0   | 0.0        | 0.0  | 100.0       |
      | 4  | 15   | 20231016   |                   | 0.0             | 100.0         | 0.0      | 0.0  | 0.0       | 100.0 | 0.0   | 0.0        | 0.0  | 100.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      | 400.0         | 0        | 0.0  | 0         | 400.0 | 180.0 | 0.0        | 0.0  | 220.0       |
    Then Loan Transactions tab has the following data:
      | Transaction date  | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20230901 | Disbursement     | 400.0  | 0.0       | 0.0      | 0.0  | 0.0       | 400.0        |
      | 20230901 | Down Payment     | 100.0  | 100.0     | 0.0      | 0.0  | 0.0       | 300.0        |
      | 20230916 | Repayment        | 80.0   | 80.0      | 0.0      | 0.0  | 0.0       | 220.0        |
    When Admin sets the business date to "20230920"
    And Customer makes "AUTOPAY" repayment on "20230920" with 180 EUR transaction amount
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date         | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20230901 |                   | 400.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 0    | 20230901 | 20230901 | 300.0           | 100.0         | 0.0      | 0.0  | 0.0       | 100.0 | 100.0 | 0.0        | 0.0  | 0.0         |
      | 2  | 15   | 20230916 | 20230920 | 200.0           | 100.0         | 0.0      | 0.0  | 0.0       | 100.0 | 100.0 | 0.0        | 20.0 | 0.0         |
      | 3  | 15   | 20231001   |                   | 100.0           | 100.0         | 0.0      | 0.0  | 0.0       | 100.0 | 80.0  | 80.0       | 0.0  | 20.0        |
      | 4  | 15   | 20231016   |                   | 0.0             | 100.0         | 0.0      | 0.0  | 0.0       | 100.0 | 80.0  | 80.0       | 0.0  | 20.0        |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      | 400.0         | 0        | 0.0  | 0         | 400.0 | 360.0 | 160.0      | 20.0 | 40.0        |
    Then Loan Transactions tab has the following data:
      | Transaction date  | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20230901 | Disbursement     | 400.0  | 0.0       | 0.0      | 0.0  | 0.0       | 400.0        |
      | 20230901 | Down Payment     | 100.0  | 100.0     | 0.0      | 0.0  | 0.0       | 300.0        |
      | 20230916 | Repayment        | 80.0   | 80.0      | 0.0      | 0.0  | 0.0       | 220.0        |
      | 20230920 | Repayment        | 180.0  | 180.0     | 0.0      | 0.0  | 0.0       | 40.0         |
    When Admin set "LP2_DOWNPAYMENT_AUTO_ADVANCED_PAYMENT_ALLOCATION" loan product "DEFAULT" transaction type to "NEXT_INSTALLMENT" future installment allocation rule

  @TestRailId:C2897 @AdvancedPaymentAllocation
  Scenario: Verify advanced payment allocation - future installments: LAST_INSTALLMENT, payment after due date
    When Admin sets the business date to "20230901"
    And Admin creates a client with random data
    When Admin set "LP2_DOWNPAYMENT_AUTO_ADVANCED_PAYMENT_ALLOCATION" loan product "DEFAULT" transaction type to "LAST_INSTALLMENT" future installment allocation rule
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                      | submitted on date | with Principal | ANNUAL interest rate % | interest type | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_DOWNPAYMENT_AUTO_ADVANCED_PAYMENT_ALLOCATION | 20230901 | 400            | 0                      | FLAT          | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 45                | DAYS                  | 15             | DAYS                   | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20230901" with "400" amount and expected disbursement date on "20230901"
    And Admin successfully disburse the loan on "20230901" with "400" EUR transaction amount
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date         | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20230901 |                   | 400.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 0    | 20230901 | 20230901 | 300.0           | 100.0         | 0.0      | 0.0  | 0.0       | 100.0 | 100.0 | 0.0        | 0.0  | 0.0         |
      | 2  | 15   | 20230916 |                   | 200.0           | 100.0         | 0.0      | 0.0  | 0.0       | 100.0 | 0.0   | 0.0        | 0.0  | 100.0       |
      | 3  | 15   | 20231001   |                   | 100.0           | 100.0         | 0.0      | 0.0  | 0.0       | 100.0 | 0.0   | 0.0        | 0.0  | 100.0       |
      | 4  | 15   | 20231016   |                   | 0.0             | 100.0         | 0.0      | 0.0  | 0.0       | 100.0 | 0.0   | 0.0        | 0.0  | 100.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      | 400.0         | 0        | 0.0  | 0         | 400.0 | 100.0 | 0.0        | 0.0  | 300.0       |
    Then Loan Transactions tab has the following data:
      | Transaction date  | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20230901 | Disbursement     | 400.0  | 0.0       | 0.0      | 0.0  | 0.0       | 400.0        |
      | 20230901 | Down Payment     | 100.0  | 100.0     | 0.0      | 0.0  | 0.0       | 300.0        |
    When Admin sets the business date to "20230920"
    And Customer makes "AUTOPAY" repayment on "20230920" with 150 EUR transaction amount
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date         | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late  | Outstanding |
      |    |      | 20230901 |                   | 400.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |       |             |
      | 1  | 0    | 20230901 | 20230901 | 300.0           | 100.0         | 0.0      | 0.0  | 0.0       | 100.0 | 100.0 | 0.0        | 0.0   | 0.0         |
      | 2  | 15   | 20230916 | 20230920 | 200.0           | 100.0         | 0.0      | 0.0  | 0.0       | 100.0 | 100.0 | 0.0        | 100.0 | 0.0         |
      | 3  | 15   | 20231001   |                   | 100.0           | 100.0         | 0.0      | 0.0  | 0.0       | 100.0 | 0.0   | 0.0        | 0.0   | 100.0       |
      | 4  | 15   | 20231016   |                   | 0.0             | 100.0         | 0.0      | 0.0  | 0.0       | 100.0 | 50.0  | 50.0       | 0.0   | 50.0        |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late  | Outstanding |
      | 400.0         | 0        | 0.0  | 0         | 400.0 | 250.0 | 50.0       | 100.0 | 150.0       |
    Then Loan Transactions tab has the following data:
      | Transaction date  | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20230901 | Disbursement     | 400.0  | 0.0       | 0.0      | 0.0  | 0.0       | 400.0        |
      | 20230901 | Down Payment     | 100.0  | 100.0     | 0.0      | 0.0  | 0.0       | 300.0        |
      | 20230920 | Repayment        | 150.0  | 150.0     | 0.0      | 0.0  | 0.0       | 150.0        |
    When Admin set "LP2_DOWNPAYMENT_AUTO_ADVANCED_PAYMENT_ALLOCATION" loan product "DEFAULT" transaction type to "NEXT_INSTALLMENT" future installment allocation rule

  @TestRailId:C2922
  @ProgressiveLoanSchedule
  @AdvancedPaymentAllocation
  Scenario: Verify advanced payment allocation with progressive loan schedule with multi disbursement and with overpaid installment
    When Admin sets the business date to "20230501"
    And Admin creates a client with random data
    When Admin set "LP2_DOWNPAYMENT_ADV_PMT_ALLOC_PROGRESSIVE_LOAN_SCHEDULE_HORIZONTAL" loan product "DEFAULT" transaction type to "NEXT_INSTALLMENT" future installment allocation rule
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                        | submitted on date | with Principal | ANNUAL interest rate % | interest type | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_DOWNPAYMENT_ADV_PMT_ALLOC_PROGRESSIVE_LOAN_SCHEDULE_HORIZONTAL | 20230501       | 1000           | 0                      | FLAT          | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 60                | DAYS                  | 15             | DAYS                   | 4                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20230501" with "1000" amount and expected disbursement date on "20230501"
    And Admin successfully disburse the loan on "20230501" with "1000" EUR transaction amount
    Then Loan Repayment schedule has 5 periods, with the following data for periods:
      | Nr | Days | Date         | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20230501  |           | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 0    | 20230501  |           | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0  | 0.0        | 0.0  | 250.0       |
      | 2  | 15   | 20230516  |           | 562.5           | 187.5         | 0.0      | 0.0  | 0.0       | 187.5 | 0.0  | 0.0        | 0.0  | 187.5       |
      | 3  | 15   | 20230531  |           | 375.0           | 187.5         | 0.0      | 0.0  | 0.0       | 187.5 | 0.0  | 0.0        | 0.0  | 187.5       |
      | 4  | 15   | 20230615 |           | 187.5           | 187.5         | 0.0      | 0.0  | 0.0       | 187.5 | 0.0  | 0.0        | 0.0  | 187.5       |
      | 5  | 15   | 20230630 |           | 0.0             | 187.5         | 0.0      | 0.0  | 0.0       | 187.5 | 0.0  | 0.0        | 0.0  | 187.5       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 1000.0        | 0        | 0.0  | 0         | 1000.0 | 0.0  | 0.0        | 0.0  | 1000.0      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20230501      | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
    When Admin sets the business date to "20230506"
    And Customer makes "AUTOPAY" repayment on "20230506" with 650 EUR transaction amount
    Then Loan Repayment schedule has 5 periods, with the following data for periods:
      | Nr | Days | Date         | Paid date   | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late  | Outstanding |
      |    |      | 20230501  |             | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |       |             |
      | 1  | 0    | 20230501  | 20230506 | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 250.0 | 0.0         |
      | 2  | 15   | 20230516  | 20230506 | 562.5           | 187.5         | 0.0      | 0.0  | 0.0       | 187.5 | 187.5 | 187.5      | 0.0   | 0.0         |
      | 3  | 15   | 20230531  | 20230506 | 375.0           | 187.5         | 0.0      | 0.0  | 0.0       | 187.5 | 187.5 | 187.5      | 0.0   | 0.0         |
      | 4  | 15   | 20230615 |             | 187.5           | 187.5         | 0.0      | 0.0  | 0.0       | 187.5 | 25.0  | 25.0       | 0.0   | 162.5       |
      | 5  | 15   | 20230630 |             | 0.0             | 187.5         | 0.0      | 0.0  | 0.0       | 187.5 | 0.0   | 0.0        | 0.0   | 187.5       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late  | Outstanding |
      | 1000.0        | 0        | 0.0  | 0         | 1000.0 | 650.0 | 400.0      | 250.0 | 350.0       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20230501      | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
      | 20230506      | Repayment        | 650.0  | 650.0     | 0.0      | 0.0  | 0.0       | 350.0        |
    When Admin sets the business date to "20230525"
    And Admin successfully disburse the loan on "20230525" with "250" EUR transaction amount
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date         | Paid date   | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late  | Outstanding |
      |    |      | 20230501  |             | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |       |             |
      | 1  | 0    | 20230501  | 20230506 | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 250.0 | 0.0         |
      | 2  | 15   | 20230516  | 20230506 | 562.5           | 187.5         | 0.0      | 0.0  | 0.0       | 187.5 | 187.5 | 187.5      | 0.0   | 0.0         |
      |    |      | 20230525  |             | 250.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |       |             |
      | 3  | 0    | 20230525  |             | 750.0           | 62.5          | 0.0      | 0.0  | 0.0       | 62.5  | 0.0   | 0.0        | 0.0   | 62.5        |
      | 4  | 15   | 20230531  |             | 500.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 187.5 | 187.5      | 0.0   | 62.5        |
      | 5  | 15   | 20230615 |             | 250.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 25.0  | 25.0       | 0.0   | 225.0       |
      | 6  | 15   | 20230630 |             | 0.0             | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0   | 0.0        | 0.0   | 250.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late  | Outstanding |
      | 1250.0        | 0        | 0.0  | 0         | 1250.0 | 650.0 | 400.0      | 250.0 | 600.0       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20230501      | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
      | 20230506      | Repayment        | 650.0  | 650.0     | 0.0      | 0.0  | 0.0       | 350.0        |
      | 20230525      | Disbursement     | 250.0  | 0.0       | 0.0      | 0.0  | 0.0       | 600.0        |
    When Admin sets the business date to "20230612"
    And Admin successfully disburse the loan on "20230612" with "250" EUR transaction amount
    Then Loan Repayment schedule has 7 periods, with the following data for periods:
      | Nr | Days | Date         | Paid date   | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late  | Outstanding |
      |    |      | 20230501  |             | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0   |            |       |             |
      | 1  | 0    | 20230501  | 20230506 | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0  | 250.0 | 0.0        | 250.0 | 0.0         |
      | 2  | 15   | 20230516  | 20230506 | 562.5           | 187.5         | 0.0      | 0.0  | 0.0       | 187.5  | 187.5 | 187.5      | 0.0   | 0.0         |
      |    |      | 20230525  |             | 250.0           |               |          | 0.0  |           | 0.0    | 0.0   |            |       |             |
      | 3  | 0    | 20230525  |             | 750.0           | 62.5          | 0.0      | 0.0  | 0.0       | 62.5   | 0.0   | 0.0        | 0.0   | 62.5        |
      | 4  | 15   | 20230531  |             | 500.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0  | 187.5 | 187.5      | 0.0   | 62.5        |
      |    |      | 20230612 |             | 250.0           |               |          | 0.0  |           | 0.0    | 0.0   |            |       |             |
      | 5  | 0    | 20230612 |             | 687.5           | 62.5          | 0.0      | 0.0  | 0.0       | 62.5   | 0.0   | 0.0        | 0.0   | 62.5        |
      | 6  | 15   | 20230615 |             | 343.75          | 343.75        | 0.0      | 0.0  | 0.0       | 343.75 | 25.0  | 25.0       | 0.0   | 318.75      |
      | 7  | 15   | 20230630 |             | 0.0             | 343.75        | 0.0      | 0.0  | 0.0       | 343.75 | 0.0   | 0.0        | 0.0   | 343.75      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late  | Outstanding |
      | 1500.0        | 0        | 0.0  | 0         | 1500.0 | 650.0 | 400.0      | 250.0 | 850.0       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20230501      | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
      | 20230506      | Repayment        | 650.0  | 650.0     | 0.0      | 0.0  | 0.0       | 350.0        |
      | 20230525      | Disbursement     | 250.0  | 0.0       | 0.0      | 0.0  | 0.0       | 600.0        |
      | 20230612     | Disbursement     | 250.0  | 0.0       | 0.0      | 0.0  | 0.0       | 850.0        |
    When Admin set "LP2_DOWNPAYMENT_ADV_PMT_ALLOC_PROGRESSIVE_LOAN_SCHEDULE_HORIZONTAL" loan product "DEFAULT" transaction type to "NEXT_INSTALLMENT" future installment allocation rule

  @TestRailId:C2937
  @ProgressiveLoanSchedule
  @AdvancedPaymentAllocation
  Scenario: Verify advanced payment allocation with progressive loan schedule with multi disbursement and reschedule
    When Admin sets the business date to "20230501"
    And Admin creates a client with random data
    When Admin set "LP2_DOWNPAYMENT_ADV_PMT_ALLOC_PROGRESSIVE_LOAN_SCHEDULE_HORIZONTAL" loan product "DEFAULT" transaction type to "NEXT_INSTALLMENT" future installment allocation rule
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                        | submitted on date | with Principal | ANNUAL interest rate % | interest type | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_DOWNPAYMENT_ADV_PMT_ALLOC_PROGRESSIVE_LOAN_SCHEDULE_HORIZONTAL | 20230501       | 1000           | 0                      | FLAT          | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 60                | DAYS                  | 15             | DAYS                   | 4                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20230501" with "1000" amount and expected disbursement date on "20230501"
    And Admin successfully disburse the loan on "20230501" with "1000" EUR transaction amount
    Then Loan Repayment schedule has 5 periods, with the following data for periods:
      | Nr | Days | Date         | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20230501  |           | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 0    | 20230501  |           | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0  | 0.0        | 0.0  | 250.0       |
      | 2  | 15   | 20230516  |           | 562.5           | 187.5         | 0.0      | 0.0  | 0.0       | 187.5 | 0.0  | 0.0        | 0.0  | 187.5       |
      | 3  | 15   | 20230531  |           | 375.0           | 187.5         | 0.0      | 0.0  | 0.0       | 187.5 | 0.0  | 0.0        | 0.0  | 187.5       |
      | 4  | 15   | 20230615 |           | 187.5           | 187.5         | 0.0      | 0.0  | 0.0       | 187.5 | 0.0  | 0.0        | 0.0  | 187.5       |
      | 5  | 15   | 20230630 |           | 0.0             | 187.5         | 0.0      | 0.0  | 0.0       | 187.5 | 0.0  | 0.0        | 0.0  | 187.5       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 1000.0        | 0        | 0.0  | 0         | 1000.0 | 0.0  | 0.0        | 0.0  | 1000.0      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20230501      | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
    When Admin sets the business date to "20230506"
    And Customer makes "AUTOPAY" repayment on "20230506" with 650 EUR transaction amount
    Then Loan Repayment schedule has 5 periods, with the following data for periods:
      | Nr | Days | Date         | Paid date   | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late  | Outstanding |
      |    |      | 20230501  |             | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |       |             |
      | 1  | 0    | 20230501  | 20230506 | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 250.0 | 0.0         |
      | 2  | 15   | 20230516  | 20230506 | 562.5           | 187.5         | 0.0      | 0.0  | 0.0       | 187.5 | 187.5 | 187.5      | 0.0   | 0.0         |
      | 3  | 15   | 20230531  | 20230506 | 375.0           | 187.5         | 0.0      | 0.0  | 0.0       | 187.5 | 187.5 | 187.5      | 0.0   | 0.0         |
      | 4  | 15   | 20230615 |             | 187.5           | 187.5         | 0.0      | 0.0  | 0.0       | 187.5 | 25.0  | 25.0       | 0.0   | 162.5       |
      | 5  | 15   | 20230630 |             | 0.0             | 187.5         | 0.0      | 0.0  | 0.0       | 187.5 | 0.0   | 0.0        | 0.0   | 187.5       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late  | Outstanding |
      | 1000.0        | 0        | 0.0  | 0         | 1000.0 | 650.0 | 400.0      | 250.0 | 350.0       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20230501      | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
      | 20230506      | Repayment        | 650.0  | 650.0     | 0.0      | 0.0  | 0.0       | 350.0        |
    When Admin sets the business date to "20230525"
    When Batch API call with steps: rescheduleLoan from "20230615" to "20230713" submitted on date: "20230525", approveReschedule on date: "20230525" runs with enclosingTransaction: "true"
    And Admin successfully disburse the loan on "20230525" with "250" EUR transaction amount
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date         | Paid date   | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late  | Outstanding |
      |    |      | 20230501  |             | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |       |             |
      | 1  | 0    | 20230501  | 20230506 | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 250.0 | 0.0         |
      | 2  | 15   | 20230516  | 20230506 | 562.5           | 187.5         | 0.0      | 0.0  | 0.0       | 187.5 | 187.5 | 187.5      | 0.0   | 0.0         |
      |    |      | 20230525  |             | 250.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |       |             |
      | 3  | 0    | 20230525  |             | 750.0           | 62.5          | 0.0      | 0.0  | 0.0       | 62.5  | 0.0   | 0.0        | 0.0   | 62.5        |
      | 4  | 15   | 20230531  |             | 500.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 187.5 | 187.5      | 0.0   | 62.5        |
      | 5  | 43   | 20230713 |             | 250.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 25.0  | 25.0       | 0.0   | 225.0       |
      | 6  | 15   | 20230728 |             | 0.0             | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0   | 0.0        | 0.0   | 250.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late  | Outstanding |
      | 1250.0        | 0        | 0.0  | 0         | 1250.0 | 650.0 | 400.0      | 250.0 | 600.0       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20230501      | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
      | 20230506      | Repayment        | 650.0  | 650.0     | 0.0      | 0.0  | 0.0       | 350.0        |
      | 20230525      | Disbursement     | 250.0  | 0.0       | 0.0      | 0.0  | 0.0       | 600.0        |
    When Admin sets the business date to "20230715"
    And Admin successfully disburse the loan on "20230715" with "250" EUR transaction amount
    Then Loan Repayment schedule has 7 periods, with the following data for periods:
      | Nr | Days | Date         | Paid date   | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late  | Outstanding |
      |    |      | 20230501  |             | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |       |             |
      | 1  | 0    | 20230501  | 20230506 | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 250.0 | 0.0         |
      | 2  | 15   | 20230516  | 20230506 | 562.5           | 187.5         | 0.0      | 0.0  | 0.0       | 187.5 | 187.5 | 187.5      | 0.0   | 0.0         |
      |    |      | 20230525  |             | 250.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |       |             |
      | 3  | 0    | 20230525  |             | 750.0           | 62.5          | 0.0      | 0.0  | 0.0       | 62.5  | 0.0   | 0.0        | 0.0   | 62.5        |
      | 4  | 15   | 20230531  |             | 500.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 187.5 | 187.5      | 0.0   | 62.5        |
      | 5  | 43   | 20230713 |             | 250.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 25.0  | 25.0       | 0.0   | 225.0       |
      |    |      | 20230715 |             | 250.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |       |             |
      | 6  | 0    | 20230715 |             | 437.5           | 62.5          | 0.0      | 0.0  | 0.0       | 62.5  | 0.0   | 0.0        | 0.0   | 62.5        |
      | 7  | 15   | 20230728 |             | 0.0             | 437.5         | 0.0      | 0.0  | 0.0       | 437.5 | 0.0   | 0.0        | 0.0   | 437.5       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late  | Outstanding |
      | 1500.0        | 0        | 0.0  | 0         | 1500.0 | 650.0 | 400.0      | 250.0 | 850.0       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20230501      | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
      | 20230506      | Repayment        | 650.0  | 650.0     | 0.0      | 0.0  | 0.0       | 350.0        |
      | 20230525      | Disbursement     | 250.0  | 0.0       | 0.0      | 0.0  | 0.0       | 600.0        |
      | 20230715     | Disbursement     | 250.0  | 0.0       | 0.0      | 0.0  | 0.0       | 850.0        |
    When Batch API call with steps: rescheduleLoan from "20230713" to "20230813" submitted on date: "20230715", approveReschedule on date: "20230715" runs with enclosingTransaction: "true"
    Then Loan Repayment schedule has 7 periods, with the following data for periods:
      | Nr | Days | Date           | Paid date   | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late  | Outstanding |
      |    |      | 20230501    |             | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0   |            |       |             |
      | 1  | 0    | 20230501    | 20230506 | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0  | 250.0 | 0.0        | 250.0 | 0.0         |
      | 2  | 15   | 20230516    | 20230506 | 562.5           | 187.5         | 0.0      | 0.0  | 0.0       | 187.5  | 187.5 | 187.5      | 0.0   | 0.0         |
      |    |      | 20230525    |             | 250.0           |               |          | 0.0  |           | 0.0    | 0.0   |            |       |             |
      | 3  | 0    | 20230525    |             | 750.0           | 62.5          | 0.0      | 0.0  | 0.0       | 62.5   | 0.0   | 0.0        | 0.0   | 62.5        |
      | 4  | 15   | 20230531    |             | 500.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0  | 187.5 | 187.5      | 0.0   | 62.5        |
      |    |      | 20230715   |             | 250.0           |               |          | 0.0  |           | 0.0    | 0.0   |            |       |             |
      | 5  | 0    | 20230715   |             | 687.5           | 62.5          | 0.0      | 0.0  | 0.0       | 62.5   | 0.0   | 0.0        | 0.0   | 62.5        |
      | 6  | 74   | 20230813 |             | 343.75          | 343.75        | 0.0      | 0.0  | 0.0       | 343.75 | 25.0  | 25.0       | 0.0   | 318.75      |
      | 7  | 15   | 20230828 |             | 0.0             | 343.75        | 0.0      | 0.0  | 0.0       | 343.75 | 0.0   | 0.0        | 0.0   | 343.75      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late  | Outstanding |
      | 1500.0        | 0        | 0.0  | 0         | 1500.0 | 650.0 | 400.0      | 250.0 | 850.0       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20230501      | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
      | 20230506      | Repayment        | 650.0  | 650.0     | 0.0      | 0.0  | 0.0       | 350.0        |
      | 20230525      | Disbursement     | 250.0  | 0.0       | 0.0      | 0.0  | 0.0       | 600.0        |
      | 20230715     | Disbursement     | 250.0  | 0.0       | 0.0      | 0.0  | 0.0       | 850.0        |
    When Admin set "LP2_DOWNPAYMENT_ADV_PMT_ALLOC_PROGRESSIVE_LOAN_SCHEDULE_HORIZONTAL" loan product "DEFAULT" transaction type to "NEXT_INSTALLMENT" future installment allocation rule

  @TestRailId:C2940 @AdvancedPaymentAllocation @ProgressiveLoanSchedule
  Scenario: Verify AdvancedPaymentAllocation behaviour: loanScheduleProcessingType-horizontal, charge after maturity, loan fully paid in advance
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
#  Loan got fully paid in advance
    And Customer makes "AUTOPAY" repayment on "20230901" with 1020 EUR transaction amount
    Then Loan status will be "CLOSED_OBLIGATIONS_MET"
    Then Loan has 0 outstanding amount
    Then Loan Repayment schedule has 5 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date         | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20230901 |                   | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 0    | 20230901 | 20230901 | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0  | 0.0         |
      | 2  | 15   | 20230916 | 20230901 | 500.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 250.0      | 0.0  | 0.0         |
      | 3  | 15   | 20231001   | 20230901 | 250.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 250.0      | 0.0  | 0.0         |
      | 4  | 15   | 20231016   | 20230901 | 0.0             | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 250.0      | 0.0  | 0.0         |
      | 5  | 1    | 20231017   | 20230901 | 0.0             | 0.0           | 0.0      | 0.0  | 20.0      | 20.0  | 20.0  | 20.0       | 0.0  | 0.0         |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late | Outstanding |
      | 1000.0        | 0.0      | 0.0  | 20.0      | 1020.0 | 1020.0 | 770.0      | 0.0  | 0.0         |
    Then Loan Transactions tab has the following data:
      | Transaction date  | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20230901 | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
      | 20230901 | Repayment        | 1020.0 | 1000.0    | 0.0      | 0.0  | 20.0      | 0.0          |
      | 20230901 | Accrual          | 20.0   | 0.0       | 0.0      | 0.0  | 20.0      | 0.0          |
    Then Loan Charges tab has the following data:
      | Name    | isPenalty | Payment due at     | Due as of       | Calculation type | Due  | Paid | Waived | Outstanding |
      | NSF fee | true      | Specified due date | 20231017 | Flat             | 20.0 | 20.0 | 0.0    | 0.0         |

  @TestRailId:C2941 @AdvancedPaymentAllocation @ProgressiveLoanSchedule
  Scenario: Verify AdvancedPaymentAllocation behaviour: loanScheduleProcessingType-vertical, charge after maturity, loan fully paid in advance
    When Admin sets the business date to "20230901"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                      | submitted on date | with Principal | ANNUAL interest rate % | interest type | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_DOWNPAYMENT_ADV_PMT_ALLOC_PROGRESSIVE_LOAN_SCHEDULE_VERTICAL | 20230901 | 1000           | 0                      | FLAT          | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 45                | DAYS                  | 15             | DAYS                   | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
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
#  Loan got fully paid in advance
    And Customer makes "AUTOPAY" repayment on "20230901" with 1020 EUR transaction amount
    Then Loan status will be "CLOSED_OBLIGATIONS_MET"
    Then Loan has 0 outstanding amount
    Then Loan Repayment schedule has 5 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date         | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20230901 |                   | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 0    | 20230901 | 20230901 | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0  | 0.0         |
      | 2  | 15   | 20230916 | 20230901 | 500.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 250.0      | 0.0  | 0.0         |
      | 3  | 15   | 20231001   | 20230901 | 250.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 250.0      | 0.0  | 0.0         |
      | 4  | 15   | 20231016   | 20230901 | 0.0             | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 250.0      | 0.0  | 0.0         |
      | 5  | 1    | 20231017   | 20230901 | 0.0             | 0.0           | 0.0      | 0.0  | 20.0      | 20.0  | 20.0  | 20.0       | 0.0  | 0.0         |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late | Outstanding |
      | 1000.0        | 0.0      | 0.0  | 20.0      | 1020.0 | 1020.0 | 770.0      | 0.0  | 0.0         |
    Then Loan Transactions tab has the following data:
      | Transaction date  | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20230901 | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
      | 20230901 | Repayment        | 1020.0 | 1000.0    | 0.0      | 0.0  | 20.0      | 0.0          |
      | 20230901 | Accrual          | 20.0   | 0.0       | 0.0      | 0.0  | 20.0      | 0.0          |
    Then Loan Charges tab has the following data:
      | Name    | isPenalty | Payment due at     | Due as of       | Calculation type | Due  | Paid | Waived | Outstanding |
      | NSF fee | true      | Specified due date | 20231017 | Flat             | 20.0 | 20.0 | 0.0    | 0.0         |

  @TestRailId:C2942 @AdvancedPaymentAllocation @ProgressiveLoanSchedule
  Scenario: Verify AdvancedPaymentAllocation behaviour: loanScheduleProcessingType-horizontal, charge after maturity, loan overpaid in advance
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
#  Loan got overpaid in advance
    And Customer makes "AUTOPAY" repayment on "20230901" with 1120 EUR transaction amount
    Then Loan status will be "OVERPAID"
    Then Loan has 0 outstanding amount
    Then Loan has 100 overpaid amount
    Then Loan Repayment schedule has 5 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date         | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20230901 |                   | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 0    | 20230901 | 20230901 | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0  | 0.0         |
      | 2  | 15   | 20230916 | 20230901 | 500.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 250.0      | 0.0  | 0.0         |
      | 3  | 15   | 20231001   | 20230901 | 250.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 250.0      | 0.0  | 0.0         |
      | 4  | 15   | 20231016   | 20230901 | 0.0             | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 250.0      | 0.0  | 0.0         |
      | 5  | 1    | 20231017   | 20230901 | 0.0             | 0.0           | 0.0      | 0.0  | 20.0      | 20.0  | 20.0  | 20.0       | 0.0  | 0.0         |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late | Outstanding |
      | 1000.0        | 0.0      | 0.0  | 20.0      | 1020.0 | 1020.0 | 770.0      | 0.0  | 0.0         |
    Then Loan Transactions tab has the following data:
      | Transaction date  | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20230901 | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
      | 20230901 | Repayment        | 1120.0 | 1000.0    | 0.0      | 0.0  | 20.0      | 0.0          |
      | 20230901 | Accrual          | 20.0   | 0.0       | 0.0      | 0.0  | 20.0      | 0.0          |
    Then Loan Charges tab has the following data:
      | Name    | isPenalty | Payment due at     | Due as of       | Calculation type | Due  | Paid | Waived | Outstanding |
      | NSF fee | true      | Specified due date | 20231017 | Flat             | 20.0 | 20.0 | 0.0    | 0.0         |

  @TestRailId:C2943 @AdvancedPaymentAllocation @ProgressiveLoanSchedule
  Scenario: Verify AdvancedPaymentAllocation behaviour: loanScheduleProcessingType-vertical, charge after maturity, loan overpaid in advance
    When Admin sets the business date to "20230901"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                      | submitted on date | with Principal | ANNUAL interest rate % | interest type | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_DOWNPAYMENT_ADV_PMT_ALLOC_PROGRESSIVE_LOAN_SCHEDULE_VERTICAL | 20230901 | 1000           | 0                      | FLAT          | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 45                | DAYS                  | 15             | DAYS                   | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
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
#  Loan got overpaid in advance
    And Customer makes "AUTOPAY" repayment on "20230901" with 1120 EUR transaction amount
    Then Loan status will be "OVERPAID"
    Then Loan has 0 outstanding amount
    Then Loan has 100 overpaid amount
    Then Loan Repayment schedule has 5 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date         | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20230901 |                   | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 0    | 20230901 | 20230901 | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0  | 0.0         |
      | 2  | 15   | 20230916 | 20230901 | 500.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 250.0      | 0.0  | 0.0         |
      | 3  | 15   | 20231001   | 20230901 | 250.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 250.0      | 0.0  | 0.0         |
      | 4  | 15   | 20231016   | 20230901 | 0.0             | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 250.0      | 0.0  | 0.0         |
      | 5  | 1    | 20231017   | 20230901 | 0.0             | 0.0           | 0.0      | 0.0  | 20.0      | 20.0  | 20.0  | 20.0       | 0.0  | 0.0         |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late | Outstanding |
      | 1000.0        | 0.0      | 0.0  | 20.0      | 1020.0 | 1020.0 | 770.0      | 0.0  | 0.0         |
    Then Loan Transactions tab has the following data:
      | Transaction date  | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20230901 | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
      | 20230901 | Repayment        | 1120.0 | 1000.0    | 0.0      | 0.0  | 20.0      | 0.0          |
      | 20230901 | Accrual          | 20.0   | 0.0       | 0.0      | 0.0  | 20.0      | 0.0          |
    Then Loan Charges tab has the following data:
      | Name    | isPenalty | Payment due at     | Due as of       | Calculation type | Due  | Paid | Waived | Outstanding |
      | NSF fee | true      | Specified due date | 20231017 | Flat             | 20.0 | 20.0 | 0.0    | 0.0         |

  @TestRailId:C2944 @AdvancedPaymentAllocation @ProgressiveLoanSchedule
  Scenario: Verify AdvancedPaymentAllocation behaviour: loanScheduleProcessingType-horizontal, charge after maturity, in advanced repayment (future installment type: NEXT_INSTALLMENT)
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
    When Admin sets the business date to "20230916"
    And Customer makes "AUTOPAY" repayment on "20230916" with 250 EUR transaction amount
    Then Loan Repayment schedule has 5 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date         | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20230901 |                   | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 0    | 20230901 | 20230901 | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0  | 0.0         |
      | 2  | 15   | 20230916 | 20230916 | 500.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0  | 0.0         |
      | 3  | 15   | 20231001   |                   | 250.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0   | 0.0        | 0.0  | 250.0       |
      | 4  | 15   | 20231016   |                   | 0.0             | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0   | 0.0        | 0.0  | 250.0       |
      | 5  | 1    | 20231017   |                   | 0.0             | 0.0           | 0.0      | 0.0  | 20.0      | 20.0  | 0.0   | 0.0        | 0.0  | 20.0        |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 1000.0        | 0.0      | 0.0  | 20.0      | 1020.0 | 500.0 | 0.0        | 0.0  | 520.0       |
    Then Loan Transactions tab has the following data:
      | Transaction date  | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20230901 | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
      | 20230901 | Repayment        | 250.0  | 250.0     | 0.0      | 0.0  | 0.0       | 750.0        |
      | 20230916 | Repayment        | 250.0  | 250.0     | 0.0      | 0.0  | 0.0       | 500.0        |
    Then Loan Charges tab has the following data:
      | Name    | isPenalty | Payment due at     | Due as of       | Calculation type | Due  | Paid | Waived | Outstanding |
      | NSF fee | true      | Specified due date | 20231017 | Flat             | 20.0 | 0.0  | 0.0    | 20.0        |
#    Make charges for the next installments
    When Admin adds "LOAN_NSF_FEE" due date charge with "20230917" due date and 20 EUR transaction amount
    When Admin adds "LOAN_NSF_FEE" due date charge with "20231016" due date and 20 EUR transaction amount
    Then Loan Repayment schedule has 5 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date         | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20230901 |                   | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 0    | 20230901 | 20230901 | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0  | 0.0         |
      | 2  | 15   | 20230916 | 20230916 | 500.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0  | 0.0         |
      | 3  | 15   | 20231001   |                   | 250.0           | 250.0         | 0.0      | 0.0  | 20.0      | 270.0 | 0.0   | 0.0        | 0.0  | 270.0       |
      | 4  | 15   | 20231016   |                   | 0.0             | 250.0         | 0.0      | 0.0  | 20.0      | 270.0 | 0.0   | 0.0        | 0.0  | 270.0       |
      | 5  | 1    | 20231017   |                   | 0.0             | 0.0           | 0.0      | 0.0  | 20.0      | 20.0  | 0.0   | 0.0        | 0.0  | 20.0        |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 1000.0        | 0.0      | 0.0  | 60.0      | 1060.0 | 500.0 | 0.0        | 0.0  | 560.0       |
    Then Loan Transactions tab has the following data:
      | Transaction date  | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20230901 | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
      | 20230901 | Repayment        | 250.0  | 250.0     | 0.0      | 0.0  | 0.0       | 750.0        |
      | 20230916 | Repayment        | 250.0  | 250.0     | 0.0      | 0.0  | 0.0       | 500.0        |
    Then Loan Charges tab has the following data:
      | Name    | isPenalty | Payment due at     | Due as of         | Calculation type | Due  | Paid | Waived | Outstanding |
      | NSF fee | true      | Specified due date | 20231017   | Flat             | 20.0 | 0.0  | 0.0    | 20.0        |
      | NSF fee | true      | Specified due date | 20231016   | Flat             | 20.0 | 0.0  | 0.0    | 20.0        |
      | NSF fee | true      | Specified due date | 20230917 | Flat             | 20.0 | 0.0  | 0.0    | 20.0        |
#    Make in advance payment (future installment type: NEXT_INSTALLMENT)
    When Admin sets the business date to "20230917"
    And Customer makes "AUTOPAY" repayment on "20230917" with 100 EUR transaction amount
    Then Loan Repayment schedule has 5 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date         | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20230901 |                   | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 0    | 20230901 | 20230901 | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0  | 0.0         |
      | 2  | 15   | 20230916 | 20230916 | 500.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0  | 0.0         |
      | 3  | 15   | 20231001   |                   | 250.0           | 250.0         | 0.0      | 0.0  | 20.0      | 270.0 | 100.0 | 100.0      | 0.0  | 170.0       |
      | 4  | 15   | 20231016   |                   | 0.0             | 250.0         | 0.0      | 0.0  | 20.0      | 270.0 | 0.0   | 0.0        | 0.0  | 270.0       |
      | 5  | 1    | 20231017   |                   | 0.0             | 0.0           | 0.0      | 0.0  | 20.0      | 20.0  | 0.0   | 0.0        | 0.0  | 20.0        |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 1000.0        | 0.0      | 0.0  | 60.0      | 1060.0 | 600.0 | 100.0      | 0.0  | 460.0       |
    Then Loan Transactions tab has the following data:
      | Transaction date  | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20230901 | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
      | 20230901 | Repayment        | 250.0  | 250.0     | 0.0      | 0.0  | 0.0       | 750.0        |
      | 20230916 | Repayment        | 250.0  | 250.0     | 0.0      | 0.0  | 0.0       | 500.0        |
      | 20230917 | Repayment        | 100.0  | 80.0      | 0.0      | 0.0  | 20.0      | 420.0        |
    Then Loan Charges tab has the following data:
      | Name    | isPenalty | Payment due at     | Due as of         | Calculation type | Due  | Paid | Waived | Outstanding |
      | NSF fee | true      | Specified due date | 20231017   | Flat             | 20.0 | 0.0  | 0.0    | 20.0        |
      | NSF fee | true      | Specified due date | 20231016   | Flat             | 20.0 | 0.0  | 0.0    | 20.0        |
      | NSF fee | true      | Specified due date | 20230917 | Flat             | 20.0 | 20.0 | 0.0    | 0.0         |

  @TestRailId:C2945 @AdvancedPaymentAllocation @ProgressiveLoanSchedule
  Scenario: Verify AdvancedPaymentAllocation behaviour: loanScheduleProcessingType-vertical, charge after maturity, in advanced repayment (future installment type: NEXT_INSTALLMENT)
    When Admin sets the business date to "20230901"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                      | submitted on date | with Principal | ANNUAL interest rate % | interest type | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_DOWNPAYMENT_ADV_PMT_ALLOC_PROGRESSIVE_LOAN_SCHEDULE_VERTICAL | 20230901 | 1000           | 0                      | FLAT          | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 45                | DAYS                  | 15             | DAYS                   | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
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
    When Admin sets the business date to "20230916"
    And Customer makes "AUTOPAY" repayment on "20230916" with 250 EUR transaction amount
    Then Loan Repayment schedule has 5 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date         | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20230901 |                   | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 0    | 20230901 | 20230901 | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0  | 0.0         |
      | 2  | 15   | 20230916 | 20230916 | 500.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0  | 0.0         |
      | 3  | 15   | 20231001   |                   | 250.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0   | 0.0        | 0.0  | 250.0       |
      | 4  | 15   | 20231016   |                   | 0.0             | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0   | 0.0        | 0.0  | 250.0       |
      | 5  | 1    | 20231017   |                   | 0.0             | 0.0           | 0.0      | 0.0  | 20.0      | 20.0  | 0.0   | 0.0        | 0.0  | 20.0        |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 1000.0        | 0.0      | 0.0  | 20.0      | 1020.0 | 500.0 | 0.0        | 0.0  | 520.0       |
    Then Loan Transactions tab has the following data:
      | Transaction date  | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20230901 | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
      | 20230901 | Repayment        | 250.0  | 250.0     | 0.0      | 0.0  | 0.0       | 750.0        |
      | 20230916 | Repayment        | 250.0  | 250.0     | 0.0      | 0.0  | 0.0       | 500.0        |
    Then Loan Charges tab has the following data:
      | Name    | isPenalty | Payment due at     | Due as of       | Calculation type | Due  | Paid | Waived | Outstanding |
      | NSF fee | true      | Specified due date | 20231017 | Flat             | 20.0 | 0.0  | 0.0    | 20.0        |
#    Make charges for the next installments
    When Admin adds "LOAN_NSF_FEE" due date charge with "20230917" due date and 20 EUR transaction amount
    When Admin adds "LOAN_NSF_FEE" due date charge with "20231016" due date and 20 EUR transaction amount
    Then Loan Repayment schedule has 5 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date         | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20230901 |                   | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 0    | 20230901 | 20230901 | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0  | 0.0         |
      | 2  | 15   | 20230916 | 20230916 | 500.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0  | 0.0         |
      | 3  | 15   | 20231001   |                   | 250.0           | 250.0         | 0.0      | 0.0  | 20.0      | 270.0 | 0.0   | 0.0        | 0.0  | 270.0       |
      | 4  | 15   | 20231016   |                   | 0.0             | 250.0         | 0.0      | 0.0  | 20.0      | 270.0 | 0.0   | 0.0        | 0.0  | 270.0       |
      | 5  | 1    | 20231017   |                   | 0.0             | 0.0           | 0.0      | 0.0  | 20.0      | 20.0  | 0.0   | 0.0        | 0.0  | 20.0        |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 1000.0        | 0.0      | 0.0  | 60.0      | 1060.0 | 500.0 | 0.0        | 0.0  | 560.0       |
    Then Loan Transactions tab has the following data:
      | Transaction date  | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20230901 | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
      | 20230901 | Repayment        | 250.0  | 250.0     | 0.0      | 0.0  | 0.0       | 750.0        |
      | 20230916 | Repayment        | 250.0  | 250.0     | 0.0      | 0.0  | 0.0       | 500.0        |
    Then Loan Charges tab has the following data:
      | Name    | isPenalty | Payment due at     | Due as of         | Calculation type | Due  | Paid | Waived | Outstanding |
      | NSF fee | true      | Specified due date | 20231017   | Flat             | 20.0 | 0.0  | 0.0    | 20.0        |
      | NSF fee | true      | Specified due date | 20231016   | Flat             | 20.0 | 0.0  | 0.0    | 20.0        |
      | NSF fee | true      | Specified due date | 20230917 | Flat             | 20.0 | 0.0  | 0.0    | 20.0        |
#    Make in advance payment (future installment type: NEXT_INSTALLMENT)
    When Admin sets the business date to "20230917"
    And Customer makes "AUTOPAY" repayment on "20230917" with 100 EUR transaction amount
    Then Loan Repayment schedule has 5 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date         | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20230901 |                   | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 0    | 20230901 | 20230901 | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0  | 0.0         |
      | 2  | 15   | 20230916 | 20230916 | 500.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0  | 0.0         |
      | 3  | 15   | 20231001   |                   | 250.0           | 250.0         | 0.0      | 0.0  | 20.0      | 270.0 | 60.0  | 60.0       | 0.0  | 210.0       |
      | 4  | 15   | 20231016   |                   | 0.0             | 250.0         | 0.0      | 0.0  | 20.0      | 270.0 | 20.0  | 20.0       | 0.0  | 250.0       |
      | 5  | 1    | 20231017   | 20230917 | 0.0             | 0.0           | 0.0      | 0.0  | 20.0      | 20.0  | 20.0  | 20.0       | 0.0  | 0.0         |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 1000.0        | 0.0      | 0.0  | 60.0      | 1060.0 | 600.0 | 100.0      | 0.0  | 460.0       |
    Then Loan Transactions tab has the following data:
      | Transaction date  | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20230901 | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
      | 20230901 | Repayment        | 250.0  | 250.0     | 0.0      | 0.0  | 0.0       | 750.0        |
      | 20230916 | Repayment        | 250.0  | 250.0     | 0.0      | 0.0  | 0.0       | 500.0        |
      | 20230917 | Repayment        | 100.0  | 40.0      | 0.0      | 0.0  | 60.0      | 460.0        |
    Then Loan Charges tab has the following data:
      | Name    | isPenalty | Payment due at     | Due as of         | Calculation type | Due  | Paid | Waived | Outstanding |
      | NSF fee | true      | Specified due date | 20231017   | Flat             | 20.0 | 20.0 | 0.0    | 0.0         |
      | NSF fee | true      | Specified due date | 20231016   | Flat             | 20.0 | 20.0 | 0.0    | 0.0         |
      | NSF fee | true      | Specified due date | 20230917 | Flat             | 20.0 | 20.0 | 0.0    | 0.0         |

