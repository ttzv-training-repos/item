class HolidayRequestsController < ApplicationController
  include HolidayRequestsHelper
  def index
    
  end

  def new
    @holiday_request = HolidayRequest.new
    @manager = current_user.employee.manager
  end

  def create
    employee = current_user.employee
    holiday_request = employee.holiday_requests.create(holiday_request_params)
    manager = employee.manager
    #add request to manager inbox
    holiday_request.update(inbox_id: manager.inbox.id)
    redirect_to holidays_path
  end

  def update
    
  end

  def delete
    
  end


end
