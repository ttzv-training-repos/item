class HolidayRequestsController < ApplicationController
  include HolidayRequestsHelper
  def index
    
  end

  def new
    @holiday_request = HolidayRequest.new
  end

  def create
    current_user.employee.holiday_requests.create(holiday_request_params)
    redirect_to holidays_path
  end

  def update
    
  end

  def delete
    
  end


end
