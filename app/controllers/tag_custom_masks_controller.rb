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

    #redirect_to edit_template_path(params[:template_id])
  end

  def create
    tagging = TemplateTagging.find_by(
      template_id: params[:template_id],
      itemtag_id: params[:itemtag_id]
    ) 
    @tag_custom_mask = tagging.tag_custom_mask
    if @tag_custom_mask.nil?
      p mask_params
     @tag_custom_mask = tagging.create_tag_custom_mask(mask_params)
    end

    redirect_to edit_template_path(params[:template_id])
  end

  def preview
    tag_custom_mask = TemplateTagging.find_by(
      template_id: params[:template_id],
      itemtag_id: params[:itemtag_id]
    ).tag_custom_mask
    mask_hash = JSON.parse(tag_custom_mask.value, symbolize_names: true)

    current_user = AdUser.find(params_for_preview[:ad_users_id])
    attribute = JSON.parse(tag_custom_mask.value)["attribute"].split("#")[1];
    p attribute
    @preview = current_user[attribute]
  end

end
