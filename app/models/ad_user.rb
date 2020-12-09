class AdUser < ApplicationRecord
  has_one :ad_user_detail, dependent: :destroy
  has_one :office, :through => :ad_user_detail

  def get_attr(column, table)
    return self[column] if table == "ad_users"
    return self.ad_user_detail[column] if table == "ad_user_details"
    return self.office[column] if table == "offices"
  end
end
