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
    params_hash = ad_user_detail_params
    params_hash[:office_id] = Office.dummy.id if params_hash[:office_id].empty?
    @ad_user_detail.update(params_hash)
  end
  
  def create
    @ad_user_detail = AdUserDetail.create(ad_user_id: params[:ad_user_id])
    @ad_user_detail.update(ad_user_detail_params)
    @ad_user_detail.save
  end

end
