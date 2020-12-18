module LdapServices
  class LdapConn

    def initialize(config_hash=nil)
      connect(config_hash)
    end

    def connect(config_hash=nil)
      if config_hash.nil?
        ldap_config = JSON.parse(File.read("config/secrets/userconfig.json"), {:symbolize_names => true})
      else
        ldap_config = config_hash
      end
      settings = {
        :host => ldap_config[:host], #use IP address if name cant be resolved
        :base => ldap_config[:base],
        :port => ldap_config[:port],
        :auth => {
          :method => :simple,
          :username => ldap_config[:login],
          :password => ldap_config[:password]
        }
      } 
      ActiveDirectory::Base.setup(settings)
    end

    def all_users
      ActiveDirectory::User.find(:all, :sn => "*")
    end
    
  end
end