# handler.LambdaFunctions::Handler.process
require 'base64'
require 'json'
require 'cfn-nag-service/service'
require 'cfn-nag-service/private_key'

##
# This is a Lambda frontend to CfnNagService.
#
# In turn this expects to act as a "lambda proxy" for an API GW created via SAM
#
# For information on the required request/response interface for working with GW, see:
# https://aws.amazon.com/premiumsupport/knowledge-center/malformed-502-api-gateway/
class Handler
  def self.process(event:,context:)
    if ENV['DEBUG']
      puts event.inspect
      ENV.each { |k,v| puts "#{k}=#{v}" }
    end

    service = CfnNagService.new(private_key: private_key)

    case event['resource']
    when '/status'
      service.status

    when '/scan'
      validation_result = valid_event?(event)
      return validation_result if validation_result

      success_response(service.scan(template_body(event)))

    when '/signed_scan'
      validation_result = valid_event?(event)
      return validation_result if validation_result

      success_response(service.signed_scan(template_body(event)))

    else
      error_response(
        StandardError.new(msg="#{event['resource']} is not legit resource"),
        event
      )
    end
  rescue StandardError => error
    error_response(error, event)
  end

  private

  def self.private_key
    PrivateKey.new.retrieve
  end

  def self.valid_event?(event)
    if event['resource'].nil?
      raise StandardError.new(msg='resource must be defined')
    end

    if event['body'].nil?
      raise StandardError.new(msg='body must be defined')
    end
  rescue StandardError => error
    error_response(error, event)
  end

  def self.template_body(event)
    event['body']
  end

  def self.success_response(result)
    {
      'statusCode' => 200,
      'body' => result.to_json.to_s
    }
  end

  def self.error_response(error, event)
    {
      'body' => {
        'error_message' => error.message,
        'error_type' => error.class,
        'stacktrace' => error.backtrace,
        'event' => event
      }.to_json.to_s
    }
  end
end
