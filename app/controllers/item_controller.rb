class ItemController < ApplicationController
  protect_from_forgery with: :null_session
  def all_users
    render :json => {headers: AdUserHeader.en_headers, users: AdUser.all.as_json}
  end

  
end
