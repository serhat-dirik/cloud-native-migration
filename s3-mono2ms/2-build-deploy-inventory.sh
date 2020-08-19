#! /bin/bash
set -x

oc new-app openshift/postgresql:10 --name=inventory-database -e POSTGRESQL_USER=inventory -e POSTGRESQL_PASSWORD=mysecretpassword -e POSTGRESQL_DATABASE=inventory
cd inventory-quarkus
mvn clean package -Dquarkus.package.uber-jar=true -DskipTests
oc new-build --name=inventory java --binary=true --labels=app.kubernetes.io/instance=inventory
oc start-build inventory --from-file=target/inventory-1.0-SNAPSHOT-runner.jar --follow
oc new-app inventory
oc label deployment/inventory app.kubernetes.io/part-of=coolstore app.kubernetes.io/name=java app.kubernetes.io/instance=inventory --overwrite
oc expose svc inventory
oc set probe deployment/inventory  --readiness --get-url=http://:8080/health --initial-delay-seconds=5 --period-seconds=5 --failure-threshold=15
oc set probe deployment/inventory  --liveness --get-url=http://:8080/health --initial-delay-seconds=20 --period-seconds=5 --failure-threshold=15

oc label deployment inventory-database app.openshift.io/runtime=postgresql --overwrite
oc label deployment/inventory app.kubernetes.io/part-of=inventory --overwrite
oc label deployment/inventory-database app.kubernetes.io/part-of=inventory --overwrite
oc annotate deployment/inventory app.openshift.io/connects-to=inventory-database --overwrite
oc annotate deployment/inventory app.openshift.io/vcs-uri=https://github.com/serhat-dirik/cloud-native-migration.git --overwrite
oc annotate deployment/inventory app.openshift.io/vcs-ref=master --overwrite
