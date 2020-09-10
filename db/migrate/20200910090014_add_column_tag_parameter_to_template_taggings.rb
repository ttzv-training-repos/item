class AddColumnTagParameterToTemplateTaggings < ActiveRecord::Migration[6.0]
  def change
    add_column :template_taggings, :tag_parameter, :string
  end
end
