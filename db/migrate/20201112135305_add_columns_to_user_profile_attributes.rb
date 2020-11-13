class AddColumnsToUserProfileAttributes < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :email, :string, :unique => true
    add_column :users, :profile_picture_google, :string
    add_column :users, :profile_picture_local, :string
    add_column :users, :anonymous, :boolean
  end
end
