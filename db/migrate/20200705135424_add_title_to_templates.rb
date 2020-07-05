class AddTitleToTemplates < ActiveRecord::Migration[6.0]
  def change
    add_column :templates, :title, :string
  end
end
