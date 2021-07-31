class AddCoulmnItemTypeToItemtags < ActiveRecord::Migration[6.0]
  def change
    add_column :itemtags, :item_type, :string
  end
end
