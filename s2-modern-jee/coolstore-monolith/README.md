# CoolStore Monolith

This repository has the complete coolstore monolith built as a Java EE 7 application. To deploy it on OpenShift Container Platform (OCP) follow the instructions below

## Prerequisites

* Access to a OCP cluster using 3.5 or later.
* OpenShift Command Client tool (eg. oc) installed locally
* JBoss EAP xPaaS imagestream definitions installed in the `openshift` project/namespace (or in the project in which you will deploy this app)
* Authenticated from the command line client to the cluster

        oc login <url>

## Build and deploy using the binary deployment

Clone the project to a local directory

    git clone `URL to this repo` coolstore-monolith
    cd coolstore-monolith

Build the project using openshift profile

    mvn clean package -Popenshift

Create a new project (or use an existing)

    oc new-project coolstore

Create the app

    oc process -f src/main/openshift/template-binary.yaml | oc create -f -

Start the build

    oc start-build coolstore --from-file=deployments/ROOT.war
