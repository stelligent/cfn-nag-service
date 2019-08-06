require 'json'
require 'base64'
require 'rbnacl'

##
# Anything related to encoding or generating signatures for the cfn-nag service
#
class Signatures
  ##
  # Encode a string, array or hash in strict base64 s.t. it makes life easier to verify
  # signatures (against the encoded value)
  #
  def self.encode(something)
    unless something.is_a? String
      something = something.to_json
    end
    Base64.strict_encode64 something
  end

  ##
  # Create a digital signature for a string in (strict) base64 encoding.
  #
  # @param key_seed the binary form of the key
  # @return base64 encoded version of the signature
  #
  def self.sign(key_seed, string_to_sign)
    signing_key = RbNaCl::SigningKey.new(key_seed)
    signature = signing_key.sign(string_to_sign)
    Base64.strict_encode64 signature
  end
end
