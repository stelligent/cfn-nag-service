### Preparing Lambda Deployment Package

```
bundle install --path vendor/bundle
zip cfn-nag-lambda.zip cfn-nag-lambda-handler.rb vendor -r
```
