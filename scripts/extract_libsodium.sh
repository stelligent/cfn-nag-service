#!/usr/bin/env bash

set -e

mkdir lib || true
rm -f libsodium.zip
rm -f lib/libsodium*
docker run -v `pwd`:/var/task -t lambci/lambda:build-ruby2.5 ./download_libsodium.sh
zip libsodium.zip lib/ -r
aws s3 cp libsodium.zip s3://${S3_BUCKET_NAME}/libsodium.zip
