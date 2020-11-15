class AddDefaultToHolidayStatusColumn < ActiveRecord::Migration[6.0]
  def change
    change_column_default :holiday_requests, :status, 'NEW'
  end
end
