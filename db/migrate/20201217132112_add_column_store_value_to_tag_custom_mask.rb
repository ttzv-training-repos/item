class AddColumnStoreValueToTagCustomMask < ActiveRecord::Migration[6.0]
  def change
    add_column :tag_custom_masks, :store_value, :boolean, default: false
  end
end
