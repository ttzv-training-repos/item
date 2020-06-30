class Office < ApplicationRecord
  has_many :ad_user_details
  has_many :ad_users, :through => :ad_user_details
end
