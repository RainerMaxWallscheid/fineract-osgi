# fineract-accounttransfer

Core residual peel — account transfers and standing instructions (ADR-022).

| Gradle project | Path | BSN | Role |
|----------------|------|-----|------|
| `fineract-accounttransfer-api` | `api/` | `org.apache.fineract.accounttransfer.api` | Ports, enums, shared DTOs, exceptions, API constants |
| `fineract-accounttransfer-impl` | `impl/` | `org.apache.fineract.accounttransfer.impl` | REST, handlers, validators, JDBC reads, SI job; Equinox DS `OSGI-INF/accounttransfer.xml` |
| `fineract-accounttransfer-test` | `test/` | `org.apache.fineract.accounttransfer.test` | Fragment-Host → impl |

### Residual / composition-root

Kernel residual in `fineract-core`: `PortfolioAccountType`, `PortfolioAccountData`, `AccountTransferData`,
`AccountTransfersReadPlatformService` (savings transaction DTO / `SavingsHelper` coupling).

Entity write path (`AccountTransfersWritePlatformService*`, associations/transfer entities, assemblers, funds-write adapter) stays in `fineract-progressive-loan-impl` (loan + savings coupling).

```bash
./gradlew :fineract-accounttransfer-api:jar :fineract-accounttransfer-impl:jar :fineract-accounttransfer-test:test
```
