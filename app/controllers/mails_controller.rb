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


  def send_request
    creator = current_user.name.nil? ? current_user.email : current_user.name 
    sent_item_group = SentItemGroup.new(creator: creator)
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
        status = false
        status_content = exception
      end
      sent_item_group.save if sent_item_group.id.nil?
      sent_item_group.sent_items.create({
        title: m["subject"],
        item_type: "Mail",
        status: status,
        content: m["content"],
        status_content: status_content,
        recipients: m["recipient"],
        fields: m[:tagMap].to_json
        })
        store_itemtag_values(m[:tagMap], m[:template_id], m[:user_id] ) if status
    end

    task_status = sent_item_group.sent_items.all.pluck(:status).uniq
    task_status_messages = sent_item_group.sent_items.all.pluck(:status_content).uniq
    if task_status.length == 1 and task_status.first
      flash.now[:notice] = "Task finished succesfully"
    elsif task_status.length == 2
      flash.now[:alert] = "Finished with errors:\n #{task_status_messages.join("\n")}"
    else
      flash.now[:alert] = "Failed with errors:\n #{task_status_messages.join("\n")}"
    end

  end
end
