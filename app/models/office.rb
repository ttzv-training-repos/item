class Office < ApplicationRecord
  has_many :ad_user_details, dependent: :nullify
  has_many :ad_users, :through => :ad_user_details

  def values_to_s
    self.as_json.values.join(", ")
  end

  def display_office_info
    values_to_s
  end

  #skips dummy office
  def self.selectable
    Office.where.not(name: nil)
  end

  def self.dummy
    Office.find_by(name: nil)
  end

end
