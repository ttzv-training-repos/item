class RenameBoundFieldToBoundAttr < ActiveRecord::Migration[6.0]
  def change
    rename_column :template_tags, :bound_field, :bound_attr
  end
end
