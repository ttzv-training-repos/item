class AddContentToTemplate < ActiveRecord::Migration[6.0]
  def change
    add_column :templates, :content, :text
  end
end
