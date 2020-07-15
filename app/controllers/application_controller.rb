class ApplicationController < ActionController::Base

  def index
  end

  protected
  
  def google_auth_client
    session[:user_id] = User.authenticate_new.session_id if session[:user_id].nil?
    user_id = session[:user_id]
    UserServices::UserAuthorizer.client(user_id)
  end

end
