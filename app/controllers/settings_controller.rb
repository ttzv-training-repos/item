class SettingsController < ApplicationController
  include SettingsHelper
  def index
    @tags = TemplateTag.where.not(name: "itemtag-mail-topic")
    @attrs = Array.new
    @attrs << ActiveRecord::Base.connection.columns(:ad_users).collect {|c| "ad_users." + c.name}
    @attrs << ActiveRecord::Base.connection.columns(:ad_user_details).collect {|c| "ad_user_details." + c.name}
    @attrs << ActiveRecord::Base.connection.columns(:offices).collect {|c| "offices." + c.name}
    @attrs.flatten!
  end

  def run_autobinder
    AdUserServices::UserOfficeBinder.new.run
  end

  def process_request
    settings_params.each do |entry| 
      tag = TemplateTag.find_by(name: entry.first)
      tag.update(bound_attr: entry.last) unless entry.last.empty?
    end
  end

  def authorize
    client_secret = JSON.parse(File.read('client_secrets.json'), symbolize_names: true)
    client_secret = client_secret[:web]
    client = Signet::OAuth2::Client.new(
      :authorization_uri => client_secret[:auth_uri],
      :token_credential_uri =>  client_secret[:token_uri],
      :client_id => client_secret[:client_id],
      :client_secret => client_secret[:client_secret],
      :scope => 'email profile openid https://www.googleapis.com/auth/gmail.send',
      :redirect_uri => client_secret[:redirect_uris][0]
    )
    redirect_to(client.authorization_uri.to_s)
    puts "request"
    
  end

end
