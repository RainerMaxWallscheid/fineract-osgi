@LoanUpdateAvailableDisbursementAmount
Feature: LoanUpdateAvailableDisbursementAmount

  @TestRailId:C3869
  Scenario: Verify update available disbursement amount for progressive loan - UC1
    When Admin sets the business date to "20250101"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                                    | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_EMI_360_30_INTEREST_RECALCULATION_DAILY_TILL_PRECLOSE_PMT_ALLOC_1 | 20250101   | 1000            | 7                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 6                 | MONTHS                | 1              | MONTHS                 | 6                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20250101" with "1000" amount and expected disbursement date on "20250101"
    And Update loan available disbursement amount is forbidden with amount "1001" due to exceed applied amount
    Then Update loan available disbursement amount is forbidden with amount "-100" due to min allowed amount
    Then Update loan available disbursement amount by external-id with new amount "600" value
    When Admin successfully disburse the loan on "20250101" with "600" EUR transaction amount

    When Loan Pay-off is made on "20250101"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C3919
  Scenario: Verify update available disbursement amount after undo disbursement for single disb progressive loan - UC3
    When Admin sets the business date to "20250101"
    And Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                        | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_EMI_360_30_INTEREST_RECALCULATION_DAILY_TILL_PRECLOSE | 20250101   | 1000           | 7                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 6                 | MONTHS                | 1              | MONTHS                 | 6                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20250101" with "1000" amount and expected disbursement date on "20250101"
    And Admin successfully disburse the loan on "20250101" with "100" EUR transaction amount
    Then Update loan available disbursement amount by external-id with new amount "600" value
    When Admin successfully undo disbursal
    Then Admin fails to disburse the loan on "20250101" with "750" EUR transaction amount due to exceed approved amount
    When Admin successfully disburse the loan on "20250101" with "700" EUR transaction amount

    When Loan Pay-off is made on "20250101"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C3920
  Scenario: Verify update available disbursement amount with approved over applied amount for progressive multidisbursal loan with percentage overAppliedCalculationType - UC4
    When Admin sets the business date to "20250101"
    And Admin creates a client with random data
    And Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                                       | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_RECALC_EMI_360_30_MULTIDISB_APPROVED_OVER_APPLIED_CAPITALIZED_INCOME | 20250101   | 1000           | 7                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 6                 | MONTHS                | 1              | MONTHS                 | 6                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20250101" with "1000" amount and expected disbursement date on "20250101"
    Then Loan has availableDisbursementAmountWithOverApplied field with value: 1500

    And Admin successfully disburse the loan on "20250101" with "900" EUR transaction amount
    Then Loan has availableDisbursementAmountWithOverApplied field with value: 600

    Then Update loan available disbursement amount is forbidden with amount "601" due to exceed applied amount
    Then Update loan available disbursement amount with new amount "600" value
    And Admin successfully disburse the loan on "20250101" with "600" EUR transaction amount
    Then Loan has availableDisbursementAmountWithOverApplied field with value: 0

    When Loan Pay-off is made on "20250101"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C3921
  Scenario: Verify update available disbursement amount with approved over applied amount and capitalized income for progressive loan with percentage overAppliedCalculationType - UC8_1
    When Admin sets the business date to "20250101"
    And Admin creates a client with random data
    And Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                                        | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_RECALC_EMI_360_30_APPROVED_OVER_APPLIED_PERCENTAGE_CAPITALIZED_INCOME | 20250101   | 1000           | 7                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 6                 | MONTHS                | 1              | MONTHS                 | 6                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20250101" with "1000" amount and expected disbursement date on "20250101"
    Then Loan has availableDisbursementAmountWithOverApplied field with value: 1500

    And Admin successfully disburse the loan on "20250101" with "900" EUR transaction amount
    Then Loan has availableDisbursementAmountWithOverApplied field with value: 600

    Then Update loan available disbursement amount is forbidden with amount "700" due to exceed applied amount
    Then Update loan available disbursement amount with new amount "500" value
    Then Loan has availableDisbursementAmountWithOverApplied field with value: 600

    And Capitalized income with payment type "AUTOPAY" on "20250101" is forbidden with amount "601" while exceed approved amount
    And Admin adds capitalized income with "AUTOPAY" payment type to the loan on "20250101" with "600" EUR transaction amount
    Then Loan has availableDisbursementAmountWithOverApplied field with value: 0

    When Loan Pay-off is made on "20250101"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C3922
  Scenario: Verify update available disbursement amount with capitalized income for progressive loan - UC8_2
    When Admin sets the business date to "20250101"
    And Admin creates a client with random data
    And Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                      | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_EMI_360_30_INTEREST_RECALC_DAILY_CAPITALIZED_INCOME | 20250101   | 1000           | 7                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 6                 | MONTHS                | 1              | MONTHS                 | 6                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20250101" with "1000" amount and expected disbursement date on "20250101"
    And Admin successfully disburse the loan on "20250101" with "600" EUR transaction amount
    Then Update loan available disbursement amount is forbidden with amount "500" due to exceed applied amount
    And Admin adds capitalized income with "AUTOPAY" payment type to the loan on "20250101" with "200" EUR transaction amount
    Then Update loan available disbursement amount with new amount "150" value
    And Capitalized income with payment type "AUTOPAY" on "20250101" is forbidden with amount "151" while exceed approved amount
    And Admin adds capitalized income with "AUTOPAY" payment type to the loan on "20250101" with "150" EUR transaction amount

    When Loan Pay-off is made on "20250101"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C3923
  Scenario: Verify update available disbursement amount with capitalized income for progressive multidisbursal loan - UC8_3
    When Admin sets the business date to "20250101"
    And Admin creates a client with random data
    And Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                                  | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_RECALC_EMI_360_30_MULTIDISB_CAPITALIZED_INCOME_ADJ_CUSTOM_ALLOC | 20250101   | 1000           | 7                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 6                 | MONTHS                | 1              | MONTHS                 | 6                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20250101" with "900" amount and expected disbursement date on "20250101"
    And Admin successfully disburse the loan on "20250101" with "600" EUR transaction amount
    Then Update loan available disbursement amount is forbidden with amount "500" due to exceed applied amount
    And Admin adds capitalized income with "AUTOPAY" payment type to the loan on "20250101" with "200" EUR transaction amount
    Then Update loan available disbursement amount by external-id with new amount "200" value
    Then Admin fails to disburse the loan on "20250101" with "201" EUR transaction amount due to exceed approved amount
    And Admin successfully disburse the loan on "20250101" with "200" EUR transaction amount

    When Loan Pay-off is made on "20250101"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C3924
  Scenario: Verify update available disbursement amount before disbursement for single disb cumulative loan - UC5_1
    When Admin sets the business date to "20250101"
    And Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct         | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy                        |
      | LP1_INTEREST_FLAT   | 20250101    | 1000           | 0                      | DECLINING_BALANCE | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 3                 | MONTHS                | 1              | MONTHS                 | 3                  | 0                       | 0                      | 0                    | PENALTIES_FEES_INTEREST_PRINCIPAL_ORDER |
    And Admin successfully approves the loan on "20250101" with "1000" amount and expected disbursement date on "20250101"
    Then Update loan available disbursement amount with new amount "900" value
    Then Admin fails to disburse the loan on "20250101" with "901" EUR transaction amount due to exceed approved amount
    And Admin successfully disburse the loan on "20250101" with "900" EUR transaction amount

    When Loan Pay-off is made on "20250101"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C3925
  Scenario: Verify update available disbursement amount before disbursement for single disb progressive loan - UC5_2
    When Admin sets the business date to "20250101"
    And Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                        | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_EMI_360_30_INTEREST_RECALCULATION_DAILY_TILL_PRECLOSE | 20250101   | 1000           | 7                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 6                 | MONTHS                | 1              | MONTHS                 | 6                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20250101" with "1000" amount and expected disbursement date on "20250101"
    Then Update loan available disbursement amount by external-id with new amount "900" value
    Then Admin fails to disburse the loan on "20250101" with "901" EUR transaction amount due to exceed approved amount
    And Admin successfully disburse the loan on "20250101" with "900" EUR transaction amount

    When Loan Pay-off is made on "20250101"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C3926
  Scenario: Verify available disbursement amount change for progressive multidisbursal loan that doesn't expect tranches - UC6
    When Admin sets the business date to "20250101"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                 | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_EMI_360_30_INTEREST_RECALC_DAILY_MULTIDISBURSE | 20250101   | 1000           | 7                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 6                 | MONTHS                | 1              | MONTHS                 | 6                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20250101" with "1000" amount and expected disbursement date on "20250101"
    When Admin successfully disburse the loan on "20250101" with "200" EUR transaction amount
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20250101  |           | 200.0           |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 31   | 20250201 |           | 167.15          | 32.85         | 1.17     | 0.0  | 0.0       | 34.02 | 0.0  | 0.0        | 0.0  | 34.02       |
      | 2  | 28   | 20250301    |           | 134.11          | 33.04         | 0.98     | 0.0  | 0.0       | 34.02 | 0.0  | 0.0        | 0.0  | 34.02       |
      | 3  | 31   | 20250401    |           | 100.87          | 33.24         | 0.78     | 0.0  | 0.0       | 34.02 | 0.0  | 0.0        | 0.0  | 34.02       |
      | 4  | 30   | 20250501      |           |  67.44          | 33.43         | 0.59     | 0.0  | 0.0       | 34.02 | 0.0  | 0.0        | 0.0  | 34.02       |
      | 5  | 31   | 20250601     |           |  33.81          | 33.63         | 0.39     | 0.0  | 0.0       | 34.02 | 0.0  | 0.0        | 0.0  | 34.02       |
      | 6  | 30   | 20250701     |           |   0.0           | 33.81         | 0.2      | 0.0  | 0.0       | 34.01 | 0.0  | 0.0        | 0.0  | 34.01       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 200.0         | 4.11     | 0.0  | 0.0       | 204.11 | 0.0  | 0.0        | 0.0  | 204.11      |
    Then Update loan available disbursement amount with new amount "400" value
    Then Admin fails to disburse the loan on "20250101" with "420" EUR transaction amount due to exceed approved amount
    When Admin successfully disburse the loan on "20250101" with "399" EUR transaction amount
    Then Update loan available disbursement amount is forbidden with amount "500" due to exceed applied amount

    When Loan Pay-off is made on "20250101"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C3927
  Scenario: Verify available disbursement amount change is forbidden with lower value for progressive multidisbursal loan that expects tranches - UC7_1
    When Admin sets the business date to "20250101"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with three expected disbursements details and following data:
      | LoanProduct                                                                                | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            | 1st_tranche_disb_expected_date | 1st_tranche_disb_principal | 2nd_tranche_disb_expected_date | 2nd_tranche_disb_principal | 3rd_tranche_disb_expected_date | 3rd_tranche_disb_principal |
      | LP2_ADV_PYMNT_INTEREST_DAILY_EMI_360_30_INTEREST_RECALC_DAILY_MULTIDISBURSE_EXPECT_TRANCHE | 20250101   | 1000           | 7                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 6                 | MONTHS                | 1              | MONTHS                 | 6                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION | 20250101                | 300.0                      | 20250102                | 200.0                      | 20250103                | 500.0                      |
    And Admin successfully approves the loan on "20250101" with "1000" amount and expected disbursement date on "20250101"
    Then Loan has availableDisbursementAmountWithOverApplied field with value: 0
    Then Loan Tranche Details tab has the following data:
      | Expected Disbursement On | Disbursed On    | Principal   | Net Disbursal Amount |
      | 20250101          |                 | 300.0       |                      |
      | 20250102          |                 | 200.0       |                      |
      | 20250103          |                 | 500.0       |                      |
