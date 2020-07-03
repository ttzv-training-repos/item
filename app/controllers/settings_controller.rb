class SettingsController < ApplicationController

  def run_autobinder
    AdUserServices::UserOfficeBinder.new.run
    
  end

end
