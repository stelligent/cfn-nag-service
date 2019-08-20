# frozen_string_literal: true

require 'sinatra'
require 'cfn-nag-service/service'
require 'cfn-nag-service/private_key'
require 'cfn-nag-service/cert'
require 'webrick'
require 'webrick/https'

set :bind, '0.0.0.0'

use_https = %w[self cert].include?(ENV['use_https'])
if use_https
  set :server_settings,
      SSLEnable: true,
      SSLCertName: [['CN', WEBrick::Utils.getservername]]
end

if ENV['use_https'] == 'cert'
  set :server_settings,
      SSLCertificate: Cert.new.public_cert,
      SSLPrivateKey: Cert.new.private_key
  # else use the generated self-signed cert that comes with webrick/rack
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
