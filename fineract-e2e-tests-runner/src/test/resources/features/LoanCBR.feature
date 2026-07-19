@LoanCBR
Feature: Credit Balance Refund

  @TestRailId:C2505
  Scenario: Verify that Loan status goes from overpaid to active in case of CBR transaction (with replaying when CBR>new balance → clears overpaid, remaining increasing loan balance)
    When Admin sets the business date to "20230101"
    When Admin creates a client with random data
    When Admin creates a new default Loan with date: "20230101"
    And Admin successfully approves the loan on "20230101" with "1000" amount and expected disbursement date on "20230101"
    When Admin successfully disburse the loan on "20230101" with "1000" EUR transaction amount
    When Admin sets the business date to "20230103"
    And Customer makes "AUTOPAY" repayment on "20230103" with 100 EUR transaction amount
    When Admin sets the business date to "20230105"
    And Customer makes "AUTOPAY" repayment on "20230105" with 500 EUR transaction amount
    And Customer makes "AUTOPAY" repayment on "20230105" with 600 EUR transaction amount
    Then Loan status will be "OVERPAID"
    Then Loan has 0 outstanding amount
    Then Loan has 200 overpaid amount
    When Admin sets the business date to "20230107"
    When Admin makes Credit Balance Refund transaction on "20230107" with 200 EUR transaction amount
    Then Loan status will be "CLOSED_OBLIGATIONS_MET"
    Then Loan has 0 outstanding amount
    When Customer undo "1"th repayment on "20230103"
    Then Loan status will be "ACTIVE"
    Then Loan has 100 outstanding amount
    Then Loan Transactions tab has a "DISBURSEMENT" transaction with date "20230101" which has the following Journal entries:
      | Type      | Account code | Account name              | Debit  | Credit |
      | ASSET     | 112601       | Loans Receivable          | 1000.0 |        |
      | LIABILITY | 145023       | Suspense/Clearing account |        | 1000.0 |
    Then Loan Transactions tab has a "REPAYMENT" transaction with date "20230103" which has the following Journal entries:
      | Type      | Account code | Account name              | Debit | Credit |
      | ASSET     | 112601       | Loans Receivable          |       | 100.0  |
      | LIABILITY | 145023       | Suspense/Clearing account | 100.0 |        |
      | ASSET     | 112601       | Loans Receivable          | 100.0 |        |
      | LIABILITY | 145023       | Suspense/Clearing account |       | 100.0  |
    Then Loan Transactions tab has a "REPAYMENT" transaction with date "20230105" which has the following Journal entries:
      | Type      | Account code | Account name              | Debit | Credit |
      | ASSET     | 112601       | Loans Receivable          |       | 500.0  |
      | LIABILITY | 145023       | Suspense/Clearing account | 500.0 |        |
      | ASSET     | 112601       | Loans Receivable          |       | 500.0  |
      | LIABILITY | l1           | Overpayment account       |       | 100.0  |
      | LIABILITY | 145023       | Suspense/Clearing account | 600.0 |        |
    Then Loan Transactions tab has a "CREDIT_BALANCE_REFUND" transaction with date "20230107" which has the following Journal entries:
      | Type      | Account code | Account name              | Debit | Credit |
      | ASSET     | 112601       | Loans Receivable          | 100.0 |        |
      | LIABILITY | l1           | Overpayment account       | 100.0 |        |
      | LIABILITY | 145023       | Suspense/Clearing account |       | 200.0  |

  @TestRailId:C2511
  Scenario: Verify that Loan status goes from overpaid to closed in case of CBR transaction when transaction amount equals overpaid amount
    When Admin sets the business date to "20230101"
    When Admin creates a client with random data
    When Admin creates a new default Loan with date: "20230101"
    And Admin successfully approves the loan on "20230101" with "1000" amount and expected disbursement date on "20230101"
    When Admin successfully disburse the loan on "20230101" with "1000" EUR transaction amount
    When Admin sets the business date to "20230103"
    And Customer makes "AUTOPAY" repayment on "20230103" with 450 EUR transaction amount
    When Admin sets the business date to "20230105"
    And Customer makes "AUTOPAY" repayment on "20230105" with 450 EUR transaction amount
    And Customer makes "AUTOPAY" repayment on "20230105" with 300 EUR transaction amount
    Then Loan status will be "OVERPAID"
    Then Loan has 0 outstanding amount
    Then Loan has 200 overpaid amount
    When Admin makes Credit Balance Refund transaction on "20230105" with 200 EUR transaction amount
    Then Loan status will be "CLOSED_OBLIGATIONS_MET"
    Then Loan has 0 outstanding amount
    Then Loan Transactions tab has a "DISBURSEMENT" transaction with date "20230101" which has the following Journal entries:
      | Type      | Account code | Account name              | Debit  | Credit |
      | ASSET     | 112601       | Loans Receivable          | 1000.0 |        |
      | LIABILITY | 145023       | Suspense/Clearing account |        | 1000.0 |
    Then Loan Transactions tab has a "REPAYMENT" transaction with date "20230103" which has the following Journal entries:
      | Type      | Account code | Account name              | Debit | Credit |
      | ASSET     | 112601       | Loans Receivable          |       | 450.0  |
      | LIABILITY | 145023       | Suspense/Clearing account | 450.0 |        |
    Then Loan Transactions tab has a "REPAYMENT" transaction with date "20230105" which has the following Journal entries:
      | Type      | Account code | Account name              | Debit | Credit |
      | ASSET     | 112601       | Loans Receivable          |       | 450.0  |
      | LIABILITY | 145023       | Suspense/Clearing account | 450.0 |        |
      | ASSET     | 112601       | Loans Receivable          |       | 100.0  |
      | LIABILITY | l1           | Overpayment account       |       | 200.0  |
      | LIABILITY | 145023       | Suspense/Clearing account | 300.0 |        |
    Then Loan Transactions tab has a "CREDIT_BALANCE_REFUND" transaction with date "20230105" which has the following Journal entries:
      | Type      | Account code | Account name              | Debit | Credit |
      | LIABILITY | l1           | Overpayment account       | 200.0 |        |
      | LIABILITY | 145023       | Suspense/Clearing account |       | 200.0  |

  @TestRailId:C2515
  Scenario: Single repayment reversal
    When Admin sets the business date to "20230101"
    And Admin creates a client with random data
    When Admin creates a new default Loan with date: "20230101"
    And Admin successfully approves the loan on "20230101" with "1000" amount and expected disbursement date on "20230101"
    And Admin successfully disburse the loan on "20230101" with "1000" EUR transaction amount
    When Admin sets the business date to "20230110"
    And Customer makes "AUTOPAY" repayment on "20230110" with 1200 EUR transaction amount
    When Admin sets the business date to "20230111"
    And Admin makes Credit Balance Refund transaction on "20230111" with 200 EUR transaction amount
    Then Loan status will be "CLOSED_OBLIGATIONS_MET"
    Then Loan has 0 outstanding amount
    When Customer undo "1"th repayment on "20230110"
    Then Loan status will be "ACTIVE"
    Then Loan has 1200 outstanding amount
    Then Loan Transactions tab has a "DISBURSEMENT" transaction with date "20230101" which has the following Journal entries:
      | Type      | Account code | Account name              | Debit  | Credit |
      | ASSET     | 112601       | Loans Receivable          | 1000.0 |        |
      | LIABILITY | 145023       | Suspense/Clearing account |        | 1000.0 |
    Then Loan Transactions tab has a "REPAYMENT" transaction with date "20230110" which has the following Journal entries:
      | Type      | Account code | Account name              | Debit  | Credit |
      | ASSET     | 112601       | Loans Receivable          |        | 1000.0 |
      | LIABILITY | l1           | Overpayment account       |        | 200.0  |
      | LIABILITY | 145023       | Suspense/Clearing account | 1200.0 |        |
      | ASSET     | 112601       | Loans Receivable          | 1000.0 |        |
      | LIABILITY | l1           | Overpayment account       | 200.0  |        |
      | LIABILITY | 145023       | Suspense/Clearing account |        | 1200.0 |
    Then Loan Transactions tab has a "CREDIT_BALANCE_REFUND" transaction with date "20230111" which has the following Journal entries:
      | Type      | Account code | Account name              | Debit | Credit |
      | ASSET     | 112601       | Loans Receivable          | 200.0 |        |
      | LIABILITY | 145023       | Suspense/Clearing account |       | 200.0  |


  @TestRailId:C2516
  Scenario: Multi repayment reversal
    When Admin sets the business date to "20230101"
    And Admin creates a client with random data
    When Admin creates a new default Loan with date: "20230101"
    And Admin successfully approves the loan on "20230101" with "1000" amount and expected disbursement date on "20230101"
    And Admin successfully disburse the loan on "20230101" with "1000" EUR transaction amount
    When Admin sets the business date to "20230110"
    And Customer makes "AUTOPAY" repayment on "20230110" with 500 EUR transaction amount
    When Admin sets the business date to "20230111"
    And Customer makes "AUTOPAY" repayment on "20230111" with 700 EUR transaction amount
    Then Loan has 0 outstanding amount
    Then Loan has 200 overpaid amount
    When Admin sets the business date to "20230113"
    And Admin makes Credit Balance Refund transaction on "20230113" with 200 EUR transaction amount
    Then Loan status will be "CLOSED_OBLIGATIONS_MET"
    Then Loan has 0 outstanding amount
    When Customer undo "1"th repayment on "20230110"
    Then Loan status will be "ACTIVE"
    Then Loan has 500 outstanding amount
    Then Loan Transactions tab has a "DISBURSEMENT" transaction with date "20230101" which has the following Journal entries:
      | Type      | Account code | Account name              | Debit  | Credit |
      | ASSET     | 112601       | Loans Receivable          | 1000.0 |        |
      | LIABILITY | 145023       | Suspense/Clearing account |        | 1000.0 |
    Then Loan Transactions tab has a "REPAYMENT" transaction with date "20230110" which has the following Journal entries:
      | Type      | Account code | Account name              | Debit | Credit |
      | ASSET     | 112601       | Loans Receivable          |       | 500.0  |
      | LIABILITY | 145023       | Suspense/Clearing account | 500.0 |        |
      | ASSET     | 112601       | Loans Receivable          | 500.0 |        |
      | LIABILITY | 145023       | Suspense/Clearing account |       | 500.0  |
    Then Loan Transactions tab has a "REPAYMENT" transaction with date "20230111" which has the following Journal entries:
      | Type      | Account code | Account name              | Debit | Credit |
      | ASSET     | 112601       | Loans Receivable          |       | 700.0  |
      | LIABILITY | 145023       | Suspense/Clearing account | 700.0 |        |
    Then Loan Transactions tab has a "CREDIT_BALANCE_REFUND" transaction with date "20230113" which has the following Journal entries:
      | Type      | Account code | Account name              | Debit | Credit |
      | ASSET     | 112601       | Loans Receivable          | 200.0 |        |
      | LIABILITY | 145023       | Suspense/Clearing account |       | 200.0  |

  @TestRailId:C2517
  Scenario: Overpaid paid portion
    When Admin sets the business date to "20230101"
    And Admin creates a client with random data
    When Admin creates a new default Loan with date: "20230101"
    And Admin successfully approves the loan on "20230101" with "1000" amount and expected disbursement date on "20230101"
    And Admin successfully disburse the loan on "20230101" with "1000" EUR transaction amount
    When Admin sets the business date to "20230110"
    And Customer makes "AUTOPAY" repayment on "20230110" with 100 EUR transaction amount
    When Admin sets the business date to "20230111"
    And Customer makes "AUTOPAY" repayment on "20230111" with 1100 EUR transaction amount
    Then Loan has 0 outstanding amount
    Then Loan has 200 overpaid amount
    When Admin sets the business date to "20230113"
    And Admin makes Credit Balance Refund transaction on "20230113" with 200 EUR transaction amount
    Then Loan status will be "CLOSED_OBLIGATIONS_MET"
    Then Loan has 0 outstanding amount
    When Customer undo "1"th repayment on "20230110"
    Then Loan status will be "ACTIVE"
    Then Loan has 100 outstanding amount
    Then Loan Transactions tab has a "DISBURSEMENT" transaction with date "20230101" which has the following Journal entries:
      | Type      | Account code | Account name              | Debit  | Credit |
      | ASSET     | 112601       | Loans Receivable          | 1000.0 |        |
      | LIABILITY | 145023       | Suspense/Clearing account |        | 1000.0 |
    Then Loan Transactions tab has a "REPAYMENT" transaction with date "20230110" which has the following Journal entries:
      | Type      | Account code | Account name              | Debit | Credit |
      | ASSET     | 112601       | Loans Receivable          |       | 100.0  |
      | LIABILITY | 145023       | Suspense/Clearing account | 100.0 |        |
      | ASSET     | 112601       | Loans Receivable          | 100.0 |        |
      | LIABILITY | 145023       | Suspense/Clearing account |       | 100.0  |
    Then Loan Transactions tab has a "REPAYMENT" transaction with date "20230111" which has the following Journal entries:
      | Type      | Account code | Account name              | Debit  | Credit |
      | ASSET     | 112601       | Loans Receivable          |        | 1000.0 |
      | LIABILITY | l1           | Overpayment account       |        | 100.0  |
      | LIABILITY | 145023       | Suspense/Clearing account | 1100.0 |        |
    Then Loan Transactions tab has a "CREDIT_BALANCE_REFUND" transaction with date "20230113" which has the following Journal entries:
      | Type      | Account code | Account name              | Debit | Credit |
      | ASSET     | 112601       | Loans Receivable          | 100.0 |        |
      | LIABILITY | l1           | Overpayment account       | 100.0 |        |
      | LIABILITY | 145023       | Suspense/Clearing account |       | 200.0  |

  @TestRailId:C2518
  Scenario: Repayment reversal
    When Admin sets the business date to "20230101"
    And Admin creates a client with random data
    When Admin creates a new default Loan with date: "20230101"
    And Admin successfully approves the loan on "20230101" with "1000" amount and expected disbursement date on "20230101"
    And Admin successfully disburse the loan on "20230101" with "1000" EUR transaction amount
    When Admin sets the business date to "20230110"
    And Customer makes "AUTOPAY" repayment on "20230110" with 1000 EUR transaction amount
    When Admin sets the business date to "20230111"
    And Admin makes "PAYOUT_REFUND" transaction with "AUTOPAY" payment type on "20230111" with 1000 EUR transaction amount
    Then Loan has 0 outstanding amount
    Then Loan has 1000 overpaid amount
    When Admin sets the business date to "20230113"
    And Admin makes Credit Balance Refund transaction on "20230113" with 1000 EUR transaction amount
    Then Loan status will be "CLOSED_OBLIGATIONS_MET"
    Then Loan has 0 outstanding amount
    When Customer undo "1"th repayment on "20230110"
    Then Loan status will be "ACTIVE"
    Then Loan has 1000 outstanding amount
    Then Loan Transactions tab has a "DISBURSEMENT" transaction with date "20230101" which has the following Journal entries:
      | Type      | Account code | Account name              | Debit  | Credit |
      | ASSET     | 112601       | Loans Receivable          | 1000.0 |        |
      | LIABILITY | 145023       | Suspense/Clearing account |        | 1000.0 |
    Then Loan Transactions tab has a "REPAYMENT" transaction with date "20230110" which has the following Journal entries:
      | Type      | Account code | Account name              | Debit  | Credit |
      | ASSET     | 112601       | Loans Receivable          |        | 1000.0 |
      | LIABILITY | 145023       | Suspense/Clearing account | 1000.0 |        |
      | ASSET     | 112601       | Loans Receivable          | 1000.0 |        |
      | LIABILITY | 145023       | Suspense/Clearing account |        | 1000.0 |
    Then Loan Transactions tab has a "PAYOUT_REFUND" transaction with date "20230111" which has the following Journal entries:
      | Type      | Account code | Account name              | Debit  | Credit |
      | ASSET     | 112601       | Loans Receivable          |        | 1000.0 |
      | LIABILITY | 145023       | Suspense/Clearing account | 1000.0 |        |
    Then Loan Transactions tab has a "CREDIT_BALANCE_REFUND" transaction with date "20230113" which has the following Journal entries:
      | Type      | Account code | Account name              | Debit  | Credit |
      | ASSET     | 112601       | Loans Receivable          | 1000.0 |        |
      | LIABILITY | 145023       | Suspense/Clearing account |        | 1000.0 |

  @TestRailId:C2519
  Scenario: Refund reversal
    When Admin sets the business date to "20230101"
    And Admin creates a client with random data
    When Admin creates a new default Loan with date: "20230101"
    And Admin successfully approves the loan on "20230101" with "1000" amount and expected disbursement date on "20230101"
    And Admin successfully disburse the loan on "20230101" with "1000" EUR transaction amount
    When Admin sets the business date to "20230110"
    And Customer makes "AUTOPAY" repayment on "20230110" with 1000 EUR transaction amount
    When Admin sets the business date to "20230111"
    And Refund happens on "20230111" with 1000 EUR transaction amount
    Then Loan has 0 outstanding amount
    Then Loan has 1000 overpaid amount
    When Admin sets the business date to "20230113"
    And Admin makes Credit Balance Refund transaction on "20230113" with 1000 EUR transaction amount
    Then Loan status will be "CLOSED_OBLIGATIONS_MET"
    Then Loan has 0 outstanding amount
    When Refund undo happens on "20230113"
    Then Loan status will be "ACTIVE"
    Then Loan has 1000 outstanding amount
    Then Loan Transactions tab has a "DISBURSEMENT" transaction with date "20230101" which has the following Journal entries:
      | Type      | Account code | Account name              | Debit  | Credit |
      | ASSET     | 112601       | Loans Receivable          | 1000.0 |        |
      | LIABILITY | 145023       | Suspense/Clearing account |        | 1000.0 |
    Then Loan Transactions tab has a "REPAYMENT" transaction with date "20230110" which has the following Journal entries:
      | Type      | Account code | Account name              | Debit  | Credit |
      | ASSET     | 112601       | Loans Receivable          |        | 1000.0 |
      | LIABILITY | 145023       | Suspense/Clearing account | 1000.0 |        |
    Then Loan Transactions tab has a "PAYOUT_REFUND" transaction with date "20230111" which has the following Journal entries:
      | Type      | Account code | Account name              | Debit  | Credit |
      | LIABILITY | l1           | Overpayment account       |        | 1000.0 |
      | LIABILITY | 145023       | Suspense/Clearing account | 1000.0 |        |
      | LIABILITY | l1           | Overpayment account       | 1000.0 |        |
      | LIABILITY | 145023       | Suspense/Clearing account |        | 1000.0 |
    Then Loan Transactions tab has a "CREDIT_BALANCE_REFUND" transaction with date "20230113" which has the following Journal entries:
      | Type      | Account code | Account name              | Debit  | Credit |
      | ASSET     | 112601       | Loans Receivable          | 1000.0 |        |
      | LIABILITY | 145023       | Suspense/Clearing account |        | 1000.0 |

  @TestRailId:C2520
  Scenario: Partial refund reversal
    When Admin sets the business date to "20230101"
    And Admin creates a client with random data
    When Admin creates a new default Loan with date: "20230101"
    And Admin successfully approves the loan on "20230101" with "1000" amount and expected disbursement date on "20230101"
    And Admin successfully disburse the loan on "20230101" with "1000" EUR transaction amount
    When Admin sets the business date to "20230110"
    And Customer makes "AUTOPAY" repayment on "20230110" with 1000 EUR transaction amount
    When Admin sets the business date to "20230111"
    And Refund happens on "20230111" with 500 EUR transaction amount
    Then Loan has 0 outstanding amount
    Then Loan has 500 overpaid amount
    When Admin sets the business date to "20230113"
    And Admin makes Credit Balance Refund transaction on "20230113" with 500 EUR transaction amount
    Then Loan status will be "CLOSED_OBLIGATIONS_MET"
    Then Loan has 0 outstanding amount
    When Refund undo happens on "20230113"
    Then Loan status will be "ACTIVE"
    Then Loan has 500 outstanding amount
    Then Loan Transactions tab has a "DISBURSEMENT" transaction with date "20230101" which has the following Journal entries:
      | Type      | Account code | Account name              | Debit  | Credit |
      | ASSET     | 112601       | Loans Receivable          | 1000.0 |        |
      | LIABILITY | 145023       | Suspense/Clearing account |        | 1000.0 |
    Then Loan Transactions tab has a "REPAYMENT" transaction with date "20230110" which has the following Journal entries:
      | Type      | Account code | Account name              | Debit  | Credit |
      | ASSET     | 112601       | Loans Receivable          |        | 1000.0 |
      | LIABILITY | 145023       | Suspense/Clearing account | 1000.0 |        |
    Then Loan Transactions tab has a "PAYOUT_REFUND" transaction with date "20230111" which has the following Journal entries:
      | Type      | Account code | Account name              | Debit | Credit |
      | LIABILITY | l1           | Overpayment account       |       | 500.0  |
      | LIABILITY | 145023       | Suspense/Clearing account | 500.0 |        |
      | LIABILITY | l1           | Overpayment account       | 500.0 |        |
      | LIABILITY | 145023       | Suspense/Clearing account |       | 500.0  |
    Then Loan Transactions tab has a "CREDIT_BALANCE_REFUND" transaction with date "20230113" which has the following Journal entries:
      | Type      | Account code | Account name              | Debit | Credit |
      | ASSET     | 112601       | Loans Receivable          | 500.0 |        |
      | LIABILITY | 145023       | Suspense/Clearing account |       | 500.0  |

  @TestRailId:C2521
  Scenario: Chargeback after CBR
    When Admin sets the business date to "20230101"
    And Admin creates a client with random data
    When Admin creates a new default Loan with date: "20230101"
    And Admin successfully approves the loan on "20230101" with "1000" amount and expected disbursement date on "20230101"
    And Admin successfully disburse the loan on "20230101" with "1000" EUR transaction amount
    When Admin sets the business date to "20230110"
    And Customer makes "AUTOPAY" repayment on "20230110" with 500 EUR transaction amount
    When Admin sets the business date to "20230111"
    And Customer makes "AUTOPAY" repayment on "20230111" with 700 EUR transaction amount
    Then Loan has 0 outstanding amount
    Then Loan has 200 overpaid amount
    When Admin sets the business date to "20230113"
    And Admin makes Credit Balance Refund transaction on "20230113" with 200 EUR transaction amount
    Then Loan status will be "CLOSED_OBLIGATIONS_MET"
    Then Loan has 0 outstanding amount
    When Admin sets the business date to "20230115"
    And Admin makes "REPAYMENT_ADJUSTMENT_CHARGEBACK" chargeback with 500 EUR transaction amount for Payment nr. 1
    Then Loan status will be "ACTIVE"
    Then Loan has 500 outstanding amount
    When Customer undo "2"th repayment on "20230111"
    Then Loan status will be "ACTIVE"
    Then Loan has 1200 outstanding amount
    Then Loan Transactions tab has a "DISBURSEMENT" transaction with date "20230101" which has the following Journal entries:
      | Type      | Account code | Account name              | Debit  | Credit |
      | ASSET     | 112601       | Loans Receivable          | 1000.0 |        |
      | LIABILITY | 145023       | Suspense/Clearing account |        | 1000.0 |
    Then Loan Transactions tab has a "REPAYMENT" transaction with date "20230110" which has the following Journal entries:
      | Type      | Account code | Account name              | Debit | Credit |
      | ASSET     | 112601       | Loans Receivable          |       | 500.0  |
      | LIABILITY | 145023       | Suspense/Clearing account | 500.0 |        |
    Then Loan Transactions tab has a "REPAYMENT" transaction with date "20230111" which has the following Journal entries:
      | Type      | Account code | Account name              | Debit | Credit |
      | ASSET     | 112601       | Loans Receivable          |       | 500.0  |
      | LIABILITY | l1           | Overpayment account       |       | 200.0  |
      | LIABILITY | 145023       | Suspense/Clearing account | 700.0 |        |
      | ASSET     | 112601       | Loans Receivable          | 500.0 |        |
      | LIABILITY | l1           | Overpayment account       | 200.0 |        |
      | LIABILITY | 145023       | Suspense/Clearing account |       | 700.0  |
    Then Loan Transactions tab has a "CREDIT_BALANCE_REFUND" transaction with date "20230113" which has the following Journal entries:
      | Type      | Account code | Account name              | Debit | Credit |
      | ASSET     | 112601       | Loans Receivable          | 200.0 |        |
      | LIABILITY | 145023       | Suspense/Clearing account |       | 200.0  |
    Then Loan Transactions tab has a "CHARGEBACK" transaction with date "20230115" which has the following Journal entries:
      | Type      | Account code | Account name              | Debit | Credit |
      | ASSET     | 112601       | Loans Receivable          | 500.0 |        |
      | LIABILITY | 145023       | Suspense/Clearing account |       | 500.0  |

  @TestRailId:C2522
  Scenario: Refund after CBR scenario
    When Admin sets the business date to "20230101"
    And Admin creates a client with random data
    When Admin creates a new default Loan with date: "20230101"
    And Admin successfully approves the loan on "20230101" with "1000" amount and expected disbursement date on "20230101"
    And Admin successfully disburse the loan on "20230101" with "1000" EUR transaction amount
    When Admin sets the business date to "20230110"
    And Customer makes "AUTOPAY" repayment on "20230110" with 500 EUR transaction amount
    When Admin sets the business date to "20230111"
    And Customer makes "AUTOPAY" repayment on "20230111" with 700 EUR transaction amount
    Then Loan has 0 outstanding amount
    Then Loan has 200 overpaid amount
    When Admin sets the business date to "20230113"
    And Admin makes Credit Balance Refund transaction on "20230113" with 200 EUR transaction amount
    Then Loan status will be "CLOSED_OBLIGATIONS_MET"
    Then Loan has 0 outstanding amount
    When Admin sets the business date to "20230115"
    And Refund happens on "20230115" with 500 EUR transaction amount
    When Admin sets the business date to "20230117"
    And Admin makes Credit Balance Refund transaction on "20230117" with 500 EUR transaction amount
    Then Loan has 0 outstanding amount
    Then Loan status will be "CLOSED_OBLIGATIONS_MET"
    When Customer undo "2"th repayment on "20230111"
    Then Loan has 700 outstanding amount
    Then Loan Transactions tab has a "DISBURSEMENT" transaction with date "20230101" which has the following Journal entries:
      | Type      | Account code | Account name              | Debit  | Credit |
      | ASSET     | 112601       | Loans Receivable          | 1000.0 |        |
      | LIABILITY | 145023       | Suspense/Clearing account |        | 1000.0 |
    Then Loan Transactions tab has a "REPAYMENT" transaction with date "20230110" which has the following Journal entries:
      | Type      | Account code | Account name              | Debit | Credit |
      | ASSET     | 112601       | Loans Receivable          |       | 500.0  |
      | LIABILITY | 145023       | Suspense/Clearing account | 500.0 |        |
    Then Loan Transactions tab has a "REPAYMENT" transaction with date "20230111" which has the following Journal entries:
      | Type      | Account code | Account name              | Debit | Credit |
      | ASSET     | 112601       | Loans Receivable          |       | 500.0  |
      | LIABILITY | l1           | Overpayment account       |       | 200.0  |
      | LIABILITY | 145023       | Suspense/Clearing account | 700.0 |        |
      | ASSET     | 112601       | Loans Receivable          | 500.0 |        |
      | LIABILITY | l1           | Overpayment account       | 200.0 |        |
      | LIABILITY | 145023       | Suspense/Clearing account |       | 700.0  |
    Then Loan Transactions tab has a "CREDIT_BALANCE_REFUND" transaction with date "20230113" which has the following Journal entries:
      | Type      | Account code | Account name              | Debit | Credit |
      | ASSET     | 112601       | Loans Receivable          | 200.0 |        |
      | LIABILITY | 145023       | Suspense/Clearing account |       | 200.0  |
    Then Loan Transactions tab has a "PAYOUT_REFUND" transaction with date "20230115" which has the following Journal entries:
      | Type      | Account code | Account name              | Debit | Credit |
      | ASSET     | 112601       | Loans Receivable          |       | 500.0  |
      | LIABILITY | 145023       | Suspense/Clearing account | 500.0 |        |
    Then Loan Transactions tab has a "CREDIT_BALANCE_REFUND" transaction with date "20230117" which has the following Journal entries:
      | Type      | Account code | Account name              | Debit | Credit |
      | ASSET     | 112601       | Loans Receivable          | 500.0 |        |
      | LIABILITY | 145023       | Suspense/Clearing account |       | 500.0  |

  @TestRailId:C2523
  Scenario: Single repayment reversal (after maturity)
    When Admin sets the business date to "20230101"
    And Admin creates a client with random data
    When Admin creates a new default Loan with date: "20230101"
    And Admin successfully approves the loan on "20230101" with "1000" amount and expected disbursement date on "20230101"
    And Admin successfully disburse the loan on "20230101" with "1000" EUR transaction amount
    When Admin sets the business date to "20230201"
    And Customer makes "AUTOPAY" repayment on "20230201" with 1200 EUR transaction amount
    When Admin sets the business date to "20230211"
    And Admin makes Credit Balance Refund transaction on "20230211" with 200 EUR transaction amount
    Then Loan status will be "CLOSED_OBLIGATIONS_MET"
    Then Loan has 0 outstanding amount
    When Customer undo "1"th repayment on "20230201"
    Then Loan status will be "ACTIVE"
    Then Loan has 1200 outstanding amount
    Then Loan Transactions tab has a "DISBURSEMENT" transaction with date "20230101" which has the following Journal entries:
      | Type      | Account code | Account name              | Debit  | Credit |
      | ASSET     | 112601       | Loans Receivable          | 1000.0 |        |
      | LIABILITY | 145023       | Suspense/Clearing account |        | 1000.0 |
    Then Loan Transactions tab has a "REPAYMENT" transaction with date "20230201" which has the following Journal entries:
      | Type      | Account code | Account name              | Debit  | Credit |
      | ASSET     | 112601       | Loans Receivable          |        | 1000.0 |
      | LIABILITY | l1           | Overpayment account       |        | 200.0  |
      | LIABILITY | 145023       | Suspense/Clearing account | 1200.0 |        |
      | ASSET     | 112601       | Loans Receivable          | 1000.0 |        |
      | LIABILITY | l1           | Overpayment account       | 200.0  |        |
      | LIABILITY | 145023       | Suspense/Clearing account |        | 1200.0 |
    Then Loan Transactions tab has a "CREDIT_BALANCE_REFUND" transaction with date "20230211" which has the following Journal entries:
      | Type      | Account code | Account name              | Debit | Credit |
      | ASSET     | 112601       | Loans Receivable          | 200.0 |        |
      | LIABILITY | 145023       | Suspense/Clearing account |       | 200.0  |

  @TestRailId:C2524
  Scenario: Multi repayment reversal (after maturity)
    When Admin sets the business date to "20230101"
    And Admin creates a client with random data
    When Admin creates a new default Loan with date: "20230101"
    And Admin successfully approves the loan on "20230101" with "1000" amount and expected disbursement date on "20230101"
    And Admin successfully disburse the loan on "20230101" with "1000" EUR transaction amount
    When Admin sets the business date to "20230201"
    And Customer makes "AUTOPAY" repayment on "20230201" with 500 EUR transaction amount
    When Admin sets the business date to "20230202"
    And Customer makes "AUTOPAY" repayment on "20230202" with 700 EUR transaction amount
    Then Loan has 0 outstanding amount
    Then Loan has 200 overpaid amount
    When Admin sets the business date to "20230211"
    And Admin makes Credit Balance Refund transaction on "20230211" with 200 EUR transaction amount
    Then Loan status will be "CLOSED_OBLIGATIONS_MET"
    Then Loan has 0 outstanding amount
    When Customer undo "1"th repayment on "20230201"
    Then Loan status will be "ACTIVE"
    Then Loan has 500 outstanding amount
    Then Loan Transactions tab has a "DISBURSEMENT" transaction with date "20230101" which has the following Journal entries:
      | Type      | Account code | Account name              | Debit  | Credit |
      | ASSET     | 112601       | Loans Receivable          | 1000.0 |        |
      | LIABILITY | 145023       | Suspense/Clearing account |        | 1000.0 |
    Then Loan Transactions tab has a "REPAYMENT" transaction with date "20230201" which has the following Journal entries:
      | Type      | Account code | Account name              | Debit | Credit |
      | ASSET     | 112601       | Loans Receivable          |       | 500.0  |
      | LIABILITY | 145023       | Suspense/Clearing account | 500.0 |        |
      | ASSET     | 112601       | Loans Receivable          | 500.0 |        |
      | LIABILITY | 145023       | Suspense/Clearing account |       | 500.0  |
    Then Loan Transactions tab has a "REPAYMENT" transaction with date "20230202" which has the following Journal entries:
      | Type      | Account code | Account name              | Debit | Credit |
      | ASSET     | 112601       | Loans Receivable          |       | 700.0  |
      | LIABILITY | 145023       | Suspense/Clearing account | 700.0 |        |
    Then Loan Transactions tab has a "CREDIT_BALANCE_REFUND" transaction with date "20230211" which has the following Journal entries:
      | Type      | Account code | Account name              | Debit | Credit |
      | ASSET     | 112601       | Loans Receivable          | 200.0 |        |
      | LIABILITY | 145023       | Suspense/Clearing account |       | 200.0  |

  @TestRailId:C2525
  Scenario: Overpaid paid portion (after maturity)
    When Admin sets the business date to "20230101"
    And Admin creates a client with random data
    When Admin creates a new default Loan with date: "20230101"
    And Admin successfully approves the loan on "20230101" with "1000" amount and expected disbursement date on "20230101"
    And Admin successfully disburse the loan on "20230101" with "1000" EUR transaction amount
    When Admin sets the business date to "20230201"
    And Customer makes "AUTOPAY" repayment on "20230201" with 100 EUR transaction amount
    When Admin sets the business date to "20230202"
    And Customer makes "AUTOPAY" repayment on "20230202" with 1100 EUR transaction amount
    Then Loan has 0 outstanding amount
    Then Loan has 200 overpaid amount
    When Admin sets the business date to "20230211"
    And Admin makes Credit Balance Refund transaction on "20230211" with 200 EUR transaction amount
    Then Loan status will be "CLOSED_OBLIGATIONS_MET"
    Then Loan has 0 outstanding amount
    When Customer undo "1"th repayment on "20230201"
    Then Loan status will be "ACTIVE"
    Then Loan has 100 outstanding amount
    Then Loan Transactions tab has a "DISBURSEMENT" transaction with date "20230101" which has the following Journal entries:
      | Type      | Account code | Account name              | Debit  | Credit |
      | ASSET     | 112601       | Loans Receivable          | 1000.0 |        |
      | LIABILITY | 145023       | Suspense/Clearing account |        | 1000.0 |
    Then Loan Transactions tab has a "REPAYMENT" transaction with date "20230201" which has the following Journal entries:
      | Type      | Account code | Account name              | Debit | Credit |
      | ASSET     | 112601       | Loans Receivable          |       | 100.0  |
      | LIABILITY | 145023       | Suspense/Clearing account | 100.0 |        |
      | ASSET     | 112601       | Loans Receivable          | 100.0 |        |
      | LIABILITY | 145023       | Suspense/Clearing account |       | 100.0  |
    Then Loan Transactions tab has a "REPAYMENT" transaction with date "20230202" which has the following Journal entries:
      | Type      | Account code | Account name              | Debit  | Credit |
      | ASSET     | 112601       | Loans Receivable          |        | 1000.0 |
      | LIABILITY | l1           | Overpayment account       |        | 100.0  |
      | LIABILITY | 145023       | Suspense/Clearing account | 1100.0 |        |
    Then Loan Transactions tab has a "CREDIT_BALANCE_REFUND" transaction with date "20230211" which has the following Journal entries:
      | Type      | Account code | Account name              | Debit | Credit |
      | ASSET     | 112601       | Loans Receivable          | 100.0 |        |
      | LIABILITY | l1           | Overpayment account       | 100.0 |        |
      | LIABILITY | 145023       | Suspense/Clearing account |       | 200.0  |

  @TestRailId:C2526
  Scenario: Repayment reversal (after maturity)
    When Admin sets the business date to "20230101"
    And Admin creates a client with random data
    When Admin creates a new default Loan with date: "20230101"
    And Admin successfully approves the loan on "20230101" with "1000" amount and expected disbursement date on "20230101"
    And Admin successfully disburse the loan on "20230101" with "1000" EUR transaction amount
    When Admin sets the business date to "20230201"
    And Customer makes "AUTOPAY" repayment on "20230201" with 1000 EUR transaction amount
    When Admin sets the business date to "20230210"
    And Admin makes "PAYOUT_REFUND" transaction with "AUTOPAY" payment type on "20230210" with 1000 EUR transaction amount
    Then Loan has 0 outstanding amount
    Then Loan has 1000 overpaid amount
    When Admin sets the business date to "20230211"
    And Admin makes Credit Balance Refund transaction on "20230211" with 1000 EUR transaction amount
    Then Loan status will be "CLOSED_OBLIGATIONS_MET"
    Then Loan has 0 outstanding amount
    When Customer undo "1"th repayment on "20230201"
    Then Loan status will be "ACTIVE"
    Then Loan has 1000 outstanding amount
    Then Loan Transactions tab has a "DISBURSEMENT" transaction with date "20230101" which has the following Journal entries:
      | Type      | Account code | Account name              | Debit  | Credit |
      | ASSET     | 112601       | Loans Receivable          | 1000.0 |        |
      | LIABILITY | 145023       | Suspense/Clearing account |        | 1000.0 |
    Then Loan Transactions tab has a "REPAYMENT" transaction with date "20230201" which has the following Journal entries:
      | Type      | Account code | Account name              | Debit  | Credit |
      | ASSET     | 112601       | Loans Receivable          |        | 1000.0 |
      | LIABILITY | 145023       | Suspense/Clearing account | 1000.0 |        |
      | ASSET     | 112601       | Loans Receivable          | 1000.0 |        |
      | LIABILITY | 145023       | Suspense/Clearing account |        | 1000.0 |
    Then Loan Transactions tab has a "PAYOUT_REFUND" transaction with date "20230210" which has the following Journal entries:
      | Type      | Account code | Account name              | Debit  | Credit |
      | ASSET     | 112601       | Loans Receivable          |        | 1000.0 |
      | LIABILITY | 145023       | Suspense/Clearing account | 1000.0 |        |
    Then Loan Transactions tab has a "CREDIT_BALANCE_REFUND" transaction with date "20230211" which has the following Journal entries:
      | Type      | Account code | Account name              | Debit  | Credit |
      | ASSET     | 112601       | Loans Receivable          | 1000.0 |        |
      | LIABILITY | 145023       | Suspense/Clearing account |        | 1000.0 |

  @TestRailId:C2527
  Scenario: Refund reversal (after maturity)
    When Admin sets the business date to "20230101"
    And Admin creates a client with random data
    When Admin creates a new default Loan with date: "20230101"
    And Admin successfully approves the loan on "20230101" with "1000" amount and expected disbursement date on "20230101"
    And Admin successfully disburse the loan on "20230101" with "1000" EUR transaction amount
    When Admin sets the business date to "20230201"
    And Customer makes "AUTOPAY" repayment on "20230201" with 1000 EUR transaction amount
    When Admin sets the business date to "20230210"
    And Refund happens on "20230210" with 1000 EUR transaction amount
    Then Loan has 0 outstanding amount
    Then Loan has 1000 overpaid amount
    When Admin sets the business date to "20230211"
    And Admin makes Credit Balance Refund transaction on "20230211" with 1000 EUR transaction amount
    Then Loan status will be "CLOSED_OBLIGATIONS_MET"
    Then Loan has 0 outstanding amount
    When Refund undo happens on "20230210"
    Then Loan status will be "ACTIVE"
    Then Loan has 1000 outstanding amount
    Then Loan Transactions tab has a "DISBURSEMENT" transaction with date "20230101" which has the following Journal entries:
      | Type      | Account code | Account name              | Debit  | Credit |
      | ASSET     | 112601       | Loans Receivable          | 1000.0 |        |
      | LIABILITY | 145023       | Suspense/Clearing account |        | 1000.0 |
    Then Loan Transactions tab has a "REPAYMENT" transaction with date "20230201" which has the following Journal entries:
      | Type      | Account code | Account name              | Debit  | Credit |
      | ASSET     | 112601       | Loans Receivable          |        | 1000.0 |
      | LIABILITY | 145023       | Suspense/Clearing account | 1000.0 |        |
    Then Loan Transactions tab has a "PAYOUT_REFUND" transaction with date "20230210" which has the following Journal entries:
      | Type      | Account code | Account name              | Debit  | Credit |
      | LIABILITY | l1           | Overpayment account       |        | 1000.0 |
      | LIABILITY | 145023       | Suspense/Clearing account | 1000.0 |        |
      | LIABILITY | l1           | Overpayment account       | 1000.0 |        |
      | LIABILITY | 145023       | Suspense/Clearing account |        | 1000.0 |
    Then Loan Transactions tab has a "CREDIT_BALANCE_REFUND" transaction with date "20230211" which has the following Journal entries:
      | Type      | Account code | Account name              | Debit  | Credit |
      | ASSET     | 112601       | Loans Receivable          | 1000.0 |        |
      | LIABILITY | 145023       | Suspense/Clearing account |        | 1000.0 |

  @TestRailId:C2528
  Scenario: Partial refund reversal (after maturity)
    When Admin sets the business date to "20230101"
    And Admin creates a client with random data
    When Admin creates a new default Loan with date: "20230101"
    And Admin successfully approves the loan on "20230101" with "1000" amount and expected disbursement date on "20230101"
    And Admin successfully disburse the loan on "20230101" with "1000" EUR transaction amount
    When Admin sets the business date to "20230201"
    And Customer makes "AUTOPAY" repayment on "20230201" with 1000 EUR transaction amount
    When Admin sets the business date to "20230210"
    And Refund happens on "20230210" with 500 EUR transaction amount
    Then Loan has 0 outstanding amount
    Then Loan has 500 overpaid amount
    When Admin sets the business date to "20230211"
    And Admin makes Credit Balance Refund transaction on "20230211" with 500 EUR transaction amount
    Then Loan status will be "CLOSED_OBLIGATIONS_MET"
    Then Loan has 0 outstanding amount
    When Refund undo happens on "20230210"
    Then Loan status will be "ACTIVE"
    Then Loan has 500 outstanding amount
    Then Loan Transactions tab has a "DISBURSEMENT" transaction with date "20230101" which has the following Journal entries:
      | Type      | Account code | Account name              | Debit  | Credit |
      | ASSET     | 112601       | Loans Receivable          | 1000.0 |        |
      | LIABILITY | 145023       | Suspense/Clearing account |        | 1000.0 |
    Then Loan Transactions tab has a "REPAYMENT" transaction with date "20230201" which has the following Journal entries:
      | Type      | Account code | Account name              | Debit  | Credit |
      | ASSET     | 112601       | Loans Receivable          |        | 1000.0 |
      | LIABILITY | 145023       | Suspense/Clearing account | 1000.0 |        |
    Then Loan Transactions tab has a "PAYOUT_REFUND" transaction with date "20230210" which has the following Journal entries:
      | Type      | Account code | Account name              | Debit | Credit |
      | LIABILITY | l1           | Overpayment account       |       | 500.0  |
      | LIABILITY | 145023       | Suspense/Clearing account | 500.0 |        |
      | LIABILITY | l1           | Overpayment account       | 500.0 |        |
      | LIABILITY | 145023       | Suspense/Clearing account |       | 500.0  |
    Then Loan Transactions tab has a "CREDIT_BALANCE_REFUND" transaction with date "20230211" which has the following Journal entries:
      | Type      | Account code | Account name              | Debit | Credit |
      | ASSET     | 112601       | Loans Receivable          | 500.0 |        |
      | LIABILITY | 145023       | Suspense/Clearing account |       | 500.0  |

  @TestRailId:C2529
  Scenario: Chargeback after CBR (after maturity)
    When Admin sets the business date to "20230101"
    And Admin creates a client with random data
    When Admin creates a new default Loan with date: "20230101"
    And Admin successfully approves the loan on "20230101" with "1000" amount and expected disbursement date on "20230101"
    And Admin successfully disburse the loan on "20230101" with "1000" EUR transaction amount
    When Admin sets the business date to "20230201"
    And Customer makes "AUTOPAY" repayment on "20230201" with 500 EUR transaction amount
    When Admin sets the business date to "20230202"
    And Customer makes "AUTOPAY" repayment on "20230202" with 700 EUR transaction amount
    Then Loan has 0 outstanding amount
    Then Loan has 200 overpaid amount
    When Admin sets the business date to "20230211"
    And Admin makes Credit Balance Refund transaction on "20230211" with 200 EUR transaction amount
    Then Loan status will be "CLOSED_OBLIGATIONS_MET"
    Then Loan has 0 outstanding amount
    When Admin sets the business date to "20230215"
    And Admin makes "REPAYMENT_ADJUSTMENT_CHARGEBACK" chargeback with 500 EUR transaction amount for Payment nr. 1
    Then Loan status will be "ACTIVE"
    Then Loan has 500 outstanding amount
    When Customer undo "2"th repayment on "20230202"
    Then Loan status will be "ACTIVE"
    Then Loan has 1200 outstanding amount
    Then Loan Transactions tab has a "DISBURSEMENT" transaction with date "20230101" which has the following Journal entries:
      | Type      | Account code | Account name              | Debit  | Credit |
      | ASSET     | 112601       | Loans Receivable          | 1000.0 |        |
      | LIABILITY | 145023       | Suspense/Clearing account |        | 1000.0 |
    Then Loan Transactions tab has a "REPAYMENT" transaction with date "20230201" which has the following Journal entries:
      | Type      | Account code | Account name              | Debit | Credit |
      | ASSET     | 112601       | Loans Receivable          |       | 500.0  |
      | LIABILITY | 145023       | Suspense/Clearing account | 500.0 |        |
    Then Loan Transactions tab has a "REPAYMENT" transaction with date "20230202" which has the following Journal entries:
      | Type      | Account code | Account name              | Debit | Credit |
      | ASSET     | 112601       | Loans Receivable          |       | 500.0  |
      | LIABILITY | l1           | Overpayment account       |       | 200.0  |
      | LIABILITY | 145023       | Suspense/Clearing account | 700.0 |        |
      | ASSET     | 112601       | Loans Receivable          | 500.0 |        |
      | LIABILITY | l1           | Overpayment account       | 200.0 |        |
      | LIABILITY | 145023       | Suspense/Clearing account |       | 700.0  |
    Then Loan Transactions tab has a "CREDIT_BALANCE_REFUND" transaction with date "20230211" which has the following Journal entries:
      | Type      | Account code | Account name              | Debit | Credit |
      | ASSET     | 112601       | Loans Receivable          | 200.0 |        |
      | LIABILITY | 145023       | Suspense/Clearing account |       | 200.0  |
    Then Loan Transactions tab has a "CHARGEBACK" transaction with date "20230215" which has the following Journal entries:
      | Type      | Account code | Account name              | Debit | Credit |
      | ASSET     | 112601       | Loans Receivable          | 500.0 |        |
      | LIABILITY | 145023       | Suspense/Clearing account |       | 500.0  |

  @TestRailId:C2530
  Scenario: Refund after CBR scenario (after maturity)
    When Admin sets the business date to "20230101"
    And Admin creates a client with random data
    When Admin creates a new default Loan with date: "20230101"
    And Admin successfully approves the loan on "20230101" with "1000" amount and expected disbursement date on "20230101"
    And Admin successfully disburse the loan on "20230101" with "1000" EUR transaction amount
    When Admin sets the business date to "20230201"
    And Customer makes "AUTOPAY" repayment on "20230201" with 500 EUR transaction amount
    When Admin sets the business date to "20230202"
    And Customer makes "AUTOPAY" repayment on "20230202" with 700 EUR transaction amount
    Then Loan has 0 outstanding amount
    Then Loan has 200 overpaid amount
    When Admin sets the business date to "20230211"
    And Admin makes Credit Balance Refund transaction on "20230211" with 200 EUR transaction amount
    Then Loan status will be "CLOSED_OBLIGATIONS_MET"
    Then Loan has 0 outstanding amount
    When Admin sets the business date to "20230215"
    And Refund happens on "20230215" with 500 EUR transaction amount
    When Admin sets the business date to "20230217"
    And Admin makes Credit Balance Refund transaction on "20230217" with 500 EUR transaction amount
    Then Loan has 0 outstanding amount
    Then Loan status will be "CLOSED_OBLIGATIONS_MET"
    When Customer undo "2"th repayment on "20230202"
    Then Loan has 700 outstanding amount
    Then Loan Transactions tab has a "DISBURSEMENT" transaction with date "20230101" which has the following Journal entries:
      | Type      | Account code | Account name              | Debit  | Credit |
      | ASSET     | 112601       | Loans Receivable          | 1000.0 |        |
      | LIABILITY | 145023       | Suspense/Clearing account |        | 1000.0 |
    Then Loan Transactions tab has a "REPAYMENT" transaction with date "20230201" which has the following Journal entries:
      | Type      | Account code | Account name              | Debit | Credit |
      | ASSET     | 112601       | Loans Receivable          |       | 500.0  |
      | LIABILITY | 145023       | Suspense/Clearing account | 500.0 |        |
    Then Loan Transactions tab has a "REPAYMENT" transaction with date "20230202" which has the following Journal entries:
      | Type      | Account code | Account name              | Debit | Credit |
      | ASSET     | 112601       | Loans Receivable          |       | 500.0  |
      | LIABILITY | l1           | Overpayment account       |       | 200.0  |
      | LIABILITY | 145023       | Suspense/Clearing account | 700.0 |        |
      | ASSET     | 112601       | Loans Receivable          | 500.0 |        |
      | LIABILITY | l1           | Overpayment account       | 200.0 |        |
      | LIABILITY | 145023       | Suspense/Clearing account |       | 700.0  |
    Then Loan Transactions tab has a "CREDIT_BALANCE_REFUND" transaction with date "20230211" which has the following Journal entries:
      | Type      | Account code | Account name              | Debit | Credit |
      | ASSET     | 112601       | Loans Receivable          | 200.0 |        |
      | LIABILITY | 145023       | Suspense/Clearing account |       | 200.0  |
    Then Loan Transactions tab has a "PAYOUT_REFUND" transaction with date "20230215" which has the following Journal entries:
      | Type      | Account code | Account name              | Debit | Credit |
      | ASSET     | 112601       | Loans Receivable          |       | 500.0  |
      | LIABILITY | 145023       | Suspense/Clearing account | 500.0 |        |
    Then Loan Transactions tab has a "CREDIT_BALANCE_REFUND" transaction with date "20230217" which has the following Journal entries:
      | Type      | Account code | Account name              | Debit | Credit |
      | ASSET     | 112601       | Loans Receivable          | 500.0 |        |
      | LIABILITY | 145023       | Suspense/Clearing account |       | 500.0  |

  @TestRailId:C2841
  Scenario: Verify that accruals created for charges after CBR post-maturity
    When Admin sets the business date to "20230701"
    And Admin creates a client with random data
    When Admin creates a new default Loan with date: "20230701"
    And Admin successfully approves the loan on "20230701" with "1000" amount and expected disbursement date on "20230701"
    And Admin successfully disburse the loan on "20230701" with "1000" EUR transaction amount
    When Admin sets the business date to "20230731"
    And Customer makes "AUTOPAY" repayment on "20230731" with 1000 EUR transaction amount
    When Admin sets the business date to "20230801"
    When Customer makes "MERCHANT_ISSUED_REFUND" transaction with "AUTOPAY" payment type on "20230801" with 200 EUR transaction amount and system-generated Idempotency key
    When Admin runs inline COB job for Loan
    When Admin sets the business date to "20230802"
    And Admin makes Credit Balance Refund transaction on "20230802" with 200 EUR transaction amount
    Then Loan Repayment schedule has 1 periods, with the following data for periods:
      | Nr | Days | Date         | Paid date    | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late | Outstanding |
      |    |      | 20230701 |              | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0    |            |      |             |
      | 1  | 30   | 20230731 | 20230731 | 0.0             | 1000.0        | 0.0      | 0.0  | 0.0       | 1000.0 | 1000.0 | 0.0        | 0.0  | 0.0         |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late | Outstanding |
      | 1000.0        | 0.0      | 0.0  | 0.0       | 1000.0 | 1000.0 | 0.0        | 0.0  | 0.0         |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type       | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20230701     | Disbursement           | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
      | 20230731     | Repayment              | 1000.0 | 1000.0    | 0.0      | 0.0  | 0.0       | 0.0          |
      | 20230801   | Merchant Issued Refund | 200.0  | 0.0       | 0.0      | 0.0  | 0.0       | 0.0          |
      | 20230802   | Credit Balance Refund  | 200.0  | 0.0       | 0.0      | 0.0  | 0.0       | 0.0          |
    When Admin runs inline COB job for Loan
    When Admin sets the business date to "20230803"
    When Admin adds "LOAN_SNOOZE_FEE" due date charge with "20230803" due date and 10 EUR transaction amount
    When Admin runs inline COB job for Loan
    When Admin sets the business date to "20230804"
    When Admin runs inline COB job for Loan
    Then Loan Repayment schedule has 2 periods, with the following data for periods:
      | Nr | Days | Date           | Paid date    | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late | Outstanding |
      |    |      | 20230701   |              | 1000.0          |               |          | 0.0  |           | 0.0    | 0.0    |            |      |             |
      | 1  | 30   | 20230731   | 20230731 | 0.0             | 1000.0        | 0.0      | 0.0  | 0.0       | 1000.0 | 1000.0 | 0.0        | 0.0  | 0.0         |
      | 2  | 3    | 20230803 |              | 0.0             | 200.0         | 0.0      | 10.0 | 0.0       | 210.0  | 200.0  | 200.0      | 0.0  | 10.0        |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late | Outstanding |
      | 1200.0        | 0.0      | 10.0 | 0.0       | 1210.0 | 1200.0 | 200.0      | 0.0  | 10.0        |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type       | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20230701     | Disbursement           | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
      | 20230731     | Repayment              | 1000.0 | 1000.0    | 0.0      | 0.0  | 0.0       | 0.0          |
      | 20230801   | Merchant Issued Refund | 200.0  | 0.0       | 0.0      | 10.0 | 0.0       | 0.0          |
      | 20230802   | Credit Balance Refund  | 200.0  | 10.0      | 0.0      | 0.0  | 0.0       | 10.0         |
      | 20230803   | Accrual                | 10.0   | 0.0       | 0.0      | 10.0 | 0.0       | 0.0          |

  @TestRailId:C2885
  Scenario: Verify that Loan status goes from overpaid to active in case of CBR transaction (with replaying when CBR>new balance → clears overpaid, remaining increasing loan balance) - LP2_DOWNPAYMENT_AUTO_ADVANCED_PAYMENT_ALLOCATION loan product
    When Admin sets the business date to "20230901"
    When Admin creates a client with random data
    When Admin set "LP2_DOWNPAYMENT_AUTO_ADVANCED_PAYMENT_ALLOCATION" loan product "DEFAULT" transaction type to "NEXT_INSTALLMENT" future installment allocation rule
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                      | submitted on date | with Principal | ANNUAL interest rate % | interest type | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_DOWNPAYMENT_AUTO_ADVANCED_PAYMENT_ALLOCATION | 20230901 | 1000           | 0                      | FLAT          | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 45                | DAYS                  | 15             | DAYS                   | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20230901" with "1000" amount and expected disbursement date on "20230901"
    When Admin successfully disburse the loan on "20230901" with "1000" EUR transaction amount
    When Admin sets the business date to "20230916"
    And Customer makes "AUTOPAY" repayment on "20230916" with 250 EUR transaction amount
    When Admin sets the business date to "20231001"
    And Customer makes "AUTOPAY" repayment on "20231001" with 250 EUR transaction amount
    When Admin sets the business date to "20231016"
    And Customer makes "AUTOPAY" repayment on "20231016" with 350 EUR transaction amount
    Then Loan status will be "OVERPAID"
    Then Loan has 0 outstanding amount
    Then Loan has 100 overpaid amount
    When Admin makes Credit Balance Refund transaction on "20231016" with 100 EUR transaction amount
    Then Loan status will be "CLOSED_OBLIGATIONS_MET"
    Then Loan has 0 outstanding amount
    When Customer undo "1"th repayment on "20230916"
    Then Loan status will be "ACTIVE"
    Then Loan has 250 outstanding amount
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date         | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late  | Outstanding |
      |    |      | 20230901 |                   | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |       |             |
      | 1  | 0    | 20230901 | 20230901 | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0   | 0.0         |
      | 2  | 15   | 20230916 | 20231001   | 500.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 250.0 | 0.0         |
      | 3  | 15   | 20231001   | 20231016   | 250.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 250.0 | 0.0         |
      | 4  | 15   | 20231016   |                   | 0.0             | 350.0         | 0.0      | 0.0  | 0.0       | 350.0 | 100.0 | 0.0        | 0.0   | 250.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 1100.0        | 0        | 0    | 0         | 1100.0 | 850.0 | 0          | 500  | 250         |
    Then On Loan Transactions tab the "Repayment" Transaction with date "20230916" is reverted
    Then Loan Transactions tab has the following data:
      | Transaction date  | Transaction Type      | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20230901 | Disbursement          | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
      | 20230901 | Down Payment          | 250.0  | 250.0     | 0.0      | 0.0  | 0.0       | 750.0        |
      | 20230916 | Repayment             | 250.0  | 250.0     | 0.0      | 0.0  | 0.0       | 500.0        |
      | 20231001   | Repayment             | 250.0  | 250.0     | 0.0      | 0.0  | 0.0       | 500.0        |
      | 20231016   | Repayment             | 350.0  | 350.0     | 0.0      | 0.0  | 0.0       | 150.0        |
      | 20231016   | Credit Balance Refund | 100.0  | 100.0     | 0.0      | 0.0  | 0.0       | 250.0        |
    Then Loan Transactions tab has a "DISBURSEMENT" transaction with date "20230901" which has the following Journal entries:
      | Type      | Account code | Account name              | Debit  | Credit |
      | ASSET     | 112601       | Loans Receivable          | 1000.0 |        |
      | LIABILITY | 145023       | Suspense/Clearing account |        | 1000.0 |
    Then Loan Transactions tab has a "DOWN_PAYMENT" transaction with date "20230901" which has the following Journal entries:
      | Type      | Account code | Account name              | Debit | Credit |
      | ASSET     | 112601       | Loans Receivable          |       | 250.0  |
      | LIABILITY | 145023       | Suspense/Clearing account | 250.0 |        |
    Then Loan Transactions tab has a "REPAYMENT" transaction with date "20230916" which has the following Journal entries:
      | Type      | Account code | Account name              | Debit | Credit |
      | ASSET     | 112601       | Loans Receivable          |       | 250.0  |
      | LIABILITY | 145023       | Suspense/Clearing account | 250.0 |        |
      | ASSET     | 112601       | Loans Receivable          | 250.0 |        |
      | LIABILITY | 145023       | Suspense/Clearing account |       | 250.0  |
    Then Loan Transactions tab has a "REPAYMENT" transaction with date "20231001" which has the following Journal entries:
      | Type      | Account code | Account name              | Debit | Credit |
      | ASSET     | 112601       | Loans Receivable          |       | 250.0  |
      | LIABILITY | 145023       | Suspense/Clearing account | 250.0 |        |
    Then Loan Transactions tab has a "REPAYMENT" transaction with date "20231016" which has the following Journal entries:
      | Type      | Account code | Account name              | Debit | Credit |
      | ASSET     | 112601       | Loans Receivable          |       | 350.0  |
      | LIABILITY | 145023       | Suspense/Clearing account | 350.0 |        |
    Then Loan Transactions tab has a "CREDIT_BALANCE_REFUND" transaction with date "20231016" which has the following Journal entries:
      | Type      | Account code | Account name              | Debit | Credit |
      | ASSET     | 112601       | Loans Receivable          | 100.0 |        |
      | LIABILITY | 145023       | Suspense/Clearing account |       | 100.0  |

  @TestRailId:C2886
  Scenario: Verify that Loan status goes from overpaid to closed in case of CBR transaction when transaction amount equals overpaid amount - LP2_DOWNPAYMENT_AUTO_ADVANCED_PAYMENT_ALLOCATION loan product
    When Admin sets the business date to "20230901"
    When Admin creates a client with random data
    When Admin set "LP2_DOWNPAYMENT_AUTO_ADVANCED_PAYMENT_ALLOCATION" loan product "DEFAULT" transaction type to "NEXT_INSTALLMENT" future installment allocation rule
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                      | submitted on date | with Principal | ANNUAL interest rate % | interest type | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_DOWNPAYMENT_AUTO_ADVANCED_PAYMENT_ALLOCATION | 20230901 | 1000           | 0                      | FLAT          | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 45                | DAYS                  | 15             | DAYS                   | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20230901" with "1000" amount and expected disbursement date on "20230901"
    When Admin successfully disburse the loan on "20230901" with "1000" EUR transaction amount
    When Admin sets the business date to "20230916"
    And Customer makes "AUTOPAY" repayment on "20230916" with 250 EUR transaction amount
    When Admin sets the business date to "20231001"
    And Customer makes "AUTOPAY" repayment on "20231001" with 250 EUR transaction amount
    When Admin sets the business date to "20231016"
    And Customer makes "AUTOPAY" repayment on "20231016" with 350 EUR transaction amount
    Then Loan status will be "OVERPAID"
    Then Loan has 0 outstanding amount
    Then Loan has 100 overpaid amount
    When Admin makes Credit Balance Refund transaction on "20231016" with 100 EUR transaction amount
    Then Loan status will be "CLOSED_OBLIGATIONS_MET"
    Then Loan has 0 outstanding amount
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date         | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20230901 |                   | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 0    | 20230901 | 20230901 | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0  | 0.0         |
      | 2  | 15   | 20230916 | 20230916 | 500.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0  | 0.0         |
      | 3  | 15   | 20231001   | 20231001   | 250.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0  | 0.0         |
      | 4  | 15   | 20231016   | 20231016   | 0.0             | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0  | 0.0         |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late | Outstanding |
      | 1000.0        | 0        | 0    | 0         | 1000.0 | 1000.0 | 0          | 0    | 0           |
    Then Loan Transactions tab has the following data:
      | Transaction date  | Transaction Type      | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20230901 | Disbursement          | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
      | 20230901 | Down Payment          | 250.0  | 250.0     | 0.0      | 0.0  | 0.0       | 750.0        |
      | 20230916 | Repayment             | 250.0  | 250.0     | 0.0      | 0.0  | 0.0       | 500.0        |
      | 20231001   | Repayment             | 250.0  | 250.0     | 0.0      | 0.0  | 0.0       | 250.0        |
      | 20231016   | Repayment             | 350.0  | 250.0     | 0.0      | 0.0  | 0.0       | 0.0          |
      | 20231016   | Credit Balance Refund | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 0.0          |
    Then Loan Transactions tab has a "DISBURSEMENT" transaction with date "20230901" which has the following Journal entries:
      | Type      | Account code | Account name              | Debit  | Credit |
      | ASSET     | 112601       | Loans Receivable          | 1000.0 |        |
      | LIABILITY | 145023       | Suspense/Clearing account |        | 1000.0 |
    Then Loan Transactions tab has a "DOWN_PAYMENT" transaction with date "20230901" which has the following Journal entries:
      | Type      | Account code | Account name              | Debit | Credit |
      | ASSET     | 112601       | Loans Receivable          |       | 250.0  |
      | LIABILITY | 145023       | Suspense/Clearing account | 250.0 |        |
    Then Loan Transactions tab has a "REPAYMENT" transaction with date "20230916" which has the following Journal entries:
      | Type      | Account code | Account name              | Debit | Credit |
      | ASSET     | 112601       | Loans Receivable          |       | 250.0  |
      | LIABILITY | 145023       | Suspense/Clearing account | 250.0 |        |
    Then Loan Transactions tab has a "REPAYMENT" transaction with date "20231001" which has the following Journal entries:
      | Type      | Account code | Account name              | Debit | Credit |
      | ASSET     | 112601       | Loans Receivable          |       | 250.0  |
      | LIABILITY | 145023       | Suspense/Clearing account | 250.0 |        |
    Then Loan Transactions tab has a "REPAYMENT" transaction with date "20231016" which has the following Journal entries:
      | Type      | Account code | Account name              | Debit | Credit |
      | ASSET     | 112601       | Loans Receivable          |       | 250.0  |
      | LIABILITY | l1           | Overpayment account       |       | 100.0  |
      | LIABILITY | 145023       | Suspense/Clearing account | 350.0 |        |
    Then Loan Transactions tab has a "CREDIT_BALANCE_REFUND" transaction with date "20231016" which has the following Journal entries:
      | Type      | Account code | Account name              | Debit | Credit |
      | LIABILITY | l1           | Overpayment account       | 100.0 |        |
      | LIABILITY | 145023       | Suspense/Clearing account |       | 100.0  |

  @TestRailId:C2887
  Scenario: Verify that Loan status goes from overpaid to active in case of Refund transaction was reverted - LP2_DOWNPAYMENT_AUTO_ADVANCED_PAYMENT_ALLOCATION loan product
    When Admin sets the business date to "20230901"
    When Admin creates a client with random data
    When Admin set "LP2_DOWNPAYMENT_AUTO_ADVANCED_PAYMENT_ALLOCATION" loan product "DEFAULT" transaction type to "NEXT_INSTALLMENT" future installment allocation rule
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                      | submitted on date | with Principal | ANNUAL interest rate % | interest type | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_DOWNPAYMENT_AUTO_ADVANCED_PAYMENT_ALLOCATION | 20230901 | 1000           | 0                      | FLAT          | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 45                | DAYS                  | 15             | DAYS                   | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20230901" with "1000" amount and expected disbursement date on "20230901"
    When Admin successfully disburse the loan on "20230901" with "1000" EUR transaction amount
    When Admin sets the business date to "20230916"
    And Customer makes "AUTOPAY" repayment on "20230916" with 250 EUR transaction amount
    When Admin sets the business date to "20231001"
    And Customer makes "AUTOPAY" repayment on "20231001" with 250 EUR transaction amount
    When Admin sets the business date to "20231016"
    And Customer makes "AUTOPAY" repayment on "20231016" with 250 EUR transaction amount
    And Refund happens on "20231016" with 100 EUR transaction amount
    Then Loan status will be "OVERPAID"
    Then Loan has 0 outstanding amount
    Then Loan has 100 overpaid amount
    When Admin makes Credit Balance Refund transaction on "20231016" with 100 EUR transaction amount
    Then Loan status will be "CLOSED_OBLIGATIONS_MET"
    Then Loan has 0 outstanding amount
    When Refund undo happens on "20231016"
    Then Loan status will be "ACTIVE"
    Then Loan has 100 outstanding amount
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date         | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20230901 |                   | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 0    | 20230901 | 20230901 | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0  | 0.0         |
      | 2  | 15   | 20230916 | 20230916 | 500.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0  | 0.0         |
      | 3  | 15   | 20231001   | 20231001   | 250.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0  | 0.0         |
      | 4  | 15   | 20231016   |                   | 0.0             | 350.0         | 0.0      | 0.0  | 0.0       | 350.0 | 250.0 | 0.0        | 0.0  | 100.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late | Outstanding |
      | 1100.0        | 0        | 0    | 0         | 1100.0 | 1000.0 | 0          | 0    | 100         |
    Then On Loan Transactions tab the "Payout Refund" Transaction with date "20231016" is reverted
    Then Loan Transactions tab has the following data:
      | Transaction date  | Transaction Type      | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20230901 | Disbursement          | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
      | 20230901 | Down Payment          | 250.0  | 250.0     | 0.0      | 0.0  | 0.0       | 750.0        |
      | 20230916 | Repayment             | 250.0  | 250.0     | 0.0      | 0.0  | 0.0       | 500.0        |
      | 20231001   | Repayment             | 250.0  | 250.0     | 0.0      | 0.0  | 0.0       | 250.0        |
      | 20231016   | Repayment             | 250.0  | 250.0     | 0.0      | 0.0  | 0.0       | 0.0          |
      | 20231016   | Payout Refund         | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 0.0          |
      | 20231016   | Credit Balance Refund | 100.0  | 100.0     | 0.0      | 0.0  | 0.0       | 100.0        |
    Then Loan Transactions tab has a "DISBURSEMENT" transaction with date "20230901" which has the following Journal entries:
      | Type      | Account code | Account name              | Debit  | Credit |
      | ASSET     | 112601       | Loans Receivable          | 1000.0 |        |
      | LIABILITY | 145023       | Suspense/Clearing account |        | 1000.0 |
    Then Loan Transactions tab has a "DOWN_PAYMENT" transaction with date "20230901" which has the following Journal entries:
      | Type      | Account code | Account name              | Debit | Credit |
      | ASSET     | 112601       | Loans Receivable          |       | 250.0  |
      | LIABILITY | 145023       | Suspense/Clearing account | 250.0 |        |
    Then Loan Transactions tab has a "REPAYMENT" transaction with date "20230916" which has the following Journal entries:
      | Type      | Account code | Account name              | Debit | Credit |
      | ASSET     | 112601       | Loans Receivable          |       | 250.0  |
      | LIABILITY | 145023       | Suspense/Clearing account | 250.0 |        |
    Then Loan Transactions tab has a "REPAYMENT" transaction with date "20231001" which has the following Journal entries:
      | Type      | Account code | Account name              | Debit | Credit |
      | ASSET     | 112601       | Loans Receivable          |       | 250.0  |
      | LIABILITY | 145023       | Suspense/Clearing account | 250.0 |        |
    Then Loan Transactions tab has a "REPAYMENT" transaction with date "20231016" which has the following Journal entries:
      | Type      | Account code | Account name              | Debit | Credit |
      | ASSET     | 112601       | Loans Receivable          |       | 250.0  |
      | LIABILITY | 145023       | Suspense/Clearing account | 250.0 |        |
    Then Loan Transactions tab has a "PAYOUT_REFUND" transaction with date "20231016" which has the following Journal entries:
      | Type      | Account code | Account name              | Debit | Credit |
      | LIABILITY | l1           | Overpayment account       |       | 100.0  |
      | LIABILITY | 145023       | Suspense/Clearing account | 100.0 |        |
      | LIABILITY | l1           | Overpayment account       | 100.0 |        |
      | LIABILITY | 145023       | Suspense/Clearing account |       | 100.0  |
    Then Loan Transactions tab has a "CREDIT_BALANCE_REFUND" transaction with date "20231016" which has the following Journal entries:
      | Type      | Account code | Account name              | Debit | Credit |
      | ASSET     | 112601       | Loans Receivable          | 100.0 |        |
      | LIABILITY | 145023       | Suspense/Clearing account |       | 100.0  |

  @TestRailId:C2888
  Scenario: Multi repayment reversal (after maturity) - LP2_DOWNPAYMENT_AUTO_ADVANCED_PAYMENT_ALLOCATION loan product
    When Admin sets the business date to "20230901"
    When Admin creates a client with random data
    When Admin set "LP2_DOWNPAYMENT_AUTO_ADVANCED_PAYMENT_ALLOCATION" loan product "DEFAULT" transaction type to "NEXT_INSTALLMENT" future installment allocation rule
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                      | submitted on date | with Principal | ANNUAL interest rate % | interest type | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_DOWNPAYMENT_AUTO_ADVANCED_PAYMENT_ALLOCATION | 20230901 | 1000           | 0                      | FLAT          | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 45                | DAYS                  | 15             | DAYS                   | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20230901" with "1000" amount and expected disbursement date on "20230901"
    When Admin successfully disburse the loan on "20230901" with "1000" EUR transaction amount
    When Admin sets the business date to "20230916"
    And Customer makes "AUTOPAY" repayment on "20230916" with 250 EUR transaction amount
    When Admin sets the business date to "20231001"
    And Customer makes "AUTOPAY" repayment on "20231001" with 250 EUR transaction amount
    When Admin sets the business date to "20231020"
    And Customer makes "AUTOPAY" repayment on "20231020" with 350 EUR transaction amount
    Then Loan status will be "OVERPAID"
    Then Loan has 0 outstanding amount
    Then Loan has 100 overpaid amount
    When Admin sets the business date to "20231025"
    When Admin makes Credit Balance Refund transaction on "20231025" with 100 EUR transaction amount
    Then Loan status will be "CLOSED_OBLIGATIONS_MET"
    Then Loan has 0 outstanding amount
    When Customer undo "1"th repayment on "20231020"
    Then Loan status will be "ACTIVE"
    Then Loan has 250 outstanding amount
    Then Loan Repayment schedule has 5 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date         | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late  | Outstanding |
      |    |      | 20230901 |                   | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |       |             |
      | 1  | 0    | 20230901 | 20230901 | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0   | 0.0         |
      | 2  | 15   | 20230916 | 20231001   | 500.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 250.0 | 0.0         |
      | 3  | 15   | 20231001   | 20231020   | 250.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 250.0 | 0.0         |
      | 4  | 15   | 20231016   |                   | 0.0             | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 100.0 | 0.0        | 100.0 | 150.0       |
      | 5  | 9    | 20231025   |                   | 0.0             | 100.0         | 0.0      | 0.0  | 0.0       | 100.0 | 0.0   | 0.0        | 0.0   | 100.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 1100.0        | 0        | 0    | 0         | 1100.0 | 850.0 | 0          | 600  | 250         |
    Then On Loan Transactions tab the "Repayment" Transaction with date "20230916" is reverted
    Then Loan Transactions tab has the following data:
      | Transaction date  | Transaction Type      | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20230901 | Disbursement          | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
      | 20230901 | Down Payment          | 250.0  | 250.0     | 0.0      | 0.0  | 0.0       | 750.0        |
      | 20230916 | Repayment             | 250.0  | 250.0     | 0.0      | 0.0  | 0.0       | 500.0        |
      | 20231001   | Repayment             | 250.0  | 250.0     | 0.0      | 0.0  | 0.0       | 500.0        |
      | 20231020   | Repayment             | 350.0  | 350.0     | 0.0      | 0.0  | 0.0       | 150.0        |
      | 20231025   | Credit Balance Refund | 100.0  | 100.0     | 0.0      | 0.0  | 0.0       | 250.0        |
    Then Loan Transactions tab has a "DISBURSEMENT" transaction with date "20230901" which has the following Journal entries:
      | Type      | Account code | Account name              | Debit  | Credit |
      | ASSET     | 112601       | Loans Receivable          | 1000.0 |        |
      | LIABILITY | 145023       | Suspense/Clearing account |        | 1000.0 |
    Then Loan Transactions tab has a "DOWN_PAYMENT" transaction with date "20230901" which has the following Journal entries:
      | Type      | Account code | Account name              | Debit | Credit |
      | ASSET     | 112601       | Loans Receivable          |       | 250.0  |
      | LIABILITY | 145023       | Suspense/Clearing account | 250.0 |        |
    Then Loan Transactions tab has a "REPAYMENT" transaction with date "20230916" which has the following Journal entries:
      | Type      | Account code | Account name              | Debit | Credit |
      | ASSET     | 112601       | Loans Receivable          |       | 250.0  |
      | LIABILITY | 145023       | Suspense/Clearing account | 250.0 |        |
      | ASSET     | 112601       | Loans Receivable          | 250.0 |        |
      | LIABILITY | 145023       | Suspense/Clearing account |       | 250.0  |
    Then Loan Transactions tab has a "REPAYMENT" transaction with date "20231001" which has the following Journal entries:
      | Type      | Account code | Account name              | Debit | Credit |
      | ASSET     | 112601       | Loans Receivable          |       | 250.0  |
      | LIABILITY | 145023       | Suspense/Clearing account | 250.0 |        |
    Then Loan Transactions tab has a "REPAYMENT" transaction with date "20231020" which has the following Journal entries:
      | Type      | Account code | Account name              | Debit | Credit |
      | ASSET     | 112601       | Loans Receivable          |       | 350.0  |
      | LIABILITY | 145023       | Suspense/Clearing account | 350.0 |        |
    Then Loan Transactions tab has a "CREDIT_BALANCE_REFUND" transaction with date "20231025" which has the following Journal entries:
      | Type      | Account code | Account name              | Debit | Credit |
      | ASSET     | 112601       | Loans Receivable          | 100.0 |        |
      | LIABILITY | 145023       | Suspense/Clearing account |       | 100.0  |

  @TestRailId:C2889
  Scenario: Verify that Loan status goes from overpaid to active in case of CBR transaction (after maturity) - LP2_DOWNPAYMENT_AUTO_ADVANCED_PAYMENT_ALLOCATION loan product
    When Admin sets the business date to "20230901"
    When Admin creates a client with random data
    When Admin set "LP2_DOWNPAYMENT_AUTO_ADVANCED_PAYMENT_ALLOCATION" loan product "DEFAULT" transaction type to "NEXT_INSTALLMENT" future installment allocation rule
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                      | submitted on date | with Principal | ANNUAL interest rate % | interest type | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_DOWNPAYMENT_AUTO_ADVANCED_PAYMENT_ALLOCATION | 20230901 | 1000           | 0                      | FLAT          | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 45                | DAYS                  | 15             | DAYS                   | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20230901" with "1000" amount and expected disbursement date on "20230901"
    When Admin successfully disburse the loan on "20230901" with "1000" EUR transaction amount
    When Admin sets the business date to "20230916"
    And Customer makes "AUTOPAY" repayment on "20230916" with 250 EUR transaction amount
    When Admin sets the business date to "20231001"
    And Customer makes "AUTOPAY" repayment on "20231001" with 250 EUR transaction amount
    When Admin sets the business date to "20231020"
    And Customer makes "AUTOPAY" repayment on "20231020" with 200 EUR transaction amount
    When Admin sets the business date to "20231021"
    And Customer makes "AUTOPAY" repayment on "20231021" with 150 EUR transaction amount
    Then Loan status will be "OVERPAID"
    Then Loan has 0 outstanding amount
    Then Loan has 100 overpaid amount
    When Admin makes Credit Balance Refund transaction on "20231021" with 100 EUR transaction amount
    Then Loan status will be "CLOSED_OBLIGATIONS_MET"
    Then Loan has 0 outstanding amount
    When Customer undo "1"th repayment on "20230920"
    Then Loan status will be "ACTIVE"
    Then Loan has 250 outstanding amount
    Then Loan Repayment schedule has 5 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date         | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late  | Outstanding |
      |    |      | 20230901 |                   | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |       |             |
      | 1  | 0    | 20230901 | 20230901 | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0   | 0.0         |
      | 2  | 15   | 20230916 | 20231001   | 500.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 250.0 | 0.0         |
      | 3  | 15   | 20231001   | 20231021   | 250.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 250.0 | 0.0         |
      | 4  | 15   | 20231016   |                   | 0.0             | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 100.0 | 0.0        | 100.0 | 150.0       |
      | 5  | 5    | 20231021   |                   | 0.0             | 100.0         | 0.0      | 0.0  | 0.0       | 100.0 | 0.0   | 0.0        | 0.0   | 100.0       |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 1100.0        | 0        | 0    | 0         | 1100.0 | 850.0 | 0          | 600  | 250         |
    Then On Loan Transactions tab the "Repayment" Transaction with date "20230916" is reverted
    Then Loan Transactions tab has the following data:
      | Transaction date  | Transaction Type      | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20230901 | Disbursement          | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
      | 20230901 | Down Payment          | 250.0  | 250.0     | 0.0      | 0.0  | 0.0       | 750.0        |
      | 20230916 | Repayment             | 250.0  | 250.0     | 0.0      | 0.0  | 0.0       | 500.0        |
      | 20231001   | Repayment             | 250.0  | 250.0     | 0.0      | 0.0  | 0.0       | 500.0        |
      | 20231020   | Repayment             | 200.0  | 200.0     | 0.0      | 0.0  | 0.0       | 300.0        |
      | 20231021   | Repayment             | 150.0  | 150.0     | 0.0      | 0.0  | 0.0       | 150.0        |
      | 20231021   | Credit Balance Refund | 100.0  | 100.0     | 0.0      | 0.0  | 0.0       | 250.0        |
    Then Loan Transactions tab has a "DISBURSEMENT" transaction with date "20230901" which has the following Journal entries:
      | Type      | Account code | Account name              | Debit  | Credit |
      | ASSET     | 112601       | Loans Receivable          | 1000.0 |        |
      | LIABILITY | 145023       | Suspense/Clearing account |        | 1000.0 |
    Then Loan Transactions tab has a "DOWN_PAYMENT" transaction with date "20230901" which has the following Journal entries:
      | Type      | Account code | Account name              | Debit | Credit |
      | ASSET     | 112601       | Loans Receivable          |       | 250.0  |
      | LIABILITY | 145023       | Suspense/Clearing account | 250.0 |        |
    Then Loan Transactions tab has a "REPAYMENT" transaction with date "20230916" which has the following Journal entries:
      | Type      | Account code | Account name              | Debit | Credit |
      | ASSET     | 112601       | Loans Receivable          |       | 250.0  |
      | LIABILITY | 145023       | Suspense/Clearing account | 250.0 |        |
      | ASSET     | 112601       | Loans Receivable          | 250.0 |        |
      | LIABILITY | 145023       | Suspense/Clearing account |       | 250.0  |
    Then Loan Transactions tab has a "REPAYMENT" transaction with date "20231001" which has the following Journal entries:
      | Type      | Account code | Account name              | Debit | Credit |
      | ASSET     | 112601       | Loans Receivable          |       | 250.0  |
      | LIABILITY | 145023       | Suspense/Clearing account | 250.0 |        |
    Then Loan Transactions tab has a "REPAYMENT" transaction with date "20231020" which has the following Journal entries:
      | Type      | Account code | Account name              | Debit | Credit |
      | ASSET     | 112601       | Loans Receivable          |       | 200.0  |
      | LIABILITY | 145023       | Suspense/Clearing account | 200.0 |        |
    Then Loan Transactions tab has a "REPAYMENT" transaction with date "20231021" which has the following Journal entries:
      | Type      | Account code | Account name              | Debit | Credit |
      | ASSET     | 112601       | Loans Receivable          |       | 150.0  |
      | LIABILITY | 145023       | Suspense/Clearing account | 150.0 |        |
    Then Loan Transactions tab has a "CREDIT_BALANCE_REFUND" transaction with date "20231021" which has the following Journal entries:
      | Type      | Account code | Account name              | Debit | Credit |
      | ASSET     | 112601       | Loans Receivable          | 100.0 |        |
      | LIABILITY | 145023       | Suspense/Clearing account |       | 100.0  |

  @TestRailId:C2890
  Scenario: Verify that accruals created for charges after CBR post-maturity - LP2_DOWNPAYMENT_AUTO_ADVANCED_PAYMENT_ALLOCATION loan product
    When Admin sets the business date to "20230901"
    When Admin creates a client with random data
    When Admin set "LP2_DOWNPAYMENT_AUTO_ADVANCED_PAYMENT_ALLOCATION" loan product "DEFAULT" transaction type to "NEXT_INSTALLMENT" future installment allocation rule
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                      | submitted on date | with Principal | ANNUAL interest rate % | interest type | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_DOWNPAYMENT_AUTO_ADVANCED_PAYMENT_ALLOCATION | 20230901 | 1000           | 0                      | FLAT          | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 45                | DAYS                  | 15             | DAYS                   | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20230901" with "1000" amount and expected disbursement date on "20230901"
    When Admin successfully disburse the loan on "20230901" with "1000" EUR transaction amount
    When Admin sets the business date to "20230916"
    And Customer makes "AUTOPAY" repayment on "20230916" with 250 EUR transaction amount
    When Admin sets the business date to "20231001"
    And Customer makes "AUTOPAY" repayment on "20231001" with 250 EUR transaction amount
    When Admin sets the business date to "20231016"
    And Customer makes "AUTOPAY" repayment on "20231016" with 250 EUR transaction amount
    Then Loan status will be "CLOSED_OBLIGATIONS_MET"
    When Admin sets the business date to "20231017"
    When Customer makes "MERCHANT_ISSUED_REFUND" transaction with "AUTOPAY" payment type on "20231017" with 100 EUR transaction amount and system-generated Idempotency key
    When Admin runs inline COB job for Loan
    When Admin sets the business date to "20231018"
    And Admin makes Credit Balance Refund transaction on "20231018" with 100 EUR transaction amount
    Then Loan status will be "CLOSED_OBLIGATIONS_MET"
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date         | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20230901 |                   | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 0    | 20230901 | 20230901 | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0  | 0.0         |
      | 2  | 15   | 20230916 | 20230916 | 500.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0  | 0.0         |
      | 3  | 15   | 20231001   | 20231001   | 250.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0  | 0.0         |
      | 4  | 15   | 20231016   | 20231016   | 0.0             | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0  | 0.0         |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late | Outstanding |
      | 1000.0        | 0        | 0    | 0         | 1000.0 | 1000.0 | 0          | 0    | 0           |
    Then Loan Transactions tab has the following data:
      | Transaction date  | Transaction Type       | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20230901 | Disbursement           | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
      | 20230901 | Down Payment           | 250.0  | 250.0     | 0.0      | 0.0  | 0.0       | 750.0        |
      | 20230916 | Repayment              | 250.0  | 250.0     | 0.0      | 0.0  | 0.0       | 500.0        |
      | 20231001   | Repayment              | 250.0  | 250.0     | 0.0      | 0.0  | 0.0       | 250.0        |
      | 20231016   | Repayment              | 250.0  | 250.0     | 0.0      | 0.0  | 0.0       | 0.0          |
      | 20231017   | Merchant Issued Refund | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 0.0          |
      | 20231018   | Credit Balance Refund  | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 0.0          |
    When Admin runs inline COB job for Loan
    When Admin sets the business date to "20231019"
    When Admin adds "LOAN_SNOOZE_FEE" due date charge with "20231019" due date and 10 EUR transaction amount
    When Admin runs inline COB job for Loan
    When Admin sets the business date to "20231020"
    When Admin runs inline COB job for Loan
    Then Loan Repayment schedule has 5 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date         | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20230901 |                   | 1000.0          |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 0    | 20230901 | 20230901 | 750.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0  | 0.0         |
      | 2  | 15   | 20230916 | 20230916 | 500.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0  | 0.0         |
      | 3  | 15   | 20231001   | 20231001   | 250.0           | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0  | 0.0         |
      | 4  | 15   | 20231016   | 20231016   | 0.0             | 250.0         | 0.0      | 0.0  | 0.0       | 250.0 | 250.0 | 0.0        | 0.0  | 0.0         |
      | 5  | 3    | 20231019   |                   | 0.0             | 0.0           | 0.0      | 10.0 | 0.0       | 10.0  | 0.0   | 0.0        | 0.0  | 10.0        |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late | Outstanding |
      | 1000.0        | 0        | 10   | 0         | 1010.0 | 1000.0 | 0          | 0    | 10          |
    Then Loan Transactions tab has the following data:
      | Transaction date  | Transaction Type       | Amount | Principal | Interest | Fees | Penalties | Loan Balance |
      | 20230901 | Disbursement           | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       |
      | 20230901 | Down Payment           | 250.0  | 250.0     | 0.0      | 0.0  | 0.0       | 750.0        |
      | 20230916 | Repayment              | 250.0  | 250.0     | 0.0      | 0.0  | 0.0       | 500.0        |
      | 20231001   | Repayment              | 250.0  | 250.0     | 0.0      | 0.0  | 0.0       | 250.0        |
      | 20231016   | Repayment              | 250.0  | 250.0     | 0.0      | 0.0  | 0.0       | 0.0          |
      | 20231017   | Merchant Issued Refund | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 0.0          |
      | 20231018   | Credit Balance Refund  | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 0.0          |
      | 20231019   | Accrual                | 10.0   | 0.0       | 0.0      | 10.0 | 0.0       | 0.0          |

  @TestRailId:C2989
  Scenario: Verify that CBR transaction date cannot be in the future
    When Admin sets the business date to "20230901"
    When Admin creates a client with random data
    When Admin set "LP2_DOWNPAYMENT_AUTO_ADVANCED_PAYMENT_ALLOCATION" loan product "DEFAULT" transaction type to "NEXT_INSTALLMENT" future installment allocation rule
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                      | submitted on date | with Principal | ANNUAL interest rate % | interest type | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_DOWNPAYMENT_AUTO_ADVANCED_PAYMENT_ALLOCATION | 20230901 | 1000           | 0                      | FLAT          | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 45                | DAYS                  | 15             | DAYS                   | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20230901" with "1000" amount and expected disbursement date on "20230901"
    When Admin successfully disburse the loan on "20230901" with "1000" EUR transaction amount
    When Admin sets the business date to "20230910"
    And Customer makes "AUTOPAY" repayment on "20230910" with 1000 EUR transaction amount
    Then Loan status will be "OVERPAID"
    Then Loan has 0 outstanding amount
    Then Loan has 250 overpaid amount
    When Admin sets the business date to "20230915"
    Then Credit Balance Refund transaction on future date "20230920" with 250 EUR transaction amount will result an error

  @TestRailId:C3020
  Scenario: Verify that Charge-off and CBR transaction GL entries are correct in case of repayment reversal after CBR and Fraud flagged loan
    When Admin sets the business date to "20240101"
    When Admin creates a client with random data
    When Admin set "LP2_DOWNPAYMENT_AUTO_ADVANCED_PAYMENT_ALLOCATION" loan product "DEFAULT" transaction type to "NEXT_INSTALLMENT" future installment allocation rule
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                      | submitted on date | with Principal | ANNUAL interest rate % | interest type | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_DOWNPAYMENT_AUTO_ADVANCED_PAYMENT_ALLOCATION | 20240101   | 1000           | 0                      | FLAT          | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 45                | DAYS                  | 15             | DAYS                   | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240101" with "1000" amount and expected disbursement date on "20240101"
    When Admin successfully disburse the loan on "20240101" with "1000" EUR transaction amount
    Then Admin can successfully set Fraud flag to the loan
    And Admin does charge-off the loan on "20240101"
    Then Loan marked as charged-off on "20240101"
    When Admin sets the business date to "20240110"
    And Customer makes "AUTOPAY" repayment on "20240110" with 1000 EUR transaction amount
    Then Loan status will be "OVERPAID"
    Then Loan has 0 outstanding amount
    Then Loan has 250 overpaid amount
    When Admin sets the business date to "20240111"
    And Admin makes Credit Balance Refund transaction on "20240111" with 250 EUR transaction amount
    When Admin sets the business date to "20240112"
    When Customer undo "1"th "Repayment" transaction made on "20240110"
    Then Loan Transactions tab has a "DISBURSEMENT" transaction with date "20240101" which has the following Journal entries:
      | Type      | Account code | Account name              | Debit  | Credit |
      | ASSET     | 112601       | Loans Receivable          | 1000.0 |        |
      | LIABILITY | 145023       | Suspense/Clearing account |        | 1000.0 |
    Then Loan Transactions tab has a "DOWN_PAYMENT" transaction with date "20240101" which has the following Journal entries:
      | Type      | Account code | Account name              | Debit | Credit |
      | ASSET     | 112601       | Loans Receivable          |       | 250.0  |
      | LIABILITY | 145023       | Suspense/Clearing account | 250.0 |        |
    Then Loan Transactions tab has a "CHARGE_OFF" transaction with date "20240101" which has the following Journal entries:
      | Type    | Account code | Account name               | Debit | Credit |
      | ASSET   | 112601       | Loans Receivable           |       | 750.0  |
      | EXPENSE | 744037       | Credit Loss/Bad Debt-Fraud | 750.0 |        |
    Then Loan Transactions tab has a "REPAYMENT" transaction with date "20240110" which has the following Journal entries:
      | Type      | Account code | Account name              | Debit  | Credit |
      | INCOME    | 744008       | Recoveries                |        | 750.0  |
      | LIABILITY | l1           | Overpayment account       |        | 250.0  |
      | LIABILITY | 145023       | Suspense/Clearing account | 1000.0 |        |
      | INCOME    | 744008       | Recoveries                | 750.0  |        |
      | LIABILITY | l1           | Overpayment account       | 250.0  |        |
      | LIABILITY | 145023       | Suspense/Clearing account |        | 1000.0 |
    Then Loan Transactions tab has a "CREDIT_BALANCE_REFUND" transaction with date "20240111" which has the following Journal entries:
      | Type      | Account code | Account name               | Debit | Credit |
      | EXPENSE   | 744037       | Credit Loss/Bad Debt-Fraud | 250.0 |        |
      | LIABILITY | 145023       | Suspense/Clearing account  |       | 250.0  |

  @TestRailId:C3021
  Scenario: Verify that Charge-off and CBR transaction GL entries are correct in case of repayment reversal after CBR and Non-Fraud loan
    When Admin sets the business date to "20240101"
    When Admin creates a client with random data
    When Admin set "LP2_DOWNPAYMENT_AUTO_ADVANCED_PAYMENT_ALLOCATION" loan product "DEFAULT" transaction type to "NEXT_INSTALLMENT" future installment allocation rule
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                      | submitted on date | with Principal | ANNUAL interest rate % | interest type | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_DOWNPAYMENT_AUTO_ADVANCED_PAYMENT_ALLOCATION | 20240101   | 1000           | 0                      | FLAT          | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 45                | DAYS                  | 15             | DAYS                   | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240101" with "1000" amount and expected disbursement date on "20240101"
    When Admin successfully disburse the loan on "20240101" with "1000" EUR transaction amount
    And Admin does charge-off the loan on "20240101"
    Then Loan marked as charged-off on "20240101"
    When Admin sets the business date to "20240110"
    And Customer makes "AUTOPAY" repayment on "20240110" with 1000 EUR transaction amount
    Then Loan status will be "OVERPAID"
    Then Loan has 0 outstanding amount
    Then Loan has 250 overpaid amount
    When Admin sets the business date to "20240111"
    And Admin makes Credit Balance Refund transaction on "20240111" with 250 EUR transaction amount
    When Admin sets the business date to "20240112"
    When Customer undo "1"th "Repayment" transaction made on "20240110"
    Then Loan Transactions tab has a "DISBURSEMENT" transaction with date "20240101" which has the following Journal entries:
      | Type      | Account code | Account name              | Debit  | Credit |
      | ASSET     | 112601       | Loans Receivable          | 1000.0 |        |
      | LIABILITY | 145023       | Suspense/Clearing account |        | 1000.0 |
    Then Loan Transactions tab has a "DOWN_PAYMENT" transaction with date "20240101" which has the following Journal entries:
      | Type      | Account code | Account name              | Debit | Credit |
      | ASSET     | 112601       | Loans Receivable          |       | 250.0  |
      | LIABILITY | 145023       | Suspense/Clearing account | 250.0 |        |
    Then Loan Transactions tab has a "CHARGE_OFF" transaction with date "20240101" which has the following Journal entries:
      | Type    | Account code | Account name         | Debit | Credit |
      | ASSET   | 112601       | Loans Receivable     |       | 750.0  |
      | EXPENSE | 744007       | Credit Loss/Bad Debt | 750.0 |        |
    Then Loan Transactions tab has a "REPAYMENT" transaction with date "20240110" which has the following Journal entries:
      | Type      | Account code | Account name              | Debit  | Credit |
      | INCOME    | 744008       | Recoveries                |        | 750.0  |
      | LIABILITY | l1           | Overpayment account       |        | 250.0  |
      | LIABILITY | 145023       | Suspense/Clearing account | 1000.0 |        |
      | INCOME    | 744008       | Recoveries                | 750.0  |        |
      | LIABILITY | l1           | Overpayment account       | 250.0  |        |
      | LIABILITY | 145023       | Suspense/Clearing account |        | 1000.0 |
    Then Loan Transactions tab has a "CREDIT_BALANCE_REFUND" transaction with date "20240111" which has the following Journal entries:
      | Type      | Account code | Account name              | Debit | Credit |
      | EXPENSE   | 744007       | Credit Loss/Bad Debt      | 250.0 |        |
      | LIABILITY | 145023       | Suspense/Clearing account |       | 250.0  |

  @TestRailId:C3040
  Scenario: Verify that Charge-off and CBR transaction GL entries are correct before and after a repayment reversal taken place after CBR - UC1
    When Admin sets the business date to "20240101"
    When Admin creates a client with random data
    When Admin set "LP2_DOWNPAYMENT_AUTO_ADVANCED_PAYMENT_ALLOCATION" loan product "DEFAULT" transaction type to "NEXT_INSTALLMENT" future installment allocation rule
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                      | submitted on date | with Principal | ANNUAL interest rate % | interest type | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_DOWNPAYMENT_AUTO_ADVANCED_PAYMENT_ALLOCATION | 20240101   | 1000           | 0                      | FLAT          | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 45                | DAYS                  | 15             | DAYS                   | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240101" with "1000" amount and expected disbursement date on "20240101"
    When Admin successfully disburse the loan on "20240101" with "1000" EUR transaction amount
    When Admin sets the business date to "20240102"
    And Customer makes "AUTOPAY" repayment on "20240102" with 100 EUR transaction amount
    When Admin sets the business date to "20240103"
    And Admin does charge-off the loan on "20240103"
    When Admin sets the business date to "20240104"
    When Customer makes "PAYOUT_REFUND" transaction with "AUTOPAY" payment type on "20240104" with 1000 EUR transaction amount and system-generated Idempotency key
    When Admin sets the business date to "20240105"
    And Admin makes Credit Balance Refund transaction on "20240105" with 350 EUR transaction amount
