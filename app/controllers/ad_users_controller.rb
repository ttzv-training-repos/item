class AdUsersController < ApplicationController

  def index
    @headers = AdUserHeader.en_headers
    @users = AdUser.all.limit(10)
    @users = [@users] unless @users.length > 0
  end

  def reload
    ldap_sync = LdapServices::LdapSync.new(LdapServices::LdapConn.new)
    ldap_sync.sync
    redirect_to(item_ad_users_path)
  end

end
