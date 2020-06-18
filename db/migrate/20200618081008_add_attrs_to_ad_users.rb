class AddAttrsToAdUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :ad_users, :sn, :string
    add_column :ad_users, :givenname, :string
    add_column :ad_users, :displayname, :string
    add_column :ad_users, :mail, :string
    add_column :ad_users, :userprincipalname, :string
  end
end
