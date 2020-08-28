class RenameTypeToItemType < ActiveRecord::Migration[6.0]
  def change
    rename_column :sent_items, :type, :item_type
  end
end
