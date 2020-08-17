#! /bin/bash
set -x
cd coolstore-monolith
mvn clean package -Popenshift
oc start-build coolstore --from-file=deployments/ROOT.war
oc rollout status -w dc/coolstore
oc get route www
