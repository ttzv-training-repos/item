class ApplicationController < ActionController::Base
  before_action :get_user_profile
  def index
  end

  protected
  
  def google_auth_client
    authorizer = UserServices::UserAuthorizer.new(current_user)
    client = authorizer.client
  end

  def google_new_authorization
    redirect_to UserServices::UserAuthorizer.new_client.authorization_uri.to_s
  end

  def current_user
    if session[:user_id]
      @current_user = User.find(session[:user_id]) 
    else
      @current_user = User.authenticate_new
      session[:user_id] = @current_user.id
    end
    @current_user
  end

  def get_user_profile
    @google_logged_in = logged_in?
    @user_profile = current_user
  end

  def flash_ajax_notice(text)
    flash.now[:notice] = text
    render partial: "shared/notice"
  end

  def flash_ajax_alert(text)
    flash.now[:alert] = text
    render partial: "shared/alert"
  end

  def logged_in?
    !google_auth_client.nil?
  end

end
