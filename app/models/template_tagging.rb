class TemplateTagging < ApplicationRecord
  belongs_to :template
  belongs_to :itemtag
  has_one :tag_custom_mask, dependent: :destroy

  def self.upsert(hash)
    template_tagging = TemplateTagging.find_by(hash)
    if template_tagging.nil?
      TemplateTagging.create(hash) 
    else
      template_tagging.update(hash)
    end
  end
end
