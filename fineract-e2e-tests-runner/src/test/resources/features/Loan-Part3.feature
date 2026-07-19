@LoanFeature
Feature: Loan - Part3

  @TestRailId:C2946 @AdvancedPaymentAllocation @ProgressiveLoanSchedule
  Scenario: Verify AdvancedPaymentAllocation behaviour: loanScheduleProcessingType-horizontal, charge after maturity, late Goodwill credit transaction (future installment type: LAST_INSTALLMENT) - amount < past due charge
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
#    Make late Goodwill credit transaction (future installment type: LAST_INSTALLMENT)
    When Admin sets the business date to "20231017"
    When Customer makes "GOODWILL_CREDIT" transaction with "AUTOPAY" payment type on "20231017" with 15 EUR transaction amount and system-generated Idempotency key
    Then Loan Repayment schedule has 5 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date         | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20230901 |                   | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 0    | 20230901 | 20230901 | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0  | 0.0         |
      | 2  | 15   | 20230916 | 20230916 | 500.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0  | 0.0         |
      | 3  | 15   | 20231001   |                   | 250.0           | 250.0         | 0.0      | 0.0  | 20.0      | 270.0 | 15.0  | 0.0        | 15.0 | 255.0       |
      | 4  | 15   | 20231016   |                   | 0.0             | 250.0         | 0.0      | 0.0  | 20.0      | 270.0 | 0.0   | 0.0        | 0.0  | 270.0       |
      | 5  | 1    | 20231017   |                   | 0.0             | 0.0           | 0.0      | 0.0  | 20.0      | 20.0  | 0.0   | 0.0        | 0.0  | 20.0        |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 1000.0        | 0.0      | 0.0  | 60.0      | 1060.0 | 515.0 | 0.0        | 15.0 | 545.0       |
    Then Loan Transactions tab has the following data:
      | Transaction date  | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20230901 | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
      | 20230901 | Repayment        | 250.0  | 250.0     | 0.0      | 0.0  | 0.0       | 750.0        |
      | 20230916 | Repayment        | 250.0  | 250.0     | 0.0      | 0.0  | 0.0       | 500.0        |
      | 20231017   | Goodwill Credit  | 15.0   | 0.0       | 0.0      | 0.0  | 15.0      | 500.0        |
    Then Loan Charges tab has the following data:
      | Name    | isPenalty | Payment due at     | Due as of         | Calculation type | Due  | Paid | Waived | Outstanding |
      | NSF fee | true      | Specified due date | 20231017   | Flat             | 20.0 | 0.0  | 0.0    | 20.0        |
      | NSF fee | true      | Specified due date | 20231016   | Flat             | 20.0 | 0.0  | 0.0    | 20.0        |
      | NSF fee | true      | Specified due date | 20230917 | Flat             | 20.0 | 15.0 | 0.0    | 5.0         |

  @TestRailId:C2947 @AdvancedPaymentAllocation @ProgressiveLoanSchedule
  Scenario: Verify AdvancedPaymentAllocation behaviour: loanScheduleProcessingType-vertical, charge after maturity, late Goodwill credit transaction (future installment type: LAST_INSTALLMENT) - amount < past due charge
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
#    Make late Goodwill credit transaction (future installment type: LAST_INSTALLMENT)
    When Admin sets the business date to "20231017"
    When Customer makes "GOODWILL_CREDIT" transaction with "AUTOPAY" payment type on "20231017" with 15 EUR transaction amount and system-generated Idempotency key
    Then Loan Repayment schedule has 5 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date         | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20230901 |                   | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 0    | 20230901 | 20230901 | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0  | 0.0         |
      | 2  | 15   | 20230916 | 20230916 | 500.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0  | 0.0         |
      | 3  | 15   | 20231001   |                   | 250.0           | 250.0         | 0.0      | 0.0  | 20.0      | 270.0 | 15.0  | 0.0        | 15.0 | 255.0       |
      | 4  | 15   | 20231016   |                   | 0.0             | 250.0         | 0.0      | 0.0  | 20.0      | 270.0 | 0.0   | 0.0        | 0.0  | 270.0       |
      | 5  | 1    | 20231017   |                   | 0.0             | 0.0           | 0.0      | 0.0  | 20.0      | 20.0  | 0.0   | 0.0        | 0.0  | 20.0        |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 1000.0        | 0.0      | 0.0  | 60.0      | 1060.0 | 515.0 | 0.0        | 15.0 | 545.0       |
    Then Loan Transactions tab has the following data:
      | Transaction date  | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20230901 | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
      | 20230901 | Repayment        | 250.0  | 250.0     | 0.0      | 0.0  | 0.0       | 750.0        |
      | 20230916 | Repayment        | 250.0  | 250.0     | 0.0      | 0.0  | 0.0       | 500.0        |
      | 20231017   | Goodwill Credit  | 15.0   | 0.0       | 0.0      | 0.0  | 15.0      | 500.0        |
    Then Loan Charges tab has the following data:
      | Name    | isPenalty | Payment due at     | Due as of         | Calculation type | Due  | Paid | Waived | Outstanding |
      | NSF fee | true      | Specified due date | 20231017   | Flat             | 20.0 | 0.0  | 0.0    | 20.0        |
      | NSF fee | true      | Specified due date | 20231016   | Flat             | 20.0 | 0.0  | 0.0    | 20.0        |
      | NSF fee | true      | Specified due date | 20230917 | Flat             | 20.0 | 15.0 | 0.0    | 5.0         |

  @TestRailId:C2948 @AdvancedPaymentAllocation @ProgressiveLoanSchedule
  Scenario: Verify AdvancedPaymentAllocation behaviour: loanScheduleProcessingType-horizontal, charge after maturity, late Goodwill credit transaction (future installment type: LAST_INSTALLMENT) - amount > first past due charge
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
#    Make late Goodwill credit transaction (future installment type: LAST_INSTALLMENT)
    When Admin sets the business date to "20231017"
    When Customer makes "GOODWILL_CREDIT" transaction with "AUTOPAY" payment type on "20231017" with 35 EUR transaction amount and system-generated Idempotency key
    Then Loan Repayment schedule has 5 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date         | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20230901 |                   | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 0    | 20230901 | 20230901 | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0  | 0.0         |
      | 2  | 15   | 20230916 | 20230916 | 500.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0  | 0.0         |
      | 3  | 15   | 20231001   |                   | 250.0           | 250.0         | 0.0      | 0.0  | 20.0      | 270.0 | 35.0  | 0.0        | 35.0 | 235.0       |
      | 4  | 15   | 20231016   |                   | 0.0             | 250.0         | 0.0      | 0.0  | 20.0      | 270.0 | 0.0   | 0.0        | 0.0  | 270.0       |
      | 5  | 1    | 20231017   |                   | 0.0             | 0.0           | 0.0      | 0.0  | 20.0      | 20.0  | 0.0   | 0.0        | 0.0  | 20.0        |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 1000.0        | 0.0      | 0.0  | 60.0      | 1060.0 | 535.0 | 0.0        | 35.0 | 525.0       |
    Then Loan Transactions tab has the following data:
      | Transaction date  | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20230901 | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
      | 20230901 | Repayment        | 250.0  | 250.0     | 0.0      | 0.0  | 0.0       | 750.0        |
      | 20230916 | Repayment        | 250.0  | 250.0     | 0.0      | 0.0  | 0.0       | 500.0        |
      | 20231017   | Goodwill Credit  | 35.0   | 15.0      | 0.0      | 0.0  | 20.0      | 485.0        |
    Then Loan Charges tab has the following data:
      | Name    | isPenalty | Payment due at     | Due as of         | Calculation type | Due  | Paid | Waived | Outstanding |
      | NSF fee | true      | Specified due date | 20231017   | Flat             | 20.0 | 0.0  | 0.0    | 20.0        |
      | NSF fee | true      | Specified due date | 20231016   | Flat             | 20.0 | 0.0  | 0.0    | 20.0        |
      | NSF fee | true      | Specified due date | 20230917 | Flat             | 20.0 | 20.0 | 0.0    | 0.0         |

  @TestRailId:C2949 @AdvancedPaymentAllocation @ProgressiveLoanSchedule
  Scenario: Verify AdvancedPaymentAllocation behaviour: loanScheduleProcessingType-vertical, charge after maturity, late Goodwill credit transaction (future installment type: LAST_INSTALLMENT) - amount > first past due charge
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
#    Make late Goodwill credit transaction (future installment type: LAST_INSTALLMENT)
    When Admin sets the business date to "20231017"
    When Customer makes "GOODWILL_CREDIT" transaction with "AUTOPAY" payment type on "20231017" with 35 EUR transaction amount and system-generated Idempotency key
    Then Loan Repayment schedule has 5 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date         | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20230901 |                   | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 0    | 20230901 | 20230901 | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0  | 0.0         |
      | 2  | 15   | 20230916 | 20230916 | 500.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0  | 0.0         |
      | 3  | 15   | 20231001   |                   | 250.0           | 250.0         | 0.0      | 0.0  | 20.0      | 270.0 | 20.0  | 0.0        | 20.0 | 250.0       |
      | 4  | 15   | 20231016   |                   | 0.0             | 250.0         | 0.0      | 0.0  | 20.0      | 270.0 | 15.0  | 0.0        | 15.0 | 255.0       |
      | 5  | 1    | 20231017   |                   | 0.0             | 0.0           | 0.0      | 0.0  | 20.0      | 20.0  | 0.0   | 0.0        | 0.0  | 20.0        |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 1000.0        | 0.0      | 0.0  | 60.0      | 1060.0 | 535.0 | 0.0        | 35.0 | 525.0       |
    Then Loan Transactions tab has the following data:
      | Transaction date  | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20230901 | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
      | 20230901 | Repayment        | 250.0  | 250.0     | 0.0      | 0.0  | 0.0       | 750.0        |
      | 20230916 | Repayment        | 250.0  | 250.0     | 0.0      | 0.0  | 0.0       | 500.0        |
      | 20231017   | Goodwill Credit  | 35.0   | 0.0       | 0.0      | 0.0  | 35.0      | 500.0        |
    Then Loan Charges tab has the following data:
      | Name    | isPenalty | Payment due at     | Due as of         | Calculation type | Due  | Paid | Waived | Outstanding |
      | NSF fee | true      | Specified due date | 20231017   | Flat             | 20.0 | 0.0  | 0.0    | 20.0        |
      | NSF fee | true      | Specified due date | 20231016   | Flat             | 20.0 | 15.0 | 0.0    | 5.0         |
      | NSF fee | true      | Specified due date | 20230917 | Flat             | 20.0 | 20.0 | 0.0    | 0.0         |

  @TestRailId:C2950 @AdvancedPaymentAllocation @ProgressiveLoanSchedule
  Scenario: Verify AdvancedPaymentAllocation behaviour: loanScheduleProcessingType-horizontal, charge after maturity, late Goodwill credit transaction (future installment type: LAST_INSTALLMENT) - amount > sum past due charges
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
#    Make late Goodwill credit transaction (future installment type: LAST_INSTALLMENT)
    When Admin sets the business date to "20231017"
    When Customer makes "GOODWILL_CREDIT" transaction with "AUTOPAY" payment type on "20231017" with 350 EUR transaction amount and system-generated Idempotency key
    Then Loan Repayment schedule has 5 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date         | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late  | Outstanding |
      |    |      | 20230901 |                   | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |       |             |
      | 1  | 0    | 20230901 | 20230901 | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0   | 0.0         |
      | 2  | 15   | 20230916 | 20230916 | 500.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0   | 0.0         |
      | 3  | 15   | 20231001   | 20231017   | 250.0           | 250.0         | 0.0      | 0.0  | 20.0      | 270.0 | 270.0 | 0.0        | 270.0 | 0.0         |
      | 4  | 15   | 20231016   |                   | 0.0             | 250.0         | 0.0      | 0.0  | 20.0      | 270.0 | 80.0  | 0.0        | 80.0  | 190.0       |
      | 5  | 1    | 20231017   |                   | 0.0             | 0.0           | 0.0      | 0.0  | 20.0      | 20.0  | 0.0   | 0.0        | 0.0   | 20.0        |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late  | Outstanding |
      | 1000.0        | 0.0      | 0.0  | 60.0      | 1060.0 | 850.0 | 0.0        | 350.0 | 210.0       |
    Then Loan Transactions tab has the following data:
      | Transaction date  | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20230901 | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
      | 20230901 | Repayment        | 250.0  | 250.0     | 0.0      | 0.0  | 0.0       | 750.0        |
      | 20230916 | Repayment        | 250.0  | 250.0     | 0.0      | 0.0  | 0.0       | 500.0        |
      | 20231017   | Goodwill Credit  | 350.0  | 310.0     | 0.0      | 0.0  | 40.0      | 190.0        |
    Then Loan Charges tab has the following data:
      | Name    | isPenalty | Payment due at     | Due as of         | Calculation type | Due  | Paid | Waived | Outstanding |
      | NSF fee | true      | Specified due date | 20231017   | Flat             | 20.0 | 0.0  | 0.0    | 20.0        |
      | NSF fee | true      | Specified due date | 20231016   | Flat             | 20.0 | 20.0 | 0.0    | 0.0         |
      | NSF fee | true      | Specified due date | 20230917 | Flat             | 20.0 | 20.0 | 0.0    | 0.0         |

  @TestRailId:C2951 @AdvancedPaymentAllocation @ProgressiveLoanSchedule
  Scenario: Verify AdvancedPaymentAllocation behaviour: loanScheduleProcessingType-vertical, charge after maturity, late Goodwill credit transaction (future installment type: LAST_INSTALLMENT) - amount > sum past due charges
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
#    Make late Goodwill credit transaction (future installment type: LAST_INSTALLMENT)
    When Admin sets the business date to "20231017"
    When Customer makes "GOODWILL_CREDIT" transaction with "AUTOPAY" payment type on "20231017" with 350 EUR transaction amount and system-generated Idempotency key
    Then Loan Repayment schedule has 5 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date         | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late  | Outstanding |
      |    |      | 20230901 |                   | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |       |             |
      | 1  | 0    | 20230901 | 20230901 | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0   | 0.0         |
      | 2  | 15   | 20230916 | 20230916 | 500.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0   | 0.0         |
      | 3  | 15   | 20231001   | 20231017   | 250.0           | 250.0         | 0.0      | 0.0  | 20.0      | 270.0 | 270.0 | 0.0        | 270.0 | 0.0         |
      | 4  | 15   | 20231016   |                   | 0.0             | 250.0         | 0.0      | 0.0  | 20.0      | 270.0 | 80.0  | 0.0        | 80.0  | 190.0       |
      | 5  | 1    | 20231017   |                   | 0.0             | 0.0           | 0.0      | 0.0  | 20.0      | 20.0  | 0.0   | 0.0        | 0.0   | 20.0        |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late  | Outstanding |
      | 1000.0        | 0.0      | 0.0  | 60.0      | 1060.0 | 850.0 | 0.0        | 350.0 | 210.0       |
    Then Loan Transactions tab has the following data:
      | Transaction date  | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20230901 | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
      | 20230901 | Repayment        | 250.0  | 250.0     | 0.0      | 0.0  | 0.0       | 750.0        |
      | 20230916 | Repayment        | 250.0  | 250.0     | 0.0      | 0.0  | 0.0       | 500.0        |
      | 20231017   | Goodwill Credit  | 350.0  | 310.0     | 0.0      | 0.0  | 40.0      | 190.0        |
    Then Loan Charges tab has the following data:
      | Name    | isPenalty | Payment due at     | Due as of         | Calculation type | Due  | Paid | Waived | Outstanding |
      | NSF fee | true      | Specified due date | 20231017   | Flat             | 20.0 | 0.0  | 0.0    | 20.0        |
      | NSF fee | true      | Specified due date | 20231016   | Flat             | 20.0 | 20.0 | 0.0    | 0.0         |
      | NSF fee | true      | Specified due date | 20230917 | Flat             | 20.0 | 20.0 | 0.0    | 0.0         |

  @TestRailId:C2952 @AdvancedPaymentAllocation @ProgressiveLoanSchedule
  Scenario: Verify AdvancedPaymentAllocation behaviour: loanScheduleProcessingType-horizontal, charge after maturity, in advanced Goodwill credit transaction on first charge due date (future installment type: LAST_INSTALLMENT) - amount > due date charge
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
#    Make in advanced Goodwill credit transaction (future installment type: LAST_INSTALLMENT)
    When Admin sets the business date to "20230917"
    When Customer makes "GOODWILL_CREDIT" transaction with "AUTOPAY" payment type on "20230917" with 35 EUR transaction amount and system-generated Idempotency key
    Then Loan Repayment schedule has 5 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date         | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20230901 |                   | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 0    | 20230901 | 20230901 | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0  | 0.0         |
      | 2  | 15   | 20230916 | 20230916 | 500.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0  | 0.0         |
      | 3  | 15   | 20231001   |                   | 250.0           | 250.0         | 0.0      | 0.0  | 20.0      | 270.0 | 0.0   | 0.0        | 0.0  | 270.0       |
      | 4  | 15   | 20231016   |                   | 0.0             | 250.0         | 0.0      | 0.0  | 20.0      | 270.0 | 15.0  | 15.0       | 0.0  | 255.0       |
      | 5  | 1    | 20231017   | 20230917 | 0.0             | 0.0           | 0.0      | 0.0  | 20.0      | 20.0  | 20.0  | 20.0       | 0.0  | 0.0         |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 1000.0        | 0.0      | 0.0  | 60.0      | 1060.0 | 535.0 | 35.0       | 0.0  | 525.0       |
    Then Loan Transactions tab has the following data:
      | Transaction date  | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20230901 | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
      | 20230901 | Repayment        | 250.0  | 250.0     | 0.0      | 0.0  | 0.0       | 750.0        |
      | 20230916 | Repayment        | 250.0  | 250.0     | 0.0      | 0.0  | 0.0       | 500.0        |
      | 20230917 | Goodwill Credit  | 35.0   | 0.0       | 0.0      | 0.0  | 35.0      | 500.0        |
    Then Loan Charges tab has the following data:
      | Name    | isPenalty | Payment due at     | Due as of         | Calculation type | Due  | Paid | Waived | Outstanding |
      | NSF fee | true      | Specified due date | 20231017   | Flat             | 20.0 | 20.0 | 0.0    | 0.0         |
      | NSF fee | true      | Specified due date | 20231016   | Flat             | 20.0 | 15.0 | 0.0    | 5.0         |
      | NSF fee | true      | Specified due date | 20230917 | Flat             | 20.0 | 0.0  | 0.0    | 20.0        |

  @TestRailId:C2953 @AdvancedPaymentAllocation @ProgressiveLoanSchedule
  Scenario: Verify AdvancedPaymentAllocation behaviour: loanScheduleProcessingType-vertical, charge after maturity, in advanced Goodwill credit transaction on first charge due date (future installment type: LAST_INSTALLMENT) - amount > due date charge
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
#    Make in advanced Goodwill credit transaction (future installment type: LAST_INSTALLMENT)
    When Admin sets the business date to "20230917"
    When Customer makes "GOODWILL_CREDIT" transaction with "AUTOPAY" payment type on "20230917" with 35 EUR transaction amount and system-generated Idempotency key
    Then Loan Repayment schedule has 5 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date         | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20230901 |                   | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 0    | 20230901 | 20230901 | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0  | 0.0         |
      | 2  | 15   | 20230916 | 20230916 | 500.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0  | 0.0         |
      | 3  | 15   | 20231001   |                   | 250.0           | 250.0         | 0.0      | 0.0  | 20.0      | 270.0 | 0.0   | 0.0        | 0.0  | 270.0       |
      | 4  | 15   | 20231016   |                   | 0.0             | 250.0         | 0.0      | 0.0  | 20.0      | 270.0 | 15.0  | 15.0       | 0.0  | 255.0       |
      | 5  | 1    | 20231017   | 20230917 | 0.0             | 0.0           | 0.0      | 0.0  | 20.0      | 20.0  | 20.0  | 20.0       | 0.0  | 0.0         |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 1000.0        | 0.0      | 0.0  | 60.0      | 1060.0 | 535.0 | 35.0       | 0.0  | 525.0       |
    Then Loan Transactions tab has the following data:
      | Transaction date  | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20230901 | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
      | 20230901 | Repayment        | 250.0  | 250.0     | 0.0      | 0.0  | 0.0       | 750.0        |
      | 20230916 | Repayment        | 250.0  | 250.0     | 0.0      | 0.0  | 0.0       | 500.0        |
      | 20230917 | Goodwill Credit  | 35.0   | 0.0       | 0.0      | 0.0  | 35.0      | 500.0        |
    Then Loan Charges tab has the following data:
      | Name    | isPenalty | Payment due at     | Due as of         | Calculation type | Due  | Paid | Waived | Outstanding |
      | NSF fee | true      | Specified due date | 20231017   | Flat             | 20.0 | 20.0 | 0.0    | 0.0         |
      | NSF fee | true      | Specified due date | 20231016   | Flat             | 20.0 | 15.0 | 0.0    | 5.0         |
      | NSF fee | true      | Specified due date | 20230917 | Flat             | 20.0 | 0.0  | 0.0    | 20.0        |

  @TestRailId:C2954 @AdvancedPaymentAllocation @ProgressiveLoanSchedule
  Scenario: Verify AdvancedPaymentAllocation behaviour: loanScheduleProcessingType-horizontal, charge after maturity, in advanced Goodwill credit transaction before first charge due date (future installment type: LAST_INSTALLMENT) - amount > first and second charge
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
    When Admin sets the business date to "20230917"
  #    Make in advanced Goodwill credit transaction (future installment type: LAST_INSTALLMENT)
    When Customer makes "GOODWILL_CREDIT" transaction with "AUTOPAY" payment type on "20230917" with 35 EUR transaction amount and system-generated Idempotency key
    Then Loan Repayment schedule has 5 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date         | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20230901 |                   | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 0    | 20230901 | 20230901 | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0  | 0.0         |
      | 2  | 15   | 20230916 | 20230916 | 500.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0  | 0.0         |
      | 3  | 15   | 20231001   |                   | 250.0           | 250.0         | 0.0      | 0.0  | 20.0      | 270.0 | 0.0   | 0.0        | 0.0  | 270.0       |
      | 4  | 15   | 20231016   |                   | 0.0             | 250.0         | 0.0      | 0.0  | 20.0      | 270.0 | 15.0  | 15.0       | 0.0  | 255.0       |
      | 5  | 1    | 20231017   | 20230917 | 0.0             | 0.0           | 0.0      | 0.0  | 20.0      | 20.0  | 20.0  | 20.0       | 0.0  | 0.0         |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 1000.0        | 0.0      | 0.0  | 60.0      | 1060.0 | 535.0 | 35.0       | 0.0  | 525.0       |
    Then Loan Transactions tab has the following data:
      | Transaction date  | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20230901 | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
      | 20230901 | Repayment        | 250.0  | 250.0     | 0.0      | 0.0  | 0.0       | 750.0        |
      | 20230916 | Repayment        | 250.0  | 250.0     | 0.0      | 0.0  | 0.0       | 500.0        |
      | 20230917 | Goodwill Credit  | 35.0   | 0.0       | 0.0      | 0.0  | 35.0      | 500.0        |
    Then Loan Charges tab has the following data:
      | Name    | isPenalty | Payment due at     | Due as of         | Calculation type | Due  | Paid | Waived | Outstanding |
      | NSF fee | true      | Specified due date | 20231017   | Flat             | 20.0 | 20.0 | 0.0    | 0.0         |
      | NSF fee | true      | Specified due date | 20231016   | Flat             | 20.0 | 15.0 | 0.0    | 5.0         |
      | NSF fee | true      | Specified due date | 20230917 | Flat             | 20.0 | 0.0  | 0.0    | 20.0        |

  @TestRailId:C2955 @AdvancedPaymentAllocation @ProgressiveLoanSchedule
  Scenario: Verify AdvancedPaymentAllocation behaviour: loanScheduleProcessingType-vertical, charge after maturity, in advanced Goodwill credit transaction before first charge due date (future installment type: LAST_INSTALLMENT) - amount > first and second charge
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
    When Admin sets the business date to "20230917"
