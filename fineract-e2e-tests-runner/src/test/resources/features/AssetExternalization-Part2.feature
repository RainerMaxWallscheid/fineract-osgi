@AssetExternalizationFeature
Feature: Asset Externalization - Part2

  @TestRailId:C3800 @AssetExternalizationJournalEntry
  Scenario: Verify manual journal entry with External Asset Owner empty value if asset-externalization is enabled - UC2
    Given Global configuration "asset-externalization-of-non-active-loans" is enabled
    When Admin sets the business date to "20250610"
    Then Admin creates manual Journal entry with "88" amount and "20250610" date and without External Asset Owner
    Then Verify manual Journal entry with External Asset Owner "true" and with the following Journal entries:
      | Type      | Account code | Account name              | Debit | Credit | Manual Entry |
      | ASSET     | 112601       | Loans Receivable          | 88.0  |        | true         |
      | LIABILITY | 145023       | Suspense/Clearing account |       | 88.0   | true         |
    Given Global configuration "asset-externalization-of-non-active-loans" is enabled

  @TestRailId:C3801 @AssetExternalizationJournalEntry
  Scenario: Verify manual journal entry with External Asset Owner empty value if asset-externalization is enabled for existing loan - UC3
    Given Global configuration "asset-externalization-of-non-active-loans" is enabled
    When Admin sets the business date to "20250601"
    When Admin creates a client with random data
    When Admin creates a new default Loan with date: "20250601"
    And Admin successfully approves the loan on "20250601" with "1000" amount and expected disbursement date on "20250601"
    When Admin successfully disburse the loan on "20250601" with "1000" EUR transaction amount
    Then Loan status will be "ACTIVE"
    When Admin makes asset externalization request by Loan ID with unique ownerExternalId, system-generated transferExternalId and the following data:
      | Transaction type | settlementDate | purchasePriceRatio |
      | sale             | 2025-06-01     | 1                  |
    Then Asset externalization response has the correct Loan ID, transferExternalId
    Then Fetching Asset externalization details by loan id gives numberOfElements: 1 with correct ownerExternalId and the following data:
      | settlementDate | purchasePriceRatio | status  | effectiveFrom | effectiveTo | Transaction type |
      | 2025-06-01     | 1                  | PENDING | 2025-06-01    | 9999-12-31  | SALE             |
    When Admin sets the business date to "20250627"
    Then Admin creates manual Journal entry with "99" amount and "20250627" date and unique External Asset Owner
    Then Verify manual Journal entry with External Asset Owner "true" and with the following Journal entries:
      | Type      | Account code | Account name              | Debit | Credit | Manual Entry |
      | ASSET     | 112601       | Loans Receivable          | 99.0  |        | true         |
      | LIABILITY | 145023       | Suspense/Clearing account |       | 99.0   | true         |
    Given Global configuration "asset-externalization-of-non-active-loans" is enabled
    When Loan Pay-off is made on "20250626"
    Then Loan's all installments have obligations met

  @TestRailId:C3821 @AssetExternalizationJournalEntry
  Scenario: Verify manual journal entry with no External Asset Owner value if asset-externalization is disabled - UC4
    Given Global configuration "asset-externalization-of-non-active-loans" is disabled
    When Admin sets the business date to "20250625"
    Then Admin creates manual Journal entry with "250.05" amount and "20250615" date and without External Asset Owner
    Then Verify manual Journal entry with External Asset Owner "false" and with the following Journal entries:
      | Type      | Account code | Account name              | Debit  | Credit | Manual Entry |
      | ASSET     | 112601       | Loans Receivable          | 250.05 |        | true         |
      | LIABILITY | 145023       | Suspense/Clearing account |        | 250.05 | true         |
    Given Global configuration "asset-externalization-of-non-active-loans" is enabled

  @TestRailId:C3991
  Scenario: Verify asset externalization previous owner for intermediarySale transfer with following SALES request - UC1
    When Admin set external asset owner loan product attribute "SETTLEMENT_MODEL" value "DELAYED_SETTLEMENT" for loan product "LP1_DUE_DATE"
    When Admin sets the business date to "20230501"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct  | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy                        |
      | LP1_DUE_DATE | 20230501       | 1000           | 0                      | DECLINING_BALANCE | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 1                 | MONTHS                | 1              | MONTHS                 | 1                  | 0                       | 0                      | 0                    | PENALTIES_FEES_INTEREST_PRINCIPAL_ORDER |
    And Admin successfully approves the loan on "20230501" with "1000" amount and expected disbursement date on "20230501"
    When Admin successfully disburse the loan on "20230501" with "1000" EUR transaction amount
    Then Loan status will be "ACTIVE"
    When Admin makes asset externalization request by Loan ID with unique ownerExternalId, system-generated transferExternalId and the following data:
      | Transaction type | settlementDate | purchasePriceRatio |
      | intermediarySale | 2023-05-21     | 1                  |
    Then Asset externalization response has the correct Loan ID, transferExternalId
    Then Fetching Asset externalization details by loan id gives numberOfElements: 1 with correct ownerExternalId and the following data:
      | settlementDate | purchasePriceRatio | status               | effectiveFrom | effectiveTo | Transaction type |
      | 2023-05-21     | 1                  | PENDING_INTERMEDIATE | 2023-05-01    | 9999-12-31  | INTERMEDIARYSALE |
    When Admin sets the business date to "20230522"
    When Admin runs inline COB job for Loan
    Then Fetching Asset externalization details by loan id gives numberOfElements: 2 with correct ownerExternalId and the following data:
      | settlementDate | purchasePriceRatio | status               | effectiveFrom | effectiveTo | Transaction type |
      | 2023-05-21     | 1                  | PENDING_INTERMEDIATE | 2023-05-01    | 2023-05-21  | INTERMEDIARYSALE |
      | 2023-05-21     | 1                  | ACTIVE_INTERMEDIATE  | 2023-05-22    | 9999-12-31  | INTERMEDIARYSALE |
    Then LoanOwnershipTransferBusinessEvent with transfer type: "INTERMEDIARYSALE" and transfer asset owner is created
    When Admin sets the business date to "20230614"
    When Admin makes asset externalization request by Loan ID with unique ownerExternalId, system-generated transferExternalId and the following data:
      | Transaction type | settlementDate | purchasePriceRatio |
      | sale             | 2023-06-14     | 1                  |
    Then Fetching Asset externalization details by loan id gives numberOfElements: 3 with correct ownerExternalId and the following data:
      | settlementDate | purchasePriceRatio | status               | effectiveFrom | effectiveTo | Transaction type |
      | 2023-05-21     | 1                  | PENDING_INTERMEDIATE | 2023-05-01    | 2023-05-21  | INTERMEDIARYSALE |
      | 2023-05-21     | 1                  | ACTIVE_INTERMEDIATE  | 2023-05-22    | 9999-12-31  | INTERMEDIARYSALE |
      | 2023-06-14     | 1                  | PENDING              | 2023-06-14    | 9999-12-31  | SALE             |
    When Admin sets the business date to "20230615"
    When Admin runs inline COB job for Loan
    Then Fetching Asset externalization details by loan id gives numberOfElements: 4 with correct ownerExternalId and the following data:
      | settlementDate | purchasePriceRatio | status               | effectiveFrom | effectiveTo | Transaction type |
      | 2023-05-21     | 1                  | PENDING_INTERMEDIATE | 2023-05-01    | 2023-05-21  | INTERMEDIARYSALE |
      | 2023-05-21     | 1                  | ACTIVE_INTERMEDIATE  | 2023-05-22    | 2023-06-14  | INTERMEDIARYSALE |
      | 2023-06-14     | 1                  | PENDING              | 2023-06-14    | 2023-06-14  | SALE             |
      | 2023-06-14     | 1                  | ACTIVE               | 2023-06-15    | 9999-12-31  | SALE             |
    Then LoanOwnershipTransferBusinessEvent with transfer type: "SALE" and transfer asset owner based on intermediarySale is created
    When Admin set external asset owner loan product attribute "SETTLEMENT_MODEL" value "DEFAULT_SETTLEMENT" for loan product "LP1_DUE_DATE"
    When Loan Pay-off is made on "20230615" with transfer external owner
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C3992
  Scenario: Verify asset externalization previous owner for intermediarySale transfer with following SALES and BUYBACK requests - UC2
    When Admin set external asset owner loan product attribute "SETTLEMENT_MODEL" value "DELAYED_SETTLEMENT" for loan product "LP1_DUE_DATE"
    When Admin sets the business date to "20230501"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct  | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy                        |
      | LP1_DUE_DATE | 20230501       | 1000           | 0                      | DECLINING_BALANCE | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 1                 | MONTHS                | 1              | MONTHS                 | 1                  | 0                       | 0                      | 0                    | PENALTIES_FEES_INTEREST_PRINCIPAL_ORDER |
    And Admin successfully approves the loan on "20230501" with "1000" amount and expected disbursement date on "20230501"
    When Admin successfully disburse the loan on "20230501" with "1000" EUR transaction amount
    Then Loan status will be "ACTIVE"
    When Admin makes asset externalization request by Loan ID with unique ownerExternalId, system-generated transferExternalId and the following data:
      | Transaction type | settlementDate | purchasePriceRatio |
      | intermediarySale | 2023-05-21     | 1                  |
    Then Asset externalization response has the correct Loan ID, transferExternalId
    Then Fetching Asset externalization details by loan id gives numberOfElements: 1 with correct ownerExternalId and the following data:
      | settlementDate | purchasePriceRatio | status               | effectiveFrom | effectiveTo | Transaction type |
      | 2023-05-21     | 1                  | PENDING_INTERMEDIATE | 2023-05-01    | 9999-12-31  | INTERMEDIARYSALE |
    When Admin sets the business date to "20230522"
    When Admin runs inline COB job for Loan
    Then Fetching Asset externalization details by loan id gives numberOfElements: 2 with correct ownerExternalId and the following data:
      | settlementDate | purchasePriceRatio | status               | effectiveFrom | effectiveTo | Transaction type |
      | 2023-05-21     | 1                  | PENDING_INTERMEDIATE | 2023-05-01    | 2023-05-21  | INTERMEDIARYSALE |
      | 2023-05-21     | 1                  | ACTIVE_INTERMEDIATE  | 2023-05-22    | 9999-12-31  | INTERMEDIARYSALE |
    Then LoanOwnershipTransferBusinessEvent with transfer type: "INTERMEDIARYSALE" and transfer asset owner is created
    When Admin sets the business date to "20230614"
    When Admin makes asset externalization request by Loan ID with unique ownerExternalId, system-generated transferExternalId and the following data:
      | Transaction type | settlementDate | purchasePriceRatio |
      | sale             | 2023-06-14     | 1                  |
    Then Fetching Asset externalization details by loan id gives numberOfElements: 3 with correct ownerExternalId and the following data:
      | settlementDate | purchasePriceRatio | status               | effectiveFrom | effectiveTo | Transaction type |
      | 2023-05-21     | 1                  | PENDING_INTERMEDIATE | 2023-05-01    | 2023-05-21  | INTERMEDIARYSALE |
      | 2023-05-21     | 1                  | ACTIVE_INTERMEDIATE  | 2023-05-22    | 9999-12-31  | INTERMEDIARYSALE |
      | 2023-06-14     | 1                  | PENDING              | 2023-06-14    | 9999-12-31  | SALE             |
    When Admin sets the business date to "20230615"
    When Admin runs inline COB job for Loan
    Then Fetching Asset externalization details by loan id gives numberOfElements: 4 with correct ownerExternalId and the following data:
      | settlementDate | purchasePriceRatio | status               | effectiveFrom | effectiveTo | Transaction type |
      | 2023-05-21     | 1                  | PENDING_INTERMEDIATE | 2023-05-01    | 2023-05-21  | INTERMEDIARYSALE |
      | 2023-05-21     | 1                  | ACTIVE_INTERMEDIATE  | 2023-05-22    | 2023-06-14  | INTERMEDIARYSALE |
      | 2023-06-14     | 1                  | PENDING              | 2023-06-14    | 2023-06-14  | SALE             |
      | 2023-06-14     | 1                  | ACTIVE               | 2023-06-15    | 9999-12-31  | SALE             |
    Then LoanOwnershipTransferBusinessEvent with transfer type: "SALE" and transfer asset owner based on intermediarySale is created
    When Admin makes asset externalization request by Loan ID with unique ownerExternalId, system-generated transferExternalId and the following data:
      | Transaction type | settlementDate | purchasePriceRatio |
      | buyback          | 2023-06-16     |                    |
    Then Fetching Asset externalization details by loan id gives numberOfElements: 5 with correct ownerExternalId and the following data:
      | settlementDate | purchasePriceRatio | status               | effectiveFrom | effectiveTo | Transaction type |
      | 2023-05-21     | 1                  | PENDING_INTERMEDIATE | 2023-05-01    | 2023-05-21  | INTERMEDIARYSALE |
      | 2023-05-21     | 1                  | ACTIVE_INTERMEDIATE  | 2023-05-22    | 2023-06-14  | INTERMEDIARYSALE |
      | 2023-06-14     | 1                  | PENDING              | 2023-06-14    | 2023-06-14  | SALE             |
      | 2023-06-14     | 1                  | ACTIVE               | 2023-06-15    | 9999-12-31  | SALE             |
      | 2023-06-16     | 1                  | BUYBACK              | 2023-06-15    | 9999-12-31  | BUYBACK          |
    When Admin sets the business date to "20230617"
    When Admin runs inline COB job for Loan
    Then Fetching Asset externalization details by loan id gives numberOfElements: 5 with correct ownerExternalId and the following data:
      | settlementDate | purchasePriceRatio | status               | effectiveFrom | effectiveTo | Transaction type |
      | 2023-05-21     | 1                  | PENDING_INTERMEDIATE | 2023-05-01    | 2023-05-21  | INTERMEDIARYSALE |
      | 2023-05-21     | 1                  | ACTIVE_INTERMEDIATE  | 2023-05-22    | 2023-06-14  | INTERMEDIARYSALE |
      | 2023-06-14     | 1                  | PENDING              | 2023-06-14    | 2023-06-14  | SALE             |
      | 2023-06-14     | 1                  | ACTIVE               | 2023-06-15    | 2023-06-16  | SALE             |
      | 2023-06-16     | 1                  | BUYBACK              | 2023-06-15    | 2023-06-16  | BUYBACK          |
    Then LoanOwnershipTransferBusinessEvent with transfer type: "BUYBACK" and transfer asset owner is created
    When Admin set external asset owner loan product attribute "SETTLEMENT_MODEL" value "DEFAULT_SETTLEMENT" for loan product "LP1_DUE_DATE"
    When Loan Pay-off is made on "20230617"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C3993
  Scenario: Verify asset externalization previous owner for intermediarySale transfer with following BUYBACK requests - UC3
    When Admin set external asset owner loan product attribute "SETTLEMENT_MODEL" value "DELAYED_SETTLEMENT" for loan product "LP1_DUE_DATE"
    When Admin sets the business date to "20230501"
    When Admin creates a client with random data
    When Admin creates a fully customized loan with the following data:
      | LoanProduct  | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy                        |
      | LP1_DUE_DATE | 20230501       | 1000           | 0                      | DECLINING_BALANCE | SAME_AS_REPAYMENT_PERIOD    | EQUAL_INSTALLMENTS | 1                 | MONTHS                | 1              | MONTHS                 | 1                  | 0                       | 0                      | 0                    | PENALTIES_FEES_INTEREST_PRINCIPAL_ORDER |
    And Admin successfully approves the loan on "20230501" with "1000" amount and expected disbursement date on "20230501"
    When Admin successfully disburse the loan on "20230501" with "1000" EUR transaction amount
    Then Loan status will be "ACTIVE"
    When Admin makes asset externalization request by Loan ID with unique ownerExternalId, system-generated transferExternalId and the following data:
      | Transaction type | settlementDate | purchasePriceRatio |
      | intermediarySale | 2023-05-21     | 1                  |
    Then Asset externalization response has the correct Loan ID, transferExternalId
    Then Fetching Asset externalization details by loan id gives numberOfElements: 1 with correct ownerExternalId and the following data:
      | settlementDate | purchasePriceRatio | status               | effectiveFrom | effectiveTo | Transaction type |
      | 2023-05-21     | 1                  | PENDING_INTERMEDIATE | 2023-05-01    | 9999-12-31  | INTERMEDIARYSALE |
    When Admin sets the business date to "20230522"
    When Admin runs inline COB job for Loan
    Then Fetching Asset externalization details by loan id gives numberOfElements: 2 with correct ownerExternalId and the following data:
      | settlementDate | purchasePriceRatio | status               | effectiveFrom | effectiveTo | Transaction type |
      | 2023-05-21     | 1                  | PENDING_INTERMEDIATE | 2023-05-01    | 2023-05-21  | INTERMEDIARYSALE |
      | 2023-05-21     | 1                  | ACTIVE_INTERMEDIATE  | 2023-05-22    | 9999-12-31  | INTERMEDIARYSALE |
    Then LoanOwnershipTransferBusinessEvent with transfer type: "INTERMEDIARYSALE" and transfer asset owner is created
    When Admin sets the business date to "20230614"
    When Admin makes asset externalization request by Loan ID with unique ownerExternalId, system-generated transferExternalId and the following data:
      | Transaction type | settlementDate | purchasePriceRatio |
      | buyback          | 2023-06-14     |                    |
    Then Fetching Asset externalization details by loan id gives numberOfElements: 3 with correct ownerExternalId and the following data:
      | settlementDate | purchasePriceRatio | status               | effectiveFrom | effectiveTo | Transaction type |
      | 2023-05-21     | 1                  | PENDING_INTERMEDIATE | 2023-05-01    | 2023-05-21  | INTERMEDIARYSALE |
      | 2023-05-21     | 1                  | ACTIVE_INTERMEDIATE  | 2023-05-22    | 9999-12-31  | INTERMEDIARYSALE |
      | 2023-06-14     | 1                  | BUYBACK_INTERMEDIATE | 2023-06-14    | 9999-12-31  | BUYBACK          |
    When Admin sets the business date to "20230615"
    When Admin runs inline COB job for Loan
    Then Fetching Asset externalization details by loan id gives numberOfElements: 3 with correct ownerExternalId and the following data:
      | settlementDate | purchasePriceRatio | status               | effectiveFrom | effectiveTo | Transaction type |
      | 2023-05-21     | 1                  | PENDING_INTERMEDIATE | 2023-05-01    | 2023-05-21  | INTERMEDIARYSALE |
      | 2023-05-21     | 1                  | ACTIVE_INTERMEDIATE  | 2023-05-22    | 2023-06-14  | INTERMEDIARYSALE |
      | 2023-06-14     | 1                  | BUYBACK_INTERMEDIATE | 2023-06-14    | 2023-06-14  | BUYBACK          |
    Then LoanOwnershipTransferBusinessEvent with transfer type: "BUYBACK" and transfer asset owner based on intermediarySale is created
    When Admin set external asset owner loan product attribute "SETTLEMENT_MODEL" value "DEFAULT_SETTLEMENT" for loan product "LP1_DUE_DATE"
    When Loan Pay-off is made on "20230615"
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C4640
  Scenario: Verify creation of new external asset owner and it presence in the list
    When Admin creates a new external asset owner with a unique ownerExternalId
    Then External asset owner creation response has a non-null resourceId
    Then External asset owner list contains the created owner

  @TestRailId:C4641
  Scenario: Verify creation of an external asset owner fails for null, duplicate and empty ownerExternalId
    When Admin tries to create an external asset owner with null ownerExternalId then it should fail with 400 status code
    When Admin tries to create an external asset owner with empty JSON body then it should fail with 400 status code
    When Admin creates a new external asset owner with a unique ownerExternalId
    Then External asset owner creation response has a non-null resourceId
    When Admin tries to create an external asset owner with a duplicate ownerExternalId then it should fail with 403 status code

  @TestRailId:C4642
  Scenario: Verify creation of multiple external asset owners and presence of all items the list
    When Admin creates a new external asset owner with a unique ownerExternalId
    Then External asset owner creation response has a non-null resourceId
    Then External asset owner list contains the created owner
    When Admin creates a new external asset owner with a unique ownerExternalId
    Then External asset owner creation response has a non-null resourceId
    Then External asset owner list contains the created owner
    Then Admin retrieves all external asset owners successfully

  @TestRailId:C72360
  Scenario: Verify that when a loan with PENDING owner-to-owner SALES is fully paid asset transfer is DECLINED and original owner remains active
    When Admin sets the business date to "20230501"
    When Admin creates a client with random data
    When Admin creates a new default Loan with date: "20230501"
    And Admin successfully approves the loan on "20230501" with "1000" amount and expected disbursement date on "20230501"
    When Admin successfully disburse the loan on "20230501" with "1000" EUR transaction amount
    Then Loan status will be "ACTIVE"
    When Admin makes asset externalization request by Loan ID with unique ownerExternalId, system-generated transferExternalId and the following data:
      | Transaction type | settlementDate | purchasePriceRatio |
      | sale             | 2023-05-21     | 1                  |
    Then Asset externalization response has the correct Loan ID, transferExternalId
    When Admin sets the business date to "20230522"
    When Admin runs inline COB job for Loan
    Then LoanOwnershipTransferBusinessEvent is created
    Then LoanAccountSnapshotBusinessEvent is created
    Then Fetching Asset externalization details by loan id gives numberOfElements: 2 with correct ownerExternalId and the following data:
      | settlementDate | purchasePriceRatio | status  | effectiveFrom | effectiveTo | Transaction type |
      | 2023-05-21     | 1                  | PENDING | 2023-05-01    | 2023-05-21  | SALE             |
      | 2023-05-21     | 1                  | ACTIVE  | 2023-05-22    | 9999-12-31  | SALE             |
    When Admin sets the business date to "20230525"
    When Admin makes asset externalization request by Loan ID with unique ownerExternalId, system-generated transferExternalId and the following data:
      | Transaction type | settlementDate | purchasePriceRatio |
      | sale             | 2023-06-14     | 1                  |
    Then Asset externalization response has the correct Loan ID, transferExternalId
    When Admin sets the business date to "20230528"
    And Customer makes "AUTOPAY" repayment on "20230528" with 1000 EUR transaction amount and check previous external owner
    Then Loan status will be "CLOSED_OBLIGATIONS_MET"
    Then Fetching Asset externalization details by loan id gives numberOfElements: 4 with correct ownerExternalId and the following data:
      | settlementDate | purchasePriceRatio | status   | effectiveFrom | effectiveTo | Transaction type |
      | 2023-06-14     | 1                  | DECLINED | 2023-05-28    | 2023-05-28  | SALE             |
    Then LoanOwnershipTransferBusinessEvent with transfer status: "DECLINED" and transfer status reason "BALANCE_ZERO" is created

  @TestRailId:C72361
  Scenario: Verify that when a loan with PENDING owner-to-owner SALES is overpaid asset transfer is DECLINED and original owner remains active
    When Admin sets the business date to "20230501"
    When Admin creates a client with random data
    When Admin creates a new default Loan with date: "20230501"
    And Admin successfully approves the loan on "20230501" with "1000" amount and expected disbursement date on "20230501"
    When Admin successfully disburse the loan on "20230501" with "1000" EUR transaction amount
    Then Loan status will be "ACTIVE"
    When Admin makes asset externalization request by Loan ID with unique ownerExternalId, system-generated transferExternalId and the following data:
      | Transaction type | settlementDate | purchasePriceRatio |
      | sale             | 2023-05-21     | 1                  |
    Then Asset externalization response has the correct Loan ID, transferExternalId
    When Admin sets the business date to "20230522"
    When Admin runs inline COB job for Loan
    Then LoanOwnershipTransferBusinessEvent is created
    Then LoanAccountSnapshotBusinessEvent is created
    Then Fetching Asset externalization details by loan id gives numberOfElements: 2 with correct ownerExternalId and the following data:
      | settlementDate | purchasePriceRatio | status  | effectiveFrom | effectiveTo | Transaction type |
      | 2023-05-21     | 1                  | PENDING | 2023-05-01    | 2023-05-21  | SALE             |
      | 2023-05-21     | 1                  | ACTIVE  | 2023-05-22    | 9999-12-31  | SALE             |
    When Admin sets the business date to "20230525"
    When Admin makes asset externalization request by Loan ID with unique ownerExternalId, system-generated transferExternalId and the following data:
      | Transaction type | settlementDate | purchasePriceRatio |
      | sale             | 2023-06-14     | 1                  |
    Then Asset externalization response has the correct Loan ID, transferExternalId
    When Admin sets the business date to "20230528"
    And Customer makes "AUTOPAY" repayment on "20230528" with 1200 EUR transaction amount and check previous external owner
    Then Loan status will be "OVERPAID"
    Then Fetching Asset externalization details by loan id gives numberOfElements: 4 with correct ownerExternalId and the following data:
      | settlementDate | purchasePriceRatio | status   | effectiveFrom | effectiveTo | Transaction type |
      | 2023-06-14     | 1                  | DECLINED | 2023-05-28    | 2023-05-28  | SALE             |
    Then LoanOwnershipTransferBusinessEvent with transfer status: "DECLINED" and transfer status reason "BALANCE_NEGATIVE" is created

  @TestRailId:C72362
  Scenario: Verify owner-to-owner transfer completes via COB and next repayment accounting goes to new owner
    When Admin sets the business date to "20230501"
    When Admin creates a client with random data
    When Admin creates a new default Loan with date: "20230501"
    And Admin successfully approves the loan on "20230501" with "1000" amount and expected disbursement date on "20230501"
    When Admin successfully disburse the loan on "20230501" with "1000" EUR transaction amount
    Then Loan status will be "ACTIVE"
    When Admin makes asset externalization request by Loan ID with unique ownerExternalId, system-generated transferExternalId and the following data:
      | Transaction type | settlementDate | purchasePriceRatio |
      | sale             | 2023-05-21     | 1                  |
    Then Asset externalization response has the correct Loan ID, transferExternalId
    When Admin sets the business date to "20230522"
    When Admin runs inline COB job for Loan
    Then LoanOwnershipTransferBusinessEvent is created
    Then LoanAccountSnapshotBusinessEvent is created
    Then Fetching Asset externalization details by loan id gives numberOfElements: 2 with correct ownerExternalId and the following data:
      | settlementDate | purchasePriceRatio | status  | effectiveFrom | effectiveTo | Transaction type |
      | 2023-05-21     | 1                  | PENDING | 2023-05-01    | 2023-05-21  | SALE             |
      | 2023-05-21     | 1                  | ACTIVE  | 2023-05-22    | 9999-12-31  | SALE             |
    When Admin sets the business date to "20230525"
    When Admin makes asset externalization request by Loan ID with unique ownerExternalId, system-generated transferExternalId and the following data:
      | Transaction type | settlementDate | purchasePriceRatio |
      | sale             | 2023-05-25     | 1                  |
    Then Asset externalization response has the correct Loan ID, transferExternalId
    When Admin sets the business date to "20230526"
    When Admin runs inline COB job for Loan
    Then LoanOwnershipTransferBusinessEvent is created
    Then LoanAccountSnapshotBusinessEvent is created
    Then The latest asset externalization transaction with "ACTIVE" status has the following TRANSFER Journal entries:
      | glAccountType | glAccountCode | glAccountName    | entryType | amount  |
      | ASSET         | 112601        | Loans Receivable | CREDIT    | 1000.00 |
      | ASSET         | 146000        | Asset transfer   | DEBIT     | 1000.00 |
      | ASSET         | 112601        | Loans Receivable | DEBIT     | 1000.00 |
      | ASSET         | 146000        | Asset transfer   | CREDIT    | 1000.00 |
    Then The asset external owner has the following OWNER Journal entries:
      | glAccountType | glAccountCode | glAccountName    | entryType | amount  |
      | ASSET         | 112601        | Loans Receivable | DEBIT     | 1000.00 |
    When Customer makes "REPAYMENT" transaction with "AUTOPAY" payment type on "20230526" with 200 EUR transaction amount and system-generated Idempotency key and check external owner
    Then The asset external owner has the following OWNER Journal entries:
      | glAccountType | glAccountCode | glAccountName             | entryType | amount  |
      | ASSET         | 112601        | Loans Receivable          | DEBIT     | 1000.00 |
      | ASSET         | 112601        | Loans Receivable          | CREDIT    | 200.00  |
      | LIABILITY     | 145023        | Suspense/Clearing account | DEBIT     | 200.00  |
    When Loan Pay-off is made on "20230526" with transfer external owner
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C72363
  Scenario: Verify owner-to-owner repayment accounting goes to old owner while PENDING transfer not yet settled
    When Admin sets the business date to "20230501"
    When Admin creates a client with random data
    When Admin creates a new default Loan with date: "20230501"
    And Admin successfully approves the loan on "20230501" with "1000" amount and expected disbursement date on "20230501"
    When Admin successfully disburse the loan on "20230501" with "1000" EUR transaction amount
    Then Loan status will be "ACTIVE"
    When Admin makes asset externalization request by Loan ID with unique ownerExternalId, system-generated transferExternalId and the following data:
      | Transaction type | settlementDate | purchasePriceRatio |
      | sale             | 2023-05-21     | 1                  |
    Then Asset externalization response has the correct Loan ID, transferExternalId
    When Admin sets the business date to "20230522"
    When Admin runs inline COB job for Loan
    Then LoanOwnershipTransferBusinessEvent is created
    Then LoanAccountSnapshotBusinessEvent is created
    Then Fetching Asset externalization details by loan id gives numberOfElements: 2 with correct ownerExternalId and the following data:
      | settlementDate | purchasePriceRatio | status  | effectiveFrom | effectiveTo | Transaction type |
      | 2023-05-21     | 1                  | PENDING | 2023-05-01    | 2023-05-21  | SALE             |
      | 2023-05-21     | 1                  | ACTIVE  | 2023-05-22    | 9999-12-31  | SALE             |
    Then The asset external owner has the following OWNER Journal entries:
      | glAccountType | glAccountCode | glAccountName    | entryType | amount  |
      | ASSET         | 112601        | Loans Receivable | DEBIT     | 1000.00 |
    When Admin sets the business date to "20230525"
    When Admin makes asset externalization request by Loan ID with unique ownerExternalId, system-generated transferExternalId and the following data:
      | Transaction type | settlementDate | purchasePriceRatio |
      | sale             | 2023-06-14     | 1                  |
    Then Asset externalization response has the correct Loan ID, transferExternalId
    When Customer makes "REPAYMENT" transaction with "AUTOPAY" payment type on "20230525" with 200 EUR transaction amount and system-generated Idempotency key and check previous external owner
    When Loan Pay-off is made on "20230525" with previous transfer external owner
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C72364
  Scenario: Verify chained owner-to-owner transfers complete successfully
    When Admin sets the business date to "20230501"
    When Admin creates a client with random data
    When Admin creates a new default Loan with date: "20230501"
    And Admin successfully approves the loan on "20230501" with "1000" amount and expected disbursement date on "20230501"
    When Admin successfully disburse the loan on "20230501" with "1000" EUR transaction amount
    Then Loan status will be "ACTIVE"
    When Admin makes asset externalization request by Loan ID with unique ownerExternalId, system-generated transferExternalId and the following data:
      | Transaction type | settlementDate | purchasePriceRatio |
      | sale             | 2023-05-21     | 1                  |
    Then Asset externalization response has the correct Loan ID, transferExternalId
    When Admin sets the business date to "20230522"
    When Admin runs inline COB job for Loan
    Then LoanOwnershipTransferBusinessEvent is created
    Then LoanAccountSnapshotBusinessEvent is created
    Then Fetching Asset externalization details by loan id gives numberOfElements: 2 with correct ownerExternalId and the following data:
      | settlementDate | purchasePriceRatio | status  | effectiveFrom | effectiveTo | Transaction type |
      | 2023-05-21     | 1                  | PENDING | 2023-05-01    | 2023-05-21  | SALE             |
      | 2023-05-21     | 1                  | ACTIVE  | 2023-05-22    | 9999-12-31  | SALE             |
    When Admin sets the business date to "20230525"
    When Admin makes asset externalization request by Loan ID with unique ownerExternalId, system-generated transferExternalId and the following data:
      | Transaction type | settlementDate | purchasePriceRatio |
      | sale             | 2023-05-25     | 1                  |
    Then Asset externalization response has the correct Loan ID, transferExternalId
    When Admin sets the business date to "20230526"
    When Admin runs inline COB job for Loan
    Then LoanOwnershipTransferBusinessEvent is created
    Then LoanAccountSnapshotBusinessEvent is created
    Then The asset external owner has the following OWNER Journal entries:
      | glAccountType | glAccountCode | glAccountName    | entryType | amount  |
      | ASSET         | 112601        | Loans Receivable | DEBIT     | 1000.00 |
    When Admin sets the business date to "20230528"
    When Admin makes asset externalization request by Loan ID with unique ownerExternalId, system-generated transferExternalId and the following data:
      | Transaction type | settlementDate | purchasePriceRatio |
      | sale             | 2023-05-28     | 1                  |
    Then Asset externalization response has the correct Loan ID, transferExternalId
    When Admin sets the business date to "20230529"
    When Admin runs inline COB job for Loan
    Then LoanOwnershipTransferBusinessEvent is created
    Then LoanAccountSnapshotBusinessEvent is created
    Then The asset external owner has the following OWNER Journal entries:
      | glAccountType | glAccountCode | glAccountName    | entryType | amount  |
      | ASSET         | 112601        | Loans Receivable | DEBIT     | 1000.00 |
    When Customer makes "REPAYMENT" transaction with "AUTOPAY" payment type on "20230529" with 300 EUR transaction amount and system-generated Idempotency key and check external owner
    Then The asset external owner has the following OWNER Journal entries:
      | glAccountType | glAccountCode | glAccountName             | entryType | amount  |
      | ASSET         | 112601        | Loans Receivable          | DEBIT     | 1000.00 |
      | ASSET         | 112601        | Loans Receivable          | CREDIT    | 300.00  |
      | LIABILITY     | 145023        | Suspense/Clearing account | DEBIT     | 300.00  |
    When Loan Pay-off is made on "20230529" with transfer external owner
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C72365
  Scenario: Verify cancel of PENDING owner-to-owner transfer before COB preserves original owner
    When Admin sets the business date to "20230501"
    When Admin creates a client with random data
    When Admin creates a new default Loan with date: "20230501"
    And Admin successfully approves the loan on "20230501" with "1000" amount and expected disbursement date on "20230501"
    When Admin successfully disburse the loan on "20230501" with "1000" EUR transaction amount
    Then Loan status will be "ACTIVE"
    When Admin makes asset externalization request by Loan ID with unique ownerExternalId, system-generated transferExternalId and the following data:
      | Transaction type | settlementDate | purchasePriceRatio |
      | sale             | 2023-05-21     | 1                  |
    Then Asset externalization response has the correct Loan ID, transferExternalId
    When Admin sets the business date to "20230522"
    When Admin runs inline COB job for Loan
    Then LoanOwnershipTransferBusinessEvent is created
    Then LoanAccountSnapshotBusinessEvent is created
    Then Fetching Asset externalization details by loan id gives numberOfElements: 2 with correct ownerExternalId and the following data:
      | settlementDate | purchasePriceRatio | status  | effectiveFrom | effectiveTo | Transaction type |
      | 2023-05-21     | 1                  | PENDING | 2023-05-01    | 2023-05-21  | SALE             |
      | 2023-05-21     | 1                  | ACTIVE  | 2023-05-22    | 9999-12-31  | SALE             |
    When Admin sets the business date to "20230525"
    When Admin makes asset externalization request by Loan ID with unique ownerExternalId, system-generated transferExternalId and the following data:
      | Transaction type | settlementDate | purchasePriceRatio |
      | sale             | 2023-05-30     | 1                  |
    Then Asset externalization response has the correct Loan ID, transferExternalId
    When Admin send "cancel" command on "PENDING" transaction
    Then Fetching Asset externalization details by loan id gives numberOfElements: 4 with correct ownerExternalId and the following data:
      | settlementDate | purchasePriceRatio | status    | effectiveFrom | effectiveTo | Transaction type |
      | 2023-05-30     | 1                  | CANCELLED | 2023-05-25    | 2023-05-25  | SALE             |
    When Customer makes "REPAYMENT" transaction with "AUTOPAY" payment type on "20230525" with 200 EUR transaction amount and system-generated Idempotency key and check previous external owner
    When Loan Pay-off is made on "20230525" with previous transfer external owner
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C72366
  Scenario: Verify buyback is blocked while PENDING owner-to-owner transfer exists
    When Admin sets the business date to "20230501"
    When Admin creates a client with random data
    When Admin creates a new default Loan with date: "20230501"
    And Admin successfully approves the loan on "20230501" with "1000" amount and expected disbursement date on "20230501"
    When Admin successfully disburse the loan on "20230501" with "1000" EUR transaction amount
    Then Loan status will be "ACTIVE"
    When Admin makes asset externalization request by Loan ID with unique ownerExternalId, system-generated transferExternalId and the following data:
      | Transaction type | settlementDate | purchasePriceRatio |
      | sale             | 2023-05-21     | 1                  |
    Then Asset externalization response has the correct Loan ID, transferExternalId
    When Admin sets the business date to "20230522"
    When Admin runs inline COB job for Loan
    Then LoanOwnershipTransferBusinessEvent is created
    Then LoanAccountSnapshotBusinessEvent is created
    Then Fetching Asset externalization details by loan id gives numberOfElements: 2 with correct ownerExternalId and the following data:
      | settlementDate | purchasePriceRatio | status  | effectiveFrom | effectiveTo | Transaction type |
      | 2023-05-21     | 1                  | PENDING | 2023-05-01    | 2023-05-21  | SALE             |
      | 2023-05-21     | 1                  | ACTIVE  | 2023-05-22    | 9999-12-31  | SALE             |
    When Admin sets the business date to "20230525"
    When Admin makes asset externalization request by Loan ID with unique ownerExternalId, system-generated transferExternalId and the following data:
      | Transaction type | settlementDate | purchasePriceRatio |
      | sale             | 2023-05-30     | 1                  |
    Then Asset externalization response has the correct Loan ID, transferExternalId
    Then Asset externalization transaction with the following data results a 403 error and "BUYBACK_ALREADY_IN_PROGRESS_CANNOT_BE_BOUGHT" error message
      | Transaction type | settlementDate | purchasePriceRatio |
      | buyback          | 2023-06-01     |                    |
    When Loan Pay-off is made on "20230525" with previous transfer external owner
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C85346
  Scenario: Verify owner-to-owner transfer completes via COB, Recognition of Fully Deferred Capitalized Income has correct journal entries
    When Admin sets the business date to "20260101"
    And Admin creates a client with random data
    And Admin creates a fully customized loan with the following data:
      | LoanProduct                                                                      | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_EMI_360_30_INTEREST_RECALC_DAILY_CAPITALIZED_INCOME | 20260101   | 3000           | 7                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 3                 | MONTHS                | 1              | MONTHS                 | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20260101" with "3000" amount and expected disbursement date on "20260101"
    And Admin successfully disburse the loan on "20260101" with "1500" EUR transaction amount
    Then Loan status will be "ACTIVE"
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      |    |      | 20260101  |           | 1500.0          |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      | 1  | 31   | 20260201 |           | 1002.91         | 497.09        | 8.75     | 0.0  | 0.0       | 505.84 | 0.0  | 0.0        | 0.0  | 505.84      |
      | 2  | 28   | 20260301    |           | 502.92          | 499.99        | 5.85     | 0.0  | 0.0       | 505.84 | 0.0  | 0.0        | 0.0  | 505.84      |
      | 3  | 31   | 20260401    |           | 0.0             | 502.92        | 2.93     | 0.0  | 0.0       | 505.85 | 0.0  | 0.0        | 0.0  | 505.85      |

    And Admin adds capitalized income with "AUTOPAY" payment type to the loan on "20260101" with "900" EUR transaction amount
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      |    |      | 20260101  |           | 1500.0          |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      |    |      | 20260101  |           | 900.0           |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      | 1  | 31   | 20260201 |           | 1604.65         | 795.35        | 14.0     | 0.0  | 0.0       | 809.35 | 0.0  | 0.0        | 0.0  | 809.35      |
      | 2  | 28   | 20260301    |           | 804.66          | 799.99        | 9.36     | 0.0  | 0.0       | 809.35 | 0.0  | 0.0        | 0.0  | 809.35      |
      | 3  | 31   | 20260401    |           | 0.0             | 804.66        | 4.69     | 0.0  | 0.0       | 809.35 | 0.0  | 0.0        | 0.0  | 809.35      |

    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type   | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20260101  | Disbursement       | 1500.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1500.0       | false    |
      | 20260101  | Capitalized Income | 900.0  | 900.0     | 0.0      | 0.0  | 0.0       | 2400.0       | false    |
    When Admin sets the business date to "20260102"
    When Admin runs inline COB job for Loan
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type                | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20260101  | Disbursement                    | 1500.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1500.0       | false    |
      | 20260101  | Capitalized Income              | 900.0  | 900.0     | 0.0      | 0.0  | 0.0       | 2400.0       | false    |
      | 20260101  | Capitalized Income Amortization | 10.0   | 0.0       | 10.0     | 0.0  | 0.0       | 0.0          | false    |
    When Admin makes asset externalization request by Loan ID with unique ownerExternalId, system-generated transferExternalId and the following data:
      | Transaction type | settlementDate | purchasePriceRatio |
      | sale             | 2026-01-15     | 1                  |

    When Admin sets the business date to "20260115"
    When Admin runs inline COB job for Loan
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type                | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20260101  | Disbursement                    | 1500.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1500.0       | false    |
      | 20260101  | Capitalized Income              | 900.0  | 900.0     | 0.0      | 0.0  | 0.0       | 2400.0       | false    |
      | 20260101  | Capitalized Income Amortization | 10.0   | 0.0       | 10.0     | 0.0  | 0.0       | 0.0          | false    |
      | 20260102  | Accrual                         | 0.45   | 0.0       | 0.45     | 0.0  | 0.0       | 0.0          | false    |
      | 20260102  | Capitalized Income Amortization | 10.0   | 0.0       | 10.0     | 0.0  | 0.0       | 0.0          | false    |
      | 20260103  | Accrual                         | 0.45   | 0.0       | 0.45     | 0.0  | 0.0       | 0.0          | false    |
      | 20260103  | Capitalized Income Amortization | 10.0   | 0.0       | 10.0     | 0.0  | 0.0       | 0.0          | false    |
      | 20260104  | Accrual                         | 0.45   | 0.0       | 0.45     | 0.0  | 0.0       | 0.0          | false    |
      | 20260104  | Capitalized Income Amortization | 10.0   | 0.0       | 10.0     | 0.0  | 0.0       | 0.0          | false    |
      | 20260105  | Accrual                         | 0.46   | 0.0       | 0.46     | 0.0  | 0.0       | 0.0          | false    |
      | 20260105  | Capitalized Income Amortization | 10.0   | 0.0       | 10.0     | 0.0  | 0.0       | 0.0          | false    |
      | 20260106  | Accrual                         | 0.45   | 0.0       | 0.45     | 0.0  | 0.0       | 0.0          | false    |
      | 20260106  | Capitalized Income Amortization | 10.0   | 0.0       | 10.0     | 0.0  | 0.0       | 0.0          | false    |
      | 20260107  | Accrual                         | 0.45   | 0.0       | 0.45     | 0.0  | 0.0       | 0.0          | false    |
      | 20260107  | Capitalized Income Amortization | 10.0   | 0.0       | 10.0     | 0.0  | 0.0       | 0.0          | false    |
      | 20260108  | Accrual                         | 0.45   | 0.0       | 0.45     | 0.0  | 0.0       | 0.0          | false    |
      | 20260108  | Capitalized Income Amortization | 10.0   | 0.0       | 10.0     | 0.0  | 0.0       | 0.0          | false    |
      | 20260109  | Accrual                         | 0.45   | 0.0       | 0.45     | 0.0  | 0.0       | 0.0          | false    |
      | 20260109  | Capitalized Income Amortization | 10.0   | 0.0       | 10.0     | 0.0  | 0.0       | 0.0          | false    |
      | 20260110  | Accrual                         | 0.45   | 0.0       | 0.45     | 0.0  | 0.0       | 0.0          | false    |
      | 20260110  | Capitalized Income Amortization | 10.0   | 0.0       | 10.0     | 0.0  | 0.0       | 0.0          | false    |
      | 20260111  | Accrual                         | 0.46   | 0.0       | 0.46     | 0.0  | 0.0       | 0.0          | false    |
      | 20260111  | Capitalized Income Amortization | 10.0   | 0.0       | 10.0     | 0.0  | 0.0       | 0.0          | false    |
      | 20260112  | Accrual                         | 0.45   | 0.0       | 0.45     | 0.0  | 0.0       | 0.0          | false    |
      | 20260112  | Capitalized Income Amortization | 10.0   | 0.0       | 10.0     | 0.0  | 0.0       | 0.0          | false    |
      | 20260113  | Accrual                         | 0.45   | 0.0       | 0.45     | 0.0  | 0.0       | 0.0          | false    |
      | 20260113  | Capitalized Income Amortization | 10.0   | 0.0       | 10.0     | 0.0  | 0.0       | 0.0          | false    |
      | 20260114  | Accrual                         | 0.45   | 0.0       | 0.45     | 0.0  | 0.0       | 0.0          | false    |
      | 20260114  | Capitalized Income Amortization | 10.0   | 0.0       | 10.0     | 0.0  | 0.0       | 0.0          | false    |

    When Admin sets the business date to "20260116"
    When Admin runs inline COB job for Loan
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type                | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20260101  | Disbursement                    | 1500.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1500.0       | false    |
      | 20260101  | Capitalized Income              | 900.0  | 900.0     | 0.0      | 0.0  | 0.0       | 2400.0       | false    |
      | 20260101  | Capitalized Income Amortization | 10.0   | 0.0       | 10.0     | 0.0  | 0.0       | 0.0          | false    |
      | 20260102  | Accrual                         | 0.45   | 0.0       | 0.45     | 0.0  | 0.0       | 0.0          | false    |
      | 20260102  | Capitalized Income Amortization | 10.0   | 0.0       | 10.0     | 0.0  | 0.0       | 0.0          | false    |
      | 20260103  | Accrual                         | 0.45   | 0.0       | 0.45     | 0.0  | 0.0       | 0.0          | false    |
      | 20260103  | Capitalized Income Amortization | 10.0   | 0.0       | 10.0     | 0.0  | 0.0       | 0.0          | false    |
      | 20260104  | Accrual                         | 0.45   | 0.0       | 0.45     | 0.0  | 0.0       | 0.0          | false    |
      | 20260104  | Capitalized Income Amortization | 10.0   | 0.0       | 10.0     | 0.0  | 0.0       | 0.0          | false    |
      | 20260105  | Accrual                         | 0.46   | 0.0       | 0.46     | 0.0  | 0.0       | 0.0          | false    |
      | 20260105  | Capitalized Income Amortization | 10.0   | 0.0       | 10.0     | 0.0  | 0.0       | 0.0          | false    |
      | 20260106  | Accrual                         | 0.45   | 0.0       | 0.45     | 0.0  | 0.0       | 0.0          | false    |
      | 20260106  | Capitalized Income Amortization | 10.0   | 0.0       | 10.0     | 0.0  | 0.0       | 0.0          | false    |
      | 20260107  | Accrual                         | 0.45   | 0.0       | 0.45     | 0.0  | 0.0       | 0.0          | false    |
      | 20260107  | Capitalized Income Amortization | 10.0   | 0.0       | 10.0     | 0.0  | 0.0       | 0.0          | false    |
      | 20260108  | Accrual                         | 0.45   | 0.0       | 0.45     | 0.0  | 0.0       | 0.0          | false    |
      | 20260108  | Capitalized Income Amortization | 10.0   | 0.0       | 10.0     | 0.0  | 0.0       | 0.0          | false    |
      | 20260109  | Accrual                         | 0.45   | 0.0       | 0.45     | 0.0  | 0.0       | 0.0          | false    |
      | 20260109  | Capitalized Income Amortization | 10.0   | 0.0       | 10.0     | 0.0  | 0.0       | 0.0          | false    |
      | 20260110  | Accrual                         | 0.45   | 0.0       | 0.45     | 0.0  | 0.0       | 0.0          | false    |
      | 20260110  | Capitalized Income Amortization | 10.0   | 0.0       | 10.0     | 0.0  | 0.0       | 0.0          | false    |
      | 20260111  | Accrual                         | 0.46   | 0.0       | 0.46     | 0.0  | 0.0       | 0.0          | false    |
      | 20260111  | Capitalized Income Amortization | 10.0   | 0.0       | 10.0     | 0.0  | 0.0       | 0.0          | false    |
      | 20260112  | Accrual                         | 0.45   | 0.0       | 0.45     | 0.0  | 0.0       | 0.0          | false    |
      | 20260112  | Capitalized Income Amortization | 10.0   | 0.0       | 10.0     | 0.0  | 0.0       | 0.0          | false    |
      | 20260113  | Accrual                         | 0.45   | 0.0       | 0.45     | 0.0  | 0.0       | 0.0          | false    |
      | 20260113  | Capitalized Income Amortization | 10.0   | 0.0       | 10.0     | 0.0  | 0.0       | 0.0          | false    |
      | 20260114  | Accrual                         | 0.45   | 0.0       | 0.45     | 0.0  | 0.0       | 0.0          | false    |
      | 20260114  | Capitalized Income Amortization | 10.0   | 0.0       | 10.0     | 0.0  | 0.0       | 0.0          | false    |
      | 20260115  | Accrual                         | 0.45   | 0.0       | 0.45     | 0.0  | 0.0       | 0.0          | false    |
      | 20260115  | Capitalized Income Amortization | 10.0   | 0.0       | 10.0     | 0.0  | 0.0       | 0.0          | false    |
      | 20260115  | Capitalized Income Amortization | 750.0  | 0.0       | 750.0    | 0.0  | 0.0       | 0.0          | false    |

    And Loan Transactions tab has a "CAPITALIZED_INCOME_AMORTIZATION" transaction with date "20260115" which has the following Journal entries:
      | Type      | Account code | Account name                | Debit | Credit |
      | INCOME    | 404000       | Interest Income             |       | 750.0  |
      | LIABILITY | 145024       | Deferred Capitalized Income | 750.0 |        |
      | INCOME    | 404000       | Interest Income             |       | 10.0   |
      | LIABILITY | 145024       | Deferred Capitalized Income | 10.0  |        |

    When Admin sets the business date to "20260117"
    When Admin runs inline COB job for Loan
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type                | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20260101  | Disbursement                    | 1500.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1500.0       | false    |
      | 20260101  | Capitalized Income              | 900.0  | 900.0     | 0.0      | 0.0  | 0.0       | 2400.0       | false    |
      | 20260101  | Capitalized Income Amortization | 10.0   | 0.0       | 10.0     | 0.0  | 0.0       | 0.0          | false    |
      | 20260102  | Accrual                         | 0.45   | 0.0       | 0.45     | 0.0  | 0.0       | 0.0          | false    |
      | 20260102  | Capitalized Income Amortization | 10.0   | 0.0       | 10.0     | 0.0  | 0.0       | 0.0          | false    |
      | 20260103  | Accrual                         | 0.45   | 0.0       | 0.45     | 0.0  | 0.0       | 0.0          | false    |
      | 20260103  | Capitalized Income Amortization | 10.0   | 0.0       | 10.0     | 0.0  | 0.0       | 0.0          | false    |
      | 20260104  | Accrual                         | 0.45   | 0.0       | 0.45     | 0.0  | 0.0       | 0.0          | false    |
      | 20260104  | Capitalized Income Amortization | 10.0   | 0.0       | 10.0     | 0.0  | 0.0       | 0.0          | false    |
      | 20260105  | Accrual                         | 0.46   | 0.0       | 0.46     | 0.0  | 0.0       | 0.0          | false    |
      | 20260105  | Capitalized Income Amortization | 10.0   | 0.0       | 10.0     | 0.0  | 0.0       | 0.0          | false    |
      | 20260106  | Accrual                         | 0.45   | 0.0       | 0.45     | 0.0  | 0.0       | 0.0          | false    |
      | 20260106  | Capitalized Income Amortization | 10.0   | 0.0       | 10.0     | 0.0  | 0.0       | 0.0          | false    |
      | 20260107  | Accrual                         | 0.45   | 0.0       | 0.45     | 0.0  | 0.0       | 0.0          | false    |
      | 20260107  | Capitalized Income Amortization | 10.0   | 0.0       | 10.0     | 0.0  | 0.0       | 0.0          | false    |
      | 20260108  | Accrual                         | 0.45   | 0.0       | 0.45     | 0.0  | 0.0       | 0.0          | false    |
      | 20260108  | Capitalized Income Amortization | 10.0   | 0.0       | 10.0     | 0.0  | 0.0       | 0.0          | false    |
      | 20260109  | Accrual                         | 0.45   | 0.0       | 0.45     | 0.0  | 0.0       | 0.0          | false    |
      | 20260109  | Capitalized Income Amortization | 10.0   | 0.0       | 10.0     | 0.0  | 0.0       | 0.0          | false    |
      | 20260110  | Accrual                         | 0.45   | 0.0       | 0.45     | 0.0  | 0.0       | 0.0          | false    |
      | 20260110  | Capitalized Income Amortization | 10.0   | 0.0       | 10.0     | 0.0  | 0.0       | 0.0          | false    |
      | 20260111  | Accrual                         | 0.46   | 0.0       | 0.46     | 0.0  | 0.0       | 0.0          | false    |
      | 20260111  | Capitalized Income Amortization | 10.0   | 0.0       | 10.0     | 0.0  | 0.0       | 0.0          | false    |
      | 20260112  | Accrual                         | 0.45   | 0.0       | 0.45     | 0.0  | 0.0       | 0.0          | false    |
      | 20260112  | Capitalized Income Amortization | 10.0   | 0.0       | 10.0     | 0.0  | 0.0       | 0.0          | false    |
      | 20260113  | Accrual                         | 0.45   | 0.0       | 0.45     | 0.0  | 0.0       | 0.0          | false    |
      | 20260113  | Capitalized Income Amortization | 10.0   | 0.0       | 10.0     | 0.0  | 0.0       | 0.0          | false    |
      | 20260114  | Accrual                         | 0.45   | 0.0       | 0.45     | 0.0  | 0.0       | 0.0          | false    |
      | 20260114  | Capitalized Income Amortization | 10.0   | 0.0       | 10.0     | 0.0  | 0.0       | 0.0          | false    |
      | 20260115  | Accrual                         | 0.45   | 0.0       | 0.45     | 0.0  | 0.0       | 0.0          | false    |
      | 20260115  | Capitalized Income Amortization | 10.0   | 0.0       | 10.0     | 0.0  | 0.0       | 0.0          | false    |
      | 20260115  | Capitalized Income Amortization | 750.0  | 0.0       | 750.0    | 0.0  | 0.0       | 0.0          | false    |
      | 20260116  | Accrual                         | 0.45   | 0.0       | 0.45     | 0.0  | 0.0       | 0.0          | false    |
    When Admin makes asset externalization request by Loan ID with unique ownerExternalId, system-generated transferExternalId and the following data:
      | Transaction type | settlementDate | purchasePriceRatio |
      | buyback          | 2026-01-20     |                    |

    When Admin sets the business date to "20260121"
    When Admin runs inline COB job for Loan
    When Admin makes asset externalization request by Loan ID with unique ownerExternalId, system-generated transferExternalId and the following data:
      | Transaction type | settlementDate | purchasePriceRatio |
      | sale             | 2026-02-01     | 1                  |
    When Admin sets the business date to "20260202"
    When Admin runs inline COB job for Loan
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type                | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20260101  | Disbursement                    | 1500.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1500.0       | false    |
      | 20260101  | Capitalized Income              | 900.0  | 900.0     | 0.0      | 0.0  | 0.0       | 2400.0       | false    |
      | 20260101  | Capitalized Income Amortization | 10.0   | 0.0       | 10.0     | 0.0  | 0.0       | 0.0          | false    |
      | 20260102  | Accrual                         | 0.45   | 0.0       | 0.45     | 0.0  | 0.0       | 0.0          | false    |
      | 20260102  | Capitalized Income Amortization | 10.0   | 0.0       | 10.0     | 0.0  | 0.0       | 0.0          | false    |
      | 20260103  | Accrual                         | 0.45   | 0.0       | 0.45     | 0.0  | 0.0       | 0.0          | false    |
      | 20260103  | Capitalized Income Amortization | 10.0   | 0.0       | 10.0     | 0.0  | 0.0       | 0.0          | false    |
      | 20260104  | Accrual                         | 0.45   | 0.0       | 0.45     | 0.0  | 0.0       | 0.0          | false    |
      | 20260104  | Capitalized Income Amortization | 10.0   | 0.0       | 10.0     | 0.0  | 0.0       | 0.0          | false    |
      | 20260105  | Accrual                         | 0.46   | 0.0       | 0.46     | 0.0  | 0.0       | 0.0          | false    |
      | 20260105  | Capitalized Income Amortization | 10.0   | 0.0       | 10.0     | 0.0  | 0.0       | 0.0          | false    |
      | 20260106  | Accrual                         | 0.45   | 0.0       | 0.45     | 0.0  | 0.0       | 0.0          | false    |
      | 20260106  | Capitalized Income Amortization | 10.0   | 0.0       | 10.0     | 0.0  | 0.0       | 0.0          | false    |
      | 20260107  | Accrual                         | 0.45   | 0.0       | 0.45     | 0.0  | 0.0       | 0.0          | false    |
      | 20260107  | Capitalized Income Amortization | 10.0   | 0.0       | 10.0     | 0.0  | 0.0       | 0.0          | false    |
      | 20260108  | Accrual                         | 0.45   | 0.0       | 0.45     | 0.0  | 0.0       | 0.0          | false    |
      | 20260108  | Capitalized Income Amortization | 10.0   | 0.0       | 10.0     | 0.0  | 0.0       | 0.0          | false    |
      | 20260109  | Accrual                         | 0.45   | 0.0       | 0.45     | 0.0  | 0.0       | 0.0          | false    |
      | 20260109  | Capitalized Income Amortization | 10.0   | 0.0       | 10.0     | 0.0  | 0.0       | 0.0          | false    |
      | 20260110  | Accrual                         | 0.45   | 0.0       | 0.45     | 0.0  | 0.0       | 0.0          | false    |
      | 20260110  | Capitalized Income Amortization | 10.0   | 0.0       | 10.0     | 0.0  | 0.0       | 0.0          | false    |
      | 20260111  | Accrual                         | 0.46   | 0.0       | 0.46     | 0.0  | 0.0       | 0.0          | false    |
      | 20260111  | Capitalized Income Amortization | 10.0   | 0.0       | 10.0     | 0.0  | 0.0       | 0.0          | false    |
      | 20260112  | Accrual                         | 0.45   | 0.0       | 0.45     | 0.0  | 0.0       | 0.0          | false    |
      | 20260112  | Capitalized Income Amortization | 10.0   | 0.0       | 10.0     | 0.0  | 0.0       | 0.0          | false    |
      | 20260113  | Accrual                         | 0.45   | 0.0       | 0.45     | 0.0  | 0.0       | 0.0          | false    |
      | 20260113  | Capitalized Income Amortization | 10.0   | 0.0       | 10.0     | 0.0  | 0.0       | 0.0          | false    |
      | 20260114  | Accrual                         | 0.45   | 0.0       | 0.45     | 0.0  | 0.0       | 0.0          | false    |
      | 20260114  | Capitalized Income Amortization | 10.0   | 0.0       | 10.0     | 0.0  | 0.0       | 0.0          | false    |
      | 20260115  | Accrual                         | 0.45   | 0.0       | 0.45     | 0.0  | 0.0       | 0.0          | false    |
      | 20260115  | Capitalized Income Amortization | 10.0   | 0.0       | 10.0     | 0.0  | 0.0       | 0.0          | false    |
      | 20260115  | Capitalized Income Amortization | 750.0  | 0.0       | 750.0    | 0.0  | 0.0       | 0.0          | false    |
      | 20260116  | Accrual                         | 0.45   | 0.0       | 0.45     | 0.0  | 0.0       | 0.0          | false    |
      | 20260117  | Accrual                         | 0.46   | 0.0       | 0.46     | 0.0  | 0.0       | 0.0          | false    |
      | 20260118  | Accrual                         | 0.45   | 0.0       | 0.45     | 0.0  | 0.0       | 0.0          | false    |
      | 20260119  | Accrual                         | 0.45   | 0.0       | 0.45     | 0.0  | 0.0       | 0.0          | false    |
      | 20260120  | Accrual                         | 0.45   | 0.0       | 0.45     | 0.0  | 0.0       | 0.0          | false    |
      | 20260121  | Accrual                         | 0.45   | 0.0       | 0.45     | 0.0  | 0.0       | 0.0          | false    |
      | 20260122  | Accrual                         | 0.45   | 0.0       | 0.45     | 0.0  | 0.0       | 0.0          | false    |
      | 20260123  | Accrual                         | 0.46   | 0.0       | 0.46     | 0.0  | 0.0       | 0.0          | false    |
      | 20260124  | Accrual                         | 0.45   | 0.0       | 0.45     | 0.0  | 0.0       | 0.0          | false    |
      | 20260125  | Accrual                         | 0.45   | 0.0       | 0.45     | 0.0  | 0.0       | 0.0          | false    |
      | 20260126  | Accrual                         | 0.45   | 0.0       | 0.45     | 0.0  | 0.0       | 0.0          | false    |
      | 20260127  | Accrual                         | 0.45   | 0.0       | 0.45     | 0.0  | 0.0       | 0.0          | false    |
      | 20260128  | Accrual                         | 0.45   | 0.0       | 0.45     | 0.0  | 0.0       | 0.0          | false    |
      | 20260129  | Accrual                         | 0.46   | 0.0       | 0.46     | 0.0  | 0.0       | 0.0          | false    |
      | 20260130  | Accrual                         | 0.45   | 0.0       | 0.45     | 0.0  | 0.0       | 0.0          | false    |
      | 20260131  | Accrual                         | 0.45   | 0.0       | 0.45     | 0.0  | 0.0       | 0.0          | false    |
      | 20260201 | Accrual                         | 0.45   | 0.0       | 0.45     | 0.0  | 0.0       | 0.0          | false    |
    When Admin sets the business date to "20260222"
    When Admin runs inline COB job for Loan
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type                | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20260101  | Disbursement                    | 1500.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1500.0       | false    |
      | 20260101  | Capitalized Income              | 900.0  | 900.0     | 0.0      | 0.0  | 0.0       | 2400.0       | false    |
      | 20260101  | Capitalized Income Amortization | 10.0   | 0.0       | 10.0     | 0.0  | 0.0       | 0.0          | false    |
      | 20260102  | Accrual                         | 0.45   | 0.0       | 0.45     | 0.0  | 0.0       | 0.0          | false    |
      | 20260102  | Capitalized Income Amortization | 10.0   | 0.0       | 10.0     | 0.0  | 0.0       | 0.0          | false    |
      | 20260103  | Accrual                         | 0.45   | 0.0       | 0.45     | 0.0  | 0.0       | 0.0          | false    |
      | 20260103  | Capitalized Income Amortization | 10.0   | 0.0       | 10.0     | 0.0  | 0.0       | 0.0          | false    |
      | 20260104  | Accrual                         | 0.45   | 0.0       | 0.45     | 0.0  | 0.0       | 0.0          | false    |
      | 20260104  | Capitalized Income Amortization | 10.0   | 0.0       | 10.0     | 0.0  | 0.0       | 0.0          | false    |
      | 20260105  | Accrual                         | 0.46   | 0.0       | 0.46     | 0.0  | 0.0       | 0.0          | false    |
      | 20260105  | Capitalized Income Amortization | 10.0   | 0.0       | 10.0     | 0.0  | 0.0       | 0.0          | false    |
      | 20260106  | Accrual                         | 0.45   | 0.0       | 0.45     | 0.0  | 0.0       | 0.0          | false    |
      | 20260106  | Capitalized Income Amortization | 10.0   | 0.0       | 10.0     | 0.0  | 0.0       | 0.0          | false    |
      | 20260107  | Accrual                         | 0.45   | 0.0       | 0.45     | 0.0  | 0.0       | 0.0          | false    |
      | 20260107  | Capitalized Income Amortization | 10.0   | 0.0       | 10.0     | 0.0  | 0.0       | 0.0          | false    |
      | 20260108  | Accrual                         | 0.45   | 0.0       | 0.45     | 0.0  | 0.0       | 0.0          | false    |
      | 20260108  | Capitalized Income Amortization | 10.0   | 0.0       | 10.0     | 0.0  | 0.0       | 0.0          | false    |
      | 20260109  | Accrual                         | 0.45   | 0.0       | 0.45     | 0.0  | 0.0       | 0.0          | false    |
      | 20260109  | Capitalized Income Amortization | 10.0   | 0.0       | 10.0     | 0.0  | 0.0       | 0.0          | false    |
      | 20260110  | Accrual                         | 0.45   | 0.0       | 0.45     | 0.0  | 0.0       | 0.0          | false    |
      | 20260110  | Capitalized Income Amortization | 10.0   | 0.0       | 10.0     | 0.0  | 0.0       | 0.0          | false    |
      | 20260111  | Accrual                         | 0.46   | 0.0       | 0.46     | 0.0  | 0.0       | 0.0          | false    |
      | 20260111  | Capitalized Income Amortization | 10.0   | 0.0       | 10.0     | 0.0  | 0.0       | 0.0          | false    |
      | 20260112  | Accrual                         | 0.45   | 0.0       | 0.45     | 0.0  | 0.0       | 0.0          | false    |
      | 20260112  | Capitalized Income Amortization | 10.0   | 0.0       | 10.0     | 0.0  | 0.0       | 0.0          | false    |
      | 20260113  | Accrual                         | 0.45   | 0.0       | 0.45     | 0.0  | 0.0       | 0.0          | false    |
      | 20260113  | Capitalized Income Amortization | 10.0   | 0.0       | 10.0     | 0.0  | 0.0       | 0.0          | false    |
      | 20260114  | Accrual                         | 0.45   | 0.0       | 0.45     | 0.0  | 0.0       | 0.0          | false    |
      | 20260114  | Capitalized Income Amortization | 10.0   | 0.0       | 10.0     | 0.0  | 0.0       | 0.0          | false    |
      | 20260115  | Accrual                         | 0.45   | 0.0       | 0.45     | 0.0  | 0.0       | 0.0          | false    |
      | 20260115  | Capitalized Income Amortization | 10.0   | 0.0       | 10.0     | 0.0  | 0.0       | 0.0          | false    |
      | 20260115  | Capitalized Income Amortization | 750.0  | 0.0       | 750.0    | 0.0  | 0.0       | 0.0          | false    |
      | 20260116  | Accrual                         | 0.45   | 0.0       | 0.45     | 0.0  | 0.0       | 0.0          | false    |
      | 20260117  | Accrual                         | 0.46   | 0.0       | 0.46     | 0.0  | 0.0       | 0.0          | false    |
      | 20260118  | Accrual                         | 0.45   | 0.0       | 0.45     | 0.0  | 0.0       | 0.0          | false    |
      | 20260119  | Accrual                         | 0.45   | 0.0       | 0.45     | 0.0  | 0.0       | 0.0          | false    |
      | 20260120  | Accrual                         | 0.45   | 0.0       | 0.45     | 0.0  | 0.0       | 0.0          | false    |
      | 20260121  | Accrual                         | 0.45   | 0.0       | 0.45     | 0.0  | 0.0       | 0.0          | false    |
      | 20260122  | Accrual                         | 0.45   | 0.0       | 0.45     | 0.0  | 0.0       | 0.0          | false    |
      | 20260123  | Accrual                         | 0.46   | 0.0       | 0.46     | 0.0  | 0.0       | 0.0          | false    |
      | 20260124  | Accrual                         | 0.45   | 0.0       | 0.45     | 0.0  | 0.0       | 0.0          | false    |
      | 20260125  | Accrual                         | 0.45   | 0.0       | 0.45     | 0.0  | 0.0       | 0.0          | false    |
      | 20260126  | Accrual                         | 0.45   | 0.0       | 0.45     | 0.0  | 0.0       | 0.0          | false    |
      | 20260127  | Accrual                         | 0.45   | 0.0       | 0.45     | 0.0  | 0.0       | 0.0          | false    |
      | 20260128  | Accrual                         | 0.45   | 0.0       | 0.45     | 0.0  | 0.0       | 0.0          | false    |
      | 20260129  | Accrual                         | 0.46   | 0.0       | 0.46     | 0.0  | 0.0       | 0.0          | false    |
      | 20260130  | Accrual                         | 0.45   | 0.0       | 0.45     | 0.0  | 0.0       | 0.0          | false    |
      | 20260131  | Accrual                         | 0.45   | 0.0       | 0.45     | 0.0  | 0.0       | 0.0          | false    |
      | 20260201 | Accrual                         | 0.45   | 0.0       | 0.45     | 0.0  | 0.0       | 0.0          | false    |
      | 20260202 | Accrual                         | 0.5    | 0.0       | 0.5      | 0.0  | 0.0       | 0.0          | false    |
      | 20260203 | Accrual                         | 0.5    | 0.0       | 0.5      | 0.0  | 0.0       | 0.0          | false    |
      | 20260204 | Accrual                         | 0.5    | 0.0       | 0.5      | 0.0  | 0.0       | 0.0          | false    |
      | 20260205 | Accrual                         | 0.5    | 0.0       | 0.5      | 0.0  | 0.0       | 0.0          | false    |
      | 20260206 | Accrual                         | 0.5    | 0.0       | 0.5      | 0.0  | 0.0       | 0.0          | false    |
      | 20260207 | Accrual                         | 0.5    | 0.0       | 0.5      | 0.0  | 0.0       | 0.0          | false    |
      | 20260208 | Accrual                         | 0.5    | 0.0       | 0.5      | 0.0  | 0.0       | 0.0          | false    |
      | 20260209 | Accrual                         | 0.5    | 0.0       | 0.5      | 0.0  | 0.0       | 0.0          | false    |
      | 20260210 | Accrual                         | 0.5    | 0.0       | 0.5      | 0.0  | 0.0       | 0.0          | false    |
      | 20260211 | Accrual                         | 0.5    | 0.0       | 0.5      | 0.0  | 0.0       | 0.0          | false    |
      | 20260212 | Accrual                         | 0.5    | 0.0       | 0.5      | 0.0  | 0.0       | 0.0          | false    |
      | 20260213 | Accrual                         | 0.5    | 0.0       | 0.5      | 0.0  | 0.0       | 0.0          | false    |
      | 20260214 | Accrual                         | 0.5    | 0.0       | 0.5      | 0.0  | 0.0       | 0.0          | false    |
      | 20260215 | Accrual                         | 0.5    | 0.0       | 0.5      | 0.0  | 0.0       | 0.0          | false    |
      | 20260216 | Accrual                         | 0.5    | 0.0       | 0.5      | 0.0  | 0.0       | 0.0          | false    |
      | 20260217 | Accrual                         | 0.5    | 0.0       | 0.5      | 0.0  | 0.0       | 0.0          | false    |
      | 20260218 | Accrual                         | 0.5    | 0.0       | 0.5      | 0.0  | 0.0       | 0.0          | false    |
      | 20260219 | Accrual                         | 0.5    | 0.0       | 0.5      | 0.0  | 0.0       | 0.0          | false    |
      | 20260220 | Accrual                         | 0.5    | 0.0       | 0.5      | 0.0  | 0.0       | 0.0          | false    |
      | 20260221 | Accrual                         | 0.5    | 0.0       | 0.5      | 0.0  | 0.0       | 0.0          | false    |

    When Loan Pay-off is made on "20260222" with transfer external owner
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C85347
  Scenario: Verify owner-to-owner transfer completes via COB, Recognition of Fully Deferred Buydown Fee has correct journal entries
    When Admin sets the business date to "20260101"
    And Admin creates a client with random data
    And Admin creates a fully customized loan with the following data:
      | LoanProduct                                              | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_PROGRESSIVE_ADVANCED_PAYMENT_ALLOCATION_BUYDOWN_FEES | 20240101   | 3000           | 7                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 3                 | MONTHS                | 1              | MONTHS                 | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20260101" with "3000" amount and expected disbursement date on "20260101"
    And Admin successfully disburse the loan on "20260101" with "1500" EUR transaction amount
    Then Loan status will be "ACTIVE"
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      |    |      | 20260101  |           | 1500.0          |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      | 1  | 31   | 20260201 |           | 1002.91         | 497.09        | 8.75     | 0.0  | 0.0       | 505.84 | 0.0  | 0.0        | 0.0  | 505.84      |
      | 2  | 28   | 20260301    |           | 502.92          | 499.99        | 5.85     | 0.0  | 0.0       | 505.84 | 0.0  | 0.0        | 0.0  | 505.84      |
      | 3  | 31   | 20260401    |           | 0.0             | 502.92        | 2.93     | 0.0  | 0.0       | 505.85 | 0.0  | 0.0        | 0.0  | 505.85      |

    When Admin adds buy down fee with "AUTOPAY" payment type to the loan on "20260101" with "900" EUR transaction amount
    Then Loan Repayment schedule has 3 periods, with the following data for periods:
      | Nr | Days | Date             | Paid date | Balance of loan | Principal due | Interest | Fees | Penalties | Due    | Paid | In advance | Late | Outstanding |
      |    |      | 20260101  |           | 1500.0          |               |          | 0.0  |           | 0.0    | 0.0  |            |      |             |
      | 1  | 31   | 20260201 |           | 1002.91         | 497.09        | 8.75     | 0.0  | 0.0       | 505.84 | 0.0  | 0.0        | 0.0  | 505.84      |
      | 2  | 28   | 20260301    |           | 502.92          | 499.99        | 5.85     | 0.0  | 0.0       | 505.84 | 0.0  | 0.0        | 0.0  | 505.84      |
      | 3  | 31   | 20260401    |           | 0.0             | 502.92        | 2.93     | 0.0  | 0.0       | 505.85 | 0.0  | 0.0        | 0.0  | 505.85      |

    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20260101  | Disbursement     | 1500.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1500.0       | false    |
      | 20260101  | Buy Down Fee     | 900.0  | 0.0       | 900.0    | 0.0  | 0.0       | 0.0          | false    |
    When Admin sets the business date to "20260102"
    When Admin runs inline COB job for Loan
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type          | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20260101  | Disbursement              | 1500.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1500.0       | false    |
      | 20260101  | Buy Down Fee              | 900.0  | 0.0       | 900.0    | 0.0  | 0.0       | 0.0          | false    |
      | 20260101  | Buy Down Fee Amortization | 10.0   | 0.0       | 10.0     | 0.0  | 0.0       | 0.0          | false    |
    When Admin makes asset externalization request by Loan ID with unique ownerExternalId, system-generated transferExternalId and the following data:
      | Transaction type | settlementDate | purchasePriceRatio |
      | sale             | 2026-01-15     | 1                  |

    When Admin sets the business date to "20260115"
    When Admin runs inline COB job for Loan
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type          | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20260101  | Disbursement              | 1500.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1500.0       | false    |
      | 20260101  | Buy Down Fee              | 900.0  | 0.0       | 900.0    | 0.0  | 0.0       | 0.0          | false    |
      | 20260101  | Buy Down Fee Amortization | 10.0   | 0.0       | 10.0     | 0.0  | 0.0       | 0.0          | false    |
      | 20260102  | Accrual                   | 0.28   | 0.0       | 0.28     | 0.0  | 0.0       | 0.0          | false    |
      | 20260102  | Buy Down Fee Amortization | 10.0   | 0.0       | 10.0     | 0.0  | 0.0       | 0.0          | false    |
      | 20260103  | Accrual                   | 0.28   | 0.0       | 0.28     | 0.0  | 0.0       | 0.0          | false    |
      | 20260103  | Buy Down Fee Amortization | 10.0   | 0.0       | 10.0     | 0.0  | 0.0       | 0.0          | false    |
      | 20260104  | Accrual                   | 0.29   | 0.0       | 0.29     | 0.0  | 0.0       | 0.0          | false    |
      | 20260104  | Buy Down Fee Amortization | 10.0   | 0.0       | 10.0     | 0.0  | 0.0       | 0.0          | false    |
      | 20260105  | Accrual                   | 0.28   | 0.0       | 0.28     | 0.0  | 0.0       | 0.0          | false    |
      | 20260105  | Buy Down Fee Amortization | 10.0   | 0.0       | 10.0     | 0.0  | 0.0       | 0.0          | false    |
      | 20260106  | Accrual                   | 0.28   | 0.0       | 0.28     | 0.0  | 0.0       | 0.0          | false    |
      | 20260106  | Buy Down Fee Amortization | 10.0   | 0.0       | 10.0     | 0.0  | 0.0       | 0.0          | false    |
      | 20260107  | Accrual                   | 0.28   | 0.0       | 0.28     | 0.0  | 0.0       | 0.0          | false    |
      | 20260107  | Buy Down Fee Amortization | 10.0   | 0.0       | 10.0     | 0.0  | 0.0       | 0.0          | false    |
      | 20260108  | Accrual                   | 0.29   | 0.0       | 0.29     | 0.0  | 0.0       | 0.0          | false    |
      | 20260108  | Buy Down Fee Amortization | 10.0   | 0.0       | 10.0     | 0.0  | 0.0       | 0.0          | false    |
      | 20260109  | Accrual                   | 0.28   | 0.0       | 0.28     | 0.0  | 0.0       | 0.0          | false    |
      | 20260109  | Buy Down Fee Amortization | 10.0   | 0.0       | 10.0     | 0.0  | 0.0       | 0.0          | false    |
      | 20260110  | Accrual                   | 0.28   | 0.0       | 0.28     | 0.0  | 0.0       | 0.0          | false    |
      | 20260110  | Buy Down Fee Amortization | 10.0   | 0.0       | 10.0     | 0.0  | 0.0       | 0.0          | false    |
      | 20260111  | Accrual                   | 0.28   | 0.0       | 0.28     | 0.0  | 0.0       | 0.0          | false    |
      | 20260111  | Buy Down Fee Amortization | 10.0   | 0.0       | 10.0     | 0.0  | 0.0       | 0.0          | false    |
      | 20260112  | Accrual                   | 0.28   | 0.0       | 0.28     | 0.0  | 0.0       | 0.0          | false    |
      | 20260112  | Buy Down Fee Amortization | 10.0   | 0.0       | 10.0     | 0.0  | 0.0       | 0.0          | false    |
      | 20260113  | Accrual                   | 0.29   | 0.0       | 0.29     | 0.0  | 0.0       | 0.0          | false    |
      | 20260113  | Buy Down Fee Amortization | 10.0   | 0.0       | 10.0     | 0.0  | 0.0       | 0.0          | false    |
      | 20260114  | Accrual                   | 0.28   | 0.0       | 0.28     | 0.0  | 0.0       | 0.0          | false    |
      | 20260114  | Buy Down Fee Amortization | 10.0   | 0.0       | 10.0     | 0.0  | 0.0       | 0.0          | false    |

    When Admin sets the business date to "20260116"
    When Admin runs inline COB job for Loan
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type          | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20260101  | Disbursement              | 1500.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1500.0       | false    |
      | 20260101  | Buy Down Fee              | 900.0  | 0.0       | 900.0    | 0.0  | 0.0       | 0.0          | false    |
      | 20260101  | Buy Down Fee Amortization | 10.0   | 0.0       | 10.0     | 0.0  | 0.0       | 0.0          | false    |
      | 20260102  | Accrual                   | 0.28   | 0.0       | 0.28     | 0.0  | 0.0       | 0.0          | false    |
      | 20260102  | Buy Down Fee Amortization | 10.0   | 0.0       | 10.0     | 0.0  | 0.0       | 0.0          | false    |
      | 20260103  | Accrual                   | 0.28   | 0.0       | 0.28     | 0.0  | 0.0       | 0.0          | false    |
      | 20260103  | Buy Down Fee Amortization | 10.0   | 0.0       | 10.0     | 0.0  | 0.0       | 0.0          | false    |
      | 20260104  | Accrual                   | 0.29   | 0.0       | 0.29     | 0.0  | 0.0       | 0.0          | false    |
      | 20260104  | Buy Down Fee Amortization | 10.0   | 0.0       | 10.0     | 0.0  | 0.0       | 0.0          | false    |
      | 20260105  | Accrual                   | 0.28   | 0.0       | 0.28     | 0.0  | 0.0       | 0.0          | false    |
      | 20260105  | Buy Down Fee Amortization | 10.0   | 0.0       | 10.0     | 0.0  | 0.0       | 0.0          | false    |
      | 20260106  | Accrual                   | 0.28   | 0.0       | 0.28     | 0.0  | 0.0       | 0.0          | false    |
      | 20260106  | Buy Down Fee Amortization | 10.0   | 0.0       | 10.0     | 0.0  | 0.0       | 0.0          | false    |
      | 20260107  | Accrual                   | 0.28   | 0.0       | 0.28     | 0.0  | 0.0       | 0.0          | false    |
      | 20260107  | Buy Down Fee Amortization | 10.0   | 0.0       | 10.0     | 0.0  | 0.0       | 0.0          | false    |
      | 20260108  | Accrual                   | 0.29   | 0.0       | 0.29     | 0.0  | 0.0       | 0.0          | false    |
      | 20260108  | Buy Down Fee Amortization | 10.0   | 0.0       | 10.0     | 0.0  | 0.0       | 0.0          | false    |
      | 20260109  | Accrual                   | 0.28   | 0.0       | 0.28     | 0.0  | 0.0       | 0.0          | false    |
      | 20260109  | Buy Down Fee Amortization | 10.0   | 0.0       | 10.0     | 0.0  | 0.0       | 0.0          | false    |
      | 20260110  | Accrual                   | 0.28   | 0.0       | 0.28     | 0.0  | 0.0       | 0.0          | false    |
      | 20260110  | Buy Down Fee Amortization | 10.0   | 0.0       | 10.0     | 0.0  | 0.0       | 0.0          | false    |
      | 20260111  | Accrual                   | 0.28   | 0.0       | 0.28     | 0.0  | 0.0       | 0.0          | false    |
      | 20260111  | Buy Down Fee Amortization | 10.0   | 0.0       | 10.0     | 0.0  | 0.0       | 0.0          | false    |
      | 20260112  | Accrual                   | 0.28   | 0.0       | 0.28     | 0.0  | 0.0       | 0.0          | false    |
      | 20260112  | Buy Down Fee Amortization | 10.0   | 0.0       | 10.0     | 0.0  | 0.0       | 0.0          | false    |
      | 20260113  | Accrual                   | 0.29   | 0.0       | 0.29     | 0.0  | 0.0       | 0.0          | false    |
      | 20260113  | Buy Down Fee Amortization | 10.0   | 0.0       | 10.0     | 0.0  | 0.0       | 0.0          | false    |
      | 20260114  | Accrual                   | 0.28   | 0.0       | 0.28     | 0.0  | 0.0       | 0.0          | false    |
      | 20260114  | Buy Down Fee Amortization | 10.0   | 0.0       | 10.0     | 0.0  | 0.0       | 0.0          | false    |
      | 20260115  | Accrual                   | 0.28   | 0.0       | 0.28     | 0.0  | 0.0       | 0.0          | false    |
      | 20260115  | Buy Down Fee Amortization | 10.0   | 0.0       | 10.0     | 0.0  | 0.0       | 0.0          | false    |
      | 20260115  | Buy Down Fee Amortization | 750.0  | 0.0       | 750.0    | 0.0  | 0.0       | 0.0          | false    |

    And Loan Transactions tab has a "BUY_DOWN_FEE_AMORTIZATION" transaction with date "20260115" which has the following Journal entries:
      | Type      | Account code | Account name                | Debit | Credit |
      | INCOME    | 450281       | Income From Buy Down        |       | 750.0  |
      | LIABILITY | 145024       | Deferred Capitalized Income | 750.0 |        |
      | INCOME    | 450281       | Income From Buy Down        |       | 10.0   |
      | LIABILITY | 145024       | Deferred Capitalized Income | 10.0  |        |

    When Admin sets the business date to "20260117"
    When Admin runs inline COB job for Loan
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type          | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20260101  | Disbursement              | 1500.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1500.0       | false    |
      | 20260101  | Buy Down Fee              | 900.0  | 0.0       | 900.0    | 0.0  | 0.0       | 0.0          | false    |
      | 20260101  | Buy Down Fee Amortization | 10.0   | 0.0       | 10.0     | 0.0  | 0.0       | 0.0          | false    |
      | 20260102  | Accrual                   | 0.28   | 0.0       | 0.28     | 0.0  | 0.0       | 0.0          | false    |
      | 20260102  | Buy Down Fee Amortization | 10.0   | 0.0       | 10.0     | 0.0  | 0.0       | 0.0          | false    |
      | 20260103  | Accrual                   | 0.28   | 0.0       | 0.28     | 0.0  | 0.0       | 0.0          | false    |
      | 20260103  | Buy Down Fee Amortization | 10.0   | 0.0       | 10.0     | 0.0  | 0.0       | 0.0          | false    |
      | 20260104  | Accrual                   | 0.29   | 0.0       | 0.29     | 0.0  | 0.0       | 0.0          | false    |
      | 20260104  | Buy Down Fee Amortization | 10.0   | 0.0       | 10.0     | 0.0  | 0.0       | 0.0          | false    |
      | 20260105  | Accrual                   | 0.28   | 0.0       | 0.28     | 0.0  | 0.0       | 0.0          | false    |
      | 20260105  | Buy Down Fee Amortization | 10.0   | 0.0       | 10.0     | 0.0  | 0.0       | 0.0          | false    |
      | 20260106  | Accrual                   | 0.28   | 0.0       | 0.28     | 0.0  | 0.0       | 0.0          | false    |
      | 20260106  | Buy Down Fee Amortization | 10.0   | 0.0       | 10.0     | 0.0  | 0.0       | 0.0          | false    |
      | 20260107  | Accrual                   | 0.28   | 0.0       | 0.28     | 0.0  | 0.0       | 0.0          | false    |
      | 20260107  | Buy Down Fee Amortization | 10.0   | 0.0       | 10.0     | 0.0  | 0.0       | 0.0          | false    |
      | 20260108  | Accrual                   | 0.29   | 0.0       | 0.29     | 0.0  | 0.0       | 0.0          | false    |
      | 20260108  | Buy Down Fee Amortization | 10.0   | 0.0       | 10.0     | 0.0  | 0.0       | 0.0          | false    |
      | 20260109  | Accrual                   | 0.28   | 0.0       | 0.28     | 0.0  | 0.0       | 0.0          | false    |
      | 20260109  | Buy Down Fee Amortization | 10.0   | 0.0       | 10.0     | 0.0  | 0.0       | 0.0          | false    |
      | 20260110  | Accrual                   | 0.28   | 0.0       | 0.28     | 0.0  | 0.0       | 0.0          | false    |
      | 20260110  | Buy Down Fee Amortization | 10.0   | 0.0       | 10.0     | 0.0  | 0.0       | 0.0          | false    |
      | 20260111  | Accrual                   | 0.28   | 0.0       | 0.28     | 0.0  | 0.0       | 0.0          | false    |
      | 20260111  | Buy Down Fee Amortization | 10.0   | 0.0       | 10.0     | 0.0  | 0.0       | 0.0          | false    |
      | 20260112  | Accrual                   | 0.28   | 0.0       | 0.28     | 0.0  | 0.0       | 0.0          | false    |
      | 20260112  | Buy Down Fee Amortization | 10.0   | 0.0       | 10.0     | 0.0  | 0.0       | 0.0          | false    |
      | 20260113  | Accrual                   | 0.29   | 0.0       | 0.29     | 0.0  | 0.0       | 0.0          | false    |
      | 20260113  | Buy Down Fee Amortization | 10.0   | 0.0       | 10.0     | 0.0  | 0.0       | 0.0          | false    |
      | 20260114  | Accrual                   | 0.28   | 0.0       | 0.28     | 0.0  | 0.0       | 0.0          | false    |
      | 20260114  | Buy Down Fee Amortization | 10.0   | 0.0       | 10.0     | 0.0  | 0.0       | 0.0          | false    |
      | 20260115  | Accrual                   | 0.28   | 0.0       | 0.28     | 0.0  | 0.0       | 0.0          | false    |
      | 20260115  | Buy Down Fee Amortization | 10.0   | 0.0       | 10.0     | 0.0  | 0.0       | 0.0          | false    |
      | 20260115  | Buy Down Fee Amortization | 750.0  | 0.0       | 750.0    | 0.0  | 0.0       | 0.0          | false    |
      | 20260116  | Accrual                   | 0.28   | 0.0       | 0.28     | 0.0  | 0.0       | 0.0          | false    |
    When Admin makes asset externalization request by Loan ID with unique ownerExternalId, system-generated transferExternalId and the following data:
      | Transaction type | settlementDate | purchasePriceRatio |
      | buyback          | 2026-01-20     |                    |

    When Admin sets the business date to "20260121"
    When Admin runs inline COB job for Loan
    When Admin makes asset externalization request by Loan ID with unique ownerExternalId, system-generated transferExternalId and the following data:
      | Transaction type | settlementDate | purchasePriceRatio |
      | sale             | 2026-01-25     | 1                  |
    When Admin sets the business date to "20260126"
    When Admin runs inline COB job for Loan
    And Loan Transactions tab has the following data:
      | Transaction date | Transaction Type          | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20260101  | Disbursement              | 1500.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1500.0       | false    |
      | 20260101  | Buy Down Fee              | 900.0  | 0.0       | 900.0    | 0.0  | 0.0       | 0.0          | false    |
      | 20260101  | Buy Down Fee Amortization | 10.0   | 0.0       | 10.0     | 0.0  | 0.0       | 0.0          | false    |
      | 20260102  | Accrual                   | 0.28   | 0.0       | 0.28     | 0.0  | 0.0       | 0.0          | false    |
      | 20260102  | Buy Down Fee Amortization | 10.0   | 0.0       | 10.0     | 0.0  | 0.0       | 0.0          | false    |
      | 20260103  | Accrual                   | 0.28   | 0.0       | 0.28     | 0.0  | 0.0       | 0.0          | false    |
      | 20260103  | Buy Down Fee Amortization | 10.0   | 0.0       | 10.0     | 0.0  | 0.0       | 0.0          | false    |
      | 20260104  | Accrual                   | 0.29   | 0.0       | 0.29     | 0.0  | 0.0       | 0.0          | false    |
      | 20260104  | Buy Down Fee Amortization | 10.0   | 0.0       | 10.0     | 0.0  | 0.0       | 0.0          | false    |
      | 20260105  | Accrual                   | 0.28   | 0.0       | 0.28     | 0.0  | 0.0       | 0.0          | false    |
      | 20260105  | Buy Down Fee Amortization | 10.0   | 0.0       | 10.0     | 0.0  | 0.0       | 0.0          | false    |
      | 20260106  | Accrual                   | 0.28   | 0.0       | 0.28     | 0.0  | 0.0       | 0.0          | false    |
      | 20260106  | Buy Down Fee Amortization | 10.0   | 0.0       | 10.0     | 0.0  | 0.0       | 0.0          | false    |
      | 20260107  | Accrual                   | 0.28   | 0.0       | 0.28     | 0.0  | 0.0       | 0.0          | false    |
      | 20260107  | Buy Down Fee Amortization | 10.0   | 0.0       | 10.0     | 0.0  | 0.0       | 0.0          | false    |
      | 20260108  | Accrual                   | 0.29   | 0.0       | 0.29     | 0.0  | 0.0       | 0.0          | false    |
      | 20260108  | Buy Down Fee Amortization | 10.0   | 0.0       | 10.0     | 0.0  | 0.0       | 0.0          | false    |
      | 20260109  | Accrual                   | 0.28   | 0.0       | 0.28     | 0.0  | 0.0       | 0.0          | false    |
      | 20260109  | Buy Down Fee Amortization | 10.0   | 0.0       | 10.0     | 0.0  | 0.0       | 0.0          | false    |
      | 20260110  | Accrual                   | 0.28   | 0.0       | 0.28     | 0.0  | 0.0       | 0.0          | false    |
      | 20260110  | Buy Down Fee Amortization | 10.0   | 0.0       | 10.0     | 0.0  | 0.0       | 0.0          | false    |
      | 20260111  | Accrual                   | 0.28   | 0.0       | 0.28     | 0.0  | 0.0       | 0.0          | false    |
      | 20260111  | Buy Down Fee Amortization | 10.0   | 0.0       | 10.0     | 0.0  | 0.0       | 0.0          | false    |
      | 20260112  | Accrual                   | 0.28   | 0.0       | 0.28     | 0.0  | 0.0       | 0.0          | false    |
      | 20260112  | Buy Down Fee Amortization | 10.0   | 0.0       | 10.0     | 0.0  | 0.0       | 0.0          | false    |
      | 20260113  | Accrual                   | 0.29   | 0.0       | 0.29     | 0.0  | 0.0       | 0.0          | false    |
      | 20260113  | Buy Down Fee Amortization | 10.0   | 0.0       | 10.0     | 0.0  | 0.0       | 0.0          | false    |
      | 20260114  | Accrual                   | 0.28   | 0.0       | 0.28     | 0.0  | 0.0       | 0.0          | false    |
      | 20260114  | Buy Down Fee Amortization | 10.0   | 0.0       | 10.0     | 0.0  | 0.0       | 0.0          | false    |
      | 20260115  | Accrual                   | 0.28   | 0.0       | 0.28     | 0.0  | 0.0       | 0.0          | false    |
      | 20260115  | Buy Down Fee Amortization | 10.0   | 0.0       | 10.0     | 0.0  | 0.0       | 0.0          | false    |
      | 20260115  | Buy Down Fee Amortization | 750.0  | 0.0       | 750.0    | 0.0  | 0.0       | 0.0          | false    |
      | 20260116  | Accrual                   | 0.28   | 0.0       | 0.28     | 0.0  | 0.0       | 0.0          | false    |
      | 20260117  | Accrual                   | 0.29   | 0.0       | 0.29     | 0.0  | 0.0       | 0.0          | false    |
      | 20260118  | Accrual                   | 0.28   | 0.0       | 0.28     | 0.0  | 0.0       | 0.0          | false    |
      | 20260119  | Accrual                   | 0.28   | 0.0       | 0.28     | 0.0  | 0.0       | 0.0          | false    |
      | 20260120  | Accrual                   | 0.28   | 0.0       | 0.28     | 0.0  | 0.0       | 0.0          | false    |
      | 20260121  | Accrual                   | 0.29   | 0.0       | 0.29     | 0.0  | 0.0       | 0.0          | false    |
      | 20260122  | Accrual                   | 0.28   | 0.0       | 0.28     | 0.0  | 0.0       | 0.0          | false    |
      | 20260123  | Accrual                   | 0.28   | 0.0       | 0.28     | 0.0  | 0.0       | 0.0          | false    |
      | 20260124  | Accrual                   | 0.28   | 0.0       | 0.28     | 0.0  | 0.0       | 0.0          | false    |
      | 20260125  | Accrual                   | 0.28   | 0.0       | 0.28     | 0.0  | 0.0       | 0.0          | false    |

    When Loan Pay-off is made on "20260126" with transfer external owner
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C85406
  Scenario: Verify buy down fee partial adjustment after full amortization via investor sale - UC1: results in correct amortization adjustment amount
    When Admin sets the business date to "20260701"
    And Admin creates a client with random data
    And Admin creates a fully customized loan with the following data:
      | LoanProduct                                              | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_PROGRESSIVE_ADVANCED_PAYMENT_ALLOCATION_BUYDOWN_FEES | 20260701      | 1000           | 7                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 3                 | MONTHS                | 1              | MONTHS                 | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20260701" with "1000" amount and expected disbursement date on "20260701"
    And Admin successfully disburse the loan on "20260701" with "1000" EUR transaction amount
    And Admin adds buy down fee with "AUTOPAY" payment type to the loan on "20260701" with "50" EUR transaction amount
    When Admin makes asset externalization request by Loan ID with unique ownerExternalId, system-generated transferExternalId and the following data:
      | Transaction type | settlementDate | purchasePriceRatio |
      | sale             | 2026-07-01     | 1                  |
    Then Asset externalization response has the correct Loan ID, transferExternalId
    And Buy down fee contains the following data:
      | Date         | Fee Amount | Amortized Amount | Not Yet Amortized Amount | Adjusted Amount | Charged Off Amount |
      | 20260701 | 50.0       | 0.0              | 50.0                     | 0.0             | 0.0                |
    When Admin sets the business date to "20260702"
    And Admin runs inline COB job for Loan
    Then Fetching Asset externalization details by loan id gives numberOfElements: 2 with correct ownerExternalId and the following data:
      | settlementDate | purchasePriceRatio | status  | effectiveFrom | effectiveTo | Transaction type |
      | 2026-07-01     | 1                  | PENDING | 2026-07-01    | 2026-07-01  | SALE             |
      | 2026-07-01     | 1                  | ACTIVE  | 2026-07-02    | 9999-12-31  | SALE             |
    And Loan Transactions tab has the following data without accruals:
      | Transaction date | Transaction Type          | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20260701     | Disbursement              | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       | false    |
      | 20260701     | Buy Down Fee              | 50.0   | 0.0       | 50.0     | 0.0  | 0.0       | 0.0          | false    |
      | 20260701     | Buy Down Fee Amortization | 0.54   | 0.0       | 0.54     | 0.0  | 0.0       | 0.0          | false    |
      | 20260701     | Buy Down Fee Amortization | 49.46  | 0.0       | 49.46    | 0.0  | 0.0       | 0.0          | false    |
    And Buy down fee contains the following data:
      | Date         | Fee Amount | Amortized Amount | Not Yet Amortized Amount | Adjusted Amount | Charged Off Amount |
      | 20260701 | 50.0       | 50.0             | 0.0                      | 0.0             | 0.0                |
    And LoanBuyDownFeeAmortizationTransactionCreatedBusinessEvent is created on "20260701"
    And Admin adds buy down fee adjustment with "AUTOPAY" payment type to the loan on "20260702" with "20" EUR transaction amount
    And Loan Transactions tab has the following data without accruals:
      | Transaction date | Transaction Type          | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20260701     | Disbursement              | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       | false    |
      | 20260701     | Buy Down Fee              | 50.0   | 0.0       | 50.0     | 0.0  | 0.0       | 0.0          | false    |
      | 20260701     | Buy Down Fee Amortization | 0.54   | 0.0       | 0.54     | 0.0  | 0.0       | 0.0          | false    |
      | 20260701     | Buy Down Fee Amortization | 49.46  | 0.0       | 49.46    | 0.0  | 0.0       | 0.0          | false    |
      | 20260702     | Buy Down Fee Adjustment   | 20.0   | 0.0       | 20.0     | 0.0  | 0.0       | 0.0          | false    |
    And Buy down fee contains the following data:
      | Date         | Fee Amount | Amortized Amount | Not Yet Amortized Amount | Adjusted Amount | Charged Off Amount |
      | 20260701 | 50.0       | 30.0             | 0.0                      | 20.0            | 0.0                |
    And LoanBuyDownFeeAdjustmentTransactionCreatedBusinessEvent is created on "20260702"
    When Admin sets the business date to "20260703"
    And Admin runs inline COB job for Loan
    Then Loan Transactions tab has the following data without accruals:
      | Transaction date | Transaction Type                     | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20260701     | Disbursement                         | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       | false    |
      | 20260701     | Buy Down Fee                         | 50.0   | 0.0       | 50.0     | 0.0  | 0.0       | 0.0          | false    |
      | 20260701     | Buy Down Fee Amortization            | 0.54   | 0.0       | 0.54     | 0.0  | 0.0       | 0.0          | false    |
      | 20260701     | Buy Down Fee Amortization            | 49.46  | 0.0       | 49.46    | 0.0  | 0.0       | 0.0          | false    |
      | 20260702     | Buy Down Fee Adjustment              | 20.0   | 0.0       | 20.0     | 0.0  | 0.0       | 0.0          | false    |
      | 20260702     | Buy Down Fee Amortization Adjustment | 20.0   | 0.0       | 20.0     | 0.0  | 0.0       | 0.0          | false    |
    And Buy down fee contains the following data:
      | Date         | Fee Amount | Amortized Amount | Not Yet Amortized Amount | Adjusted Amount | Charged Off Amount |
      | 20260701 | 50.0       | 30.0             | 0.0                      | 20.0            | 0.0                |
    And LoanBuyDownFeeAmortizationAdjustmentTransactionCreatedBusinessEvent is created on "20260702"
