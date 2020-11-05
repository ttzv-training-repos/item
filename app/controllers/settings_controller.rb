class SettingsController < ApplicationController
  include SettingsHelper
  def index
    @sent_items = SentItem.all
  end

  def run_autobinder
    AdUserServices::UserOfficeBinder.new.run
  end

  def process_request
    settings_params.each do |entry| 
      tag = TemplateTag.find_by(name: entry.first)
      tag.update(default_value_mask: entry.last) unless entry.last.empty?
    end
  end

end
