module SettingsHelper

  def smtp_params
    params.require(:smtp_setting).permit(
      :sender,
      :address,
      :port,
      :domain,
      :user_name,
      :store_password,
      :password,
      :authentication,
      :tls
    )
  end

  def ldap_params
    params.require(:ldap_setting).permit(
      :host,
      :base,
      :port,
      :login,
      :password,
      :default
    )
  end

  def sms_params
    params.require(:sms_setting).permit(
      :token,
      :sender_name,
      :default
    )
  end

end
