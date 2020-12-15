class AdUsersController < ApplicationController

  def index
    builder = AdUserServices::TableQueryBuilder.new({
      ad_users: [
        "id",
        "objectguid",
        "objectsid",
        "name",
        "displayname",
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
    @users = AdUser.left_outer_joins(:office).select(builder.selected_data)
    @users = [@users] unless @users.is_a?(ActiveRecord::Relation)
    @headers = builder.localized_hash(:en)
  end

  

end
