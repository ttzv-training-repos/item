class MailsController < ApplicationController
  include MailsHelper
  include ActionController::Live
  
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
    messages.each do |m|
      p m
      TemplateMailer.with(
        user: current_user, 
        password: cookies[:smtp_password],
        client: google_auth_client
      ).template_mail(recipients: 'txdxkx@gmail.com',
                      subject: m["subject"],
                      body_html: m["content"])
                      .deliver_now
    end

  end

  def progress
    render :json => {progress: Redis.new.get("mprg")}
  end

end
