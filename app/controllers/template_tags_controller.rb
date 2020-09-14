class TemplateTagsController < ApplicationController
  include TemplateTagsHelper

  def create
    name = tag_name_type(tag_params[:name], tag_params[:template_type])
    if TemplateTag.find_by(name: name).nil?
      hash = tag_params
      hash.delete(:template_type)
      hash[:display_name] = hash[:name].strip.capitalize
      hash[:name] = name
      new_tag = TemplateTag.create(hash)
      render :json => {
        status: "Created",
        message: "Tag created",
        tag:{
          id: new_tag.id,
          name: new_tag.name,
          display_name: new_tag.display_name,
          description: new_tag.description,
          store_value: new_tag.store_value,
          default_value_mask: new_tag.default_value_mask
        }
      }
    else
      render :json => {
        status: "Duplicate",
        message: "Tag with this name already exists."
      }
    end
  end

end
