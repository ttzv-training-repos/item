class AdUsersController < ApplicationController

  def index
    @headers = AdUserHeader.en_headers.filter { |k, v| AdUserHeader.default_headers.include?(k) }
    @headers.merge!({position: 'Position', officename: 'Office Name p1', officename_2: "Office Name p2"})
    @users = AdUser.joins(:ad_user_detail, :office).limit(50).select('ad_users.*', 'ad_user_details.position', 'offices.name as officename', 'offices.name_2 as officename_2')
    @users = [@users] unless @users.is_a?(ActiveRecord::Relation)
    @hidden_ad_headers = ["objectguid"]
  end

  def reload
    ldap_sync = LdapServices::LdapSync.new(LdapServices::LdapConn.new)
    ldap_sync.sync
    redirect_to(ad_users_path)
  end

end
