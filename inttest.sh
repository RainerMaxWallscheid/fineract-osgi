pkill -f "tomcat" || true
./gradlew dropPGDB -PdbName=fineract_default
./gradlew dropPGDB -PdbName=fineract_tenants
./gradlew createPGDB -PdbName=fineract_tenants
./gradlew createPGDB -PdbName=fineract_default
./gradlew integration-tests:test -PdbType=postgresql -Dorg.gradle.jvmargs="-Xmx12g -XX:MaxMetaspaceSize=1g"
