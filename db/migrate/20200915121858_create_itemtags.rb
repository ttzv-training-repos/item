class CreateItemtags < ActiveRecord::Migration[6.0]
  def change
    create_table :itemtags do |t|
      t.string :name, unique: true
      t.string :default_value_mask
      t.boolean :store_value, default: false
      t.text :description
      t.string :display_name

      t.timestamps
    end
  end
end
