class SmsGatewayController < ApplicationController
  include SmsGatewayHelper
  require 'smsapi'
  before_action :authenticate_user!

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
    sent_item_group = SentItemGroup.create
    request_data = sms_params
    sender = request_data[:sender]
    messages = request_data[:messages].values
    client = Smsapi::Client.new(current_user.sms_setting.token)
    p client.credits
    messages.each.with_index do |m, i|
      begin
        puts "message to: #{m["recipient"]}, #{m["phone_number"]}"
        recipient_number = m["phone_number"].to_i
        message_body = m["content"]
        message_body = Rails::Html::FullSanitizer.new.sanitize(message_body)
        sms = client.send_single(recipient_number, message_body, test: '1', from: sender )
        p sms
        progress = ((i+1) / messages.length.to_f * 100).to_i
        ActionCable.server.broadcast("progress_bar_mails", {progress: progress})
        status = true
        status_content = "Message was delivered to selected recipient."
      rescue => exception
        status = false
        status_content = exception
      end
      store_itemtag_values(m[:tagMap], m[:template_id], m[:user_id] )
      sent_item_group.sent_items.create({
        title: m["name"],
        tiem_type: "SMS",
        status: status,
        content: message_body,
        status_content: status_content  
      })
    end
    flash.now[:notice] = "All messages sent succesfully"
    render "mails/send_request"
  end

end
