class MailsController < ApplicationController
  include MailsHelper
  
  def upload
    uploaded_files = params[:templates]
    uploaded_files.each do |file| 
      template = Template.find_or_create_by(name: strip_extension(file.original_filename))
      template.template_file.purge if template.template_file.attached?
      template.template_file.attach(file)
    end
    respond_to do |format|
      format.js {render inline: "location.reload();" }
    end
  end

  def index
    @templates = Template.all
  end



end
