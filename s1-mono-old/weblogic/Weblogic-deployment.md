# Quick Web Logic Deployment - with docker

  I assume you already have a local docker setup.
1.  Go to Oracle container registry (https://container-registry.oracle.com/) and sign-in.
  If you don't have an account, create a new one. Search for weblogic container image,
  and accept the license agreement.
2. Login to Oracle registry

```shell
docker login https://container-registry.oracle.com/
```
3. Create a local domain.properties file and put username and password inside
```
username=weblogic
password=weblogic1
```
4.  Run the below command in the same directory
``` shell
docker run -d -p 7001:7001 -p 9002:9002 \
      -v $PWD:/u01/oracle/properties container-registry.oracle.com/middleware/weblogic:12.2.1.4-dev
```
5. The application requires one data source and one JMS topic definition :
```
Data Source: java:jboss/datasources/CoolstoreDS
JMS Topic: jms/topic/orders
```
6. Deploy monolith.war to root context
