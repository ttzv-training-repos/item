class TagCustomMask < ApplicationRecord
  belongs_to :template_tagging

  def self.upsert(hash)
    template_tagging_id = hash[:template_tagging_id]
    value = hash[:value]
    raise "Missing parameters" if template_tagging_id.nil? or value.nil?

    tag_custom_mask = TagCustomMask.find_by(template_tagging_id: template_tagging_id)
    if tag_custom_mask.nil?
      new_mask = TagCustomMask.create(hash)
    else
      tag_custom_mask.update(value: value)
    end
  end

end
