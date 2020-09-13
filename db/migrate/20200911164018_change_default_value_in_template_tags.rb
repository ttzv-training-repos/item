class ChangeDefaultValueInTemplateTags < ActiveRecord::Migration[6.0]
  def change
    change_column :template_tags, :store_value, :boolean, default: false
  end
end
