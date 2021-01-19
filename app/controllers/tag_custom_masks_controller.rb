class TagCustomMasksController < ApplicationController
  include TagCustomMasksHelper

  def edit
    tagging = TemplateTagging.find_by(
      template_id: params[:template_id],
      itemtag_id: params[:itemtag_id]
    )
    @tag_custom_mask = tagging.tag_custom_mask
    if @tag_custom_mask.nil?
      @tag_custom_mask = TagCustomMask.new
    end
  end
  
  def update
    @tag_custom_mask = TemplateTagging.find_by(
      template_id: params[:template_id],
      itemtag_id: params[:itemtag_id]
    ).tag_custom_mask
      @tag_custom_mask.update(mask_params)
      @preview = preview(
        params[:itemtag_id],
        params[:template_id],
        params[:ad_users_id]
        )
      flash.now[:notice] = "Succesfully updated custom mask"
  end

  def create
    tagging = TemplateTagging.find_by(
      template_id: params[:template_id],
      itemtag_id: params[:itemtag_id]
    ) 
    @tag_custom_mask = tagging.tag_custom_mask
    if @tag_custom_mask.nil?
     @tag_custom_mask = tagging.create_tag_custom_mask(mask_params)
    end
    @preview = preview(
      params[:itemtag_id],
      params[:template_id],
      params[:ad_users_id]
      )

    flash.now[:notice] = "Succesfully created custom mask"
  end

  private 

  def preview(itemtag_id, template_id, ad_user_id)
    itemtag = Itemtag.find(itemtag_id)
    itemtag.apply_mask(ad_user_id, template_id)
  end

end
