#!/usr/bin/env ruby

require 'rbnacl'
require 'base64'

puts "Enter Base64 encoded signature:"
signature = gets.chomp
puts "Enter Base64 encoded verification key"
verify_key = gets.chomp
puts "Enter in Base64 encoded results"
document_encoded = gets.chomp

signature = Base64.strict_decode64(signature.chomp)
verify_key = RbNaCl::VerifyKey.new(Base64.strict_decode64(verify_key.chomp))

begin
  puts "Signature is valid!" if verify_key.verify(signature, document_encoded)
rescue RbNaCl::BadSignatureError
  puts "Signature is not valid!"
  exit 1
end
