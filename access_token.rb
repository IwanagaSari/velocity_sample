# encoding: utf-8

require 'google_drive'


client = OAuth2::Client.new(
  '',
  '',
  :site => "https://accounts.google.com",
  :token_url => "/o/oauth2/token",
  :authorize_url => "/o/oauth2/auth")

auth_token = client.auth_code.get_token(
  '',
  :redirect_uri => 'urn:ietf:wg:oauth:2.0:oob')

p auth_token
