module LdapServices
  class LdapConn

    def initialize
      connect
    end

    def configure(settings)
      @settings = settings
      self
    end

    def connect
      if @settings.nil?
        user_config = JSON.parse(File.read("userconfig.json"), {:symbolize_names => true})
        @settings = {
          :host => user_config[:host],
          :base => user_config[:base],
          :port => user_config[:port],
          :auth => {
            :method => :simple,
            :username => user_config[:login],
            :password => user_config[:password]
          }
        }
      else
        @settings = settings
      end 
      ActiveDirectory::Base.setup(@settings)
    end

    def all_users
      ActiveDirectory::User.find(:all, :sn => "*")
    end
    
  end
end