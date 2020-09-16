class RenameColumnTemplateTaggings < ActiveRecord::Migration[6.0]
  def change
    rename_column :template_taggings, :template_tag_id, :itemtag_id
  end
end
