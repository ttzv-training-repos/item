module ItemtagsHelper

  def itemtag_params
    params.require(:itemtag)
    .permit(:name,
            :display_name,
            :description,
            :default_value_mask,
            :store_value)
  end

  def generate_tag(category, name)
    "itemtag-#{category}-#{name.strip.downcase}"
  end

  def generate_displayname(name)
    name.strip.capitalize
  end

  def available_tags_for(template)
    Itemtag.where(item_type: template.category).filter{ |tag| !template.itemtags.include? tag }
  end

end
