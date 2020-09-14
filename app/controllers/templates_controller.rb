class TemplatesController < ApplicationController

  def index
    @templates = Template.all
  end

  def new
    @template = Template.new
  end

  def update
    @template = Template.find(params[:id])
    @template.update(name: params[:name], 
                    title: params[:title], 
                    template_type: params[:type])
    filename = @template.template_file.filename.to_s
    @template.template_file.purge
    file = File.new(filename, 'w+') { |f| f.write(params[:template_content]) }
    @template.template_file.attach(io: file, filename: filename)
  end

  def edit
    @template = Template.find(params[:id])
    @template_content = @template.template_file.open { |f| File.read(f) }
    @template_tags = @template.template_tags
    @available_tags = TemplateTag.joins(:templates).where(templates:{template_type: @template.template_type}).group(:name)
    @template_types = Template.type_list
    p @template_types
  end

  def tag_request
    p params
  end

end
