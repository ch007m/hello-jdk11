#!/usr/bin/env bash

echo "Start jdk11 Spring Boot Hello"
java -Djava.security.egd=file:/dev/./urandom -jar /opt/spring-boot/hello-gateway-0.0.1-SNAPSHOT.jar