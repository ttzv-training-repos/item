class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:google_oauth2, :ldap]

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

  def self.from_omniauth(access_token)
    credentials = access_token.credentials
    data = access_token.info
    user = User.where(email: data['email']).first

    unless user
        client = Hash.new
        client[:access_token] = credentials['token']
        client[:refresh_token] = credentials['refresh_token']
        client[:expires_at] = credentials['expires_at']
        user = User.create(name: data['name'],
            email: data['email'],
            password: Devise.friendly_token[0,20],
            google_client: client.to_json,
            picture_google: data['image'],
            anonymous: false
        )
    end
    user
end

end
