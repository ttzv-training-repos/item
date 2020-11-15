class UsersController < ApplicationController

  def become
    #return unless current_user.is_an_admin? need to implement this
    sign_in(:user, User.find(params[:id]))
    redirect_to root_url # or user_root_url
  end

end
