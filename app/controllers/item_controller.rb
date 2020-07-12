class ItemController < ApplicationController
  #https://www.rubydoc.info/github/google/google-api-ruby-client
  require 'google/apis/options'
  require 'google/apis/gmail_v1'
  require 'google/apis/oauth2_v2'
  def index
  end

  def oauth2login
    client_secret = JSON.parse(File.read('client_secrets.json'), symbolize_names: true)
    client_secret = client_secret[:web]
    client = Signet::OAuth2::Client.new(
      :authorization_uri => client_secret[:auth_uri],
      :token_credential_uri =>  client_secret[:token_uri],
      :client_id => client_secret[:client_id],
      :client_secret => client_secret[:client_secret],
      :scope => 'email profile openid https://www.googleapis.com/auth/gmail.send',
      :redirect_uri => client_secret[:redirect_uris][0]
    )

    client.code = params[:code]
    client.fetch_access_token!
    Google::Apis::RequestOptions.default.authorization = client

    profile = Google::Apis::Oauth2V2::Userinfo.new
    p profile.email
  end
  
end