#    --- Before reverse/replay ---
    Then Loan Transactions tab has a "DISBURSEMENT" transaction with date "20240101" which has the following Journal entries:
      | Type      | Account code | Account name              | Debit  | Credit |
      | ASSET     | 112601       | Loans Receivable          | 1000.0 |        |
      | LIABILITY | 145023       | Suspense/Clearing account |        | 1000.0 |
    Then Loan Transactions tab has a "DOWN_PAYMENT" transaction with date "20240101" which has the following Journal entries:
      | Type      | Account code | Account name              | Debit | Credit |
      | ASSET     | 112601       | Loans Receivable          |       | 250.0  |
      | LIABILITY | 145023       | Suspense/Clearing account | 250.0 |        |
    Then Loan Transactions tab has a "REPAYMENT" transaction with date "20240102" which has the following Journal entries:
      | Type      | Account code | Account name              | Debit | Credit |
      | ASSET     | 112601       | Loans Receivable          |       | 100.0  |
      | LIABILITY | 145023       | Suspense/Clearing account | 100.0 |        |
    Then Loan Transactions tab has a "CHARGE_OFF" transaction with date "20240103" which has the following Journal entries:
      | Type    | Account code | Account name         | Debit | Credit |
      | ASSET   | 112601       | Loans Receivable     |       | 650.0  |
      | EXPENSE | 744007       | Credit Loss/Bad Debt | 650.0 |        |
    Then Loan Transactions tab has a "PAYOUT_REFUND" transaction with date "20240104" which has the following Journal entries:
      | Type      | Account code | Account name              | Debit  | Credit |
      | EXPENSE   | 744007       | Credit Loss/Bad Debt      |        | 650.0  |
      | LIABILITY | l1           | Overpayment account       |        | 350.0  |
      | LIABILITY | 145023       | Suspense/Clearing account | 1000.0 |        |
    Then Loan Transactions tab has a "CREDIT_BALANCE_REFUND" transaction with date "20240105" which has the following Journal entries:
      | Type      | Account code | Account name              | Debit | Credit |
      | LIABILITY | l1           | Overpayment account       | 350.0 |        |
      | LIABILITY | 145023       | Suspense/Clearing account |       | 350.0  |
