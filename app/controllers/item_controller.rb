class ItemController < ApplicationController
  include ItemHelper
  
  def index
    @user_id = current_user || nil
  end

  def oauth2login
    # Not used, code moved to Users::OmniauthCallbacksController#google_oauth2
  end

  def google_login
    # functionality handled by devise
    # authorizer = UserServices::UserAuthorizer.new(current_user)
    # client = authorizer.client
    # if client
    #   redirect_to root_path
    # else
    #   google_new_authorization
    # end
  end

  def google_logout
    # functionality handled by devise
    # current_user.update(google_client: nil)
    # session[:user_id] = nil
    # redirect_to root_path
  end

  private

  def invalid_query_string
    redirect_to root_path if params[:code].nil?
    params[:code].nil?
  end
  
end
