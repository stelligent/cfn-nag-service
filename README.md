## CfnNagService

This repository contains the automation code required to deploy https://github.com/stelligent/cfn_nag as an API Gateway endpoint.

### Endpoints

Each request expects a JSON structure with a single `template_body` key. The value of this key should be a Base64 encoded CloudFormation template in either JSON or YAML.

#### /scan

This endpoint returns the same response that you would see if you just ran `cfn_nag` from the command line.

Request example:

```
{
  "template_body": "ewogICJBV1NUZW1wbGF0ZUZvcm1hdFZlcnNpb24iOiAiMjAxMC0wOS0wOSIsCiAgIlJlc291cmNlcyI6IHsKICAgICAgICAiUzNCdWNrZXQiOiB7CiAgICAgICAgICAgICJUeXBlIjogIkFXUzo6UzM6OkJ1Y2tldCIsCiAgICAgICAgICAgICJQcm9wZXJ0aWVzIjogewogICAgICAgICAgICAgICAgIkFjY2Vzc0NvbnRyb2wiOiAiUHVibGljUmVhZFdyaXRlIiwKICAgICAgICAgICAgICAgICJDb3JzQ29uZmlndXJhdGlvbiI6IHsKICAgICAgICAgICAgICAgICAgICAiQ29yc1J1bGVzIjogWwogICAgICAgICAgICAgICAgICAgICAgICB7CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAiQWxsb3dlZEhlYWRlcnMiOiBbCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIioiCiAgICAgICAgICAgICAgICAgICAgICAgICAgICBdLAogICAgICAgICAgICAgICAgICAgICAgICAgICAgIkFsbG93ZWRNZXRob2RzIjogWwogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICJHRVQiCiAgICAgICAgICAgICAgICAgICAgICAgICAgICBdLAogICAgICAgICAgICAgICAgICAgICAgICAgICAgIkFsbG93ZWRPcmlnaW5zIjogWwogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICIqIgogICAgICAgICAgICAgICAgICAgICAgICAgICAgXSwKICAgICAgICAgICAgICAgICAgICAgICAgICAgICJFeHBvc2VkSGVhZGVycyI6IFsKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAiRGF0ZSIKICAgICAgICAgICAgICAgICAgICAgICAgICAgIF0sCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAiSWQiOiAibXlDT1JTUnVsZUlkMSIsCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAiTWF4QWdlIjogIjM2MDAiCiAgICAgICAgICAgICAgICAgICAgICAgIH0sCiAgICAgICAgICAgICAgICAgICAgICAgIHsKICAgICAgICAgICAgICAgICAgICAgICAgICAgICJBbGxvd2VkSGVhZGVycyI6IFsKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAieC1hbXotKiIKICAgICAgICAgICAgICAgICAgICAgICAgICAgIF0sCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAiQWxsb3dlZE1ldGhvZHMiOiBbCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIkRFTEVURSIKICAgICAgICAgICAgICAgICAgICAgICAgICAgIF0sCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAiQWxsb3dlZE9yaWdpbnMiOiBbCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgImh0dHA6Ly93d3cuZXhhbXBsZTEuY29tIiwKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAiaHR0cDovL3d3dy5leGFtcGxlMi5jb20iCiAgICAgICAgICAgICAgICAgICAgICAgICAgICBdLAogICAgICAgICAgICAgICAgICAgICAgICAgICAgIkV4cG9zZWRIZWFkZXJzIjogWwogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICJDb25uZWN0aW9uIiwKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAiU2VydmVyIiwKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAiRGF0ZSIKICAgICAgICAgICAgICAgICAgICAgICAgICAgIF0sCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAiSWQiOiAibXlDT1JTUnVsZUlkMiIsCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAiTWF4QWdlIjogIjE4MDAiCiAgICAgICAgICAgICAgICAgICAgICAgIH0KICAgICAgICAgICAgICAgICAgICBdCiAgICAgICAgICAgICAgICB9CiAgICAgICAgICAgIH0KICAgICAgICB9CiAgICB9LAogICAgIk91dHB1dHMiOiB7CiAgICAgICAgIkJ1Y2tldE5hbWUiOiB7CiAgICAgICAgICAgICJWYWx1ZSI6IHsKICAgICAgICAgICAgICAgICJSZWYiOiAiUzNCdWNrZXQiCiAgICAgICAgICAgIH0sCiAgICAgICAgICAgICJEZXNjcmlwdGlvbiI6ICJOYW1lIG9mIHRoZSBzYW1wbGUgQW1hem9uIFMzIGJ1Y2tldCB3aXRoIENPUlMgZW5hYmxlZC4iCiAgICAgICAgfQogICAgfQp9Cg=="
}
```

