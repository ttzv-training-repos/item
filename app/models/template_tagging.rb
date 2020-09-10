class TemplateTagging < ApplicationRecord
  belongs_to :template
  belongs_to :template_tag
  belongs_to :tag_custom_mask

  def self.upsert(hash)
    template_tagging = TemplateTagging.find_by(hash)
    if TemplateTagging.nil?
      TemplateTagging.create(hash) 
    else
      template_tagging.update(hash)
    end
  end
end
