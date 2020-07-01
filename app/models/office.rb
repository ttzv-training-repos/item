class Office < ApplicationRecord
  has_many :ad_user_details, dependent: :nullify
  has_many :ad_users, :through => :ad_user_details

  def values_to_s
    self.as_json.values.join(", ")
  end


end
