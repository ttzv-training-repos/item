class CreateTagCustomMasks < ActiveRecord::Migration[6.0]
  def change
    create_table :tag_custom_masks do |t|
      t.string :value

      t.timestamps
    end
  end
end
