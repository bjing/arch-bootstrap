#!/bin/bash
if [ $# != 1 ]; then
  echo "No packer version parameter given."
  exit 1
fi

PACKER_VERSION=$1
wget https://dl.bintray.com/mitchellh/packer/packer_${PACKER_VERSION}_linux_amd64.zip -O /tmp/packer.zip
mkdir /opt/packer-${PACKER_VERSION}
cd /opt/packer-${PACKER_VERSION}
unzip /tmp/packer.zip
ln -sf /opt/packer-${PACKER_VERSION} /opt/packer
rm /tmp/packer.zip