Response example:

```
{
    "failure_count": 1,
    "violations": [
        {
            "id": "W35",
            "type": "WARN",
            "message": "S3 Bucket should have access logging configured",
            "logical_resource_ids": [
                "S3Bucket"
            ],
            "line_numbers": [
                5
            ]
        },
        {
            "id": "F14",
            "type": "FAIL",
            "message": "S3 Bucket should not have a public read-write acl",
            "logical_resource_ids": [
                "S3Bucket"
            ],
            "line_numbers": [
                5
            ]
        }
    ]
}
```

#### /scan_secure

This endpoint will provide a digital signature so you can verify the authenticity of the results. There are two SSM SecureString parameters involved:

* /CfnNagService/signing_key - The key the service uses to sign requests
* /CfnNagService/verify_key - The key you can use to verify signatures

Response example:

```
{
    "results": {
        "failure_count": 1,
        "violations": [
            {
                "id": "W35",
                "type": "WARN",
                "message": "S3 Bucket should have access logging configured",
                "logical_resource_ids": [
                    "S3Bucket"
                ],
                "line_numbers": [
                    5
                ]
            },
            {
                "id": "F14",
                "type": "FAIL",
                "message": "S3 Bucket should not have a public read-write acl",
                "logical_resource_ids": [
                    "S3Bucket"
                ],
                "line_numbers": [
                    5
                ]
            }
        ]
    },
    "signature": "eKlzShFty5tCC/zXo3Cf7L0E0yCxdXejS7dAYauBc2s9eBoCfs9Lmd2AQcGR\nEwrSUzr43s+bUjqy/5Sum1JcCQ==\n"
}
```

#### /status

This endpoint just provides a 200 HTTP response and a simple message to let you know the endpoint is up.

### Endpoint options

All endpoints have two parameters that can modify the response. When set to `true` it will provide more information in the response.

* return_template - Returns the template_body that was originally passed in to the service
* return_rule - Returns an array of all rules that were applied

Example endpoint request URL:

https://dtulcqx04a.execute-api.us-east-1.amazonaws.com/Prod/scan_secure/?return_template=true&return_rules=true

Example response:

