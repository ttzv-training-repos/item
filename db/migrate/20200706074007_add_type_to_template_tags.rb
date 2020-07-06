class AddTypeToTemplateTags < ActiveRecord::Migration[6.0]
  def change
    add_column :template_tags, :type, :string
  end
end
