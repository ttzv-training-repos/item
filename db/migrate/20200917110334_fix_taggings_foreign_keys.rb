class FixTaggingsForeignKeys < ActiveRecord::Migration[6.0]
  def change
    add_foreign_key :template_taggings, :itemtags
    remove_foreign_key :template_taggings, :template_tags
  end
end
