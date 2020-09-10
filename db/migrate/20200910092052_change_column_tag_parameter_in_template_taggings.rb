class ChangeColumnTagParameterInTemplateTaggings < ActiveRecord::Migration[6.0]
  def change
    rename_column :template_taggings, :tag_parameter, :tag_custom_mask_id
    change_column :template_taggings, :tag_custom_mask_id, :integer
  end
end
