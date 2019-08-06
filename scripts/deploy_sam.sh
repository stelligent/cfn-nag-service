#!/bin/sh -ex
AWS_REGION=us-east-1
if [[ -z "${S3_BUCKET_NAME}" ]];
then
  echo must set S3_BUCKET_NAME in env for bucket to upload lambda to for dpeloyment
  exit 1
fi

./extract_libsodium.sh

pushd ..
mkdir sam_out || true

sam build -t infra/sam_template.yaml -s . --use-container --debug
sam package --template-file .aws-sam/build/template.yaml \
            --s3-bucket $S3_BUCKET_NAME \
            --output-template-file sam_out/packaged-template.yaml
sam deploy --stack-name cfn-nag-service \
           --template-file sam_out/packaged-template.yaml \
           --capabilities CAPABILITY_IAM \
           --parameter-overrides "S3Bucket=$S3_BUCKET_NAME" \
           --region ${AWS_REGION}
popd