#    --- Close loan ---
    When Loan Pay-off is made on "20260702" with transfer external owner
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C85407
  Scenario: Verify buy down fee partial adjustment after full amortization via investor sale - UC2: with two buydown fees results in correct amortization adjustment amount
    When Admin sets the business date to "20260701"
    And Admin creates a client with random data
    And Admin creates a fully customized loan with the following data:
      | LoanProduct                                              | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_PROGRESSIVE_ADVANCED_PAYMENT_ALLOCATION_BUYDOWN_FEES | 20260701      | 1000           | 7                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 3                 | MONTHS                | 1              | MONTHS                 | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20260701" with "1000" amount and expected disbursement date on "20260701"
    And Admin successfully disburse the loan on "20260701" with "1000" EUR transaction amount
    And Admin adds buy down fee with "AUTOPAY" payment type to the loan on "20260701" with "50" EUR transaction amount
    And Admin adds buy down fee with "AUTOPAY" payment type to the loan on "20260701" with "30" EUR transaction amount
    When Admin makes asset externalization request by Loan ID with unique ownerExternalId, system-generated transferExternalId and the following data:
      | Transaction type | settlementDate | purchasePriceRatio |
      | sale             | 2026-07-01     | 1                  |
    Then Asset externalization response has the correct Loan ID, transferExternalId
    And Buy down fee contains the following data:
      | Date         | Fee Amount | Amortized Amount | Not Yet Amortized Amount | Adjusted Amount | Charged Off Amount |
      | 20260701 | 50.0       | 0.0              | 50.0                     | 0.0             | 0.0                |
      | 20260701 | 30.0       | 0.0              | 30.0                     | 0.0             | 0.0                |
    When Admin sets the business date to "20260702"
    And Admin runs inline COB job for Loan
    Then Fetching Asset externalization details by loan id gives numberOfElements: 2 with correct ownerExternalId and the following data:
      | settlementDate | purchasePriceRatio | status  | effectiveFrom | effectiveTo | Transaction type |
      | 2026-07-01     | 1                  | PENDING | 2026-07-01    | 2026-07-01  | SALE             |
      | 2026-07-01     | 1                  | ACTIVE  | 2026-07-02    | 9999-12-31  | SALE             |
    And Loan Transactions tab has the following data without accruals:
      | Transaction date | Transaction Type          | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20260701     | Disbursement              | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       | false    |
      | 20260701     | Buy Down Fee              | 50.0   | 0.0       | 50.0     | 0.0  | 0.0       | 0.0          | false    |
      | 20260701     | Buy Down Fee              | 30.0   | 0.0       | 30.0     | 0.0  | 0.0       | 0.0          | false    |
      | 20260701     | Buy Down Fee Amortization | 0.87   | 0.0       | 0.87     | 0.0  | 0.0       | 0.0          | false    |
      | 20260701     | Buy Down Fee Amortization | 79.13  | 0.0       | 79.13    | 0.0  | 0.0       | 0.0          | false    |
    And Buy down fee contains the following data:
      | Date         | Fee Amount | Amortized Amount | Not Yet Amortized Amount | Adjusted Amount | Charged Off Amount |
      | 20260701 | 50.0       | 50.0             | 0.0                      | 0.0             | 0.0                |
      | 20260701 | 30.0       | 30.0             | 0.0                      | 0.0             | 0.0                |
    And LoanBuyDownFeeAmortizationTransactionCreatedBusinessEvent is created on "20260701"
    And Admin adds buy down fee adjustment with "AUTOPAY" payment type to the loan on "20260702" with "20" EUR transaction amount
    And Loan Transactions tab has the following data without accruals:
      | Transaction date | Transaction Type          | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20260701     | Disbursement              | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       | false    |
      | 20260701     | Buy Down Fee              | 50.0   | 0.0       | 50.0     | 0.0  | 0.0       | 0.0          | false    |
      | 20260701     | Buy Down Fee              | 30.0   | 0.0       | 30.0     | 0.0  | 0.0       | 0.0          | false    |
      | 20260701     | Buy Down Fee Amortization | 0.87   | 0.0       | 0.87     | 0.0  | 0.0       | 0.0          | false    |
      | 20260701     | Buy Down Fee Amortization | 79.13  | 0.0       | 79.13    | 0.0  | 0.0       | 0.0          | false    |
      | 20260702     | Buy Down Fee Adjustment   | 20.0   | 0.0       | 20.0     | 0.0  | 0.0       | 0.0          | false    |
    And Buy down fee contains the following data:
      | Date         | Fee Amount | Amortized Amount | Not Yet Amortized Amount | Adjusted Amount | Charged Off Amount |
      | 20260701 | 50.0       | 30.0             | 0.0                      | 20.0            | 0.0                |
      | 20260701 | 30.0       | 30.0             | 0.0                      | 0.0             | 0.0                |
    And LoanBuyDownFeeAdjustmentTransactionCreatedBusinessEvent is created on "20260702"
    When Admin sets the business date to "20260703"
    And Admin runs inline COB job for Loan
    Then Loan Transactions tab has the following data without accruals:
      | Transaction date | Transaction Type                     | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20260701     | Disbursement                         | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       | false    |
      | 20260701     | Buy Down Fee                         | 50.0   | 0.0       | 50.0     | 0.0  | 0.0       | 0.0          | false    |
      | 20260701     | Buy Down Fee                         | 30.0   | 0.0       | 30.0     | 0.0  | 0.0       | 0.0          | false    |
      | 20260701     | Buy Down Fee Amortization            | 0.87   | 0.0       | 0.87     | 0.0  | 0.0       | 0.0          | false    |
      | 20260701     | Buy Down Fee Amortization            | 79.13  | 0.0       | 79.13    | 0.0  | 0.0       | 0.0          | false    |
      | 20260702     | Buy Down Fee Adjustment              | 20.0   | 0.0       | 20.0     | 0.0  | 0.0       | 0.0          | false    |
      | 20260702     | Buy Down Fee Amortization Adjustment | 20.0   | 0.0       | 20.0     | 0.0  | 0.0       | 0.0          | false    |
    And Buy down fee contains the following data:
      | Date         | Fee Amount | Amortized Amount | Not Yet Amortized Amount | Adjusted Amount | Charged Off Amount |
      | 20260701 | 50.0       | 30.0             | 0.0                      | 20.0            | 0.0                |
      | 20260701 | 30.0       | 30.0             | 0.0                      | 0.0             | 0.0                |
    And LoanBuyDownFeeAmortizationAdjustmentTransactionCreatedBusinessEvent is created on "20260702"
    #    --- Close loan ---
    When Loan Pay-off is made on "20260702" with transfer external owner
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C85408
  Scenario: Verify buy down fee partial adjustment after full amortization via investor sale - UC3: second daily COB after buy down fee adjustment post investor sale does not duplicate amortization adjustment
    When Admin sets the business date to "20260801"
    And Admin creates a client with random data
    And Admin creates a fully customized loan with the following data:
      | LoanProduct                                              | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_PROGRESSIVE_ADVANCED_PAYMENT_ALLOCATION_BUYDOWN_FEES | 20260801    | 1000           | 7                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 3                 | MONTHS                | 1              | MONTHS                 | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20260801" with "1000" amount and expected disbursement date on "20260801"
    And Admin successfully disburse the loan on "20260801" with "1000" EUR transaction amount
    And Admin adds buy down fee with "AUTOPAY" payment type to the loan on "20260801" with "50" EUR transaction amount
    When Admin makes asset externalization request by Loan ID with unique ownerExternalId, system-generated transferExternalId and the following data:
      | Transaction type | settlementDate | purchasePriceRatio |
      | sale             | 2026-08-01     | 1                  |
    When Admin sets the business date to "20260802"
    And Admin runs inline COB job for Loan
    And Admin adds buy down fee adjustment with "AUTOPAY" payment type to the loan on "20260802" with "20" EUR transaction amount
    When Admin sets the business date to "20260803"
    And Admin runs inline COB job for Loan
    And Loan Transactions tab has the following data without accruals:
      | Transaction date | Transaction Type                     | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20260801   | Disbursement                         | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       | false    |
      | 20260801   | Buy Down Fee                         | 50.0   | 0.0       | 50.0     | 0.0  | 0.0       | 0.0          | false    |
      | 20260801   | Buy Down Fee Amortization            | 0.54   | 0.0       | 0.54     | 0.0  | 0.0       | 0.0          | false    |
      | 20260801   | Buy Down Fee Amortization            | 49.46  | 0.0       | 49.46    | 0.0  | 0.0       | 0.0          | false    |
      | 20260802   | Buy Down Fee Adjustment              | 20.0   | 0.0       | 20.0     | 0.0  | 0.0       | 0.0          | false    |
      | 20260802   | Buy Down Fee Amortization Adjustment | 20.0   | 0.0       | 20.0     | 0.0  | 0.0       | 0.0          | false    |
    When Admin sets the business date to "20260804"
    And Admin runs inline COB job for Loan
    Then Loan Transactions tab has the following data without accruals:
      | Transaction date | Transaction Type                     | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20260801   | Disbursement                         | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       | false    |
      | 20260801   | Buy Down Fee                         | 50.0   | 0.0       | 50.0     | 0.0  | 0.0       | 0.0          | false    |
      | 20260801   | Buy Down Fee Amortization            | 0.54   | 0.0       | 0.54     | 0.0  | 0.0       | 0.0          | false    |
      | 20260801   | Buy Down Fee Amortization            | 49.46  | 0.0       | 49.46    | 0.0  | 0.0       | 0.0          | false    |
      | 20260802   | Buy Down Fee Adjustment              | 20.0   | 0.0       | 20.0     | 0.0  | 0.0       | 0.0          | false    |
      | 20260802   | Buy Down Fee Amortization Adjustment | 20.0   | 0.0       | 20.0     | 0.0  | 0.0       | 0.0          | false    |
    When Loan Pay-off is made on "20260804" with transfer external owner
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C85409
  Scenario: Verify capitalized income partial adjustment after full amortization via investor sale - UC1: results in correct amortization adjustment amount
    When Admin sets the business date to "20260701"
    And Admin creates a client with random data
    And Admin creates a fully customized loan with the following data:
      | LoanProduct                                                    | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_EMI_360_30_INTEREST_RECALC_DAILY_CAPITALIZED_INCOME | 20260701      | 1100           | 7                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 3                 | MONTHS                | 1              | MONTHS                 | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20260701" with "1100" amount and expected disbursement date on "20260701"
    And Admin successfully disburse the loan on "20260701" with "1000" EUR transaction amount
    And Admin adds capitalized income with "AUTOPAY" payment type to the loan on "20260701" with "50" EUR transaction amount
    When Admin makes asset externalization request by Loan ID with unique ownerExternalId, system-generated transferExternalId and the following data:
      | Transaction type | settlementDate | purchasePriceRatio |
      | sale             | 2026-07-01     | 1                  |
    Then Asset externalization response has the correct Loan ID, transferExternalId
    And Deferred Capitalized Income contains the following data:
      | Amount | Amortized Amount | Unrecognized Amount | Adjusted Amount | Charged Off Amount |
      | 50.0   | 0.0              | 50.0                | 0.0             | 0.0                |
    When Admin sets the business date to "20260702"
    And Admin runs inline COB job for Loan
    Then Fetching Asset externalization details by loan id gives numberOfElements: 2 with correct ownerExternalId and the following data:
      | settlementDate | purchasePriceRatio | status  | effectiveFrom | effectiveTo | Transaction type |
      | 2026-07-01     | 1                  | PENDING | 2026-07-01    | 2026-07-01  | SALE             |
      | 2026-07-01     | 1                  | ACTIVE  | 2026-07-02    | 9999-12-31  | SALE             |
    And Loan Transactions tab has the following data without accruals:
      | Transaction date | Transaction Type                | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20260701     | Disbursement                    | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       | false    |
      | 20260701     | Capitalized Income              | 50.0   | 50.0      | 0.0      | 0.0  | 0.0       | 1050.0       | false    |
      | 20260701     | Capitalized Income Amortization | 0.54   | 0.0       | 0.54     | 0.0  | 0.0       | 0.0          | false    |
      | 20260701     | Capitalized Income Amortization | 49.46  | 0.0       | 49.46    | 0.0  | 0.0       | 0.0          | false    |
    And Deferred Capitalized Income contains the following data:
      | Amount | Amortized Amount | Unrecognized Amount | Adjusted Amount | Charged Off Amount |
      | 50.0   | 50.0             | 0.0                 | 0.0             | 0.0                |
    And LoanCapitalizedIncomeAmortizationTransactionCreatedBusinessEvent is raised on "20260701"
    And Admin adds capitalized income adjustment with "AUTOPAY" payment type to the loan on "20260702" with "20" EUR transaction amount
    And Loan Transactions tab has the following data without accruals:
      | Transaction date | Transaction Type                | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20260701     | Disbursement                    | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       | false    |
      | 20260701     | Capitalized Income              | 50.0   | 50.0      | 0.0      | 0.0  | 0.0       | 1050.0       | false    |
      | 20260701     | Capitalized Income Amortization | 0.54   | 0.0       | 0.54     | 0.0  | 0.0       | 0.0          | false    |
      | 20260701     | Capitalized Income Amortization | 49.46  | 0.0       | 49.46    | 0.0  | 0.0       | 0.0          | false    |
      | 20260702     | Capitalized Income Adjustment   | 20.0   | 20.0      | 0.0      | 0.0  | 0.0       | 1030.0       | false    |
    And Deferred Capitalized Income contains the following data:
      | Amount | Amortized Amount | Unrecognized Amount | Adjusted Amount | Charged Off Amount |
      | 50.0   | 30.0             | 0.0                 | 20.0            | 0.0                |
    And LoanCapitalizedIncomeAdjustmentTransactionCreatedBusinessEvent is raised on "20260702"
    When Admin sets the business date to "20260703"
    And Admin runs inline COB job for Loan
    Then Loan Transactions tab has the following data without accruals:
      | Transaction date | Transaction Type                            | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20260701     | Disbursement                                | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       | false    |
      | 20260701     | Capitalized Income                          | 50.0   | 50.0      | 0.0      | 0.0  | 0.0       | 1050.0       | false    |
      | 20260701     | Capitalized Income Amortization             | 0.54   | 0.0       | 0.54     | 0.0  | 0.0       | 0.0          | false    |
      | 20260701     | Capitalized Income Amortization             | 49.46  | 0.0       | 49.46    | 0.0  | 0.0       | 0.0          | false    |
      | 20260702     | Capitalized Income Adjustment               | 20.0   | 20.0      | 0.0      | 0.0  | 0.0       | 1030.0       | false    |
      | 20260702     | Capitalized Income Amortization Adjustment  | 20.0   | 0.0       | 20.0     | 0.0  | 0.0       | 0.0          | false    |
    And Deferred Capitalized Income contains the following data:
      | Amount | Amortized Amount | Unrecognized Amount | Adjusted Amount | Charged Off Amount |
      | 50.0   | 30.0             | 0.0                 | 20.0            | 0.0                |
    And LoanCapitalizedIncomeAmortizationAdjustmentTransactionCreatedBusinessEvent is raised on "20260702"
