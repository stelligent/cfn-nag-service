#!/usr/bin/env ruby

require 'base64'
require 'rbnacl'
require 'aws-sdk-ssm'

signing_key = RbNaCl::SigningKey.generate
encoded_signing_key = Base64.encode64 signing_key
verify_key = verify_key = signing_key.verify_key
encoded_verify_key = Base64.encode64 verify_key

ssm = Aws::SSM::Client.new(region: 'us-east-1')
ssm.put_parameter({
  name: "/CfnNagService/signing_key",
  description: "Signing Key for /scan_secure requests for CFN Nag Service",
  value: encoded_signing_key,
  type: "SecureString"
})
ssm.put_parameter({
  name: "/CfnNagService/verify_key",
  description: "Verification Key for /scan_secure requests for CFN Nag Service",
  value: encoded_verify_key,
  type: "SecureString"
})
