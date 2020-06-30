class AdUser < ApplicationRecord
  has_one :ad_user_detail
  has_one :office, :through => :ad_user_detail
end
