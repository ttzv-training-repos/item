class ItemController < ApplicationController
  include ItemHelper

  def index
    user_id = session[:user_id]
    selected_users = UserHolder.where(user_id: user_id).pluck(:objectguid)
    @holder = AdUser.joins("INNER JOIN user_holders ON ad_users.objectguid = user_holders.objectguid AND user_id = #{user_id}").pluck(:displayname)
  end
  
  def all_users
    render :json => {headers: AdUserHeader.en_headers, users: AdUser.all.as_json}
  end
  
end
