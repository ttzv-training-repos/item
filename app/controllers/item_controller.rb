class ItemController < ApplicationController
  require 'google/apis/options'
  include ItemHelper
  
  def index
    client = google_auth_client
    if client.nil?
      picture_url = ""
    else
      profile = GoogleApiServices::ProfileService.new(client)
      picture_url = profile.picture
    end
    @google_profile_img = picture_url
    @user_id = current_user
  end

  def oauth2login
    return if invalid_query_string
    user_id = current_user
    client = UserServices::UserAuthorizer.load_client(user_id)
    client.code= params[:code]
    client.fetch_access_token!
    UserServices::UserAuthorizer.store_client(user_id: user_id, client: client)
    redirect_to root_path
  end

  def google_login
    user_id = current_user
    client = UserServices::UserAuthorizer.client(user_id)
    unless client.nil?
      redirect_to root_path
    else
      client = UserServices::UserAuthorizer.new_client
      UserServices::UserAuthorizer.store_client(user_id: user_id, client: client)
      redirect_to client.authorization_uri.to_s
    end
  end

  def google_logout
    UserServices::UserAuthorizer.remove(current_user)
    redirect_to root_path
  end

  private

  def invalid_query_string
    redirect_to root_path if params[:code].nil?
    params[:code].nil?
  end
  
end
