class ItemController < ApplicationController
  include ItemHelper
  
  def all_users
    render :json => {headers: AdUserHeader.en_headers, users: AdUser.all.as_json}
  end
  
end
