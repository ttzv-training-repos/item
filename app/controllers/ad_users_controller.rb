class AdUsersController < ApplicationController

  def reload
    ldap_sync = LdapServices::LdapSync.new(LdapServices::LdapConn.new)
    ldap_sync.sync
    redirect_to(item_ad_users_path)
  end

end
