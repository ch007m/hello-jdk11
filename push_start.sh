#!/usr/bin/env bash

project=hello-gateway

pod_name=$(oc get pod -lapp=${project} -o name)
name=$(cut -d'/' -f2 <<<$pod_name)

echo "## $runtime files ${project} pushed ..."

cmd="run-jdk11"
oc cp ./target/${project}-0.0.1-SNAPSHOT.jar $name:/opt/spring-boot/${project}-0.0.1-SNAPSHOT.jar

oc rsh $pod_name /var/lib/supervisord/bin/supervisord ctl stop $cmd
oc rsh $pod_name /var/lib/supervisord/bin/supervisord ctl start $cmd

echo "## component ${component} (re)started"