#    --- After reverse/replay ---
    When Admin sets the business date to "20240106"
    When Customer undo "1"th "Repayment" transaction made on "20240102"
    Then Loan Transactions tab has a "DISBURSEMENT" transaction with date "20240101" which has the following Journal entries:
      | Type      | Account code | Account name              | Debit  | Credit |
      | ASSET     | 112601       | Loans Receivable          | 1000.0 |        |
      | LIABILITY | 145023       | Suspense/Clearing account |        | 1000.0 |
    Then Loan Transactions tab has a "DOWN_PAYMENT" transaction with date "20240101" which has the following Journal entries:
      | Type      | Account code | Account name              | Debit | Credit |
      | ASSET     | 112601       | Loans Receivable          |       | 250.0  |
      | LIABILITY | 145023       | Suspense/Clearing account | 250.0 |        |
    Then Loan Transactions tab has a "REPAYMENT" transaction with date "20240102" which has the following Journal entries:
      | Type      | Account code | Account name              | Debit | Credit |
      | ASSET     | 112601       | Loans Receivable          |       | 100.0  |
      | LIABILITY | 145023       | Suspense/Clearing account | 100.0 |        |
      | ASSET     | 112601       | Loans Receivable          | 100.0 |        |
      | LIABILITY | 145023       | Suspense/Clearing account |       | 100.0  |
    Then Loan Transactions tab has a "CHARGE_OFF" transaction with date "20240103" which has the following Journal entries:
      | Type    | Account code | Account name         | Debit | Credit |
      | ASSET   | 112601       | Loans Receivable     |       | 750.0  |
      | EXPENSE | 744007       | Credit Loss/Bad Debt | 750.0 |        |
    Then Loan Transactions tab has a "PAYOUT_REFUND" transaction with date "20240104" which has the following Journal entries:
      | Type      | Account code | Account name              | Debit  | Credit |
      | EXPENSE   | 744007       | Credit Loss/Bad Debt      |        | 750.0  |
      | LIABILITY | l1           | Overpayment account       |        | 250.0  |
      | LIABILITY | 145023       | Suspense/Clearing account | 1000.0 |        |
    Then Loan Transactions tab has a "CREDIT_BALANCE_REFUND" transaction with date "20240105" which has the following Journal entries:
      | Type      | Account code | Account name              | Debit | Credit |
      | EXPENSE   | 744007       | Credit Loss/Bad Debt      | 100.0 |        |
      | LIABILITY | l1           | Overpayment account       | 250.0 |        |
      | LIABILITY | 145023       | Suspense/Clearing account |       | 350.0  |

  @TestRailId:C3041
  Scenario: Verify that Charge-off and CBR transaction GL entries are correct before and after a repayment reversal taken place after CBR - UC2
    When Admin sets the business date to "20240101"
    When Admin creates a client with random data
    When Admin set "LP2_DOWNPAYMENT_AUTO_ADVANCED_PAYMENT_ALLOCATION" loan product "DEFAULT" transaction type to "NEXT_INSTALLMENT" future installment allocation rule
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                      | submitted on date | with Principal | ANNUAL interest rate % | interest type | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_DOWNPAYMENT_AUTO_ADVANCED_PAYMENT_ALLOCATION | 20240101   | 1000           | 0                      | FLAT          | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 45                | DAYS                  | 15             | DAYS                   | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240101" with "1000" amount and expected disbursement date on "20240101"
    When Admin successfully disburse the loan on "20240101" with "1000" EUR transaction amount
    And Admin does charge-off the loan on "20240101"
    Then Loan marked as charged-off on "20240101"
    When Admin sets the business date to "20240110"
    And Customer makes "AUTOPAY" repayment on "20240110" with 1000 EUR transaction amount
    Then Loan status will be "OVERPAID"
    Then Loan has 0 outstanding amount
    Then Loan has 250 overpaid amount
    When Admin sets the business date to "20240111"
    And Admin makes Credit Balance Refund transaction on "20240111" with 250 EUR transaction amount
