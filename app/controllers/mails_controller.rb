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

  def templates_data
    json_data = Hash.new
    Template.all.each do |t|
      json_data.merge!(
        {
        t.name => {
          id: t.id,
          name: t.name,
          title: t.title,
          content: template_content(t),
          tags: itemtags_hash(t)
        }
      })
    end
      render :json => {template_data: json_data}
  end

  # JSON name - message_request
  # Keys:
  # sender
  # messages => recipient
  #             content
  def send_request
    message_request = mail_params
    sender = message_request[:sender]
    messages = message_request[:messages].values
    messages.each.with_index do |m, i|
      # TemplateMailer.with(
      #   user: current_user, 
      #   password: cookies[:smtp_password],
      #   client: google_auth_client
      # ).template_mail(recipients: '',
      #                 subject: m["subject"],
      #                 body_html: m["content"])
      #                 .deliver_now
      progress = ((i+1) / messages.length.to_f * 100).to_i
      ActionCable.server.broadcast("progress_bar_mails", {progress: progress})
      sleep 1
    end
    flash.now[:notice] = "All messages sent succesfully"
  end
end
