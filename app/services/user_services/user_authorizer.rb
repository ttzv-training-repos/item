module UserServices
  class UserAuthorizer

    def self.client(user_id)
      raise "User ID cannot be a NULL value" if user_id.nil?
      client = self.load_client(user_id)
      if client.nil?
        client = self.new_client(user_id)
        self.store_client(user_id: user_id, client: client)
        return client
      else
        begin
          client.refresh! if client.expired?
        rescue
          return client
        end
        self.store_client(user_id: user_id, client: client)
        return client
      end
    end

    def self.load_client(user_id)
      raise "User ID cannot be a NULL value" if user_id.nil?
      redis = Redis.new
      return nil if redis.get("oauth:#{user_id}").nil?
      puts "oauth:#{user_id}"
      Signet::OAuth2::Client.new(JSON.parse(Redis.new.get("oauth:#{user_id}"), symbolize_names: true))
    end

    def self.new_client(user_id)
      raise "User ID cannot be a NULL value" if user_id.nil?
      client_secret = JSON.parse(File.read('config/secrets/client_secrets.json'), symbolize_names: true)
      client_secret = client_secret[:web]
      client = Signet::OAuth2::Client.new(
        :authorization_uri => client_secret[:auth_uri],
        :token_credential_uri =>  client_secret[:token_uri],
        :client_id => client_secret[:client_id],
        :client_secret => client_secret[:client_secret],
        :scope => 'email profile openid https://www.googleapis.com/auth/gmail.send',
        :redirect_uri => client_secret[:redirect_uris][0],
        :additional_parameters => {"access_type" => "offline"}
      )
      client
    end

    def self.store_client(options={})
      user_id = options[:user_id]
      client = options[:client]
      raise "Required authenticated User ID" if user_id.nil? 
      raise "Required Client to store" if client.nil?

      Redis.new.set("oauth:#{user_id}", client.to_json)
    end

  end
end