#    --- disbursement - 1 January, 2025  ---
    When Admin successfully disburse the loan on "20250101" with "300" EUR transaction amount
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount  | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20250101  | Disbursement     | 300.0   | 0.0       | 0.0      | 0.0  | 0.0       | 300.0        | false    | false    |
    When Admin sets the business date to "20250102"
    Then Loan has availableDisbursementAmountWithOverApplied field with value: 0
    Then Update loan available disbursement amount is forbidden with amount "100" due to exceed applied amount
    When Admin sets the business date to "20250103"
    Then Update loan available disbursement amount is forbidden with amount "100" due to exceed applied amount
    When Admin sets the business date to "20250104"
    Then Update loan available disbursement amount is forbidden with amount "100" due to exceed applied amount

    When Admin successfully disburse the loan on "20250102" with "200" EUR transaction amount
    When Admin successfully disburse the loan on "20250103" with "500" EUR transaction amount
    Then Loan has availableDisbursementAmountWithOverApplied field with value: 0
    Then Loan Tranche Details tab has the following data:
      | Expected Disbursement On | Disbursed On    | Principal   | Net Disbursal Amount |
      | 20250101          | 20250101 | 300.0       |                      |
      | 20250102          | 20250102 | 200.0       |                      |
      | 20250103          | 20250103 | 500.0       |                      |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount  | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20250101  | Disbursement     | 300.0   | 0.0       | 0.0      | 0.0  | 0.0       | 300.0        | false    | false    |
      | 20250102  | Disbursement     | 200.0   | 0.0       | 0.0      | 0.0  | 0.0       | 500.0        | false    | false    |
      | 20250103  | Disbursement     | 500.0   | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       | false    | false    |

    When Loan Pay-off is made on "20250101"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C3928
  Scenario: Verify available disbursement amount change with greater value above approved amount for progressive multidisbursal loan that expects tranches - UC7_2
    When Admin sets the business date to "20250101"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with three expected disbursements details and following data:
      | LoanProduct                                                                                | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            | 1st_tranche_disb_expected_date | 1st_tranche_disb_principal | 2nd_tranche_disb_expected_date | 2nd_tranche_disb_principal | 3rd_tranche_disb_expected_date | 3rd_tranche_disb_principal |
      | LP2_ADV_PYMNT_INTEREST_DAILY_EMI_360_30_INTEREST_RECALC_DAILY_MULTIDISBURSE_EXPECT_TRANCHE | 20250101   | 1200           | 7                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 6                 | MONTHS                | 1              | MONTHS                 | 6                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION | 20250101                | 300.0                      | 20250102                | 200.0                      | 20250103                | 500.0                      |
    And Admin successfully approves the loan on "20250101" with "1000" amount and expected disbursement date on "20250101"
    Then Loan has availableDisbursementAmountWithOverApplied field with value: 0
    Then Loan Tranche Details tab has the following data:
      | Expected Disbursement On | Disbursed On    | Principal   | Net Disbursal Amount |
      | 20250101          |                 | 300.0       |                      |
      | 20250102          |                 | 200.0       |                      |
      | 20250103          |                 | 500.0       |                      |
