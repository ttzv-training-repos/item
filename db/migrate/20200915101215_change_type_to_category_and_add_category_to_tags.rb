class ChangeTypeToCategoryAndAddCategoryToTags < ActiveRecord::Migration[6.0]
  def change
    rename_column :templates, :template_type, :category
    add_column :template_tags, :category, :string
  end
end
