class AdUsersController < ApplicationController

  def index
    builder = AdUserServices::TableQueryBuilder.new({
      ad_users: [
        "id",
        "name",
        "displayname",
        "objectguid",
        "samaccountname",
        "mail",
        "dn",
        "whencreated"
      ],
      ad_user_details: [
        "position"
      ],
      offices: [
        "name",
        "name_2"
      ]
    })
    @users = AdUser.joins(:office).select(builder.selected_data).limit(50)
    @users = [@users] unless @users.is_a?(ActiveRecord::Relation)
    @headers = builder.localized_hash(:en)
  end

  def reload
    ldap_sync = LdapServices::LdapSync.new(LdapServices::LdapConn.new)
    ldap_sync.sync
    redirect_to(ad_users_path)
  end

end
