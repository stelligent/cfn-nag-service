# handler.LambdaFunctions::Handler.process
require 'cfn-nag'
require 'base64'
require 'json'

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

        secure = event['resource'] == '/scan_secure' ? true : false
        response = build_response(result_string, secure)

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

    def self.build_payload(result_string, secure = false)
      if secure
        "Not implemented yet"
      else
        result_string
      end
    end

    def self.scan_file(cfn_nag, template_body)
      audit_result = cfn_nag.audit(cloudformation_string: template_body)
      audit_result[:violations] = audit_result[:violations].map(&:to_h)
      audit_result.to_json.to_s
    end
  end
end
