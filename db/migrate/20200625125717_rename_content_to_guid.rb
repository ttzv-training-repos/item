class RenameContentToGuid < ActiveRecord::Migration[6.0]
  def change
    rename_column :user_holders, :content, :objectguid
  end
end