```
{
    "results": {
        "failure_count": 1,
        "violations": [
            {
                "id": "W35",
                "type": "WARN",
                "message": "S3 Bucket should have access logging configured",
                "logical_resource_ids": [
                    "S3Bucket"
                ],
                "line_numbers": [
                    5
                ]
            },
            {
                "id": "F14",
                "type": "FAIL",
                "message": "S3 Bucket should not have a public read-write acl",
                "logical_resource_ids": [
                    "S3Bucket"
                ],
                "line_numbers": [
                    5
                ]
            }
        ]
    },
    "signature": "eKlzShFty5tCC/zXo3Cf7L0E0yCxdXejS7dAYauBc2s9eBoCfs9Lmd2AQcGR\nEwrSUzr43s+bUjqy/5Sum1JcCQ==\n",
    "template": "ewogICJBV1NUZW1wbGF0ZUZvcm1hdFZlcnNpb24iOiAiMjAxMC0wOS0wOSIsCiAgIlJlc291cmNlcyI6IHsKICAgICAgICAiUzNCdWNrZXQiOiB7CiAgICAgICAgICAgICJUeXBlIjogIkFXUzo6UzM6OkJ1Y2tldCIsCiAgICAgICAgICAgICJQcm9wZXJ0aWVzIjogewogICAgICAgICAgICAgICAgIkFjY2Vzc0NvbnRyb2wiOiAiUHVibGljUmVhZFdyaXRlIiwKICAgICAgICAgICAgICAgICJDb3JzQ29uZmlndXJhdGlvbiI6IHsKICAgICAgICAgICAgICAgICAgICAiQ29yc1J1bGVzIjogWwogICAgICAgICAgICAgICAgICAgICAgICB7CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAiQWxsb3dlZEhlYWRlcnMiOiBbCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIioiCiAgICAgICAgICAgICAgICAgICAgICAgICAgICBdLAogICAgICAgICAgICAgICAgICAgICAgICAgICAgIkFsbG93ZWRNZXRob2RzIjogWwogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICJHRVQiCiAgICAgICAgICAgICAgICAgICAgICAgICAgICBdLAogICAgICAgICAgICAgICAgICAgICAgICAgICAgIkFsbG93ZWRPcmlnaW5zIjogWwogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICIqIgogICAgICAgICAgICAgICAgICAgICAgICAgICAgXSwKICAgICAgICAgICAgICAgICAgICAgICAgICAgICJFeHBvc2VkSGVhZGVycyI6IFsKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAiRGF0ZSIKICAgICAgICAgICAgICAgICAgICAgICAgICAgIF0sCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAiSWQiOiAibXlDT1JTUnVsZUlkMSIsCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAiTWF4QWdlIjogIjM2MDAiCiAgICAgICAgICAgICAgICAgICAgICAgIH0sCiAgICAgICAgICAgICAgICAgICAgICAgIHsKICAgICAgICAgICAgICAgICAgICAgICAgICAgICJBbGxvd2VkSGVhZGVycyI6IFsKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAieC1hbXotKiIKICAgICAgICAgICAgICAgICAgICAgICAgICAgIF0sCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAiQWxsb3dlZE1ldGhvZHMiOiBbCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIkRFTEVURSIKICAgICAgICAgICAgICAgICAgICAgICAgICAgIF0sCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAiQWxsb3dlZE9yaWdpbnMiOiBbCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgImh0dHA6Ly93d3cuZXhhbXBsZTEuY29tIiwKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAiaHR0cDovL3d3dy5leGFtcGxlMi5jb20iCiAgICAgICAgICAgICAgICAgICAgICAgICAgICBdLAogICAgICAgICAgICAgICAgICAgICAgICAgICAgIkV4cG9zZWRIZWFkZXJzIjogWwogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICJDb25uZWN0aW9uIiwKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAiU2VydmVyIiwKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAiRGF0ZSIKICAgICAgICAgICAgICAgICAgICAgICAgICAgIF0sCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAiSWQiOiAibXlDT1JTUnVsZUlkMiIsCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAiTWF4QWdlIjogIjE4MDAiCiAgICAgICAgICAgICAgICAgICAgICAgIH0KICAgICAgICAgICAgICAgICAgICBdCiAgICAgICAgICAgICAgICB9CiAgICAgICAgICAgIH0KICAgICAgICB9CiAgICB9LAogICAgIk91dHB1dHMiOiB7CiAgICAgICAgIkJ1Y2tldE5hbWUiOiB7CiAgICAgICAgICAgICJWYWx1ZSI6IHsKICAgICAgICAgICAgICAgICJSZWYiOiAiUzNCdWNrZXQiCiAgICAgICAgICAgIH0sCiAgICAgICAgICAgICJEZXNjcmlwdGlvbiI6ICJOYW1lIG9mIHRoZSBzYW1wbGUgQW1hem9uIFMzIGJ1Y2tldCB3aXRoIENPUlMgZW5hYmxlZC4iCiAgICAgICAgfQogICAgfQp9Cg==",
    "rules": [
        "W34 WARN Batch Job Definition Container Properties should not have Privileged set to true",
        "W1 WARN Specifying credentials in the template itself is probably not the safest thing",
        "W10 WARN CloudFront Distribution should enable access logging",
        "W32 WARN CodeBuild project should specify an EncryptionKey value",
        "F37 FAIL DMS Endpoint must not be a plaintext string or a Ref to a NoEcho Parameter with a Default value.",
        "F36 FAIL Directory Service Microsoft AD must not be a plaintext string or a Ref to a NoEcho Parameter with a Default value.",
        "F31 FAIL DirectoryService::SimpleAD should use a parameter for password, with NoEcho",
        "W33 WARN EC2 Subnet should not have MapPublicIpOnLaunch set to true",
        "F32 FAIL EFS FileSystem should have encryption enabled",
        "F1 FAIL EBS volume should have server-side encryption enabled",
        "F25 FAIL ElastiCache ReplicationGroup should have encryption enabled for at rest",
        "F33 FAIL ElastiCache ReplicationGroup should have encryption enabled for in transit",
        "W26 WARN Elastic Load Balancer should have access logging enabled",
        "W17 WARN IAM managed policy should not allow Allow+NotAction",
        "W23 WARN IAM managed policy should not allow Allow+NotResource",
        "F5 FAIL IAM managed policy should not allow * action",
        "W13 WARN IAM managed policy should not allow * resource",
        "W16 WARN IAM policy should not allow Allow+NotAction",
        "W22 WARN IAM policy should not allow Allow+NotResource",
        "F4 FAIL IAM policy should not allow * action",
        "W12 WARN IAM policy should not allow * resource",
        "W15 WARN IAM role should not allow Allow+NotAction",
        "W14 WARN IAM role should not allow Allow+NotAction on trust permissions",
        "F6 FAIL IAM role should not allow Allow+NotPrincipal in its trust policy",
        "W21 WARN IAM role should not allow Allow+NotResource",
        "F3 FAIL IAM role should not allow * action on its permissions policy",
        "F2 FAIL IAM role should not allow * action on its trust policy",
        "W11 WARN IAM role should not allow * resource on its permissions policy",
        "F19 FAIL EnableKeyRotation should not be false or absent on KMS::Key resource",
        "W24 WARN Lambda permission beside InvokeFunction might not be what you want? Not sure!?",
        "F13 FAIL Lambda permission principal should not be wildcard",
        "F12 FAIL IAM managed policy should not apply directly to users.  Should be on group",
        "F30 FAIL Neptune database cluster storage should have encryption enabled",
        "F11 FAIL IAM policy should not apply directly to users.  Should be on group",
        "F34 FAIL RDS DB Cluster master user password must be Ref to NoEcho Parameter. Default credentials are not recommended",
        "F26 FAIL RDS DBCluster should have StorageEncrypted enabled",
        "F27 FAIL RDS DBInstance should have StorageEncrypted enabled",
        "F23 FAIL RDS instance master user password must be Ref to NoEcho Parameter. Default credentials are not recommended",
        "F24 FAIL RDS instance master username must be Ref to NoEcho Parameter. Default credentials are not recommended",
        "F22 FAIL RDS instance should not be publicly accessible",
        "F28 FAIL Redshift Cluster should have encryption enabled",
        "F35 FAIL Redshift Cluster master user password must be Ref to NoEcho Parameter. Default credentials are not recommended",
        "W28 WARN Resource found with an explicit name, this disallows updates that require replacement of this resource",
        "W35 WARN S3 Bucket should have access logging configured",
        "W20 WARN S3 Bucket policy should not allow Allow+NotAction",
        "F9 FAIL S3 Bucket policy should not allow Allow+NotPrincipal",
        "F15 FAIL S3 Bucket policy should not allow * action",
        "F16 FAIL S3 Bucket policy should not allow * principal",
        "W31 WARN S3 Bucket likely should not have a public read acl",
        "F14 FAIL S3 Bucket should not have a public read-write acl",
        "W5 WARN Security Groups found with cidr open to world on egress",
        "W29 WARN Security Groups found egress with port range instead of just a single port",
        "W9 WARN Security Groups found with ingress cidr that is not /32",
        "W2 WARN Security Groups found with cidr open to world on ingress.  This should never be true on instance.  Permissible on ELB",
        "W27 WARN Security Groups found ingress with port range instead of just a single port",
        "F1000 FAIL Missing egress rule means all traffic is allowed outbound.  Make this explicit if it is desired configuration",
        "W19 WARN SNS Topic policy should not allow Allow+NotAction",
        "F8 FAIL SNS Topic policy should not allow Allow+NotPrincipal",
        "F18 FAIL SNS topic policy should not allow * principal",
        "W18 WARN SQS Queue policy should not allow Allow+NotAction",
        "F7 FAIL SQS Queue policy should not allow Allow+NotPrincipal",
        "F20 FAIL SQS Queue policy should not allow * action",
        "F21 FAIL SQS Queue policy should not allow * principal",
        "F10 FAIL IAM user should not have any inline policies.  Should be centralized Policy object on group",
        "F2000 FAIL User is not assigned to a group",
        "F665 FAIL WebAcl DefaultAction should not be ALLOW",
        "F29 FAIL Workspace should have encryption enabled"
    ]
}
```

