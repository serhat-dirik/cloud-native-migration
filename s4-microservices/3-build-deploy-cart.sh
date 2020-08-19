#! /bin/bash
set -x

oc new-app --as-deployment-config jboss/infinispan-server:10.0.0.Beta3 --name=datagrid-service

cd cart-service
mvn clean package -Dquarkus.package.uber-jar=true -DskipTests
oc new-build --name=cart java --binary=true --labels=app.kubernetes.io/instance=cart
oc start-build cart --from-file=target/cart-1.0-SNAPSHOT-runner.jar --follow
oc new-app cart
oc label deployment/cart app.kubernetes.io/part-of=cart app.kubernetes.io/name=java app.kubernetes.io/instance=cart --overwrite
oc expose svc cart
oc set probe deployment/cart  --readiness --get-url=http://:8080/health --initial-delay-seconds=5 --period-seconds=5 --failure-threshold=15
oc set probe deployment/cart  --liveness --get-url=http://:8080/health --initial-delay-seconds=20 --period-seconds=5 --failure-threshold=15

oc label deployment cart app.kubernetes.io/part-of=cart app.openshift.io/runtime=quarkus --overwrite
oc label dc/datagrid-service app.kubernetes.io/part-of=cart app.openshift.io/runtime=datagrid --overwrite
oc annotate deployment cart app.openshift.io/connects-to=catalog,datagrid-service --overwrite
oc annotate deployment cart app.openshift.io/vcs-ref=ocp-4.5 --overwrite