#    --- disbursement - 1 January, 2025  ---
    When Admin successfully disburse the loan on "20250101" with "300" EUR transaction amount
    Then Loan has availableDisbursementAmountWithOverApplied field with value: 0
    When Admin sets the business date to "20250102"
    Then Update loan available disbursement amount with new amount "200" value
    When Admin successfully disburse the loan on "20250102" with "200" EUR transaction amount
    Then Loan has availableDisbursementAmountWithOverApplied field with value: 200

    When Admin sets the business date to "20250103"
    Then Admin fails to disburse the loan on "20250103" with "800" EUR transaction amount due to exceed approved amount
    When Admin successfully disburse the loan on "20250103" with "700" EUR transaction amount
    Then Loan has availableDisbursementAmountWithOverApplied field with value: 0
    Then Loan Tranche Details tab has the following data:
      | Expected Disbursement On | Disbursed On    | Principal   | Net Disbursal Amount |
      | 20250101          | 20250101 | 300.0       |                      |
      | 20250102          | 20250102 | 200.0       |                      |
      | 20250103          | 20250103 | 700.0       |                      |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount  | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20250101  | Disbursement     | 300.0   | 0.0       | 0.0      | 0.0  | 0.0       | 300.0        | false    | false    |
      | 20250102  | Disbursement     | 200.0   | 0.0       | 0.0      | 0.0  | 0.0       | 500.0        | false    | false    |
      | 20250103  | Disbursement     | 700.0   | 0.0       | 0.0      | 0.0  | 0.0       | 1200.0       | false    | false    |

    When Loan Pay-off is made on "20250101"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C3929
  Scenario: Verify available disbursement amount change with greater value under approved amount for progressive multidisbursal loan that expects tranches - UC7_3
    When Admin sets the business date to "20250101"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with three expected disbursements details and following data:
      | LoanProduct                                                                                | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            | 1st_tranche_disb_expected_date | 1st_tranche_disb_principal | 2nd_tranche_disb_expected_date | 2nd_tranche_disb_principal | 3rd_tranche_disb_expected_date | 3rd_tranche_disb_principal |
      | LP2_ADV_PYMNT_INTEREST_DAILY_EMI_360_30_INTEREST_RECALC_DAILY_MULTIDISBURSE_EXPECT_TRANCHE | 20250101   | 1200           | 7                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 6                 | MONTHS                | 1              | MONTHS                 | 6                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION | 20250101                | 300.0                      | 20250102                | 200.0                      | 20250103                | 300.0                      |
    And Admin successfully approves the loan on "20250101" with "1000" amount and expected disbursement date on "20250101"
    Then Loan has availableDisbursementAmountWithOverApplied field with value: 0
    Then Loan Tranche Details tab has the following data:
      | Expected Disbursement On | Disbursed On    | Principal   | Net Disbursal Amount |
      | 20250101          |                 | 300.0       |                      |
      | 20250102          |                 | 200.0       |                      |
      | 20250103          |                 | 300.0       |                      |
