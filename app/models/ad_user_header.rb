class AdUserHeader < ApplicationRecord

  def self.en_headers
    headers = Hash.new
    AdUserHeader.pluck(:name, :name_en).each { |entry| headers.merge!(entry.first => entry.last) }
    headers
  end

  def self.hidden_ad_headers
    [
      "objectclass",
      "cn",
      "description",
      "instancetype",
      "usncreated",
      "memberof",
      "usnchanged",
      "useraccountcontrol",
      "badpwdcount",
      "codepage",
      "countrycode",
      "badpasswordtime",
      "lastlogoff",
      "lastlogon",
      "logonhours",
      "pwdlastset",
      "primarygroupid",
      "admincount",
      "accountexpires",
      "logoncount",
      "samaccounttype",
      "objectcategory",
      "iscriticalsystemobject",
      "dscorepropagationdata",
      "lastlogontimestamp",
      "msds-supportedencryptiontypes",
      "userprincipalname"
    ]
  end

  def self.minimized_header_keys
    min_arr = [
      "whencreated",
      "displayname",
      "mail"
    ]
  end

  def self.minimized_headers
    min_arr = self.minimized_header_keys
    headers = Hash.new
    AdUserHeader.pluck(:name, :name_en).each { |entry| headers.merge!(entry.first => entry.last) if min_arr.include?(entry.first) }
    headers
  end

end


