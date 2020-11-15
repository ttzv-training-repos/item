class AddColumnManagerIdToEmployee < ActiveRecord::Migration[6.0]
  def change
    add_column :employees, :manager_id, :integer
  end
end
