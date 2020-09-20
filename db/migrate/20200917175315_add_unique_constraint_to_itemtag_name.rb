class AddUniqueConstraintToItemtagName < ActiveRecord::Migration[6.0]
  def change
    add_index :itemtags, :name, :unique => true
  end
end
