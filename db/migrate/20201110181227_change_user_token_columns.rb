class ChangeUserTokenColumns < ActiveRecord::Migration[6.0]
  def change
    remove_column :users, :refresh_token
    remove_column :users, :access_token
    add_column :users, :google_client, :text
  end
end
