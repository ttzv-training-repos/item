class ItemController < ApplicationController
  require 'google/apis/options'
  include ItemHelper
  
  def index
    client = google_auth_client
    if client.access_token.nil?
      picture_url = ""
    else
      profile = GoogleApiServices::ProfileService.new(client)
      picture_url = profile.picture
    end
    @google_profile_img = picture_url
  end

  def oauth2login
    user_id = session[:user_id]
    client = UserServices::UserAuthorizer.client(user_id)
    client.code= params[:code]
    client.fetch_access_token!
    raise "For some reason User ID is null" if user_id.nil?
    UserServices::UserAuthorizer.store_client(user_id: user_id, client: client)
  end
  
end
