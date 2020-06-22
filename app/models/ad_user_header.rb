class AdUserHeader < ApplicationRecord

  def self.en_headers
    headers = Hash.new
    AdUserHeader.pluck(:name, :name_en).each { |entry| headers.merge!(entry.first => entry.last) }
    headers
  end
end
