module GoogleApiServices

  class MailingService

    def initialize
      client_id = Google::Auth::ClientId.from_file('client_secrets.json')
      scope = ['https://www.googleapis.com/auth/drive']
      token_store = Google::Auth::Stores::RedisTokenStore.new(redis: Redis.new)
      authorizer = Google::Auth::WebUserAuthorizer.new(
        client_id, scope, token_store, '/oauth2callback')
    end

    def authorize

    end

  end
end