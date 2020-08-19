#! /bin/bash
set -x

cd coolstore-ui
npm install --save-dev nodeshift
npm run nodeshift --useDeployment

oc expose svc/coolstore-ui
oc label dc/coolstore-ui app.kubernetes.io/part-of=coolstore --overwrite
oc annotate dc/coolstore-ui app.openshift.io/connects-to=order-cart,catalog,inventory,order --overwrite
oc annotate dc/coolstore-ui app.openshift.io/vcs-uri=https://github.com/serhat-dirik/cloud-native-migration.git --overwrite
oc annotate dc/coolstore-ui app.openshift.io/vcs-ref=ocp-4.5 --overwrite
