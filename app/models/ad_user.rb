class AdUser < ApplicationRecord
  has_one :ad_user_detail, dependent: :destroy
  has_one :office, :through => :ad_user_detail

  def get_attr(column, table)
    return self[column] if table == "ad_users"
    return self.ad_user_detail[column] if table == "ad_user_details"
    return self.office[column] if table == "offices"
  end

  def self.synchronize_with_ldap(connection)
    existing_users = AdUser.all
    ldap_users = connection.all_users
    ldap_guids_array = []
    db_guids_array = guid_array(existing_users)
    #Update records if ldap data is newer
    ldap_users = ldap_users.each do |user|
      user_hash = LdapServices::LdapUser.tohash(user)
      ldap_guids_array << user_hash[:objectguid]
      db_user = existing_users.find_by(objectguid: user_hash[:objectguid])
      if db_user
        if user_hash[:whenchanged].after?(db_user.whenchanged)
          db_user.update(user_hash) 
          puts "Updated #{user_hash[:objectguid]}, #{user_hash[:whenchanged]}, #{db_user.whenchanged}"
        end
      else
        AdUser.create(user_hash)
        puts "Created #{user_hash[:objectguid]}"
      end
    end
    #Remove elements not present in ldap
    (db_guids_array - ldap_guids_array).each do |guid|
      AdUser.find_by(objectguid: guid).destroy
      puts "Destroyed #{guid}"
    end
  end

  private

  def self.guid_array(collection)
    collection.map do |el|
      el[:objectguid]
    end
  end

end
