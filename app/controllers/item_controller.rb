class ItemController < ApplicationController
  include ItemHelper
  
  def index
    @user_id = current_user.id
  end

  def oauth2login
    client = UserServices::UserAuthorizer.new_client
    client.code = params[:code]
    client.fetch_access_token!
    profile = fetch_google_profile(client)
    user = User.find_by(email: profile[:email])
    session[:user_id] = user.id unless user.nil?
    current_user.update(
      google_client: client.to_json,
      name: profile[:name],
      email: profile[:email],
      picture_google: profile[:picture],
      anonymous: false
    )
    redirect_to root_path
  end

  def google_login
    authorizer = UserServices::UserAuthorizer.new(current_user)
    client = authorizer.client
    if client
      redirect_to root_path
    else
      google_new_authorization
    end
  end

  def google_logout
    current_user.update(google_client: nil)
    session[:user_id] = nil
    redirect_to root_path
  end

  private

  def invalid_query_string
    redirect_to root_path if params[:code].nil?
    params[:code].nil?
  end
  
end
