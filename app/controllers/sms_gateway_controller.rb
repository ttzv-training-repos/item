class SmsGatewayController < ApplicationController

  def index
    @sender = "123_placeholder"
    @templates = Template.where(category: "sms")
  end

  def upload
    
  end

end
