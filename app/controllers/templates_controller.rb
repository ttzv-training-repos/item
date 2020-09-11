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
  end

end
