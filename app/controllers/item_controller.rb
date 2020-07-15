class ItemController < ApplicationController
  #  https://googleapis.dev/ruby/google-api-client/latest
  include ItemHelper
  def index
  end

  def oauth2login
    client = UserServices::UserAuthorizer.new_client(session[:user_id])
    client.code= params[:code]
    client.fetch_access_token!
    p client
    session[:user_id] = User.authenticate_new.session_id if session[:user_id].nil?
    user_id = session[:user_id]
    p user_id
    UserServices::UserAuthorizer.store_client(user_id: user_id, client: client)
  end
  
end
