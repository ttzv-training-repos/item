class AdUser < ApplicationRecord
  include Comparable

  def <=>(other)
    self.objectguid <=> other.objectguid
  end

end
