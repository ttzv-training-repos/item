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

end
