# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

ad_user_header_seed_hash = {
  dn: "Distinguished Name",
  objectclass: "Object Class",
  cn: "Common Name",
  sn: "Last name",
  givenname: "First name",
  displayname: "Display name",
  description: "Description",
  distinguishedname: "Distinguished Name",
  instancetype: "Instance Type",
  whencreated: "When Created",
  whenchanged: "When Changed",
  usncreated: "USN Created",
  memberof: "Groups membership",
  usnchanged: "USN Changed",
  name: "Name",
  objectguid: "GUID",
  useraccountcontrol: "UAC",
  badpwdcount: "Bad password count",
  codepage: "Code Page",
  countrycode: "Country Code",
  badpasswordtime: "Bad password time",
  lastlogoff: "Last Logoff",
  lastlogon: "Last Logon",
  logonhours: "Logon hours",
  pwdlastset: "Password last set",
  primarygroupid: "Primary Group ID",
  objectsid: "SID",
  admincount: "Admin Count",
  accountexpires: "Account Expiration Date",
  logoncount: "Logon Count",
  samaccountname: "Login",
  samaccounttype: "Account type",
  lockouttime: "Lockout time",
  objectcategory: "Object Category",
  iscriticalsystemobject: "",
  dscorepropagationdata: "",
  lastlogontimestamp: "",
  "msds-supportedencryptiontypes" =>  "",
  mail: "Mail",
  userprincipalname: "Principal name"
  }

ad_user_detail_header_seed_hash = {
  position: "Position"
}

office_header_seed_hash = {
  name: "Office Name",
  name_2: "Office Name cont.",
  location: "Location",
  location_2: "Location cont.",
  postalcode: "Postal code",
  phonenumber: "Phone Number",
  phonenumber_2: "Phone Number II",
  fax: "Fax",
  fax_2: "Fax II",
  opt_info: "Additional info",
  opt_info_2: "Additional info cont."
}

def localized_headers(header_hash)
  data = Array.new
  header_hash.each do |tr_k, tr_v|
    data << {name: tr_k, name_en: tr_v}
  end
  data
end

AdUserHeader.destroy_all
AdUserDetailHeader.destroy_all
OfficeHeader.destroy_all

localized_headers(ad_user_header_seed_hash).each { |entry| AdUserHeader.create(entry)}
localized_headers(ad_user_detail_header_seed_hash).each { |entry| AdUserDetailHeader.create(entry)}
localized_headers(office_header_seed_hash).each { |entry| OfficeHeader.create(entry)}

default_template_tag_seed = [
  [name: "itemtag-mail-topic", tag_type: "mail"],
  [name: "itemtag-mail-login", tag_type: "mail"],
  [name: "itemtag-mail-password", tag_type: "mail"]
]

TemplateTag.destroy_all
default_template_tag_seed.each { |entry| TemplateTag.create(entry) }
