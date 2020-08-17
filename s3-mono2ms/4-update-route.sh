#! /bin/bash
set -x
WWW_ROUTE=$(oc get route www -o jsonpath='{.spec.host}')
oc create route edge www-catalog --service=catalog --port='8080' --hostname=$WWW_ROUTE --path=/services/products
oc patch route www-catalog --type json  --patch '[{ "op": "remove", "path": "/spec/tls" }]'
