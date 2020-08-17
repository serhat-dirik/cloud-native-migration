# Application Migration to EAP

  This is a sample shift and lift demo with the help of Red Hat Migration Toolkit. We have an a packaged JEE application monolith.war, consist of our coolstore retail web application. It's currently implemented for Weblogic. If you like to test it on Weblogic, [Weblogic deployment hints](weblogic/Weblogic-deployment.md) can be helpful. As a first step of our modernization project, we'd like to migrate it to a modern, cloud ready JEE application server, Red Hat EAP in this case.

  Download the Red Hat Migration Toolkit CLI from the below url:
https://developers.redhat.com/products/rhamt/download

  Extract it to a directory and execute the below command:

```shell
cd $RHAMT_DIR/bin

./rhamt-cli --input $your_input_dir/monolith.war --output $your_report_dir/report --source weblogic --target eap:7 --packages com.redhat
```

Later you should get a similar output:

```
Using RHAMT at /Users/serhat/RedHat/product/Demo/rtm/rhamt-cli-4.3.1.Final
> Red Hat Application Migration Toolkit (RHAMT) CLI, version 4.3.1.Final.


Red Hat Application Migration Toolkit (RHAMT) CLI, version [ 4.3.1.Final ] - by Red Hat, Inc. [ https://developers.redhat.com/products/rhamt/overview/ ]

These input applications or directories are large:
 	your_input_dir/monolith.war
 Processing may take a very long time. Please consult the RHAMT User Guide for performance tips. Would you like to continue? [Y,n] Y

Input Application:your_input_dir/monolith.war
Output Path:your_report_dir/report
...
...
Report created: your_report_dir/report/index.html
              Access it at this URL: file:///your_report_dir/report/index.html
```
Open the report and examine it to understand what's need to be changed to migrate Red Hat EAP. A Migrated version of the project can be found in [stage 2 Modern JEE](../s2-modern-jee/README.md)
