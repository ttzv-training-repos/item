class TemplatesController < ApplicationController

  def index
    @templates = Template.all
  end

  def new

  end

  def update
    puts params
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
