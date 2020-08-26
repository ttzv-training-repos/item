class MailsController < ApplicationController
  include MailsHelper
  
  def upload
    uploaded_files = params[:templates]
    uploaded_files.each do |file|
      process_template(file)
    end
    respond_to do |format|
      format.js {render inline: "location.reload();" }
    end
  end

  def index
    @templates = Template.all
    #@sender = GoogleApiServices::ProfileService.new(google_auth_client).email
  end

  def templates_data
    json_data = Hash.new
    Template.all.each do |t|
      json_data.merge!(
        {
        t.name => {
          title: t.title,
          content: template_content(t),
          tags: t.template_tags.select(:name, :bound_attr).as_json
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
    puts "#############################################"
    p message_request[:messages].values
    sender = message_request[:sender]
    messages = message_request[:messages]
    messages = messages.to_hash.map { |m| m[1] }

    mailing_service = GoogleApiServices::MailingService.new(google_auth_client)
    mailing_service.send(sender: sender, messages: messages)

  end

end
