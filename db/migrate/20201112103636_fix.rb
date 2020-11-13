class Fix < ActiveRecord::Migration[6.0]
  def change
    rename_column :smtp_settings, :store_pasword, :store_password
  end
end
