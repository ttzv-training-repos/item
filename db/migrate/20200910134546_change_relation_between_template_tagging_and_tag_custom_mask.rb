class ChangeRelationBetweenTemplateTaggingAndTagCustomMask < ActiveRecord::Migration[6.0]
  def change
    remove_column :template_taggings, :tag_custom_mask_id
    add_column :tag_custom_masks, :template_tagging_id, :integer
    add_foreign_key :tag_custom_masks, :template_taggings
  end
end
