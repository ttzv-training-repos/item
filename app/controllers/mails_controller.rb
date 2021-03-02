class MailsController < ApplicationController
  include MailsHelper
  before_action :authenticate_user!
  
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
    sent_item_group = SentItemGroup.create
    request_data = mail_params
    sender = request_data[:sender]
    messages = request_data[:messages].values
    messages.each.with_index do |m, i|
      begin
        TemplateMailer.with(
          user: current_user, 
          password: cookies[:smtp_password],
          client: google_auth_client
        ).template_mail(recipients: m["recipient"],
                        subject: m["subject"],
                        body_html: m["content"]
                        ).deliver_now
        progress = ((i+1) / messages.length.to_f * 100).to_i
        ActionCable.server.broadcast("progress_bar_mails", {progress: progress})
        status = true
        status_content = "Message was delivered to selected recipient."
      rescue => exception
        puts exception
        status = false
        status_content = exception
      end
      store_itemtag_values(m[:tagMap], m[:template_id], m[:user_id] )
      sent_item_group.sent_items.create({
        title: m["subject"],
        item_type: "Mail",
        status: status,
        content: m["content"],
        status_content: status_content  
      })
    end
    flash.now[:notice] = "Task finished"
  end
end
