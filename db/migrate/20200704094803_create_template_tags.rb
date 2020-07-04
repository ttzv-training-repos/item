class CreateTemplateTags < ActiveRecord::Migration[6.0]
  def change
    create_table :template_tags do |t|
      t.string :name
      t.string :bound_field
      t.boolean :autofill
      t.boolean :store_value

      t.timestamps
    end
  end
end
