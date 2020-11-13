class SmtpSetting < ApplicationRecord

  def password_def_value(force_mask=nil)
    return MASKED_PASSWORD if force_mask
    password.present? ? MASKED_PASSWORD : ''
  end
end
