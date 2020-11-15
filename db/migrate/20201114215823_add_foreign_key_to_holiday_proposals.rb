class AddForeignKeyToHolidayProposals < ActiveRecord::Migration[6.0]
  def change
    add_column :holiday_requests, :employee_id, :integer
    add_foreign_key :holiday_requests, :employees
    
  end
end
