class CreateTemplateTaggings < ActiveRecord::Migration[6.0]
  def change
    create_table :template_taggings do |t|
      t.references :template, null: false, foreign_key: true
      t.references :template_tag, null: false, foreign_key: true

      t.timestamps
    end
  end
end
