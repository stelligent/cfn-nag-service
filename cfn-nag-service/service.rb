require 'cfn-nag'
require_relative 'signatures'
require 'rbnacl'

##
# The common source for a cfn-nag service (that both lambda and ECS/image should share)
#
class CfnNagService
  ##
  # Constructor
  #
  # @param private_key for #signed_scan, this is used for the crypto to sign the results
  #
  def initialize(private_key: null)
    @private_key = private_key
  end

  ##
  # Vanilla scan with no signatures or anything fancy
  #
  # @param template_body string representation of a cloudformation template
  # @return Hash with body key that contains Hash of results
  #
  def scan(template_body)
    audit_result = audit(cloudformation_string: template_body)
    response(audit_result)
  end

  ##
  # Scan where the rules, template and violations are all digitally signed together
  # Includes vanilla results for convenience, then the encoded results and signature additionally
  #
  # @param template_body string representation of a cloudformation template
  # @return Hash with body key that contains Hash of results
  #
  def signed_scan(template_body)
    audit_result = audit(cloudformation_string: template_body)

    signed_response(audit_result, template_body)
  end

  ##
  # This is currently bogus 100% happy status
  #
  def status
    {
      'body' => 'Service is up!'
    }
  end

  private

  def audit(cloudformation_string:)
    audit_result = cfn_nag.audit(cloudformation_string: cloudformation_string)
    audit_result[:violations] = convert_violation_objects_into_hashes audit_result
    audit_result
  end

  def convert_violation_objects_into_hashes(audit_result)
    audit_result[:violations].map(&:to_h)
  end

  def cfn_nag
    config = CfnNagConfig.new
    CfnNag.new(config: config)
  end

  def rules
    custom_rule_loader = CustomRuleLoader.new
    custom_rule_loader.rule_definitions.rules
  end

  def error_response(error)
    {
      'body' => {
        'error_message' => error.message,
        'error_type' => error.class,
        'stacktrace' => error.backtrace
      }.to_json.to_s
    }
  end

  def signed_response(audit_results, template_body)
    signed_response = response(audit_results)
    signed_response['results_encoded'] = Signatures.encode({
      'violations' => audit_results,
      'template' => template_body,
      'rules' => rules
    })
    signed_response['signature'] = Signatures.sign(
      @private_key,
      signed_response['results_encoded']
    )

    signed_response
  end

  def response(audit_results)
    {
      'results' => audit_results
    }
  end
end