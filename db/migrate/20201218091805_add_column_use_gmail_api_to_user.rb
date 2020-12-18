class AddColumnUseGmailApiToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :use_gmail_api, :boolean
  end
end
