# handler.LambdaFunctions::Handler.process
require 'cfn-nag'
require 'base64'
require 'json'
require 'rbnacl'
require 'aws-sdk-ssm'

module LambdaFunctions
  class Handler
    def self.process(event:,context:)
        puts event.inspect
        body = JSON.parse(event['body'])
        template_body = Base64.decode64(body['template_body'])
        aggregate_results = []
        config = CfnNagConfig.new
        cfn_nag = CfnNag.new(config: config)

        result_string = scan_file(cfn_nag, template_body)
        response = build_response(result_string, event)

        {
          "body" => response.to_json.to_s
        }
    rescue StandardError => error
      {
        "body" => {
          "error_message": error.message,
          "error_type": error.class,
          "stacktrace": error.backtrace,
          "event": event
        }.to_json.to_s
      }
    end

    def self.build_response(result_string, event)
      params = event['queryStringParameters']
      return_template = param_truthy?(params, 'return_template')
      return_rules = param_truthy?(params, 'return_rules')
      sign_request = event['resource'] == '/scan_secure'
      return result_string unless return_template || return_rules || sign_request

      response = {
        'results' => result_string
      }

      response['signature'] = sign_results(result_string) if sign_request
      response['template'] = JSON.parse(event['body'])['template_body'] if return_template
      response['rules'] = get_rules if return_rules
      response
    end

    def self.sign_results(result_string)
      key_seed = retrieve_signing_key
      document = result_string.to_json.to_s
      puts "Signing document:"
      puts document
      signing_key = RbNaCl::SigningKey.new(key_seed)
      signature = signing_key.sign(document)
      Base64.strict_encode64 signature
    end

    def self.param_truthy?(params, param_name)
      return false if params.nil? || params.empty?
      params.key?(param_name) && params[param_name].to_s.casecmp('true').zero?
    end

    def self.retrieve_signing_key
      ssm = Aws::SSM::Client.new(region: 'us-east-1')
      response = ssm.get_parameter({
        name: '/CfnNagService/signing_key',
        with_decryption: true
      })
      encoded_key = response.parameter.value
      Base64.decode64 encoded_key
    end

    def self.get_rules
      custom_rule_loader = CustomRuleLoader.new
      custom_rule_loader.rule_definitions.rules
    end

    def self.scan_file(cfn_nag, template_body)
      audit_result = cfn_nag.audit(cloudformation_string: template_body)
      audit_result[:violations] = audit_result[:violations].map(&:to_h)
      audit_result
    end
  end
end
