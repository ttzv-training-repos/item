module UserHoldersHelper

  def users_from_guids(guids)
    builder = AdUserServices::TableQueryBuilder.new({
      ad_users:[
      "id",
      "displayname",
      "mail",
      "samaccountname",
      "givenname",
      "sn"
      ],
      ad_user_details: [
        "position"
      ],
      offices: [
        "name",
        "name_2"
      ]
    }, explicit: true)
    found_users = AdUser.where(objectguid: guids)
    found_users.joins(:office).select(builder.selected_data)
  end

end
