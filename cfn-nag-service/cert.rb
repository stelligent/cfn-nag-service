# frozen_string_literal: true

require 'openssl'

class Cert
  def public_cert
    raise StandardError('cert_public_path not defined') unless ENV['cert_public_path']

    OpenSSL::X509::Certificate.new(File.open(ENV['cert_public_path']).read)
  end

  def private_key
    raise StandardError('cert_private_path not defined') unless ENV['cert_private_path']

    OpenSSL::PKey::RSA.new(File.open(ENV['cert_private_path']).read)
  end
end
