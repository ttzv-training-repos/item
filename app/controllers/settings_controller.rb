class SettingsController < ApplicationController
  include SettingsHelper
  before_action :authenticate_user!
  before_action :not_available, only: [:sync_ldap, :update_gmail_authorization, :update_ldap_settings, :update_sms_settings ]

  def index
    @smtp_setting = current_user.smtp_setting
    @smtp_setting = SmtpSetting.new if @smtp_setting.nil?
    @current_user_can_send_gmail = current_user.can_send_gmail?
    @pwd_val_smtp = @smtp_setting.password_def_value(cookies[:smtp_password])

    @ldap_setting = current_user.ldap_setting
    @ldap_setting = LdapSetting.new if @ldap_setting.nil?
    @pwd_val_ldap = @ldap_setting.password_def_value

    @sms_setting = current_user.sms_setting
    @sms_setting = SmsSetting.new if @sms_setting.nil?
    @pwd_val_sms = @sms_setting.password_def_value(nil, :token)
  end

  def run_autobinder
    AdUserServices::UserOfficeBinder.new.run
    flash_ajax_notice("Autobind finished, check Users list")
  end

  def process_request
    settings_params.each do |entry| 
      tag = TemplateTag.find_by(name: entry.first)
      tag.update(default_value_mask: entry.last) unless entry.last.empty?
    end
  end

  def update_smtp_settings
    hash = {
      sender: smtp_params[:sender],
      address: smtp_params[:address],
      port: smtp_params[:port],
      domain: smtp_params[:domain],
      user_name: smtp_params[:user_name],
      store_password: smtp_params[:store_password],
      authentication: smtp_params[:authentication],
      tls: smtp_params[:tls]
    }

    if smtp_params[:password] != MASKED_PASSWORD
      if smtp_params[:store_password] === 1
        hash[:password] = smtp_params[:password]
        cookies[:smtp_password] = nil
      else
        hash[:password] = nil
        cookies[:smtp_password] = smtp_params[:password]
      end
    end

    @smtp_setting = current_user.smtp_setting

    if @smtp_setting
      @smtp_setting.update(hash)
    else
      @smtp_setting = current_user.create_smtp_setting(hash)
    end

    if current_user.can_send_gmail?
      current_user.update(use_gmail_api: false)
      redirect_to user_google_oauth2_omniauth_authorize_path
    else
      redirect_to settings_path
    end
  end

  def update_gmail_authorization
    use_gmail_api = params[:use_gmail_api]
    current_user.update(use_gmail_api: use_gmail_api)
    if use_gmail_api == "true" and !current_user.can_send_gmail?
      redirect_to user_google_oauth2_omniauth_authorize_path(scope: 'gmail.send', include_granted_scopes: true)
    else
      redirect_to settings_path
    end
  end

  def sync_ldap
    AdUser.synchronize_with_ldap(
      LdapServices::LdapConn.new(
        LdapSetting.default)
      )
    redirect_to(ad_users_path)
  end

  def update_ldap_settings
    ldap_setting = current_user.ldap_setting
    ldap_setting = current_user.create_ldap_setting if ldap_setting.nil?
    if ldap_params[:default] == "1"
      LdapSetting.where.not(id: ldap_setting.id).update(default: false)
    end
    hash = ldap_params
    hash.delete(:password) if hash[:password] == MASKED_PASSWORD
    ldap_setting.update(hash)
  end

  def update_app_settings

  end

  def update_sms_settings
    #check if new token
    sms_setting = current_user.sms_setting
    sms_setting = current_user.create_sms_setting if sms_setting.nil?
    if sms_params[:default] == "1"
      SmsSetting.where.not(id: sms_setting.id).update(default: false)
    end
    hash = sms_params
    hash.delete(:token) if hash[:token] == MASKED_PASSWORD
    sms_setting.update(hash)
  end

  private

  def not_available
    flash_ajax_alert("Not available in preview")
  end

end
