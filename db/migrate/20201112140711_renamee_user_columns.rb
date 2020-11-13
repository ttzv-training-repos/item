class RenameeUserColumns < ActiveRecord::Migration[6.0]
  def change
    rename_column :users, :profile_picture_google, :picture_google
    rename_column :users, :profile_picture_local, :picture_local
  end
end
