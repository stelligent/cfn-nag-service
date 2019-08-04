require 'aws-sdk-ssm'

##
# might plug/play this with ssm, secrets mgr or whatever?
#
class PrivateKey
  def retrieve
    return ENV['private_key_override'] unless ENV['private_key_override'].nil?

    retrieve_private_key_from_ssm
  end

  private

  def retrieve_private_key_from_ssm
    private_key_ssm_path = ENV['private_key_ssm_path']
    raise StandardError('private_key_ssm_path not defined') unless private_key_ssm_path

    ssm = Aws::SSM::Client.new
    response = ssm.get_parameter(
      name: private_key_ssm_path,
      with_decryption: true
    )
    encoded_key = response.parameter.value
    Base64.decode64 encoded_key
  end
end

