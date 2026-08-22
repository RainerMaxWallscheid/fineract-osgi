pkill -f "tomcat" || true
./gradlew dropPGDB -PdbName=fineract_default
./gradlew dropPGDB -PdbName=fineract_tenants
./gradlew createPGDB -PdbName=fineract_tenants
./gradlew createPGDB -PdbName=fineract_default
/gradlew :fineract-e2e-tests-runner:cucumber -Dcucumber.features=docs/gherkin/features -PdbType=postgresql
