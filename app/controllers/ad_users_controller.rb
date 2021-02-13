class AdUsersController < ApplicationController
  include AdUsersHelper
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

  def new
    @ad_user = AdUser.new
  end

  def create
    ad_user_hash = ad_user_params
    ad_user_hash.merge!(displayname: "#{ad_user_hash[:givenname]} #{ad_user_hash[:sn]}")

    AdUser.create(ad_user_hash)
    redirect_to ad_users_path
  end

end
