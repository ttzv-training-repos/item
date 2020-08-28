class SettingsController < ApplicationController
  include SettingsHelper
  def index
    @tags = TemplateTag.where.not(name: "itemtag-mail-topic")
    @attrs = Array.new
    @attrs << ActiveRecord::Base.connection.columns(:ad_users).collect {|c| "ad_users_" + c.name}
    @attrs << ActiveRecord::Base.connection.columns(:ad_user_details).collect {|c| "ad_user_details_" + c.name}
    @attrs << ActiveRecord::Base.connection.columns(:offices).collect {|c| "offices_" + c.name}
    @attrs.flatten!
    @sent_items = SentItem.all
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

end
