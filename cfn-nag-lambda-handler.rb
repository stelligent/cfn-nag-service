# cfn-nag-lambda-handler.LambdaFunctions::Handler.process
require 'cfn-nag'
require 'base64'

module LambdaFunctions
  class Handler
    def self.process(event:,context:)
        template_body = Base64.decode64(event['template_body'])
        aggregate_results = []
        config = CfnNagConfig.new
        cfn_nag = CfnNag.new(config: config)

        scan_file(cfn_nag, template_body)
    end

    def self.scan_file(cfn_nag, template_body)
      audit_result = cfn_nag.audit(cloudformation_string: template_body)
      audit_result[:violations] = audit_result[:violations].map(&:to_h)
      audit_result
    end
  end
end
