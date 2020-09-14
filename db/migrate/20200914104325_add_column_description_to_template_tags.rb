class AddColumnDescriptionToTemplateTags < ActiveRecord::Migration[6.0]
  def change
    add_column :template_tags, :description, :text
  end
end
