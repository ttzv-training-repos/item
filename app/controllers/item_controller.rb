class ItemController < ApplicationController

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
      :scope => 'email profile',
      :redirect_uri => client_secret[:redirect_uris][0]
    )

    client.code = params[:code]
    client.fetch_access_token!
    Google::Apis::RequestOptions.default.authorization = client

    profile = Google::Apis::GmailV1::Profile.new
    p profile.email_address
  end
  
end
