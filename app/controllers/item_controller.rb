class ItemController < ApplicationController
  #  https://googleapis.dev/ruby/google-api-client/latest
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
    session[:oauth] = client.access_token
  end
  
end
