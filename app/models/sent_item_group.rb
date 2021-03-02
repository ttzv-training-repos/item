class SentItemGroup < ApplicationRecord
  has_many :sent_items, dependent: :destroy
end
