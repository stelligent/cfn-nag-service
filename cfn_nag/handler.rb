# handler.LambdaFunctions::Handler.process
require 'cfn-nag'
require 'base64'
require 'json'
require 'rbnacl'

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
          "body" => response
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
      result_string =
        if event['resource'] == '/scan_secure'
          'Not implemented yet'
        else
          result_string
        end

      return result_string unless param_truthy?(params['return_template']) ||
                                  param_truthy?(params['return_rules'])

      response = {
        'result' => result_string
      }

      if param_truthy?(params['return_template'])
        response['template'] = event['body']['template_body']
      end

      if param_truthy?(params['return_rules'])
        response['rules'] = get_rules
      end

      response
    end

    def self.param_truthy?(param)
      param.to_s.casecmp('true').zero?
    end

    def self.get_rules
      custom_rule_loader = CustomRuleLoader.new
      rules = custom_rule_loader.rule_definitions.rules
      rules.to_json
    end

    def self.scan_file(cfn_nag, template_body)
      audit_result = cfn_nag.audit(cloudformation_string: template_body)
      audit_result[:violations] = audit_result[:violations].map(&:to_h)
      audit_result.to_json.to_s
    end
  end
end
