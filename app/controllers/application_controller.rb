class ApplicationController < ActionController::Base
  def index
  end

  protected
  
  def google_auth_client
    authorizer = UserServices::UserAuthorizer.new(current_user)
    client = authorizer.client
  end

  def current_user_old
    if session[:user_id]
      @current_user = User.find(session[:user_id]) 
    else
      @current_user = User.authenticate_new
      session[:user_id] = @current_user.id
    end
    @current_user
  end

  def flash_ajax_notice(text)
    flash.now[:notice] = text
    render partial: "shared/notice"
  end

  def flash_ajax_alert(text)
    flash.now[:alert] = text
    render partial: "shared/alert"
  end

end
