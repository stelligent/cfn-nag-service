# cfn-nag-lambda-handler.LambdaFunctions::Handler.process
require 'cfn-nag'
require 'base64'

module LambdaFunctions
  class Handler
    def self.process(event:,context:)
        #template_body = JSON.parse(event['template_body'])
        #template_body = JSON.pretty_generate(template_body)
        template_body = Base64.decode64(event['template_body'])
        aggregate_results = []
        config = CfnNagConfig.new
        cfn_nag = CfnNag.new(config: config)

        aggregate_results << scan_file(cfn_nag, template_body)

        cfn_nag.render_results(aggregate_results: aggregate_results,
                               output_format: 'json')
    end

    def self.scan_file(cfn_nag, template_body)
      audit_result = cfn_nag.audit(cloudformation_string: template_body)

      {
        filename: 'lambda_payload',
        file_results: audit_result
      }
    end
  end
end
