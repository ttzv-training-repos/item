class AddColumnInboxIdToHolidayRequests < ActiveRecord::Migration[6.0]
  def change
    add_reference :holiday_requests, :inbox
  end
end
