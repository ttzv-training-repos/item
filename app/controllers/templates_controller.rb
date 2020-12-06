class TemplatesController < ApplicationController
  include TemplatesHelper
  
  def index
    @templates = Template.all
  end
  
  def new
    @template = Template.new
    @type_list = Template.type_list
    @template_tags = @template.itemtags
    @available_tags = Itemtag.all
  end
  
  def edit
    @template = Template.find(params[:id])
    @template_content = @template.template_file.open { |f| File.read(f) }
    @type_list = Template.type_list
    @template_tags = @template.itemtags
    @available_tags = Itemtag.all.filter{ |tag| !@template_tags.include? tag}
    @itemtag = Itemtag.new #to render new tag form
  end
  
  def create
    @template = Template.new(params_nocontent(template_params))
    if @template.save
      @template.template_file.attach(
        io: StringIO.new(template_params[:content]),
        filename: template_params[:name] + '.html'
      )
      create_and_associate_nonexistent_tags(template_params[:content], @template.id)
      respond_to do |format|
        format.js { flash_ajax_notice("Template created") }
      end
    else
      
    end
  end

  def destroy
    Template.find(params[:id]).destroy
    respond_to do |format|
      format.js { flash_ajax_notice("Template deleted") }
    end
  end

  def update
    @template = Template.find(params[:id])
    @template.update(
      params_nocontent(template_params)
      )

    create_and_associate_nonexistent_tags(template_params[:content], @template.id)

    filename = @template.template_file.filename.to_s
    @template.template_file.purge
    @template.template_file.attach(
      io: StringIO.new(template_params[:content]),
      filename: filename
      )
    respond_to do |format|
      format.js { flash_ajax_notice("Template updated") }
    end
  end

  def tag_edit
    hash = {
      template_id: params[:template_id],
      itemtag_id: params[:tag_id]
    }
    if params[:associate] == "true"
      TemplateTagging.create(hash)
      flash.now[:notice] = "Tag associated with template"
    else
      TemplateTagging.find_by(hash).destroy
      flash.now[:notice] = "Association removed"
    end
    @template = Template.find(params[:template_id])
    @template_tags = @template.itemtags
    @available_tags = Itemtag.all.filter{ |tag| !@template_tags.include? tag }
  end
end
