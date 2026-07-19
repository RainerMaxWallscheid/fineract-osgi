@COBFeature
Feature: COBFeature

  @TestRailId:C2501
  Scenario: As an admin I would like to see that last closed business date got updated after COB catch up job finished
    When Admin sets the business date to "20220101"
    When Admin creates a client with random data
    When Admin creates a new default Loan with date: "20220101"
    And Admin successfully approves the loan on "20220101" with "1000" amount and expected disbursement date on "20220101"
    When Admin successfully disburse the loan on "20220101" with "1000" EUR transaction amount
    Then Admin checks that last closed business date of loan is "null"
    When Admin sets the business date to "20220102"
    When Admin runs COB job
    Then Admin checks that last closed business date of loan is "20220101"
    When Admin sets the business date to "20220105"
    When Admin runs COB job
    Then Admin checks that last closed business date of loan is "20220101"
    When Admin runs COB catch up
    When Admin checks that Loan COB is running until the current business date
    Then Admin checks that last closed business date of loan is "20220104"
    And Customer makes "AUTOPAY" repayment on "20220105" with 1000 EUR transaction amount
    Then Loan status will be "CLOSED_OBLIGATIONS_MET"


  @TestRailId:C2681
  Scenario: As an admin I would like to check that the Delinquency bucket set on the loan correctly when the arrears setting is 3 on the product
    When Admin sets the business date to "20220101"
    When Admin creates a client with random data
    When Admin creates a new default Loan with date: "20220101"
    And Admin successfully approves the loan on "20220101" with "1000" amount and expected disbursement date on "20220101"
    When Admin successfully disburse the loan on "20220101" with "1000" EUR transaction amount
    When Admin sets the business date to "20220204"
    When Admin runs COB job
    Then Admin checks that delinquency range is: "RANGE_1" and has delinquentDate "2022-02-03"

  @TestRailId:C2791
  Scenario: Verify that COB processes loans which are not closed/overpaid and has a last_closed_business_date exactly 1 day behind COB date
    When Admin sets the business date to "20220101"
    When Admin creates a client with random data
    When Admin creates a new default Loan with date: "20220101"
    And Admin successfully approves the loan on "20220101" with "1000" amount and expected disbursement date on "20220101"
    When Admin successfully disburse the loan on "20220101" with "1000" EUR transaction amount
    Then Loan status will be "ACTIVE"
    Then Admin checks that last closed business date of loan is "null"
    When Admin sets the business date to "20220102"
    When Admin runs COB job
    Then Admin checks that last closed business date of loan is "20220101"
    When Admin sets the business date to "20220103"
    When Admin runs COB job
    Then Admin checks that last closed business date of loan is "20220102"

  @TestRailId:C2792
  Scenario: Verify that COB doesn’t touch loans with last closed business date behind COB date
    When Admin sets the business date to "20220101"
    When Admin creates a client with random data
    When Admin creates a new default Loan with date: "20220101"
    And Admin successfully approves the loan on "20220101" with "1000" amount and expected disbursement date on "20220101"
    When Admin successfully disburse the loan on "20220101" with "1000" EUR transaction amount
    Then Loan status will be "ACTIVE"
    Then Admin checks that last closed business date of loan is "null"
    When Admin sets the business date to "20220210"
    When Admin runs inline COB job for Loan
    Then Admin checks that last closed business date of loan is "20220209"
    Then Admin checks that delinquency range is: "RANGE_3" and has delinquentDate "2022-02-03"
    Then Loan delinquency history has the following details:
      | Range (Classification) | Added on date  | Lifted on date |
      | RANGE_3                | 20220210 |                |
      | RANGE_1                | 20220204 | 20220209 |
    When Admin sets the business date to "20220212"
    When Admin runs COB job
    Then Admin checks that last closed business date of loan is "20220209"
    Then Loan delinquency history has the following details:
      | Range (Classification) | Added on date  | Lifted on date |
      | RANGE_3                | 20220210 |                |
      | RANGE_1                | 20220204 | 20220209 |

  @TestRailId:C2793
  Scenario: Verify that COB doesn’t touch CLOSED loans
    When Admin sets the business date to "20220101"
    When Admin creates a client with random data
    When Admin creates a new default Loan with date: "20220101"
    And Admin successfully approves the loan on "20220101" with "1000" amount and expected disbursement date on "20220101"
    When Admin successfully disburse the loan on "20220101" with "1000" EUR transaction amount
    Then Loan status will be "ACTIVE"
    Then Admin checks that last closed business date of loan is "null"
    When Admin sets the business date to "20220210"
    When Admin runs inline COB job for Loan
    Then Admin checks that last closed business date of loan is "20220209"
    Then Admin checks that delinquency range is: "RANGE_3" and has delinquentDate "2022-02-03"
    Then Loan delinquency history has the following details:
      | Range (Classification) | Added on date  | Lifted on date |
      | RANGE_3                | 20220210 |                |
      | RANGE_1                | 20220204 | 20220209 |
    And Customer makes "AUTOPAY" repayment on "20220210" with 1000 EUR transaction amount
    Then Loan status will be "CLOSED_OBLIGATIONS_MET"
    Then Admin checks that delinquency range is: "NO_DELINQUENCY" and has delinquentDate ""
    Then Loan delinquency history has the following details:
      | Range (Classification) | Added on date  | Lifted on date |
      | RANGE_3                | 20220210 | 20220210 |
      | RANGE_1                | 20220204 | 20220209 |
    When Admin sets the business date to "20220211"
    When Admin runs COB job
    Then Admin checks that last closed business date of loan is "20220209"
    Then Loan delinquency history has the following details:
      | Range (Classification) | Added on date  | Lifted on date |
      | RANGE_3                | 20220210 | 20220210 |
      | RANGE_1                | 20220204 | 20220209 |

  @TestRailId:C2794
  Scenario: Verify that COB doesn’t touch OVERPAID loans
    When Admin sets the business date to "20220101"
    When Admin creates a client with random data
    When Admin creates a new default Loan with date: "20220101"
    And Admin successfully approves the loan on "20220101" with "1000" amount and expected disbursement date on "20220101"
    When Admin successfully disburse the loan on "20220101" with "1000" EUR transaction amount
    Then Loan status will be "ACTIVE"
    Then Admin checks that last closed business date of loan is "null"
    When Admin sets the business date to "20220210"
    When Admin runs inline COB job for Loan
    Then Admin checks that last closed business date of loan is "20220209"
    Then Admin checks that delinquency range is: "RANGE_3" and has delinquentDate "2022-02-03"
    Then Loan delinquency history has the following details:
      | Range (Classification) | Added on date  | Lifted on date |
      | RANGE_3                | 20220210 |                |
      | RANGE_1                | 20220204 | 20220209 |
    And Customer makes "AUTOPAY" repayment on "20220210" with 1200 EUR transaction amount
    Then Loan status will be "OVERPAID"
    Then Admin checks that delinquency range is: "NO_DELINQUENCY" and has delinquentDate ""
    Then Loan delinquency history has the following details:
      | Range (Classification) | Added on date  | Lifted on date |
      | RANGE_3                | 20220210 | 20220210 |
      | RANGE_1                | 20220204 | 20220209 |
    When Admin sets the business date to "20220211"
    When Admin runs COB job
    Then Admin checks that last closed business date of loan is "20220209"
    Then Loan delinquency history has the following details:
      | Range (Classification) | Added on date  | Lifted on date |
      | RANGE_3                | 20220210 | 20220210 |
      | RANGE_1                | 20220204 | 20220209 |

  @TestRailId:C2795
  Scenario: Verify that COB catch up runs properly on loan which is behind date because of locked with error
    When Admin sets the business date to "20220101"
    When Admin creates a client with random data
    When Admin creates a new default Loan with date: "20220101"
    And Admin successfully approves the loan on "20220101" with "1000" amount and expected disbursement date on "20220101"
    When Admin successfully disburse the loan on "20220101" with "1000" EUR transaction amount
    Then Loan status will be "ACTIVE"
    Then Admin checks that last closed business date of loan is "null"
    When Admin sets the business date to "20220102"
    When Admin runs COB job
    Then Admin checks that last closed business date of loan is "20220101"
    When Admin sets the business date to "20220103"
    Then Admin places a lock on loan account with an error message
    Then Admin checks that last closed business date of loan is "20220101"
    When Admin sets the business date to "20220105"
    Then Admin checks that last closed business date of loan is "20220101"
    When Admin runs COB catch up
    When Admin checks that Loan COB is running until the current business date
    Then Admin checks that last closed business date of loan is "20220104"
    And Customer makes "AUTOPAY" repayment on "20220105" with 1000 EUR transaction amount
    Then Loan status will be "CLOSED_OBLIGATIONS_MET"

  @TestRailId:C2796
  Scenario: Verify that after COB runs there are no unreleased loan locks
    When Admin sets the business date to "20220101"
    When Admin creates a client with random data
    When Admin creates a new default Loan with date: "20220101"
    And Admin successfully approves the loan on "20220101" with "1000" amount and expected disbursement date on "20220101"
    When Admin successfully disburse the loan on "20220101" with "1000" EUR transaction amount
    Then Loan status will be "ACTIVE"
    Then Admin checks that last closed business date of loan is "null"
    When Admin sets the business date to "20220102"
    When Admin runs COB job
    Then The loan account is not locked

  @TestRailId:C2797
  Scenario: Verify that Inline COB is executed for stuck loans - when payment happened on a loan with last closed business date in the past, COB got executed before the repayment
    When Admin sets the business date to "20220101"
    When Admin creates a client with random data
    When Admin creates a new default Loan with date: "20220101"
    And Admin successfully approves the loan on "20220101" with "1000" amount and expected disbursement date on "20220101"
    When Admin successfully disburse the loan on "20220101" with "1000" EUR transaction amount
    Then Loan status will be "ACTIVE"
    Then Admin checks that last closed business date of loan is "null"
    When Admin sets the business date to "20220102"
    When Admin runs COB job
    Then Admin checks that last closed business date of loan is "20220101"
    When Admin sets the business date to "20220104"
    When Admin creates new user with "NO_BYPASS_AUTOTEST" username, "NO_BYPASS_AUTOTEST_ROLE" role name and given permissions:
      | REPAYMENT_LOAN |
    When Created user makes externalID controlled "AUTOPAY" repayment on "20220104" with 500 EUR transaction amount
    Then Admin checks that last closed business date of loan is "20220103"

  @TestRailId:C2798
  Scenario: Verify that Inline COB is executed for stuck loans - when payment happened on a locked loan COB got executed before the repayment
    When Admin sets the business date to "20220101"
    When Admin creates a client with random data
    When Admin creates a new default Loan with date: "20220101"
    And Admin successfully approves the loan on "20220101" with "1000" amount and expected disbursement date on "20220101"
    When Admin successfully disburse the loan on "20220101" with "1000" EUR transaction amount
    Then Loan status will be "ACTIVE"
    Then Admin checks that last closed business date of loan is "null"
    When Admin sets the business date to "20220102"
    When Admin runs COB job
    Then Admin checks that last closed business date of loan is "20220101"
    When Admin places a lock on loan account with an error message
    When Admin sets the business date to "20220104"
    When Admin creates new user with "NO_BYPASS_AUTOTEST" username, "NO_BYPASS_AUTOTEST_ROLE" role name and given permissions:
      | REPAYMENT_LOAN |
    When Created user makes externalID controlled "AUTOPAY" repayment on "20220104" with 500 EUR transaction amount
    Then Admin checks that last closed business date of loan is "20220103"

  @TestRailId:C3044 @AdvancedPaymentAllocation
  Scenario: Verify that LoanAccountCustomSnapshotBusinessEvent is created with proper business date when installment is due date and COB runs
    When Admin sets the business date to "20220101"
    When Admin creates a client with random data
    When Admin set "LP2_DOWNPAYMENT_AUTO_ADVANCED_PAYMENT_ALLOCATION" loan product "DEFAULT" transaction type to "NEXT_INSTALLMENT" future installment allocation rule
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                       | submitted on date | with Principal | ANNUAL interest rate % | interest type | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_DOWNPAYMENT_AUTO_ADVANCED_PAYMENT_ALLOCATION | 20220101   | 1000           | 0                      | FLAT          | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 45                | DAYS                  | 15             | DAYS                   | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20220101" with "1000" amount and expected disbursement date on "20220101"
    When Admin successfully disburse the loan on "20220101" with "1000" EUR transaction amount
    When Admin sets the business date to "20220117"
    When Admin runs inline COB job for Loan
    Then LoanAccountCustomSnapshotBusinessEvent is created with business date "20220117"

  Scenario: COB removes an orphaned lock with no error on a loan already processed for that COB date
    When Admin sets the business date to "20220101"
    When Admin creates a client with random data
    When Admin creates a new default Loan with date: "20220101"
    And Admin successfully approves the loan on "20220101" with "1000" amount and expected disbursement date on "20220101"
    When Admin successfully disburse the loan on "20220101" with "1000" EUR transaction amount
    When Admin sets the business date to "20220102"
    When Admin runs COB job
    Then Admin checks that last closed business date of loan is "20220101"
    When Admin places a lock on loan account WITHOUT an error message
    When Admin runs COB job
    Then The loan account is not locked
    And Customer makes "AUTOPAY" repayment on "20220102" with 1000 EUR transaction amount
    Then Loan status will be "CLOSED_OBLIGATIONS_MET"

  Scenario: COB keeps a lock that carries an error message
    When Admin sets the business date to "20220101"
    When Admin creates a client with random data
    When Admin creates a new default Loan with date: "20220101"
    And Admin successfully approves the loan on "20220101" with "1000" amount and expected disbursement date on "20220101"
    When Admin successfully disburse the loan on "20220101" with "1000" EUR transaction amount
    When Admin sets the business date to "20220102"
    When Admin runs COB job
    Then Admin checks that last closed business date of loan is "20220101"
    When Admin places a lock on loan account with an error message
    When Admin runs COB job
    Then The loan account is locked by chunk processing

  Scenario: COB keeps a lock when the loan's last closed business date does not match the lock's COB date
    When Admin sets the business date to "20220101"
    When Admin creates a client with random data
    When Admin creates a new default Loan with date: "20220101"
    And Admin successfully approves the loan on "20220101" with "1000" amount and expected disbursement date on "20220101"
    When Admin successfully disburse the loan on "20220101" with "1000" EUR transaction amount
    When Admin sets the business date to "20220102"
    When Admin runs COB job
    Then Admin checks that last closed business date of loan is "20220101"
    # Skip a few days so the lock's cob_date will be far ahead of the loan's last_closed_business_date.
    # Even if the next COB advances last_closed by one day, it still won't reach the lock's cob_date.
    When Admin sets the business date to "20220105"
    When Admin places a lock on loan account WITHOUT an error message
    When Admin runs COB job
    Then The loan account is locked by chunk processing

  Scenario: COB removes an orphaned inline-COB lock with no error on a loan already processed for that COB date
    When Admin sets the business date to "20220101"
    When Admin creates a client with random data
    When Admin creates a new default Loan with date: "20220101"
    And Admin successfully approves the loan on "20220101" with "1000" amount and expected disbursement date on "20220101"
    When Admin successfully disburse the loan on "20220101" with "1000" EUR transaction amount
    When Admin sets the business date to "20220102"
    When Admin runs COB job
    Then Admin checks that last closed business date of loan is "20220101"
    When Admin places an inline COB lock on loan account WITHOUT an error message
    When Admin runs COB job
    Then The loan account is not locked

  Scenario: COB keeps an inline-COB lock that carries an error message
    When Admin sets the business date to "20220101"
    When Admin creates a client with random data
    When Admin creates a new default Loan with date: "20220101"
    And Admin successfully approves the loan on "20220101" with "1000" amount and expected disbursement date on "20220101"
    When Admin successfully disburse the loan on "20220101" with "1000" EUR transaction amount
    When Admin sets the business date to "20220102"
    When Admin runs COB job
    Then Admin checks that last closed business date of loan is "20220101"
    When Admin places an inline COB lock on loan account with an error message
    When Admin runs COB job
    Then The loan account is locked by chunk processing

  Scenario: COB keeps a lock with NULL cob business date
    # SQL filter requires `lock_placed_on_cob_business_date IS NOT NULL` — a lock with NULL date must never be removed
    # (no proof exists that the loan was already processed for that date).
    When Admin sets the business date to "20220101"
    When Admin creates a client with random data
    When Admin creates a new default Loan with date: "20220101"
    And Admin successfully approves the loan on "20220101" with "1000" amount and expected disbursement date on "20220101"
    When Admin successfully disburse the loan on "20220101" with "1000" EUR transaction amount
    When Admin sets the business date to "20220102"
    When Admin runs COB job
    Then Admin checks that last closed business date of loan is "20220101"
    When Admin places a lock on loan account WITHOUT an error message and null cob business date
    When Admin runs COB job
    Then The loan account is locked by chunk processing

  Scenario: COB keeps a lock when cob business date is in the past relative to last closed date
    # SQL uses `last_closed_business_date = lock_placed_on_cob_business_date` (strict equality), so a stale lock
    # whose cob date already lags behind the loan's last_closed must remain — the date proves a *different* run.
    When Admin sets the business date to "20220101"
    When Admin creates a client with random data
    When Admin creates a new default Loan with date: "20220101"
    And Admin successfully approves the loan on "20220101" with "1000" amount and expected disbursement date on "20220101"
    When Admin successfully disburse the loan on "20220101" with "1000" EUR transaction amount
    When Admin sets the business date to "20220102"
    When Admin runs COB job
    Then Admin checks that last closed business date of loan is "20220101"
    When Admin sets the business date to "20220103"
    When Admin runs COB job
    Then Admin checks that last closed business date of loan is "20220102"
    # Loan's last_closed is now 02 Jan; place a lock that claims cob_date = 01 Jan (earlier) — must NOT be removed.
    When Admin places a lock on loan account WITHOUT an error message and cob business date "20220101"
    When Admin runs COB job
    Then The loan account is locked by chunk processing

  Scenario: COB removes only orphaned locks among multiple loans in the same run
    # Two loans share the same COB run: the first one carries an orphaned lock (no error) and must be unlocked;
    # the second one carries a lock with an error message and must remain locked. Verifies DELETE selectivity.
    When Admin sets the business date to "20220101"
    When Admin creates a client with random data
    When Admin creates a new default Loan with date: "20220101"
    And Admin successfully approves the loan on "20220101" with "1000" amount and expected disbursement date on "20220101"
    When Admin successfully disburse the loan on "20220101" with "1000" EUR transaction amount
    When Admin crates a second default loan with date: "20220101"
    And Admin successfully approves the second loan on "20220101" with "1000" amount and expected disbursement date on "20220101"
    And Admin successfully disburse the second loan on "20220101" with "1000" EUR transaction amount
    When Admin sets the business date to "20220102"
    When Admin runs COB job
    Then Admin checks that last closed business date of loan is "20220101"
    When Admin places a lock on loan account WITHOUT an error message
    When Admin places a lock on second loan account with an error message
    When Admin runs COB job
    Then The loan account is not locked
    Then The second loan account is locked by chunk processing