#    --- Before reverse/replay ---
    Then Loan Transactions tab has a "DISBURSEMENT" transaction with date "20240101" which has the following Journal entries:
      | Type      | Account code | Account name              | Debit  | Credit |
      | ASSET     | 112601       | Loans Receivable          | 1000.0 |        |
      | LIABILITY | 145023       | Suspense/Clearing account |        | 1000.0 |
    Then Loan Transactions tab has a "DOWN_PAYMENT" transaction with date "20240101" which has the following Journal entries:
      | Type      | Account code | Account name              | Debit | Credit |
      | ASSET     | 112601       | Loans Receivable          |       | 250.0  |
      | LIABILITY | 145023       | Suspense/Clearing account | 250.0 |        |
    Then Loan Transactions tab has a "CHARGE_OFF" transaction with date "20240101" which has the following Journal entries:
      | Type    | Account code | Account name         | Debit | Credit |
      | ASSET   | 112601       | Loans Receivable     |       | 750.0  |
      | EXPENSE | 744007       | Credit Loss/Bad Debt | 750.0 |        |
    Then Loan Transactions tab has a "REPAYMENT" transaction with date "20240110" which has the following Journal entries:
      | Type      | Account code | Account name              | Debit  | Credit |
      | INCOME    | 744008       | Recoveries                |        | 750.0  |
      | LIABILITY | l1           | Overpayment account       |        | 250.0  |
      | LIABILITY | 145023       | Suspense/Clearing account | 1000.0 |        |
    Then Loan Transactions tab has a "CREDIT_BALANCE_REFUND" transaction with date "20240111" which has the following Journal entries:
      | Type      | Account code | Account name              | Debit | Credit |
      | LIABILITY | l1           | Overpayment account       | 250.0 |        |
      | LIABILITY | 145023       | Suspense/Clearing account |       | 250.0  |
