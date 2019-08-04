FROM ruby:2.5-alpine3.9@sha256:f33782620b363575ad95d19d0f0f07f7d197e9ccfee51f20df39dd33d408cdb4

LABEL org.opencontainers.image.authors="eric.kascic@stelligent.com"

EXPOSE 4567

RUN apk add openssl build-base libffi libsodium

RUN openssl req -x509 -newkey rsa:4096 -keyout key.pem -out cert.pem -nodes -days 365 -subj '/CN=localhost'

# could be more selective
COPY . /

RUN gem install bundler
RUN bundle install

ENV private_key_ssm_path ''
ENV private_key_override ''
ENV cert_public_path ''
ENV cert_private_path ''

ENTRYPOINT ruby -I /lib /lib/cfn-nag-service/sinatra.rb

