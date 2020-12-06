module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :user

    def connect
      self.user = find_verified_user
    end

    private
    def find_verified_user
      user = env['warden'].user
      if user
        return user
      else
        reject_unauthorized_connection
      end
    end
  end
end
