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

end
