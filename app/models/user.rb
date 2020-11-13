class User < ApplicationRecord

  has_one :setting, dependent: :destroy
  has_one :smtp_setting, dependent: :destroy
  has_many :user_holders, dependent: :destroy

  def self.authenticate_new
    user = User.create(name: 'Stranger')
  end

  def picture
    return picture_local if picture_local.present?
    return picture_google if picture_google.present?
    return ''
  end

end
