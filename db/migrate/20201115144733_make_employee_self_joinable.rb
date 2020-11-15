class MakeEmployeeSelfJoinable < ActiveRecord::Migration[6.0]
  def change
    remove_column :employees, :manager_id
    add_reference :employees, :manager
  end
end
