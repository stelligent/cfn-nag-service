require 'json'
require 'test/unit'
#require 'mocha/test_unit'

require_relative '../../cfn_nag/handler'

class CfnNagTest < Test::Unit::TestCase
  def event
    {"body"=>
      "{\"template_body\": \"ewogICJBV1NUZW1wbGF0ZUZvcm1hdFZlcnNpb24iOiAiMjAxMC0wOS0wOSIsCiAgIlJlc291cmNlcyI6IHsKICAgICAgICAiUzNCdWNrZXQiOiB7CiAgICAgICAgICAgICJUeXBlIjogIkFXUzo6UzM6OkJ1Y2tldCIsCiAgICAgICAgICAgICJQcm9wZXJ0aWVzIjogewogICAgICAgICAgICAgICAgIkFjY2Vzc0NvbnRyb2wiOiAiUHVibGljUmVhZFdyaXRlIiwKICAgICAgICAgICAgICAgICJDb3JzQ29uZmlndXJhdGlvbiI6IHsKICAgICAgICAgICAgICAgICAgICAiQ29yc1J1bGVzIjogWwogICAgICAgICAgICAgICAgICAgICAgICB7CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAiQWxsb3dlZEhlYWRlcnMiOiBbCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIioiCiAgICAgICAgICAgICAgICAgICAgICAgICAgICBdLAogICAgICAgICAgICAgICAgICAgICAgICAgICAgIkFsbG93ZWRNZXRob2RzIjogWwogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICJHRVQiCiAgICAgICAgICAgICAgICAgICAgICAgICAgICBdLAogICAgICAgICAgICAgICAgICAgICAgICAgICAgIkFsbG93ZWRPcmlnaW5zIjogWwogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICIqIgogICAgICAgICAgICAgICAgICAgICAgICAgICAgXSwKICAgICAgICAgICAgICAgICAgICAgICAgICAgICJFeHBvc2VkSGVhZGVycyI6IFsKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAiRGF0ZSIKICAgICAgICAgICAgICAgICAgICAgICAgICAgIF0sCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAiSWQiOiAibXlDT1JTUnVsZUlkMSIsCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAiTWF4QWdlIjogIjM2MDAiCiAgICAgICAgICAgICAgICAgICAgICAgIH0sCiAgICAgICAgICAgICAgICAgICAgICAgIHsKICAgICAgICAgICAgICAgICAgICAgICAgICAgICJBbGxvd2VkSGVhZGVycyI6IFsKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAieC1hbXotKiIKICAgICAgICAgICAgICAgICAgICAgICAgICAgIF0sCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAiQWxsb3dlZE1ldGhvZHMiOiBbCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIkRFTEVURSIKICAgICAgICAgICAgICAgICAgICAgICAgICAgIF0sCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAiQWxsb3dlZE9yaWdpbnMiOiBbCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgImh0dHA6Ly93d3cuZXhhbXBsZTEuY29tIiwKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAiaHR0cDovL3d3dy5leGFtcGxlMi5jb20iCiAgICAgICAgICAgICAgICAgICAgICAgICAgICBdLAogICAgICAgICAgICAgICAgICAgICAgICAgICAgIkV4cG9zZWRIZWFkZXJzIjogWwogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICJDb25uZWN0aW9uIiwKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAiU2VydmVyIiwKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAiRGF0ZSIKICAgICAgICAgICAgICAgICAgICAgICAgICAgIF0sCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAiSWQiOiAibXlDT1JTUnVsZUlkMiIsCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAiTWF4QWdlIjogIjE4MDAiCiAgICAgICAgICAgICAgICAgICAgICAgIH0KICAgICAgICAgICAgICAgICAgICBdCiAgICAgICAgICAgICAgICB9CiAgICAgICAgICAgIH0KICAgICAgICB9CiAgICB9LAogICAgIk91dHB1dHMiOiB7CiAgICAgICAgIkJ1Y2tldE5hbWUiOiB7CiAgICAgICAgICAgICJWYWx1ZSI6IHsKICAgICAgICAgICAgICAgICJSZWYiOiAiUzNCdWNrZXQiCiAgICAgICAgICAgIH0sCiAgICAgICAgICAgICJEZXNjcmlwdGlvbiI6ICJOYW1lIG9mIHRoZSBzYW1wbGUgQW1hem9uIFMzIGJ1Y2tldCB3aXRoIENPUlMgZW5hYmxlZC4iCiAgICAgICAgfQogICAgfQp9Cg==\"}",
     "resource"=>"/{proxy+}",
     "path"=>"/path/to/resource",
     "httpMethod"=>"POST",
     "isBase64Encoded"=>false,
     "queryStringParameters"=>{"foo"=>"bar"},
     "pathParameters"=>{"proxy"=>"/path/to/resource"},
     "stageVariables"=>{"baz"=>"qux"},
     "headers"=>
      {"Accept"=>
        "text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8",
       "Accept-Encoding"=>"gzip, deflate, sdch",
       "Accept-Language"=>"en-US,en;q=0.8",
       "Cache-Control"=>"max-age=0",
       "CloudFront-Forwarded-Proto"=>"https",
       "CloudFront-Is-Desktop-Viewer"=>"true",
       "CloudFront-Is-Mobile-Viewer"=>"false",
       "CloudFront-Is-SmartTV-Viewer"=>"false",
       "CloudFront-Is-Tablet-Viewer"=>"false",
       "CloudFront-Viewer-Country"=>"US",
       "Host"=>"1234567890.execute-api.us-east-1.amazonaws.com",
       "Upgrade-Insecure-Requests"=>"1",
       "User-Agent"=>"Custom User Agent String",
       "Via"=>"1.1 08f323deadbeefa7af34d5feb414ce27.cloudfront.net (CloudFront)",
       "X-Amz-Cf-Id"=>"cDehVQoZnx43VYQb9j2-nvCh-9z396Uhbp027Y2JvkCPNLmGJHqlaA==",
       "X-Forwarded-For"=>"127.0.0.1, 127.0.0.2",
       "X-Forwarded-Port"=>"443",
       "X-Forwarded-Proto"=>"https"},
     "requestContext"=>
      {"accountId"=>"123456789012",
       "resourceId"=>"123456",
       "stage"=>"prod",
       "requestId"=>"c6af9ac6-7b61-11e6-9a41-93e8deadbeef",
       "requestTime"=>"09/Apr/2015:12:34:56 +0000",
       "requestTimeEpoch"=>1428582896000,
       "identity"=>
        {"cognitoIdentityPoolId"=>nil,
         "accountId"=>nil,
         "cognitoIdentityId"=>nil,
         "caller"=>nil,
         "accessKey"=>nil,
         "sourceIp"=>"127.0.0.1",
         "cognitoAuthenticationType"=>nil,
         "cognitoAuthenticationProvider"=>nil,
         "userArn"=>nil,
         "userAgent"=>"Custom User Agent String",
         "user"=>nil},
       "path"=>"/prod/path/to/resource",
       "resourcePath"=>"/{proxy+}",
       "httpMethod"=>"POST",
       "apiId"=>"1234567890",
       "protocol"=>"HTTP/1.1"}}
  end

  def mock_response
    Object.new.tap do |mock|
      mock.expects(:code).returns(200)
    end
  end

  def expected_result
    result = {
      failure_count: 1,
      violations: [
        {
          id: 'W35',
          type: 'WARN',
          message: 'S3 Bucket should have access logging configured',
          logical_resource_ids: ['S3Bucket'],
          line_numbers: [5]
        },
        {
          id: 'F14',
          type: 'FAIL',
          message: 'S3 Bucket should not have a public read-write acl',
          logical_resource_ids: ['S3Bucket'],
          line_numbers: [5]
        }
      ]
    }.to_json

    { "body" => result }
  end

  def test_lambda_handler
    assert_equal(LambdaFunctions::Handler.process(event: event, context: ''), expected_result)
  end
end
