class AddColumnDisplayNameToTemplateTags < ActiveRecord::Migration[6.0]
  def change
    add_column :template_tags, :display_name, :string
  end
end
