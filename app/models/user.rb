class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:google_oauth2, :ldap]

  has_one :setting, dependent: :destroy
  has_one :smtp_setting, dependent: :destroy
  has_many :user_holders, dependent: :destroy
  has_one :employee

  after_create :create_employee_if_not_exist

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
    client = Hash.new
    client[:access_token] = credentials['token']
    client[:refresh_token] = credentials['refresh_token']
    client[:expires_at] = credentials['expires_at']

    if user
      user.update(google_client: client.to_json)
    else
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

  private

  def create_employee_if_not_exist
    self.create_employee if self.employee.nil?
  end


end
