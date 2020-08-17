#! /bin/bash
set -x
oc scale dc/coolstore --replicas=2
oc get po --selector="deploymentconfig=coolstore" -w
