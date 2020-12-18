class CreateLdapSettings < ActiveRecord::Migration[6.0]
  def change
    create_table :ldap_settings do |t|
      t.references :user
      t.string :host
      t.string :base
      t.string :port
      t.string :login
      t.string :password
      t.timestamps
    end
  end
end
