class RenameColumnsInTemplateTags < ActiveRecord::Migration[6.0]
  def change
    rename_column :template_tags, :bound_attr, :default_value_mask
    rename_column :template_tags, :tagtype, :tag_type
  end
end