#    --- disbursement - 1 January, 2025  ---
    When Admin successfully disburse the loan on "20250101" with "300" EUR transaction amount

    When Admin sets the business date to "20250102"
    Then Update loan available disbursement amount by external-id with new amount "150" value
    Then Loan has availableDisbursementAmountWithOverApplied field with value: 150
    When Admin successfully disburse the loan on "20250102" with "300" EUR transaction amount
    When Admin sets the business date to "20250103"
    Then Admin fails to disburse the loan on "20250103" with "400" EUR transaction amount due to exceed approved amount
    When Admin successfully disburse the loan on "20250103" with "350" EUR transaction amount
    Then Loan has availableDisbursementAmountWithOverApplied field with value: 0
    Then Loan Tranche Details tab has the following data:
      | Expected Disbursement On | Disbursed On    | Principal   | Net Disbursal Amount |
      | 20250101          | 20250101 | 300.0       |                      |
      | 20250102          | 20250102 | 300.0       |                      |
      | 20250103          | 20250103 | 350.0       |                      |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount  | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20250101  | Disbursement     | 300.0   | 0.0       | 0.0      | 0.0  | 0.0       | 300.0        | false    | false    |
      | 20250102  | Disbursement     | 300.0   | 0.0       | 0.0      | 0.0  | 0.0       | 600.0        | false    | false    |
      | 20250103  | Disbursement     | 350.0   | 0.0       | 0.0      | 0.0  | 0.0       | 950.0        | false    | false    |

    When Loan Pay-off is made on "20250101"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C3995
  Scenario: Verify update available disbursement amount to zero is forbidden for not approved loan
    When Admin sets the business date to "20250101"
    And Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                        | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_EMI_360_30_INTEREST_RECALCULATION_DAILY_TILL_PRECLOSE | 20250101   | 1000           | 7                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 6                 | MONTHS                | 1              | MONTHS                 | 6                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20250101" with "1000" amount and expected disbursement date on "20250101"
    Then Updating the loan's available disbursement amount to "0" is forbidden because cannot be zero as nothing was disbursed

    Then Admin can successfully undone the loan approval
    Then Loan status will be "SUBMITTED_AND_PENDING_APPROVAL"

  @TestRailId:C3996
  Scenario: Verify update available disbursement amount to zero is forbidden for approved loan
    When Admin sets the business date to "20250101"
    And Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                        | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_EMI_360_30_INTEREST_RECALCULATION_DAILY_TILL_PRECLOSE | 20250101   | 1000           | 7                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 6                 | MONTHS                | 1              | MONTHS                 | 6                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20250101" with "1000" amount and expected disbursement date on "20250101"
    Then Updating the loan's available disbursement amount to "0" is forbidden because cannot be zero as nothing was disbursed

    Then Admin can successfully undone the loan approval
    Then Loan status will be "SUBMITTED_AND_PENDING_APPROVAL"

  @TestRailId:C3997
  Scenario: Verify update available disbursement amount to zero is allowed for active loan after partial disbursement for single disb loan
    When Admin sets the business date to "20250101"
    And Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                        | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_EMI_360_30_INTEREST_RECALCULATION_DAILY_TILL_PRECLOSE | 20250101   | 1000           | 7                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 6                 | MONTHS                | 1              | MONTHS                 | 6                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20250101" with "1000" amount and expected disbursement date on "20250101"
    And Admin successfully disburse the loan on "20250101" with "500" EUR transaction amount
    Then Update loan available disbursement amount with new amount "0" value

    When Admin successfully undo disbursal
    Then Admin fails to disburse the loan on "20250101" with "501" EUR transaction amount due to exceed approved amount

    Then Admin can successfully undone the loan approval
    Then Loan status will be "SUBMITTED_AND_PENDING_APPROVAL"

  @TestRailId:C3998
  Scenario: Verify update available disbursement amount to zero is allowed for active loan after partial disbursement for multidisb loan that doesn't expect tranches
    When Admin sets the business date to "20250101"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                 | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_EMI_360_30_INTEREST_RECALC_DAILY_MULTIDISBURSE | 20250101   | 1000           | 7                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 6                 | MONTHS                | 1              | MONTHS                 | 6                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20250101" with "1000" amount and expected disbursement date on "20250101"
    When Admin successfully disburse the loan on "20250101" with "200" EUR transaction amount
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20250101  |           | 200.0           |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 31   | 20250201 |           | 167.15          | 32.85         | 1.17     | 0.0  | 0.0       | 34.02 | 0.0  | 0.0        | 0.0  | 34.02       |
      | 2  | 28   | 20250301    |           | 134.11          | 33.04         | 0.98     | 0.0  | 0.0       | 34.02 | 0.0  | 0.0        | 0.0  | 34.02       |
      | 3  | 31   | 20250401    |           | 100.87          | 33.24         | 0.78     | 0.0  | 0.0       | 34.02 | 0.0  | 0.0        | 0.0  | 34.02       |
      | 4  | 30   | 20250501      |           |  67.44          | 33.43         | 0.59     | 0.0  | 0.0       | 34.02 | 0.0  | 0.0        | 0.0  | 34.02       |
      | 5  | 31   | 20250601     |           |  33.81          | 33.63         | 0.39     | 0.0  | 0.0       | 34.02 | 0.0  | 0.0        | 0.0  | 34.02       |
      | 6  | 30   | 20250701     |           |   0.0           | 33.81         | 0.2      | 0.0  | 0.0       | 34.01 | 0.0  | 0.0        | 0.0  | 34.01       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      | 200.0         | 4.11     | 0.0  | 0.0       | 204.11 | 0.0  | 0.0        | 0.0  | 204.11      |

    Then Update loan available disbursement amount with new amount "0" value
    Then Admin fails to disburse the loan on "20250101" with "1" EUR transaction amount due to exceed approved amount

    When Loan Pay-off is made on "20250101"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C3999
  Scenario: Verify availableDisbursementAmountWithOverApplied field calculation
    When Admin sets the business date to "20250101"
    And Admin creates a client with random data
    And Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                                       | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_RECALC_EMI_360_30_MULTIDISB_APPROVED_OVER_APPLIED_CAPITALIZED_INCOME | 20250101   | 1000           | 7                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 6                 | MONTHS                | 1              | MONTHS                 | 6                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    Then Loan has availableDisbursementAmountWithOverApplied field with value: 1500
    And Admin successfully approves the loan on "20250101" with "1000" amount and expected disbursement date on "20250101"
    Then Loan has availableDisbursementAmountWithOverApplied field with value: 1500
    And Admin successfully disburse the loan on "20250101" with "900" EUR transaction amount
    Then Loan has availableDisbursementAmountWithOverApplied field with value: 600
    And Admin successfully disburse the loan on "20250101" with "300" EUR transaction amount
    Then Loan has availableDisbursementAmountWithOverApplied field with value: 300
    And Admin adds capitalized income with "AUTOPAY" payment type to the loan on "20250101" with "100" EUR transaction amount
    Then Loan has availableDisbursementAmountWithOverApplied field with value: 200
    And Admin adds capitalized income with "AUTOPAY" payment type to the loan on "20250101" with "150" EUR transaction amount
    Then Loan has availableDisbursementAmountWithOverApplied field with value: 50
    When Loan Pay-off is made on "20250101"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C4003
  Scenario: Verify availableDisbursementAmountWithOverApplied field calculation for progressive multidisbursal loan that expects tranches
    When Admin sets the business date to "20250101"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with three expected disbursements details and following data:
      | LoanProduct                                                                                        | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            | 1st_tranche_disb_expected_date | 1st_tranche_disb_principal | 2nd_tranche_disb_expected_date | 2nd_tranche_disb_principal | 3rd_tranche_disb_expected_date | 3rd_tranche_disb_principal |
      | LP2_ADV_PYMNT_INT_DAILY_EMI_360_30_INT_RECALC_DAILY_MULTIDISB_EXPECT_TRANCHE_APPROVED_OVER_APPLIED | 20250101   | 1000           | 7                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 6                 | MONTHS                | 1              | MONTHS                 | 6                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION | 20250101                | 300.0                      | 20250102                | 200.0                      | 20250103                | 500.0                      |
    Then Loan Tranche Details tab has the following data:
      | Expected Disbursement On | Disbursed On    | Principal   | Net Disbursal Amount |
      | 20250101          |                 | 300.0       |                      |
      | 20250102          |                 | 200.0       |                      |
      | 20250103          |                 | 500.0       |                      |
    Then Loan has availableDisbursementAmountWithOverApplied field with value: 500
    And Admin successfully approves the loan on "20250101" with "1000" amount and expected disbursement date on "20250101"
    Then Loan Tranche Details tab has the following data:
      | Expected Disbursement On | Disbursed On    | Principal   | Net Disbursal Amount |
      | 20250101          |                 | 300.0       |                      |
      | 20250102          |                 | 200.0       |                      |
      | 20250103          |                 | 500.0       |                      |
    Then Loan has availableDisbursementAmountWithOverApplied field with value: 500
    When Admin successfully disburse the loan on "20250101" with "300" EUR transaction amount
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount  | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20250101  | Disbursement     | 300.0   | 0.0       | 0.0      | 0.0  | 0.0       | 300.0        | false    | false    |
    Then Loan has availableDisbursementAmountWithOverApplied field with value: 500
    When Admin sets the business date to "20250102"
    When Admin successfully disburse the loan on "20250102" with "200" EUR transaction amount
    Then Loan has availableDisbursementAmountWithOverApplied field with value: 500
    When Admin sets the business date to "20250103"
    When Admin successfully disburse the loan on "20250103" with "1000" EUR transaction amount
    Then Loan has availableDisbursementAmountWithOverApplied field with value: 0
    Then Loan Tranche Details tab has the following data:
      | Expected Disbursement On | Disbursed On    | Principal   | Net Disbursal Amount |
      | 20250101          | 20250101 | 300.0       |                      |
      | 20250102          | 20250102 | 200.0       |                      |
      | 20250103          | 20250103 | 1000.0      |                      |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount  | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20250101  | Disbursement     | 300.0   | 0.0       | 0.0      | 0.0  | 0.0       | 300.0        | false    | false    |
      | 20250102  | Disbursement     | 200.0   | 0.0       | 0.0      | 0.0  | 0.0       | 500.0        | false    | false    |
      | 20250103  | Disbursement     | 1000.0  | 0.0       | 0.0      | 0.0  | 0.0       | 1500.0       | false    | false    |

    When Loan Pay-off is made on "20250103"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met
