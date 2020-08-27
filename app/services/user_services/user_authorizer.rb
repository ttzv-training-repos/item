module UserServices
  class UserAuthorizer

    def self.client(user_id)
      raise "User ID cannot be a NULL value" if user_id.nil?
      client = self.load_client(user_id)
      return nil if client.nil?
      return nil if client.access_token.nil?
      begin
        client.refresh! if client.expired?
      rescue
        return client #implement a fallback that deletes stored client and forces re-authorization with forced prompt if refresh token is missing
      end
      self.store_client(user_id: user_id, client: client)
      return client
    end

    def self.load_client(user_id)
      redis = Redis.new
      stored_client = redis.get("oauth:#{user_id}")
      return nil if stored_client.nil?
      Signet::OAuth2::Client.new(JSON.parse(stored_client, symbolize_names: true))
    end

    def self.new_client
      client_secret = JSON.parse(File.read('config/secrets/client_secrets.json'), symbolize_names: true)
      client_secret = client_secret[:web]
      client = Signet::OAuth2::Client.new(
        :authorization_uri => client_secret[:auth_uri],
        :token_credential_uri =>  client_secret[:token_uri],
        :client_id => client_secret[:client_id],
        :client_secret => client_secret[:client_secret],
        :scope => 'email profile openid https://www.googleapis.com/auth/gmail.send',
        :redirect_uri => client_secret[:redirect_uris][0],
        :additional_parameters => {'access_type' => 'offline', 'approval_prompt' => 'force'},
        :valid => false
      )
    end

    def self.store_client(options={})
      user_id = options[:user_id]
      client = options[:client]
      raise "Required authenticated User ID" if user_id.nil? 
      raise "Required Client to store" if client.nil?
      Redis.new.set("oauth:#{user_id}", client.to_json)
    end

    def self.remove(user_id)
      redis = Redis.new
      stored_client = redis.get("oauth:#{user_id}")
      redis.del("oauth:#{user_id}") unless stored_client.nil?
    end

  end
end