class AddColumnSenderToUserSettings < ActiveRecord::Migration[6.0]
  def change
    add_column :smtp_settings, :sender, :string
  end
end
