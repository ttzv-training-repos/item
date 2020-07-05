class AddUniqueConstraintToTemplateName < ActiveRecord::Migration[6.0]
  def change
    add_index :templates, :name, :unique => true
  end
end
