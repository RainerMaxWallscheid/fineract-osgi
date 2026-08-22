pkill -f "tomcat" || true
./gradlew dropPGDB -PdbName=fineract_default
./gradlew dropPGDB -PdbName=fineract_tenants
./gradlew createPGDB -PdbName=fineract_tenants
./gradlew createPGDB -PdbName=fineract_default
./gradlew devRun -PdbType=postgresql
