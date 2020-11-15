class AddColumnsToHolidayProposals < ActiveRecord::Migration[6.0]
  def change
    add_column :holiday_requests, :status, :string
    add_column :holiday_requests, :since, :date
    add_column :holiday_requests, :until, :date
  end
end
