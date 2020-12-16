class AdUserDetailsController < ApplicationController
  include AdUserDetailsHelper
  def new
    @ad_user_detail = AdUserDetail.new
  end

  def edit
    @ad_user_detail = AdUserDetail.find_or_create_by(ad_user_id: params[:ad_user_id])
    @storage = @ad_user_detail.storage_json
    @ad_user = @ad_user_detail.ad_user
  end

  def update
    @ad_user_detail = AdUserDetail.find_or_create_by(ad_user_id: params[:ad_user_id])
    @ad_user_detail.update(ad_user_detail_params)
    redirect_to ad_users_path
  end
  
  def create
    @ad_user_detail = AdUserDetail.create(ad_user_id: params[:ad_user_id])
    @ad_user_detail.update(ad_user_detail_params)
    @ad_user_detail.save
    redirect_to ad_users_path
  end

end
