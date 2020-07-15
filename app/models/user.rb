class User < ApplicationRecord

  def self.authenticate_new
    user = User.create(name: 'Stranger', session_id: self.next_id)
  end

  def self.next_id
    first = User.order(session_id: :desc).first
    if first.nil? 
      next_id = 1
    else
      next_id = first.session_id + 1
    end
    next_id
  end

end