#    Make in advanced Goodwill credit transaction (future installment type: LAST_INSTALLMENT)
    When Customer makes "GOODWILL_CREDIT" transaction with "AUTOPAY" payment type on "20230917" with 35 EUR transaction amount and system-generated Idempotency key
    Then Loan Repayment schedule has 5 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date         | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20230901 |                   | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 0    | 20230901 | 20230901 | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0  | 0.0         |
      | 2  | 15   | 20230916 | 20230916 | 500.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0  | 0.0         |
      | 3  | 15   | 20231001   |                   | 250.0           | 250.0         | 0.0      | 0.0  | 20.0      | 270.0 | 0.0   | 0.0        | 0.0  | 270.0       |
      | 4  | 15   | 20231016   |                   | 0.0             | 250.0         | 0.0      | 0.0  | 20.0      | 270.0 | 15.0  | 15.0       | 0.0  | 255.0       |
      | 5  | 1    | 20231017   | 20230917 | 0.0             | 0.0           | 0.0      | 0.0  | 20.0      | 20.0  | 20.0  | 20.0       | 0.0  | 0.0         |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 1000.0        | 0.0      | 0.0  | 60.0      | 1060.0 | 535.0 | 35.0       | 0.0  | 525.0       |
    Then Loan Transactions tab has the following data:
      | Transaction date  | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20230901 | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
      | 20230901 | Repayment        | 250.0  | 250.0     | 0.0      | 0.0  | 0.0       | 750.0        |
      | 20230916 | Repayment        | 250.0  | 250.0     | 0.0      | 0.0  | 0.0       | 500.0        |
      | 20230917 | Goodwill Credit  | 35.0   | 0.0       | 0.0      | 0.0  | 35.0      | 500.0        |
    Then Loan Charges tab has the following data:
      | Name    | isPenalty | Payment due at     | Due as of         | Calculation type | Due  | Paid | Waived | Outstanding |
      | NSF fee | true      | Specified due date | 20231017   | Flat             | 20.0 | 20.0 | 0.0    | 0.0         |
      | NSF fee | true      | Specified due date | 20231016   | Flat             | 20.0 | 15.0 | 0.0    | 5.0         |
      | NSF fee | true      | Specified due date | 20230917 | Flat             | 20.0 | 0.0  | 0.0    | 20.0        |

  @TestRailId:C2956 @AdvancedPaymentAllocation @ProgressiveLoanSchedule
  Scenario: Verify AdvancedPaymentAllocation behaviour: loanScheduleProcessingType-horizontal, charge after maturity, in advanced Merchant issued refund transaction on first charge due date (future installment type: REAMORTIZATION) - amount < sum all charges
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
#    Make in advanced Merchant issued refund transaction (future installment type: REAMORTIZATION)
    When Admin sets the business date to "20230917"
    When Customer makes "MERCHANT_ISSUED_REFUND" transaction with "AUTOPAY" payment type on "20230917" with 30 EUR transaction amount and system-generated Idempotency key
    Then Loan Repayment schedule has 5 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date         | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20230901 |                   | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 0    | 20230901 | 20230901 | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0  | 0.0         |
      | 2  | 15   | 20230916 | 20230916 | 500.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0  | 0.0         |
      | 3  | 15   | 20231001   |                   | 250.0           | 250.0         | 0.0      | 0.0  | 20.0      | 270.0 | 10.0  | 10.0       | 0.0  | 260.0       |
      | 4  | 15   | 20231016   |                   | 0.0             | 250.0         | 0.0      | 0.0  | 20.0      | 270.0 | 10.0  | 10.0       | 0.0  | 260.0       |
      | 5  | 1    | 20231017   |                   | 0.0             | 0.0           | 0.0      | 0.0  | 20.0      | 20.0  | 10.0  | 10.0       | 0.0  | 10.0        |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 1000.0        | 0.0      | 0.0  | 60.0      | 1060.0 | 530.0 | 30.0       | 0.0  | 530.0       |
    Then Loan Transactions tab has the following data:
      | Transaction date  | Transaction Type       | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20230901 | Disbursement           | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
      | 20230901 | Repayment              | 250.0  | 250.0     | 0.0      | 0.0  | 0.0       | 750.0        |
      | 20230916 | Repayment              | 250.0  | 250.0     | 0.0      | 0.0  | 0.0       | 500.0        |
      | 20230917 | Merchant Issued Refund | 30.0   | 0.0       | 0.0      | 0.0  | 30.0      | 500.0        |
    Then Loan Charges tab has the following data:
      | Name    | isPenalty | Payment due at     | Due as of         | Calculation type | Due  | Paid | Waived | Outstanding |
      | NSF fee | true      | Specified due date | 20231017   | Flat             | 20.0 | 10.0 | 0.0    | 10.0        |
      | NSF fee | true      | Specified due date | 20231016   | Flat             | 20.0 | 10.0 | 0.0    | 10.0        |
      | NSF fee | true      | Specified due date | 20230917 | Flat             | 20.0 | 10.0 | 0.0    | 10.0        |

  @TestRailId:C2957 @AdvancedPaymentAllocation @ProgressiveLoanSchedule
  Scenario: Verify AdvancedPaymentAllocation behaviour: loanScheduleProcessingType-vertical, charge after maturity, in advanced Merchant issued refund transaction on first charge due date (future installment type: REAMORTIZATION) - amount < sum all charges
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
#    Make in advanced Merchant issued refund transaction (future installment type: REAMORTIZATION)
    When Admin sets the business date to "20230917"
    When Customer makes "MERCHANT_ISSUED_REFUND" transaction with "AUTOPAY" payment type on "20230917" with 30 EUR transaction amount and system-generated Idempotency key
    Then Loan Repayment schedule has 5 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date         | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20230901 |                   | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 0    | 20230901 | 20230901 | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0  | 0.0         |
      | 2  | 15   | 20230916 | 20230916 | 500.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0  | 0.0         |
      | 3  | 15   | 20231001   |                   | 250.0           | 250.0         | 0.0      | 0.0  | 20.0      | 270.0 | 10.0  | 10.0       | 0.0  | 260.0       |
      | 4  | 15   | 20231016   |                   | 0.0             | 250.0         | 0.0      | 0.0  | 20.0      | 270.0 | 10.0  | 10.0       | 0.0  | 260.0       |
      | 5  | 1    | 20231017   |                   | 0.0             | 0.0           | 0.0      | 0.0  | 20.0      | 20.0  | 10.0  | 10.0       | 0.0  | 10.0        |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 1000.0        | 0.0      | 0.0  | 60.0      | 1060.0 | 530.0 | 30.0       | 0.0  | 530.0       |
    Then Loan Transactions tab has the following data:
      | Transaction date  | Transaction Type       | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20230901 | Disbursement           | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
      | 20230901 | Repayment              | 250.0  | 250.0     | 0.0      | 0.0  | 0.0       | 750.0        |
      | 20230916 | Repayment              | 250.0  | 250.0     | 0.0      | 0.0  | 0.0       | 500.0        |
      | 20230917 | Merchant Issued Refund | 30.0   | 0.0       | 0.0      | 0.0  | 30.0      | 500.0        |
    Then Loan Charges tab has the following data:
      | Name    | isPenalty | Payment due at     | Due as of         | Calculation type | Due  | Paid | Waived | Outstanding |
      | NSF fee | true      | Specified due date | 20231017   | Flat             | 20.0 | 10.0 | 0.0    | 10.0        |
      | NSF fee | true      | Specified due date | 20231016   | Flat             | 20.0 | 10.0 | 0.0    | 10.0        |
      | NSF fee | true      | Specified due date | 20230917 | Flat             | 20.0 | 10.0 | 0.0    | 10.0        |

  @TestRailId:C2958 @AdvancedPaymentAllocation @ProgressiveLoanSchedule
  Scenario: Verify AdvancedPaymentAllocation behaviour: loanScheduleProcessingType-horizontal, charge after maturity, in advanced Merchant issued refund transaction before first charge due date (future installment type: REAMORTIZATION) - amount < sum all charges
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
    When Admin sets the business date to "20230917"
