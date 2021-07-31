#todo: add serverside validation
class ItemtagsController < ApplicationController
  include ItemtagsHelper

  def index
    @template_tags = Template.find(params[:template_id]).itemtags
    @available_tags = Itemtag.all
  end

  def new
    @itemtag = Itemtag.new
  end

  def edit
    @itemtag = Itemtag.find(params[:id])
  end

  def create
    @template = Template.find(params[:template_id])
    hash = itemtag_params
    hash[:name] = generate_tag(@template.category, hash[:display_name])
    hash[:display_name] = generate_displayname(hash[:display_name])
    hash[:item_type] = @template.category
    @itemtag = Itemtag.new(hash)
    begin
      if @itemtag.save
        flash.now[:notice] = "Tag created succesfully"
      else
        flash_ajax_alert(@itemtag.error.full_messages.to_sentence)
      end
    rescue ActiveRecord::RecordNotUnique
      respond_to do |format|
        format.js { flash_ajax_alert("Name already used") } 
      end
    end
    @template_tags = @template.itemtags
    @available_tags = available_tags_for(@template)
  end

  def update
    @template = Template.find(params[:template_id])
    hash = itemtag_params
    hash[:name] = generate_tag(@template.category, hash[:display_name])
    hash[:display_name] = generate_displayname(hash[:display_name])
    @itemtag = Itemtag.find(params[:id])
    begin
      if @itemtag.update(hash)
        flash.now[:notice] = "Tag updated succesfully"
      else
        flash_ajax_alert(@itemtag.error.full_messages.to_sentence)
      end
    rescue ActiveRecord::RecordNotUnique
      respond_to do |format|
        format.js { flash_ajax_alert("Name already used") }
      end
    end
    @template_tags = @template.itemtags
    @available_tags = available_tags_for(@template)
  end

  def destroy
    @itemtag = Itemtag.find(params[:id])
    @template = Template.find(params[:template_id])
    if @itemtag.destroy
      flash.now[:notice] = "Tag deleted"
    end
    @template_tags = @template.itemtags
    @available_tags = available_tags_for(@template)
  end


end
