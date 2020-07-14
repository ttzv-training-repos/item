class SettingsController < ApplicationController
  require 'google/apis/options'
  require 'google/apis/gmail_v1'
  require 'google/apis/oauth2_v2'
  require 'google/apis/drive_v2'
  require 'google/apis/people_v1'
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
    user_id = UserServices::UserAuthenticator.get_id(session[:user_id])
    session[:user_id] = user_id if session[:user_id].nil?

    client = UserServices::UserAuthorizer.load_client(user_id)
    if client.expired?
      client.refresh! 
      UserServices::UserAuthorizer.store_client(user_id: user_id, client: client)
    end
    if client.nil?
      client = UserServices::UserAuthorizer.new_client(user_id) 
      redirect_to(client.authorization_uri.to_s)
    end
  end

  def check_auth
    client = UserServices::UserAuthorizer.load_client(session[:user_id])

    @data = {expired: client.expired?, expiresin: client.expires_in, issuedat: client.issued_at, state: client.state, issuer: client.issuer, expiry: client.expiry, expires_at: client.expires_at}

    Google::Apis::RequestOptions.default.authorization = client

    profile = Google::Apis::Oauth2V2::Oauth2Service.new
    @apidata = profile.get_userinfo.to_json

    gmail = Google::Apis::GmailV1::GmailService.new
  end

end