#    --- After reverse/replay ---
    When Admin sets the business date to "20240112"
    When Customer undo "1"th "Repayment" transaction made on "20240110"
    Then Loan Transactions tab has a "DISBURSEMENT" transaction with date "20240101" which has the following Journal entries:
      | Type      | Account code | Account name              | Debit  | Credit |
      | ASSET     | 112601       | Loans Receivable          | 1000.0 |        |
      | LIABILITY | 145023       | Suspense/Clearing account |        | 1000.0 |
    Then Loan Transactions tab has a "DOWN_PAYMENT" transaction with date "20240101" which has the following Journal entries:
      | Type      | Account code | Account name              | Debit | Credit |
      | ASSET     | 112601       | Loans Receivable          |       | 250.0  |
      | LIABILITY | 145023       | Suspense/Clearing account | 250.0 |        |
    Then Loan Transactions tab has a "CHARGE_OFF" transaction with date "20240101" which has the following Journal entries:
      | Type    | Account code | Account name         | Debit | Credit |
      | ASSET   | 112601       | Loans Receivable     |       | 750.0  |
      | EXPENSE | 744007       | Credit Loss/Bad Debt | 750.0 |        |
    Then Loan Transactions tab has a "REPAYMENT" transaction with date "20240110" which has the following Journal entries:
      | Type      | Account code | Account name              | Debit  | Credit |
      | INCOME    | 744008       | Recoveries                |        | 750.0  |
      | LIABILITY | l1           | Overpayment account       |        | 250.0  |
      | LIABILITY | 145023       | Suspense/Clearing account | 1000.0 |        |
      | INCOME    | 744008       | Recoveries                | 750.0  |        |
      | LIABILITY | l1           | Overpayment account       | 250.0  |        |
      | LIABILITY | 145023       | Suspense/Clearing account |        | 1000.0 |
    Then Loan Transactions tab has a "CREDIT_BALANCE_REFUND" transaction with date "20240111" which has the following Journal entries:
      | Type      | Account code | Account name              | Debit | Credit |
      | EXPENSE   | 744007       | Credit Loss/Bad Debt      | 250.0 |        |
      | LIABILITY | 145023       | Suspense/Clearing account |       | 250.0  |

  @TestRailId:C3092
  Scenario: Verify that overpayment portion calculated properly in case of CBR reverse-replay
    When Admin sets the business date to "20240125"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                 | submitted on date | with Principal | ANNUAL interest rate % | interest type | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_DOWNPAYMENT_ADVANCED_PAYMENT_ALLOCATION | 20240125   | 212.87         | 0                      | FLAT          | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 30                | DAYS                  | 30             | DAYS                   | 1                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240125" with "212.87" amount and expected disbursement date on "20240125"
    When Admin successfully disburse the loan on "20240125" with "212.87" EUR transaction amount
    When Admin sets the business date to "20240224"
    And Customer makes "AUTOPAY" repayment on "20240224" with 212.87 EUR transaction amount
    When Admin sets the business date to "20240229"
    When Customer makes "MERCHANT_ISSUED_REFUND" transaction with "AUTOPAY" payment type on "20240229" with 36.99 EUR transaction amount and system-generated Idempotency key
    When Customer makes "MERCHANT_ISSUED_REFUND" transaction with "AUTOPAY" payment type on "20240229" with 18.94 EUR transaction amount and system-generated Idempotency key
    When Customer makes "MERCHANT_ISSUED_REFUND" transaction with "AUTOPAY" payment type on "20240229" with 36.99 EUR transaction amount and system-generated Idempotency key
    When Customer makes "MERCHANT_ISSUED_REFUND" transaction with "AUTOPAY" payment type on "20240229" with 31.91 EUR transaction amount and system-generated Idempotency key
    When Admin sets the business date to "20240301"
    And Admin makes Credit Balance Refund transaction on "20240301" with 124.83 EUR transaction amount
    When Admin sets the business date to "20240302"
    When Customer makes "MERCHANT_ISSUED_REFUND" transaction with "AUTOPAY" payment type on "20240302" with 19.99 EUR transaction amount and system-generated Idempotency key
    When Customer makes "MERCHANT_ISSUED_REFUND" transaction with "AUTOPAY" payment type on "20240302" with 19.99 EUR transaction amount and system-generated Idempotency key
    When Customer undo "1"th "Merchant Issued Refund" transaction made on "20240229"
    Then Loan status will be "OVERPAID"
    Then Loan has 2.99 overpaid amount
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late  | Outstanding |
      |    |      | 20240125  |                  | 212.87          |               |          | 0.0  |           | 0.0    | 0.0    |            |       |             |
      | 1  | 0    | 20240125  | 20240224 | 159.87          | 53.0          | 0.0      | 0.0  | 0.0       | 53.0   | 53.0   | 0.0        | 53.0  | 0.0         |
      | 2  | 30   | 20240224 | 20240224 | 0.0             | 159.87        | 0.0      | 0.0  | 0.0       | 159.87 | 159.87 | 0.0        | 0.0   | 0.0         |
      | 3  | 6    | 20240301    | 20240302    | 0.0             | 124.83        | 0.0      | 0.0  | 0.0       | 124.83 | 124.83 | 0.0        | 36.99 | 0.0         |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late  | Outstanding |
      | 337.7         | 0.0      | 0.0  | 0.0       | 337.7 | 337.7 | 0.0        | 89.99 | 0.0         |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type       | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20240125  | Disbursement           | 212.87 | 0.0       | 0.0      | 0.0  | 0.0       | 212.87       | false    |
      | 20240224 | Repayment              | 212.87 | 212.87    | 0.0      | 0.0  | 0.0       | 0.0          | false    |
      | 20240229 | Merchant Issued Refund | 36.99  | 0.0       | 0.0      | 0.0  | 0.0       | 0.0          | true     |
      | 20240229 | Merchant Issued Refund | 18.94  | 0.0       | 0.0      | 0.0  | 0.0       | 0.0          | false    |
      | 20240229 | Merchant Issued Refund | 36.99  | 0.0       | 0.0      | 0.0  | 0.0       | 0.0          | false    |
      | 20240229 | Merchant Issued Refund | 31.91  | 0.0       | 0.0      | 0.0  | 0.0       | 0.0          | false    |
      | 20240301    | Credit Balance Refund  | 124.83 | 36.99     | 0.0      | 0.0  | 0.0       | 36.99        | false    |
      | 20240302    | Merchant Issued Refund | 19.99  | 19.99     | 0.0      | 0.0  | 0.0       | 17.0         | false    |
      | 20240302    | Merchant Issued Refund | 19.99  | 17.0      | 0.0      | 0.0  | 0.0       | 0.0          | false    |

  @TestRailId:C3140
  Scenario: Verify that the journal entries are correct in case of merchant issued refund (chargeoff, backdated transaction, undo repayment, downpayment)
    When Admin sets the business date to "20240524"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                      | submitted on date | with Principal | ANNUAL interest rate % | interest type | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_DOWNPAYMENT_AUTO_ADVANCED_PAYMENT_ALLOCATION | 20240524       | 200            | 0                      | FLAT          | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 30                | DAYS                  | 30             | DAYS                   | 1                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240524" with "200" amount and expected disbursement date on "20240524"
    When Admin successfully disburse the loan on "20240524" with "200" EUR transaction amount
    When Admin runs inline COB job for Loan
    When Admin sets the business date to "20240525"
    When Customer undo "1"th "Down Payment" transaction made on "20240524"
    Then Loan Repayment schedule has 2 periods, with the following data for periods:
      | Nr | Days | Date         | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20240524  |           | 200.0           |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 0    | 20240524  |           | 150.0           | 50.0          | 0.0      | 0.0  | 0.0       | 50.0  | 0.0  | 0.0        | 0.0  | 50.0        |
      | 2  | 30   | 20240623 |           | 0.0             | 150.0         | 0.0      | 0.0  | 0.0       | 150.0 | 0.0  | 0.0        | 0.0  | 150.0       |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240524      | Disbursement     | 200.0  | 0.0       | 0.0      | 0.0  | 0.0       | 200.0        | false    | false    |
      | 20240524      | Down Payment     | 50.0   | 50.0      | 0.0      | 0.0  | 0.0       | 150.0        | true     | false    |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      | 200.0         | 0.0      | 0.0  | 0.0       | 200.0 | 0.0  | 0.0        | 0.0  | 200.0       |
    When Admin runs inline COB job for Loan
    When Admin sets the business date to "20240526"
    And Admin does charge-off the loan on "20240526"
    And Customer makes "AUTOPAY" repayment on "20240525" with 10 EUR transaction amount
    When Customer makes "MERCHANT_ISSUED_REFUND" transaction with "AUTOPAY" payment type on "20240526" with 200 EUR transaction amount and system-generated Idempotency key
    Then Loan Repayment schedule has 2 periods, with the following data for periods:
      | Nr | Days | Date         | Paid date   | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240524  |             | 200.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 0    | 20240524  | 20240526 | 150.0           | 50.0          | 0.0      | 0.0  | 0.0       | 50.0  | 50.0  | 0.0        | 50.0 | 0.0         |
      | 2  | 30   | 20240623 | 20240526 | 0.0             | 150.0         | 0.0      | 0.0  | 0.0       | 150.0 | 150.0 | 150.0      | 0.0  | 0.0         |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      | 200.0         | 0.0      | 0.0  | 0.0       | 200.0 | 200.0 | 150.0      | 50.0 | 0.0         |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type       | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240524      | Disbursement           | 200.0  | 0.0       | 0.0      | 0.0  | 0.0       | 200.0        | false    | false    |
      | 20240524      | Down Payment           | 50.0   | 50.0      | 0.0      | 0.0  | 0.0       | 150.0        | true     | false    |
      | 20240525      | Repayment              | 10.0   | 10.0      | 0.0      | 0.0  | 0.0       | 190.0        | false    | false    |
      | 20240526      | Charge-off             | 190.0  | 190.0     | 0.0      | 0.0  | 0.0       | 0.0          | false    | true     |
      | 20240526      | Merchant Issued Refund | 200.0  | 190.0     | 0.0      | 0.0  | 0.0       | 0.0          | false    | false    |
    When Admin runs inline COB job for Loan
    Then Loan status will be "OVERPAID"
    Then Loan has 0 outstanding amount
    Then Loan has 10 overpaid amount
    When Admin sets the business date to "20240527"
    When Admin makes Credit Balance Refund transaction on "20240527" with 10 EUR transaction amount
    Then Loan Repayment schedule has 2 periods, with the following data for periods:
      | Nr | Days | Date         | Paid date   | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240524  |             | 200.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 0    | 20240524  | 20240526 | 150.0           | 50.0          | 0.0      | 0.0  | 0.0       | 50.0  | 50.0  | 0.0        | 50.0 | 0.0         |
      | 2  | 30   | 20240623 | 20240526 | 0.0             | 150.0         | 0.0      | 0.0  | 0.0       | 150.0 | 150.0 | 150.0      | 0.0  | 0.0         |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      | 200.0         | 0.0      | 0.0  | 0.0       | 200.0 | 200.0 | 150.0      | 50.0 | 0.0         |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type       | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240524      | Disbursement           | 200.0  | 0.0       | 0.0      | 0.0  | 0.0       | 200.0        | false    | false    |
      | 20240524      | Down Payment           | 50.0   | 50.0      | 0.0      | 0.0  | 0.0       | 150.0        | true     | false    |
      | 20240525      | Repayment              | 10.0   | 10.0      | 0.0      | 0.0  | 0.0       | 190.0        | false    | false    |
      | 20240526      | Charge-off             | 190.0  | 190.0     | 0.0      | 0.0  | 0.0       | 0.0          | false    | true     |
      | 20240526      | Merchant Issued Refund | 200.0  | 190.0     | 0.0      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20240527      | Credit Balance Refund  | 10.0   | 0.0       | 0.0      | 0.0  | 0.0       | 0.0          | false    | false    |
    When Customer undo "1"th "Repayment" transaction made on "20240525"
    Then Loan Repayment schedule has 2 periods, with the following data for periods:
      | Nr | Days | Date         | Paid date   | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20240524  |             | 200.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 0    | 20240524  | 20240526 | 150.0           | 50.0          | 0.0      | 0.0  | 0.0       | 50.0  | 50.0  | 0.0        | 50.0 | 0.0         |
      | 2  | 30   | 20240623 |             | 0.0             | 160.0         | 0.0      | 0.0  | 0.0       | 160.0 | 150.0 | 150.0      | 0.0  | 10.0        |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      | 210.0         | 0.0      | 0.0  | 0.0       | 210.0 | 200.0 | 150.0      | 50.0 | 10.0        |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type       | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240524      | Disbursement           | 200.0  | 0.0       | 0.0      | 0.0  | 0.0       | 200.0        | false    | false    |
      | 20240524      | Down Payment           | 50.0   | 50.0      | 0.0      | 0.0  | 0.0       | 150.0        | true     | false    |
      | 20240525      | Repayment              | 10.0   | 10.0      | 0.0      | 0.0  | 0.0       | 190.0        | true     | false    |
      | 20240526      | Charge-off             | 200.0  | 200.0     | 0.0      | 0.0  | 0.0       | 0.0          | false    | true     |
      | 20240526      | Merchant Issued Refund | 200.0  | 200.0     | 0.0      | 0.0  | 0.0       | 0.0          | false    | true     |
      | 20240527      | Credit Balance Refund  | 10.0   | 10.0      | 0.0      | 0.0  | 0.0       | 10.0         | false    | true     |
    Then Loan Transactions tab has a "DISBURSEMENT" transaction with date "20240524" which has the following Journal entries:
      | Type      | Account code | Account name              | Debit | Credit |
      | ASSET     | 112601       | Loans Receivable          | 200.0 |        |
      | LIABILITY | 145023       | Suspense/Clearing account |       | 200.0  |
    Then Loan Transactions tab has a "DOWN_PAYMENT" transaction with date "20240524" which has the following Journal entries:
      | Type      | Account code | Account name              | Debit | Credit |
      | ASSET     | 112601       | Loans Receivable          |       | 50.0   |
      | LIABILITY | 145023       | Suspense/Clearing account | 50.0  |        |
      | ASSET     | 112601       | Loans Receivable          | 50.0  |        |
      | LIABILITY | 145023       | Suspense/Clearing account |       | 50.0   |
    Then Loan Transactions tab has a "REPAYMENT" transaction with date "20240525" which has the following Journal entries:
      | Type      | Account code | Account name              | Debit | Credit |
      | ASSET     | 112601       | Loans Receivable          |       | 10.0   |
      | LIABILITY | 145023       | Suspense/Clearing account | 10.0  |        |
      | ASSET     | 112601       | Loans Receivable          | 10.0  |        |
      | LIABILITY | 145023       | Suspense/Clearing account |       | 10.0   |
    Then Loan Transactions tab has a "CHARGE_OFF" transaction with date "20240526" which has the following Journal entries:
      | Type    | Account code | Account name         | Debit | Credit |
      | ASSET   | 112601       | Loans Receivable     |       | 200.0  |
      | EXPENSE | 744007       | Credit Loss/Bad Debt | 200.0 |        |
    Then Loan Transactions tab has a "MERCHANT_ISSUED_REFUND" transaction with date "20240526" which has the following Journal entries:
      | Type      | Account code | Account name              | Debit | Credit |
      | EXPENSE   | 744007       | Credit Loss/Bad Debt      |       | 200.0  |
      | LIABILITY | 145023       | Suspense/Clearing account | 200.0 |        |
    Then Loan Transactions tab has a "CREDIT_BALANCE_REFUND" transaction with date "20240527" which has the following Journal entries:
      | Type      | Account code | Account name              | Debit | Credit |
      | EXPENSE   | 744007       | Credit Loss/Bad Debt      | 10.0  |        |
      | LIABILITY | 145023       | Suspense/Clearing account |       | 10.0   |

  @TestRailId:C3203
  Scenario: Verify that loan status is correct when CBR is reversed on an overpaid loan
    When Admin sets the business date to "20240701"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                      | submitted on date | with Principal | ANNUAL interest rate % | interest type | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_DOWNPAYMENT_AUTO_ADVANCED_PAYMENT_ALLOCATION | 20240701      | 1000           | 0                      | FLAT          | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 30                | DAYS                  | 30             | DAYS                   | 1                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240701" with "1000" amount and expected disbursement date on "20240701"
    When Admin successfully disburse the loan on "20240701" with "1000" EUR transaction amount
    When Admin sets the business date to "20240710"
    And Customer makes "AUTOPAY" repayment on "20240710" with 1000 EUR transaction amount
    Then Loan status will be "OVERPAID"
    Then Loan has 0 outstanding amount
    Then Loan has 250 overpaid amount
    When Admin sets the business date to "20240711"
    When Admin makes Credit Balance Refund transaction on "20240711" with 250 EUR transaction amount
    Then Loan status will be "CLOSED_OBLIGATIONS_MET"
    Then Loan has 0 outstanding amount
    When Admin sets the business date to "20240712"
    When Customer undo "1"th transaction made on "20240711"
    Then Loan status will be "OVERPAID"
    Then Loan has 0 outstanding amount
    Then Loan has 250 overpaid amount

  @TestRailId:C3734
  Scenario: Verify that 2nd disbursement is allowed after MIR, Payout Refund and Credit Balance Refund closes the loan
    When Admin sets the business date to "20240314"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct                                             | submitted on date | with Principal | ANNUAL interest rate % | interest type | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_DOWNPAYMENT_AUTO_ADVANCED_CUSTOM_PAYMENT_ALLOCATION | 20240314     | 487.58         | 0                      | FLAT          | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 45                | DAYS                  | 15             | DAYS                   | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20240314" with "487.58" amount and expected disbursement date on "20240314"
  # First disbursement with automatic downpayment
    When Admin successfully disburse the loan on "20240314" with "487.58" EUR transaction amount
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date          | Paid date     | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      |    |      | 20240314 |               | 487.58          |               |          | 0.0  |           | 0.0    | 0.0   |            |      |             |
      | 1  | 0    | 20240314 | 20240314 | 365.58          | 122.0         | 0.0      | 0.0  | 0.0       | 122.0  | 122.0 | 0.0        | 0.0  | 0.0         |
      | 2  | 15   | 20240329 |               | 243.58          | 122.0         | 0.0      | 0.0  | 0.0       | 122.0  | 0.0   | 0.0        | 0.0  | 122.0       |
      | 3  | 15   | 20240413 |               | 121.58          | 122.0         | 0.0      | 0.0  | 0.0       | 122.0  | 0.0   | 0.0        | 0.0  | 122.0       |
      | 4  | 15   | 20240428 |               | 0.0             | 121.58        | 0.0      | 0.0  | 0.0       | 121.58 | 0.0   | 0.0        | 0.0  | 121.58      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      | 487.58        | 0.0      | 0.0  | 0.0       | 487.58 | 122.0 | 0.0        | 0.0  | 365.58      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240314    | Disbursement     | 487.58 | 0.0       | 0.0      | 0.0  | 0.0       | 487.58       | false    | false    |
      | 20240314    | Down Payment     | 122.0  | 122.0     | 0.0      | 0.0  | 0.0       | 365.58       | false    | false    |
    When Admin runs inline COB job for Loan
  # Merchant Issued Refund
    When Admin sets the business date to "20240324"
    When Customer makes "MERCHANT_ISSUED_REFUND" transaction with "AUTOPAY" payment type on "20240324" with 201.39 EUR transaction amount and system-generated Idempotency key
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date          | Paid date     | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late | Outstanding |
      |    |      | 20240314 |               | 487.58          |               |          | 0.0  |           | 0.0    | 0.0    |            |      |             |
      | 1  | 0    | 20240314 | 20240314 | 365.58          | 122.0         | 0.0      | 0.0  | 0.0       | 122.0  | 122.0  | 0.0        | 0.0  | 0.0         |
      | 2  | 15   | 20240329 |               | 243.58          | 122.0         | 0.0      | 0.0  | 0.0       | 122.0  | 0.0    | 0.0        | 0.0  | 122.0       |
      | 3  | 15   | 20240413 |               | 121.58          | 122.0         | 0.0      | 0.0  | 0.0       | 122.0  | 79.81  | 79.81      | 0.0  | 42.19       |
      | 4  | 15   | 20240428 | 20240324 | 0.0             | 121.58        | 0.0      | 0.0  | 0.0       | 121.58 | 121.58 | 121.58     | 0.0  | 0.0         |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late | Outstanding |
      | 487.58        | 0.0      | 0.0  | 0.0       | 487.58 | 323.39 | 201.39     | 0.0  | 164.19      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type       | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240314    | Disbursement           | 487.58 | 0.0       | 0.0      | 0.0  | 0.0       | 487.58       | false    | false    |
      | 20240314    | Down Payment           | 122.0  | 122.0     | 0.0      | 0.0  | 0.0       | 365.58       | false    | false    |
      | 20240324    | Merchant Issued Refund | 201.39 | 201.39    | 0.0      | 0.0  | 0.0       | 164.19       | false    | false    |
    When Admin runs inline COB job for Loan
  # Move forward to next year for Payout Refund
    When Admin sets the business date to "20250324"
    When Customer makes "PAYOUT_REFUND" transaction with "AUTOPAY" payment type on "20250324" with 286.19 EUR transaction amount and system-generated Idempotency key
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date          | Paid date     | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late  | Outstanding |
      |    |      | 20240314 |               | 487.58          |               |          | 0.0  |           | 0.0    | 0.0    |            |       |             |
      | 1  | 0    | 20240314 | 20240314 | 365.58          | 122.0         | 0.0      | 0.0  | 0.0       | 122.0  | 122.0  | 0.0        | 0.0   | 0.0         |
      | 2  | 15   | 20240329 | 20250324 | 243.58          | 122.0         | 0.0      | 0.0  | 0.0       | 122.0  | 122.0  | 0.0        | 122.0 | 0.0         |
      | 3  | 15   | 20240413 | 20250324 | 121.58          | 122.0         | 0.0      | 0.0  | 0.0       | 122.0  | 122.0  | 79.81      | 42.19 | 0.0         |
      | 4  | 15   | 20240428 | 20240324 | 0.0             | 121.58        | 0.0      | 0.0  | 0.0       | 121.58 | 121.58 | 121.58     | 0.0   | 0.0         |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late   | Outstanding |
      | 487.58        | 0.0      | 0.0  | 0.0       | 487.58 | 487.58 | 201.39     | 164.19 | 0.0         |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type       | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240314    | Disbursement           | 487.58 | 0.0       | 0.0      | 0.0  | 0.0       | 487.58       | false    | false    |
      | 20240314    | Down Payment           | 122.0  | 122.0     | 0.0      | 0.0  | 0.0       | 365.58       | false    | false    |
      | 20240324    | Merchant Issued Refund | 201.39 | 201.39    | 0.0      | 0.0  | 0.0       | 164.19       | false    | false    |
      | 20250324    | Payout Refund          | 286.19 | 164.19    | 0.0      | 0.0  | 0.0       | 0.0          | false    | false    |
    Then Loan status will be "OVERPAID"
    Then Loan has 0 outstanding amount
    Then Loan has 122.0 overpaid amount
    When Admin runs inline COB job for Loan
  # Credit Balance Refund to close the loan
    When Admin sets the business date to "20250325"
    When Admin makes Credit Balance Refund transaction on "20250325" with 122.0 EUR transaction amount
    Then Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date          | Paid date     | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late  | Outstanding |
      |    |      | 20240314 |               | 487.58          |               |          | 0.0  |           | 0.0    | 0.0    |            |       |             |
      | 1  | 0    | 20240314 | 20240314 | 365.58          | 122.0         | 0.0      | 0.0  | 0.0       | 122.0  | 122.0  | 0.0        | 0.0   | 0.0         |
      | 2  | 15   | 20240329 | 20250324 | 243.58          | 122.0         | 0.0      | 0.0  | 0.0       | 122.0  | 122.0  | 0.0        | 122.0 | 0.0         |
      | 3  | 15   | 20240413 | 20250324 | 121.58          | 122.0         | 0.0      | 0.0  | 0.0       | 122.0  | 122.0  | 79.81      | 42.19 | 0.0         |
      | 4  | 15   | 20240428 | 20240324 | 0.0             | 121.58        | 0.0      | 0.0  | 0.0       | 121.58 | 121.58 | 121.58     | 0.0   | 0.0         |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late   | Outstanding |
      | 487.58        | 0.0      | 0.0  | 0.0       | 487.58 | 487.58 | 201.39     | 164.19 | 0.0         |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type       | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240314    | Disbursement           | 487.58 | 0.0       | 0.0      | 0.0  | 0.0       | 487.58       | false    | false    |
      | 20240314    | Down Payment           | 122.0  | 122.0     | 0.0      | 0.0  | 0.0       | 365.58       | false    | false    |
      | 20240324    | Merchant Issued Refund | 201.39 | 201.39    | 0.0      | 0.0  | 0.0       | 164.19       | false    | false    |
      | 20250324    | Payout Refund          | 286.19 | 164.19    | 0.0      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250325    | Credit Balance Refund  | 122.0  | 0.0       | 0.0      | 0.0  | 0.0       | 0.0          | false    | false    |
    Then Loan status will be "CLOSED_OBLIGATIONS_MET"
    Then Loan has 0 outstanding amount
    When Admin runs inline COB job for Loan
  # Second disbursement
    When Admin sets the business date to "20250401"
    When Admin successfully disburse the loan on "20250401" with "243.79" EUR transaction amount
    Then Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date          | Paid date     | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late  | Outstanding |
      |    |      | 20240314 |               | 487.58          |               |          | 0.0  |           | 0.0    | 0.0    |            |       |             |
      | 1  | 0    | 20240314 | 20240314 | 365.58          | 122.0         | 0.0      | 0.0  | 0.0       | 122.0  | 122.0  | 0.0        | 0.0   | 0.0         |
      | 2  | 15   | 20240329 | 20250324 | 243.58          | 122.0         | 0.0      | 0.0  | 0.0       | 122.0  | 122.0  | 0.0        | 122.0 | 0.0         |
      | 3  | 15   | 20240413 | 20250324 | 121.58          | 122.0         | 0.0      | 0.0  | 0.0       | 122.0  | 122.0  | 79.81      | 42.19 | 0.0         |
      | 4  | 15   | 20240428 | 20240324 | 0.0             | 121.58        | 0.0      | 0.0  | 0.0       | 121.58 | 121.58 | 121.58     | 0.0   | 0.0         |
      |    |      | 20250401 |               | 243.79          |               |          | 0.0  |           | 0.0    | 0.0    |            |       |             |
      | 5  | 0    | 20250401 | 20250401 | 182.79          | 61.0          | 0.0      | 0.0  | 0.0       | 61.0   | 61.0   | 0.0        | 0.0   | 0.0         |
      | 6  | 0    | 20250401 |               | 0.0             | 182.79        | 0.0      | 0.0  | 0.0       | 182.79 | 0.0    | 0.0        | 0.0   | 182.79      |
    Then Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late   | Outstanding |
      | 731.37        | 0.0      | 0.0  | 0.0       | 731.37 | 548.58 | 201.39     | 164.19 | 182.79      |
    Then Loan Transactions tab has the following data:
      | Transaction date | Transaction Type       | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20240314    | Disbursement           | 487.58 | 0.0       | 0.0      | 0.0  | 0.0       | 487.58       | false    | false    |
      | 20240314    | Down Payment           | 122.0  | 122.0     | 0.0      | 0.0  | 0.0       | 365.58       | false    | false    |
      | 20240324    | Merchant Issued Refund | 201.39 | 201.39    | 0.0      | 0.0  | 0.0       | 164.19       | false    | false    |
      | 20250324    | Payout Refund          | 286.19 | 164.19    | 0.0      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250325    | Credit Balance Refund  | 122.0  | 0.0       | 0.0      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250401    | Disbursement           | 243.79 | 0.0       | 0.0      | 0.0  | 0.0       | 243.79       | false    | false    |
      | 20250401    | Down Payment           | 61.0   | 61.0      | 0.0      | 0.0  | 0.0       | 182.79       | false    | false    |
    Then Loan status will be "ACTIVE"

  Scenario Outline: Verify that Loan ends in correct state after CBR + backdated GoodwillCredit cocktail (<rule> future-installment rule)
    When Admin sets the business date to "20250902"
    And Admin creates a client with random data

    # Migration loan: submitted & disbursed back-dated to 20250406, 6 monthly installments
    And Admin creates a fully customized loan with the following data:
      | LoanProduct   | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | <loanProduct> | 20250406     | 1316.49        | 12.2062                | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 6                 | MONTHS                | 1              | MONTHS                 | 6                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20250406" with "1316.49" amount and expected disbursement date on "20250406"
    And Admin successfully disburse the loan on "20250406" with "1316.49" EUR transaction amount

    # 4 backdated AUTOPAY repayments of 227.31 EUR (still on system date 20250902)
    And Customer makes "REPAYMENT" transaction with "AUTOPAY" payment type on "20250506" with 227.31 EUR transaction amount and system-generated Idempotency key
    And Customer makes "REPAYMENT" transaction with "AUTOPAY" payment type on "20250606" with 227.31 EUR transaction amount and system-generated Idempotency key
    And Customer makes "REPAYMENT" transaction with "AUTOPAY" payment type on "20250706" with 227.31 EUR transaction amount and system-generated Idempotency key
    And Customer makes "REPAYMENT" transaction with "AUTOPAY" payment type on "20250806" with 227.31 EUR transaction amount and system-generated Idempotency key

    # 5th installment via AUTOPAY on 20250906
    When Admin sets the business date to "20250906"
    And Admin runs inline COB job for Loan
    And Customer makes "REPAYMENT" transaction with "AUTOPAY" payment type on "20250906" with 227.31 EUR transaction amount and system-generated Idempotency key

    # 6th installment via REAL_TIME on 20251002
    When Admin sets the business date to "20251002"
    And Admin runs inline COB job for Loan
    And Customer makes "REPAYMENT" transaction with "REAL_TIME" payment type on "20251002" with 227.00 EUR transaction amount and system-generated Idempotency key

    # 3 MIRs (interestRefundCalculation=false) on 20251029 -> loan flips to OVERPAID
    When Admin sets the business date to "20251029"
    And Admin runs inline COB job for Loan
    And Customer makes "MERCHANT_ISSUED_REFUND" transaction with "AUTOPAY" payment type on "20251029" with 242.00 EUR transaction amount and system-generated Idempotency key and interestRefundCalculation false
    And Customer makes "MERCHANT_ISSUED_REFUND" transaction with "AUTOPAY" payment type on "20251029" with 242.00 EUR transaction amount and system-generated Idempotency key and interestRefundCalculation false
    And Customer makes "MERCHANT_ISSUED_REFUND" transaction with "AUTOPAY" payment type on "20251029" with 30.49 EUR transaction amount and system-generated Idempotency key and interestRefundCalculation false
    Then Loan status will be "OVERPAID"

    # 20251030 -> CBR 514.49
    When Admin sets the business date to "20251030"
    And Admin runs inline COB job for Loan
    And Admin makes Credit Balance Refund transaction on "20251030" with 514.49 EUR transaction amount

    # 20251211 -> INTEREST_REFUND on MIR1 + backdated GOODWILL_CREDIT (txn date 20251028, BEFORE the MIRs)
    When Admin sets the business date to "20251211"
    And Admin runs inline COB job for Loan
    And Admin manually adds Interest Refund for "1"th "MERCHANT_ISSUED_REFUND" transaction made on "20251029" with 0.01 EUR interest refund amount
    And Customer makes "GOODWILL_CREDIT" transaction with "AUTOPAY" payment type on "20251028" with 0.01 EUR transaction amount and system-generated Idempotency key

    # 20251212 -> CBR 27.92
    When Admin sets the business date to "20251212"
    And Admin runs inline COB job for Loan
    And Admin makes Credit Balance Refund transaction on "20251212" with 27.92 EUR transaction amount

    # 20251216 -> INTEREST_REFUND on MIR2 & MIR3 + another backdated GOODWILL_CREDIT
    When Admin sets the business date to "20251216"
    And Admin runs inline COB job for Loan
    And Admin manually adds Interest Refund for "2"th "MERCHANT_ISSUED_REFUND" transaction made on "20251029" with 0.01 EUR interest refund amount
    And Admin manually adds Interest Refund for "3"th "MERCHANT_ISSUED_REFUND" transaction made on "20251029" with 0.01 EUR interest refund amount
    And Customer makes "GOODWILL_CREDIT" transaction with "AUTOPAY" payment type on "20251028" with 0.01 EUR transaction amount and system-generated Idempotency key

    # 20251217 -> final CBR 0.01 - should fully close the loan
    When Admin sets the business date to "20251217"
    And Admin runs inline COB job for Loan
    And Admin makes Credit Balance Refund transaction on "20251217" with 0.01 EUR transaction amount
    Then Loan has 0.0 outstanding amount
    And Loan has 0.0 overpaid amount
    And Loan status will be "CLOSED_OBLIGATIONS_MET"
    And Loan Repayment schedule has 6 periods, with the following data for periods:
      | Nr | Days | Date              | Paid date         | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid   | In advance | Late | Outstanding |
      |    |      | 20250406     |                   | 1316.49         |               |          | 0.0  |           | 0.0    | 0.0    |            |      |             |
      | 1  | 30   | 20250506       | 20250506       | 1102.39         | 214.1         | 13.21    | 0.0  | 0.0       | 227.31 | 227.31 | 0.0        | 0.0  | 0.0         |
      | 2  | 31   | 20250606      | 20250606      | 886.51          | 215.88        | 11.43    | 0.0  | 0.0       | 227.31 | 227.31 | 0.0        | 0.0  | 0.0         |
      | 3  | 30   | 20250706      | 20250706      | 668.09          | 218.42        | 8.89     | 0.0  | 0.0       | 227.31 | 227.31 | 0.0        | 0.0  | 0.0         |
      | 4  | 31   | 20250806    | 20250806    | 447.71          | 220.38        | 6.93     | 0.0  | 0.0       | 227.31 | 227.31 | 0.0        | 0.0  | 0.0         |
      | 5  | 31   | 20250906 | 20250906 | 225.04          | 222.67        | 4.64     | 0.0  | 0.0       | 227.31 | 227.31 | 0.0        | 0.0  | 0.0         |
      | 6  | 30   | 20251006   | 20251002   | 0.0             | 225.04        | 1.96     | 0.0  | 0.0       | 227.0  | 227.0  | 227.0      | 0.0  | 0.0         |
    And Loan Repayment schedule has the following data in Total row:
      | Principal due | Interest | Fees | Penalties | Due     | Paid    | In advance | Late | Outstanding |
      | 1316.49       | 47.06    | 0.0  | 0.0       | 1363.55 | 1363.55 | 227.0      | 0.0  | 0.0         |

    @TestRailId:C78812
    Examples: LAST_INSTALLMENT future-installment rule (the configuration that originally reproduced PS-3087)
      | rule             | loanProduct                                                                                        |
      | LAST_INSTALLMENT | LP2_ADV_PYMNT_INT_DAILY_EMI_ACTUAL_ACTUAL_INT_REFUND_FULL_ZERO_INT_CHARGE_OFF_ACC_LAST_INSTALLMENT |

    @TestRailId:C78853
    Examples: NEXT_INSTALLMENT future-installment rule (default; must stay unaffected by the fix)
      | rule             | loanProduct                                                                                    |
      | NEXT_INSTALLMENT | LP2_ADV_PYMNT_INT_DAILY_EMI_ACTUAL_ACTUAL_INT_REFUND_FULL_ZERO_INT_CHARGE_OFF_ACCRUAL_ACTIVITY |

  @TestRailId:C78851
  Scenario: Verify that backdated GoodwillCredit on fully paid loan followed by CBR closes the loan
    When Admin sets the business date to "20251215"
    And Admin creates a client with random data
    And Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                                        | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INT_DAILY_EMI_ACTUAL_ACTUAL_INT_REFUND_FULL_ZERO_INT_CHARGE_OFF_ACC_LAST_INSTALLMENT | 20250101   | 300            | 0                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 3                 | MONTHS                | 1              | MONTHS                 | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20250101" with "300" amount and expected disbursement date on "20250101"
    And Admin successfully disburse the loan on "20250101" with "300" EUR transaction amount
    And Customer makes "REPAYMENT" transaction with "AUTOPAY" payment type on "20250201" with 100.00 EUR transaction amount and system-generated Idempotency key
    And Customer makes "REPAYMENT" transaction with "AUTOPAY" payment type on "20250301" with 100.00 EUR transaction amount and system-generated Idempotency key
    And Customer makes "REPAYMENT" transaction with "AUTOPAY" payment type on "20250401" with 100.00 EUR transaction amount and system-generated Idempotency key
    Then Loan status will be "CLOSED_OBLIGATIONS_MET"
    # Backdated GoodwillCredit dated BEFORE maturity (20250401) on an already-closed loan
    When Customer makes "GOODWILL_CREDIT" transaction with "AUTOPAY" payment type on "20250315" with 0.50 EUR transaction amount and system-generated Idempotency key
    Then Loan status will be "OVERPAID"
    And Loan has 0.0 outstanding amount
    And Loan has 0.5 overpaid amount
    # CBR equal to overpayment closes the loan; the schedule's last installment must remain intact
    When Admin makes Credit Balance Refund transaction on "20250415" with 0.5 EUR transaction amount
    Then Loan status will be "CLOSED_OBLIGATIONS_MET"
    And Loan has 0.0 outstanding amount
    And Loan has 0.0 overpaid amount
    And Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20250101  |                  | 300.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 31   | 20250201 | 20250201 | 200.0           | 100.0         | 0.0      | 0.0  | 0.0       | 100.0 | 100.0 | 0.0        | 0.0  | 0.0         |
      | 2  | 28   | 20250301    | 20250301    | 100.0           | 100.0         | 0.0      | 0.0  | 0.0       | 100.0 | 100.0 | 0.0        | 0.0  | 0.0         |
      | 3  | 31   | 20250401    | 20250401    | 0.0             | 100.0         | 0.0      | 0.0  | 0.0       | 100.0 | 100.0 | 0.5        | 0.0  | 0.0         |

  @TestRailId:C78852
  Scenario: Verify that Reverse-replay reduces overpayment so an earlier CBR re-runs with principalPortion > 0
    When Admin sets the business date to "20251215"
    And Admin creates a client with random data
    And Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                                        | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INT_DAILY_EMI_ACTUAL_ACTUAL_INT_REFUND_FULL_ZERO_INT_CHARGE_OFF_ACC_LAST_INSTALLMENT | 20250101   | 300            | 0                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 3                 | MONTHS                | 1              | MONTHS                 | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20250101" with "300" amount and expected disbursement date on "20250101"
    And Admin successfully disburse the loan on "20250101" with "300" EUR transaction amount
    And Customer makes "REPAYMENT" transaction with "AUTOPAY" payment type on "20250201" with 100.00 EUR transaction amount and system-generated Idempotency key
    And Customer makes "REPAYMENT" transaction with "AUTOPAY" payment type on "20250301" with 100.00 EUR transaction amount and system-generated Idempotency key
    # Final repayment overpays by 50 EUR
    And Customer makes "REPAYMENT" transaction with "AUTOPAY" payment type on "20250401" with 150.00 EUR transaction amount and system-generated Idempotency key
    Then Loan status will be "OVERPAID"
    And Loan has 50.0 overpaid amount
    # CBR equals overpayment, after maturity → loan closes
    When Admin makes Credit Balance Refund transaction on "20250415" with 50 EUR transaction amount
    Then Loan status will be "CLOSED_OBLIGATIONS_MET"
    And Loan has 0.0 outstanding amount
    # Reverse the SECOND repayment → reverse-replay re-runs the CBR with smaller overpayment
    When Customer undo "1"th repayment on "20250301"
    Then Loan status will be "ACTIVE"
    And Loan has 100.0 outstanding amount
    And Loan Repayment schedule has 4 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date     | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late  | Outstanding |
      |    |      | 20250101  |               | 300.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |       |             |
      | 1  | 31   | 20250201 | 20250301 | 200.0           | 100.0         | 0.0      | 0.0  | 0.0       | 100.0 | 100.0 | 0.0        | 100.0 | 0.0         |
      | 2  | 28   | 20250301    | 20250401 | 100.0           | 100.0         | 0.0      | 0.0  | 0.0       | 100.0 | 100.0 | 0.0        | 100.0 | 0.0         |
      | 3  | 31   | 20250401    |               | 0.0             | 100.0         | 0.0      | 0.0  | 0.0       | 100.0 | 50.0  | 0.0        | 0.0   | 50.0        |
      | 4  | 14   | 20250415    |               | 0.0             | 50.0          | 0.0      | 0.0  | 0.0       | 50.0  | 0.0   | 0.0        | 0.0   | 50.0        |

  @TestRailId:C85446
  Scenario: Verify Adjust schedule with CBR on non-interest-recalculation loan - UC1: CBR credit preserved after repeated repayment reversals trigger reverse-replay
    # Step 1: Create and disburse account - (2025-08-29) 65.98
    When Admin sets the business date to "20250829"
    And Admin creates a client with random data
    And Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                                       | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INT_DAILY_EMI_ACTUAL_ACTUAL_NO_INTEREST_RECALC_INT_REFUND_FULL_ACC_MATUR_CHARGE_OFF | 20250829    | 65.98          | 0                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 30                | DAYS                  | 30             | DAYS                   | 1                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20250829" with "65.98" amount and expected disbursement date on "20250829"
    And Admin successfully disburse the loan on "20250829" with "65.98" EUR transaction amount
    Then Loan status will be "ACTIVE"
    # Step 2: Adjust the Schedule to 2 months forward (2025-08-29)
    When Admin creates and approves Loan reschedule with the following data:
      | rescheduleFromDate | submittedOnDate | adjustedDueDate  | graceOnPrincipal | graceOnInterest | extraTerms | newInterestRate |
      | 20250928  | 20250829  | 20251121 |                  |                 |            |                 |
    And Admin adds "LOAN_NSF_FEE" due date charge with "20251121" due date and 1.9 EUR transaction amount
    # Step 4: Repayment (2025-08-29) 46.89
    And Customer makes "AUTOPAY" repayment on "20250829" with 46.89 EUR transaction amount
    # Step 3: MIR (2025-08-29) 20.99
    And Customer makes "MERCHANT_ISSUED_REFUND" transaction with "AUTOPAY" payment type on "20250829" with 20.99 EUR transaction amount and system-generated Idempotency key and interestRefundCalculation false
    And Admin sets the business date to "20250903"
    And Admin runs inline COB job for Loan
    # Step 5: Second MIR (2025-09-03) 44.99
    And Customer makes "MERCHANT_ISSUED_REFUND" transaction with "AUTOPAY" payment type on "20250903" with 44.99 EUR transaction amount and system-generated Idempotency key and interestRefundCalculation false
    And Admin sets the business date to "20250905"
    And Admin runs inline COB job for Loan
