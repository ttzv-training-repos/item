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

  def check_auth
    client = google_auth_client
    if client.access_token.nil?
      redirect_to client.authorization_uri.to_s
    else
      @data = {expired: client.expired?, expiresin: client.expires_in, issuedat: client.issued_at, state: client.state, issuer: client.issuer, expiry: client.expiry, expires_at: client.expires_at}

      profile = Google::Apis::Oauth2V2::Oauth2Service.new
      profile.authorization = client
      @apidata = profile.get_userinfo.to_json

      gmail = Google::Apis::GmailV1::GmailService.new
    end
  end

end
