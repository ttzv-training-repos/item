class RenameColumnInTemplatesAndAddDefaultValueToTemplateTags < ActiveRecord::Migration[6.0]
  def change
    rename_column :templates, :applies_to, :template_type
    change_column :template_tags, :store_value, :boolean, default: true
  end
end
