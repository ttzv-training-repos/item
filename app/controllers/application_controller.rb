class ApplicationController < ActionController::Base
  before_action :get_user_profile
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

  def get_user_profile
    client = google_auth_client
    @google_logged_in = !client.nil?
    @user_profile = GoogleApiServices::ProfileService.new(client)
  end

end
