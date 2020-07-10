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
  #             custom
  #             params => ...
  #             template => title
  #                         content
  #                         tags (unneeded)
  def send_request
    message_request = mail_params
    sender = message_request[:sender]
    messages = message_request[:messages]
    msgs = messages.keys.map { |key| messages[key]}
    
    puts "msgs"
    p msgs

  end

end
