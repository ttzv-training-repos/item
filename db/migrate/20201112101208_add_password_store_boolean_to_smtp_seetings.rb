class AddPasswordStoreBooleanToSmtpSeetings < ActiveRecord::Migration[6.0]
  def change
    add_column :smtp_settings, :store_pasword, :boolean
  end
end
