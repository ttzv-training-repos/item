module LdapServices
  class LdapSync
  attr_accessor :hash

  def initialize(ldapconn)
    @ldapconn = ldapconn
  end

    def sync
      AdUser.destroy_all
      @all_users = @ldapconn.all_users
      AdUser.transaction do
        @all_users.each do |user| 
          AdUser.create(LdapUser.tohash(user))
        end
      end
      true
    end

  end
end