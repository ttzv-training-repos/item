module UserServices
  class UserAuthorizer

    def initialize(user)
      @user = user
      @client = nil
    end

    def client
      @client = load_client(@user.google_client) if @user.google_client
      if @client
        begin
          if @client.expired?
            @client.refresh! 
            update_user_client
          end
        rescue
          return nil
        end
      end
      @client
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
    
    private

    def update_user_client
      @user.update(google_client: @client.to_json)
    end
    
    def load_client(client_json)
      Signet::OAuth2::Client.new(JSON.parse(client_json, symbolize_names: true))
    end

  end
end