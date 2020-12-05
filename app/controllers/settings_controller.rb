class SettingsController < ApplicationController
  include SettingsHelper
  before_action :authenticate_user!

  def index
    @sent_items = SentItem.all
    @smtp_setting = current_user.smtp_setting
    @smtp_setting = SmtpSetting.new if @smtp_setting.nil?
    @pwd_val = @smtp_setting.password_def_value(cookies[:smtp_password])
  end

  def run_autobinder
    AdUserServices::UserOfficeBinder.new.run
    redirect_to ad_users_path
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
  end

  def sync_ldap
    ldap_sync = LdapServices::LdapSync.new(LdapServices::LdapConn.new)
    ldap_sync.sync
    redirect_to(ad_users_path)
  end

end
