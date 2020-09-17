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
    if @itemtag.save
      respond_to do |format|
        format.js { flash_ajax_notice("Tag created") }
      end
    else

    end
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
    @itemtag = Itemtag.find(params[:id])
    if @itemtag.destroy
      respond_to do |format|
        format.js { flash_ajax_notice("Tag deleted") }
      end
    end
  end


end
