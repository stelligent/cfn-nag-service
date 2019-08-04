# handler.LambdaFunctions::Handler.process
require 'base64'
require 'json'
require 'cfn-nag-service/service'
require 'cfn-nag-service/private_key'

class Handler
  def self.process(event:,context:)
    puts event.inspect

    validation_result = valid_event?(event)
    return validation_result if validation_result

    service = CfnNagService.new(private_key: PrivateKey.new.retrieve)

    case events['resource']
    when '/status'
      service.status
    when '/scan'
      service.scan(template_body(event))
    when '/signed_scan'
      service.signed_scan(template_body(event))
    else
      error_response(
        StandardError.new(msg="#{events['resource']} is not legit resource"),
        event
      )
    end
  rescue StandardError => error
    service.error_response(error)
  end

  private

  def self.valid_event?(event)
    if events['resource'].nil?
      raise StandardError.new(msg='resource must be defined')
    end

    if event['body'].nil?
      raise StandardError.new(msg='body must be defined')
    end

    if event['body']['template_body'].nil?
      raise StandardError.new(msg='body/template_body must be defined')
    end
  rescue StandardError => error
    error_response(error, event)
  end

  def self.template_body(event)
    body = JSON.parse(event['body'])
    Base64.decode64(body['template_body'])
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
