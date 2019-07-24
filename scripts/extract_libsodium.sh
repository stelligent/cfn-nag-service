#!/usr/bin/env bash

set -e

rm -f libsodium.zip
rm -f lib/libsodium*
docker run -v `pwd`:/var/task -t lambci/lambda:build-ruby2.5 ./scripts/download_libsodium.sh
zip libsodium.zip lib/ -r
aws s3 cp libsodium.zip s3://pmd-cfn-nag-1617/libsodium.zip
