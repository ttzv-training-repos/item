module UserServices
  class UserAuthenticator

    def self.get_id(user_id)
      if user_id.nil?
        user = User.create(name: 'Stranger')
        user_id = user.id
      end
      user_id
    end

  end
end