#    Make in advanced Merchant issued refund transaction (future installment type: REAMORTIZATION)
    When Customer makes "MERCHANT_ISSUED_REFUND" transaction with "AUTOPAY" payment type on "20230917" with 30 EUR transaction amount and system-generated Idempotency key
    Then Loan Repayment schedule has 5 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date         | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20230901 |                   | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 0    | 20230901 | 20230901 | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0  | 0.0         |
      | 2  | 15   | 20230916 | 20230916 | 500.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0  | 0.0         |
      | 3  | 15   | 20231001   |                   | 250.0           | 250.0         | 0.0      | 0.0  | 20.0      | 270.0 | 10.0  | 10.0       | 0.0  | 260.0       |
      | 4  | 15   | 20231016   |                   | 0.0             | 250.0         | 0.0      | 0.0  | 20.0      | 270.0 | 10.0  | 10.0       | 0.0  | 260.0       |
      | 5  | 1    | 20231017   |                   | 0.0             | 0.0           | 0.0      | 0.0  | 20.0      | 20.0  | 10.0  | 10.0       | 0.0  | 10.0        |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 1000.0        | 0.0      | 0.0  | 60.0      | 1060.0 | 530.0 | 30.0       | 0.0  | 530.0       |
    Then Loan Transactions tab has the following data:
      | Transaction date  | Transaction Type       | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20230901 | Disbursement           | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
      | 20230901 | Repayment              | 250.0  | 250.0     | 0.0      | 0.0  | 0.0       | 750.0        |
      | 20230916 | Repayment              | 250.0  | 250.0     | 0.0      | 0.0  | 0.0       | 500.0        |
      | 20230917 | Merchant Issued Refund | 30.0   | 0.0       | 0.0      | 0.0  | 30.0      | 500.0        |
    Then Loan Charges tab has the following data:
      | Name    | isPenalty | Payment due at     | Due as of         | Calculation type | Due  | Paid | Waived | Outstanding |
      | NSF fee | true      | Specified due date | 20231017   | Flat             | 20.0 | 10.0 | 0.0    | 10.0        |
      | NSF fee | true      | Specified due date | 20231016   | Flat             | 20.0 | 10.0 | 0.0    | 10.0        |
      | NSF fee | true      | Specified due date | 20230917 | Flat             | 20.0 | 10.0 | 0.0    | 10.0        |

  @TestRailId:C2959 @AdvancedPaymentAllocation @ProgressiveLoanSchedule
  Scenario: Verify AdvancedPaymentAllocation behaviour: loanScheduleProcessingType-vertical, charge after maturity, in advanced Merchant issued refund transaction before first charge due date (future installment type: REAMORTIZATION) - amount < sum all charges
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
    When Admin sets the business date to "20230917"
