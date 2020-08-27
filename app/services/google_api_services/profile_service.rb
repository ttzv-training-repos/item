module GoogleApiServices
  require 'google/apis/oauth2_v2'
  class ProfileService

    attr_reader :valid
  
    def initialize(client)
      @client = client
      if @client.nil?
        @userinfo = nil
      else
        service = Google::Apis::Oauth2V2::Oauth2Service.new
        service.authorization = @client
        @userinfo = service.get_userinfo
      end
    end
    
    def [](attribute)
      return "" if @userinfo.nil?
      return self.__send__(attribute)
    end

    private

    def picture
      @userinfo.picture
    end

    def email
      @userinfo.email
    end

    def name
      @userinfo.name
    end


  end
end