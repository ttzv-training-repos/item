class SmsGatewayController < ApplicationController
  require 'smsapi'

  def index
    sms_setting = current_user.sms_setting
    if sms_setting
      @sender = sms_setting.sender_name
      client = Smsapi::Client.new(sms_setting.token)
      @smsapi_points = client.credits.balance
    else
      @sender = "SMSApi configuration missing"
      @smsapi_points = "SMSApi configuration missing"
    end
    @templates = Template.where(category: "sms")
  end

  def send_request
    
  end

end
