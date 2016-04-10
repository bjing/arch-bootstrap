#!/bin/bash
wget --no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/8u60-b27/jdk-8u60-linux-x64.tar.gz -O /tmp/jdk8.tar.gz
cd /opt
mkdir jdk1.8.0_60-b27
cd jdk1.8.0_60-b27
tar --strip-components=1 -zxvf /tmp/jdk8.tar.gz
ln -sf /opt/jdk1.8.0_60-b27 /opt/jdk8
rm /tmp/jdk8.tar.gz

