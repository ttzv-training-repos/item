module GoogleApiServices
  require 'google/apis/oauth2_v2'
  class ProfileService
  
    def initialize(client)
      @service = Google::Apis::Oauth2V2::Oauth2Service.new
      @service.authorization = client
      @userinfo = nil
    end

    def userinfo
      begin
        @userinfo = @service.get_userinfo
      rescue Signet::AuthorizationError
        @userinfo = ""
      end
    end

    def picture
      userinfo if @userinfo.nil?
      @userinfo.empty? ? "" : @userinfo.picture
    end

    def email
      userinfo if @userinfo.nil?
      @userinfo.empty? ? "" : @userinfo.email
    end

    def name
      userinfo if @userinfo.nil?
      @userinfo.empty? ? "" : @userinfo.name
    end

  end
end