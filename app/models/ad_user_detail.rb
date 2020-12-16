class AdUserDetail < ApplicationRecord
  belongs_to :ad_user
  belongs_to :office

  # Pass key and
  def storage_set(key, value)
    key = key.to_s unless key.is_a? String
    key = value.to_s unless value.is_a? String
    storage = parse_storage(self.storage)
    storage[key] = value
    self.update(storage: storage.to_json)
  end

  def storage_delete(key)
    key = key.to_s unless key.is_a? String
    storage = parse_storage(self.storage)
    storage.delete(key)
    self.update(storage: storage.to_json)
  end

  def storage_json
    parse_storage(self.storage)
  end

  private

  def parse_storage(storage)
    JSON.parse(storage)
  end

end
