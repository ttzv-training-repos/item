module HolidayRequestsHelper

  def holiday_request_params
    params.require(:holiday_request).permit(:since,
                  :until)
  end

end
