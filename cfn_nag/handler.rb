# handler.LambdaFunctions::Handler.process
require 'cfn-nag'
require 'base64'
require 'json'

module LambdaFunctions
  class Handler
    def self.process(event:,context:)
        body = JSON.parse(event['body'])
        template_body = Base64.decode64(body['template_body'])
        aggregate_results = []
        config = CfnNagConfig.new
        cfn_nag = CfnNag.new(config: config)

        result_string = scan_file(cfn_nag, template_body)

        {
          "body" => result_string
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

    def self.scan_file(cfn_nag, template_body)
      audit_result = cfn_nag.audit(cloudformation_string: template_body)
      audit_result[:violations] = audit_result[:violations].map(&:to_h)
      audit_result.to_json.to_s
    end
  end
end