### Verifying Signatures

When using the /scan_secure endpoint you can use the libsodium library to verify the signatures. An example ruby implementation is provided.

```
$ ./scripts/verify_signature.rb
Enter Base64 encoded signature:
2nW3Y/2U/HyLy7KZvyfBgtZfz3spYI6ppYHL4rt0+pu/C7DjC/nLcTrEGiROkoVsV3TBLctgwtruHg502uxuBQ==
Enter Base64 encoded verification key
...
Enter in Base64 encoded results
eyJmYWlsdXJlX2NvdW50IjoxLCJ2aW9sYXRpb25zIjpbeyJpZCI6IlczNSIsInR5cGUiOiJXQVJOIiwibWVzc2FnZSI6IlMzIEJ1Y2tldCBzaG91bGQgaGF2ZSBhY2Nlc3MgbG9nZ2luZyBjb25maWd1cmVkIiwibG9naWNhbF9yZXNvdXJjZV9pZHMiOlsiUzNCdWNrZXQiXSwibGluZV9udW1iZXJzIjpbNV19LHsiaWQiOiJGMTQiLCJ0eXBlIjoiRkFJTCIsIm1lc3NhZ2UiOiJTMyBCdWNrZXQgc2hvdWxkIG5vdCBoYXZlIGEgcHVibGljIHJlYWQtd3JpdGUgYWNsIiwibG9naWNhbF9yZXNvdXJjZV9pZHMiOlsiUzNCdWNrZXQiXSwibGluZV9udW1iZXJzIjpbNV19XX0=
Signature is valid!
```

