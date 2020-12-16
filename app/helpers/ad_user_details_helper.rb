module AdUserDetailsHelper

  def ad_user_detail_params
    params.require(:ad_user_detail).permit(
      :office_id,
      :position,
      :phonenumber,
      :phonenumber_2
    )
  end

end
