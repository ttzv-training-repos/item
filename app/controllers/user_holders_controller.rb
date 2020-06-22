class UserHoldersController < ApplicationController
  def index
    user_id = session[:user_id]
    @users = UserHolder.where(user_id: user_id).pluck(:content)
  end

  def select
    user_id = session[:user_id]
    p user_id
    if user_id.nil?
      user_id = UserHolder.order(:user_id).first.user_id
      if user_id.nil? 
        user_id = 1
      else
        user_id += 1
      end
      session[:user_id] = user_id
    end
    users = params[:users]
    selected = UserHolder.where(user_id: user_id).pluck(:content)
    users.filter! { |u| !selected.include?(u) }
    if users.length > 0
      users.each { |u| UserHolder.create({user_id: user_id, content: u}) }
    end
  end

  def show
    
  end

end