### Local Development

#### Build dependencies
```
sam build
```

#### Test Lambda

##### Local invoke

```
sam local invoke -e event-json.json
sam local invoke -e event-yaml.json
```

##### Local API testing

```
sam local start-api
file=~/git/cfn_nag/spec/test_templates/json/elasticsearch/elasticsearch_domain_without_explicit_name.json
curl -d "{\"template_body\": \"`base64 $file`\"}" -H "Content-Type: application/json" -X POST http://127.0.0.1:3000/scan
```

### Deployment

These are typically one time tasks:

```
./scripts/create_signing_keys
./scripts/extract_libsodium.sh
```

For each deployment:

```
sam build --use-container
sam package --template-file .aws-sam/build/template.yaml --s3-bucket stelligent-cfn-nag-service --output-template-file packaged-template.yaml
sam deploy --stack-name cfn-nag-service --template-file packaged-template.yaml --capabilities CAPABILITY_IAM
```

#### Testing

```
file=~/git/cfn_nag/spec/test_templates/json/elasticsearch/elasticsearch_domain_with_explicit_name.json
curl -d "{\"template_body\": \"`base64 $file`\"}" -H "Content-Type: application/json" -X POST https://ycabffgus6.execute-api.us-east-1.amazonaws.com/Prod/scan/
```
