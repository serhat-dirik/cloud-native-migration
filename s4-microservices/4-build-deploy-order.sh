#! /bin/bash
set -x

#oc new-app --as-deployment-config  --image-stream="openshift/mongodb:3.6" --name=order-database
oc new-app --template=mongodb-ephemeral --as-deployment-config --name=order-database \
    -p MONGODB_USER=order \
    -p MONGODB_PASSWORD=mysecretpassword \
    -p MONGODB_DATABASE=orderdb \
    -p MONGODB_ADMIN_PASSWORD=mysecretpassword \
    -p MONGODB_ADMIN_PASSWORD=mysecretpassword \
    -p DATABASE_SERVICE_NAME=order-database



cd order-service
mvn clean package -Dquarkus.package.uber-jar=true -DskipTests
oc new-build --name=order java --binary=true --labels=app.kubernetes.io/instance=order
oc start-build order --from-file=target/order-1.0-SNAPSHOT-runner.jar --follow
oc new-app order
oc expose svc order
oc set probe deployment/order  --readiness --get-url=http://:8080/health --initial-delay-seconds=10 --period-seconds=5 --failure-threshold=15
oc set probe deployment/order  --liveness --get-url=http://:8080/health --initial-delay-seconds=30 --period-seconds=5 --failure-threshold=15


oc label deployment order app.kubernetes.io/part-of=order --overwrite
oc label dc/order-database app.kubernetes.io/part-of=order app.openshift.io/runtime=mongodb --overwrite
oc annotate deployment order app.openshift.io/connects-to=order-database --overwrite
oc annotate deployment/inventory app.openshift.io/vcs-uri=https://github.com/serhat-dirik/cloud-native-migration.git --overwrite
oc annotate deployment order app.openshift.io/vcs-ref=ocp-4.5 --overwrite
