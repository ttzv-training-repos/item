class TemplateTag < ApplicationRecord
  has_many :template_taggings, dependent: :destroy
  has_many :templates, through: :template_taggings
end