#    Make in advanced Merchant issued refund transaction (future installment type: REAMORTIZATION)
    When Customer makes "MERCHANT_ISSUED_REFUND" transaction with "AUTOPAY" payment type on "20230917" with 30 EUR transaction amount and system-generated Idempotency key
    Then Loan Repayment schedule has 5 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date         | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20230901 |                   | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 0    | 20230901 | 20230901 | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0  | 0.0         |
      | 2  | 15   | 20230916 | 20230916 | 500.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0  | 0.0         |
      | 3  | 15   | 20231001   |                   | 250.0           | 250.0         | 0.0      | 0.0  | 20.0      | 270.0 | 10.0  | 10.0       | 0.0  | 260.0       |
      | 4  | 15   | 20231016   |                   | 0.0             | 250.0         | 0.0      | 0.0  | 20.0      | 270.0 | 10.0  | 10.0       | 0.0  | 260.0       |
      | 5  | 1    | 20231017   |                   | 0.0             | 0.0           | 0.0      | 0.0  | 20.0      | 20.0  | 10.0  | 10.0       | 0.0  | 10.0        |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 1000.0        | 0.0      | 0.0  | 60.0      | 1060.0 | 530.0 | 30.0       | 0.0  | 530.0       |
    Then Loan Transactions tab has the following data:
      | Transaction date  | Transaction Type       | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20230901 | Disbursement           | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
      | 20230901 | Repayment              | 250.0  | 250.0     | 0.0      | 0.0  | 0.0       | 750.0        |
      | 20230916 | Repayment              | 250.0  | 250.0     | 0.0      | 0.0  | 0.0       | 500.0        |
      | 20230917 | Merchant Issued Refund | 30.0   | 0.0       | 0.0      | 0.0  | 30.0      | 500.0        |
    Then Loan Charges tab has the following data:
      | Name    | isPenalty | Payment due at     | Due as of         | Calculation type | Due  | Paid | Waived | Outstanding |
      | NSF fee | true      | Specified due date | 20231017   | Flat             | 20.0 | 10.0 | 0.0    | 10.0        |
      | NSF fee | true      | Specified due date | 20231016   | Flat             | 20.0 | 10.0 | 0.0    | 10.0        |
      | NSF fee | true      | Specified due date | 20230917 | Flat             | 20.0 | 10.0 | 0.0    | 10.0        |

  @TestRailId:C2960 @AdvancedPaymentAllocation
  Scenario: Verify that rounding in case of multiple installments works properly
    When Admin sets the business date to "20230901"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy                        |
      | LP1         | 20230901 | 1000           | 0                      | DECLINING_BALANCE | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 6                 | MONTHS                | 1              | MONTHS                 | 6                  | 0                       | 0                      | 0                    | PENALTIES_FEES_INTEREST_PRINCIPAL_ORDER |
    And Admin successfully approves the loan on "20230901" with "1000" amount and expected disbursement date on "20230901"
    When Admin successfully disburse the loan on "20230901" with "1000" EUR transaction amount
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20230901 |           | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 30   | 20231001   |           | 833.0           | 167.0         | 0.0      | 0.0  | 0.0       | 167.0 | 0.0  | 0.0        | 0.0  | 167.0       |
      | 2  | 31   | 20231101  |           | 666.0           | 167.0         | 0.0      | 0.0  | 0.0       | 167.0 | 0.0  | 0.0        | 0.0  | 167.0       |
      | 3  | 30   | 20231201  |           | 499.0           | 167.0         | 0.0      | 0.0  | 0.0       | 167.0 | 0.0  | 0.0        | 0.0  | 167.0       |
      | 4  | 31   | 20240101   |           | 332.0           | 167.0         | 0.0      | 0.0  | 0.0       | 167.0 | 0.0  | 0.0        | 0.0  | 167.0       |
      | 5  | 31   | 20240201  |           | 165.0           | 167.0         | 0.0      | 0.0  | 0.0       | 167.0 | 0.0  | 0.0        | 0.0  | 167.0       |
      | 6  | 29   | 20240301     |           | 0.0             | 165.0         | 0.0      | 0.0  | 0.0       | 165.0 | 0.0  | 0.0        | 0.0  | 165.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 1000.0        | 0.0      | 0.0  | 0.0       | 1000.0 | 0.0  | 0.0        | 0.0  | 1000.0      |

  @TestRailId:C2976 @AdvancedPaymentAllocation @ProgressiveLoanSchedule
  Scenario: Verify that disbursement amount only distributed only to future installments (2nd and 3rd installments)
    When Admin sets the business date to "20230901"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                        | submitted on date | with Principal | ANNUAL interest rate % | interest type | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_DOWNPAYMENT_ADV_PMT_ALLOC_PROGRESSIVE_LOAN_SCHEDULE_HORIZONTAL | 20230901 | 1000           | 0                      | FLAT          | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 3                 | MONTHS                | 1              | MONTHS                 | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20230901" with "1000" amount and expected disbursement date on "20230901"
    When Admin successfully disburse the loan on "20230901" with "1000" EUR transaction amount
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20230901 |           | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 0    | 20230901 |           | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0  | 0.0        | 0.0  | 250.0       |
      | 2  | 30   | 20231001   |           | 500.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0  | 0.0        | 0.0  | 250.0       |
      | 3  | 31   | 20231101  |           | 250.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0  | 0.0        | 0.0  | 250.0       |
      | 4  | 30   | 20231201  |           | 0.0             | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0  | 0.0        | 0.0  | 250.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 1000.0        | 0.0      | 0.0  | 0.0       | 1000.0 | 0.0  | 0.0        | 0.0  | 1000.0      |
    When Admin adds "LOAN_SNOOZE_FEE" due date charge with "20230901" due date and 50 EUR transaction amount
    And Customer makes "AUTOPAY" repayment on "20230901" with 250 EUR transaction amount
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date         | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20230901 |                   | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 0    | 20230901 | 20230901 | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0  | 0.0         |
      | 2  | 30   | 20231001   |                   | 500.0           | 250.0         | 0.0      | 50.0 | 0.0       | 300.0 | 0.0   | 0.0        | 0.0  | 300.0       |
      | 3  | 31   | 20231101  |                   | 250.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0   | 0.0        | 0.0  | 250.0       |
      | 4  | 30   | 20231201  |                   | 0.0             | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0   | 0.0        | 0.0  | 250.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 1000.0        | 0.0      | 50.0 | 0.0       | 1050.0 | 250.0 | 0.0        | 0.0  | 800.0       |
    When Admin sets the business date to "20231001"
    When Admin successfully disburse the loan on "20231001" with "400" EUR transaction amount
    Then Loan Repayment schedule has 5 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date         | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20230901 |                   | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 0    | 20230901 | 20230901 | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0  | 0.0         |
      | 2  | 30   | 20231001   |                   | 500.0           | 250.0         | 0.0      | 50.0 | 0.0       | 300.0 | 0.0   | 0.0        | 0.0  | 300.0       |
      |    |      | 20231001   |                   | 400.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 3  | 0    | 20231001   |                   | 800.0           | 100.0         | 0.0      | 0.0  | 0.0       | 100.0 | 0.0   | 0.0        | 0.0  | 100.0       |
      | 4  | 31   | 20231101  |                   | 400.0           | 400.0         | 0.0      | 0.0  | 0.0       | 400.0 | 0.0   | 0.0        | 0.0  | 400.0       |
      | 5  | 30   | 20231201  |                   | 0.0             | 400.0         | 0.0      | 0.0  | 0.0       | 400.0 | 0.0   | 0.0        | 0.0  | 400.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 1400.0        | 0.0      | 50.0 | 0.0       | 1450.0 | 250.0 | 0.0        | 0.0  | 1200.0      |

  @TestRailId:C2977 @AdvancedPaymentAllocation @ProgressiveLoanSchedule
  Scenario: Verify that disbursement amount only distributed only to future installments (1st, 2nd and 3rd installments)
    When Admin sets the business date to "20230901"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                        | submitted on date | with Principal | ANNUAL interest rate % | interest type | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_DOWNPAYMENT_ADV_PMT_ALLOC_PROGRESSIVE_LOAN_SCHEDULE_HORIZONTAL | 20230901 | 1000           | 0                      | FLAT          | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 3                 | MONTHS                | 1              | MONTHS                 | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20230901" with "1000" amount and expected disbursement date on "20230901"
    When Admin successfully disburse the loan on "20230901" with "1000" EUR transaction amount
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20230901 |           | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 0    | 20230901 |           | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0  | 0.0        | 0.0  | 250.0       |
      | 2  | 30   | 20231001   |           | 500.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0  | 0.0        | 0.0  | 250.0       |
      | 3  | 31   | 20231101  |           | 250.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0  | 0.0        | 0.0  | 250.0       |
      | 4  | 30   | 20231201  |           | 0.0             | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0  | 0.0        | 0.0  | 250.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 1000.0        | 0.0      | 0.0  | 0.0       | 1000.0 | 0.0  | 0.0        | 0.0  | 1000.0      |
    When Admin adds "LOAN_SNOOZE_FEE" due date charge with "20230901" due date and 50 EUR transaction amount
    And Customer makes "AUTOPAY" repayment on "20230901" with 250 EUR transaction amount
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date         | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20230901 |                   | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 0    | 20230901 | 20230901 | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0  | 0.0         |
      | 2  | 30   | 20231001   |                   | 500.0           | 250.0         | 0.0      | 50.0 | 0.0       | 300.0 | 0.0   | 0.0        | 0.0  | 300.0       |
      | 3  | 31   | 20231101  |                   | 250.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0   | 0.0        | 0.0  | 250.0       |
      | 4  | 30   | 20231201  |                   | 0.0             | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0   | 0.0        | 0.0  | 250.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 1000.0        | 0.0      | 50.0 | 0.0       | 1050.0 | 250.0 | 0.0        | 0.0  | 800.0       |
    When Admin successfully disburse the loan on "20230901" with "400" EUR transaction amount
    Then Loan Repayment schedule has 5 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date         | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20230901 |                   | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      |    |      | 20230901 |                   | 400.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 0    | 20230901 | 20230901 | 1150.0          | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0  | 0.0         |
      | 2  | 0    | 20230901 |                   | 1050.0          | 100.0         | 0.0      | 0.0  | 0.0       | 100.0 | 0.0   | 0.0        | 0.0  | 100.0       |
      | 3  | 30   | 20231001   |                   | 700.0           | 350.0         | 0.0      | 50.0 | 0.0       | 400.0 | 0.0   | 0.0        | 0.0  | 400.0       |
      | 4  | 31   | 20231101  |                   | 350.0           | 350.0         | 0.0      | 0.0  | 0.0       | 350.0 | 0.0   | 0.0        | 0.0  | 350.0       |
      | 5  | 30   | 20231201  |                   | 0.0             | 350.0         | 0.0      | 0.0  | 0.0       | 350.0 | 0.0   | 0.0        | 0.0  | 350.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 1400.0        | 0.0      | 50.0 | 0.0       | 1450.0 | 250.0 | 0.0        | 0.0  | 1200.0      |

  @TestRailId:C2978 @AdvancedPaymentAllocation @ProgressiveLoanSchedule
  Scenario: Verify that multiple disbursement amount only distributed only to future installments (2nd and 3rd installments)
    When Admin sets the business date to "20230901"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                        | submitted on date | with Principal | ANNUAL interest rate % | interest type | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_DOWNPAYMENT_ADV_PMT_ALLOC_PROGRESSIVE_LOAN_SCHEDULE_HORIZONTAL | 20230901 | 1000           | 0                      | FLAT          | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 3                 | MONTHS                | 1              | MONTHS                 | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20230901" with "1000" amount and expected disbursement date on "20230901"
    When Admin successfully disburse the loan on "20230901" with "1000" EUR transaction amount
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20230901 |           | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 0    | 20230901 |           | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0  | 0.0        | 0.0  | 250.0       |
      | 2  | 30   | 20231001   |           | 500.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0  | 0.0        | 0.0  | 250.0       |
      | 3  | 31   | 20231101  |           | 250.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0  | 0.0        | 0.0  | 250.0       |
      | 4  | 30   | 20231201  |           | 0.0             | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0  | 0.0        | 0.0  | 250.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 1000.0        | 0.0      | 0.0  | 0.0       | 1000.0 | 0.0  | 0.0        | 0.0  | 1000.0      |
    When Admin adds "LOAN_SNOOZE_FEE" due date charge with "20230901" due date and 50 EUR transaction amount
    And Customer makes "AUTOPAY" repayment on "20230901" with 250 EUR transaction amount
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date         | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20230901 |                   | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 0    | 20230901 | 20230901 | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0  | 0.0         |
      | 2  | 30   | 20231001   |                   | 500.0           | 250.0         | 0.0      | 50.0 | 0.0       | 300.0 | 0.0   | 0.0        | 0.0  | 300.0       |
      | 3  | 31   | 20231101  |                   | 250.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0   | 0.0        | 0.0  | 250.0       |
      | 4  | 30   | 20231201  |                   | 0.0             | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0   | 0.0        | 0.0  | 250.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 1000.0        | 0.0      | 50.0 | 0.0       | 1050.0 | 250.0 | 0.0        | 0.0  | 800.0       |
    When Admin sets the business date to "20231001"
    When Admin successfully disburse the loan on "20231001" with "400" EUR transaction amount
    When Admin successfully disburse the loan on "20231001" with "80" EUR transaction amount
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date         | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20230901 |                   | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 0    | 20230901 | 20230901 | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0  | 0.0         |
      | 2  | 30   | 20231001   |                   | 500.0           | 250.0         | 0.0      | 50.0 | 0.0       | 300.0 | 0.0   | 0.0        | 0.0  | 300.0       |
      |    |      | 20231001   |                   | 400.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      |    |      | 20231001   |                   | 80.0            |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 3  | 0    | 20231001   |                   | 880.0           | 100.0         | 0.0      | 0.0  | 0.0       | 100.0 | 0.0   | 0.0        | 0.0  | 100.0       |
      | 4  | 0    | 20231001   |                   | 860.0           | 20.0          | 0.0      | 0.0  | 0.0       | 20.0  | 0.0   | 0.0        | 0.0  | 20.0        |
      | 5  | 31   | 20231101  |                   | 430.0           | 430.0         | 0.0      | 0.0  | 0.0       | 430.0 | 0.0   | 0.0        | 0.0  | 430.0       |
      | 6  | 30   | 20231201  |                   | 0.0             | 430.0         | 0.0      | 0.0  | 0.0       | 430.0 | 0.0   | 0.0        | 0.0  | 430.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 1480.0        | 0.0      | 50.0 | 0.0       | 1530.0 | 250.0 | 0.0        | 0.0  | 1280.0      |

  @TestRailId:C2986 @AdvancedPaymentAllocation
  Scenario: As an admin I would like to verify that refund is working with advanced payment allocation
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
    When Admin sets the business date to "20230111"
    When Admin adds "LOAN_SNOOZE_FEE" due date charge with "20230111" due date and 20 EUR transaction amount
    When Admin adds "LOAN_SNOOZE_FEE" due date charge with "20230121" due date and 20 EUR transaction amount
    When Admin adds "LOAN_SNOOZE_FEE" due date charge with "20230211" due date and 20 EUR transaction amount
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20230101  |                 | 500.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 0    | 20230101  | 20230101 | 375.0           | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 125.0 | 0.0        | 0.0  | 0.0         |
      | 2  | 15   | 20230116  |                 | 250.0           | 125.0         | 0.0      | 20.0 | 0.0       | 145.0 | 0.0   | 0.0        | 0.0  | 145.0       |
      | 3  | 15   | 20230131  |                 | 125.0           | 125.0         | 0.0      | 20.0 | 0.0       | 145.0 | 0.0   | 0.0        | 0.0  | 145.0       |
      | 4  | 15   | 20230215 |                 | 0.0             | 125.0         | 0.0      | 20.0 | 0.0       | 145.0 | 0.0   | 0.0        | 0.0  | 145.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      | 500.0         | 0        | 60.0 | 0         | 560.0 | 125.0 | 0          | 0    | 435.0       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties |
      | 20230101  | Disbursement     | 500.0  | 0.0       | 0.0      | 0.0  | 0.0       |
      | 20230101  | Down Payment     | 125.0  | 125.0     | 0.0      | 0.0  | 0.0       |
    When Admin sets the business date to "20230116"
    And Customer makes "AUTOPAY" repayment on "20230116" with 315 EUR transaction amount
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20230101  |                 | 500.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 0    | 20230101  | 20230101 | 375.0           | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 125.0 | 0.0        | 0.0  | 0.0         |
      | 2  | 15   | 20230116  | 20230116 | 250.0           | 125.0         | 0.0      | 20.0 | 0.0       | 145.0 | 145.0 | 0.0        | 0.0  | 0.0         |
      | 3  | 15   | 20230131  | 20230116 | 125.0           | 125.0         | 0.0      | 20.0 | 0.0       | 145.0 | 145.0 | 145.0      | 0.0  | 0.0         |
      | 4  | 15   | 20230215 |                 | 0.0             | 125.0         | 0.0      | 20.0 | 0.0       | 145.0 | 25.0  | 25.0       | 0.0  | 120.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      | 500.0         | 0        | 60.0 | 0         | 560.0 | 440.0 | 170        | 0    | 120.0       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties |
      | 20230101  | Disbursement     | 500.0  | 0.0       | 0.0      | 0.0  | 0.0       |
      | 20230101  | Down Payment     | 125.0  | 125.0     | 0.0      | 0.0  | 0.0       |
      | 20230116  | Repayment        | 315.0  | 255.0     | 0.0      | 60.0 | 0.0       |
    When Admin sets the business date to "20230117"
    And Admin makes "REFUND_BY_CASH" transaction with "AUTOPAY" payment type on "20230117" with 150 EUR transaction amount
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20230101  |                 | 500.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 0    | 20230101  | 20230101 | 375.0           | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 125.0 | 0.0        | 0.0  | 0.0         |
      | 2  | 15   | 20230116  | 20230116 | 250.0           | 125.0         | 0.0      | 20.0 | 0.0       | 145.0 | 145.0 | 0.0        | 0.0  | 0.0         |
      | 3  | 15   | 20230131  |                 | 125.0           | 125.0         | 0.0      | 20.0 | 0.0       | 145.0 | 20.0  | 20.0       | 0.0  | 125.0       |
      | 4  | 15   | 20230215 |                 | 0.0             | 125.0         | 0.0      | 20.0 | 0.0       | 145.0 | 0.0   | 0.0        | 0.0  | 145.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      | 500.0         | 0        | 60.0 | 0         | 560.0 | 290.0 | 20         | 0    | 270.0       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties |
      | 20230101  | Disbursement     | 500.0  | 0.0       | 0.0      | 0.0  | 0.0       |
      | 20230101  | Down Payment     | 125.0  | 125.0     | 0.0      | 0.0  | 0.0       |
      | 20230116  | Repayment        | 315.0  | 255.0     | 0.0      | 60.0 | 0.0       |
      | 20230117  | Refund           | 150.0  | 130.0     | 0.0      | 20.0 | 0.0       |

  @TestRailId:C3042 @AdvancedPaymentAllocation
  Scenario: Verify that second disbursement is working on overpaid accounts in case of NEXT_INSTALLMENT future installment allocation rule
    When Admin sets the business date to "20240101"
    When Admin creates a client with random data
    When Admin set "LP2_DOWNPAYMENT_AUTO_ADVANCED_PAYMENT_ALLOCATION" loan product "DEFAULT" transaction type to "NEXT_INSTALLMENT" future installment allocation rule
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                      | submitted on date | with Principal | ANNUAL interest rate % | interest type | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_DOWNPAYMENT_AUTO_ADVANCED_PAYMENT_ALLOCATION | 20240101   | 1000           | 0                      | FLAT          | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 45                | DAYS                  | 15             | DAYS                   | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240101" with "1000" amount and expected disbursement date on "20240101"
    When Admin successfully disburse the loan on "20240101" with "500" EUR transaction amount
    When Admin sets the business date to "20240116"
    And Customer makes "AUTOPAY" repayment on "20240116" with 500 EUR transaction amount
    Then Loan status will be "OVERPAID"
    Then Loan has 125 overpaid amount
    When Admin successfully disburse the loan on "20240116" with "500" EUR transaction amount
    Then Loan status will be "ACTIVE"
    Then Loan has 375 outstanding amount
    Then Loan Repayment schedule has 5 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101  |                 | 500.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 0    | 20240101  | 20240101 | 375.0           | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 125.0 | 0.0        | 0.0  | 0.0         |
      | 2  | 15   | 20240116  | 20240116 | 250.0           | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 125.0 | 0.0        | 0.0  | 0.0         |
      |    |      | 20240116  |                 | 500.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 3  | 0    | 20240116  | 20240116 | 625.0           | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 125.0 | 0.0        | 0.0  | 0.0         |
      | 4  | 15   | 20240131  |                 | 313.0           | 312.0         | 0.0      | 0.0  | 0.0       | 312.0 | 125.0 | 125.0      | 0.0  | 187.0       |
      | 5  | 15   | 20240215 |                 | 0.0             | 313.0         | 0.0      | 0.0  | 0.0       | 313.0 | 125.0 | 125.0      | 0.0  | 188.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 1000.0        | 0        | 0.0  | 0         | 1000.0 | 625.0 | 250.0      | 0    | 375.0       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20240101  | Disbursement     | 500.0  | 0.0       | 0.0      | 0.0  | 0.0       | 500.0        |
      | 20240101  | Down Payment     | 125.0  | 125.0     | 0.0      | 0.0  | 0.0       | 375.0        |
      | 20240116  | Repayment        | 500.0  | 375.0     | 0.0      | 0.0  | 0.0       | 0.0          |
      | 20240116  | Disbursement     | 500.0  | 0.0       | 0.0      | 0.0  | 0.0       | 375.0        |
    When Admin set "LP2_DOWNPAYMENT_AUTO_ADVANCED_PAYMENT_ALLOCATION" loan product "DEFAULT" transaction type to "NEXT_INSTALLMENT" future installment allocation rule

  @TestRailId:C3043 @AdvancedPaymentAllocation
  Scenario: Verify that second disbursement is working on overpaid accounts in case of REAMORTIZATION future installment allocation rule
    When Admin sets the business date to "20240101"
    When Admin creates a client with random data
    When Admin set "LP2_DOWNPAYMENT_AUTO_ADVANCED_PAYMENT_ALLOCATION" loan product "DEFAULT" transaction type to "REAMORTIZATION" future installment allocation rule
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                      | submitted on date | with Principal | ANNUAL interest rate % | interest type | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_DOWNPAYMENT_AUTO_ADVANCED_PAYMENT_ALLOCATION | 20240101   | 1000           | 0                      | FLAT          | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 45                | DAYS                  | 15             | DAYS                   | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240101" with "1000" amount and expected disbursement date on "20240101"
    When Admin successfully disburse the loan on "20240101" with "500" EUR transaction amount
    When Admin sets the business date to "20240116"
    When Customer makes "PAYOUT_REFUND" transaction with "AUTOPAY" payment type on "20240116" with 500 EUR transaction amount and system-generated Idempotency key
    Then Loan status will be "OVERPAID"
    Then Loan has 125 overpaid amount
    When Admin successfully disburse the loan on "20240116" with "500" EUR transaction amount
    Then Loan status will be "ACTIVE"
    Then Loan has 375 outstanding amount
    Then Loan Repayment schedule has 5 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240101  |                 | 500.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 0    | 20240101  | 20240101 | 375.0           | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 125.0 | 0.0        | 0.0  | 0.0         |
      | 2  | 15   | 20240116  | 20240116 | 250.0           | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 125.0 | 0.0        | 0.0  | 0.0         |
      |    |      | 20240116  |                 | 500.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 3  | 0    | 20240116  | 20240116 | 625.0           | 125.0         | 0.0      | 0.0  | 0.0       | 125.0 | 125.0 | 0.0        | 0.0  | 0.0         |
      | 4  | 15   | 20240131  |                 | 313.0           | 312.0         | 0.0      | 0.0  | 0.0       | 312.0 | 125.0 | 125.0      | 0.0  | 187.0       |
      | 5  | 15   | 20240215 |                 | 0.0             | 313.0         | 0.0      | 0.0  | 0.0       | 313.0 | 125.0 | 125.0      | 0.0  | 188.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 1000.0        | 0        | 0.0  | 0         | 1000.0 | 625.0 | 250.0      | 0    | 375.0       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20240101  | Disbursement     | 500.0  | 0.0       | 0.0      | 0.0  | 0.0       | 500.0        |
      | 20240101  | Down Payment     | 125.0  | 125.0     | 0.0      | 0.0  | 0.0       | 375.0        |
      | 20240116  | Payout Refund    | 500.0  | 375.0     | 0.0      | 0.0  | 0.0       | 0.0          |
      | 20240116  | Disbursement     | 500.0  | 0.0       | 0.0      | 0.0  | 0.0       | 375.0        |
    When Admin set "LP2_DOWNPAYMENT_AUTO_ADVANCED_PAYMENT_ALLOCATION" loan product "DEFAULT" transaction type to "NEXT_INSTALLMENT" future installment allocation rule

  @TestRailId:C3046 @AdvancedPaymentAllocation
  Scenario: Verify that principal due is correct in case of second disbursement on overpaid loan
    When Admin sets the business date to "20240201"
    When Admin creates a client with random data
    When Admin set "LP2_DOWNPAYMENT_AUTO_ADVANCED_PAYMENT_ALLOCATION" loan product "DEFAULT" transaction type to "REAMORTIZATION" future installment allocation rule
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                      | submitted on date | with Principal | ANNUAL interest rate % | interest type | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_DOWNPAYMENT_AUTO_ADVANCED_PAYMENT_ALLOCATION | 20240201  | 1000           | 0                      | FLAT          | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 45                | DAYS                  | 15             | DAYS                   | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240201" with "1000" amount and expected disbursement date on "20240201"
    When Admin successfully disburse the loan on "20240201" with "200" EUR transaction amount
    When Admin sets the business date to "20240202"
    When Customer makes "PAYOUT_REFUND" transaction with "AUTOPAY" payment type on "20240202" with 200 EUR transaction amount and system-generated Idempotency key
    Then Loan status will be "OVERPAID"
    Then Loan has 50 overpaid amount
    When Admin successfully disburse the loan on "20240202" with "160" EUR transaction amount
    Then Loan Repayment schedule has 5 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due  | Paid  | In advance | Late | Outstanding |
      |    |      | 20240201 |                  | 200.0           |               |          | 0.0  |           | 0.0  | 0.0   |            |      |             |
      | 1  | 0    | 20240201 | 20240201 | 150.0           | 50.0          | 0.0      | 0.0  | 0.0       | 50.0 | 50.0  | 0.0        | 0.0  | 0.0         |
      |    |      | 20240202 |                  | 160.0           |               |          | 0.0  |           | 0.0  | 0.0   |            |      |             |
      | 2  | 0    | 20240202 | 20240202 | 270.0           | 40.0          | 0.0      | 0.0  | 0.0       | 40.0 | 40.0  | 0.0        | 0.0  | 0.0         |
      | 3  | 15   | 20240216 |                  | 180.0           | 90.0          | 0.0      | 0.0  | 0.0       | 90.0 | 53.33 | 53.33      | 0.0  | 36.67       |
      | 4  | 15   | 20240302    |                  | 90.0            | 90.0          | 0.0      | 0.0  | 0.0       | 90.0 | 53.33 | 53.33      | 0.0  | 36.67       |
      | 5  | 15   | 20240317    |                  | 0.0             | 90.0          | 0.0      | 0.0  | 0.0       | 90.0 | 53.34 | 53.34      | 0.0  | 36.66       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      | 360.0         | 0        | 0.0  | 0         | 360.0 | 250.0 | 160.0      | 0    | 110.0       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20240201 | Disbursement     | 200.0  | 0.0       | 0.0      | 0.0  | 0.0       | 200.0        |
      | 20240201 | Down Payment     | 50.0   | 50.0      | 0.0      | 0.0  | 0.0       | 150.0        |
      | 20240202 | Payout Refund    | 200.0  | 150.0     | 0.0      | 0.0  | 0.0       | 0.0          |
      | 20240202 | Disbursement     | 160.0  | 0.0       | 0.0      | 0.0  | 0.0       | 110.0        |
    When Admin set "LP2_DOWNPAYMENT_AUTO_ADVANCED_PAYMENT_ALLOCATION" loan product "DEFAULT" transaction type to "NEXT_INSTALLMENT" future installment allocation rule

  @TestRailId:C3049 @AdvancedPaymentAllocation
  Scenario: Verify that second disbursement on overpaid loan is correct when disbursement amount is lower than overpayment amount
    When Admin sets the business date to "20240201"
    When Admin creates a client with random data
    When Admin set "LP2_DOWNPAYMENT_AUTO_ADVANCED_PAYMENT_ALLOCATION" loan product "DEFAULT" transaction type to "REAMORTIZATION" future installment allocation rule
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                      | submitted on date | with Principal | ANNUAL interest rate % | interest type | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_DOWNPAYMENT_AUTO_ADVANCED_PAYMENT_ALLOCATION | 20240201  | 1000           | 0                      | FLAT          | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 45                | DAYS                  | 15             | DAYS                   | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240201" with "1000" amount and expected disbursement date on "20240201"
    When Admin successfully disburse the loan on "20240201" with "200" EUR transaction amount
    When Admin sets the business date to "20240202"
    When Customer makes "PAYOUT_REFUND" transaction with "AUTOPAY" payment type on "20240202" with 200 EUR transaction amount and system-generated Idempotency key
    Then Loan status will be "OVERPAID"
    Then Loan has 50 overpaid amount
    When Admin successfully disburse the loan on "20240202" with "28" EUR transaction amount
    Then Loan Repayment schedule has 5 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due  | Paid | In advance | Late | Outstanding |
      |    |      | 20240201 |                  | 200.0           |               |          | 0.0  |           | 0.0  | 0.0  |            |      |             |
      | 1  | 0    | 20240201 | 20240201 | 150.0           | 50.0          | 0.0      | 0.0  | 0.0       | 50.0 | 50.0 | 0.0        | 0.0  | 0.0         |
      |    |      | 20240202 |                  | 28.0            |               |          | 0.0  |           | 0.0  | 0.0  |            |      |             |
      | 2  | 0    | 20240202 | 20240202 | 171.0           | 7.0           | 0.0      | 0.0  | 0.0       | 7.0  | 7.0  | 0.0        | 0.0  | 0.0         |
      | 3  | 15   | 20240216 | 20240202 | 114.0           | 57.0          | 0.0      | 0.0  | 0.0       | 57.0 | 57.0 | 57.0       | 0.0  | 0.0         |
      | 4  | 15   | 20240302    | 20240202 | 57.0            | 57.0          | 0.0      | 0.0  | 0.0       | 57.0 | 57.0 | 57.0       | 0.0  | 0.0         |
      | 5  | 15   | 20240317    | 20240202 | 0.0             | 57.0          | 0.0      | 0.0  | 0.0       | 57.0 | 57.0 | 57.0       | 0.0  | 0.0         |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      | 228.0         | 0        | 0.0  | 0         | 228.0 | 228.0 | 171.0      | 0    | 0.0         |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20240201 | Disbursement     | 200.0  | 0.0       | 0.0      | 0.0  | 0.0       | 200.0        |
      | 20240201 | Down Payment     | 50.0   | 50.0      | 0.0      | 0.0  | 0.0       | 150.0        |
      | 20240202 | Payout Refund    | 200.0  | 150.0     | 0.0      | 0.0  | 0.0       | 0.0          |
      | 20240202 | Disbursement     | 28.0   | 0.0       | 0.0      | 0.0  | 0.0       | 0.0          |
    Then Loan status will be "OVERPAID"
    Then Loan has 22 overpaid amount
    When Admin set "LP2_DOWNPAYMENT_AUTO_ADVANCED_PAYMENT_ALLOCATION" loan product "DEFAULT" transaction type to "NEXT_INSTALLMENT" future installment allocation rule

  @TestRailId:C3068 @AdvancedPaymentAllocation
  Scenario: Verify that Fraud flag can be applied on loan is its every status
    When Admin sets the business date to "20240201"
    When Admin creates a client with random data
    When Admin set "LP2_DOWNPAYMENT_AUTO_ADVANCED_PAYMENT_ALLOCATION" loan product "DEFAULT" transaction type to "NEXT_INSTALLMENT" future installment allocation rule
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                      | submitted on date | with Principal | ANNUAL interest rate % | interest type | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_DOWNPAYMENT_AUTO_ADVANCED_PAYMENT_ALLOCATION | 20240201  | 1000           | 0                      | FLAT          | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 45                | DAYS                  | 15             | DAYS                   | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    Then Loan status will be "SUBMITTED_AND_PENDING_APPROVAL"
    Then Admin can successfully set Fraud flag to the loan
    Then Admin can successfully unset Fraud flag to the loan
    And Admin successfully approves the loan on "20240201" with "1000" amount and expected disbursement date on "20240201"
    Then Loan status will be "APPROVED"
    Then Admin can successfully set Fraud flag to the loan
    Then Admin can successfully unset Fraud flag to the loan
    When Admin successfully disburse the loan on "20240201" with "1000" EUR transaction amount
    Then Loan status will be "ACTIVE"
    Then Admin can successfully set Fraud flag to the loan
    Then Admin can successfully unset Fraud flag to the loan
    When Admin sets the business date to "20240202"
    And Customer makes "AUTOPAY" repayment on "20240202" with 100 EUR transaction amount
    Then Loan status will be "ACTIVE"
    Then Admin can successfully set Fraud flag to the loan
    Then Admin can successfully unset Fraud flag to the loan
    When Admin sets the business date to "20240203"
    And Customer makes "AUTOPAY" repayment on "20240203" with 750 EUR transaction amount
    Then Loan status will be "OVERPAID"
    Then Loan has 100 overpaid amount
    Then Admin can successfully set Fraud flag to the loan
    Then Admin can successfully unset Fraud flag to the loan
    When Admin sets the business date to "20240204"
    When Customer undo "1"th "Repayment" transaction made on "20240202"
    Then Loan status will be "CLOSED_OBLIGATIONS_MET"
    Then Admin can successfully set Fraud flag to the loan
    Then Admin can successfully unset Fraud flag to the loan

  @TestRailId:C3090
  Scenario: Verify that disbursement can be done on overpaid loan in case of cummulative loan schedule
    When Admin sets the business date to "20240201"
    When Admin creates a client with random data
    When Admin set "LP2_DOWNPAYMENT_AUTO_ADVANCED_PAYMENT_ALLOCATION" loan product "DEFAULT" transaction type to "NEXT_INSTALLMENT" future installment allocation rule
    When Admin creates a fully customized loan with the following data:
      | LoanProduct          | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy                                                             |
      | LP2_DOWNPAYMENT_AUTO | 20240201  | 1000           | 0                      | DECLINING_BALANCE | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 3                 | MONTHS                | 1              | MONTHS                 | 3                  | 0                       | 0                      | 0                    | DUE_PENALTY_INTEREST_PRINCIPAL_FEE_IN_ADVANCE_PENALTY_INTEREST_PRINCIPAL_FEE |
    And Admin successfully approves the loan on "20240201" with "1000" amount and expected disbursement date on "20240201"
    When Admin successfully disburse the loan on "20240201" with "1000" EUR transaction amount
    When Admin sets the business date to "20240202"
    And Customer makes "AUTOPAY" repayment on "20240202" with 800 EUR transaction amount
    Then Loan status will be "OVERPAID"
    Then Loan has 50 overpaid amount
    When Admin sets the business date to "20240203"
    When Admin successfully disburse the loan on "20240203" with "20" EUR transaction amount
    Then Loan status will be "OVERPAID"
    Then Loan has 30 overpaid amount
    Then Loan Repayment schedule has 5 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240201 |                  | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 0    | 20240201 | 20240201 | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0  | 0.0         |
      |    |      | 20240203 |                  | 20.0            |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 2  | 0    | 20240203 | 20240202 | 765.0           | 5.0           | 0.0      | 0.0  | 0.0       | 5.0   | 5.0   | 5.0        | 0.0  | 0.0         |
      | 3  | 29   | 20240301    | 20240202 | 510.0           | 255.0         | 0.0      | 0.0  | 0.0       | 255.0 | 255.0 | 255.0      | 0.0  | 0.0         |
      | 4  | 31   | 20240401    | 20240202 | 255.0           | 255.0         | 0.0      | 0.0  | 0.0       | 255.0 | 255.0 | 255.0      | 0.0  | 0.0         |
      | 5  | 30   | 20240501      | 20240202 | 0.0             | 255.0         | 0.0      | 0.0  | 0.0       | 255.0 | 255.0 | 255.0      | 0.0  | 0.0         |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late | Outstanding |
      | 1020.0        | 0        | 0.0  | 0         | 1020.0 | 1020.0 | 770.0      | 0    | 0.0         |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20240201 | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
      | 20240201 | Down Payment     | 250.0  | 250.0     | 0.0      | 0.0  | 0.0       | 750.0        |
      | 20240202 | Repayment        | 800.0  | 770.0     | 0.0      | 0.0  | 0.0       | 0.0          |
      | 20240203 | Disbursement     | 20.0   | 0.0       | 0.0      | 0.0  | 0.0       | 0.0          |
    When Admin sets the business date to "20240204"
    When Admin successfully disburse the loan on "20240204" with "30" EUR transaction amount
    Then Loan status will be "CLOSED_OBLIGATIONS_MET"
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240201 |                  | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 0    | 20240201 | 20240201 | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0  | 0.0         |
      |    |      | 20240203 |                  | 20.0            |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 2  | 0    | 20240203 | 20240202 | 765.0           | 5.0           | 0.0      | 0.0  | 0.0       | 5.0   | 5.0   | 5.0        | 0.0  | 0.0         |
      |    |      | 20240204 |                  | 30.0            |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 3  | 0    | 20240204 | 20240202 | 787.0           | 8.0           | 0.0      | 0.0  | 0.0       | 8.0   | 8.0   | 8.0        | 0.0  | 0.0         |
      | 4  | 29   | 20240301    | 20240202 | 524.0           | 263.0         | 0.0      | 0.0  | 0.0       | 263.0 | 263.0 | 263.0      | 0.0  | 0.0         |
      | 5  | 31   | 20240401    | 20240202 | 261.0           | 263.0         | 0.0      | 0.0  | 0.0       | 263.0 | 263.0 | 263.0      | 0.0  | 0.0         |
      | 6  | 30   | 20240501      | 20240202 | 0.0             | 261.0         | 0.0      | 0.0  | 0.0       | 261.0 | 261.0 | 261.0      | 0.0  | 0.0         |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late | Outstanding |
      | 1050.0        | 0        | 0.0  | 0         | 1050.0 | 1050.0 | 800.0      | 0    | 0.0         |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20240201 | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
      | 20240201 | Down Payment     | 250.0  | 250.0     | 0.0      | 0.0  | 0.0       | 750.0        |
      | 20240202 | Repayment        | 800.0  | 800.0     | 0.0      | 0.0  | 0.0       | 0.0          |
      | 20240203 | Disbursement     | 20.0   | 0.0       | 0.0      | 0.0  | 0.0       | 0.0          |
      | 20240204 | Disbursement     | 30.0   | 0.0       | 0.0      | 0.0  | 0.0       | 0.0          |
    When Admin sets the business date to "20240205"
    When Admin successfully disburse the loan on "20240205" with "40" EUR transaction amount
    Then Loan status will be "ACTIVE"
    Then Loan has 30 outstanding amount
    Then Loan Repayment schedule has 7 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240201 |                  | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 0    | 20240201 | 20240201 | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0  | 0.0         |
      |    |      | 20240203 |                  | 20.0            |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 2  | 0    | 20240203 | 20240202 | 765.0           | 5.0           | 0.0      | 0.0  | 0.0       | 5.0   | 5.0   | 5.0        | 0.0  | 0.0         |
      |    |      | 20240204 |                  | 30.0            |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 3  | 0    | 20240204 | 20240202 | 787.0           | 8.0           | 0.0      | 0.0  | 0.0       | 8.0   | 8.0   | 8.0        | 0.0  | 0.0         |
      |    |      | 20240205 |                  | 40.0            |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 4  | 0    | 20240205 | 20240202 | 817.0           | 10.0          | 0.0      | 0.0  | 0.0       | 10.0  | 10.0  | 10.0       | 0.0  | 0.0         |
      | 5  | 29   | 20240301    | 20240202 | 544.0           | 273.0         | 0.0      | 0.0  | 0.0       | 273.0 | 273.0 | 273.0      | 0.0  | 0.0         |
      | 6  | 31   | 20240401    | 20240202 | 271.0           | 273.0         | 0.0      | 0.0  | 0.0       | 273.0 | 273.0 | 273.0      | 0.0  | 0.0         |
      | 7  | 30   | 20240501      |                  | 0.0             | 271.0         | 0.0      | 0.0  | 0.0       | 271.0 | 241.0 | 241.0      | 0.0  | 30.0        |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late | Outstanding |
      | 1090.0        | 0        | 0.0  | 0         | 1090.0 | 1060.0 | 810.0      | 0    | 30.0        |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20240201 | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
      | 20240201 | Down Payment     | 250.0  | 250.0     | 0.0      | 0.0  | 0.0       | 750.0        |
      | 20240202 | Repayment        | 800.0  | 800.0     | 0.0      | 0.0  | 0.0       | 0.0          |
      | 20240203 | Disbursement     | 20.0   | 0.0       | 0.0      | 0.0  | 0.0       | 0.0          |
      | 20240204 | Disbursement     | 30.0   | 0.0       | 0.0      | 0.0  | 0.0       | 0.0          |
      | 20240205 | Disbursement     | 40.0   | 0.0       | 0.0      | 0.0  | 0.0       | 40.0         |
      | 20240205 | Down Payment     | 10.0   | 10.0      | 0.0      | 0.0  | 0.0       | 30.0         |

  @TestRailId:C3103
  Scenario: Verify that fixed length in loan product is inherited by loan account
    When Admin sets the business date to "20240201"
    When Admin creates a client with random data
    When Admin set "LP2_DOWNPAYMENT_AUTO_ADVANCED_PAYMENT_ALLOCATION" loan product "DEFAULT" transaction type to "NEXT_INSTALLMENT" future installment allocation rule
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                | submitted on date | with Principal | ANNUAL interest rate % | interest type | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_DOWNPAYMENT_ADV_PMT_ALLOC_FIXED_LENGTH | 20240201  | 1000           | 0                      | FLAT          | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 3                 | MONTHS                | 1              | MONTHS                 | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240201" with "1000" amount and expected disbursement date on "20240201"
    When Admin successfully disburse the loan on "20240201" with "1000" EUR transaction amount
    Then LoanDetails has fixedLength field with int value: 90

  @TestRailId:C3104
  Scenario: Verify that fixed length in loan product can be overwrote upon loan account creation
    When Admin sets the business date to "20240201"
    When Admin creates a client with random data
    When Admin set "LP2_DOWNPAYMENT_AUTO_ADVANCED_PAYMENT_ALLOCATION" loan product "DEFAULT" transaction type to "NEXT_INSTALLMENT" future installment allocation rule
    When Admin creates a fully customized loan with fixed length 60 and with the following data:
      | LoanProduct                                | submitted on date | with Principal | ANNUAL interest rate % | interest type | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_DOWNPAYMENT_ADV_PMT_ALLOC_FIXED_LENGTH | 20240201  | 1000           | 0                      | FLAT          | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 3                 | MONTHS                | 1              | MONTHS                 | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240201" with "1000" amount and expected disbursement date on "20240201"
    When Admin successfully disburse the loan on "20240201" with "1000" EUR transaction amount
    Then LoanDetails has fixedLength field with int value: 60

  @TestRailId:C3119
  Scenario: Verify fixed length loan account Loan schedule - UC1: loan account with fixed length of 40 days (loanTermFrequency: 45 days)
    When Admin sets the business date to "20240201"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with fixed length 40 and with the following data:
      | LoanProduct                                | submitted on date | with Principal | ANNUAL interest rate % | interest type | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_DOWNPAYMENT_ADV_PMT_ALLOC_FIXED_LENGTH | 20240201  | 1000           | 0                      | FLAT          | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 45                | DAYS                  | 15             | DAYS                   | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240201" with "1000" amount and expected disbursement date on "20240201"
    When Admin successfully disburse the loan on "20240201" with "1000" EUR transaction amount
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20240201 |           | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 0    | 20240201 |           | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0  | 0.0        | 0.0  | 250.0       |
      | 2  | 15   | 20240216 |           | 500.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0  | 0.0        | 0.0  | 250.0       |
      | 3  | 15   | 20240302    |           | 250.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0  | 0.0        | 0.0  | 250.0       |
      | 4  | 10   | 20240312    |           | 0.0             | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0  | 0.0        | 0.0  | 250.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 1000.0        | 0        | 0.0  | 0         | 1000.0 | 0.0  | 0.0        | 0    | 1000.0      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20240201 | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |

  @TestRailId:C3120
  Scenario: Verify fixed length loan account Loan schedule - UC2: loan account with fixed length of 50 days (loanTermFrequency: 45 days)
    When Admin sets the business date to "20240201"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with fixed length 50 and with the following data:
      | LoanProduct                                | submitted on date | with Principal | ANNUAL interest rate % | interest type | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_DOWNPAYMENT_ADV_PMT_ALLOC_FIXED_LENGTH | 20240201  | 1000           | 0                      | FLAT          | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 45                | DAYS                  | 15             | DAYS                   | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240201" with "1000" amount and expected disbursement date on "20240201"
    When Admin successfully disburse the loan on "20240201" with "1000" EUR transaction amount
    Then LoanDetails has fixedLength field with int value: 50
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20240201 |           | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 0    | 20240201 |           | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0  | 0.0        | 0.0  | 250.0       |
      | 2  | 15   | 20240216 |           | 500.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0  | 0.0        | 0.0  | 250.0       |
      | 3  | 15   | 20240302    |           | 250.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0  | 0.0        | 0.0  | 250.0       |
      | 4  | 20   | 20240322    |           | 0.0             | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0  | 0.0        | 0.0  | 250.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 1000.0        | 0        | 0.0  | 0         | 1000.0 | 0.0  | 0.0        | 0    | 1000.0      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20240201 | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |

  @TestRailId:C3121
  Scenario: Verify fixed length loan account Loan schedule - UC3: loan account with fixed length of 5 weeks (loanTermFrequency: 6 weeks)
    When Admin sets the business date to "20240201"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with fixed length 5 and with the following data:
      | LoanProduct                                | submitted on date | with Principal | ANNUAL interest rate % | interest type | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_DOWNPAYMENT_ADV_PMT_ALLOC_FIXED_LENGTH | 20240201  | 1000           | 0                      | FLAT          | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 6                 | WEEKS                 | 2              | WEEKS                  | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240201" with "1000" amount and expected disbursement date on "20240201"
    When Admin successfully disburse the loan on "20240201" with "1000" EUR transaction amount
    Then LoanDetails has fixedLength field with int value: 5
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20240201 |           | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 0    | 20240201 |           | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0  | 0.0        | 0.0  | 250.0       |
      | 2  | 14   | 20240215 |           | 500.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0  | 0.0        | 0.0  | 250.0       |
      | 3  | 14   | 20240229 |           | 250.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0  | 0.0        | 0.0  | 250.0       |
      | 4  | 7    | 20240307    |           | 0.0             | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0  | 0.0        | 0.0  | 250.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 1000.0        | 0        | 0.0  | 0         | 1000.0 | 0.0  | 0.0        | 0    | 1000.0      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20240201 | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |

  @TestRailId:C3122
  Scenario: Verify fixed length loan account Loan schedule - UC4: loan account with fixed length of 7 weeks (loanTermFrequency: 6 weeks)
    When Admin sets the business date to "20240201"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with fixed length 7 and with the following data:
      | LoanProduct                                | submitted on date | with Principal | ANNUAL interest rate % | interest type | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_DOWNPAYMENT_ADV_PMT_ALLOC_FIXED_LENGTH | 20240201  | 1000           | 0                      | FLAT          | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 6                 | WEEKS                 | 2              | WEEKS                  | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240201" with "1000" amount and expected disbursement date on "20240201"
    When Admin successfully disburse the loan on "20240201" with "1000" EUR transaction amount
    Then LoanDetails has fixedLength field with int value: 7
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20240201 |           | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 0    | 20240201 |           | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0  | 0.0        | 0.0  | 250.0       |
      | 2  | 14   | 20240215 |           | 500.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0  | 0.0        | 0.0  | 250.0       |
      | 3  | 14   | 20240229 |           | 250.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0  | 0.0        | 0.0  | 250.0       |
      | 4  | 21   | 20240321    |           | 0.0             | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0  | 0.0        | 0.0  | 250.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 1000.0        | 0        | 0.0  | 0         | 1000.0 | 0.0  | 0.0        | 0    | 1000.0      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20240201 | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |

  @TestRailId:C3123
  Scenario: Verify fixed length loan account Loan schedule - UC5: loan account with fixed length of 5 months (loanTermFrequency: 6 months)
    When Admin sets the business date to "20240201"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with fixed length 5 and with the following data:
      | LoanProduct                                | submitted on date | with Principal | ANNUAL interest rate % | interest type | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_DOWNPAYMENT_ADV_PMT_ALLOC_FIXED_LENGTH | 20240201  | 1000           | 0                      | FLAT          | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 6                 | MONTHS                | 2              | MONTHS                 | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240201" with "1000" amount and expected disbursement date on "20240201"
    When Admin successfully disburse the loan on "20240201" with "1000" EUR transaction amount
    Then LoanDetails has fixedLength field with int value: 5
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20240201 |           | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 0    | 20240201 |           | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0  | 0.0        | 0.0  | 250.0       |
      | 2  | 60   | 20240401    |           | 500.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0  | 0.0        | 0.0  | 250.0       |
      | 3  | 61   | 20240601     |           | 250.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0  | 0.0        | 0.0  | 250.0       |
      | 4  | 30   | 20240701     |           | 0.0             | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0  | 0.0        | 0.0  | 250.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 1000.0        | 0        | 0.0  | 0         | 1000.0 | 0.0  | 0.0        | 0    | 1000.0      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20240201 | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |

  @TestRailId:C3124
  Scenario: Verify fixed length loan account Loan schedule - UC6: loan account with fixed length of 7 months (loanTermFrequency: 6 months)
    When Admin sets the business date to "20240201"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with fixed length 7 and with the following data:
      | LoanProduct                                | submitted on date | with Principal | ANNUAL interest rate % | interest type | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_DOWNPAYMENT_ADV_PMT_ALLOC_FIXED_LENGTH | 20240201  | 1000           | 0                      | FLAT          | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 6                 | MONTHS                | 2              | MONTHS                 | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240201" with "1000" amount and expected disbursement date on "20240201"
    When Admin successfully disburse the loan on "20240201" with "1000" EUR transaction amount
    Then LoanDetails has fixedLength field with int value: 7
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20240201  |           | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 0    | 20240201  |           | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0  | 0.0        | 0.0  | 250.0       |
      | 2  | 60   | 20240401     |           | 500.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0  | 0.0        | 0.0  | 250.0       |
      | 3  | 61   | 20240601      |           | 250.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0  | 0.0        | 0.0  | 250.0       |
      | 4  | 92   | 20240901 |           | 0.0             | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0  | 0.0        | 0.0  | 250.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 1000.0        | 0        | 0.0  | 0         | 1000.0 | 0.0  | 0.0        | 0    | 1000.0      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20240201 | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |

  @TestRailId:C3125
  Scenario: Verify fixed length loan account Loan schedule - UC7: loan account with fixed length of 5 months but 6 month period / repayment in every 1 month results an ERROR
    When Admin sets the business date to "20240201"
    When Admin creates a client with random data
    When Trying to create a fully customized loan with fixed length 5 and with the following data will result a 403 ERROR:
      | LoanProduct                                | submitted on date | with Principal | ANNUAL interest rate % | interest type | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_DOWNPAYMENT_ADV_PMT_ALLOC_FIXED_LENGTH | 20240201  | 1000           | 0                      | FLAT          | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 6                 | MONTHS                | 1              | MONTHS                 | 6                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |

  @TestRailId:C3126
  Scenario: Verify fixed length loan account Loan schedule - UC8: Reschedule by date a loan account with fixed length of 40 days
    When Admin sets the business date to "20240201"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with fixed length 40 and with the following data:
      | LoanProduct                                | submitted on date | with Principal | ANNUAL interest rate % | interest type | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_DOWNPAYMENT_ADV_PMT_ALLOC_FIXED_LENGTH | 20240201  | 1000           | 0                      | FLAT          | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 45                | DAYS                  | 15             | DAYS                   | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240201" with "1000" amount and expected disbursement date on "20240201"
    When Admin successfully disburse the loan on "20240201" with "1000" EUR transaction amount
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20240201 |           | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 0    | 20240201 |           | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0  | 0.0        | 0.0  | 250.0       |
      | 2  | 15   | 20240216 |           | 500.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0  | 0.0        | 0.0  | 250.0       |
      | 3  | 15   | 20240302    |           | 250.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0  | 0.0        | 0.0  | 250.0       |
      | 4  | 10   | 20240312    |           | 0.0             | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0  | 0.0        | 0.0  | 250.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 1000.0        | 0        | 0.0  | 0         | 1000.0 | 0.0  | 0.0        | 0    | 1000.0      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20240201 | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
    When Admin sets the business date to "20240302"
    When Admin creates and approves Loan reschedule with the following data:
      | rescheduleFromDate | submittedOnDate | adjustedDueDate | graceOnPrincipal | graceOnInterest | extraTerms | newInterestRate |
      | 20240302      | 20240302   | 20240320   |                  |                 |            |                 |
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20240201 |           | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 0    | 20240201 |           | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0  | 0.0        | 0.0  | 250.0       |
      | 2  | 15   | 20240216 |           | 500.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0  | 0.0        | 0.0  | 250.0       |
      | 3  | 33   | 20240320    |           | 250.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0  | 0.0        | 0.0  | 250.0       |
      | 4  | 10   | 20240330    |           | 0.0             | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0  | 0.0        | 0.0  | 250.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 1000.0        | 0        | 0.0  | 0         | 1000.0 | 0.0  | 0.0        | 0    | 1000.0      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20240201 | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |

  @TestRailId:C3127
  Scenario: Verify fixed length loan account Loan schedule - UC9: Reschedule by extra terms a loan account with fixed length of 40 days
    When Admin sets the business date to "20240201"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with fixed length 40 and with the following data:
      | LoanProduct                                | submitted on date | with Principal | ANNUAL interest rate % | interest type | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_DOWNPAYMENT_ADV_PMT_ALLOC_FIXED_LENGTH | 20240201  | 1000           | 0                      | FLAT          | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 45                | DAYS                  | 15             | DAYS                   | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240201" with "1000" amount and expected disbursement date on "20240201"
    When Admin successfully disburse the loan on "20240201" with "1000" EUR transaction amount
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20240201 |           | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 0    | 20240201 |           | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0  | 0.0        | 0.0  | 250.0       |
      | 2  | 15   | 20240216 |           | 500.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0  | 0.0        | 0.0  | 250.0       |
      | 3  | 15   | 20240302    |           | 250.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0  | 0.0        | 0.0  | 250.0       |
      | 4  | 10   | 20240312    |           | 0.0             | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0  | 0.0        | 0.0  | 250.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 1000.0        | 0        | 0.0  | 0         | 1000.0 | 0.0  | 0.0        | 0    | 1000.0      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20240201 | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
    When Admin sets the business date to "20240216"
    When Admin creates and approves Loan reschedule with the following data:
      | rescheduleFromDate | submittedOnDate  | adjustedDueDate | graceOnPrincipal | graceOnInterest | extraTerms | newInterestRate |
      | 20240216   | 20240216 |                 |                  |                 | 2          |                 |
    # Verify Progressive Loan reschedule behavior - future installments recalculated
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20240201 |           | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 0    | 20240201 |           | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 0.0  | 0.0        | 0.0  | 250.0       |
      | 2  | 15   | 20240216 |           | 600.0           | 150.0         | 0.0      | 0.0  | 0.0       | 150.0 | 0.0  | 0.0        | 0.0  | 150.0       |
      | 3  | 15   | 20240302    |           | 450.0           | 150.0         | 0.0      | 0.0  | 0.0       | 150.0 | 0.0  | 0.0        | 0.0  | 150.0       |
      | 4  | 10   | 20240312    |           | 300.0           | 150.0         | 0.0      | 0.0  | 0.0       | 150.0 | 0.0  | 0.0        | 0.0  | 150.0       |
      | 5  | 20   | 20240401    |           | 150.0           | 150.0         | 0.0      | 0.0  | 0.0       | 150.0 | 0.0  | 0.0        | 0.0  | 150.0       |
      | 6  | 15   | 20240416    |           | 0.0             | 150.0         | 0.0      | 0.0  | 0.0       | 150.0 | 0.0  | 0.0        | 0.0  | 150.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 1000.0        | 0        | 0.0  | 0         | 1000.0 | 0.0  | 0.0        | 0    | 1000.0      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20240201 | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |

  @TestRailId:C3192
  Scenario: Verify that the error message is correct in case of the actual disbursement date is in the past with advanced payment allocation product + submitted on date repaymentStartDateType
    When Admin sets repaymentStartDateType for "LP2_DOWNPAYMENT_AUTO_ADVANCED_PAYMENT_ALLOCATION" loan product to "SUBMITTED_ON_DATE"
    When Admin set "LP2_DOWNPAYMENT_AUTO_ADVANCED_PAYMENT_ALLOCATION" loan product "DEFAULT" transaction type to "NEXT_INSTALLMENT" future installment allocation rule
    When Admin sets the business date to "20230101"
    And Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                      | submitted on date | with Principal | ANNUAL interest rate % | interest type | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_DOWNPAYMENT_AUTO_ADVANCED_PAYMENT_ALLOCATION | 20230101   | 500            | 0                      | FLAT          | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 45                | DAYS                  | 15             | DAYS                   | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20230101" with "500" amount and expected disbursement date on "20230101"
    Then Loan status has changed to "Approved"
    Then Admin fails to disburse the loan on "20221231" with "500" EUR transaction amount because disbursement date is earlier than "20230101"
    When Admin sets repaymentStartDateType for "LP2_DOWNPAYMENT_AUTO_ADVANCED_PAYMENT_ALLOCATION" loan product to "DISBURSEMENT_DATE"

  @TestRailId:C3242
  Scenario: Verify that there are no restriction on repayment reversal for overpaid loan for interest bearing product
    When Admin sets the business date to "20240623"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                        | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_EMI_360_30_INTEREST_RECALCULATION_DAILY_TILL_PRECLOSE | 20240623       | 400            | 0                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 30                | DAYS                  | 30             | DAYS                   | 1                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240623" with "400" amount and expected disbursement date on "20240623"
    When Admin successfully disburse the loan on "20240623" with "400" EUR transaction amount
    And Admin sets the business date to "20240624"
    And Customer makes "AUTOPAY" repayment on "20240624" with 100 EUR transaction amount
    Then Loan Repayment schedule has 1 periods, with the following data for periods:
      | Nr | Days | Date         | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240623 |           | 400.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 30   | 20240723 |           | 0.0             | 400.0         | 0.0      | 0.0  | 0.0       | 400.0 | 100.0 | 100.0      | 0.0  | 300.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      | 400.0         | 0.0      | 0.0  | 0.0       | 400.0 | 100.0 | 100.0      | 0.0  | 300.0       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20240623     | Disbursement     | 400.0  | 0.0       | 0.0      | 0.0  | 0.0       | 400.0        |
      | 20240624     | Repayment        | 100.0  | 100.0     | 0.0      | 0.0  | 0.0       | 300.0        |
    And Admin sets the business date to "20240910"
    When Customer makes "MERCHANT_ISSUED_REFUND" transaction with "AUTOPAY" payment type on "20240910" with 400 EUR transaction amount and self-generated Idempotency key
    Then Loan Repayment schedule has 1 periods, with the following data for periods:
      | Nr | Days | Date         | Paid date         | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late  | Outstanding |
      |    |      | 20240623 |                   | 400.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |       |             |
      | 1  | 30   | 20240723 | 20240910 | 0.0             | 400.0         | 0.0      | 0.0  | 0.0       | 400.0 | 400.0 | 100.0      | 300.0 | 0.0         |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late  | Outstanding |
      | 400.0         | 0.0      | 0.0  | 0.0       | 400.0 | 400.0 | 100.0      | 300.0 | 0.0         |
    Then Loan Transactions tab has the following data:
      | Transaction date  | Transaction Type       | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20240623      | Disbursement           | 400.0  | 0.0       | 0.0      | 0.0  | 0.0       | 400.0        |
      | 20240624      | Repayment              | 100.0  | 100.0     | 0.0      | 0.0  | 0.0       | 300.0        |
      | 20240910 | Merchant Issued Refund | 400.0  | 300.0     | 0.0      | 0.0  | 0.0       | 0.0          |
    Then Loan status will be "OVERPAID"
    When Admin makes Credit Balance Refund transaction on "20240910" with 91.21 EUR transaction amount
    Then Loan Repayment schedule has 1 periods, with the following data for periods:
      | Nr | Days | Date         | Paid date         | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late  | Outstanding |
      |    |      | 20240623 |                   | 400.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |       |             |
      | 1  | 30   | 20240723 | 20240910 | 0.0             | 400.0         | 0.0      | 0.0  | 0.0       | 400.0 | 400.0 | 100.0      | 300.0 | 0.0         |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late  | Outstanding |
      | 400.0         | 0.0      | 0.0  | 0.0       | 400.0 | 400.0 | 100.0      | 300.0 | 0.0         |
    Then Loan Transactions tab has the following data:
      | Transaction date  | Transaction Type       | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20240623      | Disbursement           | 400.0  | 0.0       | 0.0      | 0.0  | 0.0       | 400.0        |
      | 20240624      | Repayment              | 100.0  | 100.0     | 0.0      | 0.0  | 0.0       | 300.0        |
      | 20240910 | Merchant Issued Refund | 400.0  | 300.0     | 0.0      | 0.0  | 0.0       | 0.0          |
      | 20240910 | Credit Balance Refund  | 91.21  | 0.0       | 0.0      | 0.0  | 0.0       | 0.0          |
    When Customer undo "1"th repayment on "20240624"
    Then Loan Repayment schedule has 2 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date         | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late  | Outstanding |
      |    |      | 20240623      |                   | 400.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |       |             |
      | 1  | 30   | 20240723      | 20240910 | 0.0             | 400.0         | 0.0      | 0.0  | 0.0       | 400.0 | 400.0 | 0.0        | 400.0 | 0.0         |
      | 2  | 49   | 20240910 |                   | 0.0             | 91.21         | 0.0      | 0.0  | 0.0       | 91.21 | 0.0   | 0.0        | 0.0   | 91.21       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late  | Outstanding |
      | 491.21        | 0.0      | 0.0  | 0.0       | 491.21 | 400.0 | 0.0        | 400.0 | 91.21       |
    Then Loan Transactions tab has the following data:
      | Transaction date  | Transaction Type       | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20240623      | Disbursement           | 400.0  | 0.0       | 0.0      | 0.0  | 0.0       | 400.0        |
      | 20240624      | Repayment              | 100.0  | 100.0     | 0.0      | 0.0  | 0.0       | 300.0        |
      | 20240910 | Merchant Issued Refund | 400.0  | 400.0     | 0.0      | 0.0  | 0.0       | 0.0          |
      | 20240910 | Credit Balance Refund  | 91.21  | 91.21     | 0.0      | 0.0  | 0.0       | 91.21        |
    Then In Loan Transactions the "2"th Transaction has Transaction type="Repayment" and is reverted

  @TestRailId:C3282
  Scenario: Verify reversal of related interest refund transaction after merchant issued refund transactions is reversed
    When Admin sets the business date to "20240101"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                         | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_EMI_ACTUAL_ACTUAL_INTEREST_REFUND_FULL | 20240101   | 1000           | 9.9                    | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 4                 | MONTHS                | 1              | MONTHS                 | 4                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240101" with "1000" amount and expected disbursement date on "20240101"
    When Admin successfully disburse the loan on "20240101" with "1000" EUR transaction amount
    When Admin sets the business date to "20240122"
    When Customer makes "MERCHANT_ISSUED_REFUND" transaction with "AUTOPAY" payment type on "20240122" with 100 EUR transaction amount and system-generated Idempotency key
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late | Outstanding |
      |    |      | 20240101  |                 | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0    |            |      |             |
      | 1  | 31   | 20240201 |                 | 752.97          | 247.03        | 8.11     | 0.0  | 0.0       | 255.14 | 100.57 | 100.57     | 0.0  | 154.57      |
      | 2  | 29   | 20240301    |                 | 503.74          | 249.23        | 5.91     | 0.0  | 0.0       | 255.14 | 0.0    | 0.0        | 0.0  | 255.14      |
      | 3  | 31   | 20240401    |                 | 252.82          | 250.92        | 4.22     | 0.0  | 0.0       | 255.14	| 0.0    | 0.0        | 0.0  | 255.14      |
      | 4  | 30   | 20240501      |                 | 0.0             | 252.82        | 2.05     | 0.0  | 0.0       | 254.87 | 0.0    | 0.0        | 0.0  | 254.87      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid    | In advance | Late | Outstanding |
      | 1000.0        | 20.29    | 0.0  | 0.0       | 1020.29 | 100.57  | 100.57     | 0.0  | 919.72      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type       | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement           | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       | false    | false    |
      | 20240122  | Merchant Issued Refund | 100.0  | 100.0     | 0.0      | 0.0  | 0.0       | 900.0        | false    | false    |
      | 20240122  | Interest Refund        | 0.57   | 0.57      | 0.0      | 0.0  | 0.0       | 899.43       | false    | false    |
    When Customer undo "1"th "Merchant Issued Refund" transaction made on "20240122" with linked "Interest Refund" transaction
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late | Outstanding |
      |    |      | 20240101  |                 | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0    |            |      |             |
      | 1  | 31   | 20240201 |                 | 753.25          | 246.75        | 8.39     | 0.0  | 0.0       | 255.14 | 0.0    | 0.0        | 0.0  | 255.14      |
      | 2  | 29   | 20240301    |                 | 504.02          | 249.23        | 5.91     | 0.0  | 0.0       | 255.14 | 0.0    | 0.0        | 0.0  | 255.14      |
      | 3  | 31   | 20240401    |                 | 253.11          | 250.91        | 4.23     | 0.0  | 0.0       | 255.14	| 0.0    | 0.0        | 0.0  | 255.14      |
      | 4  | 30   | 20240501      |                 | 0.0             | 253.11        | 2.05     | 0.0  | 0.0       | 255.16 | 0.0    | 0.0        | 0.0  | 255.16      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid    | In advance | Late | Outstanding |
      | 1000.0        | 20.58    | 0.0  | 0.0       | 1020.58 | 0.0     | 0.0        | 0.0  | 1020.58     |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type       | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement           | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       | false    | false    |
      | 20240122  | Merchant Issued Refund | 100.0  | 100.0     | 0.0      | 0.0  | 0.0       | 900.0        | true     | false    |
      | 20240122  | Interest Refund        | 0.57   | 0.57      | 0.0      | 0.0  | 0.0       | 899.43       | true     | false    |
    Then In Loan Transactions the "3"th Transaction has Transaction type="Interest Refund" and is reverted

  @TestRailId:C3283
  Scenario: Verify reversal of related interest refund transaction after payout refund transactions is reversed
    When Admin sets the business date to "20240101"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                         | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_EMI_ACTUAL_ACTUAL_INTEREST_REFUND_FULL | 20240101   | 1000           | 9.9                    | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 4                 | MONTHS                | 1              | MONTHS                 | 4                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240101" with "1000" amount and expected disbursement date on "20240101"
    When Admin successfully disburse the loan on "20240101" with "1000" EUR transaction amount
    When Admin sets the business date to "20240122"
    When Admin makes "PAYOUT_REFUND" transaction with "AUTOPAY" payment type on "20240122" with 100 EUR transaction amount
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late | Outstanding |
      |    |      | 20240101  |                 | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0    |            |      |             |
      | 1  | 31   | 20240201 |                 | 752.97          | 247.03        | 8.11     | 0.0  | 0.0       | 255.14 | 100.57 | 100.57     | 0.0  | 154.57      |
      | 2  | 29   | 20240301    |                 | 503.74          | 249.23        | 5.91     | 0.0  | 0.0       | 255.14 | 0.0    | 0.0        | 0.0  | 255.14      |
      | 3  | 31   | 20240401    |                 | 252.82          | 250.92        | 4.22     | 0.0  | 0.0       | 255.14	| 0.0    | 0.0        | 0.0  | 255.14      |
      | 4  | 30   | 20240501      |                 | 0.0             | 252.82        | 2.05     | 0.0  | 0.0       | 254.87 | 0.0    | 0.0        | 0.0  | 254.87      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid    | In advance | Late | Outstanding |
      | 1000.0        | 20.29    | 0.0  | 0.0       | 1020.29 | 100.57  | 100.57     | 0.0  | 919.72      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       | false    | false    |
      | 20240122  | Payout Refund    | 100.0  | 100.0     | 0.0      | 0.0  | 0.0       | 900.0        | false    | false    |
      | 20240122  | Interest Refund  | 0.57   | 0.57      | 0.0      | 0.0  | 0.0       | 899.43       | false    | false    |
    When Customer undo "1"th "Payout Refund" transaction made on "20240122" with linked "Interest Refund" transaction
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late | Outstanding |
      |    |      | 20240101  |                 | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0    |            |      |             |
      | 1  | 31   | 20240201 |                 | 753.25          | 246.75        | 8.39     | 0.0  | 0.0       | 255.14 | 0.0    | 0.0        | 0.0  | 255.14      |
      | 2  | 29   | 20240301    |                 | 504.02          | 249.23        | 5.91     | 0.0  | 0.0       | 255.14 | 0.0    | 0.0        | 0.0  | 255.14      |
      | 3  | 31   | 20240401    |                 | 253.11          | 250.91        | 4.23     | 0.0  | 0.0       | 255.14	| 0.0    | 0.0        | 0.0  | 255.14      |
      | 4  | 30   | 20240501      |                 | 0.0             | 253.11        | 2.05     | 0.0  | 0.0       | 255.16 | 0.0    | 0.0        | 0.0  | 255.16      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid    | In advance | Late | Outstanding |
      | 1000.0        | 20.58    | 0.0  | 0.0       | 1020.58 | 0.0     | 0.0        | 0.0  | 1020.58     |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       | false    | false    |
      | 20240122  | Payout Refund    | 100.0  | 100.0     | 0.0      | 0.0  | 0.0       | 900.0        | true     | false    |
      | 20240122  | Interest Refund  | 0.57   | 0.57      | 0.0      | 0.0  | 0.0       | 899.43       | true     | false    |
    Then In Loan Transactions the "3"th Transaction has Transaction type="Interest Refund" and is reverted

  @TestRailId:C3324
  Scenario: Verify interest refund transaction after merchant issued refund transactions is forbidden to be reversed
    When Admin sets the business date to "20240101"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                         | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_EMI_ACTUAL_ACTUAL_INTEREST_REFUND_FULL | 20240101   | 1000           | 9.9                    | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 4                 | MONTHS                | 1              | MONTHS                 | 4                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240101" with "1000" amount and expected disbursement date on "20240101"
    When Admin successfully disburse the loan on "20240101" with "1000" EUR transaction amount
    When Admin sets the business date to "20240122"
    When Customer makes "MERCHANT_ISSUED_REFUND" transaction with "AUTOPAY" payment type on "20240122" with 100 EUR transaction amount and system-generated Idempotency key
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late | Outstanding |
      |    |      | 20240101  |                 | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0    |            |      |             |
      | 1  | 31   | 20240201 |                 | 752.97          | 247.03        | 8.11     | 0.0  | 0.0       | 255.14 | 100.57 | 100.57     | 0.0  | 154.57      |
      | 2  | 29   | 20240301    |                 | 503.74          | 249.23        | 5.91     | 0.0  | 0.0       | 255.14 | 0.0    | 0.0        | 0.0  | 255.14      |
      | 3  | 31   | 20240401    |                 | 252.82          | 250.92        | 4.22     | 0.0  | 0.0       | 255.14	| 0.0    | 0.0        | 0.0  | 255.14      |
      | 4  | 30   | 20240501      |                 | 0.0             | 252.82        | 2.05     | 0.0  | 0.0       | 254.87 | 0.0    | 0.0        | 0.0  | 254.87      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid    | In advance | Late | Outstanding |
      | 1000.0        | 20.29    | 0.0  | 0.0       | 1020.29 | 100.57  | 100.57     | 0.0  | 919.72      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type       | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement           | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       | false    | false    |
      | 20240122  | Merchant Issued Refund | 100.0  | 100.0     | 0.0      | 0.0  | 0.0       | 900.0        | false    | false    |
      | 20240122  | Interest Refund        | 0.57   | 0.57      | 0.0      | 0.0  | 0.0       | 899.43       | false    | false    |
    When Customer is forbidden to undo "1"th "Interest Refund" transaction made on "20240122"
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late | Outstanding |
      |    |      | 20240101  |                 | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0    |            |      |             |
      | 1  | 31   | 20240201 |                 | 752.97          | 247.03        | 8.11     | 0.0  | 0.0       | 255.14 | 100.57 | 100.57     | 0.0  | 154.57      |
      | 2  | 29   | 20240301    |                 | 503.74          | 249.23        | 5.91     | 0.0  | 0.0       | 255.14 | 0.0    | 0.0        | 0.0  | 255.14      |
      | 3  | 31   | 20240401    |                 | 252.82          | 250.92        | 4.22     | 0.0  | 0.0       | 255.14	| 0.0    | 0.0        | 0.0  | 255.14      |
      | 4  | 30   | 20240501      |                 | 0.0             | 252.82        | 2.05     | 0.0  | 0.0       | 254.87 | 0.0    | 0.0        | 0.0  | 254.87      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid    | In advance | Late | Outstanding |
      | 1000.0        | 20.29    | 0.0  | 0.0       | 1020.29 | 100.57  | 100.57     | 0.0  | 919.72      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type       | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement           | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       | false    | false    |
      | 20240122  | Merchant Issued Refund | 100.0  | 100.0     | 0.0      | 0.0  | 0.0       | 900.0        | false    | false    |
      | 20240122  | Interest Refund        | 0.57   | 0.57      | 0.0      | 0.0  | 0.0       | 899.43       | false    | false    |

  @TestRailId:C3325
  Scenario: Verify interest refund transaction after payout refund transactions is forbidden to be reversed
    When Admin sets the business date to "20240101"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                         | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_EMI_ACTUAL_ACTUAL_INTEREST_REFUND_FULL | 20240101   | 1000           | 9.9                    | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 4                 | MONTHS                | 1              | MONTHS                 | 4                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240101" with "1000" amount and expected disbursement date on "20240101"
    When Admin successfully disburse the loan on "20240101" with "1000" EUR transaction amount
    When Admin sets the business date to "20240122"
    When Admin makes "PAYOUT_REFUND" transaction with "AUTOPAY" payment type on "20240122" with 100 EUR transaction amount
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late | Outstanding |
      |    |      | 20240101  |                 | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0    |            |      |             |
      | 1  | 31   | 20240201 |                 | 752.97          | 247.03        | 8.11     | 0.0  | 0.0       | 255.14 | 100.57 | 100.57     | 0.0  | 154.57      |
      | 2  | 29   | 20240301    |                 | 503.74          | 249.23        | 5.91     | 0.0  | 0.0       | 255.14 | 0.0    | 0.0        | 0.0  | 255.14      |
      | 3  | 31   | 20240401    |                 | 252.82          | 250.92        | 4.22     | 0.0  | 0.0       | 255.14	| 0.0    | 0.0        | 0.0  | 255.14      |
      | 4  | 30   | 20240501      |                 | 0.0             | 252.82        | 2.05     | 0.0  | 0.0       | 254.87 | 0.0    | 0.0        | 0.0  | 254.87      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid    | In advance | Late | Outstanding |
      | 1000.0        | 20.29    | 0.0  | 0.0       | 1020.29 | 100.57  | 100.57     | 0.0  | 919.72      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       | false    | false    |
      | 20240122  | Payout Refund    | 100.0  | 100.0     | 0.0      | 0.0  | 0.0       | 900.0        | false    | false    |
      | 20240122  | Interest Refund  | 0.57   | 0.57      | 0.0      | 0.0  | 0.0       | 899.43       | false    | false    |
    When Customer is forbidden to undo "1"th "Interest Refund" transaction made on "20240122"
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late | Outstanding |
      |    |      | 20240101  |                 | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0    |            |      |             |
      | 1  | 31   | 20240201 |                 | 752.97          | 247.03        | 8.11     | 0.0  | 0.0       | 255.14 | 100.57 | 100.57     | 0.0  | 154.57      |
      | 2  | 29   | 20240301    |                 | 503.74          | 249.23        | 5.91     | 0.0  | 0.0       | 255.14 | 0.0    | 0.0        | 0.0  | 255.14      |
      | 3  | 31   | 20240401    |                 | 252.82          | 250.92        | 4.22     | 0.0  | 0.0       | 255.14	| 0.0    | 0.0        | 0.0  | 255.14      |
      | 4  | 30   | 20240501      |                 | 0.0             | 252.82        | 2.05     | 0.0  | 0.0       | 254.87 | 0.0    | 0.0        | 0.0  | 254.87      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid    | In advance | Late | Outstanding |
      | 1000.0        | 20.29    | 0.0  | 0.0       | 1020.29 | 100.57  | 100.57     | 0.0  | 919.72      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240101  | Disbursement     | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       | false    | false    |
      | 20240122  | Payout Refund    | 100.0  | 100.0     | 0.0      | 0.0  | 0.0       | 900.0        | false    | false    |
      | 20240122  | Interest Refund  | 0.57   | 0.57      | 0.0      | 0.0  | 0.0       | 899.43       | false    | false    |

  @TestRailId:C3300
  Scenario: Early pay-off loan with interest, TILL_PRECLOSE product
    When Admin sets the business date to "20240101"
    When Admin creates a client with random data
    When Admin set "LP2_ADV_PYMNT_INTEREST_DAILY_EMI_360_30_INTEREST_RECALCULATION_DAILY_TILL_PRECLOSE" loan product "DEFAULT" transaction type to "NEXT_INSTALLMENT" future installment allocation rule
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                              | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
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
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    |
      | 20240201 | Repayment        | 17.01  | 16.43     | 0.58     | 0.0  | 0.0       | 83.57        | false    |
      | 20240215 | Repayment        | 83.81  | 83.57     | 0.24     | 0.0  | 0.0       | 0.0          | false    |
      | 20240215 | Accrual          | 0.82   |   0.0     | 0.82     | 0.0  | 0.0       | 0.0          | false    |
    Then Loan's all installments have obligations met

  @TestRailId:C3483
  Scenario: Early pay-off loan with interest, TILL_REST_FREQUENCY_DATE product
    When Admin sets the business date to "20240101"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                              | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
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
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    |
      | 20240201 | Repayment        | 17.01  | 16.43     | 0.58     | 0.0  | 0.0       | 83.57        | false    |
      | 20240215 | Repayment        | 84.06  | 83.57     | 0.49     | 0.0  | 0.0       | 0.0          | false    |
      | 20240215 | Accrual          | 1.07   |   0.0     | 1.07     | 0.0  | 0.0       | 0.0          | false    |
    Then Loan's all installments have obligations met

  @TestRailId:C3484
  Scenario: Interest recalculation - S1 daily for overdue loan
    Given Global configuration "enable-business-date" is enabled
    When Admin sets the business date to "20240101"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                  | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_EMI_360_30_INTEREST_RECALCULATION_DAILY_TILL_PRECLOSE | 20240101   | 100            | 7.0                    | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 6                 | MONTHS                | 1              | MONTHS                 | 6                 | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240101" with "100" amount and expected disbursement date on "20240101"
    When Admin successfully disburse the loan on "20240101" with "100" EUR transaction amount
    When Admin sets the business date to "20240715"
    When Admin runs inline COB job for Loan
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20240101  |           | 100.0           |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 31   | 20240201 |           | 83.57           | 16.43         | 0.58     | 0.0  | 0.0       | 17.01 | 0.0  | 0.0        | 0.0  | 17.01       |
      | 2  | 29   | 20240301    |           | 67.14           | 16.43         | 0.58     | 0.0  | 0.0       | 17.01 | 0.0  | 0.0        | 0.0  | 17.01       |
      | 3  | 31   | 20240401    |           | 50.71           | 16.43         | 0.58     | 0.0  | 0.0       | 17.01 | 0.0  | 0.0        | 0.0  | 17.01       |
      | 4  | 30   | 20240501      |           | 34.28           | 16.43         | 0.58     | 0.0  | 0.0       | 17.01 | 0.0  | 0.0        | 0.0  | 17.01       |
      | 5  | 31   | 20240601     |           | 17.85           | 16.43         | 0.58     | 0.0  | 0.0       | 17.01 | 0.0  | 0.0        | 0.0  | 17.01       |
      | 6  | 30   | 20240701     |           | 0.0             | 17.85         | 0.58     | 0.0  | 0.0       | 18.43 | 0.0  | 0.0        | 0.0  | 18.43       |

  @TestRailId:C3485
  Scenario: Interest recalculation - S2 2 overdue
    Given Global configuration "enable-business-date" is enabled
    When Admin sets the business date to "20240101"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                  | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_EMI_360_30_INTEREST_RECALCULATION_DAILY_TILL_PRECLOSE | 20240101   | 100            | 7.0                    | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 6                 | MONTHS                | 1              | MONTHS                 | 6                 | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240101" with "100" amount and expected disbursement date on "20240101"
    When Admin successfully disburse the loan on "20240101" with "100" EUR transaction amount
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

  @TestRailId:C3486
  Scenario: Interest recalculation - S3 1 paid, 1 overdue
    Given Global configuration "enable-business-date" is enabled
    When Admin sets the business date to "20240101"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                  | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_EMI_360_30_INTEREST_RECALCULATION_DAILY_TILL_PRECLOSE | 20240101   | 100            | 7.0                    | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 6                 | MONTHS                | 1              | MONTHS                 | 6                 | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240101" with "100" amount and expected disbursement date on "20240101"
    When Admin successfully disburse the loan on "20240101" with "100" EUR transaction amount
    When Admin sets the business date to "20240201"
    And Customer makes "AUTOPAY" repayment on "20240201" with 17.01 EUR transaction amount
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

  @TestRailId:C3487
  Scenario: Loan Details Emi Amount Variations - AssociationsAll
    Given Global configuration "is-interest-to-be-recovered-first-when-greater-than-emi" is enabled
    Given Global configuration "enable-business-date" is enabled
    When Admin sets the business date to "20230101"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with "555" emi and the following data:
      | LoanProduct                                                                                     | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy                        |
      | LP1_INTEREST_DECLINING_BALANCE_SAR_RECALCULATION_SAME_AS_REPAYMENT_COMPOUNDING_NONE_MULTIDISB   | 20230101   | 10000          | 12                     | DECLINING_BALANCE | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 6                 | MONTHS                | 1              | MONTHS                 | 6                  | 0                       | 0                      | 0                    | PENALTIES_FEES_INTEREST_PRINCIPAL_ORDER |
    And Admin successfully approves the loan on "20230101" with "100" amount and expected disbursement date on "20230101"
    And Admin successfully disburse the loan on "20230101" with "100" EUR transaction amount and "50" fixed emi amount
    Then Loan emi amount variations has 1 variation, with the following data:
      | Term Type Id | Term Type Code         | Term Type Value | Applicable From | Decimal Value | Date Value      | Is Specific To Installment | Is Processed |
      | 1            | loanTermType.emiAmount | emiAmount       | 20230101 | 50.0          |                 | false                      |              |

  @TestRailId:C3488
  Scenario: Loan Details Loan Term Variations
    Given Global configuration "is-interest-to-be-recovered-first-when-greater-than-emi" is enabled
    Given Global configuration "enable-business-date" is enabled
    When Admin sets the business date to "20230101"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with "555" emi and the following data:
      | LoanProduct                                                                                     | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy                        |
      | LP1_INTEREST_DECLINING_BALANCE_SAR_RECALCULATION_SAME_AS_REPAYMENT_COMPOUNDING_NONE_MULTIDISB   | 20230101   | 10000          | 12                     | DECLINING_BALANCE | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 6                 | MONTHS                | 1              | MONTHS                 | 6                  | 0                       | 0                      | 0                    | PENALTIES_FEES_INTEREST_PRINCIPAL_ORDER |
    And Admin successfully approves the loan on "20230101" with "100" amount and expected disbursement date on "20230101"
    And Admin successfully disburse the loan on "20230101" with "100" EUR transaction amount, "50" EUR fixed emi amount and adjust repayment date on "20230115"
    Then Loan term variations has 2 variation, with the following data:
      | Term Type Id | Term Type Code         | Term Type Value | Applicable From  | Decimal Value | Date Value      | Is Specific To Installment | Is Processed |
      | 1            | loanTermType.emiAmount | emiAmount       | 20230101  | 50.0          |                 | false                      |              |
      | 4            | loanTermType.dueDate   | dueDate         | 20230201 | 50.0          | 20230115 | false                      |              |

  @TestRailId:C3489
  Scenario: EMI calculation with 360/30 Early repayment - Last installment strategy - UC1: Multiple early repayment
    When Admin sets the business date to "20240101"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                              | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_EMI_360_30_IR_DAILY_TILL_PRECLOSE_LAST_INSTALLMENT_STRATEGY | 20240101   | 100            | 7.0                    | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 6                 | MONTHS                | 1              | MONTHS                 | 6                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
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
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        |
#    --- Early repayment on 20240115 ---
    When Admin sets the business date to "20240115"
    And Customer makes "AUTOPAY" repayment on "20240115" with 15.00 EUR transaction amount
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance  | Late | Outstanding |
      |    |      | 20240101  |           | 100.0           |               |          | 0.0  |           | 0.0   | 0.0   |             |      |             |
      | 1  | 31   | 20240201 |           | 83.53           | 16.47         | 0.54     | 0.0  | 0.0       | 17.01 | 0.0   | 0.0         | 0.0  | 17.01       |
      | 2  | 29   | 20240301    |           | 66.92           | 16.61         | 0.4      | 0.0  | 0.0       | 17.01 | 0.0   | 0.0         | 0.0  | 17.01       |
      | 3  | 31   | 20240401    |           | 50.21           | 16.71         | 0.3      | 0.0  | 0.0       | 17.01 | 0.0   | 0.0         | 0.0  | 17.01       |
      | 4  | 30   | 20240501      |           | 33.41           | 16.8          | 0.21     | 0.0  | 0.0       | 17.01 | 0.0   | 0.0         | 0.0  | 17.01       |
      | 5  | 31   | 20240601     |           | 16.51           | 16.9          | 0.11     | 0.0  | 0.0       | 17.01 | 0.0   | 0.0         | 0.0  | 17.01       |
      | 6  | 30   | 20240701     |           | 0.0             | 16.51         | 0.01     | 0.0  | 0.0       | 16.52 | 15.0  | 15.0        | 0.0  | 1.52        |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 100.0         | 1.57     | 0.0  | 0.0       | 101.57 | 15.0 | 15.0       | 0.0  | 86.57       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        |
      | 20240115  | Repayment        | 15.0   | 15.0      | 0.0      | 0.0  | 0.0       | 85.0         |
    #    --- Early repayment on 20240115 ---
    And Customer makes "AUTOPAY" repayment on "20240115" with 1.50 EUR transaction amount
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid   | In advance  | Late | Outstanding |
      |    |      | 20240101  |                 | 100.0           |               |          | 0.0  |           | 0.0   | 0.0    |             |      |             |
      | 1  | 31   | 20240201 |                 | 83.52           | 16.48         | 0.53     | 0.0  | 0.0       | 17.01 | 0.0    | 0.0         | 0.0  | 17.01       |
      | 2  | 29   | 20240301    |                 | 66.9            | 16.62         | 0.39     | 0.0  | 0.0       | 17.01 | 0.0    | 0.0         | 0.0  | 17.01       |
      | 3  | 31   | 20240401    |                 | 50.18           | 16.72         | 0.29     | 0.0  | 0.0       | 17.01 | 0.0    | 0.0         | 0.0  | 17.01       |
      | 4  | 30   | 20240501      |                 | 33.37           | 16.81         | 0.2      | 0.0  | 0.0       | 17.01 | 0.0    | 0.0         | 0.0  | 17.01       |
      | 5  | 31   | 20240601     |                 | 16.5            | 16.87         | 0.1      | 0.0  | 0.0       | 16.97 | 0.0    | 0.0         | 0.0  | 16.97       |
      | 6  | 30   | 20240701     | 20240115 | 0.0             | 16.5          | 0.0      | 0.0  | 0.0       | 16.5  | 16.5   | 16.5        | 0.0  | 0.0         |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 100.0         | 1.51     | 0.0  | 0.0       | 101.51 | 16.5 | 16.5       | 0.0  | 85.01       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        |
      | 20240115  | Repayment        | 15.0   | 15.0      | 0.0      | 0.0  | 0.0       | 85.0         |
      | 20240115  | Repayment        | 1.5    | 1.5       | 0.0      | 0.0  | 0.0       | 83.5         |
    #    --- Pay-off on 20240115 ---
    And Customer makes "AUTOPAY" repayment on "20240115" with 83.76 EUR transaction amount
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid   | In advance  | Late | Outstanding |
      |    |      | 20240101  |                 | 100.0           |               |          | 0.0  |           | 0.0   | 0.0    |             |      |             |
      | 1  | 31   | 20240201 | 20240115 | 84.54           | 15.46         | 0.26     | 0.0  | 0.0       | 15.72 | 15.72  | 15.72       | 0.0  | 0.0         |
      | 2  | 29   | 20240301    | 20240115 | 67.53           | 17.01         | 0.0      | 0.0  | 0.0       | 17.01 | 17.01  | 17.01       | 0.0  | 0.0         |
      | 3  | 31   | 20240401    | 20240115 | 50.52           | 17.01         | 0.0      | 0.0  | 0.0       | 17.01 | 17.01  | 17.01       | 0.0  | 0.0         |
      | 4  | 30   | 20240501      | 20240115 | 33.51           | 17.01         | 0.0      | 0.0  | 0.0       | 17.01 | 17.01  | 17.01       | 0.0  | 0.0         |
      | 5  | 31   | 20240601     | 20240115 | 16.5            | 17.01         | 0.0      | 0.0  | 0.0       | 17.01 | 17.01  | 17.01       | 0.0  | 0.0         |
      | 6  | 30   | 20240701     | 20240115 | 0.0             | 16.5          | 0.0      | 0.0  | 0.0       | 16.5  | 16.5   | 16.5        | 0.0  | 0.0         |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late | Outstanding |
      | 100.0         | 0.26     | 0.0  | 0.0       | 100.26 | 100.26 | 100.26     | 0.0  | 0.0         |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20240101  | Disbursement     | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        |
      | 20240115  | Repayment        | 15.0   | 15.0      | 0.0      | 0.0  | 0.0       | 85.0         |
      | 20240115  | Repayment        | 1.5    | 1.5       | 0.0      | 0.0  | 0.0       | 83.5         |
      | 20240115  | Repayment        | 83.76  | 83.5      | 0.26     | 0.0  | 0.0       | 0.0          |
      | 20240115  | Accrual          | 0.26   | 0.0       | 0.26     | 0.0  | 0.0       | 0.0          |
    Then Loan status will be "CLOSED_OBLIGATIONS_MET"
