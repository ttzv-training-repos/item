class TagCustomMask < ApplicationRecord
  has_one :template_tagging

  def self.get(query_hash)
    template = query_hash[:template]
    tag = query_hash[:tag]
    raise "Template relation not provided" if template.nil?
    raise "TemplateTag relation not provided" if tag.nil?

    mask = TemplateTagging.find_by(template_id:template.id, template_tag_id: tag.id)
    TagCustomMask.find(mask.tag_custom_mask_id) unless mask.nil?
  end

  def self.upsert(query_hash, mask_value)
    template = query_hash[:template]
    tag = query_hash[:tag]
    raise "Template relation not provided" if template.nil?
    raise "TemplateTag relation not provided" if tag.nil?

    mask = TemplateTagging.find_by(template_id:template.id, template_tag_id:tag.id)
    if mask.nil?
      new_mask = TagCustomMask.create(value: mask_value)
      TemplateTagging.where(template_id: template.id, template_tag_id: tag.id).update(tag_custom_mask_id: new_mask.id)
    else
      TagCustomMask.find(mask.tag_custom_mask_id).update(value: mask_value)
    end
  end

end
