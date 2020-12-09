class SmsGatewayController < ApplicationController

  def index
    @sender = "123_placeholder"
    @templates = Template.where(category: "sms")
    @smsapi_points = 999
  end

  def send_request
    
  end

end
