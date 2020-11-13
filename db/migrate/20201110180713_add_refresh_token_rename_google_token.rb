class AddRefreshTokenRenameGoogleToken < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :refresh_token, :string
    rename_column :users, :google_token, :access_token
  end
end
