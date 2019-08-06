require 'aws-sdk-ssm'

##
# might plug/play this with ssm, secrets mgr or whatever?
#
class PrivateKey
  def retrieve
    return Base64.decode64 (ENV['private_key_override']) unless ENV['private_key_override'].nil? || ENV['private_key_override'] == ''

    retrieve_private_key_from_ssm
  end

  private

  def retrieve_private_key_from_ssm
    private_key_ssm_path = ENV['private_key_ssm_path']
    puts private_key_ssm_path
    raise StandardError.new('private_key_ssm_path not defined') unless private_key_ssm_path

    # possibly move to a factory where we can configure the client a little better (assume role etc)
    ssm = Aws::SSM::Client.new
    get_parameter_response = ssm.get_parameter(
      name: private_key_ssm_path,
      with_decryption: true
    )
    encoded_key = get_parameter_response.parameter.value
    Base64.decode64 encoded_key
  end
end

