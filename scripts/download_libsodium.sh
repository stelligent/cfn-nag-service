#!/usr/bin/env bash

echo "Installing EPEL"
yum -y install https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm

echo "Installing libsodium via yum"
yum -y install libsodium

cp -v /usr/lib64/libsodium.so.23.3.0 lib/libsodium.so.23
exit
