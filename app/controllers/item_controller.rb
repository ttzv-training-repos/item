class ItemController < ApplicationController
  include ItemHelper
  
  def index
    @user_id = current_user || nil
    @users = User.all
  end
  
end