#    --- Close loan ---
    When Loan Pay-off is made on "20260702" with transfer external owner
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C85410
  Scenario: Verify capitalized income partial adjustment after full amortization via investor sale - UC2: with two capitalized income transactions results in correct amortization adjustment amount
    When Admin sets the business date to "20260701"
    And Admin creates a client with random data
    And Admin creates a fully customized loan with the following data:
      | LoanProduct                                                    | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_EMI_360_30_INTEREST_RECALC_DAILY_CAPITALIZED_INCOME | 20260701      | 1100           | 7                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 3                 | MONTHS                | 1              | MONTHS                 | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20260701" with "1100" amount and expected disbursement date on "20260701"
    And Admin successfully disburse the loan on "20260701" with "1000" EUR transaction amount
    And Admin adds capitalized income with "AUTOPAY" payment type to the loan on "20260701" with "50" EUR transaction amount
    And Admin adds capitalized income with "AUTOPAY" payment type to the loan on "20260701" with "30" EUR transaction amount
    When Admin makes asset externalization request by Loan ID with unique ownerExternalId, system-generated transferExternalId and the following data:
      | Transaction type | settlementDate | purchasePriceRatio |
      | sale             | 2026-07-01     | 1                  |
    Then Asset externalization response has the correct Loan ID, transferExternalId
    And Deferred Capitalized Income contains the following data:
      | Amount | Amortized Amount | Unrecognized Amount | Adjusted Amount | Charged Off Amount |
      | 50.0   | 0.0              | 50.0                | 0.0             | 0.0                |
      | 30.0   | 0.0              | 30.0                | 0.0             | 0.0                |
    When Admin sets the business date to "20260702"
    And Admin runs inline COB job for Loan
    Then Fetching Asset externalization details by loan id gives numberOfElements: 2 with correct ownerExternalId and the following data:
      | settlementDate | purchasePriceRatio | status  | effectiveFrom | effectiveTo | Transaction type |
      | 2026-07-01     | 1                  | PENDING | 2026-07-01    | 2026-07-01  | SALE             |
      | 2026-07-01     | 1                  | ACTIVE  | 2026-07-02    | 9999-12-31  | SALE             |
    And Loan Transactions tab has the following data without accruals:
      | Transaction date | Transaction Type                | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20260701     | Disbursement                    | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       | false    |
      | 20260701     | Capitalized Income              | 50.0   | 50.0      | 0.0      | 0.0  | 0.0       | 1050.0       | false    |
      | 20260701     | Capitalized Income              | 30.0   | 30.0      | 0.0      | 0.0  | 0.0       | 1080.0       | false    |
      | 20260701     | Capitalized Income Amortization | 0.87   | 0.0       | 0.87     | 0.0  | 0.0       | 0.0          | false    |
      | 20260701     | Capitalized Income Amortization | 79.13  | 0.0       | 79.13    | 0.0  | 0.0       | 0.0          | false    |
    And Deferred Capitalized Income contains the following data:
      | Amount | Amortized Amount | Unrecognized Amount | Adjusted Amount | Charged Off Amount |
      | 50.0   | 50.0             | 0.0                 | 0.0             | 0.0                |
      | 30.0   | 30.0             | 0.0                 | 0.0             | 0.0                |
    And LoanCapitalizedIncomeAmortizationTransactionCreatedBusinessEvent is raised on "20260701"
    And Admin adds capitalized income adjustment with "AUTOPAY" payment type to the loan on "20260702" with "20" EUR transaction amount
    And Loan Transactions tab has the following data without accruals:
      | Transaction date | Transaction Type                | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20260701     | Disbursement                    | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       | false    |
      | 20260701     | Capitalized Income              | 50.0   | 50.0      | 0.0      | 0.0  | 0.0       | 1050.0       | false    |
      | 20260701     | Capitalized Income              | 30.0   | 30.0      | 0.0      | 0.0  | 0.0       | 1080.0       | false    |
      | 20260701     | Capitalized Income Amortization | 0.87   | 0.0       | 0.87     | 0.0  | 0.0       | 0.0          | false    |
      | 20260701     | Capitalized Income Amortization | 79.13  | 0.0       | 79.13    | 0.0  | 0.0       | 0.0          | false    |
      | 20260702     | Capitalized Income Adjustment   | 20.0   | 20.0      | 0.0      | 0.0  | 0.0       | 1060.0       | false    |
    And Deferred Capitalized Income contains the following data:
      | Amount | Amortized Amount | Unrecognized Amount | Adjusted Amount | Charged Off Amount |
      | 50.0   | 30.0             | 0.0                 | 20.0            | 0.0                |
      | 30.0   | 30.0             | 0.0                 | 0.0             | 0.0                |
    And LoanCapitalizedIncomeAdjustmentTransactionCreatedBusinessEvent is raised on "20260702"
    When Admin sets the business date to "20260703"
    And Admin runs inline COB job for Loan
    Then Loan Transactions tab has the following data without accruals:
      | Transaction date | Transaction Type                            | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20260701     | Disbursement                                | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       | false    |
      | 20260701     | Capitalized Income                          | 50.0   | 50.0      | 0.0      | 0.0  | 0.0       | 1050.0       | false    |
      | 20260701     | Capitalized Income                          | 30.0   | 30.0      | 0.0      | 0.0  | 0.0       | 1080.0       | false    |
      | 20260701     | Capitalized Income Amortization             | 0.87   | 0.0       | 0.87     | 0.0  | 0.0       | 0.0          | false    |
      | 20260701     | Capitalized Income Amortization             | 79.13  | 0.0       | 79.13    | 0.0  | 0.0       | 0.0          | false    |
      | 20260702     | Capitalized Income Adjustment               | 20.0   | 20.0      | 0.0      | 0.0  | 0.0       | 1060.0       | false    |
      | 20260702     | Capitalized Income Amortization Adjustment  | 20.0   | 0.0       | 20.0     | 0.0  | 0.0       | 0.0          | false    |
    And Deferred Capitalized Income contains the following data:
      | Amount | Amortized Amount | Unrecognized Amount | Adjusted Amount | Charged Off Amount |
      | 50.0   | 30.0             | 0.0                 | 20.0            | 0.0                |
      | 30.0   | 30.0             | 0.0                 | 0.0             | 0.0                |
    And LoanCapitalizedIncomeAmortizationAdjustmentTransactionCreatedBusinessEvent is raised on "20260702"
