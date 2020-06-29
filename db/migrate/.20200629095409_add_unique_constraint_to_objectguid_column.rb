class AddUniqueConstraintToObjectguidColumn < ActiveRecord::Migration[6.0]
  def change
    add_index :ad_users, :objectguid, :unique => true
  end
end
