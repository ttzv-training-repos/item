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
    @itemtag = Itemtag.new(itemtag_params)
    @template = Template.find(params[:template_id])
    begin
      if @itemtag.save
        flash.now[:notice] = "Tag created succesfully"
      else
        flash_ajax_notice(@itemtag.error.full_messages.to_sentence)
      end
    rescue ActiveRecord::RecordNotUnique
      respond_to do |format|
        format.js { flash_ajax_alert("Name already used") } 
      end
    end
    @template_tags = @template.itemtags
    @available_tags = Itemtag.all.filter{ |tag| !@template_tags.include? tag }
  end

  def update
   
    @itemtag = Itemtag.find(params[:id])
    if @itemtag.update(itemtag_params)
      respond_to do |format|
        format.js { flash_ajax_notice("Tag updated") }
      end
    else

    end
  end

  def destroy
    @template = Template.find(params[:template_id])
    @itemtag = Itemtag.find(params[:id])
    if @itemtag.destroy
      flash.now[:notice] = "Tag deleted"
    end
    @template_tags = @template.itemtags
    @available_tags = Itemtag.all.filter{ |tag| !@template_tags.include? tag }
  end


end
