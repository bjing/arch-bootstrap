#!/bin/bash
wget --no-check-certificate --no-cookies --header "Cookie: oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/7u79-b15/jdk-7u79-linux-x64.tar.gz -O /tmp/jdk7.tar.gz
cd /opt
tar zxvf /tmp/jdk7.tar.gz
ln -sf /opt/jdk1.7.0_79 /opt/jdk7
rm /tmp/jdk7.tar.gz

