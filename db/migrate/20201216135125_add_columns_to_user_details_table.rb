class AddColumnsToUserDetailsTable < ActiveRecord::Migration[6.0]
  def change
    add_column :ad_user_details, :phonenumber, :text
    add_column :ad_user_details, :phonenumber_2, :text
    add_column :ad_user_details, :storage, :text, :default => '{}'
  end
end
