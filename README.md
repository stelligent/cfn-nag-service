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

### Endpoint options

All endpoints have two parameters that can modify the response. When set to `true` it will provide more information in the response.

* return_template - Returns the template_body that was originally passed in to the service
* return_rule - Returns an array of all rules that were applied

Example endpoint request URL:

https://dtulcqx04a.execute-api.us-east-1.amazonaws.com/Prod/scan_secure/?return_template=true&return_rules=true

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
