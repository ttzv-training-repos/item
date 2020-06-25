class UserHoldersController < ApplicationController
  def index
    user_id = session[:user_id]
    p user_id
    selected_users = UserHolder.where(user_id: user_id).pluck(:objectguid)
    @users = AdUser.joins("INNER JOIN user_holders ON ad_users.objectguid = user_holders.objectguid AND user_id = #{user_id}").pluck(:displayname)
  end

  def select
    user_id = session[:user_id]
    p user_id
    if user_id.nil?
      first = UserHolder.order(user_id: :desc).first
      user_id = first.user_id unless first.nil? 
      if user_id.nil? 
        user_id = 1
      else
        user_id += 1
      end
      session[:user_id] = user_id
    end
    users = params[:users]
    selected = UserHolder.where(user_id: user_id).pluck(:objectguid)
    users.filter! { |u| !selected.include?(u) }
    if users.length > 0
      users.each { |u| UserHolder.create({user_id: user_id, objectguid: u}) }
    end
  end

  def clear
    user_id = session[:user_id]
    UserHolder.where(user_id: user_id).destroy_all
  end

  def qty
    user_id = session[:user_id]
    users = UserHolder.where(user_id: user_id).pluck(:objectguid)
    render :json => {qty: users.length}
  end

end
