class AddColumnDefaultToLdapSetting < ActiveRecord::Migration[6.0]
  def change
    add_column :ldap_settings, :default, :boolean, default: false
  end
end
