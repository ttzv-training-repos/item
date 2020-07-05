class TemplateTagging < ApplicationRecord
  belongs_to :template
  belongs_to :template_tag

  def self.upsert(hash)
    TemplateTagging.create(hash) if TemplateTagging.find_by(hash).nil?
  end
end
