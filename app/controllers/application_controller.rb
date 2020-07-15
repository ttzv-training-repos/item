class ApplicationController < ActionController::Base

  def index
  end

  protected
  
  def google_auth_client
    user_id = current_user
    UserServices::UserAuthorizer.client(user_id)
  end

  def current_user
    session[:user_id] = User.authenticate_new.session_id if session[:user_id].nil?
    user_id = session[:user_id]
  end

end
