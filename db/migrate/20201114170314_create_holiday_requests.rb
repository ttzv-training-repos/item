class CreateHolidayRequests < ActiveRecord::Migration[6.0]
  def change
    create_table :holiday_requests do |t|

      t.timestamps
    end
  end
end
