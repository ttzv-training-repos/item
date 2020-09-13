class RemoveColumnTagTypeFromTemplateTags < ActiveRecord::Migration[6.0]
  def change
    remove_column :template_tags, :tag_type
  end
end
