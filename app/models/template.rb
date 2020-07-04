class Template < ApplicationRecord
  has_one_attached :template_file, dependent: :destroy
end
