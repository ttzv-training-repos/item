class MailsController < ApplicationController
  include MailsHelper
  
  def upload
    uploaded_files = params[:templates]
    uploaded_files.each do |file|
      template = Template.find_or_create_by(name: strip_extension(file.original_filename))
      template.update(process_template(file))
      template.template_file.purge if template.template_file.attached?
      template.template_file.attach(file)
      associate_tags(template)
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
          tags: t.template_tags.pluck(:name)
        }
      })
    end
      render :json => {template_data: json_data}
  end

end
