# encoding: utf-8

require 'google_drive'

client = OAuth2::Client.new(
  '',
  '',
  :site => "https://accounts.google.com",
  :token_url => "/o/oauth2/token",
  :authorize_url => "/o/oauth2/auth")

authentication_url = client.auth_code.authorize_url(
    :redirect_uri => 'urn:ietf:wg:oauth:2.0:oob',
    :scope => 'https://spreadsheets.google.com/feeds/')

p authentication_url
