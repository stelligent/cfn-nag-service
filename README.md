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

```
sam build --use-container
sam package --template-file .aws-sam/build/template.yaml     --s3-bucket stelligent-cfn-nag-service --output-template-file packaged-template.yaml
sam deploy --stack-name cfn-nag-service --template-file packaged-template.yaml --capabilities CAPABILITY_IAM
```

#### Testing

```
file=~/git/cfn_nag/spec/test_templates/json/elasticsearch/elasticsearch_domain_with_explicit_name.json
curl -d "{\"template_body\": \"`base64 $file`\"}" -H "Content-Type: application/json" -X POST https://ycabffgus6.execute-api.us-east-1.amazonaws.com/Prod/scan/
```
