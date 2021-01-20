class SmsGatewayController < ApplicationController
  include SmsGatewayHelper
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
    request_data = sms_params
    sender = request_data[:sender]
    messages = request_data[:messages].values
    client = Smsapi::Client.new(current_user.sms_setting.token)
    p client.credits
    messages.each.with_index do |m, i|
      puts "message to: #{m["recipient"]}, #{m["phone_number"]}"
      recipient_number = m["phone_number"].to_i
      message_body = m["content"]#.gsub("<br>", "\n").gsub("<br/>", "\n")
      message_body = Rails::Html::FullSanitizer.new.sanitize(message_body)
      sms = client.send_single(recipient_number, message_body, test: '1', from: sender )
      p sms
      progress = ((i+1) / messages.length.to_f * 100).to_i
      ActionCable.server.broadcast("progress_bar_mails", {progress: progress})
      #store_itemtag_values(m[:tagMap], m[:template_id], m[:user_id] )
    end
    flash.now[:notice] = "All messages sent succesfully"
    render "mails/send_request"
  end

end
