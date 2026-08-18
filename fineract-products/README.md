# fineract-products

Core residual peel — generic `/v1/products/{type}` facade (share products today) (ADR-022).

| Gradle project | Path | BSN | Role |
|----------------|------|-----|------|
| `fineract-products-api` | `api/` | `org.apache.fineract.products.api` | `ShareProductReadPlatformService`, `ProductCommandsService`, `ProductData` |
| `fineract-products-impl` | `impl/` | `org.apache.fineract.products.impl` | `ProductsApiResource`; Equinox `ProductsOsgiBundleActivator` |
| `fineract-products-test` | `test/` | `org.apache.fineract.products.test` | Fragment-Host → impl |

`ProductNotFoundException` stays residual in core (`ShareProductRepositoryWrapper`). Read impl stays in `fineract-charge-impl`.

```bash
./gradlew :fineract-products-api:jar :fineract-products-impl:jar :fineract-products-test:test
```
