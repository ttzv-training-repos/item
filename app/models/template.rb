class Template < ApplicationRecord
  has_one_attached :template_file, dependent: :destroy
  has_many :template_taggings, dependent: :destroy
  has_many :template_tags, through: :template_taggings
end
