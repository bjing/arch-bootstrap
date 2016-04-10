#!/bin/bash
if [ $# != 1 ]; then
  echo "No gradle version parameter given."
  exit 1
fi

GRADLE_VERSION=$1
wget https://services.gradle.org/distributions/gradle-${GRADLE_VERSION}-bin.zip -O /tmp/gradle.zip
cd /opt
unzip /tmp/gradle.zip
ln -sf /opt/gradle-${GRADLE_VERSION} /opt/gradle
rm /tmp/gradle.zip

