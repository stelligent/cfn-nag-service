FROM ruby:2.5-alpine3.9@sha256:f33782620b363575ad95d19d0f0f07f7d197e9ccfee51f20df39dd33d408cdb4

LABEL org.opencontainers.image.authors="eric.kascic@stelligent.com"

RUN apk add openssl build-base libffi libsodium

# could be more selective
COPY . /

RUN gem install bundler
RUN bundle install

# none | self | cert
ENV use_https 'self'
ENV cert_public_path ''
ENV cert_private_path ''

# signing key settings
ENV private_key_ssm_path ''
ENV private_key_override ''

ENV AWS_REGION us-east-1

ENTRYPOINT ruby -I / /cfn-nag-service/sinatra.rb

