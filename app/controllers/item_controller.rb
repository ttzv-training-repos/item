class ItemController < ApplicationController
  
  def all_users
    render :json => {headers: AdUserHeader.en_headers, users: AdUser.all.as_json}
  end

  
end
