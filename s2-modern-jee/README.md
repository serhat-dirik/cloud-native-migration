
You haven maven, jdk and oc client is connected

```shell
oc new-project demo-monolith
```
Execute the commands below to deploy coolstore

```shell
./1-create-build-and-deploy.sh
./2-build-and-deploy.sh
```

Your apps should be ready in this stage. Scale up your monolith

```shell
./3-scaleUp.sh
```
Get all pods up and running
```shell
oc get po --selector="deploymentconfig=coolstore" -w
```

Open a new shell and start sending request

```shell
./curl-loop $(oc get route www -o jsonpath='{.spec.host}')
```
Open a new shell and kill one of pod with ```oc delete po coolstore-yourpodid```
command. Observe you're keep getting ```HTTP-200``` and replication controller
created a new pod for you

Clean Up

```shell
oc scale dc/coolstore --replicas=1
```
