module LdapServices
  class LdapSync
  attr_accessor :hash

  def initialize(ldapconn)
    @ldapconn = ldapconn
  end

    def sync
      AdUser.destroy_all
      @all_users = @ldapconn.all_users
      @all_users.each do |user_hash| 
        AdUser.create(LdapUser.tohash(user_hash))
      end
      true
    end

  end
end