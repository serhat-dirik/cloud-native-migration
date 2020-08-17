#! /bin/bash
set -x

oc new-app openshift/postgresql:10 --name=catalog-database -e POSTGRESQL_USER=catalog -e POSTGRESQL_PASSWORD=mysecretpassword -e POSTGRESQL_DATABASE=catalog
cd catalog-springboot
mvn clean package install spring-boot:repackage -DskipTests
oc new-build --name=catalog java:11 --binary  -l app=catalog
oc start-build catalog --from-file target/catalog-1.0.0-SNAPSHOT.jar --follow
oc new-app catalog  -e JAVA_OPTS_APPEND='-Dspring.profiles.active=openshift'
#oc new-app catalog --as-deployment-config -e JAVA_OPTS_APPEND='-Dspring.profiles.active=openshift'
oc expose service catalog
oc set probe deployment/catalog  --readiness --get-url=http://:8080 --initial-delay-seconds=5 --period-seconds=5 --failure-threshold=15

oc label deployment catalog app.kubernetes.io/instance=catalog --overwrite
oc label deployment catalog-database app.openshift.io/runtime=postgresql --overwrite
oc label deployment catalog app.kubernetes.io/part-of=catalog --overwrite
oc label deployment catalog-database app.kubernetes.io/part-of=catalog --overwrite
oc annotate deployment catalog app.openshift.io/connects-to=catalog-database --overwrite
oc annotate deployment catalog app.openshift.io/vcs-uri=https://github.com/RedHat-Middleware-Workshops/cloud-native-workshop-v2m1-labs.git --overwrite
oc annotate deployment catalog app.openshift.io/vcs-ref=ocp-4.5 --overwrite
