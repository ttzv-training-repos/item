class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def password_def_value(force_mask=nil, pwd_column=nil)
    return MASKED_PASSWORD if force_mask
    pwd_column = :password if pwd_column.nil?
    self[pwd_column].present? ? MASKED_PASSWORD : ''
  end
  
end
