module TagCustomMasksHelper

  TABLE_SEPARATOR = '#'

  def mask_params
    params.require(:tag_custom_mask).permit(:value)
  end

  def available_attributes
    ad_user_attr = AdUser.column_names.map do |c|
      "#{AdUser.table_name}##{c}"
    end
    ad_user_detail_attr = AdUserDetail.column_names.map do |c|
      "#{AdUserDetail.table_name}##{c}"
    end
    office_attr = Office.column_names.map do |c|
      "#{Office.table_name}##{c}"
    end
    ad_user_attr + ad_user_detail_attr + office_attr
  end

  def params_for_preview
    params.permit(:ad_users_id,
                  :template_id,
                  :itemtag_id)    
  end

end
