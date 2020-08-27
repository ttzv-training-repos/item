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

    def picture
      @userinfo.picture unless @userinfo.nil?
    end

    def email
      @userinfo.email unless @userinfo.nil?
    end

    def name
      @userinfo.name unless @userinfo.nil?
    end

    def valid
      return !@userinfo.nil?
    end

  end
end