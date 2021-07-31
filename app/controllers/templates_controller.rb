class TemplatesController < ApplicationController
  include TemplatesHelper
  
  def index
    @templates = Template.all
    respond_to do |format|
      format.html
      format.json {render :json => json_data}
    end
  end
  
  def new
    @template = Template.new
    @template.category = params[:category]
    @type_list = Template.type_list
    @template_tags = @template.itemtags
    @available_tags = Itemtag.where(item_type: @template.category)
  end
  
  def edit
    @template = Template.find(params[:id])
    @template_content = @template.content
    @type_list = Template.type_list
    @template_tags = @template.itemtags
    @available_tags = Itemtag.where(item_type: @template.category).filter{ |tag| !@template_tags.include? tag}
    @itemtag = Itemtag.new #to render new tag form
  end
  
  
  def destroy
    @template = Template.find(params[:id])
    if @template.destroy
      flash.now[:notice] = "Template deleted"
    else
      flash.now[:alert] = @template.errors
    end
  end

  def create
    @template = Template.new(secure_template_hash(template_params))
    if @template.save
      create_and_associate_nonexistent_tags(template_params[:content], @template.id)
      respond_to do |format|
        format.js { flash_ajax_notice("Template created") }
      end
    else
      respond_to do |format|
        format.js { flash_ajax_notice(@template.errors.full_messages) }
      end
    end
  end
  
  def update
    @template = Template.find(params[:id])
    if @template.update(secure_template_hash(template_params))
      create_and_associate_nonexistent_tags(template_params[:content], @template.id)
      respond_to do |format|
        format.js { flash_ajax_notice("Template updated") }
      end
    else
      respond_to do |format|
        format.js { flash_ajax_notice(@template.errors.full_messages) }
      end
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
    @available_tags = Itemtag.where(item_type: @template.category).filter{ |tag| !@template_tags.include? tag }
  end

  def upload
    uploaded_files = params[:templates]
    if files_validated?(uploaded_files)
      uploaded_files.each do |file|
        process_template(file, params[:category])
      end
      respond_to do |format|
        format.js {render inline: "location.reload();" }
      end
    else
      flash_ajax_alert ("File type must be HTML and maximum 5 files can be uploaded at once");
    end
  end

  private

  def files_validated?(files)
    return false if files.nil?
    return false if files.length > 5
    files.each do |file|
      return false unless file.content_type === "text/html"
    end
    true
  end

  

end