#    --- Close loan ---
    When Loan Pay-off is made on "20260702" with transfer external owner
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met

  @TestRailId:C85411
  Scenario: Verify capitalized income partial adjustment after full amortization via investor sale - UC3: second daily COB after capitalized income adjustment post investor sale does not duplicate amortization adjustment
    When Admin sets the business date to "20260801"
    And Admin creates a client with random data
    And Admin creates a fully customized loan with the following data:
      | LoanProduct                                                    | submitted on date | with Principal | ANNUAL interest rate % | interest type     | interest calculation period | amortization type  | loanTermFrequency | loanTermFrequencyType | repaymentEvery | repaymentFrequencyType | numberOfRepayments | graceOnPrincipalPayment | graceOnInterestPayment | interest free period | Payment strategy            |
      | LP2_ADV_PYMNT_INTEREST_DAILY_EMI_360_30_INTEREST_RECALC_DAILY_CAPITALIZED_INCOME | 20260801    | 1100           | 7                      | DECLINING_BALANCE | DAILY                       | EQUAL_INSTALLMENTS | 3                 | MONTHS                | 1              | MONTHS                 | 3                  | 0                       | 0                      | 0                    | ADVANCED_PAYMENT_ALLOCATION |
    And Admin successfully approves the loan on "20260801" with "1100" amount and expected disbursement date on "20260801"
    And Admin successfully disburse the loan on "20260801" with "1000" EUR transaction amount
    And Admin adds capitalized income with "AUTOPAY" payment type to the loan on "20260801" with "50" EUR transaction amount
    When Admin makes asset externalization request by Loan ID with unique ownerExternalId, system-generated transferExternalId and the following data:
      | Transaction type | settlementDate | purchasePriceRatio |
      | sale             | 2026-08-01     | 1                  |
    When Admin sets the business date to "20260802"
    And Admin runs inline COB job for Loan
    And Admin adds capitalized income adjustment with "AUTOPAY" payment type to the loan on "20260802" with "20" EUR transaction amount
    When Admin sets the business date to "20260803"
    And Admin runs inline COB job for Loan
    And Loan Transactions tab has the following data without accruals:
      | Transaction date | Transaction Type                            | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20260801   | Disbursement                                | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       | false    |
      | 20260801   | Capitalized Income                          | 50.0   | 50.0      | 0.0      | 0.0  | 0.0       | 1050.0       | false    |
      | 20260801   | Capitalized Income Amortization             | 0.54   | 0.0       | 0.54     | 0.0  | 0.0       | 0.0          | false    |
      | 20260801   | Capitalized Income Amortization             | 49.46  | 0.0       | 49.46    | 0.0  | 0.0       | 0.0          | false    |
      | 20260802   | Capitalized Income Adjustment               | 20.0   | 20.0      | 0.0      | 0.0  | 0.0       | 1030.0       | false    |
      | 20260802   | Capitalized Income Amortization Adjustment  | 20.0   | 0.0       | 20.0     | 0.0  | 0.0       | 0.0          | false    |
    When Admin sets the business date to "20260804"
    And Admin runs inline COB job for Loan
    Then Loan Transactions tab has the following data without accruals:
      | Transaction date | Transaction Type                            | Amount | Principal | Interest | Fees | Penalties | Loan Balance | Reverted |
      | 20260801   | Disbursement                                | 1000.0 | 0.0       | 0.0      | 0.0  | 0.0       | 1000.0       | false    |
      | 20260801   | Capitalized Income                          | 50.0   | 50.0      | 0.0      | 0.0  | 0.0       | 1050.0       | false    |
      | 20260801   | Capitalized Income Amortization             | 0.54   | 0.0       | 0.54     | 0.0  | 0.0       | 0.0          | false    |
      | 20260801   | Capitalized Income Amortization             | 49.46  | 0.0       | 49.46    | 0.0  | 0.0       | 0.0          | false    |
      | 20260802   | Capitalized Income Adjustment               | 20.0   | 20.0      | 0.0      | 0.0  | 0.0       | 1030.0       | false    |
      | 20260802   | Capitalized Income Amortization Adjustment  | 20.0   | 0.0       | 20.0     | 0.0  | 0.0       | 0.0          | false    |
    When Loan Pay-off is made on "20260804" with transfer external owner
    Then Loan is closed with zero outstanding balance and it's all installments have obligations met
