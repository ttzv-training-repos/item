class HolidaysController < ApplicationController
  before_action :authenticate_user!
  def index
    @holiday_requests = current_user.employee.holiday_requests
    @inbox = current_user.employee.inbox.holiday_requests
  end
end
