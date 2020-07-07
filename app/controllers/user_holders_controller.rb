class UserHoldersController < ApplicationController
  include UserHoldersHelper
  def index #DRY!!! TEMPORARY
    user_id = session[:user_id]
    user_id = 0 if user_id.nil?
    selected_users = UserHolder.where(user_id: user_id).pluck(:objectguid)
    @holder = AdUser.joins("INNER JOIN user_holders ON ad_users.objectguid = user_holders.objectguid AND user_id = #{user_id}").pluck(:displayname)
  end

  def process_request
    user_id = session[:user_id]
    req_proc = AdUserServices::UserHolderRequestProcessor.new(user_id)
    session[:user_id] = req_proc.session_id if user_id.nil?
    status = req_proc.process(params[:cart_request])
    # incoming requests contain name of the action and array of objects to perform this action on
    # available requests: 
    # select: clears previous content and adds array of users to cart
    # add: append selected users to cart
    # delete: delete selected users from cart
    # clear: empty cart
    # content: returns currently selected users
    # JSON format: cart_request: {action: actionname, data: [user1, user2, user3]}
    render :json => {
      action: req_proc.action,
      status: status,
      data: users_from_guids(req_proc.response_data).as_json
    }
  end

end
