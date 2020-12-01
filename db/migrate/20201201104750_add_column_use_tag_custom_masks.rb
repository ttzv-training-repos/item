class AddColumnUseTagCustomMasks < ActiveRecord::Migration[6.0]
  def change
    add_column :tag_custom_masks, :use, :boolean, :default => false
  end
end
