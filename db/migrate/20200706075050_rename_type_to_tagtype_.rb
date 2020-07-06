class RenameTypeToTagtype < ActiveRecord::Migration[6.0]
  def change
    rename_column :template_tags, :type, :tagtype
  end
end
