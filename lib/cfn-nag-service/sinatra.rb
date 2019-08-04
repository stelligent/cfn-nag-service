require 'sinatra'
require 'cfn-nag-service/service'
require 'cfn-nag-service/private_key'
require 'sinatra/base'
require 'webrick'
require 'webrick/https'
require 'openssl'
require 'cfn-nag-service/cert'

set :bind, '0.0.0.0'

set :server_settings,
    SSLEnable: true,
    SSLCertName: [['CN', WEBrick::Utils.getservername]]

if !ENV['cert_public_path'].nil? || ENV['cert_public_path'] != ''
  set :ssl_certificate, Cert.new.public_path
  set :ssl_key, Cert.new.private_path
end

cfn_nag_service = CfnNagService.new(private_key: PrivateKey.new.retrieve)

get '/cfn_nag/v1/status' do
  cfn_nag_service.status.to_json
end

post '/cfn_nag/v1/scan' do
  cfn_nag_service.scan(request.body.string).to_json
end

post '/cfn_nag/v1/signed_scan' do
  cfn_nag_service.signed_scan(request.body.string).to_json
end

