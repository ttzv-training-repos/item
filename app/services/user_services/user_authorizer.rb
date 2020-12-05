module UserServices
  class UserAuthorizer

    def initialize(user)
      @user = user
      @client = nil
    end

    def client
      @client = load_client(@user.google_client) if @user.google_client  
      if @client.expired?
        set_credentials
        @client.refresh! 
        clear_credentials
        update_user_client
      end
      @client
    end

    def new_client
      client_secret = JSON.parse(File.read('config/secrets/client_secrets.json'), symbolize_names: true)
      client_secret = client_secret[:web]
      Signet::OAuth2::Client.new(
      :authorization_uri => client_secret[:auth_uri],
      :token_credential_uri =>  client_secret[:token_uri],
      #:client_id => client_secret[:client_id],
      #:client_secret => client_secret[:client_secret],
      :redirect_uri => client_secret[:redirect_uris][0]
      )
      # :scope => 'email profile openid https://www.googleapis.com/auth/gmail.send',
      # :additional_parameters => {'access_type' => 'offline', 'approval_prompt' => 'force'},
      # :valid => false
    end
    
    private

    def update_user_client
      @user.update(google_client: @client.to_json)
    end
    
    def load_client(client_json)
      client = new_client
      client_hash = JSON.parse(client_json, symbolize_names: true)
      client.access_token = client_hash[:access_token]
      client.refresh_token = client_hash[:refresh_token]
      client.expires_at = client_hash[:expires_at]
      client
    end

    def set_credentials
      @client.client_id = Rails.application.credentials.oauth[:google_id]
      @client.client_secret = Rails.application.credentials.oauth[:google_secret]
    end

    def clear_credentials
      @client.client_id = "nil"
      @client.client_secret = "nil"
    end

  end
end