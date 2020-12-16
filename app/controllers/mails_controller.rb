class MailsController < ApplicationController
  include MailsHelper
  
  def index
    @templates = Template.where(category: "mail")
    if user_signed_in?
       @sender = current_user.email
    else
      @sender = ''
    end
  end

  # JSON name - message_request
  # Keys:
  # sender
  # messages => recipient
  #             content
  def send_request
    request_data = mail_params
    sender = request_data[:sender]
    messages = request_data[:messages].values
    messages.each.with_index do |m, i|
      TemplateMailer.with(
        user: current_user, 
        password: cookies[:smtp_password],
        client: google_auth_client
      ).template_mail(recipients: m["recipient"],
                      subject: m["subject"],
                      body_html: m["content"])
                      .deliver_now
      progress = ((i+1) / messages.length.to_f * 100).to_i
      ActionCable.server.broadcast("progress_bar_mails", {progress: progress})
    end
    flash.now[:notice] = "All messages sent succesfully"
  end
end
