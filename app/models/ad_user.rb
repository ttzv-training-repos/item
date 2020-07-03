class AdUser < ApplicationRecord
  has_one :ad_user_detail, dependent: :destroy
  has_one :office, :through => :ad_user_detail
end
