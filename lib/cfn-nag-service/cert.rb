class Cert
  def public_path
    return ENV['cert_public_path'] unless ENV['cert_public_path'].nil? || ENV['cert_public_path'] == ''

    #coupled with Dockerfile openssl command
    '/cert.pem'
  end

  def private_path
    return ENV['cert_private_path'] unless ENV['cert_private_path'].nil? || ENV['cert_private_path'] == ''

    #coupled with Dockerfile openssl command
    '/key.pem'
  end
end