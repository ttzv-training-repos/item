class CreateAdUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :ad_users do |t|
      t.string :dn 
      t.string :objectclass 
      t.string :cn
      t.text :description
      t.string :distinguishedname
      t.string :instancetype
      t.date :whencreated
      t.date :whenchanged
      t.string :usncreated
      t.string :memberof
      t.string :usnchanged
      t.string :name
      t.string :objectguid
      t.string :useraccountcontrol
      t.string :badpwdcount
      t.string :codepage
      t.string :countrycode
      t.date :badpasswordtime
      t.date :lastlogoff
      t.date :lastlogon
      t.string :logonhours
      t.date :pwdlastset
      t.string :primarygroupid
      t.string :objectsid
      t.string :admincount
      t.date :accountexpires
      t.string :logoncount
      t.string :samaccountname
      t.string :samaccounttype
      t.date :lockouttime
      t.string :objectcategory
      t.string :iscriticalsystemobject
      t.string :dscorepropagationdata
      t.date :lastlogontimestamp
      t.string :"msds-supportedencryptiontypes"
      t.timestamps
    end
  end
end