# full charge adjustment
    And Admin makes a charge adjustment for the last "LOAN_NSF_FEE" type charge which is due on "20251121" with 1.9 EUR transaction amount and externalId ""
    # Step 6: CBR (2025-09-05) 46.89
    And Admin makes Credit Balance Refund transaction on "20250905" with 46.89 EUR transaction amount
    Then Loan Repayment schedule has 1 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date      | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20250829   |                | 65.98           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 84   | 20251121 | 20250829 | 0.0             | 65.98         | 0.0      | 0.0  | 1.9       | 67.88 | 67.88 | 67.88      | 0.0  | 0.0         |
    # Step 7: Reverse the repayment from Step 4 (2025-09-10) - MIR and CBR are reverse-replayed, triggering the bug
    When Admin sets the business date to "20250910"
    And Admin runs inline COB job for Loan
    And Customer undo "1"th repayment on "20250829"
    Then Loan Repayment schedule has 2 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date         | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      |    |      | 20250829   |                   | 65.98           |               |          | 0.0  |           | 0.0    | 0.0   |            |      |             |
      | 1  | 84   | 20251121 |                   | 0.0             | 112.87        | 0.0      | 0.0  | 0.0       | 112.87 | 65.98 | 65.98      | 0.0  | 46.89       |
      | 2  | 54   | 20251121 | 20250905 | 0.0             | 0.0           | 0.0      | 0.0  | 1.9       | 1.9    | 1.9   | 1.9        | 0.0  | 0.0         |
    When Admin sets the business date to "20251014"
    And Admin runs inline COB job for Loan
    And Customer makes "AUTOPAY" repayment on "20251014" with 46.89 EUR transaction amount
    And Admin sets the business date to "20251025"
    And Admin runs inline COB job for Loan
    And Customer undo "2"th repayment on "20251014"
    Then Loan Repayment schedule has 2 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date         | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      |    |      | 20250829   |                   | 65.98           |               |          | 0.0  |           | 0.0    | 0.0   |            |      |             |
      | 1  | 84   | 20251121 |                   | 0.0             | 112.87        | 0.0      | 0.0  | 0.0       | 112.87 | 65.98 | 65.98      | 0.0  | 46.89       |
      | 2  | 54   | 20251121 | 20250905 | 0.0             | 0.0           | 0.0      | 0.0  | 1.9       | 1.9    | 1.9   | 1.9        | 0.0  | 0.0         |
    When Admin sets the business date to "20251113"
    And Admin runs inline COB job for Loan
    And Customer makes "AUTOPAY" repayment on "20251113" with 46.89 EUR transaction amount
    And Admin sets the business date to "20251119"
    And Admin runs inline COB job for Loan
    And Customer undo "3"th repayment on "20251113"
    Then Loan Repayment schedule has 2 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date         | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      |    |      | 20250829   |                   | 65.98           |               |          | 0.0  |           | 0.0    | 0.0   |            |      |             |
      | 1  | 84   | 20251121 |                   | 0.0             | 112.87        | 0.0      | 0.0  | 0.0       | 112.87 | 65.98 | 65.98      | 0.0  | 46.89       |
      | 2  | 54   | 20251121 | 20250905 | 0.0             | 0.0           | 0.0      | 0.0  | 1.9       | 1.9    | 1.9   | 1.9        | 0.0  | 0.0         |
    When Admin sets the business date to "20251121"
    And Admin runs inline COB job for Loan
    And Customer makes "AUTOPAY" repayment on "20251121" with 46.89 EUR transaction amount
    And Admin sets the business date to "20251125"
    And Admin runs inline COB job for Loan
    And Customer undo "4"th repayment on "20251121"
    Then Loan Repayment schedule has 2 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date         | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      |    |      | 20250829   |                   | 65.98           |               |          | 0.0  |           | 0.0    | 0.0   |            |      |             |
      | 1  | 84   | 20251121 |                   | 0.0             | 112.87        | 0.0      | 0.0  | 0.0       | 112.87 | 65.98 | 65.98      | 0.0  | 46.89       |
      | 2  | 54   | 20251121 | 20250905 | 0.0             | 0.0           | 0.0      | 0.0  | 1.9       | 1.9    | 1.9   | 1.9        | 0.0  | 0.0         |
    When Admin sets the business date to "20251221"
    And Admin runs inline COB job for Loan
    And Admin sets the business date to "20260121"
    And Admin runs inline COB job for Loan
    And Admin sets the business date to "20260221"
    And Admin runs inline COB job for Loan
    And Admin sets the business date to "20260321"
    And Admin runs inline COB job for Loan
    And Admin sets the business date to "20260421"
    And Admin runs inline COB job for Loan
    And Admin sets the business date to "20260517"
    And Admin runs inline COB job for Loan
    And Customer makes "AUTOPAY" repayment on "20260517" with 46.89 EUR transaction amount
    And Admin sets the business date to "20260520"
    And Admin runs inline COB job for Loan
    And Customer undo "5"th repayment on "20260517"
    Then Loan Repayment schedule has 2 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date         | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      |    |      | 20250829   |                   | 65.98           |               |          | 0.0  |           | 0.0    | 0.0   |            |      |             |
      | 1  | 84   | 20251121 |                   | 0.0             | 112.87        | 0.0      | 0.0  | 0.0       | 112.87 | 65.98 | 65.98      | 0.0  | 46.89       |
      | 2  | 54   | 20251121 | 20250905 | 0.0             | 0.0           | 0.0      | 0.0  | 1.9       | 1.9    | 1.9   | 1.9        | 0.0  | 0.0         |
    When Admin sets the business date to "20260521"
    And Admin runs inline COB job for Loan
    Then Loan Repayment schedule has 2 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date         | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      |    |      | 20250829   |                   | 65.98           |               |          | 0.0  |           | 0.0    | 0.0   |            |      |             |
      | 1  | 84   | 20251121 |                   | 0.0             | 112.87        | 0.0      | 0.0  | 0.0       | 112.87 | 65.98 | 65.98      | 0.0  | 46.89       |
      | 2  | 54   | 20251121 | 20250905 | 0.0             | 0.0           | 0.0      | 0.0  | 1.9       | 1.9    | 1.9   | 1.9        | 0.0  | 0.0         |
    When Admin does charge-off the loan on "20260521"
    And Customer makes "AUTOPAY" repayment on "20260521" with 46.89 EUR transaction amount
    And Admin sets the business date to "20260527"
    And Admin runs inline COB job for Loan
    And Customer undo "6"th repayment on "20260521"
    And Admin sets the business date to "20260605"
    And Admin runs inline COB job for Loan
    Then Loan Repayment schedule has 2 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date         | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid  | In advance | Late | Outstanding |
      |    |      | 20250829   |                   | 65.98           |               |          | 0.0  |           | 0.0    | 0.0   |            |      |             |
      | 1  | 84   | 20251121 |                   | 0.0             | 112.87        | 0.0      | 0.0  | 0.0       | 112.87 | 65.98 | 65.98      | 0.0  | 46.89       |
      | 2  | 54   | 20251121 | 20250905 | 0.0             | 0.0           | 0.0      | 0.0  | 1.9       | 1.9    | 1.9   | 1.9        | 0.0  | 0.0         |
    And Loan Transactions tab has the following data:
      | Transaction date   | Transaction Type       | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20250829     | Disbursement           | 65.98  | 0.0       | 0.0      | 0.0  | 0.0       | 65.98        | false    | false    |
      | 20250829     | Repayment              | 46.89  | 44.99     | 0.0      | 0.0  | 1.9       | 20.99        | true     | false    |
      | 20250829     | Merchant Issued Refund | 20.99  | 20.99     | 0.0      | 0.0  | 0.0       | 44.99        | false    | false    |
      | 20250829     | Accrual                | 1.9    | 0.0       | 0.0      | 0.0  | 1.9       | 0.0          | false    | false    |
      | 20250903  | Merchant Issued Refund | 44.99  | 44.99     | 0.0      | 0.0  | 0.0       | 0.0          | false    | true     |
      | 20250905  | Charge Adjustment      | 1.9    | 0.0       | 0.0      | 0.0  | 1.9       | 0.0          | false    | true     |
      | 20250905  | Credit Balance Refund  | 46.89  | 46.89     | 0.0      | 0.0  | 0.0       | 46.89        | false    | true     |
      | 20251014    | Repayment              | 46.89  | 46.89     | 0.0      | 0.0  | 0.0       | 0.0          | true     | false    |
      | 20251113   | Repayment              | 46.89  | 46.89     | 0.0      | 0.0  | 0.0       | 0.0          | true     | false    |
      | 20251121   | Repayment              | 46.89  | 46.89     | 0.0      | 0.0  | 0.0       | 0.0          | true     | false    |
      | 20260517        | Repayment              | 46.89  | 46.89     | 0.0      | 0.0  | 0.0       | 0.0          | true     | false    |
      | 20260521        | Charge-off             | 46.89  | 46.89     | 0.0      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20260521        | Repayment              | 46.89  | 46.89     | 0.0      | 0.0  | 0.0       | 0.0          | true     | false    |
    # Closing the loan
    When Loan Pay-off is made on "20260605"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C85447
  Scenario: Verify Adjust schedule with CBR on non-interest-recalculation loan - UC2: simplified repro without MIR
    When Admin sets the business date to "20250101"
    And Admin creates a client with random data
    And Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                                       | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INT_DAILY_EMI_ACTUAL_ACTUAL_NO_INTEREST_RECALC_INT_REFUND_FULL_ACC_MATUR_CHARGE_OFF | 20250101   | 100            | 0                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 30                | DAYS                  | 30             | DAYS                   | 1                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20250101" with "100" amount and expected disbursement date on "20250101"
    And Admin successfully disburse the loan on "20250101" with "100" EUR transaction amount
    Then Loan status will be "ACTIVE"
    # Adjust schedule 2 months forward
    When Admin creates and approves Loan reschedule with the following data:
      | rescheduleFromDate | submittedOnDate | adjustedDueDate | graceOnPrincipal | graceOnInterest | extraTerms | newInterestRate |
      | 20250131    | 20250101 | 20250331   |                  |                 |            |                 |
    # Repayment overpays the loan, then CBR refunds the excess
    And Customer makes "AUTOPAY" repayment on "20250101" with 200 EUR transaction amount
    And Admin makes Credit Balance Refund transaction on "20250101" with 100 EUR transaction amount
    Then Loan Repayment schedule has 1 periods, with the following data for periods:
      | Nr | Days | Date            | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20250101 |                 | 100.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 89   | 20250331   | 20250101 | 0.0             | 100.0         | 0.0      | 0.0  | 0.0       | 100.0 | 100.0 | 100.0      | 0.0  | 0.0         |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type      | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20250101  | Disbursement          | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20250101  | Repayment             | 200.0  | 100.0     | 0.0      | 0.0  | 0.0       | 0.0          | false    | false    |
      | 20250101  | Credit Balance Refund | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 0.0          | false    | false    |
    # Reverse repayment - CBR is reverse-replayed, triggering the bug
    When Admin sets the business date to "20250105"
    And Admin runs inline COB job for Loan
    And Customer undo "1"th repayment on "20250101"
    Then Loan Repayment schedule has 1 periods, with the following data for periods:
      | Nr | Days | Date            | Paid date       | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid | In advance | Late | Outstanding |
      |    |      | 20250101 |                 | 100.0           |               |          | 0.0  |           | 0.0   | 0.0  |            |      |             |
      | 1  | 89   | 20250331   |                 | 0.0             | 200.0         | 0.0      | 0.0  | 0.0       | 200.0 | 0.0  | 0.0        | 0.0  | 200.0       |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type      | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20250101  | Disbursement          | 100.0  | 0.0       | 0.0      | 0.0  | 0.0       | 100.0        | false    | false    |
      | 20250101  | Repayment             | 200.0  | 100.0     | 0.0      | 0.0  | 0.0       | 0.0          | true     | false    |
      | 20250101  | Credit Balance Refund | 100.0  | 100.0     | 0.0      | 0.0  | 0.0       | 200.0        | false    | true     |
    # Closing the loan
    When Loan Pay-off is made on "20250105"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C85448
  Scenario: Verify Adjust schedule with CBR on non-interest-recalculation loan - UC3: multiple reschedules before CBR reverse-replay
    When Admin sets the business date to "20250101"
    And Admin creates a client with random data
    And Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                                       | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INT_DAILY_EMI_ACTUAL_ACTUAL_NO_INTEREST_RECALC_INT_REFUND_FULL_ACC_MATUR_CHARGE_OFF | 20250101   | 200            | 0                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 60                | DAYS                  | 30             | DAYS                   | 2                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20250101" with "200" amount and expected disbursement date on "20250101"
    And Admin successfully disburse the loan on "20250101" with "200" EUR transaction amount
    Then Loan status will be "ACTIVE"
    # First reschedule: installment 1 moved from Jan to Feb
    When Admin creates and approves Loan reschedule with the following data:
      | rescheduleFromDate | submittedOnDate | adjustedDueDate | graceOnPrincipal | graceOnInterest | extraTerms | newInterestRate |
      | 20250131    | 20250101 | 20250228 |                 |                 |            |                 |
    # Second reschedule: installment 1 moved again from Feb to Mar
    And Admin creates and approves Loan reschedule with the following data:
      | rescheduleFromDate | submittedOnDate  | adjustedDueDate | graceOnPrincipal | graceOnInterest | extraTerms | newInterestRate |
      | 20250228   | 20250101 | 20250331   |                  |                 |            |                 |
    # Repayment overpays the loan, then CBR refunds the excess
    And Admin sets the business date to "20250115"
    And Customer makes "AUTOPAY" repayment on "20250115" with 400 EUR transaction amount
    And Admin makes Credit Balance Refund transaction on "20250115" with 200 EUR transaction amount
    Then Loan Repayment schedule has 2 periods, with the following data for periods:
      | Nr | Days | Date            | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20250101 |                  | 200.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 89   | 20250331   | 20250115  | 100.0           | 100.0         | 0.0      | 0.0  | 0.0       | 100.0 | 100.0 | 100.0      | 0.0  | 0.0         |
      | 2  | 30   | 20250430   | 20250115  | 0.0             | 100.0         | 0.0      | 0.0  | 0.0       | 100.0 | 100.0 | 100.0      | 0.0  | 0.0         |
    # Reverse repayment - CBR is reverse-replayed, triggering the bug
    When Admin sets the business date to "20250201"
    And Admin runs inline COB job for Loan
    And Customer undo "1"th repayment on "20250115"
    Then Loan Repayment schedule has 2 periods, with the following data for periods:
      | Nr | Days | Date            | Paid date        | Balance of loan | Principal due | Interest | Fees | Penalties | Due   | Paid  | In advance | Late | Outstanding |
      |    |      | 20250101 |                  | 200.0           |               |          | 0.0  |           | 0.0   | 0.0   |            |      |             |
      | 1  | 89   | 20250331   |                  | 100.0           | 300.0         | 0.0      | 0.0  | 0.0       | 300.0 | 0.0   | 0.0        | 0.0  | 300.0       |
      | 2  | 30   | 20250430   |                  | 0.0             | 100.0         | 0.0      | 0.0  | 0.0       | 100.0 | 0.0   | 0.0        | 0.0  | 100.0       |
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type      | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted | Replayed |
      | 20250101  | Disbursement          | 200.0  | 0.0       | 0.0      | 0.0  | 0.0       | 200.0        | false    | false    |
      | 20250115  | Repayment             | 400.0  | 200.0     | 0.0      | 0.0  | 0.0       | 0.0          | true     | false    |
      | 20250115  | Credit Balance Refund | 200.0  | 200.0     | 0.0      | 0.0  | 0.0       | 400.0        | false    | true     |
    # Closing the loan
    When Loan Pay-off is made on "20250201"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met