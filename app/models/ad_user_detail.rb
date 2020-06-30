class AdUserDetail < ApplicationRecord
  belongs_to :ad_user
  has_one :office
end
